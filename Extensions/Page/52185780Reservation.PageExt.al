#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185780 pageextension52185780 extends Reservation 
{
    layout
    {
        modify(ItemNo)
        {
            ApplicationArea = Basic;
        }
        modify("ReservEntry.""Shipment Date""")
        {
            ApplicationArea = Basic;
        }
        modify("ReservEntry.Description")
        {
            ApplicationArea = Basic;
        }
        modify(QtyToReserveBase)
        {
            ApplicationArea = Basic;
        }
        modify(QtyReservedBase)
        {
            ApplicationArea = Basic;
        }
        modify(UnreservedQuantity)
        {
            ApplicationArea = Basic;
        }
        modify("Summary Type")
        {
            ApplicationArea = Basic;
        }
        modify("Total Quantity")
        {
            ApplicationArea = Basic;
        }
        modify(TotalReservedQuantity)
        {
            ApplicationArea = Basic;
        }
        modify(QtyAllocatedInWarehouse)
        {
            ApplicationArea = Basic;
        }
        modify("ReservMgt.FormatQty(""Res. Qty. on Picks & Shipmts."")")
        {
            ApplicationArea = Basic;
        }
        modify(TotalAvailableQuantity)
        {
            ApplicationArea = Basic;
        }
        modify("Non-specific Reserved Qty.")
        {
            ApplicationArea = Basic;
        }
        modify("Current Reserved Quantity")
        {
            ApplicationArea = Basic;
        }
        modify(NoteText)
        {
            ApplicationArea = Basic;
        }
        modify("ReservEntry.""Variant Code""")
        {
            ApplicationArea = Basic;
        }
        modify("ReservEntry.""Location Code""")
        {
            ApplicationArea = Basic;
        }
        modify("ReservEntry.""Serial No.""")
        {
            ApplicationArea = Basic;
        }
        modify("ReservEntry.""Lot No.""")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ItemNo(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ReservEntry.""Shipment Date"""(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ReservEntry.Description"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyToReserveBase(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyReservedBase(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "UnreservedQuantity(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Summary Type"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Quantity"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalReservedQuantity(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyAllocatedInWarehouse(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ReservMgt.FormatQty(""Res. Qty. on Picks & Shipmts."")"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalAvailableQuantity(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Non-specific Reserved Qty."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Current Reserved Quantity"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ReservEntry.""Variant Code"""(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ReservEntry.""Location Code"""(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ReservEntry.""Serial No."""(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ReservEntry.""Lot No."""(Control 44)".

    }
    actions
    {
        modify(AvailableToReserve)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "AvailableToReserve(Action 30)".

        }
        modify("&Reservation Entries")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Reservation Entries"(Action 34)".

        }
        modify("Auto Reserve")
        {
            ApplicationArea = Basic;
        }
        modify("Reserve from Current Line")
        {
            ApplicationArea = Basic;
        }
        modify(CancelReservationCurrentLine)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "AvailableToReserve(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Reservation Entries"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Auto Reserve"(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserve from Current Line"(Action 37)".


        //Unsupported feature: Code Modification on "CancelReservationCurrentLine(Action 43).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF NOT CONFIRM(Text003,FALSE,"Summary Type") THEN
              EXIT;
            CLEAR(ReservEntry2);
            ReservEntry2 := ReservEntry;
            ReservEntry2.SetPointerFilter;
            ReservEntry2.SETRANGE("Reservation Status",ReservEntry2."Reservation Status"::Reservation);
            ReservEntry2.SETRANGE("Disallow Cancellation",FALSE);
            IF ReservEntry2.FINDSET THEN
            #9..17
              UpdateReservFrom
            ELSE
              ERROR(Text005);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
            ReservMgt.SetPointerFilter(ReservEntry2);
            #6..20
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CancelReservationCurrentLine(Action 43)".

    }


    //Unsupported feature: Property Modification (Id) on "NoteTextVisible(Variable 1126)".

    //var
        //>>>> ORIGINAL VALUE:
        //NoteTextVisible : 1126;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //NoteTextVisible : 19017321;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (Attributes) on "SetSalesLine(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "SetSalesLine(PROCEDURE 1)".

    //procedure SetSalesLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrentSalesLine.TESTFIELD("Job No.",'');
        CurrentSalesLine.TESTFIELD("Drop Shipment",FALSE);
        CurrentSalesLine.TESTFIELD(Type,CurrentSalesLine.Type::Item);
        CurrentSalesLine.TESTFIELD("Shipment Date");

        SalesLine := CurrentSalesLine;
        ReservEntry.SetSource(
          DATABASE::"Sales Line",SalesLine."Document Type",SalesLine."Document No.",SalesLine."Line No.",'',0);
        ReservEntry."Item No." := SalesLine."No.";
        ReservEntry."Variant Code" := SalesLine."Variant Code";
        ReservEntry."Location Code" := SalesLine."Location Code";
        ReservEntry."Shipment Date" := SalesLine."Shipment Date";

        CaptionText := ReserveSalesLine.Caption(SalesLine);
        UpdateReservFrom;

        OnAfterSetSalesLine(Rec,ReservEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        ReservEntry."Source Type" := DATABASE::"Sales Line";
        ReservEntry."Source Subtype" := SalesLine."Document Type";
        ReservEntry."Source ID" := SalesLine."Document No.";
        ReservEntry."Source Ref. No." := SalesLine."Line No.";

        #9..15
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetReqLine(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "SetReqLine(PROCEDURE 2)".

    //procedure SetReqLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrentReqLine.TESTFIELD("Sales Order No.",'');
        CurrentReqLine.TESTFIELD("Sales Order Line No.",0);
        CurrentReqLine.TESTFIELD("Sell-to Customer No.",'');
        CurrentReqLine.TESTFIELD(Type,CurrentReqLine.Type::Item);
        CurrentReqLine.TESTFIELD("Due Date");

        ReqLine := CurrentReqLine;
        ReservEntry.SetSource(
          DATABASE::"Requisition Line",0,ReqLine."Worksheet Template Name",ReqLine."Line No.",ReqLine."Journal Batch Name",0);
        ReservEntry."Item No." := ReqLine."No.";
        ReservEntry."Variant Code" := ReqLine."Variant Code";
        ReservEntry."Location Code" := ReqLine."Location Code";
        ReservEntry."Shipment Date" := ReqLine."Due Date";

        CaptionText := ReserveReqLine.Caption(ReqLine);
        UpdateReservFrom;

        OnAfterSetReqLine(Rec,ReservEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7

        ReservEntry."Source Type" := DATABASE::"Requisition Line";
        ReservEntry."Source ID" := ReqLine."Worksheet Template Name";
        ReservEntry."Source Batch Name" := ReqLine."Journal Batch Name";
        ReservEntry."Source Ref. No." := ReqLine."Line No.";

        #10..16
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetPurchLine(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "SetPurchLine(PROCEDURE 3)".

    //procedure SetPurchLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrentPurchLine.TESTFIELD("Job No.",'');
        CurrentPurchLine.TESTFIELD("Drop Shipment",FALSE);
        CurrentPurchLine.TESTFIELD(Type,CurrentPurchLine.Type::Item);
        CurrentPurchLine.TESTFIELD("Expected Receipt Date");

        PurchLine := CurrentPurchLine;
        ReservEntry.SetSource(
          DATABASE::"Purchase Line",PurchLine."Document Type",PurchLine."Document No.",PurchLine."Line No.",'',0);
        ReservEntry."Item No." := PurchLine."No.";
        ReservEntry."Variant Code" := PurchLine."Variant Code";
        ReservEntry."Location Code" := PurchLine."Location Code";
        ReservEntry."Shipment Date" := PurchLine."Expected Receipt Date";

        CaptionText := ReservePurchLine.Caption(PurchLine);
        UpdateReservFrom;

        OnAfterSetPurchLine(Rec,ReservEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        ReservEntry."Source Type" := DATABASE::"Purchase Line";
        ReservEntry."Source Subtype" := PurchLine."Document Type";
        ReservEntry."Source ID" := PurchLine."Document No.";
        ReservEntry."Source Ref. No." := PurchLine."Line No.";

        #9..15
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetItemJnlLine(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "SetItemJnlLine(PROCEDURE 4)".

    //procedure SetItemJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrentItemJnlLine.TESTFIELD("Drop Shipment",FALSE);
        CurrentItemJnlLine.TESTFIELD("Posting Date");

        ItemJnlLine := CurrentItemJnlLine;
        ReservEntry.SetSource(
          DATABASE::"Item Journal Line",ItemJnlLine."Entry Type",ItemJnlLine."Journal Template Name",ItemJnlLine."Line No.",
          ItemJnlLine."Journal Batch Name",0);
        ReservEntry."Item No." := ItemJnlLine."Item No.";
        ReservEntry."Variant Code" := ItemJnlLine."Variant Code";
        ReservEntry."Location Code" := ItemJnlLine."Location Code";
        ReservEntry."Shipment Date" := ItemJnlLine."Posting Date";

        CaptionText := ReserveItemJnlLine.Caption(ItemJnlLine);
        UpdateReservFrom;

        OnAfterSetItemJnlLine(Rec,ReservEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        ReservEntry."Source Type" := DATABASE::"Item Journal Line";
        ReservEntry."Source Subtype" := ItemJnlLine."Entry Type";
        ReservEntry."Source ID" := ItemJnlLine."Journal Template Name";
        ReservEntry."Source Batch Name" := ItemJnlLine."Journal Batch Name";
        ReservEntry."Source Ref. No." := ItemJnlLine."Line No.";

        #8..14
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetProdOrderLine(PROCEDURE 9)".



    //Unsupported feature: Code Modification on "SetProdOrderLine(PROCEDURE 9)".

    //procedure SetProdOrderLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrentProdOrderLine.TESTFIELD("Due Date");

        ProdOrderLine := CurrentProdOrderLine;
        ReservEntry.SetSource(
          DATABASE::"Prod. Order Line",ProdOrderLine.Status,ProdOrderLine."Prod. Order No.",0,'',ProdOrderLine."Line No.");
        ReservEntry."Item No." := ProdOrderLine."Item No.";
        ReservEntry."Variant Code" := ProdOrderLine."Variant Code";
        ReservEntry."Location Code" := ProdOrderLine."Location Code";
        ReservEntry."Shipment Date" := ProdOrderLine."Due Date";

        CaptionText := ReserveProdOrderLine.Caption(ProdOrderLine);
        UpdateReservFrom;

        OnAfterSetProdOrderLine(Rec,ReservEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        ReservEntry."Source Type" := DATABASE::"Prod. Order Line";
        ReservEntry."Source Subtype" := ProdOrderLine.Status;
        ReservEntry."Source ID" := ProdOrderLine."Prod. Order No.";
        ReservEntry."Source Prod. Order Line" := ProdOrderLine."Line No.";

        #6..12
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetProdOrderComponent(PROCEDURE 13)".



    //Unsupported feature: Code Modification on "SetProdOrderComponent(PROCEDURE 13)".

    //procedure SetProdOrderComponent();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrentProdOrderComp.TESTFIELD("Due Date");

        ProdOrderComp := CurrentProdOrderComp;
        ReservEntry.SetSource(
          DATABASE::"Prod. Order Component",ProdOrderComp.Status,ProdOrderComp."Prod. Order No.",ProdOrderComp."Line No.",
          '',ProdOrderComp."Prod. Order Line No.");
        ReservEntry."Item No." := ProdOrderComp."Item No.";
        ReservEntry."Variant Code" := ProdOrderComp."Variant Code";
        ReservEntry."Location Code" := ProdOrderComp."Location Code";
        ReservEntry."Shipment Date" := ProdOrderComp."Due Date";

        CaptionText := ReserveProdOrderComp.Caption(ProdOrderComp);
        UpdateReservFrom;

        OnAfterSetProdOrderComponent(Rec,ReservEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        ReservEntry."Source Type" := DATABASE::"Prod. Order Component";
        ReservEntry."Source Subtype" := ProdOrderComp.Status;
        ReservEntry."Source ID" := ProdOrderComp."Prod. Order No.";
        ReservEntry."Source Prod. Order Line" := ProdOrderComp."Prod. Order Line No.";
        ReservEntry."Source Ref. No." := ProdOrderComp."Line No.";

        #7..13
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyHeader(PROCEDURE 23)".



    //Unsupported feature: Code Modification on "SetAssemblyHeader(PROCEDURE 23)".

    //procedure SetAssemblyHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrentAssemblyHeader.TESTFIELD("Due Date");

        AssemblyHeader := CurrentAssemblyHeader;
        ReservEntry.SetSource(DATABASE::"Assembly Header",AssemblyHeader."Document Type",AssemblyHeader."No.",0,'',0);
        ReservEntry."Item No." := AssemblyHeader."Item No.";
        ReservEntry."Variant Code" := AssemblyHeader."Variant Code";
        ReservEntry."Location Code" := AssemblyHeader."Location Code";
        ReservEntry."Shipment Date" := AssemblyHeader."Due Date";

        CaptionText := AssemblyHeaderReserve.Caption(AssemblyHeader);
        UpdateReservFrom;

        OnAfterSetAssemblyHeader(Rec,ReservEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        ReservEntry."Source Type" := DATABASE::"Assembly Header";
        ReservEntry."Source Subtype" := AssemblyHeader."Document Type";
        ReservEntry."Source ID" := AssemblyHeader."No.";
        ReservEntry."Source Ref. No." := 0;

        #5..11
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyLine(PROCEDURE 22)".



    //Unsupported feature: Code Modification on "SetAssemblyLine(PROCEDURE 22)".

    //procedure SetAssemblyLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrentAssemblyLine.TESTFIELD(Type,CurrentAssemblyLine.Type::Item);
        CurrentAssemblyLine.TESTFIELD("Due Date");

        AssemblyLine := CurrentAssemblyLine;
        ReservEntry.SetSource(
          DATABASE::"Assembly Line",AssemblyLine."Document Type",AssemblyLine."Document No.",AssemblyLine."Line No.",'',0);
        ReservEntry."Item No." := AssemblyLine."No.";
        ReservEntry."Variant Code" := AssemblyLine."Variant Code";
        ReservEntry."Location Code" := AssemblyLine."Location Code";
        ReservEntry."Shipment Date" := AssemblyLine."Due Date";

        CaptionText := AssemblyLineReserve.Caption(AssemblyLine);
        UpdateReservFrom;

        OnAfterSetAssemblyLine(Rec,ReservEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        ReservEntry."Source Type" := DATABASE::"Assembly Line";
        ReservEntry."Source Subtype" := AssemblyLine."Document Type";
        ReservEntry."Source ID" := AssemblyLine."Document No.";
        ReservEntry."Source Ref. No." := AssemblyLine."Line No.";

        #7..13
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetPlanningComponent(PROCEDURE 18)".



    //Unsupported feature: Code Modification on "SetPlanningComponent(PROCEDURE 18)".

    //procedure SetPlanningComponent();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrentPlanningComponent.TESTFIELD("Due Date");

        PlanningComponent := CurrentPlanningComponent;
        ReservEntry.SetSource(
          DATABASE::"Planning Component",0,PlanningComponent."Worksheet Template Name",PlanningComponent."Line No.",
          PlanningComponent."Worksheet Batch Name",PlanningComponent."Worksheet Line No.");
        ReservEntry."Item No." := PlanningComponent."Item No.";
        ReservEntry."Variant Code" := PlanningComponent."Variant Code";
        ReservEntry."Location Code" := PlanningComponent."Location Code";
        ReservEntry."Shipment Date" := PlanningComponent."Due Date";

        CaptionText := ReservePlanningComponent.Caption(PlanningComponent);
        UpdateReservFrom;

        OnAfterSetPlanningComponent(Rec,ReservEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        ReservEntry."Source Type" := DATABASE::"Planning Component";
        ReservEntry."Source ID" := PlanningComponent."Worksheet Template Name";
        ReservEntry."Source Batch Name" := PlanningComponent."Worksheet Batch Name";
        ReservEntry."Source Prod. Order Line" := PlanningComponent."Worksheet Line No.";
        ReservEntry."Source Ref. No." := PlanningComponent."Line No.";

        #7..13
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetTransLine(PROCEDURE 47)".



    //Unsupported feature: Code Modification on "SetTransLine(PROCEDURE 47)".

    //procedure SetTransLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEARALL;

        TransLine := CurrentTransLine;
        ReservEntry.SetSource(
          DATABASE::"Transfer Line",Direction,CurrentTransLine."Document No.",CurrentTransLine."Line No.",
          '',CurrentTransLine."Derived From Line No.");
        ReservEntry."Item No." := CurrentTransLine."Item No.";
        ReservEntry."Variant Code" := CurrentTransLine."Variant Code";
        CASE Direction OF
        #10..22

        CaptionText := ReserveTransLine.Caption(TransLine);
        UpdateReservFrom;

        OnAfterSetTransLine(Rec,ReservEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        ReservEntry."Source Type" := DATABASE::"Transfer Line";
        ReservEntry."Source Subtype" := Direction;
        ReservEntry."Source ID" := CurrentTransLine."Document No.";
        ReservEntry."Source Prod. Order Line" := CurrentTransLine."Derived From Line No.";
        ReservEntry."Source Ref. No." := CurrentTransLine."Line No.";

        #7..25
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetServiceLine(PROCEDURE 15)".



    //Unsupported feature: Code Modification on "SetServiceLine(PROCEDURE 15)".

    //procedure SetServiceLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrentServiceLine.TESTFIELD(Type,CurrentServiceLine.Type::Item);
        CurrentServiceLine.TESTFIELD("Needed by Date");

        ServiceLine := CurrentServiceLine;
        ReservEntry.SetSource(
          DATABASE::"Service Line",ServiceLine."Document Type",ServiceLine."Document No.",ServiceLine."Line No.",'',0);
        ReservEntry."Item No." := ServiceLine."No.";
        ReservEntry."Variant Code" := ServiceLine."Variant Code";
        ReservEntry."Location Code" := ServiceLine."Location Code";
        ReservEntry."Shipment Date" := ServiceLine."Needed by Date";

        CaptionText := ReserveServiceLine.Caption(ServiceLine);
        UpdateReservFrom;

        OnAfterSetServiceLine(Rec,ReservEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        ReservEntry."Source Type" := DATABASE::"Service Line";
        ReservEntry."Source Subtype" := ServiceLine."Document Type";
        ReservEntry."Source ID" := ServiceLine."Document No.";
        ReservEntry."Source Ref. No." := ServiceLine."Line No.";

        #7..13
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetJobPlanningLine(PROCEDURE 20)".



    //Unsupported feature: Code Modification on "SetJobPlanningLine(PROCEDURE 20)".

    //procedure SetJobPlanningLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrentJobPlanningLine.TESTFIELD(Type,CurrentJobPlanningLine.Type::Item);
        CurrentJobPlanningLine.TESTFIELD("Planning Date");

        JobPlanningLine := CurrentJobPlanningLine;
        ReservEntry.SetSource(
          DATABASE::"Job Planning Line",JobPlanningLine.Status,JobPlanningLine."Job No.",
          JobPlanningLine."Job Contract Entry No.",'',0);
        ReservEntry."Item No." := JobPlanningLine."No.";
        ReservEntry."Variant Code" := JobPlanningLine."Variant Code";
        ReservEntry."Location Code" := JobPlanningLine."Location Code";
        ReservEntry."Shipment Date" := JobPlanningLine."Planning Date";

        CaptionText := JobPlanningLineReserve.Caption(JobPlanningLine);
        UpdateReservFrom;

        OnAfterSetJobPlanningLine(Rec,ReservEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        ReservEntry."Source Type" := DATABASE::"Job Planning Line";
        ReservEntry."Source Subtype" := JobPlanningLine.Status;
        ReservEntry."Source ID" := JobPlanningLine."Job No.";
        ReservEntry."Source Ref. No." := JobPlanningLine."Job Contract Entry No.";

        #8..14
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetReservEntry(PROCEDURE 16)".



    //Unsupported feature: Code Modification on "FilterReservEntry(PROCEDURE 11)".

    //procedure FilterReservEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        FilterReservEntry.SETRANGE("Item No.",ReservEntry."Item No.");

        CASE FromReservSummEntry."Entry No." OF
        #4..68
            END;
        END;

        OnFilterReservEntryOnAfterFilterSource(FilterReservEntry,FromReservSummEntry,ReservEntry);

        FilterReservEntry.SETRANGE(
          "Reservation Status",FilterReservEntry."Reservation Status"::Reservation);
        FilterReservEntry.SETRANGE("Location Code",ReservEntry."Location Code");
        #77..79
          FilterReservEntry.SETRANGE("Lot No.",ReservEntry."Lot No.");
        END;
        FilterReservEntry.SETRANGE(Positive,ReservMgt.IsPositive);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..71
        #74..82
        */
    //end;


    //Unsupported feature: Code Modification on "RelatesToSummEntry(PROCEDURE 5)".

    //procedure RelatesToSummEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE FromReservSummEntry."Entry No." OF
          1: // Item Ledger Entry
            EXIT((FilterReservEntry."Source Type" = DATABASE::"Item Ledger Entry") AND
        #4..38
            EXIT((FilterReservEntry."Source Type" = DATABASE::"Assembly Line") AND
              (FilterReservEntry."Source Subtype" = FromReservSummEntry."Entry No." - 151));
        END;

        IsHandled := FALSE;
        OnAfterRelatesToSummEntry(FromReservSummEntry,FilterReservEntry,IsHandled);
        EXIT(IsHandled);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..41
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateReservFrom(PROCEDURE 12)".

    //procedure UpdateReservFrom();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT FormIsOpen THEN
          GetSerialLotNo(ItemTrackingQtyToReserve,ItemTrackingQtyToReserveBase);

        QtyPerUOM := GetQtyPerUOMFromSource;

        UpdateReservMgt;
        ReservMgt.UpdateStatistics(
        #8..13
            REPEAT
              QtyReservedBase += ReservedThisLine(Rec);
            UNTIL NEXT = 0;
          QtyReservedIT := ROUND(QtyReservedBase / QtyPerUOM,UOMMgt.QtyRndPrecision);
          IF ABS(QtyReserved - QtyReservedIT) > UOMMgt.QtyRndPrecision THEN
            QtyReserved := QtyReservedIT;
          QtyToReserveBase := ItemTrackingQtyToReserveBase;
          IF ABS(ItemTrackingQtyToReserve - QtyToReserve) > UOMMgt.QtyRndPrecision THEN
            QtyToReserve := ItemTrackingQtyToReserve;
          Rec := EntrySummary;
        END;

        UpdateNonSpecific; // Late Binding

        OnAfterUpdateReservFrom;

        IF FormIsOpen THEN
          CurrPage.UPDATE;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        CASE ReservEntry."Source Type" OF
          DATABASE::"Sales Line":
            BEGIN
              SalesLine.FIND;
              SalesLine.CALCFIELDS("Reserved Quantity","Reserved Qty. (Base)");
              IF SalesLine."Document Type" = SalesLine."Document Type"::"Return Order" THEN BEGIN
                SalesLine."Reserved Quantity" := -SalesLine."Reserved Quantity";
                SalesLine."Reserved Qty. (Base)" := -SalesLine."Reserved Qty. (Base)";
              END;
              QtyReserved := SalesLine."Reserved Quantity";
              QtyReservedBase := SalesLine."Reserved Qty. (Base)";
              QtyToReserve := SalesLine."Outstanding Quantity";
              QtyToReserveBase := SalesLine."Outstanding Qty. (Base)";
              QtyPerUOM := SalesLine."Qty. per Unit of Measure";
            END;
          DATABASE::"Requisition Line":
            BEGIN
              ReqLine.FIND;
              ReqLine.CALCFIELDS("Reserved Quantity","Reserved Qty. (Base)");
              QtyReserved := ReqLine."Reserved Quantity";
              QtyReservedBase := ReqLine."Reserved Qty. (Base)";
              QtyToReserve := ReqLine.Quantity;
              QtyToReserveBase := ReqLine."Quantity (Base)";
              QtyPerUOM := ReqLine."Qty. per Unit of Measure";
            END;
          DATABASE::"Purchase Line":
            BEGIN
              PurchLine.FIND;
              PurchLine.CALCFIELDS("Reserved Quantity","Reserved Qty. (Base)");
              IF PurchLine."Document Type" = PurchLine."Document Type"::"Return Order" THEN BEGIN
                PurchLine."Reserved Quantity" := -PurchLine."Reserved Quantity";
                PurchLine."Reserved Qty. (Base)" := -PurchLine."Reserved Qty. (Base)";
              END;
              QtyReserved := PurchLine."Reserved Quantity";
              QtyReservedBase := PurchLine."Reserved Qty. (Base)";
              QtyToReserve := PurchLine."Outstanding Quantity";
              QtyToReserveBase := PurchLine."Outstanding Qty. (Base)";
              QtyPerUOM := PurchLine."Qty. per Unit of Measure";
            END;
          DATABASE::"Item Journal Line":
            BEGIN
              ItemJnlLine.FIND;
              ItemJnlLine.CALCFIELDS("Reserved Quantity","Reserved Qty. (Base)");
              QtyReserved := ItemJnlLine."Reserved Quantity";
              QtyReservedBase := ItemJnlLine."Reserved Qty. (Base)";
              QtyToReserve := ItemJnlLine.Quantity;
              QtyToReserveBase := ItemJnlLine."Quantity (Base)";
              QtyPerUOM := ItemJnlLine."Qty. per Unit of Measure";
            END;
          DATABASE::"Prod. Order Line":
            BEGIN
              ProdOrderLine.FIND;
              ProdOrderLine.CALCFIELDS("Reserved Quantity","Reserved Qty. (Base)");
              QtyReserved := ProdOrderLine."Reserved Quantity";
              QtyReservedBase := ProdOrderLine."Reserved Qty. (Base)";
              QtyToReserve := ProdOrderLine."Remaining Quantity";
              QtyToReserveBase := ProdOrderLine."Remaining Qty. (Base)";
              QtyPerUOM := ProdOrderLine."Qty. per Unit of Measure";
            END;
          DATABASE::"Prod. Order Component":
            BEGIN
              ProdOrderComp.FIND;
              ProdOrderComp.CALCFIELDS("Reserved Quantity","Reserved Qty. (Base)");
              QtyReserved := ProdOrderComp."Reserved Quantity";
              QtyReservedBase := ProdOrderComp."Reserved Qty. (Base)";
              QtyToReserve := ProdOrderComp."Remaining Quantity";
              QtyToReserveBase := ProdOrderComp."Remaining Qty. (Base)";
              QtyPerUOM := ProdOrderComp."Qty. per Unit of Measure";
            END;
          DATABASE::"Assembly Header":
            BEGIN
              AssemblyHeader.FIND;
              AssemblyHeader.CALCFIELDS("Reserved Quantity","Reserved Qty. (Base)");
              QtyReserved := AssemblyHeader."Reserved Quantity";
              QtyReservedBase := AssemblyHeader."Reserved Qty. (Base)";
              QtyToReserve := AssemblyHeader."Remaining Quantity";
              QtyToReserveBase := AssemblyHeader."Remaining Quantity (Base)";
              QtyPerUOM := AssemblyHeader."Qty. per Unit of Measure";
            END;
          DATABASE::"Assembly Line":
            BEGIN
              AssemblyLine.FIND;
              AssemblyLine.CALCFIELDS("Reserved Quantity","Reserved Qty. (Base)");
              QtyReserved := AssemblyLine."Reserved Quantity";
              QtyReservedBase := AssemblyLine."Reserved Qty. (Base)";
              QtyToReserve := AssemblyLine."Remaining Quantity";
              QtyToReserveBase := AssemblyLine."Remaining Quantity (Base)";
              QtyPerUOM := AssemblyLine."Qty. per Unit of Measure";
            END;
          DATABASE::"Planning Component":
            BEGIN
              PlanningComponent.FIND;
              PlanningComponent.CALCFIELDS("Reserved Quantity","Reserved Qty. (Base)");
              QtyReserved := PlanningComponent."Reserved Quantity";
              QtyReservedBase := PlanningComponent."Reserved Qty. (Base)";
              QtyToReserve := PlanningComponent.Quantity;
              QtyToReserveBase := PlanningComponent."Quantity (Base)";
              QtyPerUOM := PlanningComponent."Qty. per Unit of Measure";
            END;
          DATABASE::"Transfer Line":
            BEGIN
              TransLine.FIND;
              IF ReservEntry."Source Subtype" = 0 THEN BEGIN // Outbound
                TransLine.CALCFIELDS("Reserved Quantity Outbnd.","Reserved Qty. Outbnd. (Base)");
                QtyReserved := TransLine."Reserved Quantity Outbnd.";
                QtyReservedBase := TransLine."Reserved Qty. Outbnd. (Base)";
                QtyToReserve := TransLine."Outstanding Quantity";
                QtyToReserveBase := TransLine."Outstanding Qty. (Base)";
              END ELSE BEGIN // Inbound
                TransLine.CALCFIELDS("Reserved Quantity Inbnd.","Reserved Qty. Inbnd. (Base)");
                QtyReserved := TransLine."Reserved Quantity Inbnd.";
                QtyReservedBase := TransLine."Reserved Qty. Inbnd. (Base)";
                QtyToReserve := TransLine."Outstanding Quantity";
                QtyToReserveBase := TransLine."Outstanding Qty. (Base)";
              END;
              QtyPerUOM := TransLine."Qty. per Unit of Measure";
            END;
          DATABASE::"Service Line":
            BEGIN
              ServiceLine.FIND;
              ServiceLine.CALCFIELDS("Reserved Quantity","Reserved Qty. (Base)");
              QtyReserved := ServiceLine."Reserved Quantity";
              QtyReservedBase := ServiceLine."Reserved Qty. (Base)";
              QtyToReserve := ServiceLine."Outstanding Quantity";
              QtyToReserveBase := ServiceLine."Outstanding Qty. (Base)";
              QtyPerUOM := ServiceLine."Qty. per Unit of Measure";
            END;
          DATABASE::"Job Planning Line":
            BEGIN
              JobPlanningLine.FIND;
              JobPlanningLine.CALCFIELDS("Reserved Quantity","Reserved Qty. (Base)");
              QtyReserved := JobPlanningLine."Reserved Quantity";
              QtyReservedBase := JobPlanningLine."Reserved Qty. (Base)";
              QtyToReserve := JobPlanningLine."Remaining Qty.";
              QtyToReserveBase := JobPlanningLine."Remaining Qty. (Base)";
              QtyPerUOM := JobPlanningLine."Qty. per Unit of Measure";
            END;
        END;
        #5..16
          QtyReservedIT := ROUND(QtyReservedBase / QtyPerUOM,0.00001);
          IF ABS(QtyReserved - QtyReservedIT) > 0.00001 THEN
            QtyReserved := QtyReservedIT;
          QtyToReserveBase := ItemTrackingQtyToReserveBase;
          IF ABS(ItemTrackingQtyToReserve - QtyToReserve) > 0.00001 THEN
        #22..27
        IF FormIsOpen THEN
          CurrPage.UPDATE;
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateReservMgt(PROCEDURE 7)".

    //procedure UpdateReservMgt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(ReservMgt);
        CASE ReservEntry."Source Type" OF
          DATABASE::"Sales Line":
        #4..23
            ReservMgt.SetServLine(ServiceLine);
          DATABASE::"Job Planning Line":
            ReservMgt.SetJobPlanningLine(JobPlanningLine);
          ELSE
            OnUpdateReservMgt(ReservEntry,ReservMgt);
        END;
        ReservMgt.SetSerialLotNo(ReservEntry."Serial No.",ReservEntry."Lot No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..26
        END;
        ReservMgt.SetSerialLotNo(ReservEntry."Serial No.",ReservEntry."Lot No.");
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "ReservedThisLine(PROCEDURE 14)".



    //Unsupported feature: Code Modification on "GetSerialLotNo(PROCEDURE 17)".

    //procedure GetSerialLotNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Item.GET(ReservEntry."Item No.");
        IF Item."Item Tracking Code" = '' THEN
          EXIT;
        ReservEntry2 := ReservEntry;
        ReservEntry2.SetPointerFilter;
        ItemTrackingMgt.SumUpItemTracking(ReservEntry2,TempTrackingSpecification,TRUE,TRUE);

        IF TempTrackingSpecification.FIND('-') THEN BEGIN
          IF NOT CONFIRM(STRSUBSTNO(Text006)) THEN
            EXIT;
          REPEAT
            TempReservEntry.TRANSFERFIELDS(TempTrackingSpecification);
        #13..15
          IF PAGE.RUNMODAL(PAGE::"Item Tracking List",TempReservEntry) = ACTION::LookupOK THEN BEGIN
            ReservEntry."Serial No." := TempReservEntry."Serial No.";
            ReservEntry."Lot No." := TempReservEntry."Lot No.";
            OnGetSerialLotNoOnAfterSetTrackingFields(ReservEntry,TempReservEntry);
            CaptionText += STRSUBSTNO(Text007,ReservEntry."Serial No.",ReservEntry."Lot No.");
            SignFactor := CreateReservEntry.SignFactor(TempReservEntry);
            ItemTrackingQtyToReserveBase := TempReservEntry."Quantity (Base)" * SignFactor;
            ItemTrackingQtyToReserve :=
              ROUND(ItemTrackingQtyToReserveBase / TempReservEntry."Qty. per Unit of Measure",UOMMgt.QtyRndPrecision);
            HandleItemTracking := TRUE;
          END ELSE
            ERROR(Text008);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        ReservMgt.SetPointerFilter(ReservEntry2);
        #6..8
          IF NOT CONFIRM(STRSUBSTNO(Text006))
          THEN
        #10..18
        #20..22
            ItemTrackingQtyToReserve := ROUND(ItemTrackingQtyToReserveBase / TempReservEntry."Qty. per Unit of Measure",0.00001);
        #25..28
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "AutoReserve(PROCEDURE 21)".


    //Unsupported feature: Deletion (VariableCollection) on "RelatesToSummEntry(PROCEDURE 5).IsHandled(Variable 1002)".


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
