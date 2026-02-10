#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185781 pageextension52185781 extends "Available - Sales Lines" 
{
    layout
    {
        modify("Document Type")
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
        modify("Shipment Date")
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outstanding Qty. (Base)"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Qty. (Base)"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyToReserveBase(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReservedThisLine(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 25)".

    }
    actions
    {
        modify(Reserve)
        {
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

        SETRANGE("Document Type",CurrentSubType);
        SETRANGE(Type,Type::Item);
        SETRANGE("No.",ReservEntry."Item No.");
        SETRANGE("Variant Code",ReservEntry."Variant Code");
        SETRANGE("Job No.",'');
        SETRANGE("Drop Shipment",FALSE);
        SETRANGE("Location Code",ReservEntry."Location Code");

        SETFILTER("Shipment Date",ReservMgt.GetAvailabilityFilter(ReservEntry."Shipment Date"));

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


    //Unsupported feature: Property Deletion (Attributes) on "SetServiceInvLine(PROCEDURE 8)".


    //Unsupported feature: Property Deletion (Attributes) on "SetJobPlanningLine(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "CreateReservation(PROCEDURE 6)".

    //procedure CreateReservation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ABS("Outstanding Qty. (Base)") + "Reserved Qty. (Base)" < ReserveQuantityBase THEN
          ERROR(Text003,ABS("Outstanding Qty. (Base)") + "Reserved Qty. (Base)");

        #4..6
        TESTFIELD("Variant Code",ReservEntry."Variant Code");
        TESTFIELD("Location Code",ReservEntry."Location Code");

        TrackingSpecification.InitTrackingSpecification2(
          DATABASE::"Sales Line","Document Type","Document No.",'',0,"Line No.",
          "Variant Code","Location Code","Qty. per Unit of Measure");
        ReservMgt.CreateReservation(
          ReservEntry.Description,"Shipment Date",ReserveQuantity,ReserveQuantityBase,TrackingSpecification);
        UpdateReservFrom;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
        ReservMgt.CreateTrackingSpecification(TrackingSpecification,
          DATABASE::"Sales Line","Document Type","Document No.",'',0,"Line No.",
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


    //Unsupported feature: Code Modification on "UpdateReservMgt(PROCEDURE 7)".

    //procedure UpdateReservMgt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(ReservMgt);
        CASE ReservEntry."Source Type" OF
          DATABASE::"Sales Line":
        #4..9
            ReservMgt.SetProdOrderLine(ProdOrderLine);
          DATABASE::"Prod. Order Component":
            ReservMgt.SetProdOrderComponent(ProdOrderComp);
          DATABASE::"Assembly Header":
            ReservMgt.SetAssemblyHeader(AssemblyHeader);
          DATABASE::"Assembly Line":
            ReservMgt.SetAssemblyLine(AssemblyLine);
          DATABASE::"Planning Component":
            ReservMgt.SetPlanningComponent(PlanningComponent);
          DATABASE::"Transfer Line":
        #20..22
          DATABASE::"Job Planning Line":
            ReservMgt.SetJobPlanningLine(JobPlanningLine);
        END;

        OnAfterUpdateReservMgt;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..12
        #17..25
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetCurrentSubType(PROCEDURE 9)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyLine(PROCEDURE 12)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyHeader(PROCEDURE 11)".

}
