#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186359 pageextension52186359 extends "Task Interaction Languages"
{

    //Unsupported feature: Property Modification (Name) on ""Task Interaction Languages"(Page 5196)".

    Caption = 'To-do Interaction Languages';
    layout
    {
        modify("Language Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("""Attachment No."" > 0")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Language Code"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Code Modification on ""Attachment No." > 0(Control 9).OnAssistEdit".

        //trigger " > 0(Control 9)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Attachment No." = 0 THEN
          CreateAttachment(("To-do No." = '') OR Task.Closed)
        ELSE
          OpenAttachment(("To-do No." = '') OR Task.Closed);
        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Attachment No." = 0 THEN
          CreateAttachment(("To-do No." = '') OR Todo.Closed)
        ELSE
          OpenAttachment(("To-do No." = '') OR Todo.Closed);
        CurrPage.UPDATE;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Attachment No." > 0(Control 9)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Open)
        {
            ApplicationArea = Basic;
        }
        modify(Create)
        {
            ApplicationArea = Basic;
        }
        modify("Copy &from")
        {
            ApplicationArea = Basic;
        }
        modify(Import)
        {
            ApplicationArea = Basic;
        }
        modify("E&xport")
        {
            ApplicationArea = Basic;
        }
        modify(Remove)
        {
            ApplicationArea = Basic;
        }


        //Unsupported feature: Code Modification on "Open(Action 13).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        OpenAttachment(("To-do No." = '') OR Task.Closed);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        OpenAttachment(("To-do No." = '') OR Todo.Closed);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Open(Action 13)".



        //Unsupported feature: Code Modification on "Create(Action 14).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CreateAttachment(("To-do No." = '') OR Task.Closed);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CreateAttachment(("To-do No." = '') OR Todo.Closed);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Create(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy &from"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Import(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xport"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Remove(Action 18)".

    }

    var
        Todo: Record "To-do";

        AttachmentEnable: Boolean;


    //Unsupported feature: Code Modification on "OnFindRecord".

    //trigger OnFindRecord()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RecordsFound := FIND(Which);
    CurrPage.EDITABLE := ("To-do No." <> '');
    IF Task.GET("To-do No.") THEN
      CurrPage.EDITABLE := NOT Task.Closed;

    EXIT(RecordsFound);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RecordsFound := FIND(Which);
    AttachmentEnable := ("To-do No." <> '');
    CurrPage.EDITABLE := ("To-do No." <> '');
    IF Todo.GET("To-do No.") THEN BEGIN
      CurrPage.EDITABLE := NOT Todo.Closed;
      AttachmentEnable := NOT Todo.Closed;
    END;
    EXIT(RecordsFound);
    */
    //end;


    //Unsupported feature: Code Insertion on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //begin
    /*
    AttachmentEnable := TRUE;
    */
    //end;
}
