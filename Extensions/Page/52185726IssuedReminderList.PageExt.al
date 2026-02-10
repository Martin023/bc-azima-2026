#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185726 pageextension52185726 extends "Issued Reminder List" 
{
    Caption = 'Issued Reminder List';
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Amount")
        {
            ApplicationArea = Basic;
        }
        modify("No. Printed")
        {
            ApplicationArea = Basic;
        }
        modify("Post Code")
        {
            ApplicationArea = Basic;
        }
        modify(City)
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Amount"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. Printed"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 24)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("C&ustomer")
        {
            ApplicationArea = Basic;
        }
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("&Print")
        {
            ApplicationArea = Basic;
        }
        modify("Send by &Email")
        {
            Caption = '&Email';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Send by &Email"(Action 5)".

        }
        modify("&Navigate")
        {
            ApplicationArea = Basic;
        }
        modify("Reminder Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Customer - Balance to Date")
        {
            ApplicationArea = Basic;
        }
        modify("Customer - Detail Trial Bal.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""C&ustomer"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 28)".


        //Unsupported feature: Code Modification on ""&Print"(Action 16).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(IssuedReminderHeader);
            IssuedReminderHeader.PrintRecords(TRUE,FALSE,FALSE);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(IssuedReminderHeader);
            IssuedReminderHeader.PrintRecords(TRUE,FALSE);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 16)".



        //Unsupported feature: Code Modification on ""Send by &Email"(Action 5).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IssuedReminderHeader := Rec;
            CurrPage.SETSELECTIONFILTER(IssuedReminderHeader);
            CurrPage.SETSELECTIONFILTER(IssuedReminderHeader2);
            IssuedReminderHeader.SETCURRENTKEY("Customer No.");
            IF IssuedReminderHeader.FINDSET THEN
              REPEAT
                IF IssuedReminderHeader."Customer No." <> PrevCustomerNo THEN BEGIN
                  IssuedReminderHeader2.SETRANGE("Customer No.",IssuedReminderHeader."Customer No.");
                  IssuedReminderHeader2.PrintRecords(FALSE,TRUE,FALSE);
                END;
                PrevCustomerNo := IssuedReminderHeader."Customer No.";
              UNTIL IssuedReminderHeader.NEXT = 0;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IssuedReminderHeader := Rec;
            CurrPage.SETSELECTIONFILTER(IssuedReminderHeader);
            IssuedReminderHeader.PrintRecords(FALSE,TRUE);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Send by &Email"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reminder Nos."(Action 1904202406)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - Balance to Date"(Action 1902299006)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - Detail Trial Bal."(Action 1906871306)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
