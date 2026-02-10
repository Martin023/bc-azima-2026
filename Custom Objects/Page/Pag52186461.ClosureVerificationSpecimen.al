namespace ChaMkufuu.ChaMkufuu;

page 52186461 "Closure Verification Specimen"
{
    ApplicationArea = All;
    Caption = 'Closure Verification Specimen';
    PageType = CardPart;
    SourceTable = "General Set-Up";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Closure Verification Specimen"; Rec."Closure Verification Specimen")
                {
                    ToolTip = 'Specifies the value of the Closure Verification Specimen field.';

                }
            }
        }
    }
}
