#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186081 pageextension52186081 extends "Copy Job Planning Lines" 
{
    layout
    {
        modify(SourceJobNo)
        {
            ApplicationArea = Basic;
        }
        modify(SourceJobTaskNo)
        {
            ApplicationArea = Basic;
        }
        modify("Planning Line Type")
        {
            OptionCaption = 'Schedule+Contract,Schedule,Contract';
            ApplicationArea = Basic;
        }
        modify(FromDate)
        {
            ApplicationArea = Basic;
        }
        modify(ToDate)
        {
            ApplicationArea = Basic;
        }
        modify(TargetJobNo)
        {
            ApplicationArea = Basic;
        }
        modify(TargetJobTaskNo)
        {
            ApplicationArea = Basic;
        }
        modify(CopyQuantity)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "SourceJobNo(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SourceJobTaskNo(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Planning Line Type"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FromDate(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ToDate(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TargetJobNo(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TargetJobTaskNo(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CopyQuantity(Control 26)".

    }

    //Unsupported feature: Property Modification (OptionString) on "PlanningLineType(Variable 1005)".

    //var
        //>>>> ORIGINAL VALUE:
        //PlanningLineType : "Budget+Billable",Budget,Billable;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //PlanningLineType : "Schedule+Contract",Schedule,Contract;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (Attributes) on "SetFromJobTask(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "SetToJobTask(PROCEDURE 4)".

}
