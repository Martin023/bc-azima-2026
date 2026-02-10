page 52185752 "Loans List"
{
    CardPageID = "Loans card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = Loans;
    ApplicationArea = Basic, Suite;
    UsageCategory = lists;

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
                //field("CRM Application No."; Rec."CRM Application No.")
                // {
                //     ApplicationArea = all;
                //     Caption = 'CRM NO.';
                //     StyleExpr = StyleExprTxt;
                // }
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
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Account"; Rec."Loan Account")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }

                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }

                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }

                // field("Loan Rescheduled"; Rec."Loan Rescheduled")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Rescheduled';
                //     StyleExpr = StyleExprTxt;
                // }
                field("Total TopUp"; Rec."Total TopUp")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxt;
                }
                field("Days In Arrears"; Rec."Days In Arrears")
                {
                    Editable = false;
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxt;
                }
                field("Installments In Arrears"; rec."Installments In Arrears")
                {
                    Editable = false;
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxt;
                }
                field("Amount In Arreas SACCO"; Rec."Amount In Arreas SACCO")
                {
                    ApplicationArea = all;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }
                field("Amount In Arreas SASRA"; Rec."Amount In Arreas SASRA")
                {
                    ApplicationArea = all;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }
                field("Installments FallOff"; Rec."Installments FallOff")
                {
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }
                field("Loans Category-SASRA"; Rec."Loans Category-SASRA")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }
                field("Actively Attached"; Rec."Actively Attached")
                {
                    StyleExpr = StyleExprTxt;

                }
                field("Actively Attached II"; Rec."Actively Attached II")
                {
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }
                field("Recovery Mode"; Rec."Recovery Mode")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                // field("Employer Loan No."; Rec."Employer Loan No.")
                // {
                //     ApplicationArea = Basic, Suite;
                //     StyleExpr = StyleExprTxt;
                // }
                // field("Employer Code"; Rec."Employer Code")
                // {
                //     StyleExpr = StyleExprTxt;

                // }
                field("Application Date"; Rec."Application Date")
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
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }

                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                // field("New Interest Rate"; Rec."New Interest Rate")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("New No. of Installment"; Rec."New No. of Installment")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Loan Rescheduled"; Rec."Loan Rescheduled")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Disbursement Date"; Rec."Disbursement Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }

                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Last Repayment Date"; Rec."Last Repayment Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }

                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }

                field("CRB Rating"; Rec."CRB Rating")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                // field("Prorata Amount"; Rec."Prorata Amount")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     StyleExpr = StyleExprTxt;
                // }
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
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }

                // field("CRM Captured by"; Rec."CRM Captured by")
                // {
                //     ApplicationArea = Basic, Suite;
                //     StyleExpr = StyleExprTxt;
                // }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Appraised By"; Rec."Loan Appraised By")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxt;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxt;
                }
                // field("Current User"; Rec."Current User")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Current User';
                //     StyleExpr = StyleExprTxt;
                // }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxt;

                }
                field("Moratorium Loan"; Rec."Moratorium Loan")
                {
                    ApplicationArea = all;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }
                field("Member Status"; Rec."Member Status")
                {
                    StyleExpr = StyleExprTxt;

                }
                field("Sub Status"; Rec."Sub Status")
                {
                    Caption = 'Member Sub Status';
                    StyleExpr = StyleExprTxt;
                }
                field("Relation Officer"; Rec."Relation Officer")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxt;
                }
                field("Main Sector"; Rec."Main Sector") { }
                field("Main Sector Description"; Rec."Main Sector Description") { }
                field("Sub Sector Level1"; Rec."Sub Sector Level1") { }
                field("Sub Sector Level1 Description"; Rec."Sub Sector Level1 Description") { }
                field("Sub Sector Level2"; Rec."Sub Sector Level2") { }
                field("Sub Sector Level2 Description"; Rec."Sub Sector Level2 Description") { }


            }
        }
        area(factboxes)
        {
            systempart(Control11; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control12; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control13; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin


    end;

    trigger OnAfterGetRecord()
    begin
        StyleExprTxt := '';
        If Rec."Loans Category-SASRA" = Rec."Loans Category-SASRA"::Loss then
            StyleExprTxt := 'Unfavorable'
        else
            if Rec."Loans Category-SASRA" = Rec."Loans Category-SASRA"::Doubtful then
                StyleExprTxt := 'Attention' else
                if Rec."Loans Category-SASRA" = Rec."Loans Category-SASRA"::Substandard then
                    StyleExprTxt := 'Ambiguous' else
                    if Rec."Loans Category-SASRA" = Rec."Loans Category-SASRA"::Watch then
                        StyleExprTxt := 'StandardAccent' else
                        StyleExprTxt := '';
    end;

    var
        StyleExprTxt: Text;
        LoanProduct: record "Product Factory";
}

