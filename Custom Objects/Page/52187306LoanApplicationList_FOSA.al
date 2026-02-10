page 52187306 "Loan Application List_FOSA"
{
    CardPageID = "Loan Application Card_FOSA";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = Loans;
    SourceTableView = WHERE(Posted = CONST(false), "Source Unit" = const(FOSA),
                            "Dummy Appraisal" = FILTER(false),
                            "Picked Mobile Loan" = FILTER(false),
                            "Sent Online" = FILTER(false),
                            Status = FILTER(<> Approved & <> Pending & <> Rejected));

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
                field("CRM Application No."; Rec."Loan No.")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Caption = 'CRM Application No.';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
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
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
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
                field("Source Unit"; Rec."Source Unit")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Source Unit';
                    Editable = false;
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
                field("Sent Back to CRM"; Rec."Sent Back to CRM")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxt;
                }
                field("Sent Back to M-Smart"; Rec."Sent Back to M-Smart")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxt;
                }
                field("Document Excalated"; Rec."Document Excalated")
                {
                    ApplicationArea = all;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        RecoveryAccent();
        if (Rec.Status = Rec.Status::Open) and (Rec."Application Date" <> 0D) then begin

            if CalcDate('60D', Rec."Application Date") >= Today then
                Rec.Status := Rec.Status::Rejected;
            Rec.Modify;
        end;
        Rec.FilterGroup(2);
        Rec.SetFilter("Application Date", '%1..%2', CalcDate('-3M', Today), Today);
        Rec.FilterGroup(0);
        Rec.SetCurrentKey(Rec."Disbursement Priority", "Loan No.");
        Rec.SetAscending("Disbursement Priority", true);
    end;

    trigger OnAfterGetRecord()
    begin
        RecoveryAccent();
    end;

    procedure RecoveryAccent()
    var
        myInt: Integer;
    begin
        StyleExprTxt := '';
        if Pfac.Get(Rec."Loan Product Type") then begin
            if Pfac."Disbursement Priority" = 1 then
                StyleExprTxt := 'Unfavorable'
            else
                if Pfac."Disbursement Priority" = 2 then
                    StyleExprTxt := 'Ambiguous' else

                    if Pfac."Disbursement Priority" = 3 then
                        StyleExprTxt := 'StandardAccent' else
                        StyleExprTxt := '';




        end;

    end;

    var
        LoansR: Record Loans;
        StyleExprTxt: Text[20];
        Pfac: Record "Product Factory";

}

