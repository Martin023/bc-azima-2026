namespace MNSProject.MNSProject;

page 52186546 "Other Appraisal Products"
{
    ApplicationArea = All;
    Caption = 'Other Appraisal Products';
    PageType = List;
    SourceTable = "Other Apprails products";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Product ID"; Rec."Product ID")
                {
                    ToolTip = 'Specifies the value of the Product ID field.';
                    Visible = false;
                }
                field("Product code"; Rec."Product code")
                {
                    ToolTip = 'Specifies the value of the Product code field.';
                }
                field("Product Name"; Rec."Product Name")
                {
                    ToolTip = 'Specifies the value of the Product Name field.';
                }
            }
        }
    }
}
