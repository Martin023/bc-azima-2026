#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185980 pageextension52185980 extends "Cash Flow Worksheet" 
{
    layout
    {
        modify("Cash Flow Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Cash Flow Forecast No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Source Type")
        {
            ApplicationArea = Basic;
        }
        modify("Source No.")
        {
            ApplicationArea = Basic;
        }
        modify("Cash Flow Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Amount (LCY)")
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
        modify(CFName)
        {
            ApplicationArea = Basic;
        }
        modify(CFAccName)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Flow Date"(Control 1001)".

        modify(Overdue)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 1007)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Flow Forecast No."(Control 1009)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 1011)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Type"(Control 1017)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source No."(Control 1015)".


        //Unsupported feature: Property Deletion (Enabled) on ""Source No."(Control 1015)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Flow Account No."(Control 1019)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount (LCY)"(Control 1023)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 1025)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 1027)".

        modify(ErrorMessagesPart)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CFName(Control 1047)".


        //Unsupported feature: Property Deletion (ShowCaption) on "CFName(Control 1047)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CFAccName(Control 1049)".

    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify(Entries)
        {
            ApplicationArea = Basic;
        }
        modify(SuggestWorksheetLines)
        {
            ApplicationArea = Basic;
        }
        modify(Register)
        {
            ApplicationArea = Basic;
        }
        modify(ShowSource)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (RunPageMode) on "ShowSource(Action 2)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1061)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 1061)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 1061)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 1056)".


        //Unsupported feature: Property Deletion (Promoted) on "Card(Action 1056)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Card(Action 1056)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Entries(Action 1057)".


        //Unsupported feature: Code Modification on "SuggestWorksheetLines(Action 1059).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            DeleteErrors;
            SuggestWkshLines.RUNMODAL;
            CLEAR(SuggestWkshLines);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            SuggestWkshLines.RUNMODAL;
            CLEAR(SuggestWkshLines);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SuggestWorksheetLines(Action 1059)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Register(Action 1053)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowSource(Action 2)".

        modify("Page")
        {
            Visible = false;
        }
        modify(EditInExcel)
        {
            Visible = false;
        }
    }


    //Unsupported feature: Property Modification (Length) on "CFName(Variable 1006)".

    //var
        //>>>> ORIGINAL VALUE:
        //CFName : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CFName : 50;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "CFAccName(Variable 1007)".

    //var
        //>>>> ORIGINAL VALUE:
        //CFAccName : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CFAccName : 50;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ShowErrors;
        CFName := CashFlowManagement.CashFlowName("Cash Flow Forecast No.");
        CFAccName := CashFlowManagement.CashFlowAccountName("Cash Flow Account No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CFName := CashFlowManagement.CashFlowName("Cash Flow Forecast No.");
        CFAccName := CashFlowManagement.CashFlowAccountName("Cash Flow Account No.");
        */
    //end;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        SourceNumEnabled := "Source Type" <> "Source Type"::Tax;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
