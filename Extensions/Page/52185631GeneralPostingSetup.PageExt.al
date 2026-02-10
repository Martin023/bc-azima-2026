#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185631 pageextension52185631 extends "General Posting Setup" 
{
    Editable = false;
    layout
    {
        modify("Gen. Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Account")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Credit Memo Account")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Line Disc. Account")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Inv. Disc. Account")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Pmt. Disc. Debit Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Pmt. Disc. Credit Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Pmt. Tol. Debit Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Pmt. Tol. Credit Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Prepayments Account")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Sales Prepayments Account"(Control 70)".

        }
        modify("Purch. Account")
        {
            ApplicationArea = Basic;
        }
        modify("Purch. Credit Memo Account")
        {
            ApplicationArea = Basic;
        }
        modify("Purch. Line Disc. Account")
        {
            ApplicationArea = Basic;
        }
        modify("Purch. Inv. Disc. Account")
        {
            ApplicationArea = Basic;
        }
        modify("Purch. Pmt. Disc. Debit Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Purch. Pmt. Disc. Credit Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Purch. Pmt. Tol. Debit Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Purch. Pmt. Tol. Credit Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Purch. Prepayments Account")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Purch. Prepayments Account"(Control 72)".

        }
        modify("COGS Account")
        {
            ApplicationArea = Basic;
        }
        modify("COGS Account (Interim)")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""COGS Account (Interim)"(Control 1007)".

        }
        modify("Inventory Adjmt. Account")
        {
            ApplicationArea = Basic;
        }
        modify("Invt. Accrual Acc. (Interim)")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Invt. Accrual Acc. (Interim)"(Control 9)".

        }
        modify("Direct Cost Applied Account")
        {
            ApplicationArea = Basic;
        }
        modify("Overhead Applied Account")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Variance Account")
        {
            ApplicationArea = Basic;
        }
        modify("Purch. FA Disc. Account")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Purch. FA Disc. Account"(Control 6)".

        }
        modify(Control5)
        {
            Visible = false;
        }
        modify(ShowAllAccounts)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Bus. Posting Group"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Prod. Posting Group"(Control 4)".

        modify(Description)
        {
            Visible = false;
        }
        modify("View All Accounts on Lookup")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Account"(Control 19)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Sales Account"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Credit Memo Account"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Line Disc. Account"(Control 22)".


        //Unsupported feature: Property Deletion (Visible) on ""Sales Line Disc. Account"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Inv. Disc. Account"(Control 24)".


        //Unsupported feature: Property Deletion (Visible) on ""Sales Inv. Disc. Account"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Pmt. Disc. Debit Acc."(Control 25)".


        //Unsupported feature: Property Deletion (Visible) on ""Sales Pmt. Disc. Debit Acc."(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Pmt. Disc. Credit Acc."(Control 41)".


        //Unsupported feature: Property Deletion (Visible) on ""Sales Pmt. Disc. Credit Acc."(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Pmt. Tol. Debit Acc."(Control 60)".


        //Unsupported feature: Property Deletion (Visible) on ""Sales Pmt. Tol. Debit Acc."(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Pmt. Tol. Credit Acc."(Control 68)".


        //Unsupported feature: Property Deletion (Visible) on ""Sales Pmt. Tol. Credit Acc."(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Prepayments Account"(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purch. Account"(Control 27)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Purch. Account"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purch. Credit Memo Account"(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purch. Line Disc. Account"(Control 30)".


        //Unsupported feature: Property Deletion (Visible) on ""Purch. Line Disc. Account"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purch. Inv. Disc. Account"(Control 32)".


        //Unsupported feature: Property Deletion (Visible) on ""Purch. Inv. Disc. Account"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purch. Pmt. Disc. Debit Acc."(Control 43)".


        //Unsupported feature: Property Deletion (Visible) on ""Purch. Pmt. Disc. Debit Acc."(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purch. Pmt. Disc. Credit Acc."(Control 33)".


        //Unsupported feature: Property Deletion (Visible) on ""Purch. Pmt. Disc. Credit Acc."(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purch. Pmt. Tol. Debit Acc."(Control 45)".


        //Unsupported feature: Property Deletion (Visible) on ""Purch. Pmt. Tol. Debit Acc."(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purch. Pmt. Tol. Credit Acc."(Control 47)".


        //Unsupported feature: Property Deletion (Visible) on ""Purch. Pmt. Tol. Credit Acc."(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purch. Prepayments Account"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""COGS Account"(Control 35)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""COGS Account"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""COGS Account (Interim)"(Control 1007)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory Adjmt. Account"(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invt. Accrual Acc. (Interim)"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Cost Applied Account"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Overhead Applied Account"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Variance Account"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purch. FA Disc. Account"(Control 6)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter(Control1)
        {
            group(Control52)
            {
                field("Gen. Bus. Posting Group2";Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Caption = 'Gen. Bus. Posting Group';
                    Editable = false;
                }
                field("Gen. Prod. Posting Group2";Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Caption = 'Gen. Prod. Posting Group';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        modify("&Copy")
        {
            ApplicationArea = Basic;
        }
        modify(SuggestAccounts)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Copy"(Action 39)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
