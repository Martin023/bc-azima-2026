report 52186870 UpdateSavings
{
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;


    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            RequestFilterFields = "No.", Status;
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                if Members.Get("Savings Accounts"."Member No.") then begin
                    "Savings Accounts"."ID No." := Members."Primary Identification";
                    "Savings Accounts"."Payroll/Staff No." := Members."Payroll/Staff No.";
                    "Savings Accounts"."Employer Code" := Members."Employer Code";
                    "Savings Accounts"."Phone No." := Members."Phone No.";
                    "Savings Accounts"."Mobile Phone No" := members."Phone No.";
                    //"Savings Accounts"."Global Dimension 1 Code" := Members."Global Dimension 1 Code";
                    "Savings Accounts".Modify();
                end;
            end;

        }

    }
    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        Message('Update Done');
    end;




    var
        myInt: Integer;
        Members: Record Members;
}