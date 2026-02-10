#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186579 pageextension52186579 extends "Inventory Posting Setup" 
{

    //Unsupported feature: Property Modification (PageType) on ""Inventory Posting Setup"(Page 5826)".

    layout
    {
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Invt. Posting Group Code")
        {
            ApplicationArea = Basic;
        }
        modify("Inventory Account")
        {
            ApplicationArea = Basic;
        }
        modify("Inventory Account (Interim)")
        {
            ApplicationArea = Basic;
        }
        modify("WIP Account")
        {
            ApplicationArea = Basic;
        }
        modify("Material Variance Account")
        {
            ApplicationArea = Basic;
        }
        modify("Capacity Variance Account")
        {
            ApplicationArea = Basic;
        }
        modify("Subcontracted Variance Account")
        {
            ApplicationArea = Basic;
        }
        modify("Cap. Overhead Variance Account")
        {
            ApplicationArea = Basic;
        }
        modify("Mfg. Overhead Variance Account")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invt. Posting Group Code"(Control 4)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Invt. Posting Group Code"(Control 4)".

        modify(Description)
        {
            Visible = false;
        }
        modify("View All Accounts on Lookup")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory Account"(Control 6)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Inventory Account"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory Account (Interim)"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""WIP Account"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Material Variance Account"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Capacity Variance Account"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Subcontracted Variance Account"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cap. Overhead Variance Account"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Mfg. Overhead Variance Account"(Control 16)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter(Control1)
        {
            group(Control23)
            {
                field("Location Code2";Rec."Location Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Invt. Posting Group Code2";Rec."Invt. Posting Group Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        // modify(ActionContainer5)
        // {
        //     Visible = false;
        // }
        modify(SuggestAccounts)
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (CardPageID).

}
