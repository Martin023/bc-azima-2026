page 52186506 "EDMS Files List"
{
    ApplicationArea = All;
    Caption = 'EDMS Files List';
    PageType = List;
    SourceTable = "EDMS Files";
    UsageCategory = Lists;
    CardPageId = "EDMS File Viewer";

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    PromotedActionCategories = 'New,Process,Reports,Creation,Refresh';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Application No."; Rec."Application No.")
                {
                    ToolTip = 'Specifies the value of the Application/CRM Number field.';
                }
                field("EDMS Document Name"; Rec."EDMS Document Name")
                {
                    ToolTip = 'Specifies the value of the EDMS Document Name field.';
                }
                field("EDMS Document ID"; Rec."EDMS Document ID")
                {
                    ToolTip = 'Specifies the value of the EDMS Document ID field.';
                }
                field("EDMS Document Link"; Rec."EDMS Document Link")
                {
                    ToolTip = 'Specifies the value of the EDMS Document Link field.';
                }
                field("EDMS File Type"; Rec."EDMS File Type")
                {
                    ToolTip = 'Specifies the value of the EDMS File Type field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Created At"; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Updated By"; Rec."Updated By")
                {
                    ToolTip = 'Specifies the value of the Updated By field.';
                }
                field("Updated At"; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {

            action("Refresh")
            {
                ApplicationArea = All;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Category5;
                // Visible = Rec."Application No." <> '';

                trigger OnAction()
                var
                    EDMSFunctions: Codeunit "EDMS Functions";
                    TheFilter: Text;
                    ApplicationNos: List of [Text];
                    ApplicationNo: Text;
                begin
                    TheFilter := Rec.GetFilter("Application No.");

                    if TheFilter <> '' then begin
                        ApplicationNos := TheFilter.Split('|');

                        foreach ApplicationNo in ApplicationNos do begin
                            EDMSFunctions.EDMSFileList(ApplicationNo, Rec.GetFilter("EDMS Data Class Name"));
                        end;
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        EDMSFunctions: Codeunit "EDMS Functions";
        TheFilter: Text;
        ApplicationNos: List of [Text];
        ApplicationNo: Text;
    begin
        TheFilter := Rec.GetFilter("Application No.");

        if TheFilter <> '' then begin
            ApplicationNos := TheFilter.Split('|');

            foreach ApplicationNo in ApplicationNos do begin
                if ApplicationNo <> '' then begin
                    EDMSFunctions.EDMSFileList(ApplicationNo, Rec.GetFilter("EDMS Data Class Name"));
                end;
            end;
        end;
    end;
}
