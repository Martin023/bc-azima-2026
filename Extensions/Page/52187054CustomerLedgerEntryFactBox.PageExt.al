#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187054 pageextension52187054 extends "Customer Ledger Entry FactBox" 
{
    layout
    {
        modify(DocumentHeading)
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Pmt. Discount Date")
        {
            ApplicationArea = Basic;
        }
        modify(NoOfReminderFinEntries)
        {
            ApplicationArea = Basic;
        }
        modify(NoOfAppliedEntries)
        {
            ApplicationArea = Basic;
        }
        modify(NoOfDetailedCustomerEntries)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "DocumentHeading(Control 13).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF NOT ShowDoc THEN BEGIN
              GLEntry.SETCURRENTKEY("Document No.","Posting Date");
              GLEntry.SETRANGE("Document No.","Document No.");
              GLEntry.SETRANGE("Posting Date","Posting Date");

              PAGE.RUN(PAGE::"General Ledger Entries",GLEntry);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
              GeneralLedgEntriesList.SETTABLEVIEW(GLEntry);
              GeneralLedgEntriesList.RUN
            END;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "DocumentHeading(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Discount Date"(Control 3)".



        //Unsupported feature: Code Modification on "NoOfReminderFinEntries(Control 5).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ReminderFinEntry.SETRANGE("Customer Entry No.","Entry No.");

            PAGE.RUN(PAGE::"Reminder/Fin. Charge Entries",ReminderFinEntry);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ReminderFinEntry.SETRANGE("Customer Entry No.","Entry No.");
            ReminderFinEntriesList.SETTABLEVIEW(ReminderFinEntry);
            ReminderFinEntriesList.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfReminderFinEntries(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfAppliedEntries(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfDetailedCustomerEntries(Control 2)".

    }

    var
        GeneralLedgEntriesList: Page "General Ledger Entries";

    var
        ReminderFinEntriesList: Page "Reminder/Fin. Charge Entries";
}
