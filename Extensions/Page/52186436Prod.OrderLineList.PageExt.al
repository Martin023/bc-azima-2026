#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186436 pageextension52186436 extends "Prod. Order Line List" 
{
    layout
    {
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Prod. Order No.")
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Description 2")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[3]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[4]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[5]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[6]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[7]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[8]")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Finished Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Scrap %")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Starting Date")
        {

            //Unsupported feature: Property Modification (Name) on ""Starting Date"(Control 28)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Starting Date"(Control 28)".

        }
        modify("Starting Time")
        {

            //Unsupported feature: Property Modification (Name) on ""Starting Time"(Control 30)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Starting Time"(Control 30)".


            //Unsupported feature: Property Modification (Visible) on ""Starting Time"(Control 30)".

        }
        modify("Ending Date")
        {

            //Unsupported feature: Property Modification (Name) on ""Ending Date"(Control 32)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Ending Date"(Control 32)".

        }
        modify("Ending Time")
        {

            //Unsupported feature: Property Modification (Name) on ""Ending Time"(Control 34)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Ending Time"(Control 34)".


            //Unsupported feature: Property Modification (Visible) on ""Ending Time"(Control 34)".

        }
        modify("Production BOM No.")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Amount")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Order No."(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Description 2"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Finished Quantity"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Quantity"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Scrap %"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 26)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Starting Date"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 28)".


        //Unsupported feature: Property Deletion (Visible) on ""Starting Date"(Control 28)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Starting Time"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Time"(Control 30)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ending Date"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Date"(Control 32)".


        //Unsupported feature: Property Deletion (Visible) on ""Ending Date"(Control 32)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ending Time"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Time"(Control 34)".

        modify("Starting Date-Time")
        {
            Visible = false;
        }
        modify("Ending Date-Time")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Production BOM No."(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Amount"(Control 40)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(ShowDocument)
        {

            //Unsupported feature: Property Modification (Name) on "ShowDocument(Action 17)".

            ApplicationArea = Basic;
        }
        modify(ShowReservEntries)
        {

            //Unsupported feature: Property Modification (Name) on "ShowReservEntries(Action 49)".

            ApplicationArea = Basic;
        }
        modify(ShowTrackingLines)
        {

            //Unsupported feature: Property Modification (Name) on "ShowTrackingLines(Action 50)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "ShowDocument(Action 17).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ProdOrder.GET(Status,"Prod. Order No.");
            CASE Status OF
              Status::Planned:
            #4..6
              Status::Released:
                PAGE.RUN(PAGE::"Released Production Order",ProdOrder);
            END;

            OnAfterShowDocument(Rec,ProdOrder);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..9
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowDocument(Action 17)".


        //Unsupported feature: Property Deletion (Promoted) on "ShowDocument(Action 17)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "ShowDocument(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowReservEntries(Action 49)".


        //Unsupported feature: Property Deletion (Promoted) on "ShowReservEntries(Action 49)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "ShowReservEntries(Action 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowTrackingLines(Action 50)".


        //Unsupported feature: Property Deletion (Promoted) on "ShowTrackingLines(Action 50)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "ShowTrackingLines(Action 50)".

    }


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        GetStartingEndingDateAndTime(StartingTime,StartingDate,EndingTime,EndingDate);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        */
    //end;
}
