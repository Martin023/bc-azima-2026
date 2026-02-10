page 52185633 "Salary Grades"
{
    DeleteAllowed=false;
    PageType = card;
    SourceTable = "Salary Grades";
    ApplicationArea = Basic, Suite;
   

    layout
    {
        area(content)
        {
            group(General)
            {
                ShowCaption = false;
                field("Salary Grade"; Rec."Salary Grade")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                // field(Allowance; Rec.Allowance)
                // {

                // }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maxmum Amount"; Rec."Maxmum Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employee Group";Rec."Employee Group")
                {
                   ApplicationArea = Basic, Suite; 
                }
                field("Leave Days";Rec."Leave Days")
                {
                    editable=true;

                }
                
              
            }
            part("Salary Grade Lines"; "HR Salary Grade Lines")
            {
                Caption = 'Salary Grade Allowances';
                SubPageLink = "Salary Grade"= FIELD("Salary Grade");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Salary Notches")
            {
                Caption = 'Salary Notches';
                action(Notch)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Notch';
                    Image = NumberGroup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Salary Notches";
                    RunPageLink = "Salary Grade" = FIELD("Salary Grade");
                }
            }
           
    }
    }
    var
    
}

