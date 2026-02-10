#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186915 pageextension52186915 extends "Invt. Put-away Subform"
{
    layout
    {
        modify("Action Type")
        {
            ApplicationArea = Basic;
        }
        modify("Source Document")
        {
            ApplicationArea = Basic;
        }
        modify("Source No.")
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Serial No.")
        {
            ApplicationArea = Basic;
        }
        modify("Lot No.")
        {
            ApplicationArea = Basic;
        }
        modify("Expiration Date")
        {
            ApplicationArea = Basic;
            Editable = "Expiration DateEditable";
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shelf No.")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Qty. (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Handle")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. Handled")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Handle (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. Handled (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. Outstanding")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. Outstanding (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. per Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Destination Type")
        {
            ApplicationArea = Basic;
        }
        modify("Destination No.")
        {
            ApplicationArea = Basic;
        }
        modify("Special Equipment Code")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Action Type"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Document"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lot No."(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expiration Date"(Control 1106000000)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shelf No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. (Base)"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Handle"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Handled"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Handle (Base)"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Handled (Base)"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Outstanding"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Outstanding (Base)"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. per Unit of Measure"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Destination Type"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Destination No."(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Special Equipment Code"(Control 54)".

    }
    actions
    {
        modify(SplitWhseActivityLine)
        {

            //Unsupported feature: Property Modification (Name) on "SplitWhseActivityLine(Action 1901991804)".

            ApplicationArea = Basic;
        }
        modify("Source Document Line")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Contents List")
        {
            ApplicationArea = Basic;
        }
        modify("Event")
        {
            ApplicationArea = Basic;
        }
        modify(Period)
        {
            ApplicationArea = Basic;
        }
        modify(Variant)
        {
            ApplicationArea = Basic;
        }
        modify(Location)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "SplitWhseActivityLine(Action 1901991804)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Document Line"(Action 1901742204)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Contents List"(Action 1901652504)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 1901991704)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 1900295704)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 1901742104)".

    }
    var

        "Expiration DateEditable": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ExpirationDateEditable := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Expiration DateEditable" := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "CallSplitLine(PROCEDURE 8)".

    //procedure CallSplitLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WhseActivLine.COPY(Rec);
    SplitLine(WhseActivLine);
    COPY(WhseActivLine);
    CurrPage.UPDATE(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WhseActivLine.COPY(Rec);
    SplitLine(WhseActivLine);
    CurrPage.UPDATE(FALSE);
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: WhseActivPostYesNo) (VariableCollection) on "PostPutAwayYesNo(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "PostPutAwayYesNo(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "PostPutAwayYesNo(PROCEDURE 3)".

    //procedure PostPutAwayYesNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WhseActivLine.COPY(Rec);
    CODEUNIT.RUN(CODEUNIT::"Whse.-Act.-Post (Yes/No)",WhseActivLine);
    CurrPage.UPDATE(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WhseActivLine.COPY(Rec);
    WhseActivPostYesNo.RUN(WhseActivLine);
    CurrPage.UPDATE(FALSE);
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "PostAndPrint(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "AutofillQtyToHandle(PROCEDURE 10)".


    //Unsupported feature: Property Deletion (Attributes) on "DeleteQtyToHandle(PROCEDURE 6)".


    //Unsupported feature: Property Deletion (Attributes) on "UpdateForm(PROCEDURE 1102601000)".



    //Unsupported feature: Code Modification on "UpdateExpDateEditable(PROCEDURE 1106000000)".

    //procedure UpdateExpDateEditable();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Lot No." <> '' THEN
      ExpDate := ItemTrackingMgt.ExistingExpirationDate("Item No.","Variant Code",
          "Lot No.","Serial No.",FALSE,EntriesExist);
    #4..6
      ExpDateBlocked := TRUE;
    END;

    ExpirationDateEditable := NOT ExpDateBlocked;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
    "Expiration DateEditable" := NOT ExpDateBlocked;
    */
    //end;
}
