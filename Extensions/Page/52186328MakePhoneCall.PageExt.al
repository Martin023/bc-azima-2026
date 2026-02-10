#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186328 pageextension52186328 extends "Make Phone Call"
{

    //Unsupported feature: Property Modification (PageType) on ""Make Phone Call"(Page 5147)".

    layout
    {
        modify("Phone Call")
        {

            //Unsupported feature: Property Modification (Name) on ""Phone Call"(Control 1)".

            Caption = 'Step 1';

            //Unsupported feature: Property Insertion (Visible) on ""Phone Call"(Control 1)".


            //Unsupported feature: Property Insertion (InstructionalTextML) on ""Phone Call"(Control 1)".

        }
        modify("Wizard Contact Name")
        {
            Caption = 'Call to Contact Name';
            ApplicationArea = Basic;
            Editable = "Wizard Contact NameEditable";
        }
        modify("Contact Via")
        {
            Caption = 'What is their phone number?';
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            Caption = 'Describe the call.';
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
        {
            Caption = 'Who is the salesperson responsible?';
            ApplicationArea = Basic;
        }
        modify("Initiated By")
        {
            Caption = 'Who initiated the call?';
            ApplicationArea = Basic;
        }
        modify("Phone Call Result")
        {

            //Unsupported feature: Property Modification (Name) on ""Phone Call Result"(Control 2)".

            Caption = 'Step 2';

            //Unsupported feature: Property Insertion (Visible) on ""Phone Call Result"(Control 2)".


            //Unsupported feature: Property Insertion (InstructionalTextML) on ""Phone Call Result"(Control 2)".

        }
        modify(Description2)
        {
            Caption = 'Describe the call.';
            ApplicationArea = Basic;
        }
        modify("Cost (LCY)")
        {
            Caption = 'What was the cost of the phone call (LCY)?';
            ApplicationArea = Basic;
        }
        modify("Duration (Min.)")
        {
            Caption = 'How long did the phone call last (Min.)?';
            ApplicationArea = Basic;
        }
        modify(Evaluation)
        {
            Caption = 'What is your evaluation of the phone call?';
            ApplicationArea = Basic;
        }
        modify("Interaction Successful")
        {
            Caption = 'The attempt was successful.';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Wizard Contact Name"(Control 18)".


        //Unsupported feature: Property Deletion (Importance) on ""Wizard Contact Name"(Control 18)".


        //Unsupported feature: Code Insertion (VariableCollection) on ""Contact Via"(Control 20).OnAssistEdit".

        //trigger (Variable: ContactVia)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Contact Via"(Control 20).OnAssistEdit".

        //trigger OnAssistEdit()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CLEAR(TAPIManagement);
        "Contact Via" :=
          COPYSTR(TAPIManagement.ShowNumbers("Contact No.","Contact Alt. Address Code"),1,MAXSTRLEN("Contact Via"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CLEAR(TAPIManagement);
        ContactVia := TAPIManagement.ShowNumbers(Cont."No.","Contact Alt. Address Code");
        IF ContactVia <> '' THEN
          "Contact Via" := ContactVia;
        */
        //end;

        //Unsupported feature: Property Deletion (ExtendedDatatype) on ""Contact Via"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Via"(Control 20)".


        //Unsupported feature: Property Deletion (Importance) on ""Contact Via"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 23)".


        //Unsupported feature: Property Deletion (Importance) on "Description(Control 23)".


        //Unsupported feature: Property Deletion (ShowMandatory) on "Description(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 25)".


        //Unsupported feature: Property Deletion (Importance) on ""Salesperson Code"(Control 25)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Salesperson Code"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Initiated By"(Control 32)".


        //Unsupported feature: Property Deletion (Importance) on ""Initiated By"(Control 32)".

        modify(Date)
        {
            Visible = false;
        }
        modify("Time of Interaction")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description2(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost (LCY)"(Control 28)".


        //Unsupported feature: Property Deletion (Importance) on ""Cost (LCY)"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Duration (Min.)"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Evaluation(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Successful"(Control 16)".

        modify(Details)
        {
            Visible = false;
        }
        // modify("Campaign Description")
        // {
        //     Visible = false;
        // }
        // modify("Campaign Target")
        // {
        //     Visible = false;
        // }
        // modify("Campaign Response")
        // {
        //     Visible = false;
        // }
        // modify("Opportunity Description")
        // {
        //     Visible = false;
        // }
        addfirst(Content)
        {
            // group(Step3)
            // {
            //     Caption = 'Step 3';
            //     InstructionalText = 'The following fields are optional.';
            //     Visible = Step3Visible;
            //     field("Campaign Description";Rec."Campaign Description")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'What campaign is the interaction linked to?';
            //         Editable = "Campaign DescriptionEditable";
            //         Lookup = false;
            //         MultiLine = true;
            //         TableRelation = Campaign;

            //         trigger OnAssistEdit()
            //         var
            //             Campaign: Record Campaign;
            //         begin
            //             if Campaign.Get(Rec."Campaign No.") then ;
            //             if Page.RunModal(0,Campaign) = Action::LookupOK then begin
            //               Rec.Validate(Rec."Campaign No.",Campaign."No.");
            //               Rec."Campaign Description" := Campaign.Description;
            //             end;
            //         end;
            //   ookup = false;
            //         TableRelation = Opportunity;

            //         trigger OnAssistEdit()
            //         begin
            //             if Opp.Get(Rec."Opportunity No.") then ;
            //             if Page.RunModal(0,Opp) = Action::LookupOK then begin
            //               Rec.Validate(Rec."Opportunity No.",Opp."No.");
            //               Rec."Opportunity Description" := Opp.Description;
            //           // }
            // field("Campaign Target";Rec."Campaign Target")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'This contact is being targeted as part of a campaign.';
            //     Editable = "Campaign TargetEditable";
            // }
            // field("Campaign Response";Rec."Campaign Response")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'This interaction is a response to a campaign.';
            //     Editable = "Campaign ResponseEditable";
            // }
            // field("Opportunity Description";Rec."Opportunity Description")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'What is the opportunity?';
            //     //Editable = OpportunityDescriptionEditable;
            //     L    end;
            //     end;
            //         // }
            //     }
            // }
            // addafter("Initiated By")
            // {
            //     field("Dial Contact";Rec."Dial Contact")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Dial Contact on Next';
            //     }
            // }
            // }
            // actions
            // {
            //     // modify(Finish)
            // {

            //     //Unsupported feature: Property Modification (Name) on "Finish(Action 8)".

            //     ApplicationArea = Basic;

            //     //Unsupported feature: Property Modification (Image) on "Finish(Action 8)".

            //     Caption = '&Back';
            //     Enabled = BackEnable;
            //     InFooterBar = true;
            // }
            // modify(OpenCommentsPage)
            // {

            //     //Unsupported feature: Property Modification (Name) on "OpenCommentsPage(Action 9)".

            //     Caption = '&Next';
            //     ApplicationArea = Basic;

            //     //Unsupported feature: Property Modification (Image) on "OpenCommentsPage(Action 9)".

            //     Enabled = NextEnable;
            //     InFooterBar = true;
            // }
            // modify("Make Phone Call")
            // {
            //     Visible = false;
            // }


            //Unsupported feature: Code Modification on "Finish(Action 8).OnAction".

            //trigger OnAction()
            //Parameters and return type have not been exported.
            //>>>> ORIGINAL CODE:
            //begin
            /*
            LogCall;
            CurrPage.CLOSE;
            */
            //end;
            //>>>> MODIFIED CODE:
            //begin
            /*
            ShowStep(FALSE);
            PerformPrevWizardStatus2;
            CurrPage.UPDATE(TRUE);
            ShowStep(TRUE);
            */
            //end;

            //Unsupported feature: Property Deletion (Promoted) on "Finish(Action 8)".


            //Unsupported feature: Property Deletion (Visible) on "Finish(Action 8)".


            //Unsupported feature: Property Deletion (PromotedCategory) on "Finish(Action 8)".



            //Unsupported feature: Code Modification on "OpenCommentsPage(Action 9).OnAction".

            //trigger OnAction()
            //Parameters and return type have not been exported.
            //>>>> ORIGINAL CODE:
            //begin
            /*
            ShowComment;
            */
            //end;
            //>>>> MODIFIED CODE:
            //begin
            /*
            CheckStatus2;
            ShowStep(FALSE);
            PerformNextWizardStatus2;
            CurrPage.UPDATE(TRUE);
            ShowStep(TRUE);
            PerformPostStep2;
            */
            //end;

            //Unsupported feature: Property Deletion (ToolTipML) on "OpenCommentsPage(Action 9)".


            //Unsupported feature: Property Deletion (Promoted) on "OpenCommentsPage(Action 9)".


            //Unsupported feature: Property Deletion (PromotedCategory) on "OpenCommentsPage(Action 9)".

            // addafter(OpenCommentsPage)
            // {
            //     // action(Finish)
            // {
            //     ApplicationArea = Basic;
            //     Caption = '&Finish';
            //     Enabled = FinishEnable;
            //     Image = Approve;
            //     InFooterBar = true;

            //     trigger OnAction()
            //     begin
            //         // CheckStatus2;
            //         // FinishWizard2;
            //         CurrPage.Close;
            //     end;
            // }
        }
    }

    var
        ContactVia: Text[80];

    var
        Cont: Record Contact;

    var
        Opp: Record Opportunity;
        TAPIManagement: Codeunit TAPIManagement;
        FormWidth: Integer;

        "Campaign DescriptionEditable": Boolean;

    var

        "Wizard Contact NameEditable": Boolean;

        "Campaign ResponseEditable": Boolean;

        "Campaign TargetEditable": Boolean;
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

        FinishEnable: Boolean;

        BackEnable: Boolean;

        NextEnable: Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CampaignTargetEditable := TRUE;
    CampaignResponseEditable := TRUE;
    OpportunityDescriptionEditable := TRUE;
    CampaignDescriptionEditable := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    NextEnable := TRUE;
    "Campaign TargetEditable" := TRUE;
    "Campaign ResponseEditable" := TRUE;
    "Wizard Contact NameEditable" := TRUE;
    OpportunityDescriptionEditable := TRUE;
    "Campaign DescriptionEditable" := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CampaignDescriptionEditable := FALSE;
    OpportunityDescriptionEditable := FALSE;
    WizardContactNameEditable := (GETFILTER("Contact No.") = '') AND (GETFILTER("Contact Company No.") = '');
    IF Campaign.GET(GETFILTER("Campaign No.")) THEN BEGIN
      CampaignResponseEditable := FALSE;
      CampaignTargetEditable := FALSE;
    END;
    IsOnMobile := ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Phone;
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

    "Campaign DescriptionEditable" := FALSE;
    OpportunityDescriptionEditable := FALSE;

    IF Cont.GET(GETFILTER("Contact No.")) OR Cont.GET(GETFILTER("Contact Company No."))THEN
      "Wizard Contact NameEditable" := FALSE;
    IF Campaign.GET(GETFILTER("Campaign No.")) THEN BEGIN
      "Campaign ResponseEditable" := FALSE;
      "Campaign TargetEditable" := FALSE;
    END;

    ShowStep(TRUE);
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
    IF CaptionStr = '' THEN
      CaptionStr := Text001;

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
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: Visible) (ParameterCollection) on "ShowStep(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Name) on "LogCall(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "LogCall(PROCEDURE 2)".

    //procedure LogCall();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CheckPhoneCallStatus;
    LogPhoneCall;
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
            FinishEnable := FALSE;
            BackEnable := FALSE;
            NextEnable := TRUE;
          END;
        END;
      2:
        BEGIN
          Step2Visible := Visible;
          IF Visible THEN BEGIN
            FinishEnable := TRUE;
            BackEnable := TRUE;
            NextEnable := TRUE;
          END;
        END;
      3:
        BEGIN
          Step3Visible := Visible;
          IF Visible THEN BEGIN
            FinishEnable := TRUE;
            BackEnable := TRUE;
            NextEnable := FALSE;
          END;
        END;
    END;
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "Caption(PROCEDURE 1).Contact(Variable 1001)".

}
