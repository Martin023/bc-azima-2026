table 52186126 "BBF Requisation Header"
{

    fields
    {
        field(1; No; Code[20])
        {
            Editable = false;
        }
        field(2; Date; Date)
        {
            Editable = false;
        }
        field(3; "Captured By"; Code[30])
        {
            Editable = false;
        }
        field(4; Amount; Decimal)
        {
            CalcFormula = Sum("BBF Requisation Lines"."Total Amount" WHERE("Header No" = FIELD(No),
                                                                            "Member No" = FIELD("Member No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Member No"; Code[20])
        {
            TableRelation = Members."No." WHERE(Status = FILTER(<> Deceased));

            trigger OnValidate()
            var
                ReceiptsHeader: Record "Receipts Header";
                Txt0002: Label 'This member''s claim has not has not been receipted from Insurance';
            begin
                "Date of Death" := 0D;
                "Report Notice No" := '';

                if Members.Get("Member No") then begin
                    "Account Name" := Members.Name;
                end else begin
                    "Account Name" := '';
                end;

                BBFRequisationLines.Reset;
                BBFRequisationLines.SetRange("Header No", No);
                if BBFRequisationLines.Find('-') then
                    BBFRequisationLines.DeleteAll;

                Counts := 0;
                BBFRequisationHeader2.Reset;
                BBFRequisationHeader2.SetRange(BBFRequisationHeader2."Member No", "Member No");
                BBFRequisationHeader2.SetRange(Posted, false);
                if BBFRequisationHeader2.Find('-') then begin
                    repeat
                        if (BBFRequisationHeader.Status = BBFRequisationHeader.Status::Open) or
                           (BBFRequisationHeader.Status = BBFRequisationHeader.Status::Pending) then begin
                            Counts += 1;
                        end;
                    until BBFRequisationHeader.Next = 0;
                end;
                //      1

                //Check if member has picture and Signature
                ImageData.Reset;
                ImageData.SetRange(ImageData."Member No", "Member No");
                if ImageData.Find('-') then begin
                    ImageData.CalcFields(ImageData.Picture, ImageData.Signature);
                    if not ImageData.Picture.HasValue then
                        Message('Kindly capture the member photo before proceeding');
                    if not ImageData.Signature.HasValue then
                        Message('Kindly Signature sample of the member before proceeding');
                end;
            end;
        }
        field(6; "Account Name"; Text[50])
        {
        }
        field(7; "Responsibily Center"; Code[30])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(8; Type; Option)
        {
            OptionCaption = '  ,Spouse,Principal Member,Child-1,Child-2,Child-3,Child-4,Parent-1,Parent-2';
            OptionMembers = "  ",Spouse,"Principal Member","Child-1","Child-2","Child-3","Child-4","Parent-1","Parent-2";
        }
        field(9; "No. Series"; Code[20])
        {
        }
        field(10; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(11; Payed; Boolean)
        {
        }
        field(12; Posted; Boolean)
        {
        }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(15; "Payment Release Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Payment Release Date" > Today then
                    Message(PaymentDateMessage, "Payment Release Date");
            end;
        }
        field(16; "Date of Death"; Date)
        {

            trigger OnValidate()
            begin
                if "Date of Death" > Today then
                    Error('Date cannot be in future');
            end;
        }
        field(17; "Report Notice No"; Code[20])
        {
            // TableRelation = "SinkFund Report Information".No WHERE(Status = CONST(Approved),
            //                                                         "Member No" = FIELD("Member No"),
            //                                                         "Insurance Payment Status" = FILTER("Insurance Paid" | "Pending Payment"));

            trigger OnValidate()
            var
                Txt0002: Label 'This member''s claim has not has not been receipted from Insurance';
                ReceiptsHeader: Record "Receipts Header";
                Txt0003: Label 'You can not complete this process,you receited for the member';
                SinkFundReportInformation: Record "SinkFund Report Information";
                BBFRequisationLines: Record "BBF Requisation Lines";
                SaccoIncome: Decimal;
                BBFEntitlementAmt: Decimal;
                AccountNo: Code[30];
            begin
                SinkFund.Reset;
                SinkFund.SetRange(No, "Report Notice No");
                if SinkFund.Find('-') then begin
                    "Member No" := SinkFund."Member No";
                    "Account Name" := SinkFund."Member Name";
                    "Date of Death" := SinkFund."Date of Death";
                    // "Claim Option" := SinkFund."Claim Option";
                end;

                BBFRequisationLines.Reset;
                BBFRequisationLines.SetRange("Header No", No);
                if BBFRequisationLines.FindFirst then
                    BBFRequisationLines.DeleteAll;

                if SinkFundReportInformation.Get("Report Notice No") then begin
                    Members.Get("Member No");

                    // SinkFundReportInformation.CalculateBBFAmounts("Date of Death", SinkFundReportInformation."Claim Option", SaccoIncome, BBFEntitlementAmt);

                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange("Product Type", '505');
                    SavingsAccounts.SetRange("Member No.", "Member No");
                    if SavingsAccounts.FindFirst then AccountNo := SavingsAccounts."No.";

                    BBFRequisationLines.Init;
                    BBFRequisationLines."Header No" := No;
                    BBFRequisationLines."Member No" := "Member No";
                    BBFRequisationLines."Account No." := AccountNo;
                    BBFRequisationLines.Name := Members.Name;
                    BBFRequisationLines.Relationship := SinkFundReportInformation."Reported By Relationship";
                    BBFRequisationLines.Beneficiary := BBFRequisationLines.Beneficiary;
                    BBFRequisationLines."Date of Birth" := Today;
                    BBFRequisationLines."ID No." := SinkFundReportInformation."Reported By ID No";
                    // BBFRequisationLines."BBF Entitlement Code" := SinkFundReportInformation."Claim Option";
                    BBFRequisationLines."Pay To Name" := SinkFundReportInformation."Reported By Name";
                    BBFRequisationLines."Pay To ID" := SinkFundReportInformation."Reported By ID No";
                    BBFRequisationLines."Pay To Relationship" := SinkFundReportInformation."Reported By Relationship";
                    BBFRequisationLines."BBF Entitlement" := BBFEntitlementAmt;
                    BBFRequisationLines."Sacco Income Recovable" := SaccoIncome;
                    BBFRequisationLines."Total Amount" := BBFEntitlementAmt + SaccoIncome;
                    BBFRequisationLines.Insert;
                end;
            end;
        }
        // field(18; "Claim Option"; Code[20])
        // {
        //     TableRelation = "BBF Entitlement".Code;
        // }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        BBFRequisationHeader2.Reset;
        BBFRequisationHeader2.SetRange(Posted, false);
        BBFRequisationHeader2.SetRange("Captured By", UserId);
        if BBFRequisationHeader2.Find('-') then begin
            if BBFRequisationHeader2.Count > 2 then
                Error('Kindly use the open document first for you to create a new one');
        end;
        if No = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."BBF Claims");
            NoSeriesMgt.InitSeries(SeriesSetup."BBF Claims", xRec."No. Series", 0D, No, "No. Series");
        end;

        if not UserSetup.Get(UserId) then Error('Kindly have System Admin set you in User Set-up');

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Responsibility Centre");
            UserSetup.TestField("Global Dimension 1 Code");
            UserSetup.TestField("Global Dimension 2 Code");
            "Responsibily Center" := UserSetup."Responsibility Centre";
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        end;
        "Captured By" := UserId;
        Date := Today;

        ProductFactory.Reset;
        ProductFactory.SetRange("Product Category", ProductFactory."Product Category"::"Benevolent (BBF)");
        if ProductFactory.Find('-') then begin

            ApplDocs.Reset;
            ApplDocs.SetRange(ApplDocs."Product ID", ProductFactory."Product ID");
            if ApplDocs.Find('-') then begin
                repeat
                    LoanReqDocs.Init;
                    LoanReqDocs."Loan No." := No;
                    LoanReqDocs.Description := ApplDocs.Description;
                    LoanReqDocs."Document No." := ApplDocs."Document No.";
                    LoanReqDocs."Document Type" := ApplDocs."Document Type";
                    LoanReqDocs."Entry No." := LoanReqDocs."Entry No." + 100;
                    LoanReqDocs."Product ID" := ProductFactory."Product ID";
                    LoanReqDocs."Product Name" := ProductFactory."Product Description";
                    LoanReqDocs.Insert;
                until ApplDocs.Next = 0;
            end;
        end;
    end;

    var
        SeriesSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        Members: Record Members;
        Loans: Record Loans;
        BBFRequisationLines: Record "BBF Requisation Lines";
        EntryNo: Integer;
        SavingsAccounts: Record "Savings Accounts";
        BBFEntitlement: Record "BBF Entitlement";
        DimVal: Record "Dimension Value";
        ProductFactory: Record "Product Factory";
        ApplDocs: Record "Product Documents";
        LoanReqDocs: Record "Loan Required Documents";
        BBFRequisationHeader: Record "BBF Requisation Header";
        Err001: Label 'Claim has already been raised';
        Counts: Integer;
        BBFRequisationHeader2: Record "BBF Requisation Header";
        ImageData: Record "Image Data";
        SinkFund: Record "SinkFund Report Information";
        PaymentDateMessage: Label 'Kindly Note that %1 you have entered is a future date';
}

