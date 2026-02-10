#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186752 pageextension52186752 extends "Avail. - Item Tracking Lines" 
{
    layout
    {
        modify("Reservation Status")
        {
            ApplicationArea = Basic;
        }
        modify(TextCaption)
        {
            ApplicationArea = Basic;
        }
        modify("Source Type")
        {
            ApplicationArea = Basic;
        }
        modify("Source ID")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
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
        modify("Expected Receipt Date")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity (Base)")
        {
            ApplicationArea = Basic;
        }
        modify(ReservedQtyBase)
        {
            ApplicationArea = Basic;
        }
        modify(QtyToReserve)
        {
            ApplicationArea = Basic;
        }
        modify(ReservedThisLine)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Reservation Status"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TextCaption(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Type"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source ID"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lot No."(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Receipt Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity (Base)"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReservedQtyBase(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyToReserve(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReservedThisLine(Control 19)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("&Show Document")
        {
            ApplicationArea = Basic;
        }
        modify("&Cancel Reservation")
        {
            ApplicationArea = Basic;
        }
        modify(Action36)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Show Document"(Action 21)".


        //Unsupported feature: Code Modification on ""&Cancel Reservation"(Action 35).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF NOT EnableReservations THEN
              EXIT;
            IF NOT ConfirmManagement.ConfirmProcess(Text001,TRUE) THEN
              EXIT;
            ReservEngineMgt.CancelReservation(Rec);
            UpdateReservFrom;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF NOT EnableReservations THEN
              EXIT;
            IF NOT CONFIRM(Text001,FALSE) THEN
            #4..6
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Cancel Reservation"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action36(Action 36)".

    }


    //Unsupported feature: Property Modification (Id) on "FunctionButton1Visible(Variable 8739)".

    //var
        //>>>> ORIGINAL VALUE:
        //FunctionButton1Visible : 8739;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //FunctionButton1Visible : 19004938;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "FunctionButton2Visible(Variable 9714)".

    //var
        //>>>> ORIGINAL VALUE:
        //FunctionButton2Visible : 9714;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //FunctionButton2Visible : 19075899;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (Attributes) on "SetSalesLine(PROCEDURE 24)".


    //Unsupported feature: Property Deletion (Attributes) on "SetReqLine(PROCEDURE 23)".


    //Unsupported feature: Property Deletion (Attributes) on "SetPurchLine(PROCEDURE 22)".


    //Unsupported feature: Property Deletion (Attributes) on "SetItemJnlLine(PROCEDURE 21)".


    //Unsupported feature: Property Deletion (Attributes) on "SetProdOrderLine(PROCEDURE 19)".


    //Unsupported feature: Property Deletion (Attributes) on "SetProdOrderComponent(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetPlanningComponent(PROCEDURE 15)".


    //Unsupported feature: Property Deletion (Attributes) on "SetTransferLine(PROCEDURE 16)".


    //Unsupported feature: Property Deletion (Attributes) on "SetServiceInvLine(PROCEDURE 8)".


    //Unsupported feature: Property Deletion (Attributes) on "SetJobPlanningLine(PROCEDURE 9)".


    //Unsupported feature: Property Deletion (Attributes) on "SetItemTrackingLine(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyLine(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAssemblyHeader(PROCEDURE 7)".


    local procedure CreateReservation(ReserveQuantity: Decimal)
    begin
    end;

    local procedure UpdateReservMgt()
    begin
        // Clear(ReservMgt);
        // case ReservEntry."Source Type" of
        //   Database::"Sales Line":
        //     ReservMgt.SetSalesLine(SalesLine);
        //   Database::"Requisition Line":
        //     ReservMgt.SetReqLine(ReqLine);
        //   Database::"Purchase Line":
        //     ReservMgt.SetPurchLine(PurchLine);
        //   Database::"Item Journal Line":
        //     ReservMgt.SetItemJnlLine(ItemJnlLine);
        //   Database::"Prod. Order Line":
        //     ReservMgt.SetProdOrderLine(ProdOrderLine);
        //   Database::"Prod. Order Component":
        //     ReservMgt.SetProdOrderComponent(ProdOrderComp);
        //   Database::"Planning Component":
        //     ReservMgt.SetPlanningComponent(PlanningComponent);
        //   Database::"Transfer Line":
        //     ReservMgt.SetTransferLine(TransLine,ReservEntry."Source Subtype");
        //   Database::"Service Line":
        //     ReservMgt.SetServLine(ServiceInvLine);
        //   Database::"Job Planning Line":
        //     ReservMgt.SetJobPlanningLine(JobPlanningLine);
        // end;
    end;
}
