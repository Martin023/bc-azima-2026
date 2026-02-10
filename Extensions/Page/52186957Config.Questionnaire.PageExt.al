#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186957 pageextension52186957 extends "Config. Questionnaire" 
{
    Caption = 'Config. Questionnaire';
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(ExportToExcel)
        {

            //Unsupported feature: Property Modification (Name) on "ExportToExcel(Action 11)".

            ApplicationArea = Basic;
        }
        modify(ExportToXML)
        {

            //Unsupported feature: Property Modification (Name) on "ExportToXML(Action 8)".

            ApplicationArea = Basic;
        }
        modify(ImportFromXML)
        {

            //Unsupported feature: Property Modification (Name) on "ImportFromXML(Action 7)".

            ApplicationArea = Basic;
        }
        modify("&Update Questionnaire")
        {
            ApplicationArea = Basic;
        }
        modify("&Apply Answers")
        {
            ApplicationArea = Basic;
        }
        modify("&Question Areas")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "ExportToExcel(Action 11).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Code);
            IF QuestionnaireMgt.ExportQuestionnaireToExcel('',Rec) THEN
              MESSAGE(Text000);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TESTFIELD(Code);

            FileName := FileMgt.SaveFileDialog(Text002,FileName,'');
            IF FileName = '' THEN
              EXIT;

            IF QuestionnaireMgt.ExportQuestionnaireToExcel(FileName,Rec) THEN
              MESSAGE(Text000);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ExportToExcel(Action 11)".



        //Unsupported feature: Code Modification on "ExportToXML(Action 8).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF QuestionnaireMgt.ExportQuestionnaireAsXML('',Rec) THEN
              MESSAGE(Text000)
            ELSE
              MESSAGE(Text003);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF QuestionnaireMgt.ExportQuestionnaireAsXML(FileName,Rec) THEN
            #2..4
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ExportToXML(Action 8)".


        //Unsupported feature: Property Deletion (Promoted) on "ExportToXML(Action 8)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "ExportToXML(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ImportFromXML(Action 7)".


        //Unsupported feature: Property Deletion (Promoted) on "ImportFromXML(Action 7)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "ImportFromXML(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Update Questionnaire"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Apply Answers"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Question Areas"(Action 13)".

        addafter(ExportToExcel)
        {
            action("&Import from Excel")
            {
                ApplicationArea = Basic;
                Caption = '&Import from Excel';
                Ellipsis = true;
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    // FileName := FileMgt.OpenFileDialog(Text002,FileName,'');
                    // if FileName = '' then
                    //   exit;

                    // if QuestionnaireMgt.ImportQuestionnaireFromExcel(FileName) then
                    //   Message(Text001);
                end;
            }
        }
    }

    var
        Text002: label 'Save as Excel workbook';

    var
        FileMgt: Codeunit "File Management";
        FileName: Text;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
