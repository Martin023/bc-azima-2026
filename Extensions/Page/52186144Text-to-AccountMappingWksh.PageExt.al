#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186144 pageextension52186144 extends "Text-to-Account Mapping Wksh." 
{
    layout
    {
        modify(DefaultDebitAccName)
        {
            ApplicationArea = Basic;
        }
        modify(DefaultCreditAccName)
        {
            ApplicationArea = Basic;
        }
        modify("Mapping Text")
        {
            ApplicationArea = Basic;
        }
        modify("Debit Acc. No.")
        {
            ApplicationArea = Basic;
        }
        modify("Credit Acc. No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Source Type")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Source No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "DefaultDebitAccName(Control 8).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            SetUpDefaultGLAccounts(DefaultDebitAccNo,AccType::Debit);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            SetUpDefaultGLAccounts
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "DefaultDebitAccName(Control 8)".



        //Unsupported feature: Code Modification on "DefaultCreditAccName(Control 12).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            SetUpDefaultGLAccounts(DefaultCreditAccNo,AccType::Credit);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            SetUpDefaultGLAccounts
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "DefaultCreditAccName(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Mapping Text"(Control 3)".

        modify("Vendor No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Debit Acc. No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Credit Acc. No."(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Source Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Source No."(Control 5)".

    }
    actions
    {
        
        //Unsupported feature: Property Deletion (Level) on "ActionContainer11(Action 11)".



        //Unsupported feature: Code Insertion on "SetUpDefaultGLAccounts(Action 9)".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //begin
            /*
            SetUpDefaultGLAccounts
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SetUpDefaultGLAccounts(Action 9)".


        //Unsupported feature: Property Deletion (RunObject) on "SetUpDefaultGLAccounts(Action 9)".

    }


    //Unsupported feature: Property Modification (Length) on "DefaultDebitAccName(Variable 1002)".

    //var
        //>>>> ORIGINAL VALUE:
        //DefaultDebitAccName : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //DefaultDebitAccName : 50;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "DefaultCreditAccName(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //DefaultCreditAccName : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //DefaultCreditAccName : 50;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnQueryClosePage".

    //trigger OnQueryClosePage(CloseAction: Action): Boolean
    //>>>> ORIGINAL CODE:
    //begin
        /*
        EXIT(CheckEntriesAreConsistent);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF CloseAction <> ACTION::OK THEN
          EXIT(TRUE);

        CheckEntriesAreConsistent;
        */
    //end;


    //Unsupported feature: Code Modification on "SetUpDefaultGLAccounts(PROCEDURE 2)".

    //procedure SetUpDefaultGLAccounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GLAccount."No." := Account;
        GLAccount.SETRANGE("Direct Posting",TRUE);
        IF PAGE.RUNMODAL(PAGE::"G/L Account List",GLAccount) = ACTION::LookupOK THEN
          IF Account <> GLAccount."No." THEN BEGIN
            PurchasesPayablesSetup.GET;
            CASE Type OF
              Type::Debit:
                PurchasesPayablesSetup."Debit Acc. for Non-Item Lines" := GLAccount."No.";
              Type::Credit:
                PurchasesPayablesSetup."Credit Acc. for Non-Item Lines" := GLAccount."No.";
            END;
            PurchasesPayablesSetup.MODIFY;
            UpdateDefaultGLAccounts;
          END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF PAGE.RUNMODAL(PAGE::"Purchases & Payables Setup",PurchasesPayablesSetup) = ACTION::LookupOK THEN
          UpdateDefaultGLAccounts;
        */
    //end;

    //Unsupported feature: Deletion (ParameterCollection) on "SetUpDefaultGLAccounts(PROCEDURE 2).Account(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "SetUpDefaultGLAccounts(PROCEDURE 2).Type(Parameter 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "SetUpDefaultGLAccounts(PROCEDURE 2).GLAccount(Variable 1000)".


    //Unsupported feature: Property Deletion (DataCaptionFields).

}
