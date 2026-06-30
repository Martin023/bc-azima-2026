page 52185602 "HR Perspective Setup List"
{
    PageType = List;
    SourceTable = "HR Perspectives Setup";
    ApplicationArea = Basic, Suite;
    UsageCategory = Administration;
    Caption = 'HR Perspectives Setup List';
    CardPageID = "HR Perspective Setup Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Perspective type"; Rec."Perspective type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Perspective No"; Rec."Perspective No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false; 
                }
            }
        }
    }
}