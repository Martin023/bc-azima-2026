#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185758 pageextension52185758 extends "VAT Posting Setup" 
{
    Editable = false;
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
        modify("VAT Identifier")
        {
            ApplicationArea = Basic;
        }
        modify("VAT %")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Calculation Type")
        {
            ApplicationArea = Basic;
        }
        modify("Unrealized VAT Type")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Unrealized VAT Type"(Control 47)".

        }
        modify("Adjust for Payment Discount")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Adjust for Payment Discount"(Control 40)".

        }
        modify("Sales VAT Account")
        {
            ApplicationArea = Basic;
        }
        modify("Sales VAT Unreal. Account")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Sales VAT Unreal. Account"(Control 41)".

        }
        modify("Purchase VAT Account")
        {
            ApplicationArea = Basic;
        }
        modify("Purch. VAT Unreal. Account")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Purch. VAT Unreal. Account"(Control 43)".

        }
        modify("Reverse Chrg. VAT Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Reverse Chrg. VAT Unreal. Acc.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Reverse Chrg. VAT Unreal. Acc."(Control 45)".

        }
        modify("VAT Clause Code")
        {
            ApplicationArea = Basic;
        }
        modify("EU Service")
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Bus. Posting Group"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 4)".

        modify(Description)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Identifier"(Control 20)".


        //Unsupported feature: Property Deletion (Width) on ""VAT %"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT %"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Calculation Type"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unrealized VAT Type"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Adjust for Payment Discount"(Control 40)".


        //Unsupported feature: Property Deletion (Width) on ""Sales VAT Account"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales VAT Account"(Control 8)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Sales VAT Account"(Control 8)".


        //Unsupported feature: Property Deletion (Width) on ""Sales VAT Unreal. Account"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales VAT Unreal. Account"(Control 41)".


        //Unsupported feature: Property Deletion (Width) on ""Purchase VAT Account"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase VAT Account"(Control 10)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Purchase VAT Account"(Control 10)".


        //Unsupported feature: Property Deletion (Width) on ""Purch. VAT Unreal. Account"(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purch. VAT Unreal. Account"(Control 43)".


        //Unsupported feature: Property Deletion (Width) on ""Reverse Chrg. VAT Acc."(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reverse Chrg. VAT Acc."(Control 17)".


        //Unsupported feature: Property Deletion (Width) on ""Reverse Chrg. VAT Unreal. Acc."(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reverse Chrg. VAT Unreal. Acc."(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Clause Code"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""EU Service"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Certificate of Supply Required"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Tax Category"(Control 5)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter(Control1)
        {
            group(Control52)
            {
                field("VAT Bus. Posting Group2";Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("VAT Prod. Posting Group2";Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
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

        //Unsupported feature: Property Deletion (ToolTipML) on "Copy(Action 19)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
