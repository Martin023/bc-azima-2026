namespace AZIMA.AZIMA;
using Microsoft.Foundation.Company;

report 52185435 "Guarantor Substitution Report"
{
    ApplicationArea = All;
    Caption = 'Guarantor Substitution Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Guarantor Substitution Report.rdl';
    dataset
    {
        dataitem(GuarantorsSubstitution; "Guarantors Substitution")
        {
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(MemberNo; "Member No.")
            {
            }
            column(Date; "Date")
            {
            }
            column(ApprovalDate; "Approval Date")
            {
            }
            column(MemberStatus; "Member Status")
            {
            }
            column(Status; Status)
            {
            }

            dataitem("Loan Guarantors Sub"; "Loan Guarantors Sub")
            {
                Dataitemlink = "No." = FIELD("No.");
                DataItemTableView = where(substituted = const(true));
                column(Loan_No; "Loan No") { }
                column(Member_Guaranteed; "Member Guaranteed") { }
                column(Substituted; Substituted) { }
                column(Member_Substituted; "Member Substituted") { }
                column(Amount_Guaranteed; "Amount Guaranteed") { }
            }

        }

    }
    requestpage
    {
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
            area(Processing)
            {
            }
        }
    }

    var
        CI: Record "Company Information";
}