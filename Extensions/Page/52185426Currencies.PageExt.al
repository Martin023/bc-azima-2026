#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185426 pageextension52185426 extends Currencies 
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
        modify(ExchangeRateDate)
        {
            ApplicationArea = Basic;
        }
        modify(ExchangeRateAmt)
        {
            ApplicationArea = Basic;
        }
        modify("EMU Currency")
        {
            ApplicationArea = Basic;
        }
        modify("Realized Gains Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Realized Losses Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Unrealized Gains Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Unrealized Losses Acc.")
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
        modify("Amount Rounding Precision")
        {
            ApplicationArea = Basic;
        }
        modify("Amount Decimal Places")
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
        modify("Last Date Adjusted")
        {
            ApplicationArea = Basic;
        }
        modify("Last Date Modified")
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
        modify(CurrencyFactor)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 29)".

        modify("ISO Code")
        {
            Visible = false;
        }
        modify("ISO Numeric Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ExchangeRateDate(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ExchangeRateAmt(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""EMU Currency"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Realized Gains Acc."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Realized Losses Acc."(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unrealized Gains Acc."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unrealized Losses Acc."(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Realized G/L Gains Account"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Realized G/L Losses Account"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Residual Gains Account"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Residual Losses Account"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Rounding Precision"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Decimal Places"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Rounding Precision"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Rounding Type"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit-Amount Rounding Precision"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit-Amount Decimal Places"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appln. Rounding Precision"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Conv. LCY Rndg. Debit Acc."(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Conv. LCY Rndg. Credit Acc."(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Max. VAT Difference Allowed"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Rounding Type"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date Adjusted"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date Modified"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Tolerance %"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Max. Payment Tolerance Amount"(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CurrencyFactor(Control 62)".


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
        }
        modify("Adjust Exchange Rate")
        {
            ApplicationArea = Basic;
        }
        modify("Exchange Rate Adjust. Register")
        {
            ApplicationArea = Basic;
        }
        modify("Exchange Rate Services")
        {
            ApplicationArea = Basic;
        }
        modify(UpdateExchangeRates)
        {
            ApplicationArea = Basic;
        }
        modify("Foreign Currency Balance")
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Change Payment &Tolerance"(Action 61)".

        modify(SuggestAccounts)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Exch. &Rates"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Adjust Exchange Rate"(Action 1904035104)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exchange Rate Adjust. Register"(Action 1900169904)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exchange Rate Services"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "UpdateExchangeRates(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Foreign Currency Balance"(Action 1901143306)".


        //Unsupported feature: Code Modification on "ManageCRMCoupling(Action 14).OnAction".

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

    //Unsupported feature: Property Deletion (Attributes) on "GetSelectionFilter(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "GetCurrency(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
