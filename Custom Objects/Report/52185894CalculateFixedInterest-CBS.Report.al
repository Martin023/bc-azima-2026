#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185894 "Calculate Fixed Interest- CBS"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            CalcFields = Balance, "Balance (LCY)", "Net Change", "Net Change (LCY)";
            DataItemTableView = where("Product Category" = const("Fixed Deposit"));
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Account';
            column(ReportForNavId_1102755000; 1102755000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Savings Accounts".SetRange("FD Maturity Date", Today);
                GenSetup.Get;
                ProductFactory.Get("Savings Accounts"."Product Type");
                ProductFactory.TestField("Interest Payable Account");
                ProductFactory.TestField("Withholding Tax Account");
                case "Savings Accounts"."FD Maturity Instructions" of
                    "Savings Accounts"."fd maturity instructions"::" ":
                        exit;
                    "Savings Accounts"."fd maturity instructions"::"Renew Principal & Interest":
                        begin
                            LiquidateInterest();
                            WithholdingTax();
                            LiquidatePrinciple();
                            TransferPrincipleToFixedDeposit();
                            "Savings Accounts"."Fixed Deposit Status" := "Savings Accounts"."fixed deposit status"::Active;
                            "Savings Accounts".Modify;
                        end;
                    "Savings Accounts"."fd maturity instructions"::"Renew Principal":
                        begin
                            LiquidateInterest();
                            WithholdingTax();
                            "Savings Accounts"."Fixed Deposit Status" := "Savings Accounts"."fixed deposit status"::Active;
                            "Savings Accounts".Modify;
                        end;
                    "Savings Accounts"."fd maturity instructions"::"Transfer all to Savings":
                        begin
                            LiquidateInterest();
                            WithholdingTax();
                            LiquidatePrinciple();
                            "Savings Accounts"."Fixed Deposit Status" := "Savings Accounts"."fixed deposit status"::Matured;
                            "Savings Accounts".Modify;
                        end;
                end
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin

        Message('Completed successfully');
    end;

    trigger OnPreReport()
    begin
        JournalTemplate := 'GENERAL';
        JournalBatch := 'DEFAULT';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
        GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
        GenJournalLine.DeleteAll;

        DocNo := 'INT_EARNED';
        PostingDate := Today;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        ProductFactory: Record "Product Factory";
        LineNo: Integer;
        GenSetup: Record "General Set-Up";
        PostingDate: Date;
        DocNo: Code[20];
        JournalTemplate: Text;
        JournalBatch: Text;


    local procedure AccruedInt(): Decimal
    var
        FDInterestCalculationRules: Record "FD Interest Calculation Rules";
    begin
        if "Savings Accounts"."Neg. Interest Rate" <> 0 then
            exit(
            "Savings Accounts"."Net Change (LCY)" * "Savings Accounts"."Neg. Interest Rate" / 100 * 1 / 12);

        FDInterestCalculationRules.Reset;
        FDInterestCalculationRules.SetRange(FDInterestCalculationRules.Code, "Savings Accounts"."Fixed Deposit Type");
        FDInterestCalculationRules.SetFilter(FDInterestCalculationRules."Minimum Amount", '<=%1', "Savings Accounts"."Net Change (LCY)");
        FDInterestCalculationRules.SetFilter(FDInterestCalculationRules."Maximum Amount", '>=%1', "Savings Accounts"."Net Change (LCY)");
        FDInterestCalculationRules.FindSet;
        exit(
        "Savings Accounts"."Net Change (LCY)" * FDInterestCalculationRules."Interest Rate" / 100 * 1 / 12);
    end;

    local procedure IntLineNo(): Integer
    begin
        LineNo := LineNo + 10000;
        exit(LineNo);
    end;

    local procedure LiquidateInterest()
    begin

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := JournalTemplate;
        GenJournalLine."Line No." := IntLineNo;
        GenJournalLine."Journal Batch Name" := JournalBatch;
        GenJournalLine."Document No." := DocNo;
        GenJournalLine."External Document No." := "Savings Accounts"."No.";
        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
        GenJournalLine."Account No." := "Savings Accounts"."No.";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'FXD Interest-' + "Savings Accounts"."No.";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -(AccruedInt);
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No." := ProductFactory."Interest Payable Account";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    local procedure WithholdingTax()
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := JournalTemplate;
        GenJournalLine."Line No." := IntLineNo;
        GenJournalLine."Journal Batch Name" := JournalBatch;
        GenJournalLine."Document No." := DocNo;
        GenJournalLine."External Document No." := "Savings Accounts"."No.";
        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
        GenJournalLine."Account No." := "Savings Accounts"."No.";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'W/Tax on FXD Int-' + "Savings Accounts"."No.";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := AccruedInt * 15 / 100;//AccruedInt * ProductFactory."WithHolding Tax"/100;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No." := ProductFactory."Withholding Tax Account";
        GenJournalLine."Shortcut Dimension 1 Code" := "Savings Accounts"."Global Dimension 1 Code";
        GenJournalLine."Shortcut Dimension 2 Code" := "Savings Accounts"."Global Dimension 2 Code";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    local procedure LiquidatePrinciple()
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := JournalTemplate;
        GenJournalLine."Line No." := IntLineNo;
        GenJournalLine."Journal Batch Name" := JournalBatch;
        GenJournalLine."Document No." := DocNo;
        GenJournalLine."External Document No." := "Savings Accounts"."No.";
        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
        GenJournalLine."Account No." := "Savings Accounts"."No.";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'FXD Principal-' + "Savings Accounts"."No.";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := "Savings Accounts"."Net Change (LCY)";
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Savings;
        GenJournalLine."Bal. Account No." := "Savings Accounts"."No.";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    local procedure TransferPrincipleToFixedDeposit()
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := JournalTemplate;
        GenJournalLine."Line No." := IntLineNo;
        GenJournalLine."Journal Batch Name" := JournalBatch;
        GenJournalLine."Document No." := DocNo;
        GenJournalLine."External Document No." := "Savings Accounts"."No.";
        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
        GenJournalLine."Account No." := "Savings Accounts"."No.";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'FXD Principal-' + "Savings Accounts"."No.";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := Abs("Savings Accounts"."Net Change (LCY)") + (AccruedInt);
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Savings;
        GenJournalLine."Bal. Account No." := "Savings Accounts"."No.";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;
}
