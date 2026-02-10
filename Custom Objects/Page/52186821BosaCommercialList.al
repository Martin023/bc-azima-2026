page 52186821 "Bosa Commercial List"
{
    CardPageID = "Bosa Commecial Loan";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = Loans;
    SourceTableView = WHERE(Posted = CONST(false), "Source Unit" = const(BOSA), "Commercial Buyoff" = const(true), "Commercial sent" = const(true));

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
                }
                field("CRM Application No."; Rec."CRM Application No.")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxt;
                    Caption = 'CRM NO.';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Member Name"; Rec."Member Name")
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
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = all;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    StyleExpr = StyleExprTxt;
                    ApplicationArea = all;

                }

                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Rejection Reason"; Rec."Loan Rejection Reason")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        Genset: Record "General Set-Up";
    begin
        RecoveryAccent();
        Genset.Get();
        if Rec."Member No." <> '' then begin
            if rec."Current User" <> '' then begin
                if CurrentDateTime - Rec.WorkTime > Genset."Release Doc Time" then begin
                    Rec."Current User" := '';
                    Rec.WorkTime := CurrentDateTime;
                    Rec.Modify(true);
                end;
            end;
        end;
        if (Rec.Status = Rec.Status::Open) and (Rec."Application Date" <> 0D) then begin

            if CalcDate('60D', Rec."Application Date") <= Today then begin
                Rec.Status := Rec.Status::Rejected;
                Rec.Modify;
            end;
        end;
        Rec.FilterGroup(2);
        Rec.SetFilter("Application Date", '%1..%2', CalcDate('-3M', Today), Today);
        Rec.FilterGroup(0);
        Rec.SetCurrentKey(Rec."Disbursement Priority", "Loan No.");
        Rec.SetAscending("Disbursement Priority", true);
    end;

    trigger OnAfterGetRecord()
    var
        Genset: Record "General Set-Up";
    begin
        Genset.Get();

        RecoveryAccent();
        if Rec."Member No." <> '' then begin
            if rec."Current User" <> '' then begin
                if CurrentDateTime - Rec.WorkTime > Genset."Release Doc Time" then begin
                    Rec."Current User" := '';
                    Rec.WorkTime := CurrentDateTime;
                    Rec.Modify(true);
                end;
            end;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
        Genset: Record "General Set-Up";
    begin
        Genset.Get();

        RecoveryAccent();
        if Rec."Member No." <> '' then begin
            if rec."Current User" <> '' then begin
                if CurrentDateTime - Rec.WorkTime > Genset."Release Doc Time" then begin
                    Rec."Current User" := '';
                    Rec.WorkTime := CurrentDateTime;
                    Rec.Modify(true);
                end;
            end;
        end;
    end;

    procedure RecoveryAccent()
    var
        myInt: page "Bank Acc. Reconciliation";
    begin
        StyleExprTxt := '';
        if Pfac.Get(Rec."Loan Product Type") then begin
            if Pfac."Recovery Priority" = 1 then
                StyleExprTxt := 'Unfavorable'
            else
                if Pfac."Recovery Priority" = 2 then
                    StyleExprTxt := 'Ambiguous' else

                    if Pfac."Recovery Priority" = 3 then
                        StyleExprTxt := 'StandardAccent' else
                        StyleExprTxt := '';




        end;

    end;

    var
        LoansR: Record Loans;
        StyleExprTxt: Text[20];
        Pfac: Record "Product Factory";

}

