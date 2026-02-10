#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185856 pageextension52185856 extends "Change Log Setup"
{
    layout
    {
        modify("Change Log Activated")
        {
            ApplicationArea = Basic;
            trigger OnBeforeValidate()
            var
                myInt: Integer;
                UserSetup: Record "User Setup";
            begin
                UserSetup.Get(UserId);
                if UserSetup.Admin = false then
                    error('You are not authorized to perform this action.')

            end;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Change Log Activated"(Control 2)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Tables)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Tables(Action 6)".


        //Unsupported feature: Property Deletion (Promoted) on "Tables(Action 6)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Tables(Action 6)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Tables(Action 6)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
