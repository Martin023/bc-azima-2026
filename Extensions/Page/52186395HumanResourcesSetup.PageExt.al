#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186395 pageextension52186395 extends "Human Resources Setup" 
{
    layout
    {
        modify("Employee Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Base Unit of Measure")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Employee Nos."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Base Unit of Measure"(Control 4)".

        modify("Automatically Create Resource")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Human Res. Units of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Causes of Absence")
        {
            ApplicationArea = Basic;
        }
        modify("Causes of Inactivity")
        {
            ApplicationArea = Basic;
        }
        modify("Grounds for Termination")
        {
            ApplicationArea = Basic;
        }
        modify(Unions)
        {
            ApplicationArea = Basic;
        }
        modify("Employment Contracts")
        {
            ApplicationArea = Basic;
        }
        modify(Relatives)
        {
            ApplicationArea = Basic;
        }
        modify("Misc. Articles")
        {
            ApplicationArea = Basic;
        }
        modify(Confidential)
        {
            ApplicationArea = Basic;
        }
        modify(Qualifications)
        {
            ApplicationArea = Basic;
        }
        modify("Employee Statistics Groups")
        {
            ToolTip = 'Set up salary types, such as HOURLY or MONTHLY, that you use for statistical purposes. ';
            ApplicationArea = Basic;
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
