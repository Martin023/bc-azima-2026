#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186700 pageextension52186700 extends "Resource Skills"
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

            //Unsupported feature: Property Modification (Visible) on ""No."(Control 4)".

        }
        modify("Skill Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Skill Code"(Control 6)".

        }
        modify("Assigned From")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Skill Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assigned From"(Control 11)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    var

        "Skill CodeVisible": Boolean;

        "No.Visible": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    NoVisible := TRUE;
    SkillCodeVisible := TRUE;
    TypeVisible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "No.Visible" := TRUE;
    "Skill CodeVisible" := TRUE;
    TypeVisible := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SkillCodeVisible := GETFILTER("Skill Code") = '';
    NoVisible := GETFILTER("No.") = '';

    TypeVisible := TRUE;

    #6..9
    END;

    FILTERGROUP(0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Skill CodeVisible" := GETFILTER("Skill Code") = '';
    "No.Visible" := GETFILTER("No.") = '';
    #3..12
    */
    //end;
}
