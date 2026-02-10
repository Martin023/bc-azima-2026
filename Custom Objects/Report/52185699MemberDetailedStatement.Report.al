#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185699 "Member Detailed Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Member Detailed Statement.rdl';

    UsageCategory = ReportsAndAnalysis;

    Caption = 'Member Detailed Statement';

    dataset
    {
        //dataitem(52185700;52185700)
        dataitem(Members; "Members")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(Name; Members.Name)
            {
            }
            column(No; Members."No.")
            {
            }
            column(Payroll; Members."Payroll/Staff No.")
            {
            }
            column(ID; Members."Primary Identification")
            {
            }
            column(Email; Members."E-Mail")
            {
            }
            column(Picture; Company.Picture)
            {
            }
            column(Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            dataitem("Share Capital"; "Savings Accounts")
            {
                DataItemLink = "Member No." = field("No.");
                DataItemTableView = where("Product Category" = filter("Share Capital" | "Transfered Share Capital"));


                column(ShareNo; "Share Capital"."No.")
                {
                }
                column(ShareBalance; "Share Capital"."Balance (LCY)")
                {
                }
                column(ShareName; "Share Capital"."Product Name")
                {
                }
                //share capital transfer



            }
            dataitem("Deposit Contribution"; "Savings Accounts")
            {
                DataItemLink = "Member No." = field("No.");
                DataItemTableView = where("Product Category" = filter("BOSA Deposits"));
                column(ReportForNavId_18; 18)
                {
                }
                column(DepNo; "Deposit Contribution"."No.")
                {
                }
                column(DepName; "Deposit Contribution"."Product Name")
                {
                }
                column(DepBal; "Deposit Contribution"."Balance (LCY)")
                {
                }
            }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Member No." = field("No.");
                DataItemTableView = where(Posted = filter(True), "Outstanding Balance" = filter(> 0));
                column(ReportForNavId_7; 7)
                {
                }
                column(LNo; Loans."Member No.")
                {
                }
                column(ApprovedAmt; Loans."Approved Amount")
                {
                }
                column(OutstandingBal; Loans."Outstanding Balance")
                {
                }
                column(OutstandingInt; Loans."Outstanding Interest")
                {
                }
                column(OutstandingBill; loans."Amount In Arreas SASRA")
                {
                }
                column(Repayment; Loans.Repayment)
                {
                }
                column(LoanType; Loans."Loan Product Type Name")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Loans.CalcFields(Loans."Outstanding Bills");
                    if Loans."Outstanding Bills" > 0 then
                        Defaulted := true
                    else
                        Defaulted := false;
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
        if Company.Get() then
            Company.CalcFields(Company.Picture);
    end;

    var
        Defaulted: Boolean;
        Company: Record "Company Information";
        GlobalFunc: Codeunit "Global Functions";
}
