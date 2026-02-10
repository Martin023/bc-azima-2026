#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186356 pageextension52186356 extends "Create Rating"
{
    layout
    {
        modify(GetProfileLineAnswerDesc)
        {
            ApplicationArea = Basic;
        }
        modify("Interval Option")
        {
            ApplicationArea = Basic;
        }
        modify("Wizard From Value")
        {
            ApplicationArea = Basic;
            Enabled = "Wizard From ValueEnable";
        }
        modify("Wizard To Value")
        {
            ApplicationArea = Basic;
            Enabled = "Wizard To ValueEnable";
        }
        modify("Interval Option2")
        {
            ApplicationArea = Basic;
        }
        modify(Minimum)
        {
            ApplicationArea = Basic;
        }
        modify("Interval Option3")
        {
            ApplicationArea = Basic;
        }
        modify(Maximum)
        {
            ApplicationArea = Basic;
        }
        modify("Profile Questionnaire Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Min. % Questions Answered")
        {
            ApplicationArea = Basic;
        }
        modify("Answer Option")
        {
            ApplicationArea = Basic;
        }
        modify(NoOfAnswers)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "SubForm(Control 30)".


        //Unsupported feature: Property Deletion (PartType) on "SubForm(Control 30)".

    }
    actions
    {
        modify(Back)
        {
            ApplicationArea = Basic;
        }
        modify(Next)
        {
            ApplicationArea = Basic;
        }
        modify(Finish)
        {
            ApplicationArea = Basic;
        }
    }
    var
        CancelYPos: Integer;
        CancelHeight: Integer;

    var
        FrmYPos: Integer;
        FrmHeight: Integer;

    var

        "Wizard From ValueEnable": Boolean;

        "Wizard To ValueEnable": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    MaximumEnable := TRUE;
    MinimumEnable := TRUE;
    WizardToValueEnable := TRUE;
    WizardFromValueEnable := TRUE;
    NoOfAnswersEnable := TRUE;
    NextEnable := TRUE;
    SubFormVisible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    MaximumEnable := TRUE;
    MinimumEnable := TRUE;
    "Wizard To ValueEnable" := TRUE;
    "Wizard From ValueEnable" := TRUE;
    #5..7
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FormWidth := CancelXPos + CancelWidth + 220;
    FrmXPos := ROUND((FrmWidth - FormWidth) / 2,1) + FrmXPos;
    FrmWidth := FormWidth;

    VALIDATE("Auto Contact Classification",TRUE);
    #6..11
    ShowStep(TRUE);

    UpdateCntrls;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    FormWidth := CancelXPos + CancelWidth + 220;
    FrmXPos := ROUND((FrmWidth - FormWidth) / 2,1) + FrmXPos;
    FrmYPos := 3000;
    FrmHeight := CancelYPos + CancelHeight + 220;
    #3..14
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateCntrls(PROCEDURE 1)".

    //procedure UpdateCntrls();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    NoOfAnswersEnable := "Answer Option" = "Answer Option"::Custom;
    WizardFromValueEnable := "Interval Option" = "Interval Option"::Interval;
    WizardToValueEnable := "Interval Option" = "Interval Option"::Interval;
    MinimumEnable := "Interval Option" = "Interval Option"::Minimum;
    MaximumEnable := "Interval Option" = "Interval Option"::Maximum;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    NoOfAnswersEnable := "Answer Option" = "Answer Option"::Custom;
    "Wizard From ValueEnable" := "Interval Option" = "Interval Option"::Interval;
    "Wizard To ValueEnable" := "Interval Option" = "Interval Option"::Interval;
    MinimumEnable := "Interval Option" = "Interval Option"::Minimum;
    MaximumEnable := "Interval Option" = "Interval Option"::Maximum;
    */
    //end;
}
