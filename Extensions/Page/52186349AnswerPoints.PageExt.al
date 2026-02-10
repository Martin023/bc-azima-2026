#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186349 pageextension52186349 extends "Answer Points" 
{

    //Unsupported feature: Property Modification (DataCaptionExpr) on ""Answer Points"(Page 5172)".


    //Unsupported feature: Property Modification (PageType) on ""Answer Points"(Page 5172)".

    layout
    {

        //Unsupported feature: Property Modification (Name) on "Questions(Control 13)".

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
        modify(Points)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Contacts"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Points(Control 1)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        // addfirst(Content)
        // {
        //     field(CurrQuestnCode;CurrQuestnCode)
        //     {
        //         ApplicationArea = Basic;
        //         Caption = 'Profile Questionnaire Code';

        //         trigger OnLookup(var Text: Text): Boolean
        //         var
        //             ProfileQuestnHeader: Record "Profile Questionnaire Header";
        //         begin
        //             if ProfileQuestnHeader.Get(Rec."Profile Questionnaire Code") then
        //               if Page.RunModal(
        //                    Page::"Profile Questionnaire List",ProfileQuestnHeader) = Action::LookupOK
        //               then begin
        //                 Rec.SetRange(Rec."Profile Questionnaire Code",ProfileQuestnHeader.Code);
        //                 CurrQuestnCode := ProfileQuestnHeader.Code;
        //                 SetRatingFilter;
        //                 CurrPage.Update;
        //               end;
        //         end;
        //     }
        // }
    }
    actions
    {
        modify(List)
        {
            ApplicationArea = Basic;
        }
        modify(Questionnaire)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "List(Action 7)".

    }


    //Unsupported feature: Property Modification (Length) on "CurrQuestnCode(Variable 1003)".

    //var
        //>>>> ORIGINAL VALUE:
        //CurrQuestnCode : 20;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CurrQuestnCode : 10;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "TargetQuestnCode(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //TargetQuestnCode : 20;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //TargetQuestnCode : 10;
        //Variable type has not been exported.

    var
        CaptionStr: Text[260];


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TargetQuestnCode := "Profile Questionnaire Code";
        TargetQuestLineNo := "Line No.";
        TargetQuestnLineNoEnd := "Line No.";
        #4..9
            TargetQuestnLineNoEnd := TempProfileQuestnLine."Line No.";

        SetRatingFilter;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..12
        CaptionStr := FORMAT("Profile Questionnaire Code") + '  ' + Description;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetRatingFilter(PROCEDURE 1)".

}
