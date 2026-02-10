#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186994 pageextension52186994 extends "Whse. Worker WMS Role Center" 
{
    Caption = 'Role Center';
    layout
    {

        //Unsupported feature: Property Modification (Level) on "Control1901138408(Control 1901138408)".


        //Unsupported feature: Property Modification (Level) on "Control1905989608(Control 1905989608)".


        //Unsupported feature: Property Modification (Level) on "Control1006(Control 1006)".


        //Unsupported feature: Property Modification (Level) on "Control4(Control 4)".


        //Unsupported feature: Property Modification (Level) on "Control1901377608(Control 1901377608)".

        modify(Control7)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901138408(Control 1901138408)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905989608(Control 1905989608)".

        modify(Control6)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1006(Control 1006)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control4(Control 4)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901377608(Control 1901377608)".

        addfirst(RoleCenter)
        {
            group(Control1900724808)
            {
            }
        }
        addafter(Control1905989608)
        {
            group(Control1900724708)
            {
            }
        }
    }
    actions
    {
        modify("Warehouse &Bin List")
        {
            ApplicationArea = Basic;
        }
        modify("Warehouse A&djustment Bin")
        {
            ApplicationArea = Basic;
        }
        modify("Whse. P&hys. Inventory List")
        {
            ApplicationArea = Basic;
        }
        modify("Prod. &Order Picking List")
        {
            ApplicationArea = Basic;
        }
        modify("Customer &Labels")
        {
            ApplicationArea = Basic;
        }
        modify(Picks)
        {
            ApplicationArea = Basic;
        }
        modify("Put-aways")
        {
            ApplicationArea = Basic;
        }
        modify(Movements)
        {
            ApplicationArea = Basic;
        }
        modify(WhseShpt)
        {

            //Unsupported feature: Property Modification (Name) on "WhseShpt(Action 9)".

            ApplicationArea = Basic;
        }
        modify(WhseShptReleased)
        {

            //Unsupported feature: Property Modification (Name) on "WhseShptReleased(Action 22)".

            ApplicationArea = Basic;
        }
        modify(WhseShptPartPicked)
        {

            //Unsupported feature: Property Modification (Name) on "WhseShptPartPicked(Action 23)".

            ApplicationArea = Basic;
        }
        modify(WhseShptComplPicked)
        {

            //Unsupported feature: Property Modification (Name) on "WhseShptComplPicked(Action 24)".

            ApplicationArea = Basic;
        }
        modify(WhseShptPartShipped)
        {

            //Unsupported feature: Property Modification (Name) on "WhseShptPartShipped(Action 25)".

            ApplicationArea = Basic;
        }
        modify(WhseReceipts)
        {

            //Unsupported feature: Property Modification (Name) on "WhseReceipts(Action 11)".

            ApplicationArea = Basic;
        }
        modify(WhseReceiptsPartReceived)
        {

            //Unsupported feature: Property Modification (Name) on "WhseReceiptsPartReceived(Action 77)".

            ApplicationArea = Basic;
        }
        modify("Transfer Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Assembly Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Contents")
        {
            ApplicationArea = Basic;
        }
        modify(Items)
        {

            //Unsupported feature: Property Modification (Level) on "Items(Action 47)".

            ApplicationArea = Basic;
        }
        modify(Customers)
        {

            //Unsupported feature: Property Modification (Level) on "Customers(Action 49)".

            ApplicationArea = Basic;
        }
        modify(Vendors)
        {

            //Unsupported feature: Property Modification (Level) on "Vendors(Action 52)".

            ApplicationArea = Basic;
        }
        modify("Shipping Agents")
        {

            //Unsupported feature: Property Modification (Level) on ""Shipping Agents"(Action 53)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Modification (ActionType) on "Journals(Action 12)".


        //Unsupported feature: Property Modification (Name) on "Journals(Action 12)".

        modify(WhsePhysInvtJournals)
        {

            //Unsupported feature: Property Modification (Level) on "WhsePhysInvtJournals(Action 55)".


            //Unsupported feature: Property Modification (Name) on "WhsePhysInvtJournals(Action 55)".

            Caption = 'Whse. Phys. Invt. Journals';
            ApplicationArea = Basic;
        }
        modify("WhseItem Journals")
        {

            //Unsupported feature: Property Modification (Level) on ""WhseItem Journals"(Action 3)".


            //Unsupported feature: Property Modification (Name) on ""WhseItem Journals"(Action 3)".

            Caption = 'Whse. Item Journals';
            ApplicationArea = Basic;
        }
        modify(PutawayWorksheets)
        {

            //Unsupported feature: Property Modification (Level) on "PutawayWorksheets(Action 58)".


            //Unsupported feature: Property Modification (Name) on "PutawayWorksheets(Action 58)".

            ApplicationArea = Basic;
        }
        modify(MovementWorksheets)
        {

            //Unsupported feature: Property Modification (Level) on "MovementWorksheets(Action 60)".


            //Unsupported feature: Property Modification (Name) on "MovementWorksheets(Action 60)".

            ApplicationArea = Basic;
        }
        modify(PickWorksheets)
        {

            //Unsupported feature: Property Modification (Level) on "PickWorksheets(Action 56)".


            //Unsupported feature: Property Modification (Name) on "PickWorksheets(Action 56)".

            ApplicationArea = Basic;
        }
        modify("Registered Picks")
        {
            ApplicationArea = Basic;
        }
        modify("Registered Put-aways")
        {
            ApplicationArea = Basic;
        }
        modify("Registered Movements")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Whse. Receipts")
        {
            ApplicationArea = Basic;
        }
        modify("Whse. P&hysical Invt. Journal")
        {
            ApplicationArea = Basic;
        }
        modify("Whse. Item &Journal")
        {
            ApplicationArea = Basic;
        }
        modify("Pick &Worksheet")
        {
            ApplicationArea = Basic;
        }
        modify("Put-&away Worksheet")
        {
            ApplicationArea = Basic;
        }
        modify("M&ovement Worksheet")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Warehouse &Bin List"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warehouse A&djustment Bin"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Whse. P&hys. Inventory List"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. &Order Picking List"(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer &Labels"(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Picks(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Put-aways"(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Movements(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WhseShpt(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WhseShptReleased(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WhseShptPartPicked(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WhseShptComplPicked(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WhseShptPartShipped(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WhseReceipts(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WhseReceiptsPartReceived(Action 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer Orders"(Action 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assembly Orders"(Action 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Contents"(Action 46)".

        modify("Reference Data")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Items(Action 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Customers(Action 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Vendors(Action 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agents"(Action 53)".


        //Unsupported feature: Property Deletion (CaptionML) on "Journals(Action 12)".


        //Unsupported feature: Property Deletion (Image) on "Journals(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WhsePhysInvtJournals(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""WhseItem Journals"(Action 3)".

        modify(Worksheet)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PutawayWorksheets(Action 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on "MovementWorksheets(Action 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PickWorksheets(Action 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Registered Picks"(Action 43)".


        //Unsupported feature: Property Deletion (Promoted) on ""Registered Picks"(Action 43)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Registered Picks"(Action 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Registered Put-aways"(Action 44)".


        //Unsupported feature: Property Deletion (Promoted) on ""Registered Put-aways"(Action 44)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Registered Put-aways"(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Registered Movements"(Action 45)".


        //Unsupported feature: Property Deletion (Promoted) on ""Registered Movements"(Action 45)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Registered Movements"(Action 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Whse. Receipts"(Action 59)".


        //Unsupported feature: Property Deletion (Promoted) on ""Posted Whse. Receipts"(Action 59)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Posted Whse. Receipts"(Action 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Whse. P&hysical Invt. Journal"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Whse. Item &Journal"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pick &Worksheet"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Put-&away Worksheet"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""M&ovement Worksheet"(Action 30)".

        addafter("Warehouse A&djustment Bin")
        {
            separator(Action51)
            {
            }
        }
        addafter("Whse. P&hys. Inventory List")
        {
            separator(Action19)
            {
            }
        }
        addafter("Prod. &Order Picking List")
        {
            separator(Action54)
            {
            }
        }
        addafter("Bin Contents")
        {
            action("Warehouse Employees")
            {
                ApplicationArea = Basic;
                Caption = 'Warehouse Employees';
                RunObject = Page "Warehouse Employee List";
            }
        }
        addfirst(Processing)
        {
            separator(Action48)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
        }
        moveafter("Bin Contents";Items)
        moveafter("Shipping Agents";WhsePhysInvtJournals)
        // moveafter("Whse. Item Journals";PickWorksheets)
        // moveafter("Pick Worksheets";PutawayWorksheets)
        // moveafter(ActionContainer1900000012;"Registered Documents")
    }
}
