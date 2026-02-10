#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185672 "Delegate Loans Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Delegate Loans Register.rdl';

    dataset
    {
        //dataitem(52186063;52186063)
        dataitem("Delegate Members"; "Delegate Members")
        {
            DataItemTableView = where(Type = filter(Normal));
            column(ReportForNavId_1; 1)
            {
            }
            column(CName; CompanyInformation.Name)
            {
            }
            column(CPicture; CompanyInformation.Picture)
            {
            }
            column(CAddress; CompanyInformation.Address)
            {
            }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Member No." = field("Delegate MNO.");
                DataItemTableView = where(Posted = filter(True), "Outstanding Balance" = filter(<> 0), "Member No." = filter(<> ''));
                column(ReportForNavId_2; 2)
                {
                }
                column(LoanNo; Loans."Loan No.")
                {
                }
                column(MemberName; Loans."Member Name")
                {
                }
                column(LoanType; Loans."Loan Product Type Name")
                {
                }
                column(RequestedAmount; Loans."Requested Amount")
                {
                }
                column(ApprovedAmount; Loans."Approved Amount")
                {
                }
                column(MemberNo; Loans."Member No.")
                {
                }
                column(Installment; Loans.Installments)
                {
                }
                column(Interest; Loans.Interest)
                {
                }
                column(OutstandingBal; Loans."Outstanding Balance")
                {
                }
                column(OutstandingInt; Loans."Outstanding Interest")
                {
                }
                column(StaffNo; Loans."Staff No")
                {
                }
                column(DisbursmentDate; Loans."Disbursement Date")
                {
                }
                column(EmployerName; EmployerName)
                {
                }
                column(Dim2; Loans."Global Dimension 2 Code")
                {
                }
                column(CategorySasra; Loans."Loans Category-SASRA")
                {
                }
                column(Regname; Regname)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    Loans.CalcFields("Outstanding Balance");
                    if Loans."Outstanding Balance" <= 0 then
                        CurrReport.Skip;
                    if Customer.Get(Loans."Employer Code") then
                        EmployerName := Customer.Name
                    else
                        EmployerName := '';
                    delmbr.Reset;
                    delmbr.SetRange("Delegate MNO.", Loans."Member No.");
                    if delmbr.Find('-') then begin
                        //delmbr.CalcFields("RegionNames");
                        //Regname := delmbr."RegionNames";
                    end;
                end;
            }
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
        CompanyInformation: Record "Company Information";
        EmployerName: Text;
        Customer: Record Customer;
        delmbr: Record "Delegate Members";
        Regname: Text;
}
