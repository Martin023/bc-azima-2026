#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186182 pageextension52186182 extends "Posted Purch. Invoice - Update" 
{

    //Unsupported feature: Property Modification (Name) on ""Posted Purch. Invoice - Update"(Page 1351)".

    Caption = 'Inventory Setup';

    //Unsupported feature: Property Modification (SourceTable) on ""Posted Purch. Invoice - Update"(Page 1351)".


    //Unsupported feature: Property Insertion (PromotedActionCategoriesML) on ""Posted Purch. Invoice - Update"(Page 1351)".

    layout
    {
        
        // modify(Control1)
        // {

        //     //Unsupported feature: Property Modification (Level) on "Control1(Control 1)".


        //     //Unsupported feature: Property Modification (ControlType) on "Control1(Control 1)".


        //     //Unsupported feature: Property Modification (Name) on "Control1(Control 1)".

        //     Caption = 'Setup Fields';

        //     //Unsupported feature: Property Insertion (GroupType) on "Control1(Control 1)".

        // }
        // modify(General)
        // {

        //     //Unsupported feature: Property Modification (Level) on "General(Control 2)".


        //     //Unsupported feature: Property Modification (ControlType) on "General(Control 2)".


        //     //Unsupported feature: Property Modification (Name) on "General(Control 2)".

        //     ToolTip = 'Specifies that the Automatic Cost Posting function is used.';

        //     //Unsupported feature: Property Insertion (SourceExpr) on "General(Control 2)".

        //     ApplicationArea = Basic;
        // }
        modify("No.")
        {
            ToolTip = 'Specifies if you can post transactions that will bring inventory levels below zero.';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""No."(Control 3)".


            //Unsupported feature: Property Modification (Name) on ""No."(Control 3)".

        }
        modify("Buy-from Vendor Name")
        {
            Caption = 'Item Numbers';
            ToolTip = 'Specifies the code for the number series that will be used to assign numbers to items. To see the number series that have been set up in the No. Series table, choose the field.';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Buy-from Vendor Name"(Control 4)".


            //Unsupported feature: Property Modification (Name) on ""Buy-from Vendor Name"(Control 4)".


            //Unsupported feature: Property Insertion (Lookup) on ""Buy-from Vendor Name"(Control 4)".


            //Unsupported feature: Property Insertion (TableRelation) on ""Buy-from Vendor Name"(Control 4)".

        }
       

        //Unsupported feature: Property Deletion (ContainerType) on "Control1(Control 1)".


        //Unsupported feature: Property Deletion (GroupType) on "General(Control 2)".


        //Unsupported feature: Property Deletion (Editable) on ""No."(Control 3)".


        //Unsupported feature: Property Deletion (Editable) on ""Buy-from Vendor Name"(Control 4)".

        modify("Posting Date")
        {
            Visible = false;
        }
        modify("Invoice Details")
        {
            Visible = false;
        }
        modify("Payment Reference")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify(Shipping)
        {
            Visible = false;
        }
        modify("Ship-to Code")
        {
            Visible = false;
        }
        addfirst(content)
        {
        }
        addfirst(General)
        {
            // field("Automatic Cost Adjustment";"Automatic Cost Adjustment")
            // {
            //     ApplicationArea = Basic;
            //     ToolTip = 'Specifies whether to adjust for any cost changes automatically every time that you post inventory transactions. The adjustment process and its consequences are the same as for the Adjust Cost - Item Entries batch job.';
            // }
        }
    }
    actions
    {

        addfirst(navigation)
        {
            action("Inventory Periods")
            {
                ApplicationArea = Basic;
                Caption = 'Inventory Periods';
                Image = Period;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Inventory Periods";
                ToolTip = 'Set up periods in combinations with your accounting periods that define when you can post transactions that affect the value of your item inventory. When you close an inventory period, you cannot post any changes to the inventory value, either expected or actual value, before the ending date of the inventory period.';
            }
            action("Units of Measure")
            {
                ApplicationArea = Basic;
                Caption = 'Units of Measure';
                Image = UnitOfMeasure;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Units of Measure";
                ToolTip = 'Set up the units of measure, such as PSC or HOUR, that you can select from in the Item Units of Measure window that you access from the item card.';
            }
            action("Item Discount Groups")
            {
                ApplicationArea = Basic;
                Caption = 'Item Discount Groups';
                Image = Discount;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Item Disc. Groups";
                ToolTip = 'Set up discount group codes that you can use as criteria when you define special discounts on a customer, vendor, or item card.';
            }
            group(Posting)
            {
                Caption = 'Posting';
                action("Inventory Posting Setup")
                {
                    ApplicationArea = Basic;
                    Caption = 'Inventory Posting Setup';
                    Image = PostedInventoryPick;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Inventory Posting Setup";
                    ToolTip = 'Set up links between inventory posting groups, inventory locations, and general ledger accounts to define where transactions for inventory items are recorded in the general ledger.';
                }
                action("Inventory Posting Groups")
                {
                    ApplicationArea = Basic;
                    Caption = 'Inventory Posting Groups';
                    Image = ItemGroup;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Inventory Posting Groups";
                    ToolTip = 'Set up the posting groups that you assign to item cards to link business transactions made for the item with an inventory account in the general ledger to group amounts for that item type.';
                }
            }
            group("Journal Templates")
            {
                Caption = 'Journal Templates';
                action("Item Journal Templates")
                {
                    ApplicationArea = Basic;
                    Caption = 'Item Journal Templates';
                    Image = JournalSetup;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = Page "Item Journal Templates";
                    ToolTip = 'Set up number series and reason codes in the journals that you use for inventory adjustment. By using different templates you can design windows with different layouts and you can assign trace codes, number series, and reports to each template.';
                }
            }
        }
    }


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        xPurchInvHeader := Rec;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        RESET;
        IF NOT GET THEN BEGIN
          INIT;
          INSERT;
        END;
        */
    //end;

    //Unsupported feature: Property Deletion (Editable).


    //Unsupported feature: Property Deletion (ModifyAllowed).


    //Unsupported feature: Property Deletion (SourceTableTemporary).


    //Unsupported feature: Property Deletion (ShowFilter).

}
