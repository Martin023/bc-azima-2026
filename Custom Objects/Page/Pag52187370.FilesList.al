namespace MNS.MNS;

page 52187370 "Files List"
{
    ApplicationArea = All;
    Caption = 'Files List ';
    PageType = List;
    SourceTable = "Files Table";
    UsageCategory = Lists;
    CardPageId = "Files Card";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field("File Type"; Rec."File Type")
                {
                    ToolTip = 'Specifies the value of the File Type field.';
                    ApplicationArea = All;
                }
                // field("Business Loan Types";Rec."Business Loan Types")
                // {
                //     ToolTip = 'Specifies the value of the Business Loan Type field.';
                // }
                // field("Policy Files Types"; Rec."Policy Files Types")
                // {
                //     ToolTip = 'Specifies the value of the Policy Files Types field.';
                // }
                field("File/Member No."; Rec."File/Member No.")
                {
                    ToolTip = 'Specifies the value of the File/Member No. field.';
                    ApplicationArea = All;
                }
                field("File Name/Descrption"; Rec."File Name/Descrption")
                {
                    ToolTip = 'Specifies the value of the File Name/Descrption field.';
                    ApplicationArea = All;
                }
                field("File Custodian"; Rec."File Custodian")
                {
                    ToolTip = 'Specifies the value of the File Custodian field.';
                    ApplicationArea = All;
                }
                field("File Status"; Rec."File Status")
                {
                    ToolTip = 'Specifies the value of the Stage field.';
                    ApplicationArea = All;
                }
                field("File Volume No."; Rec."File Volume No.")
                {
                    ToolTip = 'Specifies the value of the File Volume No. field.';
                    ApplicationArea = All;
                }
                field("File Batch No."; Rec."File Batch No.")
                {
                    ToolTip = 'Specifies the value of the File Batch No. field.';
                    ApplicationArea = All;
                }
                field("Archived"; Rec.Archived)
                {
                    ToolTip = 'Specifies the value of the Archived field.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Archived"; Rec."Date Archived")
                {
                    ToolTip = 'Specifies the value of the Date Archived field.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Archived By"; Rec."Archived By")
                {
                    ToolTip = 'Specifies the value of the Archived By field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
