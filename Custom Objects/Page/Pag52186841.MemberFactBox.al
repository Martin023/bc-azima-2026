

page 52186841 "Member FactBox"
{
    ApplicationArea = All;
    Caption = 'Member FactBox';
    PageType = CardPart;
    SourceTable = "Member FactBox";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Editable = false;


    layout
    {
        area(content)
        {
            group(General)
            {
                Visible = not HideAccount;
                Caption = 'Loans';

                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                    Visible = false;

                }
                field("FOSA Loans"; Rec."FOSA Loans")
                {
                    Caption = 'FOSA Loans Issued';
                    ToolTip = 'Specifies the value of the FOSA Loans Issued field.';
                    visible = not HideAccount;

                }
                field("FOSA Loan Balance"; LoansProcess.GetTotalMemberLoanBalancePerUnit(Rec."Member No.", 1, Today))
                {
                    ToolTip = 'Specifies the value of the FOSA Loan Balance field.';
                    visible = not HideAccount;

                }
                field("FOSA Loan Arrears"; LoansProcess.CalculateMemberArrearsPerSourceUnit(Rec."Member No.", Today, 1))
                {
                    ToolTip = 'Specifies the value of the FOSA Loan Arrears field.';
                    visible = not HideAccount;
                    StyleExpr = 'Unfavorable';
                }
                field("BOSA Loans"; Rec."BOSA Loans")
                {
                    Caption = 'BOSA Loans Issued';
                    ToolTip = 'Specifies the value of the BOSA Loans Issued field.';
                    visible = not HideAccount;


                }
                field("BOSA Loan Balance"; LoansProcess.GetTotalMemberLoanBalancePerUnit(Rec."Member No.", 2, Today))
                {
                    ToolTip = 'Specifies the value of the BOSA Loan Balance field.';
                    visible = not HideAccount;

                }
                field("BOSA Loan Arrears"; LoansProcess.CalculateMemberArrearsPerSourceUnit(Rec."Member No.", Today, 2))
                {
                    ToolTip = 'Specifies the value of the BOSA Loan Arrears field.';
                    visible = not HideAccount;
                    StyleExpr = 'Unfavorable';

                }
                // field("BUSINESS Loans"; Rec."BUSINESS Loans")
                // {
                //     Caption = 'BUSINESS Loans Issued';
                //     ToolTip = 'Specifies the value of the BUSINESS Loans Issued field.';
                //     visible = not HideAccount;

                // }
                // field("BUSINESS Loan Balance"; LoansProcess.GetTotalMemberLoanBalancePerUnit(Rec."Member No.", 3, Today))
                // {
                //     ToolTip = 'Specifies the value of the BUSINESS Loan Balance field.';
                //     visible = not HideAccount;

                // }
                // field("BUSINESS Loan Arrears"; LoansProcess.CalculateMemberArrearsPerSourceUnit(Rec."Member No.", Today, 3))
                // {
                //     ToolTip = 'Specifies the value of the BUSINESS Loan Arrears field.';
                //     visible = not HideAccount;
                //     StyleExpr = 'Unfavorable';

                // }
                // field("HR Loans"; Rec."HR Loans")
                // {
                //     Caption = 'HR Loans Issued';
                //     ToolTip = 'Specifies the value of the HR Loans Issued field.';
                //     visible = not HideAccount;

                // }
                // field("HR Loan Balance"; LoansProcess.GetTotalMemberLoanBalancePerUnit(Rec."Member No.", 4, Today))
                // {
                //     ToolTip = 'Specifies the value of the HR Loan Balance field.';
                //     visible = not HideAccount;

                // }
                // field("HR Loan Arrears"; LoansProcess.CalculateMemberArrearsPerSourceUnit(Rec."Member No.", Today, 4))
                // {
                //     ToolTip = 'Specifies the value of the HR Loan Arrears field.';
                //     visible = not HideAccount;
                //     StyleExpr = 'Unfavorable';

                // }
                field("Total Loan Balance"; LoansProcess.GetTotalMemberLoanBalance(Rec."Member No.", Today))
                {
                    ToolTip = 'Specifies the value of the Total Loan Balance field.';
                    visible = not HideAccount;
                    //StyleExpr = 'Unfavorable';


                }
            }
            group(Savings)
            {
                Visible = not HideAccount;
                field("BOSA Deposit"; Rec."BOSA Deposit")
                {
                    ToolTip = 'Specifies the value of the BOSA Deposit field.';
                    visible = not HideAccount;

                }
                field("FOSA Savings"; Rec."FOSA Savings")
                {
                    ToolTip = 'Specifies the value of the FOSA Savings.';
                    visible = not HideAccount;

                }


                // field("BOSA Deposit Arrears"; RegnProcess.CalculateSavingArrears(Rec."Member No.", '1', PeriodRange, Today))
                // {
                //     ToolTip = 'Specifies the value of the bosa deposit arrears field.';
                // }

                field("Share Capital"; Rec."Share Capital")
                {
                    ToolTip = 'Specifies the value of the Share Capital field.';
                    visible = not HideAccount;
                }
                // field("Transferred Share Capital"; rec."Transferred Share Capital")
                // {
                //     ToolTip = 'Specifies the value of the Transferred Share Capital field.';
                //     Visible = not HideAccount;
                // }
                // field(BBF; Rec.BBF)
                // {
                //     ToolTip = 'Specifies the value of the BBF field.';
                //     visible = not HideAccount;

                // }
                // field("BBF Arrears"; RegnProcess.CalculateSavingArrears(Rec."Member No.", '4', PeriodRange, Today))
                // {
                //     ToolTip = 'Specifies the value of the BBF arrears field.';
                //     visible = not HideAccount;
                //     StyleExpr = 'Unfavorable';
                // }
                // field(Risk; Rec.Risk)
                // {
                //     ToolTip = 'Specifies the value of the Risk field.';
                //     visible = not HideAccount;
                // }
                // field("RIsk Arrears"; RegnProcess.CalculateSavingArrears(Rec."Member No.", '5', PeriodRange, Today))
                // {
                //     ToolTip = 'Specifies the value of the BBF arrears field.';
                //     visible = not HideAccount;
                //     StyleExpr = 'Unfavorable';

                // }
            }
            group(Net)
            {
                Visible = not HideAccount;
                field("Net Difference"; (Rec."BOSA Deposit" + Rec."FOSA Savings") - LoansProcess.GetTotalMemberLoanBalance(Rec."Member No.", Today))
                {
                    ToolTip = 'Specifies the value of the Net Difference field.';
                    visible = not HideAccount;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get(Rec."Member No.") then begin
            Rec.Init();
            Rec."Member No." := Rec."Member No.";
            Rec.Insert();
        end;
        MonthDiff := DATE2DMY(Today, 2) - DATE2DMY((CalcDate('-CY', Today)), 2);
        if MonthDiff <= 0 then MonthDiff := 1;
        Evaluate(PeriodRange, ('<' + Format(MonthDiff) + 'M>'));

        HideAccount := GlobalFunctions.HideAccount(Rec."Member No.");
    end;


    var
        LoansProcess: Codeunit "Loans Process";
        RegnProcess: Codeunit "Registration Process";
        PeriodRange: DateFormula;
        MonthDiff: Integer;
        GlobalFunctions: Codeunit "Global Functions";
        HideAccount: Boolean;
}
