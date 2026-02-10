#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185650 pageextension52185650 extends "Item Turnover Lines" 
{
    layout
    {
        modify("Period Start")
        {
            ApplicationArea = Basic;
        }
        modify("Period Name")
        {
            ApplicationArea = Basic;
        }
        modify(PurchasesQty)
        {
            ApplicationArea = Basic;
        }
        modify(PurchasesLCY)
        {
            ApplicationArea = Basic;
        }
        modify(SalesQty)
        {
            ApplicationArea = Basic;
        }
        modify(SalesLCY)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Start"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Name"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PurchasesQty(Control 4)".


        //Unsupported feature: Code Modification on "PurchasesLCY(Control 6).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ShowValueEntries(FALSE);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ShowItemEntries(FALSE);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "PurchasesLCY(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesQty(Control 8)".



        //Unsupported feature: Code Modification on "SalesLCY(Control 10).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ShowValueEntries(TRUE);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ShowItemEntries(TRUE);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SalesLCY(Control 10)".

    }

    var
        ItemLedgEntry: Record "Item Ledger Entry";

    var
        ItemPeriodLength: Option Day,Week,Month,Quarter,Year,Period;


    //Unsupported feature: Code Modification on "OnFindRecord".

    //trigger OnFindRecord()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        EXIT(PeriodFormMgt.FindDate(Which,Rec,PeriodType));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        EXIT(PeriodFormMgt.FindDate(Which,Rec,ItemPeriodLength));
        */
    //end;


    //Unsupported feature: Code Modification on "OnNextRecord".

    //trigger OnNextRecord()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        EXIT(PeriodFormMgt.NextDate(Steps,Rec,PeriodType));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        EXIT(PeriodFormMgt.NextDate(Steps,Rec,ItemPeriodLength));
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Set(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "Set(PROCEDURE 1)".

    //procedure Set();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Item.COPY(NewItem);
        PeriodType := NewPeriodType;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        Item.COPY(NewItem);
        ItemPeriodLength := NewItemPeriodLength;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "Set(PROCEDURE 1).NewPeriodType(Parameter 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "ShowItemEntries(PROCEDURE 2).ItemLedgEntry(Variable 1001)".

}
