#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186297 pageextension52186297 extends "Salesperson/Purchaser Card" 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Job Title")
        {
            ApplicationArea = Basic;
        }
        modify("Commission %")
        {
            ApplicationArea = Basic;
        }
        modify("Phone No.")
        {
            ApplicationArea = Basic;
        }
        modify("E-Mail")
        {
            ApplicationArea = Basic;
        }
        modify("Next Task Date")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Next Task Date"(Control 12)".


            //Unsupported feature: Property Modification (Name) on ""Next Task Date"(Control 12)".

        }
        modify("Global Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        // modify(Control3)
        // {

        //     //Unsupported feature: Property Modification (Level) on "Control3(Control 3)".


        //     //Unsupported feature: Property Modification (ControlType) on "Control3(Control 3)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Name) on "Control3(Control 3)".


        //     //Unsupported feature: Property Insertion (SourceExpr) on "Control3(Control 3)".

        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Title"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Commission %"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No."(Control 10)".


        //Unsupported feature: Property Deletion (ExtendedDatatype) on ""E-Mail"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E-Mail"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Next Task Date"(Control 12)".

        modify("Privacy Blocked")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 16)".


        //Unsupported feature: Property Deletion (SubPageLink) on "Control3(Control 3)".


        //Unsupported feature: Property Deletion (PagePartID) on "Control3(Control 3)".


        //Unsupported feature: Property Deletion (PartType) on "Control3(Control 3)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

       // moveafter("Next To-do Date";Control3)
    }
    actions
    {
        modify("Tea&ms")
        {
            ApplicationArea = Basic;
        }
        modify("Con&tacts")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Statistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 21)".

        }
        modify("C&ampaigns")
        {
            ApplicationArea = Basic;
        }
        modify("S&egments")
        {
            ApplicationArea = Basic;
        }
        modify("Interaction Log E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Postponed &Interactions")
        {
            ApplicationArea = Basic;
        }
        modify("T&asks")
        {
            Caption = 'T&o-dos';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""T&asks"(Action 35)".

        }
        // modify("Oppo&rtunities")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""Oppo&rtunities"(Action 34)".

        //     Caption = 'List';
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Name) on ""Oppo&rtunities"(Action 34)".

        // }
        modify(ActionGroupCRM)
        {
            Caption = 'Dynamics CRM';
        }
        modify(CRMGotoSystemUser)
        {
            ToolTip = 'Open the coupled Microsoft Dynamics CRM system user.';
            ApplicationArea = Basic;
        }
        modify(CRMSynchronizeNow)
        {
            Caption = 'Synchronize Now';
            ToolTip = 'Send or get updated data to or from Microsoft Dynamics CRM.';
            ApplicationArea = Basic;
        }
        modify(Coupling)
        {
            ToolTip = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.';
        }
        modify(ManageCRMCoupling)
        {
            ToolTip = 'Create or modify the coupling to a Microsoft Dynamics CRM user.';
            ApplicationArea = Basic;
        }
        modify(DeleteCRMCoupling)
        {
            ToolTip = 'Delete the coupling to a Microsoft Dynamics CRM user.';
            ApplicationArea = Basic;
        }
        modify("Create &Interaction")
        {
            Caption = 'Create &Interact';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Create &Interaction"(Action 36)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Tea&ms"(Action 28)".


        //Unsupported feature: Property Deletion (Promoted) on ""Tea&ms"(Action 28)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Tea&ms"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Con&tacts"(Action 25)".


        //Unsupported feature: Property Deletion (Promoted) on ""Con&tacts"(Action 25)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Con&tacts"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 23)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 23)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Dimensions(Action 23)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 21)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Statistics(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""C&ampaigns"(Action 26)".


        //Unsupported feature: Property Deletion (Promoted) on ""C&ampaigns"(Action 26)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""C&ampaigns"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""S&egments"(Action 27)".


        //Unsupported feature: Property Deletion (Promoted) on ""S&egments"(Action 27)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""S&egments"(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Log E&ntries"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Postponed &Interactions"(Action 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""T&asks"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Oppo&rtunities"(Action 34)".


        //Unsupported feature: Code Modification on "ManageCRMCoupling(Action 9).OnAction".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Create &Interaction"(Action 36)".

        addafter("T&asks")
        {
            // group("Oppo&rtunities")
            // {
            //     Caption = 'Oppo&rtunities';
            //     Image = OpportunityList;
            // }
        }
    }

    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF CRMIntegrationEnabled THEN BEGIN
          CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
          IF Code <> xRec.Code THEN
            CRMIntegrationManagement.SendResultNotification(Rec);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF CRMIntegrationEnabled THEN
          CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
        */
    //end;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnOpenPage".

    //trigger (Variable: CRMIntegrationManagement)()
    //Parameters and return type have not been exported.
    //begin
        /*
        */
    //end;

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
