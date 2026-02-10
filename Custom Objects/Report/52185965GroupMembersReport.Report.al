#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185965 "Group Members Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Group Members Report.rdl';

    dataset
    {
        dataitem("Account Signatories"; "Account Signatories")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(Group_No; "Account Signatories"."Account No")
            {
            }
            column(Account_Type; "Account Signatories"."Account Type")
            {
            }
            column(Member_No; "Account Signatories"."Member No.")
            {
            }
            column(DOB; "Account Signatories"."Date Of Birth")
            {
            }
            column(Staff_No; "Account Signatories"."Staff/Payroll")
            {
            }
            column(ID; "Account Signatories"."ID Number")
            {
            }
            column(IsSignatory; "Account Signatories".Signatory)
            {
            }
            column(Must_Sign; "Account Signatories"."Must Sign")
            {
            }
            column(MustBePresent; "Account Signatories"."Must be Present")
            {
            }
            column(Designation; "Account Signatories".Designation)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(GroupName; GroupName)
            {
            }
            column(Member_Name; "Account Signatories".Names)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Members.Get("Account Signatories"."Account No") then
                    GroupName := Members.Name;
            end;

            trigger OnPreDataItem()
            begin
                /*IF "Account Signatories".GETFILTER("Account No") THEN
                IF Members.GET("Account Signatories"."Account No") THEN*/
                Company.Get;
                Company.CalcFields(Picture);

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        GroupName: Text;
        Members: Record "Members";
        Company: Record "Company Information";
}
