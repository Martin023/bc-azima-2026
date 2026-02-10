page 52186352 "Movement Tracker List"
{
    PageType = List;
    SourceTable = "Movement Tracker";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approval Type"; Rec."Approval Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Current Location"; Rec."Current Location")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date/Time In"; Rec."Date/Time In")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date/Time Out"; Rec."Date/Time Out")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("USER ID"; Rec."USER ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Station; Rec.Station)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

