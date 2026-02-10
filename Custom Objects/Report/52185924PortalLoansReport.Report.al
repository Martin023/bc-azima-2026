#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185924 "Portal Loans Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Portal Loans Report.rdl';

    dataset
    {
        //dataitem(OnlineLoansApplications; UnknownTable52186053)
        dataitem(OnlineLoansApplications; "Online Loans Applications")
        {
            DataItemTableView = where(Posted = filter(False));
            column(ReportForNavId_1; 1)
            {
            }
            column(ApplicationDate; OnlineLoansApplications."Application Date")
            {
            }
            column(RequestedAmount; OnlineLoansApplications."Loan Amount")
            {
            }
            column(GhrisPassword; OnlineLoansApplications."Ghris Password")
            {
            }
            column(LoanNo; OnlineLoansApplications."Loan No")
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
            column(Product_Name; OnlineLoansApplications."Loan Type Description")
            {
            }
            column(Product_Type; OnlineLoansApplications."Loan Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Members.Get(OnlineLoansApplications."BOSA No") then begin
                    MemberNo := Members."No.";
                    PersonalNo := Members."Payroll/Staff No.";
                    MobileNo := Members."Phone No.";
                    IDNo := Members."Primary Identification";
                    Names := Members.Name;
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
        Members: Record "Members";
        CompanyInformation: Record "Company Information";
}
