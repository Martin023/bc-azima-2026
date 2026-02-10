#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185738 pageextension52185738 extends "Issued Fin. Charge Memo List" 
{
    Caption = 'Issued Fin. Charge Memo List';
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
        modify("Interest Amount")
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
        modify("No. Printed")
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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interest Amount"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. Printed"(Control 46)".


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
        modify("Finance Charge Memo Nos.")
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
            CurrPage.SETSELECTIONFILTER(IssuedFinChrgMemoHeader);
            IssuedFinChrgMemoHeader.PrintRecords(TRUE,FALSE,FALSE);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(IssuedFinChrgMemoHeader);
            IssuedFinChrgMemoHeader.PrintRecords(TRUE,FALSE);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 16)".



        //Unsupported feature: Code Modification on ""Send by &Email"(Action 5).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IssuedFinChrgMemoHeader := Rec;
            CurrPage.SETSELECTIONFILTER(IssuedFinChrgMemoHeader);
            IssuedFinChrgMemoHeader.PrintRecords(FALSE,TRUE,FALSE);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IssuedFinChrgMemoHeader := Rec;
            CurrPage.SETSELECTIONFILTER(IssuedFinChrgMemoHeader);
            IssuedFinChrgMemoHeader.PrintRecords(FALSE,TRUE);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Send by &Email"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Finance Charge Memo Nos."(Action 1902355906)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - Balance to Date"(Action 1902299006)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - Detail Trial Bal."(Action 1906871306)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
