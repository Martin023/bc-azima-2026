#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185503 pageextension52185503 extends "G/L Budget Entries"
{

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""G/L Budget Entries"(Page 120)".

    layout
    {
        modify("Budget Name")
        {
            ApplicationArea = Basic;
        }
        modify(Date)
        {
            ApplicationArea = Basic;
        }
        modify("G/L Account No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 1 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Global Dimension 1 Code"(Control 8)".

            Enabled = "Global Dimension 1 CodeEnable";
        }
        modify("Global Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Global Dimension 2 Code"(Control 10)".

            Enabled = "Global Dimension 2 CodeEnable";
        }
        modify("Budget Dimension 1 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Budget Dimension 1 Code"(Control 25)".

            Enabled = "Budget Dimension 1 CodeEnable";
        }
        modify("Budget Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Budget Dimension 2 Code"(Control 27)".

            Enabled = "Budget Dimension 2 CodeEnable";
        }
        modify("Budget Dimension 3 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Budget Dimension 3 Code"(Control 29)".

            Enabled = "Budget Dimension 3 CodeEnable";
        }
        modify("Budget Dimension 4 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Budget Dimension 4 Code"(Control 31)".

            Enabled = "Budget Dimension 4 CodeEnable";
        }
        modify("Business Unit Code")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Dimension Set ID")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Budget Name"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Date(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Account No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budget Dimension 1 Code"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budget Dimension 2 Code"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budget Dimension 3 Code"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budget Dimension 4 Code"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Business Unit Code"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension Set ID"(Control 3)".


        //Unsupported feature: Property Deletion (Visible) on ""Dimension Set ID"(Control 3)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 24)".

        modify(SetDimensionFilter)
        {
            Visible = false;
        }
    }
    var

        "Global Dimension 1 CodeVisible": Boolean;

        "Global Dimension 2 CodeVisible": Boolean;

        "Budget Dimension 1 CodeVisible": Boolean;

        "Budget Dimension 2 CodeVisible": Boolean;

        "Budget Dimension 3 CodeVisible": Boolean;

        "Budget Dimension 4 CodeVisible": Boolean;

        "Global Dimension 1 CodeEnable": Boolean;

        "Global Dimension 2 CodeEnable": Boolean;

        "Budget Dimension 1 CodeEnable": Boolean;

        "Budget Dimension 2 CodeEnable": Boolean;

        "Budget Dimension 3 CodeEnable": Boolean;

        "Budget Dimension 4 CodeEnable": Boolean;


    //Unsupported feature: Code Insertion on "OnClosePage".

    //trigger OnClosePage()
    //var
    //UpdateAnalysisView: Codeunit "Update Analysis View";
    //begin
    /*
    IF LowestModifiedEntryNo < 2147483647 THEN
      UpdateAnalysisView.SetLastBudgetEntryNo(LowestModifiedEntryNo - 1);
    */
    //end;


    //Unsupported feature: Code Modification on "OnDeleteRecord".

    //trigger OnDeleteRecord(): Boolean
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Entry No." < LowestModifiedEntryNo THEN BEGIN
      CurrPage.SETSELECTIONFILTER(GLBudgetEntry);
      GLBudgetEntry.SETCURRENTKEY("Entry No.");
      GLBudgetEntry.ASCENDING(TRUE);
      GLBudgetEntry.FINDFIRST;
      LowestModifiedEntryNo := GLBudgetEntry."Entry No.";
      UpdateAnalysisView.SetLastBudgetEntryNo(LowestModifiedEntryNo - 1);
    END;
    EXIT(IsEditable);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Entry No." < LowestModifiedEntryNo THEN
      LowestModifiedEntryNo := "Entry No.";
    EXIT(TRUE);
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    BudgetDimension4CodeEnable := TRUE;
    BudgetDimension3CodeEnable := TRUE;
    BudgetDimension2CodeEnable := TRUE;
    BudgetDimension1CodeEnable := TRUE;
    GlobalDimension2CodeEnable := TRUE;
    GlobalDimension1CodeEnable := TRUE;
    BudgetDimension4CodeVisible := TRUE;
    BudgetDimension3CodeVisible := TRUE;
    BudgetDimension2CodeVisible := TRUE;
    BudgetDimension1CodeVisible := TRUE;
    GlobalDimension2CodeVisible := TRUE;
    GlobalDimension1CodeVisible := TRUE;
    LowestModifiedEntryNo := 2147483647;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Budget Dimension 4 CodeEnable" := TRUE;
    "Budget Dimension 3 CodeEnable" := TRUE;
    "Budget Dimension 2 CodeEnable" := TRUE;
    "Budget Dimension 1 CodeEnable" := TRUE;
    "Global Dimension 2 CodeEnable" := TRUE;
    "Global Dimension 1 CodeEnable" := TRUE;
    "Budget Dimension 4 CodeVisible" := TRUE;
    "Budget Dimension 3 CodeVisible" := TRUE;
    "Budget Dimension 2 CodeVisible" := TRUE;
    "Budget Dimension 1 CodeVisible" := TRUE;
    "Global Dimension 2 CodeVisible" := TRUE;
    "Global Dimension 1 CodeVisible" := TRUE;
    LowestModifiedEntryNo := 2147483647;
    */
    //end;


    //Unsupported feature: Code Modification on "OnModifyRecord".

    //trigger OnModifyRecord(): Boolean
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Entry No." < LowestModifiedEntryNo THEN BEGIN
      LowestModifiedEntryNo := "Entry No.";
      UpdateAnalysisView.SetLastBudgetEntryNo(LowestModifiedEntryNo - 1);
    END;
    EXIT(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Entry No." < LowestModifiedEntryNo THEN
      LowestModifiedEntryNo := "Entry No.";
    EXIT(TRUE);
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF GETFILTER("Budget Name") = '' THEN
      GLBudgetName.INIT
    ELSE BEGIN
      COPYFILTER("Budget Name",GLBudgetName.Name);
      GLBudgetName.FINDFIRST;
    END;
    CurrPage.EDITABLE := NOT GLBudgetName.Blocked;
    GLSetup.GET;
    GlobalDimension1CodeEnable := GLSetup."Global Dimension 1 Code" <> '';
    GlobalDimension2CodeEnable := GLSetup."Global Dimension 2 Code" <> '';
    BudgetDimension1CodeEnable := GLBudgetName."Budget Dimension 1 Code" <> '';
    BudgetDimension2CodeEnable := GLBudgetName."Budget Dimension 2 Code" <> '';
    BudgetDimension3CodeEnable := GLBudgetName."Budget Dimension 3 Code" <> '';
    BudgetDimension4CodeEnable := GLBudgetName."Budget Dimension 4 Code" <> '';
    GlobalDimension1CodeVisible := GLSetup."Global Dimension 1 Code" <> '';
    GlobalDimension2CodeVisible := GLSetup."Global Dimension 2 Code" <> '';
    BudgetDimension1CodeVisible := GLBudgetName."Budget Dimension 1 Code" <> '';
    BudgetDimension2CodeVisible := GLBudgetName."Budget Dimension 2 Code" <> '';
    BudgetDimension3CodeVisible := GLBudgetName."Budget Dimension 3 Code" <> '';
    BudgetDimension4CodeVisible := GLBudgetName."Budget Dimension 4 Code" <> '';
    IsEditable := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    "Global Dimension 1 CodeEnable" := GLSetup."Global Dimension 1 Code" <> '';
    "Global Dimension 2 CodeEnable" := GLSetup."Global Dimension 2 Code" <> '';
    "Budget Dimension 1 CodeEnable" := GLBudgetName."Budget Dimension 1 Code" <> '';
    "Budget Dimension 2 CodeEnable" := GLBudgetName."Budget Dimension 2 Code" <> '';
    "Budget Dimension 3 CodeEnable" := GLBudgetName."Budget Dimension 3 Code" <> '';
    "Budget Dimension 4 CodeEnable" := GLBudgetName."Budget Dimension 4 Code" <> '';
    "Global Dimension 1 CodeVisible" := GLSetup."Global Dimension 1 Code" <> '';
    "Global Dimension 2 CodeVisible" := GLSetup."Global Dimension 2 Code" <> '';
    "Budget Dimension 1 CodeVisible" := GLBudgetName."Budget Dimension 1 Code" <> '';
    "Budget Dimension 2 CodeVisible" := GLBudgetName."Budget Dimension 2 Code" <> '';
    "Budget Dimension 3 CodeVisible" := GLBudgetName."Budget Dimension 3 Code" <> '';
    "Budget Dimension 4 CodeVisible" := GLBudgetName."Budget Dimension 4 Code" <> '';
    */
    //end;

    //Unsupported feature: Property Modification (Length) on "GetFirstBusUnit(PROCEDURE 5).ReturnValue".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
