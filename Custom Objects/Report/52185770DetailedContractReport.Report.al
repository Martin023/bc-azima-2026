#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185770 "Detailed Contract Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Detailed Contract Report.rdl';

    dataset
    {
        //dataitem(52185942;52185942)
        dataitem(Contracts; "Contracts")
        {
            RequestFilterFields = "Contract No", "Start Date", "End Date";
            column(ReportForNavId_1; 1)
            {
            }
            column(ContractNo_Contracts; Contracts."Contract No")
            {
            }
            column(Name_Contracts; Contracts."Contractor Name")
            {
            }
            column(Party_to_the_Contract; "Party to the Contract") { }
            column(StartDate_Contracts; Contracts."Start Date")
            {
            }
            column(EndDate_Contracts; Contracts."End Date")
            {
            }
            column(ContractValue_Contracts; Contracts."Contract Sum")
            {
            }
            column(Remarks_Contracts; Contracts.Remarks)
            {
            }
            column(SerialNo; SerialNo)
            {
            }
            column(ContractStatus; Contracts."Contract Description")
            {
            }
            column(EDRemarks; Contracts.Remarks)
            {
            }
            column(Contract_Sum; "Contract Sum")
            {

            }
            column(Contract_Period; "Contract Period") { }
            column(Contractor_Type; "Contractor Type") { }

            column(Type_Of_Service; "Type Of Service") { }
            column(Contract_Description; "Contract Description") { }
            column(Termination_Clause; "Termination Clause") { }
            column(Renewal_Clause; "Renewal Clause") { }
            column(Date_of_Request; "Date of Request") { }
            column(Date_of_Excecution; "Date of Excecution") { }
            column(Escalation_For_Leases; "Escalation For Leases") { }
            column(User_Department; "User Department") { }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }

            // column(SCMRemarks;Contracts."Supply Chain Manager Remarks")
            // {
            // }
            //dataitem(52185943;52185943)
            dataitem(Milestones; "Milestones")
            {
                DataItemLink = "Contract No" = field("Contract No");
                column(ReportForNavId_10; 10)
                {
                }
                column(Completed_ContractMilestoneEntry; Milestones."Completed %")
                {
                }
                column(StageDescription_ContractMilestoneEntry; Milestones."Stage Description")
                {
                }
                // column(CommitteeResolution_ContractMilestoneEntry;Milestones."Committee Resolution")
                // {
                // }
                // column(MilestoneDuration_ContractMilestoneEntry;Milestones."Milestone Duration")
                // {
                // }
            }

            trigger OnAfterGetRecord()
            begin
                SerialNo += 1;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        SerialNo: Integer;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
