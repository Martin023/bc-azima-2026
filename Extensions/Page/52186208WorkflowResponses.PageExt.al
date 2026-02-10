#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186208 pageextension52186208 extends "Workflow Responses" 
{
    layout
    {
        modify(Description)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 5)".

    }

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SETFILTER("Function Name",'<>%1',WorkflowWebhookResponses.SendNotificationToWebhookCode);
        IF FINDFIRST THEN;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF FINDFIRST THEN;
        */
    //end;
}
