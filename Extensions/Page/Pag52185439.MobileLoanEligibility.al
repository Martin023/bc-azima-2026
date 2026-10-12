namespace BCAZIMA.BCAZIMA;

page 52185439 "Mobile Loan Eligibility"
{
    PageType = StandardDialog;
    Caption = 'Mobile Loan Eligibility Calculator';
    ApplicationArea = All;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(MemberInfo)
            {
                Caption = 'Member Information';
                Visible = MemberNo <> '';

                field(MemberNoDisplay; MemberNo)
                {
                    Caption = 'Member No.';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Displays the member number for eligibility calculation';
                }

                field(MemberNameDisplay; MemberName)
                {
                    Caption = 'Member Name';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Displays the member name';
                }
            }

            group(LoanSelection)
            {
                Caption = 'Loan Selection';

                field(LoanTypeCode; LoanTypeCode)
                {
                    Caption = 'Select Loan Type';
                    TableRelation = "Product Factory" WHERE("Mobile Loan" = const(true), Status = CONST(Active));
                    ApplicationArea = All;
                    ToolTip = 'Select the mobile loan product to check eligibility';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CalculateEligibility();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ProductFactory: Record "Product Factory";
                    begin
                        ProductFactory.Reset();
                        ProductFactory.SetRange("Mobile Loan", true);
                        ProductFactory.SetRange(Status, ProductFactory.Status::Active);
                        if Page.RunModal(0, ProductFactory) = Action::LookupOK then begin
                            LoanTypeCode := ProductFactory."Product ID";
                            LoanProductName := ProductFactory."Product Description";
                            CalculateEligibility();
                        end;
                    end;
                }

                field(LoanProductName; LoanProductName)
                {
                    Caption = 'Loan Product';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Displays the selected loan product description';
                    Visible = LoanProductName <> '';
                }
            }

            group(EligibilityResults)
            {
                Caption = 'Eligibility Results';
                Visible = ShowResults;

                field(EligibilityStatus; EligibilityStatus)
                {
                    Caption = 'Eligibility Status';
                    Editable = false;
                    ApplicationArea = All;
                    Style = Attention;
                    StyleExpr = EligibilityStatusStyle;
                    ToolTip = 'Shows whether the member is eligible for the selected loan';
                }

                field(QualifiedAmount; QualifiedAmount)
                {
                    Caption = 'Qualified Amount (KES)';
                    Editable = false;
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = QualifiedAmountStyle;
                    ToolTip = 'Maximum loan amount the member qualifies for';
                }

                field(EligibilityReason; EligibilityFailReason)
                {
                    Caption = 'Reason';
                    Editable = false;
                    ApplicationArea = All;
                    MultiLine = true;
                    StyleExpr = EligibilityStatusStyle;
                    ToolTip = 'Shows why the member is eligible or not eligible for this loan product';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Calculate)
            {
                Caption = 'Calculate Eligibility';
                Image = Calculate;
                ApplicationArea = All;
                ToolTip = 'Calculate loan eligibility for the selected product';
                Enabled = LoanTypeCode <> '';
                Promoted = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    CalculateEligibility();
                end;
            }

            action(Refresh)
            {
                Caption = 'Refresh';
                Image = Refresh;
                ApplicationArea = All;
                ToolTip = 'Clear and reset the form';
                Promoted = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ClearFields();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        InitializePage();
    end;

    var
        SkyMobileBanking: Codeunit "Sky Mobile Banking Integration";
        LoanTypeCode: Code[20];
        LoanProductName: Text[100];
        MemberNo: Code[20];
        MemberName: Text[100];
        QualifiedAmount: Decimal;
        EligibilityFailReason: Text;
        EligibilityStatus: Text[50];
        ShowResults: Boolean;
        EligibilityStatusStyle: Text;
        QualifiedAmountStyle: Text;
        MemberNotSetErr: Label 'Member number has not been set. Please close and reopen from the member card.';
        EligibleLbl: Label 'ELIGIBLE';
        NotEligibleLbl: Label 'NOT ELIGIBLE';

    local procedure CalculateEligibility()
    var
        ResponseText: Text;
        ResponseJson: JsonObject;
        PayloadToken: JsonToken;
        PayloadObj: JsonObject;
        StatusToken: JsonToken;
        FieldToken: JsonToken;
        RequestStatus: Text;
        RequestPayload: JsonObject;
        RequestIdValue: JsonValue;
        RequestIdToken: JsonToken;
    begin
        if MemberNo = '' then
            Error(MemberNotSetErr);

        if LoanTypeCode = '' then
            exit;

        ClearResults();
        ShowResults := false;
        EligibilityFailReason := '';
        GetProductDescription();

        RequestPayload.Add('originator_id', Format(CreateGuid()));
        RequestPayload.Add('identifier_type', 'CUSTOMER_NO');
        RequestPayload.Add('identifier', MemberNo);
        RequestPayload.Add('loan_type_id', LoanTypeCode);

        RequestIdValue.SetValue(Format(CreateGuid()));
        RequestIdToken := RequestIdValue.AsToken();

        ResponseText := SkyMobileBanking.CheckLoanLimit(RequestPayload, RequestIdToken);

        if ResponseJson.ReadFrom(ResponseText) then begin
            if ResponseJson.Get('request_status', StatusToken) then
                RequestStatus := StatusToken.AsValue().AsText();

            if ResponseJson.Get('response_payload', PayloadToken) and PayloadToken.IsObject() then begin
                PayloadObj := PayloadToken.AsObject();

                if RequestStatus = 'SUCCESS' then begin
                    if PayloadObj.Get('eligible_amount', FieldToken) then
                        QualifiedAmount := FieldToken.AsValue().AsDecimal();

                    if (LoanProductName = '') and PayloadObj.Get('loan_name', FieldToken) then
                        LoanProductName := CopyStr(FieldToken.AsValue().AsText(), 1, MaxStrLen(LoanProductName));

                    if QualifiedAmount > 0 then begin
                        if PayloadObj.Get('message', FieldToken) and (FieldToken.AsValue().AsText() <> '') then
                            EligibilityFailReason := FieldToken.AsValue().AsText()
                        else if PayloadObj.Get('eligibility_fail_reason', FieldToken) and (FieldToken.AsValue().AsText() <> '') then
                            EligibilityFailReason := FieldToken.AsValue().AsText()
                        else
                            EligibilityFailReason := 'Member qualifies for the selected loan product';
                    end else begin
                        if PayloadObj.Get('eligibility_fail_reason', FieldToken) and (FieldToken.AsValue().AsText() <> '') then
                            EligibilityFailReason := FieldToken.AsValue().AsText()
                        else if PayloadObj.Get('error_message', FieldToken) and (FieldToken.AsValue().AsText() <> '') then
                            EligibilityFailReason := FieldToken.AsValue().AsText()
                        else
                            EligibilityFailReason := 'Member does not qualify for the selected loan product';
                    end;
                end else begin
                    QualifiedAmount := 0;
                    if PayloadObj.Get('error_message', FieldToken) then
                        EligibilityFailReason := FieldToken.AsValue().AsText()
                    else
                        EligibilityFailReason := 'An error occurred while evaluating eligibility.';
                end;
            end;
        end else begin
            QualifiedAmount := 0;
            EligibilityFailReason := 'Failed to process mobile loan eligibility request.';
        end;

        UpdateEligibilityStatus();
        ShowResults := true;
        CurrPage.Update(false);
    end;

    local procedure UpdateEligibilityStatus()
    begin
        if QualifiedAmount > 0 then begin
            EligibilityStatus := EligibleLbl;
            EligibilityStatusStyle := 'Favorable';
            QualifiedAmountStyle := 'Favorable';
        end else begin
            EligibilityStatus := NotEligibleLbl;
            EligibilityStatusStyle := 'Unfavorable';
            QualifiedAmountStyle := 'Unfavorable';
        end;
    end;

    local procedure ClearResults()
    begin
        QualifiedAmount := 0;
        EligibilityFailReason := '';
        EligibilityStatus := '';
    end;

    local procedure ClearFields()
    begin
        LoanTypeCode := '';
        LoanProductName := '';
        ClearResults();
        ShowResults := false;
        CurrPage.Update(false);
    end;

    local procedure InitializePage()
    var
        Members: Record Members;
    begin
        if MemberNo = '' then
            Error(MemberNotSetErr);

        Members.Reset();
        Members.SetRange("No.", MemberNo);
        if Members.FindFirst() then
            MemberName := Members.Name;

        ClearFields();
    end;

    local procedure GetProductDescription()
    var
        ProductFactory: Record "Product Factory";
    begin
        if LoanTypeCode = '' then
            exit;

        ProductFactory.Reset();
        ProductFactory.SetRange("Product ID", LoanTypeCode);
        if ProductFactory.FindFirst() then
            LoanProductName := ProductFactory."Product Description";
    end;

    procedure SetMemberNo(NewMemberNo: Code[20])
    begin
        MemberNo := NewMemberNo;
    end;

    procedure SetSavingsAccount(SavingsAccountMember: Code[20])
    begin
        MemberNo := SavingsAccountMember;
    end;
}