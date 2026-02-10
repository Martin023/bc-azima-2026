page 52186214 "Tenant Receipts Line"
{
    PageType = ListPart;
    SourceTable = "Receipt Line";
    layout
    {
        area(content)
        {
            repeater(Control1102760083)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        RecPayTypes.Reset;
                        RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Receipt);
                        RecPayTypes.SetRange(RecPayTypes.Code, Rec.Type);
                        if RecPayTypes.Find('-') then begin
                            if RecPayTypes."Account Type" = RecPayTypes."Account Type"::"G/L Account" then begin
                                "Account No.Editable" := false;
                            end
                            else begin
                                "Account No.Editable" := true;
                            end;
                        end;
                    end;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Name';
                }
                field(description; Rec."Description")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        PayModeOnAfterValidate;
                    end;
                }
                field("Grant No"; Rec."Grant No")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Cheque/Deposit Slip Bank"; Rec."Cheque/Deposit Slip Bank")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Cheque/Deposit Slip Type"; Rec."Cheque/Deposit Slip Type")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Cheque/Deposit Slip Date"; Rec."Cheque/Deposit Slip Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Deposit Slip Time"; Rec."Deposit Slip Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque/Deposit Slip No"; Rec."Cheque/Deposit Slip No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Teller ID"; Rec."Teller ID")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withholding Tax Amount"; Rec."Withholding Tax Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Clear Loan"; rec."Clear Loan")
                {
                    ApplicationArea = Basic, Suite;
                    visible = rec."Loan No." <> '';
                    Editable = rec."Loan No." <> '';
                }
                field("Loan Oustanding Principal"; Rec."Loan Oustanding Principal")
                {
                    ApplicationArea = Basic, Suite;
                    editable = false;
                }
                field("Loan Outstanding Interest"; Rec."Loan Outstanding Interest")
                {
                    ApplicationArea = Basic, Suite;
                    editable = false;
                }
                field("Total Outstanding Loan"; Rec."Total Outstanding Loan")
                {
                    ApplicationArea = Basic, Suite;
                    editable = false;
                }
                field("Daily Interest"; Rec."Daily Interest")
                {
                    ApplicationArea = Basic, Suite;
                    editable = false;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(1, ShortcutDimCode[1]);
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(2, ShortcutDimCode[2]);
                    end;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Import)
            {
                ApplicationArea = Basic, Suite;

                RunObject = XMLport "Receipt ";
            }
            // action(Post)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Post';
            //     Image = Post;
            //     // Promoted = true;
            //     // PromotedCategory = Process;
            //     // PromotedIsBig = true;
            //     Visible = false;

            //     trigger OnAction()
            //     begin
            //         if Rec.Posted then
            //             Error('The transaction has already been posted.');

            //         if Rec."Transaction Name" = '' then
            //             Error('Please enter the transaction description under transaction name.');

            //         if Rec.Amount = 0 then
            //             Error('Please enter amount.');

            //         if Rec.Amount < 0 then
            //             Error('Amount cannot be less than zero.');

            //         if Rec."Global Dimension 1 Code" = '' then
            //             Error('Please enter the Function code');

            //         if Rec."Shortcut Dimension 2 Code" = '' then
            //             Error('Please enter the source of funds.');

            //         /*
            //         CashierLinks.RESET;
            //         CashierLinks.SETRANGE(CashierLinks.UserID,USERID);
            //         IF CashierLinks.FIND('-') THEN BEGIN
            //         END
            //         ELSE BEGIN
            //         ERROR('Please link the user/cashier to a collection account before proceeding.');
            //         END;
            //         */

            //         // DELETE ANY LINE ITEM THAT MAY BE PRESENT
            //         GenJnlLine.Reset;
            //         GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'CASH RECEI');
            //         GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", Rec.No);
            //         GenJnlLine.DeleteAll;

            //         if DefaultBatch.Get('CASH RECEI', Rec.No) then
            //             DefaultBatch.Delete;

            //         DefaultBatch.Reset;
            //         DefaultBatch."Journal Template Name" := 'CASH RECEI';
            //         DefaultBatch.Name := Rec.No;
            //         DefaultBatch.Insert;

            //         GenJnlLine.Init;
            //         GenJnlLine."Journal Template Name" := 'CASH RECEI';
            //         GenJnlLine."Journal Batch Name" := rec.No;
            //         GenJnlLine."Line No." := 10000;
            //         GenJnlLine."Account Type" := Rec."Account Type";
            //         GenJnlLine."Account No." := Rec."Account No.";
            //         GenJnlLine.Validate(GenJnlLine."Account No.");
            //         GenJnlLine."Posting Date" := Rec.Date;
            //         GenJnlLine."Document No." := Rec.No;
            //         GenJnlLine."External Document No." := Rec."Cheque/Deposit Slip No";
            //         GenJnlLine.Amount := -Rec."Total Amount";
            //         GenJnlLine.Validate(GenJnlLine.Amount);

            //         GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
            //         GenJnlLine."Applies-to Doc. No." := Rec."Apply to";
            //         //GenJnlLine."Bal. Account No.":=CashierLinks."Bank Account No";
            //         if Rec."Bank Code" = '' then
            //             Error('Select the Bank Code');


            //         GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
            //         GenJnlLine.Description := Rec."Transaction Name";
            //         GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
            //         GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            //         GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
            //         GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");

            //         if GenJnlLine.Amount <> 0 then
            //             GenJnlLine.Insert;


            //         GenJnlLine.Init;
            //         GenJnlLine."Journal Template Name" := 'CASH RECEI';
            //         GenJnlLine."Journal Batch Name" := Rec.No;
            //         GenJnlLine."Line No." := 10001;
            //         GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
            //         GenJnlLine."Account No." := Rec."Bank Code";
            //         GenJnlLine.Validate(GenJnlLine."Account No.");
            //         GenJnlLine."Posting Date" := Rec.Date;
            //         GenJnlLine."Document No." := Rec.No;
            //         GenJnlLine."External Document No." := Rec."Cheque/Deposit Slip No";
            //         GenJnlLine.Amount := Rec."Total Amount";
            //         GenJnlLine.Validate(GenJnlLine.Amount);




            //         GenJnlLine.Description := Rec."Transaction Name";
            //         GenJnlLine."Shortcut Dimension 1 Code" := Rec."Dest Global Dimension 1 Code";
            //         GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            //         GenJnlLine."Shortcut Dimension 2 Code" := Rec."Dest Shortcut Dimension 2 Code";
            //         GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");

            //         if GenJnlLine.Amount <> 0 then
            //             GenJnlLine.Insert;

            //         GenJnlLine.Reset;
            //         GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'CASH RECEI');
            //         GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", Rec.No);
            //         CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Line", GenJnlLine);

            //         GenJnlLine.Reset;
            //         GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'CASH RECEI');
            //         GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", Rec.No);
            //         if GenJnlLine.Find('-') then
            //             exit;

            //         Rec.Posted := true;
            //         Rec."Date Posted" := Today;
            //         Rec."Time Posted" := Time;
            //         Rec."Posted By" := UserId;
            //         Rec.Modify;

            //     end;
            // }
            // action(Print)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Print';
            //     Image = Print;
            //     // Promoted = true;
            //     // PromotedCategory = Process;

            //     trigger OnAction()
            //     begin
            //         if Rec.Posted = false then
            //             Error('Post the receipt before printing.');
            //         Rec.Reset;
            //         Rec.SetFilter(No, Rec.No);
            //         //REPORT.Run(52015, true, true, Rec);
            //         Rec.Reset;
            //     end;
            // }
            // action("Direct Printing")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Direct Printing';
            //     // Promoted = true;
            //     // PromotedCategory = Process;

            //     trigger OnAction()
            //     begin
            //         if Rec.Posted = false then
            //             Error('Post the receipt before printing.');
            //         Rec.Reset;
            //         Rec.SetFilter(No, Rec.No);
            //         //REPORT.Run(52015, false, true, Rec);
            //         Rec.Reset;
            //     end;
            // }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnInit()
    begin
        "Account No.Editable" := true;
        "Bank AccountVisible" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        RecPayTypes: Record "Receipts and Payment Types";
        DimName1: Text[100];
        rdimname1: Text[100];
        rdimname2: Text[100];
        DImName2: Text[100];
        Custledger: Record "Cust. Ledger Entry";
        CustLedger1: Record "Cust. Ledger Entry";
        ApplyEntry: Codeunit "Sales Header Apply";
        AppliedEntries: Record "Workplan Activities";
        CustEntries: Record "Cust. Ledger Entry";
        LineNo: Integer;

        "Bank AccountVisible": Boolean;

        "Account No.Editable": Boolean;
        ShortcutDimCode: array[8] of Code[20];

    local procedure PayModeOnAfterValidate()
    begin
        if Rec."Pay Mode" = Rec."Pay Mode"::"Deposit Slip" then begin
            "Bank AccountVisible" := true;
        end
        else begin
            "Bank AccountVisible" := false;
        end;
    end;
}

