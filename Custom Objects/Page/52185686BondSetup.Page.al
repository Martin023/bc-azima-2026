page 52185686 "Bond Setup"
{
    PageType = List;
    SourceTable = "Bond Setup";
    ApplicationArea = Basic, Suite;
    usagecategory = Administration;
    Caption = 'Bond Setup';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bond Post Gen. Journal Templat"; Rec."Bond Post Gen. Journal Templat")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bond Post Gen. Journal Batch"; Rec."Bond Post Gen. Journal Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Excise Duty Account"; Rec."Excise Duty Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bid-Bond Charge %(per quarter)"; Rec."Bid-Bond Charge %(per quarter)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bid-Bond Charges Income Acc."; Rec."Bid-Bond Charges Income Acc.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bid-Bond Chg Bank Share Vendor"; Rec."Bid-Bond Chg Bank Share Vendor")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bid Bond Charge-Stima Share%"; Rec."Bid Bond Charge-Stima Share%")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bid Bond Charge-Bank Share%"; Rec."Bid Bond Charge-Bank Share%")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bid Bond Minimum Charge"; Rec."Bid Bond Minimum Charge")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Performance Bond Acc. Type"; Rec."Performance Bond Acc. Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Performance Bond Cover %"; Rec."Performance Bond Cover %")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Perf.Bond Charge%(per quarter)"; Rec."Perf.Bond Charge%(per quarter)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Performance Charge Income Acc."; Rec."Performance Charge Income Acc.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Perf.Bond Chg Bank Share Vendo"; Rec."Perf.Bond Chg Bank Share Vendo")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Perf. Bond Charge-Stima Share%"; Rec."Perf. Bond Charge-Stima Share%")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Perf. Bond Charge-Bank Share%"; Rec."Perf. Bond Charge-Bank Share%")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Performance Bond Min. Charg"; Rec."Performance Bond Min. Charg")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bond Nos."; Rec."Bond Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

