#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185734 "Agent Applications Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Agent Applications Report.rdl';

    dataset
    {
        dataitem("Agent Applications"; "Agent Applications")
        {
            RequestFilterFields = "Approval Status";

            column(AgentCode_AgentApplications; "Agent Applications"."Agent Code")
            {
            }
            column(DateEntered_AgentApplications; "Agent Applications"."Date Entered")
            {
            }
            column(CustomerIDNo_AgentApplications; "Agent Applications"."Customer ID No")
            {
            }
            column(Name_AgentApplications; "Agent Applications".Name)
            {
            }
            column(MobileNo_AgentApplications; "Agent Applications"."Mobile No")
            {
            }
            column(ApprovalStatus_AgentApplications; "Agent Applications"."Approval Status")
            {
            }
            column(Account_AgentApplications; "Agent Applications".Account)
            {
            }
            column(NameoftheProposedAgent_AgentApplications; "Agent Applications"."Name of the Proposed Agent")
            {
            }
            column(TypeofBusiness_AgentApplications; "Agent Applications"."Type of Business")
            {
            }
            column(PlaceofBusiness_AgentApplications; "Agent Applications"."Place of Business")
            {
            }
            column(PINKRA_AgentApplications; "Agent Applications"."PIN(KRA)")
            {
            }
            column(CommAccount_AgentApplications; "Agent Applications"."Comm Account")
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyPicture; CompanyInformation.Picture)
            {
            }
            column(MemberNo; MemberNo)
            {
            }
            column(StaffNo; StaffNo)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if SavingsAccounts.Get("Agent Applications".Account) then begin
                    MemberNo := SavingsAccounts."Member No.";
                    StaffNo := SavingsAccounts."Payroll/Staff No.";
                end;
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
        CompanyInformation: Record "Company Information";
        MemberNo: Code[20];
        StaffNo: Code[20];
        SavingsAccounts: Record "Savings Accounts";
}
