#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185736 pageextension52185736 extends "Issued Finance Charge Memo" 
{
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
        modify(Address)
        {
            ApplicationArea = Basic;
        }
        modify("Address 2")
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
        modify(Contact)
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Pre-Assigned No.")
        {
            ApplicationArea = Basic;
        }
        modify("No. Printed")
        {
            ApplicationArea = Basic;
        }
        modify("Fin. Charge Terms Code")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
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


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Address(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address 2"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Contact(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pre-Assigned No."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. Printed"(Control 32)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "FinChrgMemoLines(Control 29)".


        //Unsupported feature: Property Deletion (PartType) on "FinChrgMemoLines(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fin. Charge Terms Code"(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 57)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(List)
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("C&ustomer")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Statistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 7)".

        }
        modify("&Print")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Print"(Action 15)".

        }
        modify("Send by &Email")
        {
            Caption = '&Email';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Send by &Email"(Action 3)".

        }
        modify("&Navigate")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Navigate"(Action 30)".

        }
        modify("Finance Charge Memo Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Finance Charge Memo")
        {
            ApplicationArea = Basic;
        }
        // modify("Customer - Balance to Date")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Customer - Detail Trial Bal.")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "List(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 36)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 36)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""C&ustomer"(Action 35)".


        //Unsupported feature: Property Deletion (Promoted) on ""C&ustomer"(Action 35)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""C&ustomer"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 26)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 26)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Dimensions(Action 26)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 7)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Statistics(Action 7)".


        //Unsupported feature: Code Modification on ""&Print"(Action 15).OnAction".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 15)".



        //Unsupported feature: Code Modification on ""Send by &Email"(Action 3).OnAction".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Send by &Email"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Finance Charge Memo Nos."(Action 1902355906)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Finance Charge Memo"(Action 1903158706)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - Balance to Date"(Action 1902299006)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - Detail Trial Bal."(Action 1906871306)".

    }

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
