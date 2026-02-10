#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186214 pageextension52186214 extends "Workflow Overview" 
{
    layout
    {
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Last Modified Date-Time")
        {
            ApplicationArea = Basic;
        }
        modify("Last Modified By User ID")
        {
            ApplicationArea = Basic;
        }
        modify(WorkflowRecord)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Modified Date-Time"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Modified By User ID"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WorkflowRecord(Control 3)".

    }

    //Unsupported feature: Code Insertion on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //begin
        /*
        UpdatePageControls;
        */
    //end;
}
