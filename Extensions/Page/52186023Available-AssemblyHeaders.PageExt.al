#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186023 pageextension52186023 extends "Available - Assembly Headers" 
{
    layout
    {
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Reserved Qty. (Base)")
        {
            ApplicationArea = Basic;
        }
        modify(QtyToReserveBase)
        {
            ApplicationArea = Basic;
        }
        
        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Quantity"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Qty. (Base)"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyToReserveBase(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReservedThisLine(Control 19)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Item &Tracking Lines")
        {
            ApplicationArea = Basic;
        }
        modify(Reserve)
        {
            ApplicationArea = Basic;
        }
        modify(CancelReservation)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reserve(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CancelReservation(Action 5)".

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

        SETRANGE("Document Type",CurrentSubType);
        SETRANGE("Item No.",ReservEntry."Item No.");
        SETRANGE("Variant Code",ReservEntry."Variant Code");
        SETRANGE("Location Code",ReservEntry."Location Code");
        SETFILTER("Due Date",ReservMgt.GetAvailabilityFilter(ReservEntry."Shipment Date"));
        IF ReservMgt.IsPositive THEN
          SETFILTER("Remaining Quantity (Base)",'>0')
        ELSE
          SETFILTER("Remaining Quantity (Base)",'<0');
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetSalesLine(PROCEDURE 24)".


    //Unsupported feature: Property Deletion (Attributes) on "SetReqLine(PROCEDURE 23)".


    //Unsupported feature: Property Deletion (Attributes) on "SetPurchLine(PROCEDURE 22)".


    //Unsupported feature: Property Deletion (Attributes) on "SetProdOrderLine(PROCEDURE 19)".


    //Unsupported feature: Property Deletion (Attributes) on "SetProdOrderComponent(PROCEDURE 18)".


    //Unsupported feature: Property Deletion (Attributes) on "SetPlanningComponent(PROCEDURE 15)".


    //Unsupported feature: Property Deletion (Attributes) on "SetTransferLine(PROCEDURE 16)".


    //Unsupported feature: Property Deletion (Attributes) on "SetServiceInvLine(PROCEDURE 8)".


    //Unsupported feature: Property Deletion (Attributes) on "SetJobPlanningLine(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyHeader(PROCEDURE 7)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyLine(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "CreateReservation(PROCEDURE 14)".

    //procedure CreateReservation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CALCFIELDS("Reserved Qty. (Base)");

        IF "Remaining Quantity (Base)" + "Reserved Qty. (Base)" < ReserveQuantityBase THEN
        #4..7
        TESTFIELD("Location Code",ReservEntry."Location Code");

        UpdateReservMgt;
        TrackingSpecification.InitTrackingSpecification2(
          DATABASE::"Assembly Header","Document Type","No." ,'',0,0,"Variant Code","Location Code","Qty. per Unit of Measure");
        ReservMgt.CreateReservation(
          ReservEntry.Description,"Due Date",ReserveQuantity,ReserveQuantityBase,TrackingSpecification);
        UpdateReservFrom;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..10
        ReservMgt.CreateTrackingSpecification(TrackingSpecification,
          DATABASE::"Assembly Header","Document Type","No." ,'',0,0,
          "Variant Code","Location Code",'','',"Qty. per Unit of Measure");
        #13..15
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
        #4..44
              SetJobPlanningLine(JobPlanningLine,ReservEntry);
            END;
        END;

        OnAfterUpdateReservFrom;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..47
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
        #4..15
            ReservMgt.SetTransferLine(TransLine,ReservEntry."Source Subtype");
          DATABASE::"Service Line":
            ReservMgt.SetServLine(ServiceLine);
          DATABASE::"Job Planning Line":
            ReservMgt.SetJobPlanningLine(JobPlanningLine);
          DATABASE::"Assembly Line":
            ReservMgt.SetAssemblyLine(AssemblyLine);
        END;

        OnAfterUpdateReservMgt;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..18
        #21..23
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetCurrentSubType(PROCEDURE 9)".

}
