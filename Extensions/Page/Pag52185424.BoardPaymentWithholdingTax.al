namespace MNS.MNS;

page 52185424 "Deleg. Payment Withholding Tax"
{
    ApplicationArea = All;
    Caption = 'Delegate Payment Withholding Tax';
    PageType = List;
    SourceTable = "Deleg. Payment Withholding Tax";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Payment No"; Rec."Payment No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment No field.', Comment = '%';
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No field.', Comment = '%';
                    
                }
                field("Delegate KRA PIN"; Rec."Delegate KRA PIN")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Delegate KRA PIN".', Comment = '%';
                }
                field("Total Payment"; Rec."Total Payment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Payment field.', Comment = '%';
                }
                field("Withholding Tax Amount"; Rec."Withholding Tax Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Withholding Tax Amount field.', Comment = '%';
                }
                field("Date paid"; Rec."Date paid")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date paid field.', Comment = '%';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                }
            }
        }
    }
}
