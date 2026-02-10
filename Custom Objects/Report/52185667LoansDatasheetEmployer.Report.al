#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185667 "Loans Datasheet Employer"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loans Datasheet Employer.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Account Type" = filter(Employer));
            column(ReportForNavId_1; 1)
            {
            }
            column(Cname; CompanyInformation.Name)
            {
            }
            column(CPicture; CompanyInformation.Picture)
            {
            }
            column(CAddress; CompanyInformation.Address)
            {
            }
            column(EmployerCode; Customer."No.")
            {
            }
            column(EmployerName; Customer.Name)
            {
            }
            column(LoanNo; LoanNo)
            {
            }
            column(Period; Period)
            {
            }
            dataitem(loans; Loans)
            {
                DataItemLink = "Employer Code" = field("No.");
                RequestFilterFields = "Disbursement Date";
                column(ReportForNavId_4; 4)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LoanNo += 1;
                end;

                trigger OnPreDataItem()
                begin
                    Period := loans.GetFilter("Disbursement Date");
                end;
            }

            trigger OnAfterGetRecord()
            begin

                LoanNo := 0;
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
        LoanNo: Integer;
        Period: Text;
        CompanyInformation: Record "Company Information";
}
