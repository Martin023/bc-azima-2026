#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185782 pageextension52185782 extends "Available - Requisition Lines" 
{
    layout
    {
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity (Base)")
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



        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity (Base)"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Qty. (Base)"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyToReserveBase(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReservedThisLine(Control 19)".

    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("&Reserve")
        {
            ApplicationArea = Basic;
        }
        modify("&Cancel Reservation")
        {
            ApplicationArea = Basic;
        }
        modify("&Show Entire Worksheet")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Reserve"(Action 4)".


        //Unsupported feature: Code Modification on ""&Cancel Reservation"(Action 5).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF NOT ConfirmManagement.ConfirmProcess(Text001,TRUE) THEN
              EXIT;

            ReservEntry2.COPY(ReservEntry);
            #5..11

              UpdateReservFrom;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF NOT CONFIRM(Text001,FALSE) THEN
            #2..14
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Cancel Reservation"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Show Entire Worksheet"(Action 2)".

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

        SETRANGE(Type,Type::Item);
        SETRANGE("No.",ReservEntry."Item No.");
        SETRANGE("Variant Code",ReservEntry."Variant Code");
        SETRANGE("Location Code",ReservEntry."Location Code");

        SETFILTER("Due Date",ReservMgt.GetAvailabilityFilter(ReservEntry."Shipment Date"));
        IF ReservMgt.IsPositive THEN
          SETFILTER("Quantity (Base)",'>0')
        ELSE
          SETFILTER("Quantity (Base)",'<0');

        SETRANGE("Sales Order No.",'');
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetSalesLine(PROCEDURE 24)".


    //Unsupported feature: Property Deletion (Attributes) on "SetReqLine(PROCEDURE 23)".


    //Unsupported feature: Property Deletion (Attributes) on "SetPurchLine(PROCEDURE 22)".


    //Unsupported feature: Property Deletion (Attributes) on "SetProdOrderLine(PROCEDURE 19)".


    //Unsupported feature: Property Deletion (Attributes) on "SetProdOrderComponent(PROCEDURE 18)".


    //Unsupported feature: Property Deletion (Attributes) on "SetPlanningComponent(PROCEDURE 15)".


    //Unsupported feature: Property Deletion (Attributes) on "SetTransferLine(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "SetServiceInvLine(PROCEDURE 8)".


    //Unsupported feature: Property Deletion (Attributes) on "SetJobPlanningLine(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "CreateReservation(PROCEDURE 14)".

    //procedure CreateReservation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CALCFIELDS("Reserved Qty. (Base)");
        IF "Quantity (Base)" - "Reserved Qty. (Base)" < ReserveQuantityBase THEN
          ERROR(Text003,"Quantity (Base)" + "Reserved Qty. (Base)");
        #4..6
        TESTFIELD("Location Code",ReservEntry."Location Code");

        UpdateReservMgt;
        TrackingSpecification.InitTrackingSpecification2(
          DATABASE::"Requisition Line",0,"Worksheet Template Name","Journal Batch Name",0,"Line No.",
          "Variant Code","Location Code","Qty. per Unit of Measure");
        ReservMgt.CreateReservation(
          ReservEntry.Description,"Due Date",ReserveQuantity,ReserveQuantityBase,TrackingSpecification);
        UpdateReservFrom;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
        ReservMgt.CreateTrackingSpecification(TrackingSpecification,
          DATABASE::"Requisition Line",0,"Worksheet Template Name","Journal Batch Name",0,"Line No.",
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
        #4..18
          DATABASE::"Job Planning Line":
            ReservMgt.SetJobPlanningLine(JobPlanningLine);
        END;

        OnAfterUpdateReservMgt;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..21
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyLine(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyHeader(PROCEDURE 7)".

}
