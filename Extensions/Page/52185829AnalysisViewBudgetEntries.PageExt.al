#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185829 pageextension52185829 extends "Analysis View Budget Entries" 
{
    layout
    {
        modify("Analysis View Code")
        {
            ApplicationArea = Basic;
        }
        modify("Budget Name")
        {
            ApplicationArea = Basic;
        }
        modify("Business Unit Code")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Dimension 1 Value Code")
        {
            ApplicationArea = Basic;
        }
        modify("Dimension 2 Value Code")
        {
            ApplicationArea = Basic;
        }
        modify("Dimension 3 Value Code")
        {
            ApplicationArea = Basic;
        }
        modify("Dimension 4 Value Code")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Analysis View Code"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budget Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Business Unit Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Account No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension 1 Value Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension 2 Value Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension 3 Value Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension 4 Value Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 20)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }

    //Unsupported feature: Variable Insertion (Variable: GLBudgetEntries) (VariableCollection) on "DrillDown(PROCEDURE 1)".


    //Unsupported feature: Code Modification on "DrillDown(PROCEDURE 1)".

    //procedure DrillDown();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GLBudgetEntry.SETRANGE("Entry No.","Entry No.");
        PAGE.RUNMODAL(PAGE::"G/L Budget Entries",GLBudgetEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GLBudgetEntry.SETRANGE("Entry No.","Entry No.");
        GLBudgetEntries.SETRECORD(GLBudgetEntry);
        GLBudgetEntries.SETTABLEVIEW(GLBudgetEntry);
        GLBudgetEntries.RUNMODAL;
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
