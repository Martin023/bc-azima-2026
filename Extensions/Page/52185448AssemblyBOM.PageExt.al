#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185448 pageextension52185448 extends "Assembly BOM"
{
    layout
    {
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Assembly BOM")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity per")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Installed in Item No.")
        {
            ApplicationArea = Basic;
        }
        modify(Position)
        {
            ApplicationArea = Basic;
        }
        modify("Position 2")
        {
            ApplicationArea = Basic;
        }
        modify("Position 3")
        {
            ApplicationArea = Basic;
        }
        modify("Machine No.")
        {
            ApplicationArea = Basic;
        }
        modify("Lead-Time Offset")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Usage Type")
        {
            ApplicationArea = Basic;
            Editable = IsResource;
            HideValue = not IsResource;
        }

        //Unsupported feature: Code Modification on "Type(Control 2).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IsEmptyOrItem := Type IN [Type::" ",Type::Item];
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IsResource := Type = Type::Resource
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assembly BOM"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity per"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Installed in Item No."(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Position(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Position 2"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Position 3"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Machine No."(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lead-Time Offset"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Usage Type"(Control 3)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control18(Control 18)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control17(Control 17)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control11(Control 11)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control13(Control 13)".


        //Unsupported feature: Property Deletion (Visible) on "Control13(Control 13)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control9(Control 9)".


        //Unsupported feature: Property Deletion (Visible) on "Control9(Control 9)".

    }
    actions
    {
        modify("E&xplode BOM")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""E&xplode BOM"(Action 19)".

        }
        modify(CalcStandardCost)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "CalcStandardCost(Action 5)".

        }
        modify(CalcUnitPrice)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "CalcUnitPrice(Action 15)".

        }
        modify("Show BOM")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xplode BOM"(Action 19)".


        //Unsupported feature: Property Deletion (Enabled) on ""E&xplode BOM"(Action 19)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""E&xplode BOM"(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CalcStandardCost(Action 5)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "CalcStandardCost(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CalcUnitPrice(Action 15)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "CalcUnitPrice(Action 15)".

        modify("Cost Shares")
        {
            Visible = false;
        }
        modify("Where-Used")
        {
            Visible = false;
        }
        modify(View)
        {
            Visible = false;
        }
        modify(AssemblyBOM)
        {
            Visible = false;
        }
    }

    var

        IsResource: Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsEmptyOrItem := Type IN [Type::" ",Type::Item];
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IsResource := Type = Type::Resource
    */
    //end;

    //Unsupported feature: Property Deletion (RefreshOnActivate).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
