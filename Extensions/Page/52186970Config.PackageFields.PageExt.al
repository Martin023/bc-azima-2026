#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186970 pageextension52186970 extends "Config. Package Fields"
{
    layout
    {
        modify("Table ID")
        {
            ApplicationArea = Basic;
        }
        modify(Dimension)
        {
            ApplicationArea = Basic;
        }
        modify("Field ID")
        {
            ApplicationArea = Basic;
        }
        modify("Field Name")
        {
            ApplicationArea = Basic;
        }
        modify("Field Caption")
        {
            ApplicationArea = Basic;
        }
        modify("Include Field")
        {
            ApplicationArea = Basic;
            Enabled = IncludedEnabled;
        }
        modify("Validate Field")
        {
            ApplicationArea = Basic;
            Enabled = ValidateEnabled;
        }
        modify("Processing Order")
        {
            ApplicationArea = Basic;
        }
        modify("Primary Key")
        {
            ApplicationArea = Basic;
        }
        modify("Localize Field")
        {
            ApplicationArea = Basic;
        }
        modify("Relation Table ID")
        {
            ApplicationArea = Basic;
        }
        modify("Relation Table Caption")
        {
            ApplicationArea = Basic;
        }
        modify("Create Missing Codes")
        {
            ApplicationArea = Basic;
        }
        modify("Mapping Exists")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Table ID"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimension(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Field ID"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Field Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Field Caption"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Include Field"(Control 15)".


        //Unsupported feature: Property Deletion (Editable) on ""Include Field"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Validate Field"(Control 10)".


        //Unsupported feature: Property Deletion (Editable) on ""Validate Field"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Processing Order"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Primary Key"(Control 18)".

        modify(AutoIncrement)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Localize Field"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Relation Table ID"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Relation Table Caption"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Missing Codes"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Mapping Exists"(Control 22)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Set Included")
        {
            ApplicationArea = Basic;
        }
        modify("Clear Included")
        {
            ApplicationArea = Basic;
        }
        modify(Mapping)
        {
            ApplicationArea = Basic;
        }
        modify("Move Up")
        {
            ApplicationArea = Basic;
        }
        modify("Move Down")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Set Included"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Clear Included"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Mapping(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Move Up"(Action 16)".


        //Unsupported feature: Property Deletion (Promoted) on ""Move Up"(Action 16)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Move Up"(Action 16)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Move Up"(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Move Down"(Action 17)".


        //Unsupported feature: Property Deletion (Promoted) on ""Move Down"(Action 17)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Move Down"(Action 17)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Move Down"(Action 17)".

        modify("Change Related Table")
        {
            Visible = false;
        }
    }
    var
        IncludedEnabled: Boolean;
        ValidateEnabled: Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IncludedEditable := NOT "Primary Key";
    ValidateEditable := NOT "Primary Key";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IncludedEnabled := NOT "Primary Key";
    ValidateEnabled := NOT "Primary Key";
    */
    //end;
}
