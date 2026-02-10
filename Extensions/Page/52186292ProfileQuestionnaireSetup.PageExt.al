#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186292 pageextension52186292 extends "Profile Questionnaire Setup" 
{

    //Unsupported feature: Property Modification (PageType) on ""Profile Questionnaire Setup"(Page 5110)".

    layout
    {
        modify(ProfileQuestionnaireCodeName)
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
        modify("Multiple Answers")
        {
            ApplicationArea = Basic;
        }
        modify(Priority)
        {
            ApplicationArea = Basic;
        }
        modify("Auto Contact Classification")
        {
            ApplicationArea = Basic;
        }
        modify("From Value")
        {
            ApplicationArea = Basic;
        }
        modify("To Value")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Contacts")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ProfileQuestionnaireCodeName(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Multiple Answers"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Priority(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Auto Contact Classification"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""From Value"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""To Value"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Contacts"(Control 14)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Question Details")
        {
            ApplicationArea = Basic;
        }
        modify("Answer Where-Used")
        {
            ApplicationArea = Basic;
        }
        modify("Update &Classification")
        {
            ApplicationArea = Basic;
        }
        modify("Move &Up")
        {
            ApplicationArea = Basic;
        }
        modify("Move &Down")
        {
            ApplicationArea = Basic;
        }
        modify(Print)
        {
            ApplicationArea = Basic;
        }
        modify("Test Report")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Question Details"(Action 25)".


        //Unsupported feature: Property Deletion (Promoted) on ""Question Details"(Action 25)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Question Details"(Action 25)".


        //Unsupported feature: Property Deletion (Scope) on ""Question Details"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Answer Where-Used"(Action 21)".


        //Unsupported feature: Property Deletion (Promoted) on ""Answer Where-Used"(Action 21)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Answer Where-Used"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update &Classification"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Move &Up"(Action 26)".


        //Unsupported feature: Property Deletion (Promoted) on ""Move &Up"(Action 26)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Move &Up"(Action 26)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Move &Up"(Action 26)".


        //Unsupported feature: Property Deletion (Scope) on ""Move &Up"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Move &Down"(Action 27)".


        //Unsupported feature: Property Deletion (Promoted) on ""Move &Down"(Action 27)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Move &Down"(Action 27)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Move &Down"(Action 27)".


        //Unsupported feature: Property Deletion (Scope) on ""Move &Down"(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Print(Action 28)".


        //Unsupported feature: Property Deletion (Promoted) on "Print(Action 28)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Print(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Test Report"(Action 30)".

        addfirst("F&unctions")
        {
            action("Create &Rating")
            {
                ApplicationArea = Basic;
                Caption = 'Create &Rating';
                Image = CreateRating;

                trigger OnAction()
                var
                    TempProfileQuestnLine: Record "Profile Questionnaire Line" temporary;
                begin
                    TempProfileQuestnLine.CreateRatingFromProfQuestnLine(Rec);
                end;
            }
        }
    }


    //Unsupported feature: Property Modification (Length) on "CurrentQuestionsChecklistCode(Variable 1003)".

    //var
        //>>>> ORIGINAL VALUE:
        //CurrentQuestionsChecklistCode : 20;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CurrentQuestionsChecklistCode : 10;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
