#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186435 pageextension52186435 extends "Item Units of Measure" 
{
    layout
    {
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. per Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify(Height)
        {
            ApplicationArea = Basic;
        }
        modify(Width)
        {
            ApplicationArea = Basic;
        }
        modify(Length)
        {
            ApplicationArea = Basic;
        }
        modify(Cubage)
        {
            ApplicationArea = Basic;
        }
        modify(Weight)
        {
            ApplicationArea = Basic;
        }
        modify(ItemUnitOfMeasure)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. per Unit of Measure"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Height(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Width(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Length(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Cubage(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Weight(Control 19)".


        //Unsupported feature: Code Modification on "ItemUnitOfMeasure(Control 5).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            Item.TESTFIELD("No.");
            Item.LOCKTABLE;
            Item.FIND;
            Item.VALIDATE("Base Unit of Measure",ItemBaseUOM);
            Item.MODIFY(TRUE);
            CurrPage.UPDATE;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #4..6
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ItemUnitOfMeasure(Control 5)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }


    //Unsupported feature: Code Modification on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Item No." = '' THEN
          "Item No." := Item."No.";
        SetStyle;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SetStyle;
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF GETFILTER("Item No.") <> '' THEN BEGIN
          COPYFILTER("Item No.",Item."No.");
          IF Item.FINDFIRST THEN
            ItemBaseUOM := Item."Base Unit of Measure";
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF Item.GET("Item No.") THEN
          ItemBaseUOM := Item."Base Unit of Measure";
        */
    //end;

    //Unsupported feature: Property Deletion (PopulateAllFields).

}
