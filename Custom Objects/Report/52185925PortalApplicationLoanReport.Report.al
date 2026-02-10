#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185925 "Portal Application Loan Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Portal Application Loan Report.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Loan Product Type" = filter(112 | 113 | 111), "Dummy Appraisal" = filter(False), "Sent Online" = filter(True));
            RequestFilterFields = "Loan No.", "Member No.", Posted, Status;
            column(ReportForNavId_1; 1)
            {
            }
            column(Member_No; Loans."Member No.")
            {
            }
            column(GhrisPassword; GhrisPassword)
            {
            }
            column(Loan_No; Loans."Loan No.")
            {
            }
            column(Application_Date; Loans."Application Date")
            {
            }
            column(Requested_Amount; Loans."Requested Amount")
            {
            }
            column(Branch; Branch)
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Company_picture; CompanyInfo.Picture)
            {
            }
            column(Rejection_Reason; Loans."Loan Rejection Reason")
            {
            }
            column(Status; Loans.Status)
            {
            }
            //dataitem(52185700;52185700)
            dataitem(Members; "Members")
            {
                DataItemLink = "No." = field("Member No.");
                column(ReportForNavId_6; 6)
                {
                }
                column(ID_No; Members."Primary Identification")
                {
                }
                column(Mobile_No; Members."Phone No.")
                {
                }
                column(Member_Name; Members.Name)
                {
                }
                column(Staff_No; Members."Payroll/Staff No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                GhrisPassword := '';
                Branch := '';

                OnlineLoansApplications.Reset;
                OnlineLoansApplications.SetRange("Loan No", "Loan No.");
                if OnlineLoansApplications.FindFirst then begin
                    GhrisPassword := OnlineLoansApplications."Ghris Password";
                    Branch := OnlineLoansApplications."Branch Code";
                end;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
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
        GhrisPassword: Text;
        Branch: Code[20];
        OnlineLoansApplications: Record "Online Loans Applications";
        CompanyInfo: Record "Company Information";
}
