#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187063 pageextension52187063 extends "My Items" 
{
    layout
    {
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Description(Control 9)".


            //Unsupported feature: Property Modification (Name) on "Description(Control 9)".

            Editable = false;
        }
        modify("Unit Price")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Unit Price"(Control 2)".


            //Unsupported feature: Property Modification (Name) on ""Unit Price"(Control 2)".

            Editable = false;
        }
        modify(Inventory)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Inventory(Control 13)".

            Editable = false;
        }

        //Unsupported feature: Code Modification on ""Item No."(Control 4).OnValidate".

        //trigger "(Control 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            SyncFieldsWithItem
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            GetItem;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 4)".


        //Unsupported feature: Property Deletion (Lookup) on "Description(Control 9)".


        //Unsupported feature: Property Deletion (DrillDown) on "Description(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 9)".


        //Unsupported feature: Property Deletion (Lookup) on ""Unit Price"(Control 2)".


        //Unsupported feature: Property Deletion (DrillDown) on ""Unit Price"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Inventory(Control 13)".

    }
    actions
    {
        modify(Open)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Open(Action 11)".

    }


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SyncFieldsWithItem
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetItem;
        */
    //end;


    //Unsupported feature: Code Modification on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(Item)
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CLEAR(Item);
        */
    //end;

    local procedure GetItem()
    begin
        // Clear(Item);

        // if Item.Get(Rec."Item No.") then
        //   Item.CalcFields(Rec.Inventory);
    end;
}
