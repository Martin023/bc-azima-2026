#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185820 pageextension52185820 extends "VAT Rate Change Setup" 
{
    layout
    {
        modify("VAT Rate Change Tool Completed")
        {
            ApplicationArea = Basic;
        }
        modify("Perform Conversion")
        {
            ApplicationArea = Basic;
        }
        modify("Update G/L Accounts")
        {
            ApplicationArea = Basic;
        }
        modify("Account Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Update Items")
        {
            ApplicationArea = Basic;
        }
        modify("Item Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Update Resources")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Update Item Templates")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Update Item Templates"(Control 13)".


            //Unsupported feature: Property Modification (Name) on ""Update Item Templates"(Control 13)".

        }
        modify("Update Item Charges")
        {
            ApplicationArea = Basic;
        }
        modify("Update Gen. Prod. Post. Groups")
        {
            ApplicationArea = Basic;
        }
        modify("Update Serv. Price Adj. Detail")
        {
            ApplicationArea = Basic;
        }
        modify("Update Work Centers")
        {
            ApplicationArea = Basic;
        }
        modify("Update Machine Centers")
        {
            ApplicationArea = Basic;
        }
        modify("Update Gen. Journal Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Update Gen. Journal Allocation")
        {
            ApplicationArea = Basic;
        }
        modify("Update Std. Gen. Jnl. Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Update Res. Journal Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Update Job Journal Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Update Requisition Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Update Std. Item Jnl. Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Update Sales Documents")
        {
            ApplicationArea = Basic;
        }
        modify("Ignore Status on Sales Docs.")
        {
            ApplicationArea = Basic;
        }
        modify("Update Purchase Documents")
        {
            ApplicationArea = Basic;
        }
        modify("Ignore Status on Purch. Docs.")
        {
            ApplicationArea = Basic;
        }
        modify("Update Service Docs.")
        {
            ApplicationArea = Basic;
        }
        modify("Update Production Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Update Reminders")
        {
            ApplicationArea = Basic;
        }
        modify("Update Finance Charge Memos")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Rate Change Tool Completed"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Perform Conversion"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update G/L Accounts"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Filter"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Items"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Filter"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Resources"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Filter"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Item Templates"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Item Charges"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Gen. Prod. Post. Groups"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Serv. Price Adj. Detail"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Work Centers"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Machine Centers"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Gen. Journal Lines"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Gen. Journal Allocation"(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Std. Gen. Jnl. Lines"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Res. Journal Lines"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Job Journal Lines"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Requisition Lines"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Std. Item Jnl. Lines"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Sales Documents"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ignore Status on Sales Docs."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Purchase Documents"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ignore Status on Purch. Docs."(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Service Docs."(Control 20)".

        modify("Ignore Status on Service Docs.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Production Orders"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Reminders"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Finance Charge Memos"(Control 32)".

        modify("Unit Price Incl. VAT")
        {
            Visible = false;
        }
        modify("Update Unit Price For G/L Acc.")
        {
            Visible = false;
        }
        modify("Upd. Unit Price For Item Chrg.")
        {
            Visible = false;
        }
        modify("Upd. Unit Price For FA")
        {
            Visible = false;
        }
    }
    actions
    {
        modify("VAT Prod. Posting Group Conv.")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Prod. Posting Group Conv.")
        {
            ApplicationArea = Basic;
        }
        modify("&Convert")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Rate Change Log Entries")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group Conv."(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Prod. Posting Group Conv."(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Convert"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Rate Change Log Entries"(Action 26)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
