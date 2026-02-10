report 52185649 "Edits Applications"
{
    ApplicationArea = All;
    Caption = 'Edits Applications';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Edits Applications.rdl';

    dataset
    {
        dataitem(EditsHelper; "Edits Helper")
        {
            RequestFilterFields = "Record No.";
            column(EditsHeaderNo; "Edits Header No.")
            {
            }
            column(RecordNo; "Record No.")
            {
            }
            column(Posted; Posted)
            {
            }
            column(WorkflowStatus; "Workflow Status")
            {
            }
            column(CRMNo; CRMNo)
            {
            }
            column(EditStatus; EditStatus)
            {
            }
            column(OfficerAllocated; OfficerAllocated)
            {
            }
            column(DateReceived; DateReceived)
            {
            }
            column(DateWorkedOn; DateWorkedOn)
            {
            }
            column(MemberName; MemberName)
            {
            }
            column(TSCPFNo; TSCPFNo)
            {
            }
            column(IDNo; IDNo)
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
            dataitem(SystemEditsFields; "System Edits Fields")
            {
                DataItemTableView = where("Generally Edited" = CONST(true));
                DataItemLinkReference = EditsHelper;
                DataItemLink = "Record ID" = FIELD("Edits Header No.");
                column(Record_ID; "Record ID")
                {
                }
                column(Field_ID; "Field ID")
                {
                }
                column(Field_Name; "Field Name")
                {
                }
                column(Field_Type; "Field Type")
                {
                }
                column(Old_Value; "Old Value")
                {
                }
                column(New_Value; "New Value")
                {
                }
                column(Generally_Edited; "Generally Edited")
                {
                }
                column(Inserted; Inserted)
                {
                }
                column(Deleted; Deleted)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    CRMNo := '';
                    MemberName := '';
                    TSCPFNo := '';
                    IDNo := '';

                    SystemEditsTable.Reset;
                    SystemEditsTable.SetRange("No.", "Record ID");
                    if SystemEditsTable.Find('-') then begin
                        repeat
                            CRMNo := SystemEditsTable."CRM No";
                            EditStatus := SystemEditsTable."Status";
                            OfficerAllocated := SystemEditsTable."Responsible Officer";
                            DateReceived := SystemEditsTable."Application Date";
                            DateWorkedOn := SystemEditsTable."Posting Date";

                            Members.Reset;
                            Members.SetRange("No.", EditsHelper."Record No.");
                            if Members.Find('-') then begin
                                MemberName := Members.Name;
                                TSCPFNo := Members."Payroll/Staff No.";
                                IDNo := Members."Primary Identification";
                            end;
                        until SystemEditsTable.Next = 0;
                    end;
                end;
            }
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
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CompanyInformation: Record "Company Information";
        SystemEditsTable: Record "System Edits";
        CRMNo: Code[20];
        DateWorkedOn: DateTime;
        DateReceived: DateTime;
        OfficerAllocated: Code[20];
        EditStatus: Enum "Workflow Status Main Flags";
        Members: Record Members;
        MemberName: Text[100];
        TSCPFNo: Code[20];
        IDNo: Code[20];


}
