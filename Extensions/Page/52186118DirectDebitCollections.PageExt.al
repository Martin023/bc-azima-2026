#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186118 pageextension52186118 extends "Direct Debit Collections" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Identifier)
        {
            ApplicationArea = Basic;
        }
        modify("FORMAT(""Created Date-Time"")")
        {
            ApplicationArea = Basic;
        }
        modify("Created by User")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("No. of Transfers")
        {
            ApplicationArea = Basic;
        }
        modify("To Bank Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("To Bank Account Name")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Identifier(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FORMAT(""Created Date-Time"")"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Created by User"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Transfers"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""To Bank Account No."(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""To Bank Account Name"(Control 10)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control12(Control 12)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control13(Control 13)".

    }
    actions
    {
        modify(NewCollection)
        {
            ApplicationArea = Basic;
        }
        modify(Export)
        {
            ApplicationArea = Basic;
        }
        modify(Close)
        {
            ApplicationArea = Basic;
        }
        modify(Post)
        {
            ApplicationArea = Basic;
        }
        modify(Entries)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "NewCollection(Action 15)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "NewCollection(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Export(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Close(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Post(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Entries(Action 17)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
