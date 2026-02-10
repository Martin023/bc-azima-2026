#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185863 pageextension52185863 extends "Payment Disc Tolerance Warning" 
{
    layout
    {
        modify(Posting)
        {
            ApplicationArea = Basic;
        }
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
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify(AppliedAmount)
        {
            ApplicationArea = Basic;
        }
        modify(BalanceAmount)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PostingDate(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CustVendNo(Control 19)".

        modify(AccountName)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "DocNo(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CurrencyCode(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AppliedAmount(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BalanceAmount(Control 17)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetValues(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "GetValues(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "InitializeNewPostingAction(PROCEDURE 3)".

}
