namespace MNS.MNS;

report 52186168 "Create Member Files"
{
    ApplicationArea = All;
    Caption = 'Create Member Files';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Members; Members)
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                FilesTable.Reset();
                FilesTable.SetRange("File/Member No.", Members."No.");
                if not FilesTable.Find('-') then begin
                    FilesTable.INIT;
                    FilesTable."Entry No." := FilesTable."Entry No.";
                    FilesTable."File Type" := FilesTable."File Type"::"Member File";
                    FilesTable."File/Member No." := Members."No.";
                    FilesTable."File Name/Descrption" := Members.Name;
                    FilesTable."Staff PF No." := Members."Payroll/Staff No.";
                    FilesTable."Member Status" := Members.Status;
                    FilesTable."File Custodian" := 'RECORDS';
                    FilesTable."File Status" := FilesTable."File Status"::"In Store";
                end;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
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
        FilesTable: Record "Files Table";
}
