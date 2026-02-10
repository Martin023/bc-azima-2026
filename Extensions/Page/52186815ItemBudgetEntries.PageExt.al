#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186815 pageextension52186815 extends "Item Budget Entries"
{
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
        modify("Item No.")
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
        modify("Global Dimension 1 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Global Dimension 1 Code"(Control 16)".

            Enabled = "Global Dimension 1 CodeEnable";
        }
        modify("Global Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Global Dimension 2 Code"(Control 18)".

            Enabled = "Global Dimension 2 CodeEnable";
        }
        modify("Budget Dimension 1 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Budget Dimension 1 Code"(Control 20)".

            Enabled = "Budget Dimension 1 CodeEnable";
        }
        modify("Budget Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Budget Dimension 2 Code"(Control 22)".

            Enabled = "Budget Dimension 2 CodeEnable";
        }
        modify("Budget Dimension 3 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Budget Dimension 3 Code"(Control 24)".

            Enabled = "Budget Dimension 3 CodeEnable";
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Cost Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Budget Name"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Date(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Type"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budget Dimension 1 Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budget Dimension 2 Code"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budget Dimension 3 Code"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Amount"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Amount"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 32)".

        modify("Dimension Set ID")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("<Action24>")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""<Action24>"(Action 3)".

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

        "Global Dimension 1 CodeEnable": Boolean;

        "Global Dimension 2 CodeEnable": Boolean;

        "Budget Dimension 1 CodeEnable": Boolean;

        "Budget Dimension 2 CodeEnable": Boolean;

        "Budget Dimension 3 CodeEnable": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    BudgetDimension3CodeEnable := TRUE;
    BudgetDimension2CodeEnable := TRUE;
    BudgetDimension1CodeEnable := TRUE;
    GlobalDimension2CodeEnable := TRUE;
    GlobalDimension1CodeEnable := TRUE;
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
    "Budget Dimension 3 CodeEnable" := TRUE;
    "Budget Dimension 2 CodeEnable" := TRUE;
    "Budget Dimension 1 CodeEnable" := TRUE;
    "Global Dimension 2 CodeEnable" := TRUE;
    "Global Dimension 1 CodeEnable" := TRUE;
    "Budget Dimension 3 CodeVisible" := TRUE;
    "Budget Dimension 2 CodeVisible" := TRUE;
    "Budget Dimension 1 CodeVisible" := TRUE;
    "Global Dimension 2 CodeVisible" := TRUE;
    "Global Dimension 1 CodeVisible" := TRUE;
    LowestModifiedEntryNo := 2147483647;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF GETFILTER("Budget Name") = '' THEN
      ItemBudgetName.INIT
    ELSE BEGIN
      COPYFILTER("Analysis Area",ItemBudgetName."Analysis Area");
      COPYFILTER("Budget Name",ItemBudgetName.Name);
      ItemBudgetName.FINDFIRST;
    END;
    CurrPage.EDITABLE := NOT ItemBudgetName.Blocked;
    GLSetup.GET;
    GlobalDimension1CodeEnable := GLSetup."Global Dimension 1 Code" <> '';
    GlobalDimension2CodeEnable := GLSetup."Global Dimension 2 Code" <> '';
    BudgetDimension1CodeEnable := ItemBudgetName."Budget Dimension 1 Code" <> '';
    BudgetDimension2CodeEnable := ItemBudgetName."Budget Dimension 2 Code" <> '';
    BudgetDimension3CodeEnable := ItemBudgetName."Budget Dimension 3 Code" <> '';
    GlobalDimension1CodeVisible := GLSetup."Global Dimension 1 Code" <> '';
    GlobalDimension2CodeVisible := GLSetup."Global Dimension 2 Code" <> '';
    BudgetDimension1CodeVisible := ItemBudgetName."Budget Dimension 1 Code" <> '';
    BudgetDimension2CodeVisible := ItemBudgetName."Budget Dimension 2 Code" <> '';
    BudgetDimension3CodeVisible := ItemBudgetName."Budget Dimension 3 Code" <> '';
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
    "Global Dimension 1 CodeEnable" := GLSetup."Global Dimension 1 Code" <> '';
    "Global Dimension 2 CodeEnable" := GLSetup."Global Dimension 2 Code" <> '';
    "Budget Dimension 1 CodeEnable" := ItemBudgetName."Budget Dimension 1 Code" <> '';
    "Budget Dimension 2 CodeEnable" := ItemBudgetName."Budget Dimension 2 Code" <> '';
    "Budget Dimension 3 CodeEnable" := ItemBudgetName."Budget Dimension 3 Code" <> '';
    "Global Dimension 1 CodeVisible" := GLSetup."Global Dimension 1 Code" <> '';
    "Global Dimension 2 CodeVisible" := GLSetup."Global Dimension 2 Code" <> '';
    "Budget Dimension 1 CodeVisible" := ItemBudgetName."Budget Dimension 1 Code" <> '';
    "Budget Dimension 2 CodeVisible" := ItemBudgetName."Budget Dimension 2 Code" <> '';
    "Budget Dimension 3 CodeVisible" := ItemBudgetName."Budget Dimension 3 Code" <> '';
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
