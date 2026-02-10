#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186979 pageextension52186979 extends "Config. Questions FactBox" 
{

    //Unsupported feature: Property Modification (Name) on ""Config. Questions FactBox"(Page 8633)".

    Caption = 'Config. Questions Factbox';
    layout
    {
        modify("Questionnaire Code")
        {
            ApplicationArea = Basic;
        }
        modify("Question Area Code")
        {
            ApplicationArea = Basic;
        }
        modify(Question)
        {
            ApplicationArea = Basic;
        }
        modify(Answer)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Questionnaire Code"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Question Area Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Question(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Answer(Control 6)".

    }
}
