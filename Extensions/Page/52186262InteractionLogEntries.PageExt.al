#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186262 pageextension52186262 extends "Interaction Log Entries"
{

    //Unsupported feature: Property Modification (PageType) on ""Interaction Log Entries"(Page 5076)".

    layout
    {
        modify(Canceled)
        {
            ApplicationArea = Basic;
        }
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
        modify(Attachment)
        {

            //Unsupported feature: Property Modification (Name) on "Attachment(Control 3)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "Canceled(Control 4)".


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


        //Unsupported feature: Property Deletion (ToolTipML) on "Attachment(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Information Flow"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Initiated By"(Control 20)".

        // modify("Contact No.")
        // {
        //     Visible = false;
        // }
        // modify("Contact Name")
        // {
        //     Visible = false;
        // }

        // //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Company No."(Control 24)".

        // modify("Contact Company Name")
        // {
        //     Visible = false;
        // }

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


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter("Initiated By")
        {
            // field("Contact No.";Rec."Contact No.")
            // {
            //     ApplicationArea = Basic;
            // }
        }
        // addafter(Control1)
        // {
        //     group(Control78)
        //     {
        //         field("Contact Name";Rec."Contact Name")
        //         {
        //             ApplicationArea = Basic;
        //             Caption = 'Contact Name';
        //             DrillDown = false;
        //         }
        //         field("Contact Company Name";Rec."Contact Company Name")
        //         {
        //             ApplicationArea = Basic;
        //             DrillDown = false;
        //         }
        //     }
        // }
    }
    actions
    {
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("Switch Check&mark in Canceled")
        {
            ApplicationArea = Basic;
        }
        modify(Resend)
        {
            ApplicationArea = Basic;
        }
        modify("Evaluate Interaction")
        {
            ApplicationArea = Basic;
        }
        modify("Create Task")
        {
            Caption = 'Create To-do';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Create Task"(Action 76)".

        }
        modify("Show Attachments")
        {

            //Unsupported feature: Property Modification (Name) on ""Show Attachments"(Action 2)".

            Caption = '&Show';
            ApplicationArea = Basic;
        }
        modify("Create &Interaction")
        {
            Caption = 'Create &Interact';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Create &Interaction"(Action 60)".

        }
        modify("Filter")
        {
            Visible = false;
        }
        modify(ClearFilter)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 83)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 83)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Switch Check&mark in Canceled"(Action 59)".



        //Unsupported feature: Code Modification on "Resend(Action 61).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        InteractLogEntry.SETRANGE("Logged Segment Entry No.","Logged Segment Entry No.");
        InteractLogEntry.SETRANGE("Entry No.","Entry No.");
        REPORT.RUNMODAL(REPORT::"Resend Attachments",TRUE,FALSE,InteractLogEntry);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        InteractLogEntry.SETRANGE("Logged Segment Entry No.","Logged Segment Entry No.");
        InteractLogEntry.SETRANGE("Entry No.","Entry No.");
        ResendAttachments.SETTABLEVIEW(InteractLogEntry);
        ResendAttachments.RUNMODAL;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Resend(Action 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Evaluate Interaction"(Action 85)".



        //Unsupported feature: Code Modification on ""Create Task"(Action 76).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CreateTask;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CreateTodo;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Task"(Action 76)".

        modify("Delete Canceled Entries")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Attachments"(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create &Interaction"(Action 60)".

        modify(CreateOpportunity)
        {
            Visible = false;
        }
    }

    var
        ResendAttachments: Report "Resend Attachments";

    var

        FunctionsEnable: Boolean;

    var

        EntryEnable: Boolean;


    //Unsupported feature: Code Modification on "OnFindRecord".

    //trigger OnFindRecord()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RecordsFound := FIND(Which);
    ShowEnable := RecordsFound;
    EXIT(RecordsFound);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RecordsFound := FIND(Which);
    FunctionsEnable := RecordsFound;
    ShowEnable := RecordsFound;
    EntryEnable := RecordsFound;
    EXIT(RecordsFound);
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowEnable := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    EntryEnable := TRUE;
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

    //Unsupported feature: Deletion (VariableCollection) on "SetCaption(PROCEDURE 2).Salesperson(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "SetCaption(PROCEDURE 2).Task(Variable 1002)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
