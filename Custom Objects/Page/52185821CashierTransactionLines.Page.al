page 52185821 "Cashier Transaction Lines"
{
    PageType = List;
    SourceTable = "Cashier Transaction Lines";
    ApplicationArea = Basic, Suite;
    //UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Oustanding Principal"; Rec."Loan Oustanding Principal")
                {

                }
                field("Loan Outstanding Interest"; Rec."Loan Outstanding Interest")
                {

                }
                // field("Daily Interest"; Rec."Daily Interest")
                // {

                // }
                field("Total Outstanding Loan"; Rec."Total Outstanding Loan")
                {

                }
                field("Member No"; Rec."Member No")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction No"; Rec."Transaction No")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Control24)
            {
                ShowCaption = false;
                fixed("Account Details")
                {
                    group("Account Details.")
                    {
                        Caption = 'Account Details.';
                        field("Account No."; Rec."Account No")
                        {
                            Editable = false;
                            ApplicationArea = Basic, Suite;
                        }
                    }
                    group(Membership)
                    {
                        Caption = 'Membership';
                        field("Member Nos"; Rec."Member No")
                        {
                            Caption = 'Member Nos';
                            Editable = false;
                            ApplicationArea = Basic, Suite;
                        }
                    }
                    group(Amounts)
                    {
                        Caption = 'Amounts';
                        field(Balance; Rec.Amount)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            Caption = 'Balance';
                            Editable = false;
                            Visible = true;
                        }
                    }
                    group(Balances)
                    {
                        Caption = 'Total Amount';
                        field(TotalBalance; Rec.Amount + TotalAmount - xRec.Amount)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            Caption = 'Total Balance';
                            Editable = false;
                            Visible = true;
                        }
                    }
                    group(Differences)
                    {
                        Caption = 'Unallocated Amount';
                        field(UnAllocatedAmount; UnAllocatedAmount)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            Caption = 'Unallocated Amount';
                            Editable = false;
                            Visible = true;
                            Style = Unfavorable;
                            StyleExpr = UnAllocatedAmount <> 0;
                        }

                    }
                }
            }
        }
        area(factboxes)
        {
            part("Approved Images"; "Member Picture & Signature")
            {
                Caption = 'Approved Images';
                SubPageLink = "Member No" = FIELD("Member No");
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Suggest Monthly Repayments")
            {
                ApplicationArea = Basic, Suite;
                Image = SuggestLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    Ctrans.Reset;
                    Ctrans.SetRange(Ctrans.No, Rec."Transaction No");
                    if Ctrans.Find('-') then begin
                        CtransLines.Reset();
                        CtransLines.setrange("Transaction No",Ctrans.No);
                        if CtransLines.FindSet then
                            CtransLines.DeleteAll();

                        Loans.Reset;
                        Loans.SetRange(Loans."Member No.", Ctrans."Member No.");
                        if Loans.Find('-') then begin
                            repeat

                                Loans.CalcFields(Loans."Total Balance", Loans."Outstanding Interest","Outstanding Balance");

                                if (Loans."Outstanding Balance") > 0 then begin

                                    CtransLines.Init;
                                    CtransLines."Member No" := Ctrans."Member No.";
                                    CtransLines."Transaction No" := Ctrans.No;
                                    CtransLines."Account No" := Loans."Loan Account";
                                    CtransLines."Transaction Type" := CtransLines."Transaction Type"::Repayment;
                                    CtransLines."Loan No" := Loans."Loan No.";
                                    CtransLines.Amount := Loans.Repayment;//"Outstanding Bills";
                                    CtransLines.Type := CtransLines.Type::Credit;
                                    CtransLines.Insert;
                                end;

                                if (Loans."Outstanding Interest") > 0 then begin
                                    CtransLines.Init;
                                    CtransLines."Member No" := Ctrans."Member No.";
                                    CtransLines."Transaction No" := Ctrans.No;
                                    CtransLines."Account No" := Loans."Loan Account";
                                    CtransLines."Transaction Type" := CtransLines."Transaction Type"::"Interest Paid";
                                    CtransLines."Loan No" := Loans."Loan No.";
                                    CtransLines.Amount := Loans."Outstanding Interest";
                                    CtransLines.Type := CtransLines.Type::Credit;
                                    CtransLines.Insert;

                                end;

                            until Loans.Next = 0;
                        end;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CalcBal;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CalcBal;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CalcBal;
    end;

    trigger OnOpenPage()
    begin

        //**Prevent modification of approved entries
        Ctrans.Reset;
        Ctrans.SetRange(Ctrans.No, Rec."Transaction No");
        if Ctrans.Find('-') then begin
            if Ctrans.Posted then
                CurrPage.Editable := false
            else
                CurrPage.Editable := true;
        end;
        CalcBal;
    end;

    var
        Ctrans: Record "Cashier Transactions";
        Loans: Record Loans;
        CtransLines: Record "Cashier Transaction Lines";
        CashierTransactionLines: Record "Cashier Transaction Lines";
        TotalAmount: Decimal;
        CashTrans: Record "Cashier Transactions";
        UnAllocatedAmount : Decimal;

    //[Scope('OnPrem')]
    procedure CalcBal()
    var 
        Header : record "Cashier Transactions";
    begin
        TotalAmount := 0;
        clear(UnAllocatedAmount);
        CashierTransactionLines.Reset;
        CashierTransactionLines.SetRange("Transaction No", Rec."Transaction No");
        CashierTransactionLines.CalcSums(Amount);
        TotalAmount := CashierTransactionLines.Amount;
        if CashTrans.Get(Rec."Transaction No") then begin
            Rec."Member No" := CashTrans."Member No.";
        end;
        if not Header.Get(Rec."Transaction No") then
            exit;
        UnAllocatedAmount := Header.Amount - TotalAmount;
    end;
}

