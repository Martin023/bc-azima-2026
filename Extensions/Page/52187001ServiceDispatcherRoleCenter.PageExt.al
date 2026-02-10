#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187001 pageextension52187001 extends "Service Dispatcher Role Center" 
{
    Caption = 'Role Center';
    layout
    {

        //Unsupported feature: Property Modification (Level) on "Control1904652008(Control 1904652008)".


        //Unsupported feature: Property Modification (Level) on "Control21(Control 21)".


        //Unsupported feature: Property Modification (Level) on "Control1907692008(Control 1907692008)".


        //Unsupported feature: Property Modification (Level) on "Control1905989608(Control 1905989608)".


        //Unsupported feature: Property Modification (Level) on "Control31(Control 31)".


        //Unsupported feature: Property Modification (Level) on "Control1901377608(Control 1901377608)".

        modify(Control18)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1904652008(Control 1904652008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control21(Control 21)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1907692008(Control 1907692008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905989608(Control 1905989608)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control31(Control 31)".

        modify(Control32)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901377608(Control 1901377608)".

        addfirst(RoleCenter)
        {
            group(Control1900724808)
            {
            }
        }
        addafter(Control1904652008)
        {
            group(Control1900724708)
            {
            }
        }
        // addfirst(Control31)
        // {
        //     part(Control1903012608;"Copy Profile")
        //     {
        //         Visible = false;
        //     }
        // }
    }
    actions
    {

        //Unsupported feature: Property Modification (ActionType) on "Service(Action 9)".


        //Unsupported feature: Property Modification (Name) on "Service(Action 9)".

        modify("Service Ta&sks")
        {

            //Unsupported feature: Property Modification (Level) on ""Service Ta&sks"(Action 5)".

            ApplicationArea = Basic;
        }
        modify("Service &Load Level")
        {

            //Unsupported feature: Property Modification (Level) on ""Service &Load Level"(Action 6)".

            ApplicationArea = Basic;
        }
        modify("Resource &Usage")
        {

            //Unsupported feature: Property Modification (Level) on ""Resource &Usage"(Action 8)".

            ApplicationArea = Basic;
        }
        modify("Service I&tems Out of Warranty")
        {

            //Unsupported feature: Property Modification (Level) on ""Service I&tems Out of Warranty"(Action 13)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Modification (ActionType) on "Profit(Action 14)".


        //Unsupported feature: Property Modification (Name) on "Profit(Action 14)".

        modify("Profit Service &Contracts")
        {

            //Unsupported feature: Property Modification (Level) on ""Profit Service &Contracts"(Action 28)".

            ApplicationArea = Basic;
        }
        modify("Profit Service &Orders")
        {

            //Unsupported feature: Property Modification (Level) on ""Profit Service &Orders"(Action 38)".

            ApplicationArea = Basic;
        }
        modify("Profit Service &Items")
        {

            //Unsupported feature: Property Modification (Level) on ""Profit Service &Items"(Action 41)".

            ApplicationArea = Basic;
        }
        modify(Loaners)
        {
            ApplicationArea = Basic;
        }
        modify(Customers)
        {
            ApplicationArea = Basic;
        }
        modify("Service Items")
        {
            ApplicationArea = Basic;
        }
        modify(Items)
        {
            ApplicationArea = Basic;
        }
        modify("Item Journals")
        {
            ApplicationArea = Basic;
        }
        modify("Requisition Worksheets")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Modification (ActionType) on ""Service Management"(Action 27)".


        //Unsupported feature: Property Modification (Name) on ""Service Management"(Action 27)".

        modify("Service Contract Quotes")
        {

            //Unsupported feature: Property Modification (Level) on ""Service Contract Quotes"(Action 7)".

            ApplicationArea = Basic;
        }
        modify("Service Contracts")
        {

            //Unsupported feature: Property Modification (Level) on ""Service Contracts"(Action 11)".

            ApplicationArea = Basic;
        }
        modify("Service Quotes")
        {

            //Unsupported feature: Property Modification (Level) on ""Service Quotes"(Action 12)".

            ApplicationArea = Basic;
        }
        modify("Service Orders")
        {

            //Unsupported feature: Property Modification (Level) on ""Service Orders"(Action 15)".

            ApplicationArea = Basic;
        }
        modify("Standard Service Codes")
        {

            //Unsupported feature: Property Modification (Level) on ""Standard Service Codes"(Action 54)".

            ApplicationArea = Basic;
        }
        modify("Posted Service Shipments")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Service Invoices")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Service Credit Memos")
        {
            ApplicationArea = Basic;
        }
        modify("Service Contract &Quote")
        {

            //Unsupported feature: Property Modification (Level) on ""Service Contract &Quote"(Action 17)".

            ApplicationArea = Basic;
        }
        modify("Service &Contract")
        {

            //Unsupported feature: Property Modification (Level) on ""Service &Contract"(Action 10)".

            ApplicationArea = Basic;
        }
        modify("Service Q&uote")
        {

            //Unsupported feature: Property Modification (Level) on ""Service Q&uote"(Action 16)".

            ApplicationArea = Basic;
        }
        modify("Service &Order")
        {

            //Unsupported feature: Property Modification (Level) on ""Service &Order"(Action 4)".

            ApplicationArea = Basic;
        }
        modify("Sales Or&der")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer &Order")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Modification (ActionType) on "Tasks(Action 19)".


        //Unsupported feature: Property Modification (Name) on "Tasks(Action 19)".


        //Unsupported feature: Property Insertion (IsHeader) on "Tasks(Action 19)".

        modify("Service Tas&ks")
        {

            //Unsupported feature: Property Modification (Level) on ""Service Tas&ks"(Action 20)".

            ApplicationArea = Basic;
        }
        modify("C&reate Contract Service Orders")
        {

            //Unsupported feature: Property Modification (Level) on ""C&reate Contract Service Orders"(Action 22)".

            ApplicationArea = Basic;
        }
        modify("Create Contract In&voices")
        {

            //Unsupported feature: Property Modification (Level) on ""Create Contract In&voices"(Action 24)".

            ApplicationArea = Basic;
        }
        modify("Post &Prepaid Contract Entries")
        {

            //Unsupported feature: Property Modification (Level) on ""Post &Prepaid Contract Entries"(Action 26)".

            ApplicationArea = Basic;
        }
        modify("Order Pla&nning")
        {

            //Unsupported feature: Property Modification (Level) on ""Order Pla&nning"(Action 29)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Modification (ActionType) on "Administration(Action 30)".


        //Unsupported feature: Property Modification (Name) on "Administration(Action 30)".


        //Unsupported feature: Property Insertion (IsHeader) on "Administration(Action 30)".

        modify("St&andard Service Codes")
        {

            //Unsupported feature: Property Modification (Level) on ""St&andard Service Codes"(Action 33)".

            ApplicationArea = Basic;
        }
        modify("Dispatch Board")
        {

            //Unsupported feature: Property Modification (Level) on ""Dispatch Board"(Action 23)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Modification (ActionType) on "History(Action 34)".


        //Unsupported feature: Property Modification (Name) on "History(Action 34)".


        //Unsupported feature: Property Insertion (IsHeader) on "History(Action 34)".

        modify("Item &Tracing")
        {

            //Unsupported feature: Property Modification (Level) on ""Item &Tracing"(Action 36)".

            ApplicationArea = Basic;
        }
        modify("Navi&gate")
        {

            //Unsupported feature: Property Modification (Level) on ""Navi&gate"(Action 37)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (CaptionML) on "Service(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Ta&sks"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service &Load Level"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource &Usage"(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service I&tems Out of Warranty"(Action 13)".


        //Unsupported feature: Property Deletion (CaptionML) on "Profit(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Profit Service &Contracts"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Profit Service &Orders"(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Profit Service &Items"(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Loaners(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Customers(Action 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Items"(Action 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Items(Action 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Journals"(Action 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Requisition Worksheets"(Action 25)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Service Management"(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Contract Quotes"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Contracts"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Quotes"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Orders"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Standard Service Codes"(Action 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Service Shipments"(Action 60)".


        //Unsupported feature: Property Deletion (Promoted) on ""Posted Service Shipments"(Action 60)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Posted Service Shipments"(Action 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Service Invoices"(Action 61)".


        //Unsupported feature: Property Deletion (Promoted) on ""Posted Service Invoices"(Action 61)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Posted Service Invoices"(Action 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Service Credit Memos"(Action 62)".


        //Unsupported feature: Property Deletion (Promoted) on ""Posted Service Credit Memos"(Action 62)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Posted Service Credit Memos"(Action 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Contract &Quote"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service &Contract"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Q&uote"(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service &Order"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Or&der"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer &Order"(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Tas&ks"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""C&reate Contract Service Orders"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Contract In&voices"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post &Prepaid Contract Entries"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Pla&nning"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""St&andard Service Codes"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dispatch Board"(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracing"(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Navi&gate"(Action 37)".

        addafter("Service Contract Quotes")
        {
            action(Open)
            {
                ApplicationArea = Basic;
                Caption = 'Open';
                Image = Edit;
                RunObject = Page "Service Contracts";
                RunPageView = where("Change Status"=filter(Open));
                ShortCutKey = 'Return';
            }
        }
        addfirst(Creation)
        {
            group("&Service")
            {
                Caption = '&Service';
                Image = Tools;
            }
        }
        // moveafter(ActionContainer1900000006;"Service Ta&sks")
        // moveafter(ActionContainer1900000011;"Service Contract Quotes")
        // moveafter(ActionContainer1900000012;"Posted Documents")
    }
}
