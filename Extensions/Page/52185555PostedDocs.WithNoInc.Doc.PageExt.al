#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185555 pageextension52185555 extends "Posted Docs. With No Inc. Doc." 
{
    layout
    {
        modify(DateFilter)
        {
            ApplicationArea = Basic;
        }
        modify(DocNoFilter)
        {
            ApplicationArea = Basic;
        }
        modify(GLAccFilter)
        {
            ApplicationArea = Basic;
        }
        modify(ExternalDocNoFilter)
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("External Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("First Posting Description")
        {
            ApplicationArea = Basic;
        }
        modify("Debit Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Credit Amount")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "DateFilter(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DocNoFilter(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GLAccFilter(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ExternalDocNoFilter(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""External Document No."(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""First Posting Description"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Debit Amount"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Credit Amount"(Control 24)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "IncomingDocAttachFactBox(Control 14)".

    }
    actions
    {
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
        modify(Navigate)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (PromotedCategory) on "IncomingDocCard(Action 16)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "SelectIncomingDoc(Action 15)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "IncomingDocAttachFile(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Navigate(Action 6)".

    }
}
