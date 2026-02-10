#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186080 pageextension52186080 extends "Copy Job Tasks" 
{
    layout
    {
        modify(SourceJobNo)
        {
            ApplicationArea = Basic;
        }
        modify(FromJobTaskNo)
        {
            ApplicationArea = Basic;
        }
        modify(ToJobTaskNo)
        {
            ApplicationArea = Basic;
        }
        modify("From Source")
        {
            ApplicationArea = Basic;
        }
        modify("Planning Line Type")
        {
            OptionCaption = 'Schedule+Contract,Schedule,Contract';
            ApplicationArea = Basic;
        }
        modify("Ledger Entry Line Type")
        {
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
        modify(CopyQuantity)
        {
            ApplicationArea = Basic;
        }
        modify(CopyDimensions)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "SourceJobNo(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FromJobTaskNo(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ToJobTaskNo(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""From Source"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Planning Line Type"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger Entry Line Type"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FromDate(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ToDate(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TargetJobNo(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CopyQuantity(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CopyDimensions(Control 28)".

    }

    //Unsupported feature: Property Modification (OptionString) on "PlanningLineType(Variable 1002)".

    //var
        //>>>> ORIGINAL VALUE:
        //PlanningLineType : "Budget+Billable",Budget,Billable;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //PlanningLineType : "Schedule+Contract",Schedule,Contract;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PlanningLineType := PlanningLineType::"Budget+Billable";
        LedgerEntryType := LedgerEntryType::"Usage+Sale";
        ValidateSource;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        PlanningLineType := PlanningLineType::"Schedule+Contract";
        LedgerEntryType := LedgerEntryType::"Usage+Sale";
        ValidateSource;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetFromJob(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "SetToJob(PROCEDURE 5)".

}
