#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186680 pageextension52186680 extends "Troubleshooting Setup"
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

            //Unsupported feature: Property Modification (Visible) on ""No."(Control 2)".

        }
        modify("Troubleshooting No.")
        {
            ApplicationArea = Basic;
        }
        modify("Troubleshooting Description")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Troubleshooting No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Troubleshooting Description"(Control 6)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Card)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 14)".

    }
    var

        "No.Visible": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    NoVisible := TRUE;
    TypeVisible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "No.Visible" := TRUE;
    TypeVisible := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TypeVisible := GETFILTER(Type) = '';
    NoVisible := GETFILTER("No.") = '';

    IF (GETFILTER(Type) <> '') AND (GETFILTER("No.") <> '') THEN BEGIN
      RecType := GETRANGEMIN(Type);
      No := GETRANGEMIN("No.");
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TypeVisible := GETFILTER(Type) = '';
    "No.Visible" := GETFILTER("No.") = '';

    IF (GETFILTER(Type) <> '') AND (GETFILTER("No.") <> '') THEN BEGIN
      xRec.VALIDATE(Type,GETRANGEMIN(Type));
      xRec.VALIDATE("No.",GETRANGEMIN("No."));
    END;
    */
    //end;
}
