#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186295 pageextension52186295 extends "Contact Profile Answers" 
{

    //Unsupported feature: Property Modification (PageType) on ""Contact Profile Answers"(Page 5114)".

    layout
    {
        modify(CurrentQuestionsChecklistCode)
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("No. of Contacts")
        {
            ApplicationArea = Basic;
        }
        modify(Set)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentQuestionsChecklistCode(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Contacts"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Set(Control 15)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }

    //Unsupported feature: Property Modification (Length) on "CurrentQuestionsChecklistCode(Variable 1003)".

    //var
        //>>>> ORIGINAL VALUE:
        //CurrentQuestionsChecklistCode : 20;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CurrentQuestionsChecklistCode : 10;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "ContactProfileAnswerCode(Variable 1006)".

    //var
        //>>>> ORIGINAL VALUE:
        //ContactProfileAnswerCode : 20;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ContactProfileAnswerCode : 10;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (Attributes) on "SetParameters(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "UpdateProfileAnswer(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "UpdateProfileAnswer(PROCEDURE 2)".

    //procedure UpdateProfileAnswer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT RunFormCode AND Set THEN
          TESTFIELD(Type,Type::Answer);

        #4..11
        END ELSE
          IF ContProfileAnswer.GET(Cont."No.",CurrentQuestionsChecklistCode,"Line No.") THEN
            ContProfileAnswer.DELETE(TRUE);

        OnAfterUpdateProfileAnswer(Rec,xRec,Cont);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..14
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetRunFromForm(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Length) on "SetParameters(PROCEDURE 1).SetProfileQuestionnaireCode(Parameter 1001)".


    //Unsupported feature: Property Modification (Length) on "SetParameters(PROCEDURE 1).SetContProfileAnswerCode(Parameter 1003)".


    //Unsupported feature: Property Modification (Length) on "SetRunFromForm(PROCEDURE 24).CurrQuestionsChecklistCodeFrom(Parameter 1001)".

}
