#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186549 pageextension52186549 extends "Whse. Receipt Subform" 
{
    layout
    {
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
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Zone Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify("Cross-Dock Zone Code")
        {
            ApplicationArea = Basic;
        }
        modify("Cross-Dock Bin Code")
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
        modify("Qty. to Receive")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Cross-Dock")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. Received")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Receive (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Cross-Dock (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. Received (Base)")
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Document"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Zone Code"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Dock Zone Code"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Dock Bin Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shelf No."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. (Base)"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Receive"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Cross-Dock"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Received"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Receive (Base)"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Cross-Dock (Base)"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Received (Base)"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Outstanding"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Outstanding (Base)"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. per Unit of Measure"(Control 24)".

    }
    actions
    {
        modify("Source &Document Line")
        {
            ApplicationArea = Basic;
        }
        modify("&Bin Contents List")
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
        modify(ItemTrackingLines)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Source &Document Line"(Action 1900724404)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Bin Contents List"(Action 1901313204)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 1901313504)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 1900295904)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 1901742304)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemTrackingLines(Action 1903100004)".

    }

    //Unsupported feature: Variable Insertion (Variable: WhsePostReceiptYesNo) (VariableCollection) on "WhsePostRcptYesNo(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "WhsePostRcptYesNo(PROCEDURE 3)".


    //Unsupported feature: Code Modification on "WhsePostRcptYesNo(PROCEDURE 3)".

    //procedure WhsePostRcptYesNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WhseRcptLine.COPY(Rec);
        CODEUNIT.RUN(CODEUNIT::"Whse.-Post Receipt (Yes/No)",WhseRcptLine);
        RESET;
        SETCURRENTKEY("No.","Sorting Sequence No.");
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WhseRcptLine.COPY(Rec);
        WhsePostReceiptYesNo.RUN(WhseRcptLine);
        #3..5
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: WhsePostReceiptPrint) (VariableCollection) on "WhsePostRcptPrint(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (Attributes) on "WhsePostRcptPrint(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "WhsePostRcptPrint(PROCEDURE 4)".

    //procedure WhsePostRcptPrint();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WhseRcptLine.COPY(Rec);
        CODEUNIT.RUN(CODEUNIT::"Whse.-Post Receipt + Print",WhseRcptLine);
        RESET;
        SETCURRENTKEY("No.","Sorting Sequence No.");
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WhseRcptLine.COPY(Rec);
        WhsePostReceiptPrint.RUN(WhseRcptLine);
        #3..5
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: WhsePostReceiptPrintPostedRcpt) (VariableCollection) on "WhsePostRcptPrintPostedRcpt(PROCEDURE 5)".


    //Unsupported feature: Property Deletion (Attributes) on "WhsePostRcptPrintPostedRcpt(PROCEDURE 5)".



    //Unsupported feature: Code Modification on "WhsePostRcptPrintPostedRcpt(PROCEDURE 5)".

    //procedure WhsePostRcptPrintPostedRcpt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WhseRcptLine.COPY(Rec);
        CODEUNIT.RUN(CODEUNIT::"Whse.-Post Receipt + Pr. Pos.",WhseRcptLine);
        RESET;
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WhseRcptLine.COPY(Rec);
        WhsePostReceiptPrintPostedRcpt.RUN(WhseRcptLine);
        RESET;
        CurrPage.UPDATE(FALSE);
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "AutofillQtyToReceive(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "AutofillQtyToReceive(PROCEDURE 10)".

    //procedure AutofillQtyToReceive();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WhseRcptLine.COPY(Rec);
        WhseRcptLine.SETRANGE("No.","No.");
        AutofillQtyToReceive(WhseRcptLine);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WhseRcptLine.COPY(Rec);
        AutofillQtyToReceive(WhseRcptLine);
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "DeleteQtyToReceive(PROCEDURE 8)".



    //Unsupported feature: Code Modification on "DeleteQtyToReceive(PROCEDURE 8)".

    //procedure DeleteQtyToReceive();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WhseRcptLine.COPY(Rec);
        WhseRcptLine.SETRANGE("No.","No.");
        DeleteQtyToReceive(WhseRcptLine);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WhseRcptLine.COPY(Rec);
        DeleteQtyToReceive(WhseRcptLine);
        */
    //end;
}
