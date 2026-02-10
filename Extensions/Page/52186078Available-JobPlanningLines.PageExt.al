#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186078 pageextension52186078 extends "Available - Job Planning Lines" 
{
    layout
    {
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Planning Date")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Qty. (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Reserved Quantity")
        {
            ApplicationArea = Basic;
        }
        modify(QtyToReserveBase)
        {
            ApplicationArea = Basic;
        }
        modify("Work Type Code")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Planning Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Qty. (Base)"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Quantity"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyToReserveBase(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReservedThisLine(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 25)".

    }
    actions
    {
        modify(Reserve)
        {

            //Unsupported feature: Property Modification (Name) on "Reserve(Action 22)".

            ApplicationArea = Basic;
        }
        modify(CancelReservation)
        {
            ApplicationArea = Basic;
        }
        modify(ShowDocument)
        {

            //Unsupported feature: Property Modification (Name) on "ShowDocument(Action 24)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Reserve(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CancelReservation(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowDocument(Action 24)".

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

        SETRANGE(Status,CurrentSubType);
        SETRANGE(Type,Type::Item);
        SETRANGE("No.",ReservEntry."Item No.");
        SETRANGE("Variant Code",ReservEntry."Variant Code");
        SETRANGE("Location Code",ReservEntry."Location Code");

        SETFILTER("Planning Date",ReservMgt.GetAvailabilityFilter(ReservEntry."Shipment Date"));

        CASE CurrentSubType OF
          0,1,2,4:
            IF ReservMgt.IsPositive THEN
              SETFILTER("Quantity (Base)",'<0')
            ELSE
              SETFILTER("Quantity (Base)",'>0');
          3,5:
            IF NOT ReservMgt.IsPositive THEN
              SETFILTER("Quantity (Base)",'<0')
            ELSE
              SETFILTER("Quantity (Base)",'>0');
        END;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetSalesLine(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetReqLine(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "SetPurchLine(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "SetProdOrderLine(PROCEDURE 16)".


    //Unsupported feature: Property Deletion (Attributes) on "SetProdOrderComponent(PROCEDURE 15)".


    //Unsupported feature: Property Deletion (Attributes) on "SetPlanningComponent(PROCEDURE 13)".


    //Unsupported feature: Property Deletion (Attributes) on "SetTransferLine(PROCEDURE 14)".


    //Unsupported feature: Property Deletion (Attributes) on "SetServLine(PROCEDURE 8)".


    //Unsupported feature: Property Deletion (Attributes) on "SetJobPlanningLine(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "CreateReservation(PROCEDURE 6)".

    //procedure CreateReservation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CALCFIELDS("Reserved Qty. (Base)");
        IF ABS("Remaining Qty. (Base)") + "Reserved Qty. (Base)" < ReserveQuantityBase THEN
          ERROR(Text003,ABS("Remaining Qty. (Base)") + "Reserved Quantity");

        TESTFIELD("No.",ReservEntry."Item No.");
        TESTFIELD("Variant Code",ReservEntry."Variant Code");
        TESTFIELD("Location Code",ReservEntry."Location Code");

        TrackingSpecification.InitTrackingSpecification2(
          DATABASE::"Job Planning Line",Status,"Job No.",'',0,"Job Contract Entry No.",
          "Variant Code","Location Code","Qty. per Unit of Measure");
        ReservMgt.CreateReservation(
          ReservEntry.Description,"Planning Date",ReserveQuantity,ReserveQuantityBase,TrackingSpecification);
        UpdateReservFrom;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
        ReservMgt.CreateTrackingSpecification(TrackingSpecification,
          DATABASE::"Job Planning Line",Status,"Job No.",'',0,"Job Contract Entry No.",
          "Variant Code","Location Code",'','',"Qty. per Unit of Measure");
        #12..14
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


    //Unsupported feature: Code Modification on "UpdateReservMgt(PROCEDURE 7)".

    //procedure UpdateReservMgt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(ReservMgt);
        CASE ReservEntry."Source Type" OF
          DATABASE::"Sales Line":
        #4..17
            ReservMgt.SetServLine(ServLine);
          DATABASE::"Job Planning Line":
            ReservMgt.SetJobPlanningLine(JobPlanningLine);
          DATABASE::"Assembly Header":
            ReservMgt.SetAssemblyHeader(AssemblyHeader);
        END;

        OnAfterUpdateReservMgt;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..20
        END;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetCurrentSubType(PROCEDURE 9)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyLine(PROCEDURE 12)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyHeader(PROCEDURE 11)".

}
