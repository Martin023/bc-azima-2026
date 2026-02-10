#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186600 pageextension52186600 extends "BOM Structure" 
{
    layout
    {
        modify(ItemFilter)
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(HasWarning)
        {
            ApplicationArea = Basic;
        }
        modify("Low-Level Code")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. per Parent")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. per Top Item")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Replenishment System")
        {
            ApplicationArea = Basic;
        }
        modify("Lead-Time Offset")
        {
            ApplicationArea = Basic;
        }
        modify("Safety Lead Time")
        {
            ApplicationArea = Basic;
        }
        modify("Lead Time Calculation")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ItemFilter(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "HasWarning(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Low-Level Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. per Parent"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. per Top Item"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Replenishment System"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lead-Time Offset"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Safety Lead Time"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lead Time Calculation"(Control 10)".

    }
    actions
    {
        modify("Event")
        {
            ApplicationArea = Basic;
        }
        modify(Period)
        {
            ApplicationArea = Basic;
        }
        modify(Variant)
        {
            ApplicationArea = Basic;
        }
        modify(Location)
        {
            ApplicationArea = Basic;
        }
        modify("BOM Level")
        {
            ApplicationArea = Basic;
        }
        modify("Show Warnings")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 27)".


        //Unsupported feature: Property Deletion (Promoted) on "Event(Action 27)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Event(Action 27)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Event(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 26)".


        //Unsupported feature: Property Deletion (Promoted) on "Period(Action 26)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Period(Action 26)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Period(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 18)".


        //Unsupported feature: Property Deletion (Promoted) on "Variant(Action 18)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Variant(Action 18)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Variant(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 15)".


        //Unsupported feature: Property Deletion (Promoted) on "Location(Action 15)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Location(Action 15)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Location(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 13)".


        //Unsupported feature: Property Deletion (Promoted) on ""BOM Level"(Action 13)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""BOM Level"(Action 13)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""BOM Level"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Warnings"(Action 30)".

    }
    var
        Text000: label 'Could not find items with BOM levels.';


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsParentExpr := NOT "Is Leaf";

        HasWarning := NOT IsLineOk(FALSE,DummyBOMWarningLog);

        IF Type = Type::Item THEN
          "Low-Level Code" := Indentation;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "InitItem(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "InitItem(PROCEDURE 1)".

    //procedure InitItem();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Item := NewItem;
        ItemFilter := Item."No.";
        ShowBy := ShowBy::Item;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        Item.COPY(NewItem);
        ItemFilter := Item."No.";
        ShowBy := ShowBy::Item;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "InitAsmOrder(PROCEDURE 5)".


    //Unsupported feature: Property Deletion (Attributes) on "InitProdOrder(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "RefreshPage(PROCEDURE 2)".

    //procedure RefreshPage();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Item.SETFILTER("No.",ItemFilter);
        Item.SETRANGE("Date Filter",0D,WORKDATE);
        CalcBOMTree.SetItemFilter(Item);
        CASE ShowBy OF
          ShowBy::Item:
            BEGIN
              Item.FINDFIRST;
              RaiseError := (NOT Item.HasBOM) AND (Item."Routing No." = '');
              ErrorText := CouldNotFindBOMLevelsErr;
              OnRefreshPageOnBeforeRaiseError(Item,RaiseError,ErrorText);
              IF RaiseError THEN
                ERROR(ErrorText);
              CalcBOMTree.GenerateTreeForItems(Item,Rec,0);
            END;
          ShowBy::Production:
        #16..18
        END;

        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        Item.SETFILTER("No.",ItemFilter);
        #3..7
              IF (NOT Item.HasBOM) AND (Item."Routing No." = '') THEN
                ERROR(Text000);
        #13..21
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "RefreshPage(PROCEDURE 2).RaiseError(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "RefreshPage(PROCEDURE 2).ErrorText(Variable 1002)".


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
