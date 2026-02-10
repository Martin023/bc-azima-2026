namespace MNS.MNS;

page 52186612 "Monthly Contrib Logs"
{
    ApplicationArea = All;
    Caption = 'Monthly Contrib Logs';
    PageType = List;
    SourceTable = "Monthly Contrib Logs";
    UsageCategory = Lists;
    // Editable = false;
    // InsertAllowed = false;
    //DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                // field(No; Rec.No)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the No field.', Comment = '%';
                // }
                field("Product ID"; Rec."Product ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product ID. field.', Comment = '%';
                }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Effective Date field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }
                field("Currently Active"; Rec."Currently Active")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currently Active field.', Comment = '%';
                }
                field("Effected By"; Rec."Effected By")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Effected By field.', Comment = '%';
                }
            }
        }
    }
}
