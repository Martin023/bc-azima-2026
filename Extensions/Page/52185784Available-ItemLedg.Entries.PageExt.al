#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185784 pageextension52185784 extends "Available - Item Ledg. Entries" 
{
    layout
    {
        modify("Entry Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
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
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Reserved Quantity")
        {
            ApplicationArea = Basic;
        }
        modify(QtyToReserve)
        {
            ApplicationArea = Basic;
        }


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry Type"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lot No."(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Quantity"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Quantity"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyToReserve(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReservedThisLine(Control 19)".

    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Reserve)
        {
            ApplicationArea = Basic;
        }
        modify(CancelReservation)
        {

            //Unsupported feature: Property Modification (Name) on "CancelReservation(Action 24)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 51)".


        //Unsupported feature: Code Modification on "Reserve(Action 23).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ReservEntry.LOCKTABLE;
            UpdateReservMgt;
            ReservMgt.ItemLedgEntryUpdateValues(Rec,QtyToReserve,QtyReservedThisLine);
            #4..6

            ReservMgt.CopySign(NewQtyReservedThisLine,QtyToReserve);
            IF NewQtyReservedThisLine <> 0 THEN BEGIN
              OnBeforeCreateReservation(ReservEntry,"Lot No.","Serial No.");
              IF ABS(NewQtyReservedThisLine) > ABS(QtyToReserve) THEN BEGIN
                CreateReservation(QtyToReserve);
                MaxQtyToReserve := MaxQtyToReserve - QtyToReserve;
            #14..18
                MaxQtyToReserve := 0;
            END ELSE
              ERROR(Text000);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..9
            #11..21
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Reserve(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CancelReservation(Action 24)".

    }


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ReservEntry.TESTFIELD("Source Type");

        SetFilters;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ReservEntry.TESTFIELD("Source Type");

        RESET;
        SETRANGE("Item No.",ReservEntry."Item No.");
        SETRANGE("Variant Code",ReservEntry."Variant Code");
        SETRANGE("Location Code",ReservEntry."Location Code");
        SETRANGE("Drop Shipment",FALSE);
        SETRANGE(Open,TRUE);
        IF ReservMgt.FieldFilterNeeded2(ReservEntry,ReservMgt.IsPositive,0) THEN
          SETFILTER("Lot No.",ReservMgt.GetFieldFilter);
        IF ReservMgt.FieldFilterNeeded2(ReservEntry,ReservMgt.IsPositive,1) THEN
          SETFILTER("Serial No.",ReservMgt.GetFieldFilter);
        IF ReservMgt.IsPositive THEN BEGIN
          SETRANGE(Positive,TRUE);
          SETFILTER("Remaining Quantity",'>0');
        END ELSE BEGIN
          SETRANGE(Positive,FALSE);
          SETFILTER("Remaining Quantity",'<0');
        END;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetSalesLine(PROCEDURE 24)".


    //Unsupported feature: Property Deletion (Attributes) on "SetReqLine(PROCEDURE 23)".


    //Unsupported feature: Property Deletion (Attributes) on "SetPurchLine(PROCEDURE 22)".


    //Unsupported feature: Property Deletion (Attributes) on "SetProdOrderLine(PROCEDURE 19)".


    //Unsupported feature: Property Deletion (Attributes) on "SetProdOrderComponent(PROCEDURE 18)".


    //Unsupported feature: Property Deletion (Attributes) on "SetPlanningComponent(PROCEDURE 15)".


    //Unsupported feature: Property Deletion (Attributes) on "SetTransferLine(PROCEDURE 16)".


    //Unsupported feature: Property Deletion (Attributes) on "SetServiceLine(PROCEDURE 8)".


    //Unsupported feature: Property Deletion (Attributes) on "SetJobPlanningLine(PROCEDURE 5)".


    //Unsupported feature: Property Deletion (Attributes) on "SetTotalAvailQty(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetMaxQtyToReserve(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyLine(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyHeader(PROCEDURE 7)".



    //Unsupported feature: Code Modification on "CreateReservation(PROCEDURE 14)".

    //procedure CreateReservation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD("Drop Shipment",FALSE);
        TESTFIELD("Item No.",ReservEntry."Item No.");
        TESTFIELD("Variant Code",ReservEntry."Variant Code");
        TESTFIELD("Location Code",ReservEntry."Location Code");
        SpecialOrderSalesNo := ReservMgt.FindUnfinishedSpecialOrderSalesNo(Rec);
        IF SpecialOrderSalesNo <> '' THEN
          ERROR(CannotReserveFromSpecialOrderErr,SpecialOrderSalesNo);

        IF TotalAvailQty < 0 THEN BEGIN
          ReserveQuantity := 0;
        #11..21
          ERROR(Text002);

        UpdateReservMgt;
        TrackingSpecification.InitTrackingSpecification(
          DATABASE::"Item Ledger Entry",0,'','',0,"Entry No.",
          "Variant Code","Location Code","Serial No.","Lot No.","Qty. per Unit of Measure");
        ReservMgt.CreateReservation(
          ReservEntry.Description,0D,0,ReserveQuantity,TrackingSpecification);
        UpdateReservFrom;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        #8..24
        ReservMgt.CreateTrackingSpecification(TrackingSpecification,
        #26..30
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateReservFrom(PROCEDURE 17)".

    //procedure UpdateReservFrom();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE ReservEntry."Source Type" OF
          DATABASE::"Sales Line":
            BEGIN
        #4..54
              SetAssemblyHeader(AssemblyHeader,ReservEntry);
            END;
        END;

        OnAfterUpdateReservFrom;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..57
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateReservMgt(PROCEDURE 13)".

    //procedure UpdateReservMgt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(ReservMgt);
        CASE ReservEntry."Source Type" OF
          DATABASE::"Sales Line":
        #4..23
            ReservMgt.SetAssemblyHeader(AssemblyHeader);
        END;
        ReservMgt.SetSerialLotNo(ReservEntry."Serial No.",ReservEntry."Lot No.");

        OnAfterUpdateReservMgt;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..26
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "CreateReservation(PROCEDURE 14).SpecialOrderSalesNo(Variable 1002)".

}
