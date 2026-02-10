#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186983 pageextension52186983 extends "Configuration Completion" 
{
    layout
    {
        modify(BeforeSetupCloseMessage)
        {

            //Unsupported feature: Property Modification (Name) on "BeforeSetupCloseMessage(Control 5)".

            Caption = 'If you have finished setting up the company, select the profile that you want to use as your default, and then choose the OK button to close the page. Then restart the Microsoft Dynamics NAV client to apply the changes.';
            ApplicationArea = Basic;
        }
        // modify("Your Profile Code")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Your Profile Code"(Control 3)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on ""Your Profile Code"(Control 3)".

        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "BeforeSetupCloseMessage(Control 5)".

        modify("Your Profile Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (DrillDown) on ""Your Profile Code"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Your Profile Code"(Control 3)".


        //Unsupported feature: Property Deletion (Editable) on ""Your Profile Code"(Control 3)".

    }
    actions
    {
        modify(Users)
        {
            ApplicationArea = Basic;
        }
        modify("Users Personalization")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Users(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Users Personalization"(Action 8)".

    }

    //Unsupported feature: Code Modification on "OnClosePage".

    //trigger OnClosePage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SelectDefaultRoleCenter("Your Profile Code","Your Profile App ID","Your Profile Scope");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SelectDefaultRoleCenter("Your Profile Code");
        */
    //end;
}
