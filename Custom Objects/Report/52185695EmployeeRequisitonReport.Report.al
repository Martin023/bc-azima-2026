#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185695 "Employee Requisiton Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Employee Requisiton Report.rdl';

    dataset
    {
        dataitem("HR Employee Requisitions"; "HR Employee Requisitions")
        {
            RequestFilterFields = "Approval Status";
            column(ReportForNavId_1; 1)
            {
            }
            column(JobID_HREmployeeRequisitions; "HR Employee Requisitions"."Job ID")
            {
            }
            column(RequisitionDate_HREmployeeRequisitions; "HR Employee Requisitions"."Requisition Date")
            {
            }
            column(Positions_HREmployeeRequisitions; "HR Employee Requisitions".Positions)
            {
            }
            column(DateApproved_HREmployeeRequisitions; "HR Employee Requisitions"."Date Approved")
            {
            }
            column(JobDescription_HREmployeeRequisitions; "HR Employee Requisitions"."Job Description")
            {
            }
            column(ApprovalStatus_HREmployeeRequisitions; "HR Employee Requisitions"."Approval Status")
            {
            }
            column(RequiredPositions_HREmployeeRequisitions; "HR Employee Requisitions"."Required Positions")
            {
            }
            column(VacantPositions_HREmployeeRequisitions; "HR Employee Requisitions"."Vacant Positions")
            {
            }
            column(Advertised_HREmployeeRequisitions; "HR Employee Requisitions".Advertised)
            {
            }
            column(Requestor; "HR Employee Requisitions".Requestor)
            {
            }
            column(Reason_For_Request; "HR Employee Requisitions"."Reason For Request")
            {

            }
            column(Employment_Type; "HR Employee Requisitions"."Employment Type")
            {

            }
            column(CompletionStatus_HREmployeeRequisitions; "HR Employee Requisitions"."Completion Status")
            {
            }
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
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
