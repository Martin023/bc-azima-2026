#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186509 "Product Loan Summary Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Product Loan Summary Register.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Global Dimension 1 Code", "Employer Code", "Source Unit", "Member No.", "Loan Product Type", "Disbursement Date";
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(LoansCategorySASRA_Loans; Loans."Loans Category-SASRA")
            {
            }
            column(LoanProductType_Loans; Loans."Loan Product Type")
            {
            }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
            {
            }

            column(RequestedAmount; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(OutBal; Loans."Outstanding Balance")
            {
            }
            column(OutInt; Loans."Outstanding Interest")
            {
            }




            column(EmployerCode; Loans."Employer Code")
            {
            }

            column(ProductType; Loans."Loan Product Type")
            {
            }

            column(Requested_Amount; "Requested Amount")
            {

            }
            column(Global_Dimension_1_Code; Loans."Global Dimension 1 Code")
            { }
            column(Disbursement_Date; "Disbursement Date")
            {

            }

            trigger OnAfterGetRecord()
            begin

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

        actions
        {
        }
    }

    labels
    {
    }



}
