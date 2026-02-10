#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185783 pageextension52185783 extends "Available - Purchase Lines" 
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
        modify("Expected Receipt Date")
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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Receipt Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outstanding Qty. (Base)"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Qty. (Base)"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyToReserveBase(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReservedThisLine(Control 19)".

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

            //Unsupported feature: Property Modification (Name) on "CancelReservation(Action 25)".

            ApplicationArea = Basic;
        }
        modify(ShowDocument)
        {

            //Unsupported feature: Property Modification (Name) on "ShowDocument(Action 21)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 6500)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reserve(Action 24)".


        //Unsupported feature: Code Modification on "CancelReservation(Action 25).OnAction".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "CancelReservation(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowDocument(Action 21)".

    }


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ReservEntry.TESTFIELD("Source Type");

        SETRANGE("Document Type",CurrentSubType);
        #4..21
            ELSE
              SETFILTER("Quantity (Base)",'>0');
        END;

        OnAfterOpenPage(Rec,ReservEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..24
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetSalesLine(PROCEDURE 24)".


    //Unsupported feature: Property Deletion (Attributes) on "SetReqLine(PROCEDURE 23)".


    //Unsupported feature: Property Deletion (Attributes) on "SetPurchLine(PROCEDURE 22)".


    //Unsupported feature: Property Deletion (Attributes) on "SetProdOrderLine(PROCEDURE 19)".


    //Unsupported feature: Property Deletion (Attributes) on "SetProdOrderComponent(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetPlanningComponent(PROCEDURE 15)".


    //Unsupported feature: Property Deletion (Attributes) on "SetTransferLine(PROCEDURE 16)".


    //Unsupported feature: Property Deletion (Attributes) on "SetServiceInvLine(PROCEDURE 8)".


    //Unsupported feature: Property Deletion (Attributes) on "SetJobPlanningLine(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "CreateReservation(PROCEDURE 14)".

    //procedure CreateReservation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CALCFIELDS("Reserved Qty. (Base)");
        IF (ABS("Outstanding Qty. (Base)") - ABS("Reserved Qty. (Base)")) < ReserveQuantityBase THEN
          ERROR(Text003,ABS("Outstanding Qty. (Base)") - "Reserved Qty. (Base)");
        #4..8
        TESTFIELD("Location Code",ReservEntry."Location Code");

        UpdateReservMgt;
        TrackingSpecification.InitTrackingSpecification2(
          DATABASE::"Purchase Line","Document Type","Document No.",'',0,"Line No.",
          "Variant Code","Location Code","Qty. per Unit of Measure");
        ReservMgt.CreateReservation(
          ReservEntry.Description,"Expected Receipt Date",ReservedQuantity,ReserveQuantityBase,TrackingSpecification);
        UpdateReservFrom;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..11
        ReservMgt.CreateTrackingSpecification(TrackingSpecification,
          DATABASE::"Purchase Line","Document Type","Document No.",'',0,"Line No.",
          "Variant Code","Location Code",'','',"Qty. per Unit of Measure");
        #15..17
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
        #4..17
            ReservMgt.SetServLine(ServiceInvLine);
          DATABASE::"Job Planning Line":
            ReservMgt.SetJobPlanningLine(JobPlanningLine);
          DATABASE::"Assembly Line":
            ReservMgt.SetAssemblyLine(AssemblyLine);
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


    //Unsupported feature: Code Modification on "ReservedThisLine(PROCEDURE 2)".

    //procedure ReservedThisLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ReservEntry2.RESET;
        IF ReservEntry."Source Type" = DATABASE::"Transfer Line" THEN
          ReservEntry."Source Subtype" := Direction;
        OnBeforeFilterReservEntry(ReservEntry,Direction);
        ReservePurchLine.FilterReservFor(ReservEntry2,Rec);
        ReservEntry2.SETRANGE("Reservation Status",ReservEntry2."Reservation Status"::Reservation);
        EXIT(ReservMgt.MarkReservConnection(ReservEntry2,ReservEntry));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        #5..7
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetCurrentSubType(PROCEDURE 9)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyLine(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyHeader(PROCEDURE 7)".

}
