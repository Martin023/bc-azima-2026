#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185972 "Msacco Loans Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Msacco Loans Report.rdl';

    dataset
    {
        //dataitem(52185761;52185761)
        dataitem("M-SACCO Loans"; "M-SACCO Loans")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(ApplicationDate; "M-SACCO Loans".Date)
            {
            }
            column(RequestedAmount; "M-SACCO Loans"."Requested Amount")
            {
            }
            column(GhrisPassword; "M-SACCO Loans"."Ghris Password")
            {
            }
            column(LoanNo; "M-SACCO Loans"."Loan No")
            {
            }
            column(MobileNo; MobileNo)
            {
            }
            column(Names; Names)
            {
            }
            column(IDNo; IDNo)
            {
            }
            column(PersonalNo; PersonalNo)
            {
            }
            column(MemberNo; MemberNo)
            {
            }
            column(cname; CompanyInformation.Name)
            {
            }
            column(cpicture; CompanyInformation.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if SavingsAccounts.Get("M-SACCO Loans"."Account No") then begin
                    MemberNo := SavingsAccounts."Member No.";
                    PersonalNo := SavingsAccounts."Payroll/Staff No.";
                    MobileNo := SavingsAccounts."Transactional Mobile No";
                    IDNo := SavingsAccounts."ID No.";
                    Names := SavingsAccounts.Name;
                end;
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

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        MobileNo: Code[20];
        Names: Text;
        IDNo: Code[20];
        PersonalNo: Code[20];
        MemberNo: Code[20];
        SavingsAccounts: Record "Savings Accounts";
        CompanyInformation: Record "Company Information";
}
