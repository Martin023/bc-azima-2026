report 52187400 "Loan Disbursement Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Loan Disbursement Report';
    RDLCLayout = './bc-azima-2026/Layout/Disbursed Loans.rdl';



    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true));
            column(Loan_No_; "Loan No.")
            {

            }
            column(Approved_Amount; "Approved Amount")
            {
            }
            column(Requested_Amount; "Requested Amount")
            {

            }
            column(Disbursement_Date; "Disbursement Date")
            { }
            column(Installments; Installments)
            { }
            column(Loan_Appraised_By; "Loan Appraised By")
            { }
            column(Approved_By; "Approved By")
            { }
            column(Posted_By; "Posted By")
            {

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

            end;
        }
    }

    requestpage
    {
        SaveValues = true;
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
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInf.get();


    end;

    var
        myInt: Integer;
        CompanyInf: Record "Company Information";
        companyName: Text[100];
        Address: Text[100];

}