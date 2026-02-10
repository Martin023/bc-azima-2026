
page 52187374 "Member Card Printing Log"
{
    PageType = List;
    SourceTable = "Member Card Printing Log";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Record ID"; Rec."Record ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Printed At"; Rec."Printed At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Printed By"; Rec."Printed By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }


            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Insert)
            {
                ApplicationArea = All;
            }

            action(Modify)
            {
                ApplicationArea = All;
            }

            action(Delete)
            {
                ApplicationArea = All;
            }
        }
    }
}
