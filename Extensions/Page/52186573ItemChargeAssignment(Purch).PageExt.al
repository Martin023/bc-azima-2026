#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186573 pageextension52186573 extends "Item Charge Assignment (Purch)" 
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
        modify(QtyToReceiveBase)
        {
            ApplicationArea = Basic;
        }
        modify(QtyReceivedBase)
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
        modify(AssignableQty)
        {
            ApplicationArea = Basic;
        }
        modify(AssgntAmount)
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

        modify("<Gross Weight>")
        {
            Visible = false;
        }
        modify("<Unit Volume>")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "QtyToReceiveBase(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyReceivedBase(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyToShipBase(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyShippedBase(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AssignableQty(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AssgntAmount(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalQtyToAssign(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalAmountToAssign(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RemQtyToAssign(Control 27)".


        //Unsupported feature: Property Deletion (Style) on "RemQtyToAssign(Control 27)".


        //Unsupported feature: Property Deletion (StyleExpr) on "RemQtyToAssign(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RemAmountToAssign(Control 32)".


        //Unsupported feature: Property Deletion (Style) on "RemAmountToAssign(Control 32)".


        //Unsupported feature: Property Deletion (StyleExpr) on "RemAmountToAssign(Control 32)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(GetReceiptLines)
        {
            ApplicationArea = Basic;
        }
        modify(GetTransferReceiptLines)
        {
            ApplicationArea = Basic;
        }
        modify(GetReturnShipmentLines)
        {
            ApplicationArea = Basic;
        }
        modify(GetSalesShipmentLines)
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

        //Unsupported feature: Code Modification on "GetReceiptLines(Action 20).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            PurchLine2.TESTFIELD("Qty. to Invoice");

            ItemChargeAssgntPurch.SETRANGE("Document Type","Document Type");
            ItemChargeAssgntPurch.SETRANGE("Document No.","Document No.");
            ItemChargeAssgntPurch.SETRANGE("Document Line No.","Document Line No.");
            #6..11

            ReceiptLines.LOOKUPMODE(TRUE);
            ReceiptLines.RUNMODAL;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #3..14
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "GetReceiptLines(Action 20)".


        //Unsupported feature: Property Deletion (Promoted) on "GetReceiptLines(Action 20)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "GetReceiptLines(Action 20)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "GetReceiptLines(Action 20)".



        //Unsupported feature: Code Modification on "GetTransferReceiptLines(Action 42).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ItemChargeAssgntPurch.SETRANGE("Document Type","Document Type");
            ItemChargeAssgntPurch.SETRANGE("Document No.","Document No.");
            ItemChargeAssgntPurch.SETRANGE("Document Line No.","Document Line No.");

            TransferRcptLine.FILTERGROUP(2);
            TransferRcptLine.SETFILTER("Item No.",'<>%1','');
            TransferRcptLine.SETFILTER(Quantity,'<>0');
            TransferRcptLine.FILTERGROUP(0);

            PostedTransferReceiptLines.SETTABLEVIEW(TransferRcptLine);
            IF ItemChargeAssgntPurch.FINDLAST THEN
              PostedTransferReceiptLines.Initialize(ItemChargeAssgntPurch,PurchLine2."Unit Cost")
            ELSE
              PostedTransferReceiptLines.Initialize(Rec,PurchLine2."Unit Cost");

            PostedTransferReceiptLines.LOOKUPMODE(TRUE);
            PostedTransferReceiptLines.RUNMODAL;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
            #10..17
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "GetTransferReceiptLines(Action 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetReturnShipmentLines(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetSalesShipmentLines(Action 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetReturnReceiptLines(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SuggestItemChargeAssignment(Action 41)".


        //Unsupported feature: Property Deletion (Promoted) on "SuggestItemChargeAssignment(Action 41)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "SuggestItemChargeAssignment(Action 41)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "SuggestItemChargeAssignment(Action 41)".

    }


    //Unsupported feature: Property Modification (TextConstString) on "Text001(Variable 1020)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text001 : @@@="%2 = Document Type, %3 = Document No.";ENU=The remaining amount to assign is %1. It must be zero before you can post %2 %3.\ \Are you sure that you want to close the window?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text001 : @@@="%2 = Document Type, %3 = Document No.";ENU=The Rem. to Assign amount is %1. It must be zero before you can post %2 %3.\ \Are you sure that you want to close the window?;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnQueryClosePage".

    //trigger OnQueryClosePage(CloseAction: Action): Boolean
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF RemAmountToAssign <> 0 THEN
          IF NOT ConfirmManagement.ConfirmProcess(
               STRSUBSTNO(Text001,RemAmountToAssign,"Document Type","Document No."),TRUE)
          THEN
            EXIT(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF RemAmountToAssign <> 0 THEN
          IF NOT CONFIRM(Text001,FALSE,RemAmountToAssign,"Document Type","Document No.") THEN
            EXIT(FALSE);
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateQtyAssgnt(PROCEDURE 2)".

    //procedure UpdateQtyAssgnt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PurchLine2.CALCFIELDS("Qty. to Assign","Qty. Assigned");
        AssignableQty :=
          PurchLine2."Qty. to Invoice" + PurchLine2."Quantity Invoiced" - PurchLine2."Qty. Assigned";

        ItemChargeAssgntPurch.RESET;
        ItemChargeAssgntPurch.SETCURRENTKEY("Document Type","Document No.","Document Line No.");
        #7..12

        RemQtyToAssign := AssignableQty - TotalQtyToAssign;
        RemAmountToAssign := AssgntAmount - TotalAmountToAssign;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        PurchLine2.CALCFIELDS("Qty. to Assign","Qty. Assigned");
        AssignableQty := PurchLine2."Qty. to Invoice" + PurchLine2."Quantity Invoiced" -
          PurchLine2."Qty. Assigned";
        #4..15
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
              PurchLine.GET("Applies-to Doc. Type","Applies-to Doc. No.","Applies-to Doc. Line No.");
              QtyToReceiveBase := PurchLine."Qty. to Receive (Base)";
              QtyReceivedBase := PurchLine."Qty. Received (Base)";
              QtyToShipBase := 0;
              QtyShippedBase := 0;
              GrossWeight := PurchLine."Gross Weight";
              UnitVolume := PurchLine."Unit Volume";
            END;
          "Applies-to Doc. Type"::"Return Order","Applies-to Doc. Type"::"Credit Memo":
            BEGIN
              PurchLine.GET("Applies-to Doc. Type","Applies-to Doc. No.","Applies-to Doc. Line No.");
              QtyToReceiveBase := 0;
              QtyReceivedBase := 0;
              QtyToShipBase := PurchLine."Return Qty. to Ship (Base)";
              QtyShippedBase := PurchLine."Return Qty. Shipped (Base)";
              GrossWeight := PurchLine."Gross Weight";
              UnitVolume := PurchLine."Unit Volume";
            END;
          "Applies-to Doc. Type"::Receipt:
            BEGIN
              PurchRcptLine.GET("Applies-to Doc. No.","Applies-to Doc. Line No.");
              QtyToReceiveBase := 0;
              QtyReceivedBase := PurchRcptLine."Quantity (Base)";
              QtyToShipBase := 0;
              QtyShippedBase := 0;
              GrossWeight := PurchRcptLine."Gross Weight";
              UnitVolume := PurchRcptLine."Unit Volume";
            END;
          "Applies-to Doc. Type"::"Return Shipment":
            BEGIN
              ReturnShptLine.GET("Applies-to Doc. No.","Applies-to Doc. Line No.");
              QtyToReceiveBase := 0;
              QtyReceivedBase := 0;
              QtyToShipBase := 0;
              QtyShippedBase := ReturnShptLine."Quantity (Base)";
              GrossWeight := ReturnShptLine."Gross Weight";
              UnitVolume := ReturnShptLine."Unit Volume";
            END;
          "Applies-to Doc. Type"::"Transfer Receipt":
            BEGIN
              TransferRcptLine.GET("Applies-to Doc. No.","Applies-to Doc. Line No.");
              QtyToReceiveBase := 0;
              QtyReceivedBase := TransferRcptLine.Quantity;
              QtyToShipBase := 0;
              QtyShippedBase := 0;
              GrossWeight := TransferRcptLine."Gross Weight";
              UnitVolume := TransferRcptLine."Unit Volume";
            END;
          "Applies-to Doc. Type"::"Sales Shipment":
            BEGIN
              SalesShptLine.GET("Applies-to Doc. No.","Applies-to Doc. Line No.");
              QtyToReceiveBase := 0;
              QtyReceivedBase := 0;
              QtyToShipBase := 0;
              QtyShippedBase := SalesShptLine."Quantity (Base)";
              GrossWeight := SalesShptLine."Gross Weight";
              UnitVolume := SalesShptLine."Unit Volume";
            END;
          "Applies-to Doc. Type"::"Return Receipt":
            BEGIN
              ReturnRcptLine.GET("Applies-to Doc. No.","Applies-to Doc. Line No.");
              QtyToReceiveBase := 0;
              QtyReceivedBase := ReturnRcptLine."Quantity (Base)";
              QtyToShipBase := 0;
              QtyShippedBase := 0;
              GrossWeight := ReturnRcptLine."Gross Weight";
              UnitVolume := ReturnRcptLine."Unit Volume";
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
        #41..48
        #51..58
        #61..68
            END;
        END;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Initialize(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "Initialize(PROCEDURE 3)".

    //procedure Initialize();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PurchLine2 := NewPurchLine;
        DataCaption := PurchLine2."No." + ' ' + PurchLine2.Description;
        AssgntAmount := NewLineAmt;
        OnAfterInitialize(PurchLine2,AssgntAmount);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        */
    //end;


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
