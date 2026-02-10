#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186424 pageextension52186424 extends "CRM Case List" 
{
    Caption = 'Microsoft Dynamics CRM Cases';

    //Unsupported feature: Property Modification (PromotedActionCategoriesML) on ""CRM Case List"(Page 5349)".

    layout
    {
        modify(Title)
        {
            ApplicationArea = Basic;
        }
        modify(StateCode)
        {
            ApplicationArea = Basic;
        }
        modify(TicketNumber)
        {
            ApplicationArea = Basic;
        }
        modify(CreatedOn)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Title(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StateCode(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TicketNumber(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CreatedOn(Control 6)".

    }
    actions
    {
        modify(ActionGroupCRM)
        {
            Caption = 'Dynamics CRM';
        }
        modify(CRMGoToCase)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CRMGoToCase(Action 7)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
