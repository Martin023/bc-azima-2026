#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186268 pageextension52186268 extends "Postponed Interactions"
{

    //Unsupported feature: Property Modification (PageType) on ""Postponed Interactions"(Page 5082)".

    layout
    {
        modify("Attempt Failed")
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Delivery Status")
        {
            ApplicationArea = Basic;
        }
        modify(Date)
        {
            ApplicationArea = Basic;
        }
        modify("Time of Interaction")
        {
            ApplicationArea = Basic;
        }
        modify("Correspondence Type")
        {
            ApplicationArea = Basic;
        }
        modify("Interaction Group Code")
        {
            ApplicationArea = Basic;
        }
        modify("Interaction Template Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("""Attachment No."" <> 0")
        {
            ApplicationArea = Basic;
        }
        modify("Information Flow")
        {
            ApplicationArea = Basic;
        }
        modify("Initiated By")
        {
            ApplicationArea = Basic;
        }
        modify("Contact No.")
        {
            ApplicationArea = Basic;
        }
        modify("Contact Company No.")
        {
            ApplicationArea = Basic;
        }
        modify(Evaluation)
        {
            ApplicationArea = Basic;
        }
        modify("Cost (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Duration (Min.)")
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;
        }
        modify("User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Segment No.")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign No.")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign Response")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign Target")
        {
            ApplicationArea = Basic;
        }
        modify("Opportunity No.")
        {
            ApplicationArea = Basic;
        }
        modify("To-do No.")
        {
            ApplicationArea = Basic;
        }
        modify("Interaction Language Code")
        {
            ApplicationArea = Basic;
        }
        modify(Subject)
        {
            ApplicationArea = Basic;
        }
        modify("Contact Via")
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify(Comment)
        {
            ApplicationArea = Basic;
        }
        modify("Contact Name")
        {
            ApplicationArea = Basic;
        }
        modify("Contact Company Name")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Attempt Failed"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Delivery Status"(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Date(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Time of Interaction"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Correspondence Type"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Group Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Template Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Attachment No." <> 0(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Information Flow"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Initiated By"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact No."(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Company No."(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Evaluation(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost (LCY)"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Duration (Min.)"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Segment No."(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign No."(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign Entry No."(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign Response"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign Target"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Opportunity No."(Control 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""To-do No."(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Language Code"(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Subject(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Via"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Control 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Name"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Company Name"(Control 79)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("&Delete")
        {
            ApplicationArea = Basic;
        }
        modify("Show Attachments")
        {

            //Unsupported feature: Property Modification (Name) on ""Show Attachments"(Action 4)".

            Caption = '&Show';
            ApplicationArea = Basic;
            Enabled = ShowEnable;
        }
        modify(Resume)
        {
            ApplicationArea = Basic;
            Enabled = ResumeEnable;
        }
        modify("Filter")
        {
            Visible = false;
        }
        modify(ClearFilter)
        {
            Visible = false;
        }

        //Unsupported feature: Code Modification on ""&Delete"(Action 54).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CONFIRM(Text001) THEN BEGIN
          CurrPage.SETSELECTIONFILTER(InteractionLogEntry);
          IF NOT InteractionLogEntry.ISEMPTY THEN
            InteractionLogEntry.DELETEALL(TRUE)
          ELSE
            DELETE(TRUE);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
        END
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Delete"(Action 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Attachments"(Action 4)".


        //Unsupported feature: Property Deletion (Scope) on ""Show Attachments"(Action 4)".



        //Unsupported feature: Code Modification on "Resume(Action 2).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ISEMPTY THEN
          EXIT;

        ResumeInteraction
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ResumeInteraction
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Resume(Action 2)".


        //Unsupported feature: Property Deletion (Scope) on "Resume(Action 2)".

    }

    var

        FunctionsEnable: Boolean;

        ShowEnable: Boolean;

        ResumeEnable: Boolean;


    //Unsupported feature: Code Insertion on "OnFindRecord".

    //trigger OnFindRecord()
    //Parameters and return type have not been exported.
    //var
    //RecordsFound: Boolean;
    //begin
    /*
    RecordsFound := FIND(Which);
    FunctionsEnable := RecordsFound;
    ShowEnable := RecordsFound;
    ResumeEnable := RecordsFound;
    EXIT(RecordsFound);
    */
    //end;


    //Unsupported feature: Code Insertion on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //begin
    /*
    ResumeEnable := TRUE;
    ShowEnable := TRUE;
    FunctionsEnable := TRUE;
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: SalespersonPurchaser) (VariableCollection) on "SetCaption(PROCEDURE 2)".


    //Unsupported feature: Variable Insertion (Variable: ToDo) (VariableCollection) on "SetCaption(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "SetCaption(PROCEDURE 2)".

    //procedure SetCaption();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Contact.GET("Contact Company No.") THEN
      CurrPage.CAPTION(CurrPage.CAPTION + ' - ' + Contact."Company No." + ' . ' + Contact."Company Name");
    IF Contact.GET("Contact No.") THEN BEGIN
      CurrPage.CAPTION(CurrPage.CAPTION + ' - ' + Contact."No." + ' . ' + Contact.Name);
      EXIT;
    END;
    IF "Contact Company No." <> '' THEN
      EXIT;
    IF Salesperson.GET("Salesperson Code") THEN BEGIN
      CurrPage.CAPTION(CurrPage.CAPTION + ' - ' + "Salesperson Code" + ' . ' + Salesperson.Name);
      EXIT;
    END;
    IF "Interaction Template Code" <> '' THEN BEGIN
      CurrPage.CAPTION(CurrPage.CAPTION + ' - ' + "Interaction Template Code");
      EXIT;
    END;
    IF Task.GET("To-do No.") THEN BEGIN
      CurrPage.CAPTION(CurrPage.CAPTION + ' - ' + Task."No." + ' . ' + Task.Description);
      EXIT;
    END;
    IF Opportunity.GET("Opportunity No.") THEN
      CurrPage.CAPTION(CurrPage.CAPTION + ' - ' + Opportunity."No." + ' . ' + Opportunity.Description);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    IF SalespersonPurchaser.GET("Salesperson Code") THEN BEGIN
      CurrPage.CAPTION(CurrPage.CAPTION + ' - ' + "Salesperson Code" + ' . ' + SalespersonPurchaser.Name);
    #11..16
    IF ToDo.GET("To-do No.") THEN BEGIN
      CurrPage.CAPTION(CurrPage.CAPTION + ' - ' + ToDo."No." + ' . ' + ToDo.Description);
    #19..22
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "SetCaption(PROCEDURE 2).Salesperson(Variable 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "SetCaption(PROCEDURE 2).Task(Variable 1002)".


    //Unsupported feature: Property Deletion (Editable).

}
