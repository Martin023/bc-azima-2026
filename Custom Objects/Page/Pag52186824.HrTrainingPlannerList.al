page 52186824 "Hr Training Planner List"
{
    CardPageId="Training Planner";
    ApplicationArea = All;
    Caption = 'Hr Training Planner';
    PageType = List;
    SourceTable = "Hr Training Planner";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Training Course"; Rec."Training Course")
                {
                    ToolTip = 'Specifies the value of the Training Course field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("Duration"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(Month; Rec.Month)
                {
                    ToolTip = 'Specifies the value of the Month field.';
                }
                field("No Of Participants"; Rec."No Of Participants")
                {
                    ToolTip = 'Specifies the value of the No Of Participants field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("CPD Points";Rec."CPD Points")
                {
                    
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
    }
}
