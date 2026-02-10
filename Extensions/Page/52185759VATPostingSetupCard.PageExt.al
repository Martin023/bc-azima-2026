#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185759 pageextension52185759 extends "VAT Posting Setup Card" 
{
    layout
    {
        modify("VAT Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Calculation Type")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Description(Control 8)".


            //Unsupported feature: Property Modification (Name) on "Description(Control 8)".

        }
        modify("VAT %")
        {
            ApplicationArea = Basic;
        }
        modify("Unrealized VAT Type")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Identifier")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Clause Code")
        {
            ApplicationArea = Basic;
        }
        modify("EU Service")
        {
            ApplicationArea = Basic;
        }
        modify("Adjust for Payment Discount")
        {
            ApplicationArea = Basic;
        }
        modify("Certificate of Supply Required")
        {
            ApplicationArea = Basic;
        }
        modify("Tax Category")
        {
            ApplicationArea = Basic;
        }
        modify("Sales VAT Account")
        {
            ApplicationArea = Basic;
        }
        modify("Sales VAT Unreal. Account")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase VAT Account")
        {
            ApplicationArea = Basic;
        }
        modify("Purch. VAT Unreal. Account")
        {
            ApplicationArea = Basic;
        }
        modify("Reverse Chrg. VAT Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Reverse Chrg. VAT Unreal. Acc.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Bus. Posting Group"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Calculation Type"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT %"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unrealized VAT Type"(Control 40)".


        //Unsupported feature: Property Deletion (Visible) on ""Unrealized VAT Type"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Identifier"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Clause Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""EU Service"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Adjust for Payment Discount"(Control 11)".


        //Unsupported feature: Property Deletion (Visible) on ""Adjust for Payment Discount"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Certificate of Supply Required"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Tax Category"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales VAT Account"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales VAT Unreal. Account"(Control 26)".


        //Unsupported feature: Property Deletion (Visible) on ""Sales VAT Unreal. Account"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase VAT Account"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purch. VAT Unreal. Account"(Control 30)".


        //Unsupported feature: Property Deletion (Visible) on ""Purch. VAT Unreal. Account"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reverse Chrg. VAT Acc."(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reverse Chrg. VAT Unreal. Acc."(Control 34)".


        //Unsupported feature: Property Deletion (Visible) on ""Reverse Chrg. VAT Unreal. Acc."(Control 34)".

        modify(Usage)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Copy)
        {
            ApplicationArea = Basic;
        }
        modify(SuggestAccounts)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Copy(Action 6)".

    }
}
