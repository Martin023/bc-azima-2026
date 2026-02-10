page 52186743 "Digital Signature"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Digital Signature";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Signature Process"; Rec."Signature Process")
                {

                }
                field("Signature Name"; Rec."Signature Name")
                {

                }
                field("Payroll No."; Rec."Payroll No.")
                {
                    Caption = 'Owner''s Staff Number';
                }
                field("Member No."; Rec."Member No.")
                {
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                }
                field("Has Signature"; Rec."Has Signature")
                {
                    Visible = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {

                }
                field("Entered By"; Rec."Entered By")
                {

                }
                field("Date Last Modified"; Rec."Date Last Modified")
                {

                }
                field("Modified By"; Rec."Modified By")
                {

                }

            }
        }
    }
}
