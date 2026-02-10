#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185435 pageextension52185435 extends "Chart of Accounts"
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Net Change")
        {
            ApplicationArea = Basic;


        }
        modify(Balance)
        {
            ApplicationArea = Basic;

        }
        modify("Income/Balance")
        {
            ApplicationArea = Basic;
        }
        modify("Account Category")
        {
            ApplicationArea = Basic;

        }
        modify("Account Subcategory Descript.")
        {
            ApplicationArea = Basic;

        }
        modify("Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Direct Posting")
        {
            ApplicationArea = Basic;
            Visible = true;
        }
        modify(Totaling)
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Posting Type")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Debit Amount")
        {
            ApplicationArea = Basic;


        }
        modify("Credit Amount")
        {
            ApplicationArea = Basic;


        }
        modify("Balance at Date")
        {
            ApplicationArea = Basic;
        }
        modify("Additional-Currency Net Change")
        {
            ApplicationArea = Basic;
        }
        modify("Add.-Currency Balance at Date")
        {
            ApplicationArea = Basic;
        }
        modify("Additional-Currency Balance")
        {
            ApplicationArea = Basic;
        }
        modify("Consol. Debit Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Consol. Credit Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Type No.")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Consol. Translation Method")
        {
            ApplicationArea = Basic;
        }
        modify("Default IC Partner G/L Acc. No")
        {
            ApplicationArea = Basic;
        }
        modify("Default Deferral Template Code")
        {
            ApplicationArea = Basic;
            Visible = false;
        }

        addafter("No.")
        {
            field("Old Acc. No."; Rec."Old Acc. No.")
            {

            }
        }
        // addafter(Totaling)
        // {
        //     field("Direct Posting"; Rec."Direct Posting")
        //     {

        //     }
        // }


        moveafter("Debit Amount"; "Credit Amount")
        moveafter("Credit Amount"; "Balance")
        moveafter(Balance; "Net Change")
        moveafter("Account Category"; "Direct Posting")

        addafter("Net Change")
        {
            field("Budgeted Amount"; Rec."Budgeted Amount")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        modify("Ledger E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
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
        modify("E&xtended Texts")
        {
            ApplicationArea = Basic;
        }
        modify("Receivables-Payables")
        {
            ApplicationArea = Basic;
        }
        modify("Where-Used List")
        {
            ApplicationArea = Basic;
        }
        modify("G/L &Account Balance")
        {
            ApplicationArea = Basic;
        }
        modify("G/L &Balance")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Balance by &Dimension")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Account Balance/Bud&get")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Balance/B&udget")
        {
            ApplicationArea = Basic;
        }
        modify("Chart of Accounts &Overview")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Register")
        {
            ApplicationArea = Basic;
        }
        modify(IndentChartOfAccounts)
        {
            ApplicationArea = Basic;
        }
        modify("General Journal")
        {
            Caption = 'Recurring General Journal';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunObject) on ""General Journal"(Action 70)".


            //Unsupported feature: Property Modification (Name) on ""General Journal"(Action 70)".

        }
        modify("Close Income Statement")
        {
            ApplicationArea = Basic;
        }
        modify(DocsWithoutIC)
        {
            ApplicationArea = Basic;
        }
        // modify("Detail Trial Balance")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Trial Balance")
        {
            ApplicationArea = Basic;
            Visible = true;
        }
        addafter("Detail Trial Balance")
        {
            action(CustomTrialBalance)
            {
                Caption = 'Custom Detail Trial Bal.';
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    Report.run(report::"Custom Detail Trial Bal.");
                end;
            }
        }
        // modify("Trial Balance by Period")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (Promoted) on ""Trial Balance by Period"(Action 1902174606)".

        // }
        modify(Action1900210206)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on "Action1900210206(Action 1900210206)".

        }



        modify(SetDimensionFilter)
        {
            Visible = false;
        }



        addafter("G/L Balance by &Dimension")
        {
            separator(Action52)
            {
                Caption = '';
            }
        }
        addafter("G/L Balance/B&udget")
        {
            separator(Action55)
            {
            }
        }
    }


}
