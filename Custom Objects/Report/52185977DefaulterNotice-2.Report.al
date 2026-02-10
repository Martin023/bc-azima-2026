#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185977 "Defaulter Notice-2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Defaulter Notice-2.rdl';

    dataset
    {
        //dataitem(52185700;52185700)
        dataitem(Members; "Members")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(PhoneNo_Members; Members."Phone No.")
            {
            }
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(CompName; CompName)
            {
            }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Member No." = field("No.");
                RequestFilterFields = "Loan No.";
                column(ReportForNavId_2; 2)
                {
                }
                column(OutstandingBalance_Loans; Loans."Outstanding Balance")
                {
                }
                column(LoanNo_Loans; Loans."Loan No.")
                {
                }
                column(ApplicationDate_Loans; Loans."Application Date")
                {
                }
                column(LoanProductType_Loans; Loans."Loan Product Type")
                {
                }
                column(MemberNo_Loans; Loans."Member No.")
                {
                }
                column(RequestedAmount_Loans; Loans."Requested Amount")
                {
                }
                column(ApprovedAmount_Loans; Loans."Approved Amount")
                {
                }
                column(Interest_Loans; Loans.Interest)
                {
                }
                column(MemberName_Loans; Loans."Member Name")
                {
                }
                column(OutstandingInterest_Loans; Loans."Outstanding Interest")
                {
                }
                column(OutstandingBills_Loans; Loans."Outstanding Bills")
                {
                }
                column(Installments_Loans; Loans.Installments)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CompName := COMPANYNAME;
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
        CompName: Text[100];
}
