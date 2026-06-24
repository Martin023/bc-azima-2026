page 52185770 "Appraisal Salary Details"
{
    PageType = List;
    SourceTable = "Appraisal Salary Details";
    CardPageID = "Appraisal Salary Details Card.";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                ShowCaption = false;
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleText;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleText;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleText;
                }
                field(Hours; Rec.Hours)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleText;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleText;
                }


                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleText;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = all;
                }
                field(Verified; Rec.Verified)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {

            action("Salary Details Verified")
            {
                ApplicationArea = Basic, Suite;
                Image = ViewCheck;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Verify Salary Details';
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    if rec.Verified = false then begin
                        repeat
                            rec.Verified := true;
                            rec.Modify;
                        until Rec.Next = 0;
                        Loan.Reset;
                        Loan.SetRange("Loan No.", Rec."Loan No");
                        if Loan.Find('-') then begin
                            LoanGuarantorsandSecurity.Reset;
                            LoanGuarantorsandSecurity.SetRange("Loan No", Loan."Loan No.");
                            if LoanGuarantorsandSecurity.Find('-') then begin
                                repeat
                                    if (LoanGuarantorsandSecurity.Verified = true) and (rec.Verified = true) then
                                        Loan."Details Verified By" := UserId;
                                    Loan.Modify;
                                until LoanGuarantorsandSecurity.Next = 0;
                            end;

                        end;
                    end else
                        if rec.Verified = true then begin
                            repeat
                                rec.Verified := false;
                                rec.Modify;
                            until Rec.Next = 0;
                            Loan.Reset;
                            Loan.SetRange("Loan No.", Rec."Loan No");
                            if Loan.Find('-') then begin
                                LoanGuarantorsandSecurity.Reset;
                                LoanGuarantorsandSecurity.SetRange("Loan No", Loan."Loan No.");
                                if LoanGuarantorsandSecurity.Find('-') then begin
                                    repeat
                                        if (LoanGuarantorsandSecurity.Verified = false) and (rec.Verified = false) then
                                            Loan."Details Verified By" := '';
                                        Loan.Modify;
                                    until LoanGuarantorsandSecurity.Next = 0;
                                end;
                            end;

                        end;
                end;

            }

            action("Calculate NetPay")
            {
                ApplicationArea = Basic, Suite;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                // Visible = false;
                trigger OnAction()
                var
                    ApprD: Record "Appraisal Salary Details";
                    Net: Decimal;
                begin
                    if Rec."Loan No" <> '' then begin
                        if LoanApps.Get(Rec."Loan No") then begin
                            if (LoanApps."Source Unit" = LoanApps."Source Unit"::BOSA) then begin
                                ApprD.fnProcessSalaryDetails(rec."Loan No", rec."Client Code");
                                // ApprD.CalculateNetPay();
                            end;
                        end;
                        Message('NetPay calculation completed for all records.');
                    end else
                        Message('Loan No. is required to calculate NetPay.');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // StyleText := '';
        // if rec.Code = '7.1EXTERNAL BANK STO' then /*BEGIN*/
        //     StyleText := 'StrongAccent';
    end;

    trigger OnOpenPage()
    begin
        //**Prevent modification of approved entries
        if Rec."Loan No" <> '' then begin
            LoanApps.Reset;
            LoanApps.SetRange(LoanApps."Loan No.", rec."Loan No");
            if LoanApps.Find('-') then begin
                if LoanApps.Posted = true then begin
                    CurrPage.Editable := false;
                end else
                    CurrPage.Editable := true;
            end;
            // if Rec."Client Code" <> '' then begin
            //     LoanApps.Reset;
            //     LoanApps.SetRange(LoanApps."Loan No.", rec."Loan No");
            //     LoanApps.SetRange(LoanApps."Source Unit", LoanApps."Source Unit"::BOSA);
            //     if LoanApps.FindFirst() then begin
            //         if Rec."Loan No" <> '' then
            //             if LoanApps."Current User" <> UserId then begin
            //                 CurrPage.Editable := false;
            //                 message('User %1 is operating on the card', LoanApps."Current User");
            //             end;
            //     end;
            // end;
        end;
    end;

    local procedure CalculateNetPayForLoan(LoanNo: Code[50]; ClientCode: Code[20]): Decimal
    var
        ApprDetailsLocal: Record "Appraisal Salary Details";
        LoanRec: Record Loans;
        GrossPayAmount: Decimal;
        TotalDeductions: Decimal;
        FacillitativeAmount: Decimal;
        Net: Decimal;
    begin
        GrossPayAmount := 0;
        TotalDeductions := 0;
        FacillitativeAmount := 0;

        // Get Gross Pay
        ApprDetailsLocal.Reset();
        ApprDetailsLocal.SetRange("Loan No", LoanNo);
        ApprDetailsLocal.SetRange("Client Code", ClientCode);
        ApprDetailsLocal.SetRange(Type, ApprDetailsLocal.Type::"Gross Pay");
        if ApprDetailsLocal.FindFirst() then
            GrossPayAmount := ApprDetailsLocal.Amount;

        // Sum all Deductions
        ApprDetailsLocal.Reset();
        ApprDetailsLocal.SetRange("Loan No", LoanNo);
        ApprDetailsLocal.SetRange("Client Code", ClientCode);
        ApprDetailsLocal.SetRange(Type, ApprDetailsLocal.Type::Deductions);
        if ApprDetailsLocal.FindSet() then
            repeat
                TotalDeductions += ApprDetailsLocal.Amount;
            until ApprDetailsLocal.Next() = 0;

        // Sum Facilitative Allowances
        // ApprDetailsLocal.Reset();
        // ApprDetailsLocal.SetRange("Loan No", LoanNo);
        // ApprDetailsLocal.SetRange("Client Code", ClientCode);
        // ApprDetailsLocal.SetRange(Type, ApprDetailsLocal.Type::"Facillitative Allowance");
        // if ApprDetailsLocal.FindSet() then
        //     repeat
        //         FacillitativeAmount += ApprDetailsLocal.Amount;
        //     until ApprDetailsLocal.Next() = 0;

        // Calculate Net based on recovery mode when loan exists
        // if LoanRec.Get(LoanNo) then begin
        //     if LoanRec."Recovery Mode" = LoanRec."Recovery Mode"::Salary then
        //         Net := (GrossPayAmount + FacillitativeAmount) - TotalDeductions
        //     else
        //         Net := GrossPayAmount - TotalDeductions;
        // end else
        Net := GrossPayAmount - TotalDeductions;

        exit(Net);
    end;

    var
        LoanApps: Record Loans;
        StyleText: Text[20];
        Loan: Record Loans;
        AppraisalSalaryDetails: Record "Appraisal Salary Details";
        LoanGuarantorsandSecurity: Record "Loan Guarantors and Security";
}

