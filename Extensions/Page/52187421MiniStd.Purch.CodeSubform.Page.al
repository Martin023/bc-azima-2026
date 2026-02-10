#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 52187421 "Mini Std. Purch. Code Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Standard Purchase Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the number of a general ledger account, an item, an additional cost or a fixed asset, depending on the contents of the Type field.';

                    trigger OnValidate()
                    begin
                        if Rec."No." = xRec."No." then
                          exit;

                        if Rec."No." <> '' then
                          Rec.Type := Rec.Type::Item;
                    end;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Contains a description of the entry. The description depends on what you chose in the Type and No. fields. If the Type field is not blank, the program will fill in the field when you enter something in the No. field. You can change the contents of the field.';

                    trigger OnValidate()
                    begin
                        if Rec.Description = xRec.Description then
                          exit;

                        if Rec."No." = '' then
                          Rec.Type := Rec.Type::" ";
                    end;
                }
                field(Quantity;Rec.Quantity)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the number of units of the item on the line. The field can be blank if the quantity will vary. Then you can enter a quantity when you insert the line on a document.';
                }
                field("Unit of Measure Code";Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the unit of measure code to use to determine the unit price. If the line type is Item, the value is automatically copied from the Sales Unit of Measure field on the Item Card.';
                    Visible = false;
                }
                field("Amount Excl. VAT";Rec."Amount Excl. VAT")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Applies only to lines with the type G/L Account or Charge (Item). You cannot enter an amount on lines with types other than G/L Account or Charge (Item).';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension=R;
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Scope = Repeater;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Item;
    end;
}
