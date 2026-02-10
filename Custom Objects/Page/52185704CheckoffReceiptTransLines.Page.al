page 52185704 "Checkoff Receipt Trans Lines"
{
    PageType = List;
    SourceTable = "Checkoff  Receipt Trans Lines";
    ApplicationArea = Basic, Suite;
    // UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        Ctrans.Reset;
                        Ctrans.SetRange(Ctrans.No, Rec."Transaction No");
                        if Ctrans.FindFirst then
                            Rec."Document No" := Ctrans."Document No";
                        //MODIFY;
                    end;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Receipt Description"; Rec."Receipt Description")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction No"; Rec."Transaction No")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
        }
    }

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
    end;

    var
        Ctrans: Record "Checkoff  Receipt Transactions";
        Loans: Record Loans;
        Loans2: Record Loans;
        CtransLines: Record "Checkoff  Receipt Trans Lines";
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
        GeneralSetUp: Record "General Set-Up";
        Totals: Decimal;
        AmountRemaining: Decimal;
        MsgAllocated: Label 'Your Have Allocated %1 \Remaining Amount is %2';
        LoanSchedule: Record "Ideal Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
}

