#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186502 pageextension52186502 extends "FA Depreciation Books Subform"
{
    layout
    {
        modify("Depreciation Book Code")
        {
            ApplicationArea = Basic;
        }
        // modify(GetAddCurrCode)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("FA Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Depreciation Method")
        {
            ApplicationArea = Basic;
        }
        modify("Depreciation Starting Date")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Depreciation Years")
        {
            ApplicationArea = Basic;
        }
        modify("Depreciation Ending Date")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Depreciation Ending Date"(Control 33)".

        }
        modify("No. of Depreciation Months")
        {
            ApplicationArea = Basic;
        }
        modify("Straight-Line %")
        {
            ApplicationArea = Basic;
        }
        modify("Fixed Depr. Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Declining-Balance %")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Declining-Balance %"(Control 20)".

        }
        modify("First User-Defined Depr. Date")
        {
            ApplicationArea = Basic;
        }
        modify("""Disposal Date"" > 0D")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Disposal Date" > 0D(Control 28)".


            //Unsupported feature: Property Modification (Name) on ""Disposal Date" > 0D(Control 28)".

        }
        modify(BookValue)
        {

            //Unsupported feature: Property Modification (Name) on "BookValue(Control 2)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "BookValue(Control 2)".

        }
        modify("Depreciation Table Code")
        {
            ApplicationArea = Basic;
        }
        modify("Final Rounding Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Ending Book Value")
        {
            ApplicationArea = Basic;
        }
        modify("Ignore Def. Ending Book Value")
        {
            ApplicationArea = Basic;
        }
        modify("FA Exchange Rate")
        {
            ApplicationArea = Basic;
        }
        modify("Use FA Ledger Check")
        {
            ApplicationArea = Basic;
        }
        modify("Depr. below Zero %")
        {
            ApplicationArea = Basic;
        }
        modify("Fixed Depr. Amount below Zero")
        {
            ApplicationArea = Basic;
        }
        modify("Projected Disposal Date")
        {
            ApplicationArea = Basic;
        }
        modify("Projected Proceeds on Disposal")
        {
            ApplicationArea = Basic;
        }
        modify("Depr. Starting Date (Custom 1)")
        {
            ApplicationArea = Basic;
        }
        modify("Depr. Ending Date (Custom 1)")
        {
            ApplicationArea = Basic;
        }
        modify("Accum. Depr. % (Custom 1)")
        {
            ApplicationArea = Basic;
        }
        modify("Depr. This Year % (Custom 1)")
        {
            ApplicationArea = Basic;
        }
        modify("Property Class (Custom 1)")
        {
            ApplicationArea = Basic;
        }
        modify("Use Half-Year Convention")
        {
            ApplicationArea = Basic;
        }
        modify("Use DB% First Fiscal Year")
        {
            ApplicationArea = Basic;
        }
        modify("Temp. Ending Date")
        {
            ApplicationArea = Basic;
        }
        modify("Temp. Fixed Depr. Amount")
        {
            ApplicationArea = Basic;
        }



        //trigger (Variable: FALedgEntry)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "BookValue(Control 2).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DrillDownOnBookValue;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Disposal Date" > 0D THEN
          ShowBookValueAfterDisposal
        ELSE BEGIN
          SetBookValueFiltersOnFALedgerEntry(FALedgEntry);
          PAGE.RUN(0,FALedgEntry);
        END;
        */
        //end;


        moveafter("Depreciation Starting Date"; "Depreciation Ending Date")
    }
    actions
    {

        //Unsupported feature: Property Modification (Image) on ""&Depr. Book"(Action 1907746904)".

        modify("Ledger E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Error Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Maintenance Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("Main &Asset Statistics")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 1900295504)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Error Ledger Entries"(Action 1901741904)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Maintenance Ledger Entries"(Action 1903866604)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 1902759404)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Main &Asset Statistics"(Action 1901991404)".

    }

    var
        FALedgEntry: Record "FA Ledger Entry";

    var
        Disposed: Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    BookValue := GetBookValue;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Disposed := "Disposal Date" > 0D;
    IF Disposed THEN
      "Book Value" := 0;
    */
    //end;
}
