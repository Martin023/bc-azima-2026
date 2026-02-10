#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186330 pageextension52186330 extends "Contact Segment List"
{

    //Unsupported feature: Property Modification (DataCaptionExpr) on ""Contact Segment List"(Page 5150)".


    //Unsupported feature: Property Modification (PageType) on ""Contact Segment List"(Page 5150)".

    layout
    {
        modify("Segment No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Date)
        {
            ApplicationArea = Basic;
        }
        modify("Contact No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Segment No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Date(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact No."(Control 13)".

        // modify("Contact Name")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter(Control1)
        {
            group(Control17)
            {
                // field("Contact Name"; Rec."Contact Name")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Contact Name';
                //     DrillDown = false;
                // }
            }
        }
    }
    actions
    {
        modify("&Card")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Card"(Action 12)".

    }

    var
        Text001: label 'untitled';
        Cont: Record Contact;

    //Unsupported feature: Variable Insertion (Variable: CaptionStr) (VariableCollection) on "Caption(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Name) on "GetCaption(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "GetCaption(PROCEDURE 1)".

    //procedure GetCaption();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF GETFILTER("Contact Company No.") <> '' THEN BEGIN
      SourceFilter := GETFILTER("Contact Company No.");
      IF MAXSTRLEN(Contact."Company No.") >= STRLEN(SourceFilter) THEN
        IF Contact.GET(SourceFilter) THEN
          Result := STRSUBSTNO('%1 %2',Contact."No.",Contact.Name);
    END;

    IF ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Phone THEN
      Result := STRSUBSTNO('%1 %2',CurrPage.CAPTION,Result);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF Cont.GET(GETFILTER("Contact Company No.")) THEN
      CaptionStr := COPYSTR(Cont."No." + ' ' + Cont.Name,1,MAXSTRLEN(CaptionStr));
    IF Cont.GET(GETFILTER("Contact No.")) THEN
      CaptionStr := COPYSTR(CaptionStr + ' ' + Cont."No." + ' ' + Cont.Name,1,MAXSTRLEN(CaptionStr));
    IF CaptionStr = '' THEN
      CaptionStr := Text001;

    EXIT(CaptionStr);
    */
    //end;

    //Unsupported feature: Property Deletion (Name) on "GetCaption(PROCEDURE 1).Result(ReturnValue)".


    //Unsupported feature: Property Insertion (Length) on "GetCaption(PROCEDURE 1).Result(ReturnValue)".


    //Unsupported feature: Deletion (VariableCollection) on "GetCaption(PROCEDURE 1).Contact(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "GetCaption(PROCEDURE 1).SourceFilter(Variable 1000)".

}
