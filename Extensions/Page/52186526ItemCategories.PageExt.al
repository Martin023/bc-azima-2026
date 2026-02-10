#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186526 pageextension52186526 extends "Item Categories"
{
    layout
    {
        // modify("Code")
        // {
        //     ApplicationArea = Basic;
        // }
        modify(Description)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (IndentationColumnName) on "Control1(Control 1)".


        //Unsupported feature: Property Deletion (IndentationControls) on "Control1(Control 1)".


        //Unsupported feature: Property Deletion (ShowAsTree) on "Control1(Control 1)".

        modify("Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (StyleExpr) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".

        // modify(Control3)
        // {
        //     Visible = false;
        // }
        modify(ItemAttributesFactbox)
        {
            Visible = false;
        }
        addafter(Description)
        {
            // field("Def. Gen. Prod. Posting Group"; "Def. Gen. Prod. Posting Group")
            // {
            //     ApplicationArea = Basic;
            // }
            // field("Def. Inventory Posting Group"; "Def. Inventory Posting Group")
            // {
            //     ApplicationArea = Basic;
            // }
            // field("Def. VAT Prod. Posting Group"; "Def. VAT Prod. Posting Group")
            // {
            //     ApplicationArea = Basic;
            // }
            // field("Def. Costing Method"; "Def. Costing Method")
            // {
            //     ApplicationArea = Basic;
            // }

        }
     }
}
