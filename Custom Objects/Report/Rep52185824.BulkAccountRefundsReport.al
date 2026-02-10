
report 52185824 "Bulk Account Refunds Report"
{
    ApplicationArea = All;
    Caption = 'Bulk Account Refunds Report';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/BulkAccountRefundReport.rdl';
    UsageCategory = Lists;
    dataset
    {
        dataitem("Refund,Account Transfer Header"; "Refund,Account Transfer Header")
        {
            RequestFilterFields = No, "Posting date";
            column(No; No)
            {
            }
            column(DocumentNo; "Document No")
            {
            }
            column(Description; Description)
            {
            }
            column(Postingdate; "Posting date")
            {
            }
            column(Status; Status)
            {
            }
            column(Posted; Posted)
            {
            }
            column(Filters; Filters)
            {

            }
            column(CompanyInfoName; CompanyInfo.Name)
            {

            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }

            dataitem("Refund,Account Transfer lines"; "Refund,Account Transfer lines")
            {
                DataItemLink = "Refund Header No." = field(No);
                column(SourceAccount_RefundAccountTransferlines; "Source Account")
                {
                }
                column(SourceLoanNo_RefundAccountTransferlines; "Source Loan No.")
                {
                }
                column(SourceLoanTransaction_RefundAccountTransferlines; "Source Loan Transaction.")
                {
                }
                column(DestinationAccount_RefundAccountTransferlines; "Destination Account")
                {
                }
                column(Description_RefundAccountTransferlines; Description)
                {
                }
                column(Amount_RefundAccountTransferlines; Amount)
                {
                }
            }


            trigger OnPreDataItem()
            begin

                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
                Filters := "Refund,Account Transfer Header".GetFilters;
            end;


        }

    }
    var

        CompanyInfo: Record "Company Information";
        Filters: Text;

}
