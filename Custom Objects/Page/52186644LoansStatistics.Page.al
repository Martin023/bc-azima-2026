page 52186644 "Loans Statistics"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = Loans;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                    begin
                        Page.Run(Page::"Loans Posted", Rec);
                    end;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                // field("Employer Loan No."; Rec."Employer Loan No.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Member No."; Rec."Member No.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Member Name"; Rec."Member Name")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Product Name"; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }

                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }

                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Total Loan Balance"; Rec."Total Loan Balance")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Source Unit"; Rec."Source Unit")
                {

                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                // field("Loan Account"; Rec."Loan Account")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }

                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }

                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxt;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Repayment Advised"; Rec."Repayment Advised")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                }
                field("Disbursement Date"; Rec."Disbursement Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }

                field("Recovery Mode"; Rec."Recovery Mode")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Days In Arrears"; Rec."Days In Arrears")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Amount In Arreas SACCO"; Rec."Amount In Arreas SACCO")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Amount In Arreas SASRA"; Rec."Amount In Arreas SASRA")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Installments FallOff"; Rec."Installments FallOff")
                {
                    Editable = false;
                }
                field("Loans Category-SASRA"; Rec."Loans Category-SASRA")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Outstanding Repayment Period"; OutstandingRepayment)
                {
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxt;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Actively Attached"; Rec."Actively Attached")
                {

                }
                field("Actively Attached II"; Rec."Actively Attached II")
                {

                }

                field("Interest Paid"; Rec."Interest Paid")
                {
                    StyleExpr = StyleExprTxt;
                }
                field("Current Accumulated Interest"; Rec."Daily Interest")
                {
                    Caption = 'Unrealized Interest';
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }

                // field(FuturePrincipal; FuturePrincipal)
                // {
                //     Caption = 'Future Principal';
                //     ApplicationArea = Basic, Suite;
                // }
                // field(FutureInterest; FutureInterest)
                // {
                //     Caption = 'Future Interest';
                //     ApplicationArea = Basic, Suite;
                // }
                // field("TotalFuturePrincipal&Interest"; "TotalFuturePrincipal&Interest")
                // {
                //     Caption = 'Total Future Principal & Interest';
                //     ApplicationArea = Basic, Suite;
                // }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        RecoveryAccent();
        "UpdateFuturePrincipal&Interest";
    end;

    trigger OnAfterGetCurrRecord()
    begin
        RecoveryAccent();
        "UpdateFuturePrincipal&Interest";
    end;

    trigger OnOpenPage()
    begin
        RecoveryAccent();
    end;

    local procedure "UpdateFuturePrincipal&Interest"()
    var
        Loan: Record Loans;
        ActualSchedule: Codeunit ActualLoanSchedule;
    begin
        FutureInterest := ActualSchedule.GenerateFutureInterest(Rec);//

        rec.CalcFields("Outstanding Balance");

        FuturePrincipal := Rec."Outstanding Balance";

        "TotalFuturePrincipal&Interest" := Rec."Outstanding Balance" + FutureInterest;

        Rec.CalcFields("Amount In Arreas SACCO");
        AmountInArrears := Rec."Amount In Arreas SACCO";
        OutstandingRepayment := GlobalFunctions.GetRemainingInstallments(Rec, Today);//
    end;

    procedure RecoveryAccent()
    var
        myInt: page "Bank Acc. Reconciliation";
    begin
        StyleExprTxt := '';

        Rec.CalcFields("Loans Category-SASRA", "Outstanding Balance");
        if Rec."Outstanding Balance" > 0 then begin
            if Rec."Loans Category-SASRA" = Rec."Loans Category-SASRA"::Loss then
                StyleExprTxt := 'Unfavorable' else
                if Rec."Loans Category-SASRA" = Rec."Loans Category-SASRA"::Doubtful then
                    StyleExprTxt := 'Attention' else
                    if Rec."Loans Category-SASRA" = Rec."Loans Category-SASRA"::Substandard then
                        StyleExprTxt := 'Ambiguous' else
                        if Rec."Loans Category-SASRA" = Rec."Loans Category-SASRA"::Substandard then
                            StyleExprTxt := 'StandardAccent' else
                            StyleExprTxt := '';
        end;
    end;

    var
        TotaBill: Decimal;
        StyleExprTxt: Text[20];
        FuturePrincipal: Decimal;
        FutureInterest: Decimal;
        "TotalFuturePrincipal&Interest": Decimal;
        Loan: Record Loans;
        AmountInArrears: Decimal;
        OutstandingRepayment: Decimal;
        Shedule: Record "Ideal Repayment Schedule";
        GlobalFunctions: Codeunit "Global Functions";
}

