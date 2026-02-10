#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185637 "Deposit To Shares Transfer"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where(Status = const(Active));
            column(ReportForNavId_1; 1)
            {
            }
            column(MemberNo; Members."No.")
            {
            }
            column(MemberName; Members.Name)
            {
            }
            column(DepositAccount; DepositAccounts."No.")
            {
            }
            column(SharesAccount; SharesAccounts."No.")
            {
            }
            column(AmountTransfered; TransferAmount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if MemberClass.Get("Member Class") then begin
                    MaxShares := MemberClass."Share Capital";
                    MinShares := MemberClass."Share Capital";
                end;

                Evaluate(AsAt, Format(PostingDate));
                DateFilter := '01/01/2005' + '..' + AsAt;



                DepositAccounts.Reset;
                DepositAccounts.SetFilter(DepositAccounts."Product Type", DepositProduct);
                DepositAccounts.SetRange(DepositAccounts."Member No.", "No.");
                DepositAccounts.SetFilter(DepositAccounts.Balance, '>=20000');
                DepositAccounts.SetFilter("Date Filter", DateFilter);
                if DepositAccounts.Find('-') then begin
                    DepositAccounts.CalcFields(Balance);

                    SharesAccounts.Reset;
                    SharesAccounts.SetFilter(SharesAccounts."Product Type", ShareCapProduct);
                    SharesAccounts.SetRange(SharesAccounts."Member No.", "No.");
                    SharesAccounts.SetFilter(SharesAccounts.Balance, '<%1', MaxShares);
                    if SharesAccounts.Find('-') then begin
                        SharesAccounts.CalcFields(Balance);

                        TransferAmount := (MaxShares - SharesAccounts.Balance);

                        if DepositAccounts.Balance < TransferAmount then TransferAmount := DepositAccounts.Balance;
                        LineNo := LineNo + 10000;
                        //Post From Deposit Account
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := JTemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Document No." := DocumentNo;
                        GenJournalLine."Posting Date" := PostingDate;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                        GenJournalLine."Account No." := DepositAccounts."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        GenJournalLine.Description := 'Deposits To Shares Transfer.';
                        GenJournalLine.Amount := TransferAmount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then GenJournalLine.Insert;


                        LineNo := LineNo + 10000;
                        //Post To Shares Account
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := JTemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Document No." := DocumentNo;
                        GenJournalLine."Posting Date" := PostingDate;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                        GenJournalLine."Account No." := SharesAccounts."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        GenJournalLine.Description := 'Deposits To Shares Transfer.';
                        GenJournalLine.Amount := -TransferAmount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then GenJournalLine.Insert;

                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                //JournalPosting.CompletePosting(JTemplate,JBatch);
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JTemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.Find('-') then begin
                    Confirm_Message := ('System generated ' + Format(GenJournalLine.Count / 2) + ' Journal Lines. \Are you sure you want to transfer schedule?');
                    if Confirm(Confirm_Message, false) = true then Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                end;
            end;

            trigger OnPreDataItem()
            begin
                if PostingDate = 0D then Error(DateErrorTxt);
                if StrLen(DocumentNo) = 0 then Error(DocNoErrorTxt);
                if StrLen(DepositProduct) = 0 then Error(DepositProductTxt);
                if StrLen(ShareCapProduct) = 0 then Error(ShareCapProductTxt);

                Temp.Get(UserId);
                Temp.TestField("Cashier Journal Batch");
                Temp.TestField("Cashier Journal Template");
                JTemplate := Temp."Cashier Journal Template";
                JBatch := Temp."Cashier Journal Batch";

                GenJournalLine.Reset;
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemplate);
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
                if GenJournalLine.FindFirst then GenJournalLine.DeleteAll;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Control5)
                {
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = Basic;
                    }
                    field(DocumentNo; DocumentNo)
                    {
                        ApplicationArea = Basic;
                    }
                    grid(Control6)
                    {
                        GridLayout = Rows;
                        group(Control7)
                        {
                            field("From [Deposit] :"; DepositProduct)
                            {
                                ApplicationArea = Basic;
                                TableRelation = "Product Factory" where("Product Category" = filter("BOSA Deposits"));
                            }
                            field("To [ShareCapital] :"; ShareCapProduct)
                            {
                                ApplicationArea = Basic;
                                TableRelation = "Product Factory" where("Product Category" = filter("Share Capital"));
                            }
                        }
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        DepositProduct: Code[10];
        ShareCapProduct: Code[10];
        PostingDate: Date;
        DateErrorTxt: label 'Date filter is missing.';
        DocumentNo: Text;
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        MinDeposits: Decimal;
        MaxShares: Decimal;
        MinShares: Decimal;
        MemberClass: Record "Member Classes";
        DepositAccounts: Record "Savings Accounts";
        TransferAmount: Decimal;
        SharesAccounts: Record "Savings Accounts";
        DocNoErrorTxt: label 'Kindly Enter the Document No';
        DepositProductTxt: label 'Specify Deposit Product From [Deposit]';
        ShareCapProductTxt: label 'Specify Share Capital Product To [ShareCapital]';
        Temp: Record "Banking User Template";
        JTemplate: Code[20];
        JBatch: Code[20];
        LineNo: Integer;
        TransType: Enum "Transaction Types";
        AccType: Enum "Gen. Journal Account Type";
        AccountNo: array[3] of Code[20];
        Description: array[3] of Text;
        JournalPosting: Codeunit "Journal Posting";
        JournalPostingSucc: Codeunit "Journal Post Successful";
        Desc1Txt: label 'Transfer to Share Capital :-';
        Desc2Txt: label 'Transfer from Deposit :-';
        GenJournalLine: Record "Gen. Journal Line";
        Confirm_Message: Text;
        AsAt: Text;
        DateFilter: Text[100];
}
