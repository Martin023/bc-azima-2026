#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186327 pageextension52186327 extends "Assign Activity"
{

    //Unsupported feature: Property Modification (PageType) on ""Assign Activity"(Page 5146)".

    layout
    {
        modify("Activity Setup")
        {

            //Unsupported feature: Property Modification (Name) on ""Activity Setup"(Control 1)".

            Caption = 'Step 1';

            //Unsupported feature: Property Insertion (Visible) on ""Activity Setup"(Control 1)".


            //Unsupported feature: Property Insertion (InstructionalTextML) on ""Activity Setup"(Control 1)".

        }
        modify("Activity Code")
        {
            Caption = 'What is the activity code?';
            ApplicationArea = Basic;
        }
        modify(Date)
        {
            Caption = 'What is the activity start date?';
            ApplicationArea = Basic;
        }
        modify("Wizard Contact Name")
        {
            Caption = 'Which contact is involved in this activity?';
            ApplicationArea = Basic;
            Editable = "Wizard Contact NameEditable";
        }
        modify("Salesperson Code")
        {
            Caption = 'Who is the salesperson responsible?';
            ApplicationArea = Basic;
            Editable = "Salesperson CodeEditable";
        }
        modify("Team Code")
        {
            Caption = 'Which team is involved in this activity?';
            ApplicationArea = Basic;
            Editable = "Team CodeEditable";
        }
        modify("Team Meeting Organizer")
        {
            Caption = 'Who is the meeting organizer?';
            ApplicationArea = Basic;
            Editable = "Team Meeting OrganizerEditable";
        }
        modify("Wizard Campaign Description")
        {
            Caption = 'Specify a campaign here';
            ApplicationArea = Basic;
            Editable = WizardCampaignDescriptionEdita;
        }
        modify("Segment Description")
        {
            Caption = 'Create to-dos for segment';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on ""Activity Code"(Control 23).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT Activity.IncludesMeeting("Activity Code") THEN BEGIN
          TeamMeetingOrganizerEditable := FALSE;
          "Team Meeting Organizer" := ''
        END ELSE
          IF "Team Code" <> '' THEN BEGIN
            TeamMeetingOrganizerEditable := TRUE;
            "Team Meeting Organizer" := ''
          END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF NOT Activity.IncludesMeeting("Activity Code") THEN BEGIN
          "Team Meeting OrganizerEditable" := FALSE;
        #3..5
            "Team Meeting OrganizerEditable" := TRUE;
            "Team Meeting Organizer" := ''
          END;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Activity Code"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Date(Control 9)".



        //Unsupported feature: Code Modification on ""Wizard Contact Name"(Control 15).OnAssistEdit".

        //trigger OnAssistEdit()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Wizard Contact Name" = '') AND NOT SegHeader.GET(GETFILTER("Segment No.")) THEN BEGIN
          IF Cont.GET("Contact No.") THEN ;
          IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
            VALIDATE("Contact No.",Cont."No.");
            CurrPage.SETSELECTIONFILTER(Rec);
            "Wizard Contact Name" := Cont.Name;
          END;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        #6..8
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Wizard Contact Name"(Control 15)".



        //Unsupported feature: Code Modification on ""Salesperson Code"(Control 16).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF SalesPurchPerson.GET("Salesperson Code") THEN BEGIN
          TeamMeetingOrganizerEditable := FALSE;
          "Team Meeting Organizer" := '';
          "Team Code" := ''
        END ELSE
          IF Activity.IncludesMeeting("Activity Code") OR
             ("Activity Code" = '') AND
             ("Team Code" <> '')
          THEN
            TeamMeetingOrganizerEditable := TRUE
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF SalesPurchPerson.GET("Salesperson Code") THEN BEGIN
          "Team Meeting OrganizerEditable" := FALSE;
        #3..9
            "Team Meeting OrganizerEditable" := TRUE
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 16)".



        //Unsupported feature: Code Modification on ""Team Code"(Control 18).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Team.GET("Team Code") THEN BEGIN
          IF Activity.IncludesMeeting("Activity Code") THEN
            TeamMeetingOrganizerEditable := TRUE;
          "Salesperson Code" := '';
        END;
        IF "Team Code" = '' THEN BEGIN
          TeamMeetingOrganizerEditable := FALSE;
          "Team Meeting Organizer" := ''
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF Team.GET("Team Code") THEN BEGIN
          IF Activity.IncludesMeeting("Activity Code") THEN
            "Team Meeting OrganizerEditable" := TRUE;
        #4..6
          "Team Meeting OrganizerEditable" := FALSE;
          "Team Meeting Organizer" := ''
        END;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Team Code"(Control 18)".



        //Unsupported feature: Code Modification on ""Team Meeting Organizer"(Control 26).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SalesPurchPerson.LOOKUPMODE := TRUE;
        IF SalesPurchPerson.RUNMODAL = ACTION::LookupOK THEN BEGIN
          SalesPurchPerson.GETRECORD(Salesperson);
          IF TeamMeetingOrganizerEditable THEN
            "Team Meeting Organizer" := Salesperson.Code
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
          IF "Team Meeting OrganizerEditable" THEN
            "Team Meeting Organizer" := Salesperson.Code
        END;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Team Meeting Organizer"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Wizard Campaign Description"(Control 13)".


        //Unsupported feature: Property Deletion (Importance) on ""Wizard Campaign Description"(Control 13)".



        //Unsupported feature: Code Modification on ""Segment Description"(Control 21).OnAssistEdit".

        //trigger OnAssistEdit()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Segment.GET("Segment No.") THEN ;
        IF PAGE.RUNMODAL(0,Segment) = ACTION::LookupOK THEN BEGIN
          VALIDATE("Segment No.",Segment."No.");
          "Segment Description" := Segment.Description;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF Segment.GET("Segment No.") THEN ;
        IF PAGE.RUNMODAL(0,Segment) = ACTION::LookupOK THEN
          IF "Segment DescriptionEditable" THEN BEGIN
            VALIDATE("Segment No.",Segment."No.");
            "Segment Description" := Segment.Description;
          END;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Segment Description"(Control 21)".


        //Unsupported feature: Property Deletion (Importance) on ""Segment Description"(Control 21)".

        addafter("Activity Setup")
        {
            group(Step2)
            {
                Caption = 'Step 2';
                InstructionalText = 'You can now specify optional detailed information regarding the To-dos.';
                Visible = Step2Visible;
            }
        }
    }
    actions
    {
        modify(Finish)
        {
            ApplicationArea = Basic;
            Enabled = FinishEnable;
        }


        //Unsupported feature: Code Modification on "Finish(Action 10).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckAssignActivityStatus;
        FinishAssignActivity;
        CurrPage.CLOSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckStatus2;
        FinishWizard2;
        CurrPage.CLOSE;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Finish(Action 10)".


        //Unsupported feature: Property Deletion (Promoted) on "Finish(Action 10)".


        //Unsupported feature: Property Deletion (Visible) on "Finish(Action 10)".

        addfirst(Processing)
        {
            action(Back)
            {
                ApplicationArea = Basic;
                Caption = '&Back';
                Enabled = BackEnable;
                Image = PreviousRecord;
                InFooterBar = true;

                trigger OnAction()
                begin
                    ShowStep(false);
                    // PerformPrevWizardStatus2;
                    ShowStep(true);
                    CurrPage.Update(true);
                end;
            }
            action(Next)
            {
                ApplicationArea = Basic;
                Caption = '&Next';
                Enabled = NextEnable;
                Image = NextRecord;
                InFooterBar = true;

                trigger OnAction()
                begin
                    // CheckStatus2;
                    ShowStep(false);
                    // PerformNextWizardStatus2;
                    ShowStep(true);
                    CurrPage.Update(true);
                end;
            }
        }
    }

    var
        FormWidth: Integer;

    var

        "Segment DescriptionEditable": Boolean;

        "Team Meeting OrganizerEditable": Boolean;

        "Wizard Contact NameEditable": Boolean;

        WizardCampaignDescriptionEdita: Boolean;

        "Salesperson CodeEditable": Boolean;

        "Team CodeEditable": Boolean;
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

        FinishEnable: Boolean;

        BackEnable: Boolean;

        NextEnable: Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TeamCodeEditable := TRUE;
    SalespersonCodeEditable := TRUE;
    WizardContactNameEditable := TRUE;
    TeamMeetingOrganizerEditable := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    NextEnable := TRUE;
    "Team CodeEditable" := TRUE;
    "Salesperson CodeEditable" := TRUE;
    WizardCampaignDescriptionEdita := TRUE;
    "Wizard Contact NameEditable" := TRUE;
    "Team Meeting OrganizerEditable" := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WizardContactNameEditable := FALSE;
    IsOnMobile := ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Phone;

    IF SalesPurchPerson.GET(GETFILTER("Salesperson Code")) OR
       Team.GET(GETFILTER("Team Code"))
    THEN BEGIN
      SalespersonCodeEditable := FALSE;
      TeamCodeEditable := FALSE;
    END;

    IF SalesPurchPerson.GET(GETFILTER("Salesperson Code")) OR
       ("Salesperson Code" <> '') OR
       ("Activity Code" = '')
    THEN
      TeamMeetingOrganizerEditable := FALSE;

    IF Campaign.GET(GETFILTER("Campaign No.")) THEN
      "Campaign Description" := Campaign.Description;

    IF SegHeader.GET(GETFILTER("Segment No.")) THEN
      "Segment Description" := SegHeader.Description;
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
    WizardCampaignDescriptionEdita := FALSE;
    #3..6
      "Salesperson CodeEditable" := FALSE;
      "Team CodeEditable" := FALSE;
    #9..14
      "Team Meeting OrganizerEditable" := FALSE;
    #16..21

    ShowStep(TRUE);
    */
    //end;

    local procedure ShowStep(Visible: Boolean)
    begin
        case Rec."Wizard Step" of
            Rec."wizard step"::"1":
                begin
                    Step1Visible := Visible;
                    if Visible then begin
                        FinishEnable := false;
                        BackEnable := false;
                        NextEnable := true;
                    end;
                end;
            Rec."wizard step"::"2":
                begin
                    Step2Visible := Visible;
                    if Visible then begin
                        FinishEnable := true;
                        BackEnable := true;
                        NextEnable := false;
                    end;
                end;
        end;
    end;
}
