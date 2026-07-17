#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185852 "Staff On Leave"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Staff On Leave.rdl';

    dataset
    {
        dataitem("HR Leave Application"; "HR Leave Application")
        {
            DataItemTableView = where(Posted = filter(true));
            column(ReportForNavId_1; 1)
            {
            }
            column(Names_HRLeaveApplication; "HR Leave Application".Names)
            {
            }
            column(GlobalDimension1Code_HRLeaveApplication; "HR Leave Application"."Global Dimension 1 Code")
            {
            }
            column(EndDate_HRLeaveApplication; "HR Leave Application"."End Date")
            {
            }
            column(LeaveType_HRLeaveApplication; "HR Leave Application"."Leave Type")
            {
            }
            column(DaysApplied_HRLeaveApplication; "HR Leave Application"."Days Applied")
            {
            }
            column(StartDate_HRLeaveApplication; "HR Leave Application"."Start Date")
            {
            }
            column(ReturnDate_HRLeaveApplication; "HR Leave Application"."Return Date")
            {
            }
            column(ApplicationCode_HRLeaveApplication; "HR Leave Application"."Application Code")
            {
            }
            
            // Expanded Company Information
            column(CName; Company.Name) { }
            column(CAdress; Company.Address) { }
            column(CPicture; Company.Picture) { }
            column(CPhone; Company."Phone No." + ' ' + Company."Phone No. 2") { }
            column(CEmail; Company."E-Mail") { }
            column(CCity; Company.City) { }
            column(CPostCode; Company."Post Code") { }
            
            column(LeaveType; LeaveType)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Today < "HR Leave Application"."Start Date" then CurrReport.Skip;

                if Today > "HR Leave Application"."End Date" then CurrReport.Skip;

                if HRLeaveTypes.Get("HR Leave Application"."Leave Type") then
                    LeaveType := HRLeaveTypes.Description
                else
                    LeaveType := "HR Leave Application"."Leave Type";
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout { }
        actions { }
    }

    trigger OnInitReport()
    begin
        if Company.Get() then
            Company.CalcFields(Picture);
    end;

    var
        Company: Record "Company Information";
        HRLeaveTypes: Record "HR Leave Types";
        LeaveType: Text[50];
}