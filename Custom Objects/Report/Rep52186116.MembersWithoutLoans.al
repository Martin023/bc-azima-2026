report 52186116 "Members Without Loan Report"
{
    ApplicationArea = All;
    Caption = 'Members Without Loan';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/MembersWithoutLoans.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", Status;
            column(No_Members; "No.")
            {
            }
            column(Status_Members; Status)
            {
            }
            column(Name; Name)
            {
            }
            column(Phone_Number; "Phone No.")
            {
            }
            column(Loan_balances; "Loan Balances")
            {
            }

            column(CompPic; CompInfo.Picture)
            {
            }

            trigger OnPreDataItem()
            begin

                Members.SETFILTER("Loan Balances", '= 0')


            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
            }
        }

    }

    trigger OnPreReport()
    begin

        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";


}
