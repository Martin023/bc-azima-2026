#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185632 pageextension52185632 extends "VAT Entries" 
{
    layout
    {
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Prod. Posting Group")
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
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify(Base)
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("VAT Difference")
        {
            ApplicationArea = Basic;
        }
        modify("Additional-Currency Base")
        {
            ApplicationArea = Basic;
        }
        modify("Additional-Currency Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Add.-Curr. VAT Difference")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Calculation Type")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to/Pay-to No.")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Registration No.")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to/Order Address Code")
        {
            ApplicationArea = Basic;
        }
        modify("Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("EU 3-Party Trade")
        {
            ApplicationArea = Basic;
        }
        modify(Closed)
        {
            ApplicationArea = Basic;
        }
        modify("Closed by Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Internal Ref. No.")
        {
            ApplicationArea = Basic;
        }
        modify(Reversed)
        {
            ApplicationArea = Basic;
        }
        modify("Reversed by Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Reversed Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("EU Service")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Bus. Posting Group"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Prod. Posting Group"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Bus. Posting Group"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Base(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 18)".

        modify("Unrealized Amount")
        {
            Visible = false;
        }
        modify("Unrealized Base")
        {
            Visible = false;
        }
        modify("Remaining Unrealized Amount")
        {
            Visible = false;
        }
        modify("Remaining Unrealized Base")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Difference"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional-Currency Base"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional-Currency Amount"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Add.-Curr. VAT Difference"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Calculation Type"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to/Pay-to No."(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Registration No."(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to/Order Address Code"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""EU 3-Party Trade"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Closed(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Closed by Entry No."(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Internal Ref. No."(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reversed(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reversed by Entry No."(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reversed Entry No."(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""EU Service"(Control 62)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "IncomingDocAttachFactBox(Control 3)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("&Navigate")
        {
            ApplicationArea = Basic;
        }
        modify(IncomingDocCard)
        {
            ToolTip = '';
            ApplicationArea = Basic;
        }
        modify(SelectIncomingDoc)
        {
            ToolTip = '';
            ApplicationArea = Basic;
        }
        modify(IncomingDocAttachFile)
        {
            ToolTip = '';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 34)".


        //Unsupported feature: Code Modification on "SelectIncomingDoc(Action 7).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IncomingDocument.SelectIncomingDocumentForPostedDocument("Document No.","Posting Date",RECORDID);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IncomingDocument.SelectIncomingDocumentForPostedDocument("Document No.","Posting Date");
            */
        //end;
    }

    //Unsupported feature: Property Deletion (Permissions).


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
