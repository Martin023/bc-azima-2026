#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186464 pageextension52186464 extends "FA Depreciation Books"
{
    layout
    {
        modify("FA No.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""FA No."(Control 2)".

            Editable = true;
        }
        modify("Depreciation Book Code")
        {
            ApplicationArea = Basic;
            Editable = true;
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
        modify("No. of Depreciation Years")
        {
            ApplicationArea = Basic;
        }
        modify("Depreciation Starting Date")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Depreciation Months")
        {
            ApplicationArea = Basic;
        }
        modify("Depreciation Ending Date")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Depreciation Ending Date"(Control 33)".

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
        }
        modify("First User-Defined Depr. Date")
        {
            ApplicationArea = Basic;
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""FA No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depreciation Book Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetAddCurrCode(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Posting Group"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depreciation Method"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Depreciation Years"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depreciation Starting Date"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Depreciation Months"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depreciation Ending Date"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Straight-Line %"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fixed Depr. Amount"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Declining-Balance %"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""First User-Defined Depr. Date"(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depreciation Table Code"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Final Rounding Amount"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Book Value"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ignore Def. Ending Book Value"(Control 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Exchange Rate"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Use FA Ledger Check"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depr. below Zero %"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fixed Depr. Amount below Zero"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Projected Disposal Date"(Control 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Projected Proceeds on Disposal"(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depr. Starting Date (Custom 1)"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depr. Ending Date (Custom 1)"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Accum. Depr. % (Custom 1)"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depr. This Year % (Custom 1)"(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Property Class (Custom 1)"(Control 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Use Half-Year Convention"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Use DB% First Fiscal Year"(Control 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Temp. Ending Date"(Control 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Temp. Fixed Depr. Amount"(Control 73)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        moveafter("Depreciation Method"; "Depreciation Starting Date")
        moveafter("Depreciation Starting Date"; "Depreciation Ending Date")
    }
    actions
    {
        modify("Ledger E&ntries")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (PromotedCategory) on ""Ledger E&ntries"(Action 45)".

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
        modify("FA Posting Types Overview")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Error Ledger Entries"(Action 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Maintenance Ledger Entries"(Action 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Main &Asset Statistics"(Action 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Posting Types Overview"(Action 60)".

    }
}
