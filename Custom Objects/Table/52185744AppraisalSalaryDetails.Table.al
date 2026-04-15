table 52185744 "Appraisal Salary Details"
{
    DrillDownPageID = "Loan Disbursement Lines";
    LookupPageID = "Loan Disbursement Lines";

    fields
    {
        field(1; "Client Code"; Code[20])
        {
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Appraisal Salary Set-up";

            trigger OnValidate()
            var
                AppraisalSet: Record "Appraisal Salary Set-up";
            begin
                AppraisalSet.Reset();
                AppraisalSet.SetRange(Code, Rec.Code);
                if AppraisalSet.FindFirst() then begin
                    Rec.Type := AppraisalSet.Type;
                end;
            end;
        }
        field(3; Description; Text[30])
        {
        }
        field(4; Type; Option)
        {
            OptionCaption = ' ,Earnings,Deductions,Basic,Other Allowances ,Gross Pay,Fosa Income,Pension,House Allowance';
            OptionMembers = " ",Earnings,Deductions,Basic,"Other Allowances","Gross Pay","Net Income",Pension,"House Allowance";
            trigger OnValidate()
            var
                myInt: Integer;
                SalLines: Record "Salary Lines";
                Savingsacc: Record "Savings Accounts";
                LoansRec: Record Loans;
                GlobalFun: Codeunit "Global Functions";
                SlaryIn: Enum "Salary Income Types";
            begin
                Rec.Amount := 0;
                LoansRec.Reset();
                LoansRec.SetRange("Loan No.", Rec."Loan No");
                LoansRec.SetFilter("Source Unit", '<>%1', LoansRec."Source Unit"::BOSA);
                if LoansRec.FindFirst() then begin
                    Savingsacc.Reset();
                    Savingsacc.SetRange("Member No.", Rec."Client Code");
                    Savingsacc.SetRange("Product Category", Savingsacc."Product Category"::"FOSA Account");
                    if Savingsacc.FindFirst() then begin
                        // if Rec.Type = Rec.Type::"Net Income" then begin
                        //     rec.Amount := GlobalFun.GetSmallestSalary(Savingsacc."No.", SlaryIn::Salary);
                        // end;
                        // if Rec.Type = Rec.Type::"SAYE Income" then begin
                        //     Rec.Amount := GlobalFun.GetSmallestSalary(Savingsacc."No.", SlaryIn::SAYE);
                        // end;
                        // if Rec.Type = Rec.Type::Pension then begin
                        //     Rec.Amount := GlobalFun.GetSmallestSalary(Savingsacc."No.", SlaryIn::Pension);
                        // end;
                    end;
                end
            end;
        }
        field(5; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                Rec."Modified By" := '';
                if Type = Type::"Net Income" then begin
                    "Modified By" := UserId;
                    Rec.Modify();
                end;
                // if Type = Type::"SAYE Income" then begin
                //     "Modified By" := UserId;
                //     Rec.Modify();
                // end;
                if Amount < 0 then Error('Amount cannot be less than zero');

                //to initialize the STO Amount if inserted and Display a message
                if (Code = '7.1EXTERNAL BANK STO') and (Amount > 0) then begin
                    ApprDetails.Reset;
                    ApprDetails.SetRange("Loan No", "Loan No");
                    ApprDetails.SetRange(Type, ApprDetails.Type::Basic);
                    ApprDetails.SetFilter(Amount, '>0');
                    if ApprDetails.FindFirst then begin
                        Rec.Amount := 0;
                        Rec.Modify;
                        Message('Standing Order Amount not allowed when there is Basic Salary');
                    end;
                end;
                //end of initializing STO Amount

                if Type = Type::"Gross Pay" then
                    Error(Text002);

                if Type = Type::Basic then begin

                    ApprDetails.Reset;
                    ApprDetails.SetRange(Type, Type::"Gross Pay");
                    ApprDetails.SetRange("Loan No", "Loan No");
                    if ApprDetails.Find('-') then begin
                        ApprDetails.Amount := ApprDetails.Amount + Amount - xRec.Amount;
                        ApprDetails.Modify;
                    end;
                end else

                    if Type = Type::Earnings then begin
                        ApprDetails.Reset;
                        ApprDetails.SetRange(Type, Type::"Gross Pay");
                        ApprDetails.SetRange("Loan No", "Loan No");
                        if ApprDetails.Find('-') then begin
                            ApprDetails.Amount := ApprDetails.Amount + Amount - xRec.Amount;
                            ApprDetails.Modify;
                        end;
                    end else
                        if Type = Type::"Other Allowances" then begin
                            ApprDetails.Reset;
                            ApprDetails.SetRange(Type, Type::"Gross Pay");
                            ApprDetails.SetRange("Loan No", "Loan No");
                            if ApprDetails.Find('-') then begin
                                ApprDetails.Amount := ApprDetails.Amount + Amount - xRec.Amount;
                                ApprDetails.Modify;
                            end;
                        end;
                //initialize the STO Amount if there is a value in Basic
                if (Type = Type::Basic) and (Amount > 0) then begin
                    ApprDetails.Reset;
                    ApprDetails.SetRange("Loan No", "Loan No");
                    ApprDetails.SetRange(Code, '7.1EXTERNAL BANK STO');
                    if ApprDetails.FindFirst then begin
                        STOVal := ApprDetails.Amount;
                        ApprDetails.Amount := 0;
                        ApprDetails.Modify;

                        //IF Type=Type::"Other Allowances" THEN BEGIN
                        ApprDetails.Reset;
                        ApprDetails.SetRange(Type, Type::"Gross Pay");
                        ApprDetails.SetRange("Loan No", "Loan No");
                        if ApprDetails.Find('-') then begin
                            ApprDetails.Amount := ApprDetails.Amount - STOVal;
                            ApprDetails.Modify;
                        end;
                        //END;

                    end;
                end;
                //End of initialize STO Amount if There is Basic Amount
            end;
        }
        field(6; "Loan No"; Code[50])
        {
            TableRelation = Loans;

            trigger OnValidate()
            begin
                if LoanApp.Get("Loan No") then
                    "Client Code" := LoanApp."Member No.";
            end;
        }
        field(7; Verified; Boolean)
        {
            Editable = false;
        }
        field(8; "Modified By"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; Rate; Decimal)
        {
            trigger OnValidate()
            begin
                if Rec.Rate > 0 then begin
                    if rec.Hours = 0 then
                        Error('Please enter hours to calculate amount')
                    else
                        Rec.Amount := round(Rec.Rate * Rec.Hours, 0.01);
                end;
            end;
        }
        field(10; Hours; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Loan No", "Client Code", "Code", Type, Description)
        {
            Clustered = true;
        }
        // key(Key2; "Code", "Client Code", Type,Description)
        // {
        //     SumIndexFields = Amount;
        // }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    var
        Text001: Label 'Loan is already %1 thus cannot modify';
    begin
        if LoanApp.Get("Loan No") then begin
            if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) then
                Error(Text001, LoanApp.Status);
        end;
    end;

    var
        "SalarySet-up": Record "Appraisal Salary Set-up";
        LoanApp: Record Loans;
        Text002: Label 'Do not capture anything here';
        ApprDetails: Record "Appraisal Salary Details";
        STOVal: Decimal;
}

