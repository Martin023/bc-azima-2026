#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185778 pageextension52185778 extends "Currency Card" 
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
        modify("Unrealized Gains Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Realized Gains Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Unrealized Losses Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Realized Losses Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("EMU Currency")
        {
            ApplicationArea = Basic;
        }
        modify("Last Date Modified")
        {
            ApplicationArea = Basic;
        }
        modify("Last Date Adjusted")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Tolerance %")
        {
            ApplicationArea = Basic;
        }
        modify("Max. Payment Tolerance Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Invoice Rounding Precision")
        {
            ApplicationArea = Basic;
        }
        modify("Invoice Rounding Type")
        {
            ApplicationArea = Basic;
        }
        modify("Amount Rounding Precision")
        {
            ApplicationArea = Basic;
        }
        modify("Amount Decimal Places")
        {
            ApplicationArea = Basic;
        }
        modify("Unit-Amount Rounding Precision")
        {
            ApplicationArea = Basic;
        }
        modify("Unit-Amount Decimal Places")
        {
            ApplicationArea = Basic;
        }
        modify("Appln. Rounding Precision")
        {
            ApplicationArea = Basic;
        }
        modify("Conv. LCY Rndg. Debit Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Conv. LCY Rndg. Credit Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Max. VAT Difference Allowed")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Rounding Type")
        {
            ApplicationArea = Basic;
        }
        modify("Realized G/L Gains Account")
        {
            ApplicationArea = Basic;
        }
        modify("Realized G/L Losses Account")
        {
            ApplicationArea = Basic;
        }
        modify("Residual Gains Account")
        {
            ApplicationArea = Basic;
        }
        modify("Residual Losses Account")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".

        modify("ISO Code")
        {
            Visible = false;
        }
        modify("ISO Numeric Code")
        {
            Visible = false;
        }
        modify(Symbol)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Unrealized Gains Acc."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Realized Gains Acc."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unrealized Losses Acc."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Realized Losses Acc."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""EMU Currency"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date Modified"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date Adjusted"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Tolerance %"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Max. Payment Tolerance Amount"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Rounding Precision"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Rounding Type"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Rounding Precision"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Decimal Places"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit-Amount Rounding Precision"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit-Amount Decimal Places"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appln. Rounding Precision"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Conv. LCY Rndg. Debit Acc."(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Conv. LCY Rndg. Credit Acc."(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Max. VAT Difference Allowed"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Rounding Type"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Realized G/L Gains Account"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Realized G/L Losses Account"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Residual Gains Account"(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Residual Losses Account"(Control 40)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Change Payment &Tolerance")
        {
            ApplicationArea = Basic;
        }
        modify("Exch. &Rates")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Exch. &Rates"(Action 39)".

        }
        modify("Foreign Currency Balance")
        {
            ApplicationArea = Basic;
        }
        modify("Aged Accounts Receivable")
        {
            ApplicationArea = Basic;
        }
        modify("Aged Accounts Payable")
        {
            ApplicationArea = Basic;
        }
        modify("Trial Balance")
        {
            ApplicationArea = Basic;
        }
        modify(ActionGroupCRM)
        {
            Caption = 'Dynamics CRM';
        }
        modify(CRMGotoTransactionCurrency)
        {
            ToolTip = 'Open the coupled Microsoft Dynamics CRM transaction currency.';
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
            ToolTip = 'Create or modify the coupling to a Microsoft Dynamics CRM Transaction Currency.';
            ApplicationArea = Basic;
        }
        modify(DeleteCRMCoupling)
        {
            ToolTip = 'Delete the coupling to a Microsoft Dynamics CRM Transaction Currency.';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Change Payment &Tolerance"(Action 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exch. &Rates"(Action 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Foreign Currency Balance"(Action 1901143306)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Aged Accounts Receivable"(Action 1900711606)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Aged Accounts Payable"(Action 1905388206)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Trial Balance"(Action 1904082706)".


        //Unsupported feature: Code Modification on "ManageCRMCoupling(Action 5).OnAction".

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


    //Unsupported feature: Property Modification (Id) on "OnAfterGetCurrRecord.CRMCouplingManagement(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //OnAfterGetCurrRecord.CRMCouplingManagement : 1000;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //OnAfterGetCurrRecord.CRMCouplingManagement : 1001;
        //Variable type has not been exported.

    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF CRMIntegrationEnabled THEN BEGIN
          CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
          IF Code <> xRec.Code THEN
            CRMIntegrationManagement.SendResultNotification(Rec);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
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
