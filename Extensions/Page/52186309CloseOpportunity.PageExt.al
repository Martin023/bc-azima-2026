#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186309 pageextension52186309 extends "Close Opportunity"
{

    //Unsupported feature: Property Modification (PageType) on ""Close Opportunity"(Page 5128)".

    layout
    {
        modify(General)
        {

            //Unsupported feature: Property Modification (Name) on "General(Control 1)".

            Caption = 'Step 1';

            //Unsupported feature: Property Insertion (Visible) on "General(Control 1)".

        }
        modify(OptionWon)
        {
            Caption = 'This wizard helps you to close an opportunity. Do you want to close the opportunity because it is';
            ApplicationArea = Basic;
        }
        modify("Close Opportunity Code")
        {
            Caption = 'What is the reason for closing the opportunity?';
            ApplicationArea = Basic;
        }
        modify("Date of Change")
        {
            Caption = 'What is the closing date of the opportunity?';
            ApplicationArea = Basic;
        }
        modify("Calcd. Current Value (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Cancel Old To Do")
        {
            Caption = 'Cancel existing open to-dos.';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (GroupType) on "General(Control 1)".


        //Unsupported feature: Code Modification on "OptionWon(Control 12).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Action Taken" = "Action Taken"::Lost THEN
          LostActionTakenOnValidate;
        IF "Action Taken" = "Action Taken"::Won THEN
          WonActionTakenOnValidate;

        CASE "Action Taken" OF
          "Action Taken"::Won:
            BEGIN
              CalcdCurrentValueLCYEnable := TRUE;
              IF Opp.GET("Opportunity No.") THEN
                SalesQuoteEnable := Opp."Sales Document No." <> '';
            END;
          "Action Taken"::Lost:
            BEGIN
              CalcdCurrentValueLCYEnable := FALSE;
              SalesQuoteEnable := FALSE;
            END;
        END;

        UpdateEstimates;
        CASE "Action Taken" OF
          "Action Taken"::Won:
            BEGIN
              CloseOpportunityCode.SETRANGE(Type,CloseOpportunityCode.Type::Won);
              IF CloseOpportunityCode.COUNT = 1 THEN BEGIN
                CloseOpportunityCode.FINDFIRST;
                "Close Opportunity Code" := CloseOpportunityCode.Code;
              END;
            END;
          "Action Taken"::Lost:
            BEGIN
              CloseOpportunityCode.SETRANGE(Type,CloseOpportunityCode.Type::Lost);
              IF CloseOpportunityCode.COUNT = 1 THEN BEGIN
                CloseOpportunityCode.FINDFIRST;
                "Close Opportunity Code" := CloseOpportunityCode.Code;
              END;
            END;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "OptionWon(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Close Opportunity Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date of Change"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calcd. Current Value (LCY)"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cancel Old To Do"(Control 19)".

        addafter(General)
        {
            group(Step2)
            {
                Caption = 'Step 2';
                InstructionalText = 'You can now record the reason for closing the opportunity.';
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
        modify(SalesQuote)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Finish(Action 10)".


        //Unsupported feature: Property Deletion (Promoted) on "Finish(Action 10)".


        //Unsupported feature: Property Deletion (Visible) on "Finish(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesQuote(Action 15)".


        //Unsupported feature: Property Deletion (Promoted) on "SalesQuote(Action 15)".

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
                    //PerformPrevWizardStatus;
                    ShowStep(true);
                    // UpdateCntrls;
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
                    Rec.CheckStatus;
                    ShowStep(false);
                    //PerformNextWizardStatus;
                    ShowStep(true);
                    // UpdateCntrls;
                    CurrPage.Update(true);
                end;
            }
        }
    }

    var
        FormWidth: Integer;
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

    var
        Text666: label '%1 is not a valid selection.';


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OptionLostEnable := TRUE;
    OptionWonEnable := TRUE;
    SalesQuoteEnable := TRUE;
    CalcdCurrentValueLCYEnable := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    NextEnable := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateEditable;
    "Cancel Old To Do" := TRUE;
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

    UpdateEditable;
    "Cancel Old To Do" := TRUE;
    // "Create New To Do" := FALSE;
    ShowStep(TRUE);
    */
    //end;


    //Unsupported feature: Code Modification on "WonActionTakenOnValidate(PROCEDURE 19006664)".

    //procedure WonActionTakenOnValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT OptionWonEnable THEN
      ERROR(IsNotAValidSelectionErr,"Action Taken");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT OptionWonEnable THEN
      ERROR(Text666,"Action Taken");
    */
    //end;


    //Unsupported feature: Code Modification on "LostActionTakenOnValidate(PROCEDURE 19063471)".

    //procedure LostActionTakenOnValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT OptionLostEnable THEN
      ERROR(IsNotAValidSelectionErr,"Action Taken");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT OptionLostEnable THEN
      ERROR(Text666,"Action Taken");
    */
    //end;

    local procedure ShowStep(Visible: Boolean)
    var
        CloseOpportunityCode: Record "Close Opportunity Code";
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
                        CloseOpportunityCode.Reset;
                        case Rec."Action Taken" of
                            Rec."action taken"::Won:
                                if Opp.Get(Rec."Opportunity No.") then
                                    SalesQuoteEnable := Opp."Sales Document No." <> '';
                            Rec."action taken"::Lost:
                                begin
                                    //CalcdCurrentValueLCYEnable := false;
                                    SalesQuoteEnable := false;
                                end;
                        end;
                    end;
                end;
        end;
    end;
}
