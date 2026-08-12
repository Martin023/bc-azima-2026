namespace AZIMA.AZIMA;

report 52185576 "Generate Saving Advice"
{
    ApplicationArea = All;
    Caption = 'Generate Saving Advice';
    UsageCategory = Tasks;
    processingonly = true;
    dataset
    {
        dataitem(CheckoffAdviceHeader; "Checkoff Advice Header")
        {
            column(No; "No.")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            dataitem("Savings Accounts"; "Savings Accounts")
            {
                RequestFilterFields = "Product Type", "Member No.", "Employer Code";
                trigger OnpreDataItem()
                begin
                    if CheckoffAdviceHeader."Employer Code" <> '' then
                        "Savings Accounts".SetRange("Employer Code", CheckoffAdviceHeader."Employer Code");
                end;

                trigger OnAfterGetRecord()
                begin
                    if Memb.Get("Savings Accounts"."Member No.") then begin
                        if (Memb.status <> Memb.Status::Deceased) and (Memb.Status <> Memb.Status::Withdrawn) then begin
                            if ProdFac.get("Savings Accounts"."Product Type") then begin
                                //Deposit Contr
                                iEntryNo := 0;
                                CheckoffAdvice.Reset;
                                if CheckoffAdvice.Find('+') then
                                    iEntryNo := CheckoffAdvice."Entry No" + 1;

                                CheckoffAdvice.Init;
                                CheckoffAdvice."Entry No" := iEntryNo;
                                CheckoffAdvice."Advice Header No." := CheckoffAdviceHeader."No.";
                                CheckoffAdvice.Type := CheckoffAdvice.Type::Savings;
                                CheckoffAdvice."Account No." := "Savings Accounts"."No.";
                                CheckoffAdvice."Member No." := "Savings Accounts"."Member No.";
                                CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                CheckoffAdvice.Reference := 'MONTHLYDED-' + format(CheckoffAdvice."Product Type");
                                CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"Monthly Deduction";
                                CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Everything;
                                CheckoffAdvice."Amount On" := ProdFac."Minimum Contribution";
                                if "Savings Accounts"."Monthly Contribution" > CheckoffAdvice."Amount On" then
                                    CheckoffAdvice."Amount On" := "Savings Accounts"."Monthly Contribution";
                                CheckoffAdvice."Advice Date" := Today;
                                CheckoffAdvice."Employer Code" := "Savings Accounts"."Employer Code";
                                CheckoffAdvice.Names := "Savings Accounts".Name;
                                CheckoffAdvice."ID No." := "Savings Accounts"."ID No.";
                                CheckoffAdvice."Product Type" := "Savings Accounts"."Product Type";
                                CheckoffAdvice.Validate("Product Type");
                                CheckoffAdvice."Payroll No" := "Savings Accounts"."Payroll/Staff No.";
                                if CheckoffAdvice."Amount On" <> 0 then
                                    CheckoffAdvice.Insert;
                            end;
                        end;
                    end;
                end;

            }
            trigger OnAfterGetRecord()
            begin

                CheckoffAdvice.Reset;
                CheckoffAdvice.SetRange(CheckoffAdvice."Advice Header No.", CheckoffAdviceHeader."No.");
                CheckoffAdvice.SetRange(CheckoffAdvice.Type, CheckoffAdvice.Type::Savings);
                if CheckoffAdvice.Find('-') then begin
                    CheckoffAdvice.DeleteAll;
                end;
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    // trigger OnPreReport()
    // begin
    //     Message('Kindly ensure all loans have principal and interest repayments have figures to generate.');
    // end;
    trigger OnpostReport()
    begin
        Message('CHeckoff Advice has been generated successfully. Kindly check the Checkoff Advice Lines for details.');
    end;

    var
        CheckoffAdvice: record "Checkoff Advice Line";
        Memb: record members;
        ProdFac: record "Product Factory";
        iEntryNo: Integer;
}
