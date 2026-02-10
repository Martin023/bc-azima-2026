namespace ALProject.ALProject;

page 52186153 "Disposal Lines"
{
    Caption = 'Disposal Lines';
    PageType = ListPart;
    SourceTable = "Disposal Lines";


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No field.';
                }
                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Name field.';
                }
                field("Physical Count"; Rec."Physical Count")
                {
                    Caption = 'Quantity';
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inventory field.';
                }
                field(Expiry; Rec.Expiry)
                {

                }
                field("Item Location"; Rec."Item Location")
                {

                }
                field(Conditon; Rec.Conditon)
                {

                }
                field("Disposal Reason"; Rec."Disposal Reason")
                {

                }
                field("Disposal Method"; Rec."Disposal Method")
                {

                }
                field("Header No"; Rec."Header No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Header No field.';
                    visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                    visible = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Approve)
            {
                ApplicationArea = Basic;
                Caption = 'Clear Lines';
                Image = Approve;

                trigger OnAction()
                var
                begin
                    rec.reset;
                    rec.SetRange("Header No", rec."Header No");
                    if rec.Find('-') then
                        rec.DeleteAll;
                end;
            }

        }
    }

}
