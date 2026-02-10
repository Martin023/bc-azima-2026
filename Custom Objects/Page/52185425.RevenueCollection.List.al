namespace Mwanga.Mwanga;

page 52185425 "Revenue Collection List"
{
    ApplicationArea = All;
    Caption = 'Revenue Collection';
    PageType = List;
    SourceTable = "Revenue Collection";
    CardPageId = "Revenue Collection Card";
    DeleteAllowed = false;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Created At"; Rec."Created At")
                {
                    ToolTip = 'Specifies the value of the Created At field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Approved At"; Rec."Approved At")
                {
                    ToolTip = 'Specifies the value of the Approved At field.', Comment = '%';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ToolTip = 'Specifies the value of the Approved By field.', Comment = '%';
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ToolTip = 'Specifies the value of the Employer Code field.', Comment = '%';
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ToolTip = 'Specifies the value of the Employer Name field.', Comment = '%';
                }
                field("Posting Period"; Rec."Posting Period")
                {
                    ToolTip = 'Specifies the value of the Period field.', Comment = '%';
                }
                field("Amount Collected"; Rec."Amount Collected")
                {
                    ToolTip = 'Specifies the value of the Amount Collected field.', Comment = '%';
                }
            }
        }
    }
}
