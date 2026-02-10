#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186576 pageextension52186576 extends "Item Charge Assignment (Sales)" 
{
    layout
    {
        modify("Applies-to Doc. Type")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Doc. No.")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Doc. Line No.")
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Assign")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. Assigned")
        {
            ApplicationArea = Basic;
        }
        modify("Amount to Assign")
        {
            ApplicationArea = Basic;
        }
        modify(QtyToShipBase)
        {
            ApplicationArea = Basic;
        }
        modify(QtyShippedBase)
        {
            ApplicationArea = Basic;
        }
        modify(QtyToRetReceiveBase)
        {
            ApplicationArea = Basic;
        }
        modify(QtyRetReceivedBase)
        {
            ApplicationArea = Basic;
        }
        modify(AssignableQty)
        {
            ApplicationArea = Basic;
        }
        modify(AssignableAmount)
        {
            ApplicationArea = Basic;
        }
        modify(TotalQtyToAssign)
        {
            ApplicationArea = Basic;
        }
        modify(TotalAmountToAssign)
        {
            ApplicationArea = Basic;
        }
        modify(RemQtyToAssign)
        {
            ApplicationArea = Basic;
        }
        modify(RemAmountToAssign)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Doc. Type"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Doc. No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Doc. Line No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Assign"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Assigned"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount to Assign"(Control 18)".

        modify(GrossWeight)
        {
            Visible = false;
        }
        modify(UnitVolume)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "QtyToShipBase(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyShippedBase(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyToRetReceiveBase(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyRetReceivedBase(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AssignableQty(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AssignableAmount(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalQtyToAssign(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalAmountToAssign(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RemQtyToAssign(Control 23)".


        //Unsupported feature: Property Deletion (Style) on "RemQtyToAssign(Control 23)".


        //Unsupported feature: Property Deletion (StyleExpr) on "RemQtyToAssign(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RemAmountToAssign(Control 30)".


        //Unsupported feature: Property Deletion (Style) on "RemAmountToAssign(Control 30)".


        //Unsupported feature: Property Deletion (StyleExpr) on "RemAmountToAssign(Control 30)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(GetShipmentLines)
        {
            ApplicationArea = Basic;
        }
        modify(GetReturnReceiptLines)
        {
            ApplicationArea = Basic;
        }
        modify(SuggestItemChargeAssignment)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "GetShipmentLines(Action 20).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            SalesLine2.TESTFIELD("Qty. to Invoice");

            ItemChargeAssgntSales.SETRANGE("Document Type","Document Type");
            ItemChargeAssgntSales.SETRANGE("Document No.","Document No.");
            ItemChargeAssgntSales.SETRANGE("Document Line No.","Document Line No.");
            #6..11

            ShipmentLines.LOOKUPMODE(TRUE);
            ShipmentLines.RUNMODAL;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #3..14
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "GetShipmentLines(Action 20)".


        //Unsupported feature: Property Deletion (Promoted) on "GetShipmentLines(Action 20)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "GetShipmentLines(Action 20)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "GetShipmentLines(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetReturnReceiptLines(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SuggestItemChargeAssignment(Action 33)".


        //Unsupported feature: Property Deletion (Promoted) on "SuggestItemChargeAssignment(Action 33)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "SuggestItemChargeAssignment(Action 33)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "SuggestItemChargeAssignment(Action 33)".

    }


    //Unsupported feature: Code Modification on "UpdateQtyAssgnt(PROCEDURE 2)".

    //procedure UpdateQtyAssgnt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesLine2.CALCFIELDS("Qty. to Assign","Qty. Assigned");
        AssignableQty := SalesLine2."Qty. to Invoice" + SalesLine2."Quantity Invoiced" - SalesLine2."Qty. Assigned";
        OnUpdateQtyAssgntOnAfterAssignableQty(SalesLine2,AssignableQty);

        IF AssignableQty <> 0 THEN
          UnitCost := AssignableAmount / AssignableQty
        #7..17

        RemQtyToAssign := AssignableQty - TotalQtyToAssign;
        RemAmountToAssign := AssignableAmount - TotalAmountToAssign;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SalesLine2.CALCFIELDS("Qty. to Assign","Qty. Assigned");
        AssignableQty := SalesLine2."Qty. to Invoice" + SalesLine2."Quantity Invoiced" -
          SalesLine2."Qty. Assigned";
        #4..20
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateQty(PROCEDURE 1)".

    //procedure UpdateQty();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE "Applies-to Doc. Type" OF
          "Applies-to Doc. Type"::Order,"Applies-to Doc. Type"::Invoice:
            BEGIN
              SalesLine.GET("Applies-to Doc. Type","Applies-to Doc. No.","Applies-to Doc. Line No.");
              QtyToShipBase := SalesLine."Qty. to Ship (Base)";
              QtyShippedBase := SalesLine."Qty. Shipped (Base)";
              QtyToRetReceiveBase := 0;
              QtyRetReceivedBase := 0;
              GrossWeight := SalesLine."Gross Weight";
              UnitVolume := SalesLine."Unit Volume";
            END;
          "Applies-to Doc. Type"::"Return Order","Applies-to Doc. Type"::"Credit Memo":
            BEGIN
              SalesLine.GET("Applies-to Doc. Type","Applies-to Doc. No.","Applies-to Doc. Line No.");
              QtyToRetReceiveBase := SalesLine."Return Qty. to Receive (Base)";
              QtyRetReceivedBase := SalesLine."Return Qty. Received (Base)";
              QtyToShipBase := 0;
              QtyShippedBase := 0;
              GrossWeight := SalesLine."Gross Weight";
              UnitVolume := SalesLine."Unit Volume";
            END;
          "Applies-to Doc. Type"::"Return Receipt":
            BEGIN
              ReturnRcptLine.GET("Applies-to Doc. No.","Applies-to Doc. Line No.");
              QtyToRetReceiveBase := 0;
              QtyRetReceivedBase := ReturnRcptLine."Quantity (Base)";
              QtyToShipBase := 0;
              QtyShippedBase := 0;
              GrossWeight := SalesLine."Gross Weight";
              UnitVolume := SalesLine."Unit Volume";
            END;
          "Applies-to Doc. Type"::Shipment:
            BEGIN
              SalesShptLine.GET("Applies-to Doc. No.","Applies-to Doc. Line No.");
              QtyToRetReceiveBase := 0;
              QtyRetReceivedBase := 0;
              QtyToShipBase := 0;
              QtyShippedBase := SalesShptLine."Quantity (Base)";
              GrossWeight := SalesLine."Gross Weight";
              UnitVolume := SalesLine."Unit Volume";
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
        #11..18
        #21..28
        #31..38
            END;
        END;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Initialize(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "QtytoAssignOnAfterValidate(PROCEDURE 19000177)".

    //procedure QtytoAssignOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrPage.UPDATE(FALSE);
        UpdateQtyAssgnt;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CurrPage.UPDATE(TRUE);
        UpdateQtyAssgnt;
        */
    //end;

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
