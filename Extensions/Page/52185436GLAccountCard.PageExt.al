#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185436 pageextension52185436 extends "G/L Account Card"
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
        modify("Income/Balance")
        {
            ApplicationArea = Basic;
        }

        modify("Debit/Credit")
        {
            ApplicationArea = Basic;
        }
        modify("Account Type")
        {
            ApplicationArea = Basic;
        }
        modify(Totaling)
        {
            ApplicationArea = Basic;
        }
        modify("No. of Blank Lines")
        {
            ApplicationArea = Basic;
        }
        modify("New Page")
        {
            ApplicationArea = Basic;
        }
        modify("Search Name")
        {
            ApplicationArea = Basic;
        }
        modify(Balance)
        {
            ApplicationArea = Basic;
        }
        modify("Reconciliation Account")
        {
            ApplicationArea = Basic;
        }
        modify("Automatic Ext. Texts")
        {
            ApplicationArea = Basic;
        }
        modify("Direct Posting")
        {
            ApplicationArea = Basic;
        }
        modify(Blocked)
        {
            ApplicationArea = Basic;
        }
        modify("Last Date Modified")
        {
            ApplicationArea = Basic;
        }
        modify("Omit Default Descr. in Jnl.")
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
        modify("Default IC Partner G/L Acc. No")
        {
            ApplicationArea = Basic;
        }
        modify("Default Deferral Template Code")
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
        modify("Consol. Translation Method")
        {
            ApplicationArea = Basic;
        }
        modify("Exchange Rate Adjustment")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Type No.")
        {
            ApplicationArea = Basic;
        }


        // modify("Account Category")
        // {
        //     Visible = true;
        // }
        addafter("No.")
        {
            field("Old Acc. No."; Rec."Old Acc. No.")
            {

            }
        }


        addafter("Omit Default Descr. in Jnl.")
        {
            field("Budget Controlled"; rec."Budget Controlled")
            {
                ApplicationArea = Basic;
            }
        }
        // moveafter("No."; SubCategoryDescription)
        moveafter("Income/Balance"; "Debit/Credit")
        addafter(Balance)
        {
            field("Budgeted Amount"; Rec."Budgeted Amount")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Budget Filter"; Rec."Budget Filter")
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
        modify(Dimensions)
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
        modify("General Posting Setup")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Posting Setup")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Register")
        {
            ApplicationArea = Basic;
        }

        modify(Action1900210206)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on "Action1900210206(Action 1900210206)".

        }
        modify("Apply Template")
        {
            ApplicationArea = Basic;
        }



        modify(DocsWithoutIC)
        {
            Visible = false;
        }
    }


    trigger OnOpenPage()
    begin
        EditCard();
    end;


    procedure EditCard()
    var
        StatusPermission: Record 52185687;
        ErrorOnRestrictViewTxt: label 'You do not have permissions to EDIT this Page. Contact your system administrator for further details';
    begin
        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", UserId);
        StatusPermission.SetRange("Edit  G/L Account", true);
        //StatusPermission.SetRange("View G/L Account", true);
        if not StatusPermission.Find('-') then begin
            CurrPage.Editable := false;
        end;
    end;

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
