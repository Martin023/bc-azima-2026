page 52186480 "Unposted Loans Statistics"
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
                        case
                            Rec."Source Unit" of
                            Rec."Source Unit"::BOSA:
                                Page.Run(Page::"Loan Application Card_BOSA", Rec);

                            Rec."Source Unit"::FOSA:
                                Page.Run(Page::"Loan Application Card_FOSA", Rec);

                            REc."Source Unit"::"BUSINESS LOANS":
                                Page.Run(Page::"Loan Application Card_BL", Rec);

                            Rec."Source Unit"::"HR LOANS":
                                Page.Run(Page::"Loan Application Card_HR", Rec);
                        End;
                    end;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }

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
                field("Source Unit"; Rec."Source Unit")
                {

                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }

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

                field("Loan Rejection Reason"; Rec."Loan Rejection Reason")
                {

                }
                field("Loan Defferal Reason"; Rec."Loan Defferal Reason")
                {

                }
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
    begin
        FutureInterest := 0;
        FuturePrincipal := 0;
        Loan.Reset();
        Loan.SetRange("Loan No.", Rec."Loan No.");
        Loan.SetFilter("Date Filter", '>=%1', Today);
        if Loan.Find('-') then begin
            Loan.CalcFields("Outstanding Balance", "Scheduled Interest", "Scheduled Principal");
            if Loan."Loan Recovery No." <> '' then begin
                FutureInterest := Loan."Scheduled Interest";
                FuturePrincipal := Loan."Scheduled Principal";
            end else begin
                if Loan."Outstanding Balance" > 0 then begin
                    FutureInterest := Loan."Scheduled Interest";
                    FuturePrincipal := Loan."Scheduled Principal";
                end;
            end;

        end;
        "TotalFuturePrincipal&Interest" := FuturePrincipal + FutureInterest;


        Rec.CalcFields("Days In Arrears");
        AmountInArrears := (Rec."Days In Arrears" / 30) * Rec.Repayment;
        OutstandingRepayment := GlobalFunctions.GetRemainingInstallments(Rec, Today);
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

