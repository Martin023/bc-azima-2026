#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187029 pageextension52187029 extends "Small Business Owner Act."
{
    layout
    {
        modify("Released Sales Quotes")
        {
            ApplicationArea = Basic;
        }
        modify("Open Sales Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Released Sales Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Released Purchase Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Overdue Sales Documents")
        {
            ApplicationArea = Basic;
        }
        modify(SOShippedNotInvoiced)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "SOShippedNotInvoiced(Control 20)".

        }
        modify("Customers - Blocked")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Documents Due Today")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Purchase Documents Due Today"(Control 29)".


            //Unsupported feature: Property Modification (Name) on ""Purchase Documents Due Today"(Control 29)".

        }
        modify("Vendors - Payment on Hold")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Released Sales Quotes"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Open Sales Orders"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Released Sales Orders"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Released Purchase Orders"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Overdue Sales Documents"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SOShippedNotInvoiced(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customers - Blocked"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Documents Due Today"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendors - Payment on Hold"(Control 30)".

        // modify("My User Tasks")
        // {
        //     Visible = false;
        // }
        // modify("UserTaskManagement.GetMyPendingUserTasksCount")
        // {
        //     Visible = false;
        // }
    }
    actions
    {
        // modify("Sales(Control 10).""New Customer""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Sales(Control 10).""New Sales Order""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Purchase(Control 11).""New Purchase Order""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Receivables(Control 16).""Edit Cash Receipt Journal""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Receivables(Control 16).Navigate")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Payables(Control 26).""Edit Payment Journal""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Payables(Control 26).""Edit Bank Acc. Reconciliation""")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Sales(Control 10)."New Customer"(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Sales(Control 10)."New Sales Order"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Purchase(Control 11)."New Purchase Order"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Receivables(Control 16)."Edit Cash Receipt Journal"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Receivables(Control 16).Navigate(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Payables(Control 26)."Edit Payment Journal"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Payables(Control 26)."Edit Bank Acc. Reconciliation"(Action 33)".

    }

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RESET;
    IF NOT GET THEN BEGIN
      INIT;
      INSERT;
    END;
    SETFILTER("Due Date Filter",'<=%1',WORKDATE);
    SETFILTER("Overdue Date Filter",'<%1',WORKDATE);
    SETFILTER("User ID Filter",USERID);

    CalculateCueFieldValues;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    SETFILTER("Overdue Date Filter",'<%1',WORKDATE);
    */
    //end;


    //Unsupported feature: Code Modification on "CalculateCueFieldValues(PROCEDURE 6)".

    //procedure CalculateCueFieldValues();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SOShippedNotInvoicedCount := CountSalesOrdersShippedNotInvoiced;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF FIELDACTIVE("SOs Shipped Not Invoiced") THEN
      "SOs Shipped Not Invoiced" := CountSalesOrdersShippedNotInvoiced;
    */
    //end;

    //Unsupported feature: Property Deletion (RefreshOnActivate).

}
