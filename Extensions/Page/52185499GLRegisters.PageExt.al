#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185499 pageextension52185499 extends "G/L Registers"
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Creation Date")
        {
            ApplicationArea = Basic;
        }
        modify("User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Source Code")
        {
            ApplicationArea = Basic;
        }
        modify("Journal Batch Name")
        {
            ApplicationArea = Basic;
        }
        modify(Reversed)
        {
            ApplicationArea = Basic;
            Enabled = AllowReversals;
        }
        modify("From Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("To Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("From VAT Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("To VAT Entry No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Creation Date"(Control 4)".

        modify("Creation Time")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Journal Batch Name"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reversed(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""From Entry No."(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""To Entry No."(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""From VAT Entry No."(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""To VAT Entry No."(Control 29)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("General Ledger")
        {
            ApplicationArea = Basic;
        }
        modify("Customer &Ledger")
        {
            ApplicationArea = Basic;
        }
        modify("Ven&dor Ledger")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Account Ledger")
        {
            ApplicationArea = Basic;
        }
        modify("Fixed &Asset Ledger")
        {
            ApplicationArea = Basic;
        }
        modify("Maintenance Ledger")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Item Ledger Relation")
        {
            ApplicationArea = Basic;
        }
        modify(ReverseRegister)
        {
            ApplicationArea = Basic;
        }

        modify("Detail Trial Balance")
        {
            ApplicationArea = Basic;
        }
        // modify("Trial Balance")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Trial Balance by Period")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Register")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on ""G/L Register"(Action 1900210206)".

        }
        addafter("G/L Register")
        {
            action("Savings Ledger")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Savings Ledger';
                Image = Register;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Codeunit "G/L Reg.-Gen. Ledger";
                ToolTip = 'View the savings ledger entries that resulted in the current register entry.';

                trigger OnAction()
                begin
                    SavingsLedgerEntry.SetRange("Entry No.", Rec."From Entry No.", Rec."To Entry No.");
                    PAGE.Run(PAGE::"Savings Ledger Entries", SavingsLedgerEntry);
                end;
            }
        }
        addafter("Savings Ledger")
        {
            action("Credit Ledger")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Credit Ledger';
                Image = Register;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Codeunit "G/L Reg.-Gen. Ledger";
                ToolTip = 'View the credit ledger entries that resulted in the current register entry.';

                trigger OnAction()
                begin
                    CreditLedgerEntry.SetRange("Entry No.", Rec."From Entry No.", Rec."To Entry No.");
                    PAGE.Run(PAGE::"Credit Ledger Entries", CreditLedgerEntry);
                end;
            }
        }


        //Unsupported feature: Property Deletion (ToolTipML) on ""General Ledger"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer &Ledger"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ven&dor Ledger"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Account Ledger"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fixed &Asset Ledger"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Maintenance Ledger"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Entries"(Action 14)".

        modify("Employee Ledger")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Ledger Relation"(Action 35)".


        //Unsupported feature: Code Modification on "ReverseRegister(Action 32).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("No.");
        ReversalEntry.ReverseRegister("No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        TESTFIELD("No.");
        {IF USERID="User ID" THEN
          ERROR(Err001);}
        ReversalEntry.ReverseRegister("No.");
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ReverseRegister(Action 32)".



        modify("Delete Empty Registers")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Detail Trial Balance"(Action 1900670506)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Trial Balance"(Action 1904082706)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Trial Balance by Period"(Action 1902174606)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Register"(Action 1900210206)".

    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        AllowReversals := false;
        UserSetup.Get(UserId);
        if UserSetup."Post Reversals" = true then
            AllowReversals := true;
        if Rec."Creation Date" <> Today then
            AllowReversals := false;

    end;

    var
        Err001: label 'You cannot reverse a transaction you posted';
        UserSetup: Record "User Setup";
        AllowReversals: Boolean;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        CreditLedgerEntry: Record "Credit Ledger Entry";

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (SourceTableView).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
