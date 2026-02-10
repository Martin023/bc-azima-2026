#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185799 pageextension52185799 extends "Application Worksheet" 
{
    layout
    {
        modify(DateFilter)
        {
            ApplicationArea = Basic;
        }
        modify("Item Filter")
        {
            ApplicationArea = Basic;
        }
        modify(DocumentFilter)
        {
            ApplicationArea = Basic;
        }
        modify(LocationFilter)
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Entry Type")
        {
            ApplicationArea = Basic;
        }
        modify("Source Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document Line No.")
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
        modify("Lot No.")
        {
            ApplicationArea = Basic;
        }
        modify("Source No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Invoiced Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Reserved Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Shipped Qty. Not Returned")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Amount (Actual)")
        {
            ApplicationArea = Basic;
        }
        modify(GetUnitCostLCY)
        {
            ApplicationArea = Basic;
        }
        modify(Open)
        {
            ApplicationArea = Basic;
        }
        modify(Positive)
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Applied Entry to Adjust")
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Insertion (VariableCollection) on "DateFilter(Control 68).OnValidate".

        //trigger (Variable: ApplicationManagement)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "DateFilter(Control 68).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TextManagement.MakeDateFilter(DateFilter);
            SETFILTER("Posting Date",DateFilter);
            DateFilter := GETFILTER("Posting Date");
            DateFilterOnAfterValidate;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ApplicationManagement.MakeDateFilter(DateFilter) = 0 THEN;
            #2..4
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "DateFilter(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Filter"(Control 73)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DocumentFilter(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LocationFilter(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry Type"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Type"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Line No."(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lot No."(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Quantity"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoiced Quantity"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Quantity"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipped Qty. Not Returned"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Amount (Actual)"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetUnitCostLCY(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Open(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Positive(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Entry"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applied Entry to Adjust"(Control 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 2)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1903523907(Control 1903523907)".

    }
    actions
    {
        modify(AppliedEntries)
        {
            ApplicationArea = Basic;
        }
        modify(UnappliedEntries)
        {

            //Unsupported feature: Property Modification (Name) on "UnappliedEntries(Action 16)".

            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("&Value Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Reservation Entries")
        {
            ApplicationArea = Basic;
        }
        modify(Reapply)
        {

            //Unsupported feature: Property Modification (Name) on "Reapply(Action 42)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "AppliedEntries(Action 28)".


        //Unsupported feature: Property Deletion (Promoted) on "AppliedEntries(Action 28)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "AppliedEntries(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "UnappliedEntries(Action 16)".


        //Unsupported feature: Property Deletion (Promoted) on "UnappliedEntries(Action 16)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "UnappliedEntries(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 37)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 37)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Value Entries"(Action 48)".


        //Unsupported feature: Property Deletion (Promoted) on ""&Value Entries"(Action 48)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""&Value Entries"(Action 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reservation Entries"(Action 38)".


        //Unsupported feature: Property Deletion (Promoted) on ""Reservation Entries"(Action 38)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Reservation Entries"(Action 38)".



        //Unsupported feature: Code Modification on "Reapply(Action 42).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            UnblockItems;
            Reapplyall;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            Reapplyall;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Reapply(Action 42)".


        //Unsupported feature: Property Deletion (Promoted) on "Reapply(Action 42)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Reapply(Action 42)".

        modify(UndoApplications)
        {
            Visible = false;
        }
    }

    var


    //Unsupported feature: Code Insertion on "OnClosePage".

    //trigger OnClosePage()
    //begin
        /*
        UnblockItems;
        Reapplyall;
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Apply.SetCalledFromApplicationWorksheet(TRUE);
        ReapplyTouchedEntries; // in case OnQueryClosePage trigger was not executed due to a sudden crash

        InventoryPeriod.IsValidDate(InventoryOpenedFrom);
        IF InventoryOpenedFrom <> 0D THEN
          IF GETFILTER("Posting Date") = '' THEN
        #7..11
          END;

        UpdateFilterFields;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #4..14
        */
    //end;


    //Unsupported feature: Code Modification on "OnQueryClosePage".

    //trigger OnQueryClosePage(CloseAction: Action): Boolean
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Apply.AnyTouchedEntries THEN BEGIN
          IF NOT CONFIRM(Text003) THEN
            EXIT(FALSE);

          UnblockItems;
          Reapplyall;
        END;

        EXIT(TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF Apply.AnyTouchedEntries THEN
          IF NOT CONFIRM(Text003) THEN
            EXIT(FALSE);
        EXIT(TRUE);
        */
    //end;


    //Unsupported feature: Code Modification on "Reapplyall(PROCEDURE 1)".

    //procedure Reapplyall();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Apply.RedoApplications;
        Apply.CostAdjust;
        Apply.ClearApplicationLog;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        Apply.RedoApplications;
        Apply.CostAdjust;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetRecordToShow(PROCEDURE 7)".


    local procedure LocationFilterOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure DateFilterOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure ItemFilterOnAfterValidate()
    begin
        // Rec.SetFilter(Rec."Item No.",ItemFilter);
        // ItemFilter := Rec.GetFilter(Rec."Item No.");
        // CurrPage.Update;
    end;

    local procedure DocumentFilterOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
