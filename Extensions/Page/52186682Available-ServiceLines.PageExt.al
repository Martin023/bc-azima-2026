#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186682 pageextension52186682 extends "Available - Service Lines" 
{
    layout
    {
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Needed by Date")
        {
            ApplicationArea = Basic;
        }
        modify("Outstanding Qty. (Base)")
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Needed by Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outstanding Qty. (Base)"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Qty. (Base)"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyToReserveBase(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReservedThisLine(Control 19)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

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

            //Unsupported feature: Property Modification (Name) on "CancelReservation(Action 23)".

            ApplicationArea = Basic;
        }
        modify(ShowDocument)
        {

            //Unsupported feature: Property Modification (Name) on "ShowDocument(Action 24)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Reserve(Action 22)".


        //Unsupported feature: Code Modification on "CancelReservation(Action 23).OnAction".

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

        SETRANGE(Type,Type::Item);
        SETRANGE("No.",ReservEntry."Item No.");
        SETRANGE("Variant Code",ReservEntry."Variant Code");
        SETRANGE("Location Code",ReservEntry."Location Code");

        SETFILTER("Needed by Date",ReservMgt.GetAvailabilityFilter(ReservEntry."Shipment Date"));

        CASE ReservEntry."Source Subtype" OF
          0,1,2,4:
            IF ReservMgt.IsPositive THEN
              SETFILTER("Quantity (Base)",'<0')
            ELSE
              SETFILTER("Quantity (Base)",'>0');
          3:
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


    //Unsupported feature: Property Deletion (Attributes) on "SetTransferLine(PROCEDURE 9)".


    //Unsupported feature: Property Deletion (Attributes) on "SetServInvLine(PROCEDURE 8)".


    //Unsupported feature: Property Deletion (Attributes) on "SetJobPlanningLine(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "CreateReservation(PROCEDURE 6)".

    //procedure CreateReservation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ABS("Outstanding Qty. (Base)") + "Reserved Qty. (Base)" < ReserveQuantityBase THEN
          ERROR(Text002,ABS("Outstanding Qty. (Base)") + "Reserved Qty. (Base)");

        TESTFIELD(Type,Type::Item);
        TESTFIELD("No.",ReservEntry."Item No.");
        TESTFIELD("Variant Code",ReservEntry."Variant Code");
        TESTFIELD("Location Code",ReservEntry."Location Code");

        TrackingSpecification.InitTrackingSpecification2(
          DATABASE::"Service Line","Document Type","Document No.",'',0,"Line No.",
          "Variant Code","Location Code","Qty. per Unit of Measure");
        ReservMgt.CreateReservation(
          ReservEntry.Description,"Posting Date",ReserveQuantity,ReserveQuantityBase,TrackingSpecification);
        UpdateReservFrom;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
        ReservMgt.CreateTrackingSpecification(TrackingSpecification,
          DATABASE::"Service Line","Document Type","Document No.",'',0,"Line No.",
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
        #4..15
            ReservMgt.SetTransferLine(TransLine,ReservEntry."Source Subtype");
          DATABASE::"Service Line":
            ReservMgt.SetServLine(ServInvLine);
          DATABASE::"Assembly Header":
            ReservMgt.SetAssemblyHeader(AssemblyHeader);
        END;

        OnAfterUpdateReservMgt;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..18
        END;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetCurrentSubType(PROCEDURE 11)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyLine(PROCEDURE 14)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyHeader(PROCEDURE 12)".

}
