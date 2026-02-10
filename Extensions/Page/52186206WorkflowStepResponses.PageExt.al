#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186206 pageextension52186206 extends "Workflow Step Responses" 
{
    layout
    {
        modify(ResponseDescriptionTableControl)
        {
            ApplicationArea = Basic;
        }
        modify(ResponseDescriptionCardControl)
        {
            ApplicationArea = Basic;
        }
        modify(AddMoreResponsesLabel)
        {
            ApplicationArea = Basic;
        }
        modify(NextStepDescription)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ResponseDescriptionTableControl(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ResponseDescriptionCardControl(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NextStepDescription(Control 10)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Workflow Response Options"(Control 7)".

    }

    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WorkflowStep.GET("Workflow Code","Response Step ID");
        "Response Description" := WorkflowStep.GetDescription;
        MODIFY;

        UpdateNextStepDescription;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WorkflowStep.GET("Workflow Code","Response Step ID");
        "Response Description" := WorkflowStep.GetResponseDescription;
        #3..5
        */
    //end;
}
