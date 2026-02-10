#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186326 pageextension52186326 extends "Contact Through"
{
    layout
    {
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Number)
        {
            ApplicationArea = Basic;
        }
        modify("E-Mail")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""E-Mail"(Control 4)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Number(Control 8)".


        //Unsupported feature: Property Deletion (ExtendedDatatype) on ""E-Mail"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E-Mail"(Control 4)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }

    //Unsupported feature: Property Modification (TextConstString) on "Text001(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Contact Emails;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Contact E-Mails;
    //Variable type has not been exported.

    var

        "E-MailVisible": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    EmailVisible := TRUE;
    NumberVisible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "E-MailVisible" := TRUE;
    NumberVisible := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SETFILTER(Number,'<>''''');
    IF FIND('-') THEN BEGIN
      CurrPage.CAPTION := Text000;
      NumberVisible := TRUE;
      EmailVisible := FALSE;
    END ELSE BEGIN
      RESET;
      SETFILTER("E-Mail",'<>''''');
      IF FIND('-') THEN BEGIN
        CurrPage.CAPTION := Text001;
        NumberVisible := FALSE;
        EmailVisible := TRUE;
      END ELSE
        CurrPage.CLOSE;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
      "E-MailVisible" := FALSE;
    #6..11
        "E-MailVisible" := TRUE;
    #13..15
    */
    //end;
}
