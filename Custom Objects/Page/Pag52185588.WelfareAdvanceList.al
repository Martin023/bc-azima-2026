namespace ALProject.ALProject;

page 52185588 "Welfare Advance List"
{
    CardPageId="Welfare Advance"; 
    Caption = 'Welfare Advance List';
    PageType = List;
    SourceTable = "Welfare Advance";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Applicant Code"; Rec."Applicant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Applicant Code field.';
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Applicant Name field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {

                }
                field("Responsibility Center";Rec."Responsibility Center")
                {

                }
                field(Status;Rec.Status)
                {

                }
            }
        }
    }
}
