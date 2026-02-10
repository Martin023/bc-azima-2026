#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186671 pageextension52186671 extends "Service Item Trend Lines" 
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
        modify("ServItem.""Prepaid Amount""")
        {
            ApplicationArea = Basic;
        }
        modify("ServItem.""Invoiced Amount""")
        {
            ApplicationArea = Basic;
        }
        modify("ServItem.""Parts Used""")
        {
            ApplicationArea = Basic;
        }
        modify("ServItem.""Resources Used""")
        {
            ApplicationArea = Basic;
        }
        modify("ServItem.""Cost Used""")
        {
            ApplicationArea = Basic;
        }
        modify(Profit)
        {
            ApplicationArea = Basic;
        }
        modify(ProfitPct)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "ProfitPct(Control 16)".


            //Unsupported feature: Property Modification (Name) on "ProfitPct(Control 16)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Start"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Name"(Control 6)".


        //Unsupported feature: Code Modification on ""ServItem.""Prepaid Amount"""(Control 18).OnDrillDown".

        //trigger ""Prepaid Amount"""(Control 18)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ShowServLedgEntries(FALSE);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            SetDateFilter;
            CLEAR(ServLedgEntry);
            ServLedgEntry.SETCURRENTKEY("Service Item No. (Serviced)","Entry Type","Moved from Prepaid Acc.",Type,"Posting Date");
            ServLedgEntry.SETRANGE("Service Item No. (Serviced)",ServItem."No.");
            ServLedgEntry.SETRANGE("Entry Type",ServLedgEntry."Entry Type"::Sale);
            ServLedgEntry.SETRANGE("Moved from Prepaid Acc.",FALSE);
            ServLedgEntry.SETRANGE(Open,FALSE);
            ServLedgEntry.SETFILTER("Posting Date",ServItem.GETFILTER("Date Filter"));
            PAGE.RUN(0,ServLedgEntry);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""ServItem.""Prepaid Amount"""(Control 18)".



        //Unsupported feature: Code Modification on ""ServItem.""Invoiced Amount"""(Control 4).OnDrillDown".

        //trigger ""Invoiced Amount"""(Control 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ShowServLedgEntries(TRUE);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            SetDateFilter;
            CLEAR(ServLedgEntry);
            ServLedgEntry.SETCURRENTKEY("Service Item No. (Serviced)","Entry Type","Moved from Prepaid Acc.",Type,"Posting Date");
            ServLedgEntry.SETRANGE("Service Item No. (Serviced)",ServItem."No.");
            ServLedgEntry.SETRANGE("Entry Type",ServLedgEntry."Entry Type"::Sale);
            ServLedgEntry.SETRANGE("Moved from Prepaid Acc.",TRUE);
            ServLedgEntry.SETRANGE(Open,FALSE);
            ServLedgEntry.SETFILTER("Posting Date",ServItem.GETFILTER("Date Filter"));
            PAGE.RUN(0,ServLedgEntry);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""ServItem.""Invoiced Amount"""(Control 4)".



        //Unsupported feature: Code Modification on ""ServItem.""Parts Used"""(Control 8).OnDrillDown".

        //trigger ""Parts Used"""(Control 8)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ShowServLedgEntriesByType(ServLedgEntry.Type::Item);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            SetDateFilter;
            CLEAR(ServLedgEntry);
            ServLedgEntry.SETCURRENTKEY("Service Item No. (Serviced)","Entry Type","Moved from Prepaid Acc.",Type,"Posting Date");
            ServLedgEntry.SETRANGE("Service Item No. (Serviced)",ServItem."No.");
            ServLedgEntry.SETRANGE("Entry Type",ServLedgEntry."Entry Type"::Sale);
            ServLedgEntry.SETRANGE(Type,ServLedgEntry.Type::Item);
            ServLedgEntry.SETFILTER("Posting Date",ServItem.GETFILTER("Date Filter"));
            PAGE.RUN(0,ServLedgEntry);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""ServItem.""Parts Used"""(Control 8)".



        //Unsupported feature: Code Modification on ""ServItem.""Resources Used"""(Control 10).OnDrillDown".

        //trigger ""Resources Used"""(Control 10)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ShowServLedgEntriesByType(ServLedgEntry.Type::Resource);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            SetDateFilter;
            CLEAR(ServLedgEntry);
            ServLedgEntry.SETCURRENTKEY("Service Item No. (Serviced)","Entry Type","Moved from Prepaid Acc.",Type,"Posting Date");
            ServLedgEntry.SETRANGE("Service Item No. (Serviced)",ServItem."No.");
            ServLedgEntry.SETRANGE("Entry Type",ServLedgEntry."Entry Type"::Sale);
            ServLedgEntry.SETRANGE(Type,ServLedgEntry.Type::Resource);
            ServLedgEntry.SETFILTER("Posting Date",ServItem.GETFILTER("Date Filter"));
            PAGE.RUN(0,ServLedgEntry);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""ServItem.""Resources Used"""(Control 10)".



        //Unsupported feature: Code Modification on ""ServItem.""Cost Used"""(Control 12).OnDrillDown".

        //trigger ""Cost Used"""(Control 12)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ShowServLedgEntriesByType(ServLedgEntry.Type::"Service Cost");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            SetDateFilter;
            CLEAR(ServLedgEntry);
            ServLedgEntry.SETCURRENTKEY("Service Item No. (Serviced)","Entry Type","Moved from Prepaid Acc.",Type,"Posting Date");
            ServLedgEntry.SETRANGE("Service Item No. (Serviced)",ServItem."No.");
            ServLedgEntry.SETRANGE("Entry Type",ServLedgEntry."Entry Type"::Sale);
            ServLedgEntry.SETRANGE(Type,ServLedgEntry.Type::"Service Cost");
            ServLedgEntry.SETFILTER("Posting Date",ServItem.GETFILTER("Date Filter"));
            PAGE.RUN(0,ServLedgEntry);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""ServItem.""Cost Used"""(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Profit(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ProfitPct(Control 16)".

    }

    var
        ServItemPeriodLength: Option Day,Week,Month,Quarter,Year,Period;

    var
        "Profit%": Decimal;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetDateFilter;
        ServItem.CALCFIELDS("Invoiced Amount","Resources Used","Parts Used","Cost Used","Prepaid Amount");
        Profit := ServItem."Invoiced Amount" - ServItem."Resources Used" - ServItem."Parts Used" - ServItem."Cost Used";
        IF ServItem."Invoiced Amount" <> 0 THEN
          ProfitPct := ROUND((Profit / ServItem."Invoiced Amount") * 100,0.01)
        ELSE
          ProfitPct := 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
          "Profit%" := ROUND((Profit / ServItem."Invoiced Amount") * 100,0.01)
        ELSE
          "Profit%" := 0;
        */
    //end;


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
        EXIT(PeriodFormMgt.FindDate(Which,Rec,ServItemPeriodLength));
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
        EXIT(PeriodFormMgt.NextDate(Steps,Rec,ServItemPeriodLength));
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Set(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "Set(PROCEDURE 1)".

    //procedure Set();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ServItem.COPY(ServItem1);
        PeriodType := NewPeriodType;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ServItem.COPY(ServItem1);
        ServItemPeriodLength := NewServItemPeriodLength;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "Set(PROCEDURE 1).NewPeriodType(Parameter 1001)".

}
