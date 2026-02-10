#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185733 "Agent Tarriffs Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Agent Tarriffs Report.rdl';

    dataset
    {
        dataitem("Agent Tariff Details"; "Agent Tariff Details")
        {
            RequestFilterFields = "Code";
            column(ReportForNavId_1; 1)
            {
            }
            column(Code_AgentTariffDetails; "Agent Tariff Details".Code)
            {
            }
            column(LowerLimit_AgentTariffDetails; "Agent Tariff Details"."Lower Limit")
            {
            }
            column(UpperLimit_AgentTariffDetails; "Agent Tariff Details"."Upper Limit")
            {
            }
            column(ChargeAmount_AgentTariffDetails; "Agent Tariff Details"."Charge Amount")
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyPicture; CompanyInformation.Picture)
            {
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
}
