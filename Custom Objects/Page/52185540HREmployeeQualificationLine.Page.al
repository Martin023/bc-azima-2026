page 52185540 "HR Employee Qualification Line"
{
    Caption = 'Employee Qualification Lines';
    PageType = ListPart;
    SourceTable = "HR Employee Qualifications";
    
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = Basic;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = Basic;
                }
                field("Qualification Description"; Rec."Qualification Description")
                {
                    ApplicationArea = Basic;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = Basic;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Institution/Company"; Rec."Institution/Company")
                {
                    ApplicationArea = Basic;
                }
                field("Course Grade"; Rec."Course Grade")
                {
                    ApplicationArea = Basic;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

   
}

