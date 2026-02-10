#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185752 pageextension52185752 extends "Tax Jurisdictions" 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Calculate Tax on Tax")
        {
            ApplicationArea = Basic;
        }
        modify("Unrealized VAT Type")
        {
            ApplicationArea = Basic;
        }
        modify("Adjust for Payment Discount")
        {
            ApplicationArea = Basic;
        }
        modify("Tax Account (Sales)")
        {
            ApplicationArea = Basic;
        }
        modify("Unreal. Tax Acc. (Sales)")
        {
            ApplicationArea = Basic;
        }
        modify("Tax Account (Purchases)")
        {
            ApplicationArea = Basic;
        }
        modify("Reverse Charge (Purchases)")
        {
            ApplicationArea = Basic;
        }
        modify("Unreal. Tax Acc. (Purchases)")
        {
            ApplicationArea = Basic;
        }
        modify("Unreal. Rev. Charge (Purch.)")
        {
            ApplicationArea = Basic;
        }
        modify("Report-to Jurisdiction")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".

        modify("Default Sales and Use Tax")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Calculate Tax on Tax"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unrealized VAT Type"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Adjust for Payment Discount"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Tax Account (Sales)"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unreal. Tax Acc. (Sales)"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Tax Account (Purchases)"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reverse Charge (Purchases)"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unreal. Tax Acc. (Purchases)"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unreal. Rev. Charge (Purch.)"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report-to Jurisdiction"(Control 10)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Ledger &Entries")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on ""Ledger &Entries"(Action 15)".

        }
        modify(Details)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger &Entries"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Details(Action 17)".


        //Unsupported feature: Property Deletion (Promoted) on "Details(Action 17)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Details(Action 17)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Details(Action 17)".

    }
}
