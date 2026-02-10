#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186758 pageextension52186758 extends "Serial No. Information List" 
{
    layout
    {
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify("Serial No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Blocked)
        {
            ApplicationArea = Basic;
        }
        modify(Control16)
        {
            ApplicationArea = Basic;
        }
        modify(Inventory)
        {
            ApplicationArea = Basic;
        }
        modify("Expired Inventory")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Blocked(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control16(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Inventory(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expired Inventory"(Control 26)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Item &Tracking Entries")
        {
            ApplicationArea = Basic;
        }
        modify(Comment)
        {
            ApplicationArea = Basic;
        }
        modify("&Item Tracing")
        {
            ApplicationArea = Basic;
        }
        modify(Navigate)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Entries"(Action 1102601002)".


        //Unsupported feature: Code Insertion on "Comment(Action 1102601003)".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //begin
            /*
            IF INSERT THEN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Action 1102601003)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Item Tracing"(Action 1102601005)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Navigate(Action 1102601006)".

    }

    var
        Text000: label 'The filter is too long.';

    //Unsupported feature: Property Deletion (Attributes) on "GetSelectionFilter(PROCEDURE 4)".


    local procedure AppendString(SelectionFilter: Code[1000];StringToAdd: Code[100]): Code[1000]
    begin
        if StrLen(SelectionFilter) + StrLen(StringToAdd) > MaxStrLen(SelectionFilter) then
          Error(Text000);

        exit(SelectionFilter + StringToAdd);
    end;

    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (ApplicationArea).

}
