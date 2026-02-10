#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185573 pageextension52185573 extends "Units of Measure" 
{
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
        modify("International Standard Code")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""International Standard Code"(Control 3)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Translations)
        {
            ApplicationArea = Basic;
        }
        modify(ActionGroupCRM)
        {
            Caption = 'Dynamics CRM';
        }
        modify(CRMGotoUnitsOfMeasure)
        {
            ToolTip = 'Open the coupled Microsoft Dynamics CRM unit of measure.';
            ApplicationArea = Basic;
        }
        modify(CRMSynchronizeNow)
        {
            Caption = 'Synchronize Now';
            ToolTip = 'Send updated data to Microsoft Dynamics CRM.';
            ApplicationArea = Basic;
        }
        modify(Coupling)
        {
            ToolTip = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.';
        }
        modify(ManageCRMCoupling)
        {
            ToolTip = 'Create or modify the coupling to a Microsoft Dynamics CRM Unit of Measure.';
            ApplicationArea = Basic;
        }
        modify(DeleteCRMCoupling)
        {
            ToolTip = 'Delete the coupling to a Microsoft Dynamics CRM Unit of Measure.';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Translations(Action 22)".


        //Unsupported feature: Code Modification on "ManageCRMCoupling(Action 6).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CRMIntegrationManagement.DefineCoupling(RECORDID);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CRMIntegrationManagement.CreateOrUpdateCoupling(RECORDID);
            */
        //end;
        modify(ShowLog)
        {
            Visible = false;
        }
    }


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CRMIsCoupledToRecord := CRMIntegrationEnabled;
        IF CRMIsCoupledToRecord THEN
          CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
