page 52185794 "Cashier Transactions"
{
    DeleteAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Workflow Actions,Budgetary Control,Cancellation,References,Category8_caption,Workflow,Category10_caption';
    SourceTable = "Cashier Transactions";
    SourceTableView = SORTING(No)
                      ORDER(Descending);


    layout
    {
        area(content)
        {
            group(Transactions)
            {
                Caption = 'Transactions';
                Editable = true;
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;

                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin

                        Rec."Account No" := '';
                        if Rec."Account Type" = Rec."Account Type"::MPESA then
                            AccNo := false else
                            AccNo := true;
                    end;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;


                    trigger OnValidate()
                    begin
                        // SavingsAccounts.
                        //CheckMemberInfomation();
                        SavingsAccounts.Reset();
                        SavingsAccounts.SetRange(SavingsAccounts."No.", Rec."Account No");
                        if SavingsAccounts.FindFirst() then begin
                            LoaneeInfomationBase.Reset();
                            LoaneeInfomationBase.SetRange("Member No.", SavingsAccounts."No.");
                            LoaneeInfomationBase.SetFilter(Info, '<>%1', '');
                            if LoaneeInfomationBase.Find('-') then begin
                                repeat
                                    if (LoaneeInfomationBase."Expiry Date" = 0D) or (LoaneeInfomationBase."Expiry Date" > Today) then
                                        Message(LoaneeInfomationBase.Info);
                                until LoaneeInfomationBase.Next = 0;
                            end;

                        end;

                    end;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }

                field("Account Status"; Rec."Account Status")
                {
                    Editable = false;
                    ApplicationArea = Basic;
                }
                field(mNO; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                    Editable = false;
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;

                    Editable = TransType;

                    trigger OnValidate()
                    begin
                        RecoveryAccent;
                        FChequeVisible := false;
                        BChequeVisible := false;
                        BReceiptVisible := false;
                        MPESATYPEVisible := false;
                        BOSAReceiptChequeVisible := false;
                        AllAmount := false;
                        DiscCH := false;
                        RCheque := false;
                        CLien := false;
                        NormalChequeVisible := false;

                        if Rec.Type = Rec.Type::"Cheque Deposit" then begin
                            FChequeVisible := true;
                            DiscCH := true;
                            BankBankEdit := false;
                        end;

                        if Rec.Type = Rec.Type::"Bankers Cheque" then
                            BChequeVisible := true;
                        if rec.Type = rec.Type::"Cancel Bankers Cheque" then
                            BChequeVisible := true;
                        if rec.Type = rec.Type::"Cheque Withdrawal" then
                            NormalChequeVisible := true;

                        if rec.Type = rec.Type::Lien then
                            CLien := true;

                        if Rec.Type = Rec.Type::"Credit Receipt" then begin
                            BReceiptVisible := true;
                            AllAmount := true;
                        end;

                        if Rec.Type = Rec.Type::"Credit Cheque" then begin
                            FChequeVisible := true;
                            BOSAReceiptChequeVisible := true;
                            AllAmount := true;
                        end;

                        if (Rec.Type = Rec.Type::"MPESA Deposit") or (Rec.Type = Rec.Type::"MPESA Withdrawal") then begin
                            MPESATYPEVisible := true;
                        end;
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;

                    Editable = Amont;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                        TransChrg: decimal;
                        TransactionCharges: record "Transaction Charges";
                        GenSetup: record "General Set-Up";
                        WithCharge: Decimal;
                        ChargeAmount: Decimal;
                        TariffDetails: Record "Tiered Charges Lines";
                        CashierTransType: record "Transaction Types";
                    begin

                        OverMillion := false;
                        //TransTypes.Get(Rec."Transaction Type");
                        //if (TransTypes.Type = TransTypes.Type::"Cash Deposit") OR (TransTypes.Type = TransTypes.Type::"Cash Withdrawal") then begin
                        if Rec.Amount >= 1000000 then begin
                            OverMillion := true;
                            Message('Transactions above 1 million require Source of Funds and Purpose of this Transaction. This will be flagged as an AML transaction.');
                        end;

                        //end;

                        // Acctypes for deposit to check if amt is > than cashier limit


                        if rec.Type = rec.Type::Lien then begin
                            SavingsAccounts.get(rec."Account No");
                            SavingsAccounts.CalcFields("Balance (LCY)");
                            if SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.") < rec.Amount then
                                Error('There is no enough balance in the account to place a Lien!');
                        end;

                        Rec.TestField("Account No");
                        Rec.TestField("Transaction Type");
                        TransChrg := 0;
                        if (rec.type = rec.Type::"Cash Withdrawal") or (Rec.Type = rec.type::"Bankers Cheque") then begin
                            GenSetup.get;
                            TransactionCharges.Reset;
                            TransactionCharges.SetRange(TransactionCharges."Transaction Type", Gensetup."Loan SMS Charge");
                            if TransactionCharges.FindSet() then begin
                                repeat
                                    TransChrg += TransactionCharges."Charge Amount";

                                    //Excise duty
                                    if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                                (TransactionCharges."Recover Excise Duty" = true) then begin
                                        TransChrg += Gensetup."Excise Duty (%)" * 0.01;
                                    end;
                                until TransactionCharges.Next = 0;
                            end;

                            WithCharge := 0;
                            if CashierTransType.get(rec.Type) then begin
                                TransactionCharges.Reset;
                                TransactionCharges.SetRange(TransactionCharges."Transaction Type", CashierTransType.Code);
                                if TransactionCharges.Find('-') then begin
                                    repeat
                                        ChargeAmount := 0;
                                        if (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::Normal) or
                                        (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::"Stamp Duty") then begin


                                            if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" = true then
                                                ChargeAmount := (rec.Amount * TransactionCharges."Percentage of Amount") * 0.01
                                            else
                                                ChargeAmount := TransactionCharges."Charge Amount";

                                            if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin

                                                TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                                                TariffDetails.Reset;
                                                TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                                if TariffDetails.Find('-') then begin
                                                    repeat
                                                        if (rec.Amount >= TariffDetails."Lower Limit") and (rec.Amount <= TariffDetails."Upper Limit") then begin
                                                            if TariffDetails."Use Percentage" = true then begin
                                                                ChargeAmount := rec.Amount * TariffDetails.Percentage * 0.01;
                                                            end else begin
                                                                ChargeAmount := TariffDetails."Charge Amount";
                                                            end;
                                                        end;
                                                    until TariffDetails.Next = 0;
                                                end;
                                            end;


                                            WithCharge += ChargeAmount;

                                            if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty") and (TransactionCharges."Recover Excise Duty") then begin

                                                //Excise Duty
                                                WithCharge += round(((ChargeAmount * GenSetup."Excise Duty (%)") * 0.01), 0.01, '<');
                                            end;
                                        end;
                                    until TransactionCharges.Next = 0;
                                end;

                            end;


                            if (Rec.Amount + TransChrg + WithCharge) > (SavingsAccounts.GetAvailableBalance(Rec."Account No") + 240) then
                                Error('This will result in overdrawing of members account including transaction')
                        end;



                        // if (Rec."Transaction Type" = 'CASH WITHDRWAL') or (Rec."Transaction Type" = 'BANKERS CHEQUE') or
                        //  (Rec."Transaction Type" = 'CASH WITHDRWAL') or (Rec."Transaction Type" = 'RTGS') or (Rec."Transaction Type" = 'STANDING ORDER') then
                        //     if Rec.Amount > (SavingsAccounts.GetAvailableBalance(Rec."Account No") + 240) then
                        //         Error('This will result in overdrawing of members account');

                    end;
                }
                // field("Currency Code"; Rec."Currency Code")
                // {
                //     ApplicationArea = Basic;

                //     Editable = Currr;
                // }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;

                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }
                // field("Employer Code"; Rec."Employer Code")
                // {
                //     ApplicationArea = Basic;

                //     Editable = false;
                // }
                // field("Mpesa Reference"; Rec."Mpesa Reference")
                // {
                //     ApplicationArea = Basic;

                //     Editable = Rec."Account Type" = Rec."Account Type"::MPESA;
                // }
                // field("Project Vendor"; Rec."Project Vendor")
                // {
                //     ApplicationArea = Basic;
                //     Editable = Rec."Account Type" = Rec."Account Type"::Teller;

                // }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = StyleExprTxt;

                }
                group(BCheque)
                {
                    Caption = 'Bankers Cheque Information';
                    Visible = BChequeVisible;
                    field(Payee; Rec.Payee)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;

                    }
                    field("Post Dated"; Rec."Post Dated")
                    {
                        ApplicationArea = Basic;

                    }
                    field("Bankers Cheque No"; Rec."Bankers Cheque No")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Bankers Cheque No';
                        Editable = (rec.Type = rec.Type::"Cancel Bankers Cheque") or (rec.Type = rec.Type::"Bankers Cheque");
                    }

                }
                group(MPESATYPE)
                {
                    Caption = 'M-PESA Information';
                    Visible = MPESATYPEVisible;
                    field("Reference Name"; Rec."Reference Name")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;

                    }
                    field("M-PESA Reference Code"; Rec."Mpesa Reference")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("M-PESA Float Balance"; Rec."MPESA Float Balance")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                }

                group(CTLIEN)
                {
                    Caption = 'Lien Information';
                    Visible = CLien;
                    field("Blockage Reason"; Rec."Blockage Reason")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;

                    }
                    field("Other Reason"; Rec."Other Reason")
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            if Rec."Blockage Reason" = Rec."Blockage Reason"::Others then
                                rec.TestField("Other Reason");
                        end;

                    }
                }
                group(Million)
                {
                    Caption = 'Over 1M information';
                    Visible = OverMillion;
                    field(Source; Rec.Source)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field(Purpose; Rec.Purpose)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;

                    }
                }
                group(BReceipt)
                {
                    Caption = '.';
                    Visible = BReceiptVisible;
                    field("Member No."; Rec."Member No.")
                    {
                        ApplicationArea = Basic;

                        Editable = false;
                    }
                    field(Control49; Rec."Allocated Amount")
                    {
                        ApplicationArea = Basic;

                    }
                }

                group(FCheque)
                {
                    Caption = 'Bankers Cheque Deposit Information';
                    Visible = FChequeVisible;
                    field("Cheque Type"; Rec."Cheque Type")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;

                    }
                    field("Bank Code"; Rec."Bank Code")
                    {
                        ApplicationArea = Basic;

                    }

                    field("Bank Name"; Rec."Bank Name")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field(BchequeNo; Rec."Cheque No")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque No';
                        ShowMandatory = true;

                    }

                    field(Payer; Rec."Payer")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Payer';
                        ShowMandatory = true;

                    }
                    field("Bank Account"; Rec."Bank Account")
                    {
                        ApplicationArea = Basic;

                        Caption = 'Bank';
                        Visible = true;
                        Editable = BankBankEdit;
                    }
                    field("Cheque Issueing Bank"; Rec."Cheque Issueing Bank")
                    {
                        ApplicationArea = Basic;

                    }
                    field("Cheque Date"; Rec."Cheque Date")
                    {
                        ApplicationArea = Basic;

                    }
                    field("Cheque Status"; Rec."Cheque Status")
                    {
                        ApplicationArea = Basic;

                        Editable = false;
                    }
                    field("Expected Maturity Date"; Rec."Expected Maturity Date")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    group(BOSAReceiptCheque)
                    {
                        Caption = '.';
                        Visible = BOSAReceiptChequeVisible;
                    }
                }
                group(NormCheque)
                {
                    Caption = 'Normal Cheque Information';
                    Visible = NormalChequeVisible;
                    field("Cheque Type2"; Rec."Cheque Type")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                        Caption = 'Cheque Type';

                    }
                    field(BchequeNo2; Rec."Cheque No")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque No';
                        ShowMandatory = true;

                    }

                    field(Payee2; Rec."Payee")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Payee';
                        ShowMandatory = true;

                    }
                    field("Bank Accoun2"; Rec."Bank Account")
                    {
                        ApplicationArea = Basic;

                        Caption = 'Bank';
                        Visible = true;
                        Editable = BankBankEdit;
                    }
                    field("Cheque Issueing Bank2"; Rec."Cheque Issueing Bank")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Issueing Bank';
                    }
                    field("Cheque Date2"; Rec."Cheque Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Date';
                    }
                    field("Cheque Status2"; Rec."Cheque Status")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Status';
                        Editable = false;
                    }
                    field("Expected Maturity Date2"; Rec."Expected Maturity Date")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Caption = 'Expected Maturity Date';
                    }
                    group(BOSAReceiptChequ2)
                    {
                        Caption = '.';
                        Visible = BOSAReceiptChequeVisible;
                    }
                }
                field("Book Balance"; Rec."Book Balance")
                {
                    ApplicationArea = Basic;

                }
                field("Available Balance"; Rec."Available Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Available Balance';
                    Editable = false;
                }
                field("New Account Balance"; Rec."New Account Balance")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Deposited By"; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = Remarrrks;
                }

                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;

                }
                field("Till Name"; Rec."Till Name")
                {
                    ApplicationArea = Basic;

                }
                field("Cashier Till Balance"; Rec."Cashier Till Balance")
                {
                    Visible = true;
                    Editable = false;

                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;

                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Attempted Self Transaction"; Rec."Attempted Self Transaction")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part("Approved Images"; "Member Picture & Signature")
            {
                ApplicationArea = Basic;

                Caption = 'Approved Images';
                SubPageLink = "Member No" = FIELD("Member No.");
            }
            systempart(Control13; Links)
            {

                Visible = false;
            }
            systempart(Control12; Notes)
            {

                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {

            group(Transaction)
            {
                Caption = 'Transaction';
                action(Statement)
                {
                    ApplicationArea = Basic;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Caption = 'Account Statement';

                    trigger OnAction()
                    var


                    begin
                        Account.Reset;
                        Account.SetRange(Account."No.", Rec."Account No");
                        if Account.Find('-') then
                            REPORT.Run(Report::"Savings Statement", true, false, Account)
                    end;
                }
                action(
                    "Account Page")
                {
                    ApplicationArea = Basic;

                    Caption = 'Account Page';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Category7;
                    RunObject = Page "Savings Account Card";
                    RunPageLink = "No." = FIELD("Account No");
                }


                action("Picture & Signature")
                {
                    ApplicationArea = Basic;
                    Image = Picture;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    begin
                        ImageData.Reset;
                        ImageData.SetRange(ImageData."Member No", Rec."Member No.");
                        if ImageData.Find('-') then begin
                            PAGE.Run(Page::"Payroll Changes Requested", ImageData);
                        end;
                    end;
                }



                action("Allocated Amount")
                {
                    ApplicationArea = Basic;

                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Cashier Transaction Lines";
                    RunPageLink = "Transaction No" = FIELD(No);
                    Visible = AllAmount;
                }
                action(Signatories)
                {
                    ApplicationArea = Basic;
                    Image = Signature;
                    Promoted = true;
                    PromotedCategory = Category7;
                    RunObject = Page "Signatories List";
                    RunPageLink = "Account No" = FIELD("Member No.");
                    RunPageView = WHERE(Signatory = CONST(true));
                }
            }
        }
        area(processing)
        {
            action("Post & Print")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SaccoT: Codeunit "Sacco Transactions";
                    BUserSetup: Record "Banking User Template";
                    BankAccount: Record "Bank Account";
                begin

                    if rec.Posted then error('This record has already been posted. If you wish to print kindly do it using reprint action');
                    BUserSetup.Get(rec.Cashier);
                    BankAccount.Get(BUserSetup."Default  Bank");
                    BankAccount.CalcFields("Balance (LCY)");
                    if BankAccount."Balance (LCY)" > BUserSetup."Maximum Withholding" then begin
                        //if (rec.Type <> rec.Type::"Cash Deposit") and (rec.Type = rec.Type::"Cheque Deposit") or (TransType.Type = TransType.Type::"Credit Receipt") then
                        Message('You need to Return money to treasury because you have exceeded the Max Withholding!')
                    end else
                        if BankAccount."Balance (LCY)" <= 0 then
                            Error('You need to request money from treasury first before proceeding!');

                    if Rec.Status = Rec.Status::"Pending Approval" then
                        Error('The transaction must be fully approved before proceeding');

                    if rec.Type = rec.Type::Lien then begin
                        SavingsAccounts.get(rec."Account No");
                        SavingsAccounts.CalcFields("Balance (LCY)");
                        if SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.") < rec.Amount then
                            Error('There is no enough balance in the account to place a Lien!');
                    end;

                    if (TransTypes.Type = TransTypes.Type::"Cash Deposit") OR (TransTypes.Type = TransTypes.Type::"Cash Withdrawal") then begin
                        if Rec.Amount >= 1000000 then begin
                            Rec.TestField(Source);
                            Rec.TestField(Purpose);
                        end;
                    end;
                    if Rec.Type = Rec.Type::"Cash Withdrawal" then begin
                        if Rec.Status <> Rec.Status::Approved then begin
                            if Rec.Amount > BUserSetup."Max. Withdrawal Limit" then begin
                                Error('You cannot withdraw more than your allowed limit of %1 unless authorised.', BUserSetup."Max. Withdrawal Limit");
                            end;
                        end;
                    end;

                    if rec.Cashier <> userid then
                        Error('You cannot post a transaction that you did not initiate! Kindly update till.');

                    if Rec.Type = Rec.Type::"Cash Deposit" then begin
                        if Rec.Status <> Rec.Status::Approved then begin
                            if Rec.Amount > BUserSetup."Max. Deposit Limit" then begin
                                Error('You cannot deposit more than your allowed limit of %1 unless authorised.', BUserSetup."Max. Deposit Limit");
                            end;
                        end;
                    end;
                    SaccoT.InitPost(Rec);

                    Commit;

                    Trans.Reset;
                    Trans.SetRange(Trans.No, Rec.No);
                    if Trans.Find('-') then begin

                        if rec.Type = rec.Type::"Cash Withdrawal" then
                            REPORT.Run(Report::"Cashier Withdrawal Slip", true, true, Trans)
                        else
                            if rec.Type = rec.Type::"Cash Deposit" then
                                REPORT.Run(Report::"Cashier Deposit Slip", true, true, Trans)
                            else
                                if rec.Type = rec.Type::"Credit Receipt" then
                                    REPORT.Run(Report::"CashierCredit Deposit Slip", true, true, Trans)
                                else
                                    if rec.Type = rec.Type::"Cheque Deposit" then
                                        REPORT.Run(Report::"Cashier CHDeposit Slip", true, true, Trans)
                                    else
                                        if rec.Type = rec.Type::"Credit Cheque" then
                                            REPORT.Run(Report::"CashierCredit Deposit Slip", true, true, Trans)
                                        else
                                            if (rec.Type = rec.Type::"Bankers Cheque") or (rec.Type = rec.Type::"Cheque Withdrawal") then
                                                REPORT.Run(Report::"Bankers Cheque Slip", true, true, Trans)

                    end;

                    CurrPage.Close;
                end;
            }
            action("Reset Transaction Date")
            {
                ApplicationArea = Basic;
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;

                trigger OnAction()
                begin

                    Trans.Reset;
                    Trans.SetRange(Trans.Posted, false);
                    Trans.SetRange(Trans.No, Rec.No);
                    if Trans.Find('-') then begin

                        Rec."Transaction Date" := Today;
                        Rec."Transaction Time" := Time;
                        Rec.Modify;

                        Message('Transaction date updated');

                    end else
                        Error('Transaction already posted');
                end;
            }
            action("Refresh")
            {
                ApplicationArea = Basic;
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;

                trigger OnAction()
                begin
                    currpage.Update;
                    Message('Page refreshed succesfully');
                end;
            }
            action("Reset Cashier")
            {
                ApplicationArea = Basic;
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;

                trigger OnAction()
                var
                    BUserSetup: record "Banking User Template";
                    bankacc: record "Bank Account";
                    Dimension: record Dimension;
                begin

                    Trans.Reset;
                    Trans.SetRange(Trans.Posted, false);
                    Trans.SetRange(Trans.No, Rec.No);
                    if Trans.Find('-') then begin

                        Rec.Cashier := userid;
                        BUserSetup.Reset;
                        BUserSetup.SetRange(BUserSetup.UserID, UserId);
                        if BUserSetup.Find('-') then begin
                            bankacc.Reset;
                            bankacc.SetRange("No.", BUserSetup."Default  Bank");
                            if bankacc.Find('-') then begin
                                Rec."Till Code" := BUserSetup."Default  Bank";
                                Rec."Till Name" := PadStr(BUserSetup."Default  Bank" + ' ' + bankacc.Name, 50);
                            end;
                        end;

                        Dimension.Reset();
                        Dimension.SetRange(Code, rec."Global Dimension 1 Code");
                        if Dimension.FindFirst() then begin
                            Rec."Branch Name" := Dimension.Name;
                        end;

                        UserSetup.Reset;
                        UserSetup.SetRange(UserSetup."User ID", UserId);
                        if UserSetup.Find('-') then begin
                            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
                            UserSetup.TestField(UserSetup."Global Dimension 2 Code");


                            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                            rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                            rec."Responsibility Center" := UserSetup."Responsibility Centre";
                        end;

                        Message('Cashier Updated');

                    end else
                        Error('Transaction already posted');
                end;
            }
            action("Reprint Slip")
            {
                ApplicationArea = Basic;
                Caption = 'Reprint Slip';
                Image = DepositSlip;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = ReprintSlip;

                trigger OnAction()
                begin
                    Rec.TestField(Posted, true);
                    Trans.Reset;
                    Trans.SetRange(Trans.No, Rec.No);
                    if Trans.Find('-') then begin
                        Trans.Dublicate := true;
                        Trans.Modify;
                        Commit;
                    end;

                    Trans.Reset;
                    Trans.SetRange(Trans.No, Rec.No);
                    if Trans.Find('-') then begin

                        if rec.Type = rec.Type::"Cash Withdrawal" then
                            REPORT.Run(Report::"Cashier Withdrawal Slip", true, true, Trans)
                        else
                            if rec.Type = rec.Type::"Cash Deposit" then
                                REPORT.Run(Report::"Cashier Deposit Slip", true, true, Trans)
                            else
                                if rec.Type = rec.Type::"Credit Receipt" then
                                    REPORT.Run(Report::"CashierCredit Deposit Slip", true, true, Trans)
                                else
                                    if rec.Type = rec.Type::"Cheque Deposit" then
                                        REPORT.Run(Report::"Cashier CHDeposit Slip", true, true, Trans)
                                    else
                                        if rec.Type = rec.Type::"Credit Cheque" then
                                            REPORT.Run(Report::"CashierCredit Deposit Slip", true, true, Trans)
                                        else
                                            if (rec.Type = rec.Type::"Bankers Cheque") or (rec.Type = rec.Type::"Cheque Withdrawal") then
                                                REPORT.Run(Report::"Bankers Cheque Slip", true, true, Trans)

                    end;
                end;
            }
            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SaccoT: Codeunit "Sacco Transactions";
                    BUserSetup: Record "Banking User Template";
                    BankAccount: Record "Bank Account";
                begin
                    if rec.Cashier <> UpperCase(UserId) then
                        Error('You cannot post another person cashier transaction!');

                    BUserSetup.Get(rec.Cashier);
                    BankAccount.Get(BUserSetup."Default  Bank");
                    BankAccount.CalcFields("Balance (LCY)");
                    if BankAccount."Balance (LCY)" > BUserSetup."Maximum Withholding" then begin
                        message('You need to Return money to treasury because you have exceeded the Max Withholding!')
                    end else
                        if BankAccount."Balance (LCY)" <= 0 then
                            Error('You need to request money from treasury first before proceeding!');

                    if Rec.Type = rec.Type::Lien then begin
                        Rec.TestField("Blockage Reason");
                        if Rec."Blockage Reason" = Rec."Blockage Reason"::Others then
                            rec.TestField("Other Reason");
                    end;

                    if (TransTypes.Type = TransTypes.Type::"Cash Deposit") OR (TransTypes.Type = TransTypes.Type::"Cash Withdrawal") then begin
                        if Rec.Amount >= 1500000 then begin
                            Rec.TestField(Source);
                            Rec.TestField(Purpose);
                        end;
                    end;

                    //if rec.Type = rec.Type::"Cash Deposit" then begin
                    if Rec.Status = Rec.Status::Open then begin
                        if rec.Amount >= 1500000 then begin
                            Error('This transaction will violate AML rules. You must send for approval first.')
                        end;
                        //end;
                    end;

                    if Rec.Type = Rec.Type::"Cash Withdrawal" then begin
                        if Members.Get(Rec."Member No.") then begin
                            if Members."Account Type" = Members."Account Type"::"Single Member Account" then begin
                                ImageData.Reset;
                                ImageData.SetRange(ImageData."Member No", Rec."Member No.");
                                if ImageData.Find('-') then begin
                                    ImageData.CalcFields(ImageData.Picture, ImageData.Signature);
                                    if not ImageData.Picture.HasValue then
                                        Error('Kindly capture the member photo before proceeding');
                                    if not ImageData.Signature.HasValue then
                                        Error('Kindly Signature sample of the member before proceeding');
                                end else
                                    Error('Kindly capture the member photo & Signature before proceeding');
                            end;
                        end;
                    end;

                    if Rec.Status = Rec.Status::"Pending Approval" then
                        Error('The transaction must be fully approved before proceeding');

                    //Mark Transaction Posted...
                    BankAccountLedgerEntry.Reset;
                    BankAccountLedgerEntry.SetRange("Document No.", Rec.No);
                    if BankAccountLedgerEntry.FindFirst then begin
                        Rec.Posted := true;
                        Rec.Modify;
                    end;

                    if Rec.Posted = false then
                        SaccoT.InitPost(Rec);

                    CurrPage.Close;
                end;
                // end;
            }
            action("Update Till")
            {
                ApplicationArea = Basic;
                Caption = 'Update Till';
                Image = UpdateShipment;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = rec.Posted = false;

                trigger OnAction()
                var
                    bankingTemp: Record "Banking User Template";
                    BankAcc: Record "Bank Account";
                    Dimension: Record "Dimension Value";
                begin
                    //Rec.TestField(Posted, true);
                    if not rec.Posted then begin
                        rec.Cashier := UpperCase(UserId);
                        rec."Transaction Date" := Today;
                        rec."Transaction Time" := Time;


                        bankingTemp.Reset;
                        bankingTemp.SetRange(bankingTemp.UserID, UserId);
                        if bankingTemp.Find('-') then begin
                            rec."Till Code" := bankingTemp."Default  Bank";
                            bankacc.Reset;
                            bankacc.SetRange("No.", bankingTemp."Default  Bank");
                            if bankacc.Find('-') then begin
                                rec."Till Name" := PadStr(bankingTemp."Default  Bank" + ' ' + bankacc.Name, 50);
                            end;
                        end;



                        Dimension.Reset();
                        Dimension.SetRange(Code, rec."Global Dimension 1 Code");
                        if Dimension.FindFirst() then begin
                            Rec."Branch Name" := Dimension.Name;
                        end;

                        UserSetup.Reset;
                        UserSetup.SetRange(UserSetup."User ID", UserId);
                        if UserSetup.Find('-') then begin
                            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
                            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
                            rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                            rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                            rec."Responsibility Center" := UserSetup."Responsibility Centre";
                        end;

                    end
                    else
                        Error('Transaction already posted');
                    Message('Till updated successfully');
                end;
            }
            action("Till Balance")
            {
                ApplicationArea = Basic;
                Image = Balance;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Page "Bank Account Card";
                RunPageLink = "No." = FIELD("Till Code");
                //Visible = false;
            }

            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }

                action("Re-Open")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category4;
                    Image = ReOpen;

                    trigger OnAction()
                    begin
                        if not Confirm('Are you sure you want to re-open this document?') then exit;
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify(true);
                        Message('DOCUEMENT REOPENED SUCCESSFULLY.');

                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category7;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                        BUserSetup: Record "Banking User Template";
                        BankAccount: Record "Bank Account";
                    begin
                        if Rec.Type <> Rec.Type::Lien then begin
                            BUserSetup.Get(rec.Cashier);
                            BankAccount.Get(BUserSetup."Default  Bank");
                            BankAccount.CalcFields("Balance (LCY)");
                            if BankAccount."Balance (LCY)" > BUserSetup."Maximum Withholding" then begin
                                //if rec.type = rec.type::"Cash Withdrawal" then
                                Message('You need to Return money to treasury because you have exceeded the Max Withholding!')
                            end else
                                if BankAccount."Balance (LCY)" <= rec.Amount then
                                    if rec.type = rec.type::"Cash Withdrawal" then
                                        Error('You need to request money from treasury first before proceeding!');

                            if Rec.Amount <= 0 then Error('Amount must be greater than zero');
                        end;

                        if (Rec."Account Type" = Rec."Account Type"::MPESA) then begin
                            Rec.testField("Mpesa Reference");
                            Rec.testfield("Reference Name");
                        end;
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        // Rec.Status := rec.Status::"Approved";
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        approvalsMgmt: Codeunit 1535;
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action("Discount Cheque")
                {
                    ApplicationArea = Basic;
                    Image = MakeAgreement;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "Cheque Discounting";
                    RunPageLink = No = FIELD(No),
                                  Type = CONST("Cheque Deposit");
                    Visible = DiscCH;
                }
                action("Stop/Cancel Cheque")
                {
                    ApplicationArea = Basic;
                    Image = VoidCheck;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        SaccoT: Codeunit "Sacco Transactions";
                    begin

                        SaccoT.StopCheque(Rec);
                    end;
                }
                action("Clear Lien")
                {
                    ApplicationArea = Basic;
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if rec.Status <> rec.Status::Approved then begin
                            Error('To clear this Lien, the entry must be approved. Send Approval first!');
                        end;
                        if Rec.Type <> Rec.Type::Lien then
                            Error('Only applicable to Lien');

                        if rec.Status <> rec.Status::Approved then
                            Error('To clear this Lien, send for approval first!');

                        if Confirm('Are you sure you want to process the selected transactions?', false) = true then begin

                            Rec."Cheque Status" := Rec."Cheque Status"::Honoured;
                            Rec."Date Cleared" := Today;
                            Rec."Cleared By" := UserId;
                            Rec.Modify;

                            Message('Lien processed successfully');

                        end;
                    end;
                }
                action("Print Bankers Cheque")
                {
                    ApplicationArea = Basic;
                    Image = PrintCheck;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Err00001: Label 'Document must be posted ';
                        CT: Record "Cashier Transactions";
                    begin
                        if Rec.Posted = true then begin

                            CT.Reset;
                            CT.SetFilter(No, Rec.No);
                            if CT.Find then
                                REPORT.Run(Report::"Bankers Cheque Slip", true, true, CT)
                        end else
                            Error(Err00001);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        RecoveryAccent;
        clear(BalBroughtForwardAmt);
        BankLedger.Reset();
        BankLedger.SetRange("Bank Account No.", Rec."Till Code");
        BankLedger.SetFilter("Posting Date", '<%1', Today);
        BankLedger.CalcSums("Amount (LCY)");
        BalBroughtForwardAmt := BankLedger."Amount (LCY)";
        if BankLedger.FindFirst() then begin
            // if BalBroughtForwardAmt <> 0 then
            //     Error('End of Day has not been performed for the previous business day.');
        end;

        if Trans.Get(Rec.No) then begin
            BankLedger.Reset;
            BankLedger.SetRange(BankLedger."Document No.", Trans.No);
            if BankLedger.Find('-') then begin
                if Trans.Posted = false then begin
                    Trans.Posted := true;
                    Trans."Date Posted" := Today;
                    Trans."Time Posted" := Time;
                    Trans."Posted By" := UserId;
                    Trans.Modify;

                    exit;
                end;
            end;
        end;
        FChequeVisible := false;
        BChequeVisible := false;
        MPESATYPEVisible := false;
        RCheque := false;
        CLien := false;
        OverMillion := false;
        BReceiptVisible := false;
        BOSAReceiptChequeVisible := false;
        AllAmount := false;
        DiscCH := false;
        NormalChequeVisible := false;


        if Rec.Type = Rec.Type::"Cheque Deposit" then begin
            FChequeVisible := true;
            DiscCH := true;
        end;

        if (TransTypes.Type = TransTypes.Type::"Cash Deposit") OR (TransTypes.Type = TransTypes.Type::"Cash Withdrawal") then begin
            if Rec.Amount >= 1000000 then
                OverMillion := true;
        end;

        if Rec.Type = Rec.Type::"Bankers Cheque" then
            BChequeVisible := true;
        if rec.Type = Rec.Type::"Cancel Bankers Cheque" then
            BChequeVisible := true;
        if rec.Type = Rec.Type::"Cheque Withdrawal" then
            NormalChequeVisible := true;

        if rec.Type = Rec.Type::Lien then
            CLien := true;

        if Rec.Type = Rec.Type::"Credit Receipt" then begin
            BReceiptVisible := true;
            AllAmount := true;
        end;

        if Rec.Type = Rec.Type::"Credit Cheque" then begin
            FChequeVisible := true;
            BOSAReceiptChequeVisible := true;
            AllAmount := true;
        end;
        if rec.Type = rec.Type::"Cheque Deposit" then
            BankBankEdit := false
        else
            BankBankEdit := true;
        if (Rec.Type = Rec.Type::"MPESA Deposit") or (Rec.Type = Rec.Type::"MPESA Withdrawal") then begin
            MPESATYPEVisible := true;
        end;

        // SetBankCodeVisibility;

        SetControlAppearance;
        UpdateControl;
    end;


    trigger OnInit()
    begin

        UpdateControl;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Temp.Get(UserId);
        Trans.Reset;
        Trans.SetRange(Trans.Cashier, UserId);
        Trans.SetRange(Status, Trans.Status::Open);
        Trans.SetRange(Trans.Posted, false);
        if Trans.FindFirst then begin
            if Trans.Count >= Temp."No of Open Transactions" then begin
                Error('There are still some pending document(s) on your account. Please list & select the pending document to use.');
            end;
        end;
    end;

    trigger OnOpenPage()
    begin
        RecoveryAccent;


        CurrPage.Update();
        if Rec.Posted = true then
            CurrPage.Editable := false;

        if Rec."Account Type" = Rec."Account Type"::MPESA then
            AccNo := false;
        if Trans.Get(Rec.No) then begin
            BankLedger.Reset;
            BankLedger.SetRange(BankLedger."Document No.", Trans.No);
            if BankLedger.Find('-') then begin
                if Trans.Posted = false then begin
                    Trans.Posted := true;
                    Trans."Date Posted" := BankLedger."Posting Date";
                    Trans."Time Posted" := Time;
                    Trans."Posted By" := BankLedger."User ID";
                    Trans.Modify;
                    exit;
                end;
            end;
        end;
        if Rec."Account Type" = Rec."Account Type"::MPESA then
            AccNo := false else
            AccNo := true;



        if Rec."Account Type" = Rec."Account Type"::MPESA then
            AccNo := false else
            AccNo := true;

        // if Rec.posted = false then begin
        //     Temp.Get(UserId);

        // Jtemplate := Temp."Cashier Journal Template";
        // Jbatch := Temp."Cashier Journal Batch";
        //     TillNo := Temp."Default  Bank";
        //     MemberNo := Temp."Member No.";
        //     Excess := Temp."Excess Account";
        //     Shortage := Temp."Shortage Account";

        // if Jtemplate = '' then begin
        //     Error(Text0001);
        // end;
        // if Jbatch = '' then begin
        //     Error(Text0002);
        // end;
        // if TillNo = '' then begin
        //     Error(Text0003);
        // end;

        // if MemberNo = '' then begin
        //     Error(Text0004);
        // end;

        // if Shortage = '' then begin
        //     Error(Text0005);
        // end;

        // if Excess = '' then begin
        //     Error(Text0006);
        // end;

        // end;
    end;

    var
        BankBankEdit: Boolean;
        FChequeVisible: Boolean;

        BChequeVisible: Boolean;
        RCheque: Boolean;

        BReceiptVisible: Boolean;

        BOSAReceiptChequeVisible: Boolean;

        Account: Record "Savings Accounts";
        UserSetup: Record "User Setup";
        DBranch: Code[20];
        DActivity: Code[20];
        Temp: Record "Banking User Template";
        Jtemplate: Code[20];
        Jbatch: Code[20];
        TillNo: Code[20];
        MemberNo: Code[20];
        Text0001: Label 'Ensure the Cashier journal Template is set up in Banking User Setup';
        Text0002: Label 'Ensure the Cashier journal Batch is set up in Banking User Setup';
        Text0003: Label 'Ensure the Default Bank is set up in Banking User Setup';
        Text0004: Label 'Ensure the Cashier Member no is set up in Banking User Setup';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        AccNo: Boolean;
        TransType: Boolean;
        Amont: Boolean;
        Remarrrks: Boolean;
        AllAmount: Boolean;
        Trans: Record "Cashier Transactions";
        Text0005: Label 'Ensure the Cashier Shortage Account is set up in Banking User Setup';
        Text0006: Label 'Ensure the Cashier Excess Account iis set up in Banking User Setup';
        Excess: Code[20];
        Shortage: Code[20];
        Currr: Boolean;
        ImageData: Record "Image Data";
        DiscCH: Boolean;
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        BankLedger: Record "Bank Account Ledger Entry";
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        FieldEdit: Boolean;
        ShowMandatory: Boolean;
        CLien: Boolean;
        OverMillion: Boolean;
        TransTypes: Record "Transaction Types";
        StyleExprTxt: Text;
        LoaneeInfomationBase: Record "Loanee Infomation Base";
        i: Integer;
        LoanrecoveryHeader: Record "Loan Recovery Header";
        LoanrecoveryHeaderII: Record "Loan Recovery Header II";
        NumberOfLoans: Integer;
        LoanNumbers: Code[200];
        ReprintSlip: Boolean;
        MPESATYPEVisible: Boolean;
        BankCodeVisible: Boolean;

        NormalChequeVisible: Boolean;
        BalBroughtForwardAmt: Decimal;

    // TransLien: Boolean;

    local procedure SetControlAppearance()
    var
    // ApprovalsMgmt: Codeunit 1535;
    begin

        //OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        //OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    //[Scope('OnPrem')]
    procedure UpdateControl()
    begin
        // if rec."Blockage Reason" = rec."Blockage Reason"::Others then begin
        //     ShowMandatory := true;
        // end else
        //     ShowMandatory := false;


        if Rec.Status = Rec.Status::Open then begin
            AccNo := true;
            TransType := true;
            Remarrrks := true;
            Amont := true;
            Currr := true;
        end;

        if Rec.Posted = true then begin
            ReprintSlip := true
        end else
            if Rec.Posted = false then begin
                ReprintSlip := false
            end;


        if Rec.Status = Rec.Status::"Pending Approval" then begin
            AccNo := false;
            TransType := false;
            Remarrrks := false;
            Amont := false;
            Currr := false;
        end;


        if Rec.Status = Rec.Status::Rejected then begin
            AccNo := false;
            TransType := false;
            Remarrrks := false;
            Amont := false;
            Currr := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            AccNo := false;
            TransType := false;
            Remarrrks := false;
            Amont := false;
            Currr := false;

        end;
        if rec.Type = rec.Type::"Cheque Deposit" then
            BankBankEdit := false
        else
            BankBankEdit := true;
    end;

    procedure CheckMemberInfomation()
    begin
        LoaneeInfomationBase.Reset();
        LoaneeInfomationBase.SetRange("Member No.", Rec."Member No.");
        LoaneeInfomationBase.SetFilter(Info, '<>%1', '');
        if LoaneeInfomationBase.Find('-') then begin
            repeat
                if (LoaneeInfomationBase."Expiry Date" = 0D) or (LoaneeInfomationBase."Expiry Date" > Today) then
                    Message(LoaneeInfomationBase.Info);
            until LoaneeInfomationBase.Next = 0;
        end;

        //Notify Cashier about default
        i := 0;
        LoanrecoveryHeader.Reset();
        LoanrecoveryHeader.SetRange("Member No.", Rec."Member No.");
        LoanrecoveryHeader.SetRange(Action, LoanrecoveryHeader.Action::Recovered);
        LoanrecoveryHeader.SetRange("Header Reversed", false);
        if LoanrecoveryHeader.Find('-') then begin
            NumberOfLoans := LoanrecoveryHeader.Count;
            repeat
                i += 1;
                if i = NumberOfLoans then
                    LoanNumbers += LoanrecoveryHeader."Loan No." + '.  '
                else
                    LoanNumbers += LoanrecoveryHeader."Loan No." + ', ';
            until LoanrecoveryHeader.Next() = 0;
        end;

        i := 0;
        NumberOfLoans := 0;
        LoanrecoveryHeaderII.Reset();
        LoanrecoveryHeaderII.SetRange("Member No.", Rec."Member No.");
        LoanrecoveryHeaderII.SetRange(Action, LoanrecoveryHeaderII.Action::Recovered);
        LoanrecoveryHeaderII.SetRange("Header Reversed", false);
        if LoanrecoveryHeaderII.Find('-') then begin
            NumberOfLoans := LoanrecoveryHeaderII.Count;
            repeat
                i += 1;
                if i = NumberOfLoans then
                    LoanNumbers += LoanrecoveryHeaderII."Loan No." + '.'
                else
                    LoanNumbers += LoanrecoveryHeaderII."Loan No." + ', ';
            until LoanrecoveryHeaderII.Next() = 0;
        end;

        if LoanNumbers <> '' then begin
            Message('This member is a defaulter Loan Number(s): %1', LoanNumbers);
        end;
    end;

    procedure RecoveryAccent()
    var
        myInt: Integer;
        TransType: Record "Transaction Types";
    begin
        StyleExprTxt := '';
        if TransType.Get(Rec."Transaction Type") then begin
            if (TransType.Type = TransType.Type::"Cash Deposit") or (TransType.Type = TransType.Type::"Cheque Deposit") or
            (TransType.Type = TransType.Type::"Credit Receipt") or (TransType.Type = TransType.Type::"Cancel Bankers Cheque") then
                StyleExprTxt := 'Favorable'
            else
                StyleExprTxt := 'Unfavorable';
        end;

    end;
    // procedure SetBankCodeVisibility()
    // var
    //     ChequeTypes: Record "Cheque Types";
    // begin
    //     BankCodeVisible := ChequeTypes.Get(Rec."Cheque Type") and (ChequeTypes.Type = ChequeTypes.Type::Local);
    // end;
}

