#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185489 pageextension52185489 extends "Account Schedule Names" 
{
    Caption = 'Account Schedule Names';

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Account Schedule Names"(Page 103)".

    layout
    {
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        // modify("Default Column Layout")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Analysis View Name")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Default Column Layout"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Analysis View Name"(Control 11)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(EditAccountSchedule)
        {
            ApplicationArea = Basic;
        }
        // modify(EditColumnLayoutSetup)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(Overview)
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "EditAccountSchedule(Action 13)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "EditAccountSchedule(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "EditColumnLayoutSetup(Action 7)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "EditColumnLayoutSetup(Action 7)".

        modify(CopyAccountSchedule)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Overview(Action 5)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Overview(Action 5)".

        // modify(Reports)
        // {
        //     Visible = false;
        // }
        // modify(Print)
        // {
        //     Visible = false;
        // }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
