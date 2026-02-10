#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186420 pageextension52186420 extends "CRM Opportunity List"
{
    Caption = 'Microsoft Dynamics CRM Opportunities';

    //Unsupported feature: Property Modification (PromotedActionCategoriesML) on ""CRM Opportunity List"(Page 5343)".

    layout
    {
        modify(StatusCode)
        {
            Caption = 'Status';
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(EstimatedCloseDate)
        {
            ApplicationArea = Basic;
        }
        modify(EstimatedValue)
        {
            ApplicationArea = Basic;
        }
        modify(TotalAmount)
        {
            ApplicationArea = Basic;
        }
        modify(ParentContactIdName)
        {
            ApplicationArea = Basic;
        }
        modify(ParentAccountIdName)
        {
            ApplicationArea = Basic;
        }
        modify(CloseProbability)
        {
            ApplicationArea = Basic;
        }
        modify(OpportunityRatingCode)
        {
            ApplicationArea = Basic;
        }
        modify(Need)
        {
            ApplicationArea = Basic;
        }
        // modify(StateCode)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "StatusCode(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (StyleExpr) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "EstimatedCloseDate(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "EstimatedValue(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalAmount(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ParentContactIdName(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ParentAccountIdName(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CloseProbability(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OpportunityRatingCode(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Need(Control 12)".

        modify(Coupled)
        {
            Visible = false;
        }
        addafter(StatusCode)
        {
            // field(StateCode;Rec.StateCode)
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Status Reason';
            //     OptionCaption = 'Open,Won,Lost';
            // }
        }
    }
    actions
    {
        modify(ActionGroupCRM)
        {
            Caption = 'Dynamics CRM';
        }
        modify(CRMGotoOpportunities)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CRMGotoOpportunities(Action 14)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
