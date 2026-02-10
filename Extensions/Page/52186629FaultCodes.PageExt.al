#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186629 pageextension52186629 extends "Fault Codes"
{
    layout
    {
        modify("Fault Area Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Fault Area Code"(Control 9)".

        }
        modify("Symptom Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Symptom Code"(Control 11)".

        }
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Fault Area Code"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Symptom Code"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        // modify(ActionContainer5)
        // {
        //     Visible = false;
        // }
        modify("Import IRIS to Fault Code")
        {
            Visible = false;
        }
    }
    var

        "Fault Area CodeVisible": Boolean;

        "Symptom CodeVisible": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SymptomCodeVisible := TRUE;
    FaultAreaCodeVisible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Symptom CodeVisible" := TRUE;
    "Fault Area CodeVisible" := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FaultAreaCodeVisible := NOT CurrPage.LOOKUPMODE;
    SymptomCodeVisible := NOT CurrPage.LOOKUPMODE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Fault Area CodeVisible" := NOT CurrPage.LOOKUPMODE;
    "Symptom CodeVisible" := NOT CurrPage.LOOKUPMODE;
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
