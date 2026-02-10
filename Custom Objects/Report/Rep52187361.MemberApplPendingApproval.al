report 52187361 "Member Appl. Pending Approval"
{
    ApplicationArea = All;
    Caption = 'Member Appl. Pending Approval';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Member Appl. Pending Approval.rdl';
    dataset
    {
        dataitem(MemberApplication; "Member Application")
        {
            RequestFilterFields = "No.", Status;
            DataitemTableView = where(Status = Const(Pending));
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(CreatedBy; "Created By")
            {
            }
            column(ApproverID; ApproverID)
            {
            }
            column(PayrollStaffNo; "Payroll/Staff No.")
            {
            }
            column(PrimaryIdentificationType; "Primary Identification Type")
            {
            }
            column(PrimaryIdentification; "Primary Identification")
            {
            }
            column(TypeofApplication; "Type of Application")
            {
            }
            column(CRMApplicationNo; "CRM Application No.")
            {
            }
            column(AtCCC; "At CCC")
            {
            }
            column(AccountType; "Account Type")
            {
            }
            column(AllocatedOfficer; "Allocated Officer")
            {
            }
            column(AllocatedOfficerName; "Allocated Officer Name")
            {
            }
            column(ApplicationDate; "Application Date")
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(Status; Status)
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
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                ApprovalEntry.RESET;
                //ApprovalEntry.SetRange();
                ApprovalEntry.SetRange("Table ID", 52185691);
                ApprovalEntry.SetRange("Document No.", MemberApplication."No.");
                ApprovalEntry.SetRange("Status", MemberApplication.Status);
                if ApprovalEntry.FINDSET then begin
                    ApproverID := ApprovalEntry."Approver ID";
                end;
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
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }

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
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        EmployerName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        ApprovalEntry: Record "Approval Entry";
        MemberApp: Record "Member Application";
        ApproverID: Code[700];
}
