#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185433 pageextension52185433 extends "Salespersons/Purchasers"
{

    //Unsupported feature: Property Modification (Name) on ""Salespersons/Purchasers"(Page 14)".

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
        modify("Commission %")
        {
            ApplicationArea = Basic;
        }
        modify("Phone No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Commission %"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No."(Control 12)".

        modify("Privacy Blocked")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

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
        modify("Dimensions-Single")
        {
            ApplicationArea = Basic;
        }
        modify("Dimensions-&Multiple")
        {
            ApplicationArea = Basic;
        }
        modify(Statistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 19)".

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

            //Unsupported feature: Property Modification (Name) on ""T&asks"(Action 24)".

        }
        // modify("Oppo&rtunities")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""Oppo&rtunities"(Action 25)".

        //     Caption = 'List';
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Name) on ""Oppo&rtunities"(Action 25)".

        //}
        // modify(ActionGroupCRM)
        // {
        //     Caption = 'Dynamics CRM';
        // }
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
        modify(CreateInteraction)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Tea&ms"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Con&tacts"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-Single"(Action 18)".


        //Unsupported feature: Property Deletion (Promoted) on ""Dimensions-Single"(Action 18)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Dimensions-Single"(Action 18)".


        //Unsupported feature: Code Modification on ""Dimensions-&Multiple"(Action 27).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(SalespersonPurchaser);
        DefaultDimMultiple.SetMultiRecord(SalespersonPurchaser,FIELDNO(Code));
        DefaultDimMultiple.RUNMODAL;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(SalespersonPurchaser);
        DefaultDimMultiple.SetMultiSalesperson(SalespersonPurchaser);
        DefaultDimMultiple.RUNMODAL;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-&Multiple"(Action 27)".


        //Unsupported feature: Property Deletion (Promoted) on ""Dimensions-&Multiple"(Action 27)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Dimensions-&Multiple"(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 19)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Statistics(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""C&ampaigns"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""S&egments"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Log E&ntries"(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Postponed &Interactions"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""T&asks"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Oppo&rtunities"(Action 25)".



        //Unsupported feature: Code Modification on "ManageCRMCoupling(Action 10).OnAction".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "CreateInteraction(Action 17)".

        addafter("T&asks")
        {
            // group("Oppo&rtunities")
            // {
            //     Caption = 'Oppo&rtunities';
            //     Image = OpportunityList;
            // }
        }
    }

    //Unsupported feature: Property Deletion (Editable).


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
