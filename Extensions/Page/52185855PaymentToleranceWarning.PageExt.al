#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185855 pageextension52185855 extends "Payment Tolerance Warning"
{
    layout
    {
        // modify(Posting)
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Insertion (InstructionalTextML) on "Details(Control 2)".

        modify(PostingDate)
        {
            ApplicationArea = Basic;
        }
        modify(CustVendNo)
        {
            Caption = 'No';
            ApplicationArea = Basic;
        }
        modify(DocNo)
        {
            ApplicationArea = Basic;
        }
        modify(CurrencyCode)
        {
            ApplicationArea = Basic;
        }
        modify(ApplyingAmount)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "ApplyingAmount(Control 8)".


            //Unsupported feature: Property Modification (Name) on "ApplyingAmount(Control 8)".

        }
        modify(AppliedAmount)
        {
            ApplicationArea = Basic;
        }
        modify(BalanceAmount)
        {
            ApplicationArea = Basic;
        }
        modify(Posting)
        {
            Visible = false;
        }
        modify(Control1)
        {
            Visible = false;
        }
        modify(Control4)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PostingDate(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CustVendNo(Control 19)".

        modify(AccountName)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "DocNo(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CurrencyCode(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApplyingAmount(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AppliedAmount(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BalanceAmount(Control 17)".

    }

    //Unsupported feature: Property Modification (Id) on "AppliedAmount(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //AppliedAmount : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AppliedAmount : 1011;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "BalanceAmount(Variable 1004)".

    //var
    //>>>> ORIGINAL VALUE:
    //BalanceAmount : 1004;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BalanceAmount : 1009;
    //Variable type has not been exported.

    var
        Amount: Decimal;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Posting := Posting::"Remaining Amount";

    UpdateAmounts;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Posting := Posting::"Remaining Amount";

    IF BalanceAmount = 0 THEN
      BalanceAmount := Amount + AppliedAmount;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetValues(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "SetValues(PROCEDURE 1)".

    //procedure SetValues();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CLEAR(BalAmount);
    PostingDate := ShowPostingDate;
    CustVendNo := ShowCustVendNo;
    DocNo := ShowDocNo;
    CurrencyCode := ShowCurrencyCode;
    OriginalApplyingAmount := ShowAmount;
    OriginalAppliedAmount := ShowAppliedAmount;
    BalAmount := ShowBalance;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #2..5
    Amount := ShowAmount;
    AppliedAmount := ShowAppliedAmount;
    BalanceAmount := ShowBalance;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "GetValues(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "InitializeOption(PROCEDURE 3)".


    //Unsupported feature: Deletion (VariableCollection) on "SetValues(PROCEDURE 1).BalAmount(Variable 1006)".

}
