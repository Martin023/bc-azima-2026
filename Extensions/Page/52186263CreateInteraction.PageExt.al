#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186263 pageextension52186263 extends "Create Interaction"
{

    //Unsupported feature: Property Modification (PageType) on ""Create Interaction"(Page 5077)".

    layout
    {
        modify(General)
        {

            //Unsupported feature: Property Modification (Name) on "General(Control 1)".

            Caption = 'Step 1';

            //Unsupported feature: Property Insertion (Visible) on "General(Control 1)".


            //Unsupported feature: Property Insertion (InstructionalTextML) on "General(Control 1)".

        }
        // modify("Wizard Contact Name")
        // {
        //     Caption = 'Who are you interacting with?';
        //     ApplicationArea = Basic;
        //     Editable = "Wizard Contact NameEditable";
        // }
        modify("Interaction Template Code")
        {
            ApplicationArea = Basic;
            Caption = 'What is the type of interaction?';
        }
        modify(Description)
        {
            Caption = 'Describe your interaction.';
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
        {
            Caption = 'Who is the salesperson responsible?';
            ApplicationArea = Basic;
            Editable = "Salesperson CodeEditable";
        }
        // modify("Language Code")
        //{

        //Unsupported feature: Property Modification (Level) on ""Language Code"(Control 2)".


        //Unsupported feature: Property Modification (ControlType) on ""Language Code"(Control 2)".


        //Unsupported feature: Property Modification (Name) on ""Language Code"(Control 2)".

        // Caption = 'Step 2';

        //Unsupported feature: Property Insertion (Visible) on ""Language Code"(Control 2)".


        //Unsupported feature: Property Insertion (InstructionalTextML) on ""Language Code"(Control 2)".

        // }
        modify(BodyContent)
        {

            //Unsupported feature: Property Modification (Name) on "BodyContent(Control 4)".

            Caption = 'Step 4';

            //Unsupported feature: Property Modification (Visible) on "BodyContent(Control 4)".


            //Unsupported feature: Property Insertion (InstructionalTextML) on "BodyContent(Control 4)".

        }
        // modify(HTMLContentBodyText)
        // {

        //     //Unsupported feature: Property Modification (Level) on "HTMLContentBodyText(Control 5)".


        //     //Unsupported feature: Property Modification (ControlType) on "HTMLContentBodyText(Control 5)".


        //     //Unsupported feature: Property Modification (Name) on "HTMLContentBodyText(Control 5)".

        //     Caption = 'Step 5';

        //Unsupported feature: Property Insertion (Visible) on "HTMLContentBodyText(Control 5)".


        //Unsupported feature: Property Insertion (GroupType) on "HTMLContentBodyText(Control 5)".


        //Unsupported feature: Property Insertion (InstructionalTextML) on "HTMLContentBodyText(Control 5)".

        // }
        modify(InteractionDetails)
        {

            //Unsupported feature: Property Modification (Name) on "InteractionDetails(Control 3)".

            Caption = 'Step 3';

            //Unsupported feature: Property Insertion (Visible) on "InteractionDetails(Control 3)".


            //Unsupported feature: Property Insertion (InstructionalTextML) on "InteractionDetails(Control 3)".

        }
        modify("Correspondence Type")
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
        modify("Information Flow")
        {
            ApplicationArea = Basic;
            Caption = 'What is the direction of the information flow?';
        }
        modify("Initiated By")
        {
            ApplicationArea = Basic;
        }
        modify(Evaluation)
        {
            ApplicationArea = Basic;
            Caption = 'Enter the evaluation of the interaction here:';
        }
        modify("Interaction Successful")
        {
            Caption = 'The interaction attempt was successful.';
            ApplicationArea = Basic;
        }
        modify("Campaign Description")
        {
            Caption = 'What campaign is the interaction linked to?';
            ApplicationArea = Basic;
            Editable = "Campaign DescriptionEditable";

            //Unsupported feature: Property Insertion (MultiLine) on ""Campaign Description"(Control 20)".

        }
        modify("Campaign Target")
        {
            Caption = 'This contact is being targeted as part of a campaign.';
            ApplicationArea = Basic;
        }
        modify("Campaign Response")
        {
            Caption = 'This interaction is a response to a campaign.';
            ApplicationArea = Basic;
        }
        modify("Opportunity Description")
        {
            Caption = 'What is the opportunity?';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (GroupType) on "General(Control 1)".


        //Unsupported feature: Code Insertion (VariableCollection) on ""Wizard Contact Name"(Control 23).OnAssistEdit".

        //trigger (Variable: Cont)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Wizard Contact Name"(Control 23).OnAssistEdit".

        //trigger OnAssistEdit()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF IsContactEditable THEN BEGIN
          IF Contact.GET("Contact No.") THEN;
          IF PAGE.RUNMODAL(0,Contact) = ACTION::LookupOK THEN
            SetContactNo(Contact);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF (GETFILTER("Contact No.") = '') AND (GETFILTER("Contact Company No.") = '') THEN BEGIN
          IF Cont.GET("Contact No.") THEN ;
          IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
            VALIDATE("Contact No.",Cont."No.");
            "Wizard Contact Name" := Cont.Name;
          END;
        END;
        */
        //end;
        modify("Wizard Contact Name")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Wizard Contact Name"(Control 23)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Wizard Contact Name"(Control 23)".



        //Unsupported feature: Code Modification on ""Interaction Template Code"(Control 12).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdateUIFlags;

        IF Campaign.GET("Campaign No.") THEN
          "Campaign Description" := Campaign.Description;

        IF "Attachment No." <> xRec."Attachment No." THEN
          AttachmentReload;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        InteractionTemplateCodeOnAfter;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Template Code"(Control 12)".


        //Unsupported feature: Property Deletion (NotBlank) on ""Interaction Template Code"(Control 12)".


        //Unsupported feature: Property Deletion (Importance) on ""Interaction Template Code"(Control 12)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Interaction Template Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 27)".


        //Unsupported feature: Property Deletion (NotBlank) on "Description(Control 27)".


        //Unsupported feature: Property Deletion (Importance) on "Description(Control 27)".


        //Unsupported feature: Property Deletion (ShowMandatory) on "Description(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 22)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Salesperson Code"(Control 22)".

        // modify("Language Code")
        // {
        //     Visible = false;
        // }
        // modify("Language Code")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Language Code"(Control 2)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Language Code"(Control 2)".


        //Unsupported feature: Property Deletion (SourceExpr) on ""Language Code"(Control 2)".


        //Unsupported feature: Property Deletion (Enabled) on ""Language Code"(Control 2)".


        //Unsupported feature: Property Deletion (GroupType) on "BodyContent(Control 4)".

        modify(HTMLContentBodyText)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "HTMLContentBodyText(Control 5)".


        //Unsupported feature: Property Deletion (SourceExpr) on "HTMLContentBodyText(Control 5)".


        //Unsupported feature: Property Deletion (MultiLine) on "HTMLContentBodyText(Control 5)".


        //Unsupported feature: Property Deletion (ShowCaption) on "HTMLContentBodyText(Control 5)".


        //Unsupported feature: Property Deletion (Enabled) on "InteractionDetails(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Correspondence Type"(Control 45)".


        //Unsupported feature: Property Deletion (Importance) on ""Correspondence Type"(Control 45)".


        //Unsupported feature: Property Deletion (Enabled) on ""Correspondence Type"(Control 45)".


        //Unsupported feature: Property Deletion (CaptionML) on "Date(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Date(Control 50)".


        //Unsupported feature: Property Deletion (Importance) on "Date(Control 50)".


        //Unsupported feature: Property Deletion (Enabled) on "Date(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Time of Interaction"(Control 52)".


        //Unsupported feature: Property Deletion (Importance) on ""Time of Interaction"(Control 52)".


        //Unsupported feature: Property Deletion (Enabled) on ""Time of Interaction"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Information Flow"(Control 30)".


        //Unsupported feature: Property Deletion (Importance) on ""Information Flow"(Control 30)".


        //Unsupported feature: Property Deletion (Enabled) on ""Information Flow"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Initiated By"(Control 32)".


        //Unsupported feature: Property Deletion (Importance) on ""Initiated By"(Control 32)".


        //Unsupported feature: Property Deletion (Enabled) on ""Initiated By"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Evaluation(Control 34)".


        //Unsupported feature: Property Deletion (Importance) on "Evaluation(Control 34)".


        //Unsupported feature: Property Deletion (Enabled) on "Evaluation(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Successful"(Control 36)".


        //Unsupported feature: Property Deletion (Importance) on ""Interaction Successful"(Control 36)".


        //Unsupported feature: Property Deletion (Enabled) on ""Interaction Successful"(Control 36)".

        // modify("Cost (LCY)")
        // {
        //     Visible = false;
        // }
        // modify("Duration (Min.)")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign Description"(Control 20)".


        //Unsupported feature: Property Deletion (Importance) on ""Campaign Description"(Control 20)".


        //Unsupported feature: Property Deletion (Enabled) on ""Campaign Description"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign Target"(Control 51)".


        //Unsupported feature: Property Deletion (Importance) on ""Campaign Target"(Control 51)".


        //Unsupported feature: Property Deletion (Enabled) on ""Campaign Target"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign Response"(Control 53)".


        //Unsupported feature: Property Deletion (Importance) on ""Campaign Response"(Control 53)".


        //Unsupported feature: Property Deletion (Enabled) on ""Campaign Response"(Control 53)".



        //Unsupported feature: Code Modification on ""Opportunity Description"(Control 54).OnAssistEdit".

        //trigger OnAssistEdit()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        FilterContactCompanyOpportunities(Opportunity);
        IF PAGE.RUNMODAL(0,Opportunity) = ACTION::LookupOK THEN BEGIN
          VALIDATE("Opportunity No.",Opportunity."No.");
          "Opportunity Description" := Opportunity.Description;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF Opp.GET("Opportunity No.") THEN ;
        IF PAGE.RUNMODAL(0,Opp) = ACTION::LookupOK THEN BEGIN
          VALIDATE("Opportunity No.",Opp."No.");
          "Opportunity Description" := Opp.Description;
        END;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Opportunity Description"(Control 54)".


        //Unsupported feature: Property Deletion (Importance) on ""Opportunity Description"(Control 54)".


        //Unsupported feature: Property Deletion (Enabled) on ""Opportunity Description"(Control 54)".

        // addfirst("Language Code")
        // {
        //     label(Control28)
        //     {
        //         ApplicationArea = Basic;
        //         CaptionClass = Text19072056;
        //         MultiLine = true;
        //     }
        //     label(Control37)
        //     {
        //         ApplicationArea = Basic;
        //         CaptionClass = Text19041876;
        //         MultiLine = true;
        //     }
        // }
        addfirst(BodyContent)
        {
            // field("Cost (LCY)"; Rec."Cost (LCY)")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'What is the cost of the interaction (LCY)?';
            // }
            // field("Duration (Min.)"; Rec."Duration (Min.)")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'How long did the interaction last (Min.)?';
            // }
        }
        addafter("Interaction Template Code")
        {
            // field("Language Code"; Rec."Language Code")
            // {
            //     ApplicationArea = Basic;
            //     Enabled = "Language CodeEnable";
            // }
        }
        addafter("Correspondence Type")
        {
            label(Control47)
            {
                ApplicationArea = Basic;
                CaptionClass = Text19070369;
            }
        }
        // moveafter(Control1900000001;"Language Code")
        moveafter("Interaction Template Code"; "Salesperson Code")
        moveafter(Description; InteractionDetails)
    }
    actions
    {
        // modify(ActionContainer8)
        // {

        //     //Unsupported feature: Property Modification (Level) on "ActionContainer8(Action 8)".


        //     //Unsupported feature: Property Modification (ActionType) on "ActionContainer8(Action 8)".


        //     //Unsupported feature: Property Modification (Name) on "ActionContainer8(Action 8)".

        //     Caption = '&Back';
        //     Enabled = BackEnable;
        //     InFooterBar = true;

        //     //Unsupported feature: Property Insertion (Image) on "ActionContainer8(Action 8)".

        //     ApplicationArea = Basic;
        // }
        modify(Preview)
        {

            //Unsupported feature: Property Modification (Name) on "Preview(Action 9)".

            Caption = '&Next';
            ApplicationArea = Basic;
            Enabled = NextEnable;

            //Unsupported feature: Property Modification (Image) on "Preview(Action 9)".

            InFooterBar = true;
        }
        modify(Finish)
        {
            ApplicationArea = Basic;
            Enabled = FinishEnable;
            Caption = '&Finish';
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }


        //Unsupported feature: Code Insertion on "Back(Action 8)".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //begin
        /*
        ShowStep(FALSE);
        PerformPrevWizardStatus;
        ShowStep(TRUE);
        CurrPage.UPDATE(TRUE)
        */
        //end;

        //Unsupported feature: Property Deletion (ActionContainerType) on "ActionContainer8(Action 8)".



        //Unsupported feature: Code Modification on "Preview(Action 9).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PreviewHTMLContent;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckStatus;
        ShowStep(FALSE);
        PerformNextWizardStatus(AttachmentTemp);
        ShowStep(TRUE);
        CurrPage.UPDATE(TRUE);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Preview(Action 9)".


        //Unsupported feature: Property Deletion (Promoted) on "Preview(Action 9)".


        //Unsupported feature: Property Deletion (Visible) on "Preview(Action 9)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Preview(Action 9)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Preview(Action 9)".



        //Unsupported feature: Code Modification on "Finish(Action 10).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        FinishWizard(TRUE);
        IsFinished := TRUE;
        CurrPage.CLOSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        FinishWizard(TRUE,AttachmentTemp);
        IsFinished := TRUE;
        CurrPage.CLOSE;
        */
        //end;

        //Unsupported feature: Property Deletion (Promoted) on "Finish(Action 10)".


        //Unsupported feature: Property Deletion (Visible) on "Finish(Action 10)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Finish(Action 10)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Finish(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 6)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 6)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on ""Co&mments"(Action 6)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 6)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Co&mments"(Action 6)".

        addfirst(processing)
        {
        }
    }

    var
        Cont: Record Contact;


    //Unsupported feature: Property Modification (Id) on "IsFinished(Variable 1012)".

    //var
    //>>>> ORIGINAL VALUE:
    //IsFinished : 1012;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //IsFinished : 1017;
    //Variable type has not been exported.

    var
        Text001: label 'untitled';
    //Cont: Record Contact;

    var
        Todo: Record "To-do";
        Opp: Record Opportunity;
        AttachmentTemp: Record Attachment temporary;
        FormWidth: Integer;

    var

        "Language CodeEnable": Boolean;

        "Wizard Contact NameEditable": Boolean;

        "Campaign DescriptionEditable": Boolean;

    var

        "Salesperson CodeEditable": Boolean;
        CancelXPos: Integer;
        CancelYPos: Integer;
        CancelHeight: Integer;
        CancelWidth: Integer;
        FrmXPos: Integer;
        FrmYPos: Integer;
        FrmHeight: Integer;
        FrmWidth: Integer;

        Step1Visible: Boolean;

        Step2Visible: Boolean;

        Step3Visible: Boolean;

        Step4Visible: Boolean;

        Step5Visible: Boolean;

        BackEnable: Boolean;

        FinishEnable: Boolean;

        NextEnable: Boolean;
        Text19072056: label '- Open, then the relevant attachment is opened.';
        Text19041876: label '- Import, then the Import File dialog box is displayed.';
        Text19070369: label 'When did the interaction take place?';


    //Unsupported feature: Code Insertion on "OnClosePage".

    //trigger OnClosePage()
    //begin
    /*
    IF NOT IsFinished THEN
      FinishWizard(IsFinished,AttachmentTemp);
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalespersonCodeEditable := TRUE;
    OpportunityDescriptionEditable := TRUE;
    CampaignDescriptionEditable := TRUE;
    IsOnMobile := ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Phone;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    NextEnable := TRUE;
    "Salesperson CodeEditable" := TRUE;
    OpportunityDescriptionEditable := TRUE;
    "Campaign DescriptionEditable" := TRUE;
    "Wizard Contact NameEditable" := TRUE;
    "Language CodeEnable" := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CampaignDescriptionEditable := FALSE;
    OpportunityDescriptionEditable := FALSE;
    IsContactEditable := (GETFILTER("Contact No.") = '') AND (GETFILTER("Contact Company No.") = '');
    UpdateUIFlags;

    IF SalesPurchPerson.GET(GETFILTER("Salesperson Code")) THEN
      SalespersonCodeEditable := FALSE;

    AttachmentReload;

    IsFinished := FALSE;
    CurrPage.UPDATE(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    FormWidth := CancelXPos + CancelWidth + 220;
    FrmXPos := ROUND((FrmWidth - FormWidth) / 2,1) + FrmXPos;
    FrmYPos := 3000;
    FrmHeight := CancelYPos + CancelHeight + 220;
    FrmWidth := FormWidth;

    "Wizard Contact NameEditable" := FALSE;
    "Campaign DescriptionEditable" := FALSE;
    OpportunityDescriptionEditable := FALSE;

    "Language CodeEnable" := "Interaction Template Code" <> '';

    IF SalesPurchPerson.GET(GETFILTER("Salesperson Code")) THEN
      "Salesperson CodeEditable" := FALSE;

    LoadAttachment;
    ShowStep(TRUE);

    CurrPage.UPDATE(FALSE);
    */
    //end;


    //Unsupported feature: Code Modification on "Caption(PROCEDURE 1)".

    //procedure Caption();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Contact.GET(GETFILTER("Contact Company No.")) THEN
      CaptionStr := COPYSTR(Contact."No." + ' ' + Contact.Name,1,MAXSTRLEN(CaptionStr));
    IF Contact.GET(GETFILTER("Contact No.")) THEN
      CaptionStr := COPYSTR(CaptionStr + ' ' + Contact."No." + ' ' + Contact.Name,1,MAXSTRLEN(CaptionStr));
    IF SalesPurchPerson.GET(GETFILTER("Salesperson Code")) THEN
      CaptionStr := COPYSTR(CaptionStr + ' ' + SalesPurchPerson.Code + ' ' + SalesPurchPerson.Name,1,MAXSTRLEN(CaptionStr));
    IF Campaign.GET(GETFILTER("Campaign No.")) THEN
      CaptionStr := COPYSTR(CaptionStr + ' ' + Campaign."No." + ' ' + Campaign.Description,1,MAXSTRLEN(CaptionStr));
    IF Task.GET(GETFILTER("To-do No.")) THEN
      CaptionStr := COPYSTR(CaptionStr + ' ' + Task."No." + ' ' + Task.Description,1,MAXSTRLEN(CaptionStr));

    IF CaptionStr = '' THEN
      CaptionStr := UntitledTxt;

    OnAfterCaption(Rec,CaptionStr);
    EXIT(CaptionStr);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF Cont.GET(GETFILTER("Contact Company No.")) THEN
      CaptionStr := COPYSTR(Cont."No." + ' ' + Cont.Name,1,MAXSTRLEN(CaptionStr));
    IF Cont.GET(GETFILTER("Contact No.")) THEN
      CaptionStr := COPYSTR(CaptionStr + ' ' + Cont."No." + ' ' + Cont.Name,1,MAXSTRLEN(CaptionStr));
    #5..8
    IF Todo.GET(GETFILTER("To-do No.")) THEN
      CaptionStr := COPYSTR(CaptionStr + ' ' + Todo."No." + ' ' + Todo.Description,1,MAXSTRLEN(CaptionStr));

    IF CaptionStr = '' THEN
      CaptionStr := Text001;

    EXIT(CaptionStr);
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "OnAfterCaption(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Name) on "OnAfterCaption(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "OnAfterCaption(PROCEDURE 2)".

    //procedure OnAfterCaption();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CASE "Wizard Step" OF
      "Wizard Step"::"1":
        BEGIN
          Step1Visible := Visible;
          IF Visible THEN BEGIN
            BackEnable := FALSE;
            FinishEnable := FALSE;
            NextEnable := TRUE;
          END;
        END;
      "Wizard Step"::"2":
        BEGIN
          Step2Visible := Visible;
          IF Visible THEN BEGIN
            BackEnable := TRUE;
            FinishEnable := FALSE;
            NextEnable := TRUE;
          END;
        END;
      "Wizard Step"::"3":
        BEGIN
          Step3Visible := Visible;
          IF Visible THEN BEGIN
            BackEnable := TRUE;
            FinishEnable := TRUE;
            NextEnable := TRUE;
          END;
        END;
      "Wizard Step"::"4":
        BEGIN
          Step4Visible := Visible;
          IF Visible THEN BEGIN
            BackEnable := TRUE;
            FinishEnable := TRUE;
            NextEnable := TRUE;
          END;
        END;
      "Wizard Step"::"5":
        BEGIN
          Step5Visible := Visible;
          IF Visible THEN BEGIN
            BackEnable := TRUE;
            FinishEnable := TRUE;
            NextEnable := FALSE;
          END;
        END;
    END;
    */
    //end;

    local procedure InteractionTemplateCodeOnAfter()
    begin
        "Language CodeEnable" := Rec."Interaction Template Code" <> '';
        //if Campaign.Get(Rec."Campaign No.") then
        // Rec."Campaign Description" := Campaign.Description;
        if Rec."Attachment No." <> xRec."Attachment No." then
            Clear(AttachmentTemp);
    end;

    //Unsupported feature: Deletion (VariableCollection) on "Caption(PROCEDURE 1).Contact(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterCaption(PROCEDURE 2).SegmentLine(Parameter 1000)".


    //Unsupported feature: Property Deletion (AsVar) on "OnAfterCaption(PROCEDURE 2).CaptionStr(Parameter 1001)".


    //Unsupported feature: Property Modification (Name) on "OnAfterCaption(PROCEDURE 2).CaptionStr(Parameter 1001)".


    //Unsupported feature: Property Deletion (Length) on "OnAfterCaption(PROCEDURE 2).CaptionStr(Parameter 1001)".


    //Unsupported feature: Property Modification (Data type) on "OnAfterCaption(PROCEDURE 2).CaptionStr(Parameter 1001)".


    //Unsupported feature: Property Deletion (ShowFilter).

}
