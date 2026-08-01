page 52185768 "Loan Posted List"
{
    CardPageID = "Loans Posted";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Loans;
    SourceTableView =
    WHERE(Posted = CONST(true));
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
                field(Gender; Rec."Member Gender")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                // field("Loan Account"; Rec."Loan Account")
                // {
                //     ApplicationArea = Basic, Suite;
                //     StyleExpr = StyleExprTxt;
                // }
                field("Staff No"; Rec."Staff No")
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
                // field("Amount In Arreas SACCO"; Rec."Amount In Arreas SACCO")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     StyleExpr = StyleExprTxt;
                // }
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
                // field("Actively Attached II"; Rec."Actively Attached II")
                // {
                //     Editable = false;
                //     StyleExpr = StyleExprTxt;
                // }
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

                // field("CRB Rating"; Rec."CRB Rating")
                // {
                //     ApplicationArea = Basic, Suite;
                //     StyleExpr = StyleExprTxt;
                // }
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
                // field("Responsible Officer"; Rec."Responsible Officer")
                // {
                //     ApplicationArea = all;
                //     StyleExpr = StyleExprTxt;

                // }
                // field("Moratorium Loan"; Rec."Moratorium Loan")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     StyleExpr = StyleExprTxt;
                // }
                field("Member Status"; Rec."Member Status")
                {
                    StyleExpr = StyleExprTxt;

                }
                field("Sub Status"; Rec."Sub Status")
                {
                    Caption = 'Member Sub Status';
                    StyleExpr = StyleExprTxt;
                }
                field("BOSA Deposits"; Rec."BOSA Deposits")
                {
                    Caption = 'BOSA Deposits';
                    StyleExpr = StyleExprTxt;
                }
                // field("Relation Officer"; Rec."Relation Officer")
                // {
                //     ApplicationArea = all;
                //     StyleExpr = StyleExprTxt;
                // }
                field("Main Sector"; Rec."Main Sector") { }
                field("Main Sector Description"; Rec."Main Sector Description") { }
                field("Sub Sector Level1"; Rec."Sub Sector Level1") { }
                field("Sub Sector Level1 Description"; Rec."Sub Sector Level1 Description") { }
                field("Sub Sector Level2"; Rec."Sub Sector Level2") { }
                field("Sub Sector Level2 Description"; Rec."Sub Sector Level2 Description") { }


            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Update Loan Data")
            {
                ApplicationArea = Basic, Suite;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    Loans: Record Loans;
                    Members: Record Members;
                    ProductFactory: Record "Product Factory";
                    intProgressTotal: Integer;
                    intProgressI: Integer;
                    TimeProgress: TIME;
                    NoOfRecsProgress: Decimal;
                    NoOfProgressed: Integer;
                    Generating: Label 'Updating Loans Data';
                    diaProgress: Dialog;
                    intProgress: Integer;
                begin
                    Loans.Reset();
                    if Loans.Find('-') then begin
                        intProgressTotal := Loans.COUNT;

                        intProgressI := 0;
                        TimeProgress := TIME;
                        NoOfRecsProgress := intProgressTotal DIV 100;
                        NoOfProgressed := 0;

                        diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
                        repeat
                            if Loans."Employer Code" = '' then begin
                                if Members.Get(Loans."Member No.") then begin
                                    Loans."Employer Code" := Members."Employer Code";
                                end;
                            end;
                            if Loans."Application Date" = 0D then
                                Loans."Application Date" := Loans."Disbursement Date";

                            if Loans."Loan Product Type" <> '' then
                                ProductFactory.Reset();
                            ProductFactory.SetRange("Product ID", Loans."Loan Product Type");
                            if ProductFactory.FindFirst() then begin
                                Loans."Source Unit" := ProductFactory."Source Unit";
                                Loans."Interest Calculation Method" := ProductFactory."Interest Calculation Method";
                                Loans."Recovery Mode" := ProductFactory."Repay Mode";
                                if Loans.Interest = 0 then
                                    Loans.Interest := ProductFactory."Interest Rate (Max.)";
                            end;

                            Loans.Modify();

                            intProgressI += 1;

                            IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                                NoOfProgressed := NoOfProgressed + intProgressI;
                                diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                                intProgressI := 0;
                                TimeProgress := TIME;
                            END;
                        until Loans.Next() = 0;
                    end;
                    diaProgress.CLOSE;
                end;
            }

            /*action("Update Installments")
            {
                ApplicationArea = Basic, Suite;
                Image = Installments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    Loans: Record Loans;
                    Members: Record Members;
                    ProductFactory: Record "Product Factory";
                    intProgressTotal: Integer;
                    intProgressI: Integer;
                    TimeProgress: TIME;
                    NoOfRecsProgress: Decimal;
                    NoOfProgressed: Integer;
                    Generating: Label 'Updating Loans Data';
                    diaProgress: Dialog;
                    intProgress: Integer;
                begin
                    Loans.Reset();
                    if Loans.Find('-') then begin
                        intProgressTotal := Loans.COUNT;

                        intProgressI := 0;
                        TimeProgress := TIME;
                        NoOfRecsProgress := intProgressTotal DIV 100;
                        NoOfProgressed := 0;

                        diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
                        repeat
                            if ProductFactory.Get(Loans."Loan Product Type") then begin
                                if Loans.Installments > ProductFactory."Ordinary Default Intallments" then begin
                                    Loans.Installments := ProductFactory."Ordinary Default Intallments";
                                    Loans.Modify();
                                end;
                            end;

                            intProgressI += 1;

                            IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                                NoOfProgressed := NoOfProgressed + intProgressI;
                                diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                                intProgressI := 0;
                                TimeProgress := TIME;
                            END;
                        until Loans.Next() = 0;
                    end;
                    diaProgress.CLOSE;
                end;
            }*/


            action("Clear FOSA Schedules")
            {
                ApplicationArea = Basic, Suite;
                Image = ClearLog;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    Loans: Record Loans;
                    Schedules: Record "Ideal Repayment Schedule";


                    intProgressTotal: Integer;
                    intProgressI: Integer;
                    TimeProgress: TIME;
                    NoOfRecsProgress: Decimal;
                    NoOfProgressed: Integer;
                    Generating: Label 'Updating Loans Data';
                    diaProgress: Dialog;
                    intProgress: Integer;
                begin
                    Loans.Reset();
                    Loans.SetRange("Source Unit", Loans."Source Unit"::FOSA);
                    if Loans.Find('-') then begin
                        intProgressTotal := Loans.COUNT;

                        intProgressI := 0;
                        TimeProgress := TIME;
                        NoOfRecsProgress := intProgressTotal DIV 100;
                        NoOfProgressed := 0;

                        diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
                        repeat
                            Schedules.Reset();
                            Schedules.SetRange("Loan No.", Loans."Loan No.");
                            if Schedules.Find('-') then
                                Schedules.DeleteAll();

                            intProgressI += 1;

                            IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                                NoOfProgressed := NoOfProgressed + intProgressI;
                                diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                                intProgressI := 0;
                                TimeProgress := TIME;
                            END;
                        until Loans.Next() = 0;
                    end;
                    diaProgress.CLOSE;
                end;
            }


            action("Ideal Loan  Schedule")
            {
                ApplicationArea = Basic, Suite;
                Image = ViewWorksheet;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                trigger OnAction()
                var
                    LoanApp: Record Loans;
                    LoanProcess: Codeunit "Loans Process";
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    if LoanApp.Find('-') then
                        REPORT.Run(Report::"Ideal Repayment Schedule", true, true, LoanApp);
                end;
            }

            action("Actual Loan Schedule")
            {
                ApplicationArea = Basic, Suite;
                Image = ViewWorksheet;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    LoanApp: Record Loans;
                    LoanProcess: Codeunit "Loans Process";
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    if LoanApp.Find('-') then
                        REPORT.Run(Report::"Actual Repayment Schedule", true, true, LoanApp);
                end;
            }
            action("Remaining Installments")
            {
                ApplicationArea = Basic, Suite;
                Image = Reminder;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    GlobalFunctions: Codeunit "Global Functions";
                begin
                    Message(Format(GlobalFunctions.GetRemainingInstallments(Rec, Today)));
                end;
            }
            action("Create Loan Accounts")
            {
                ApplicationArea = Basic, Suite;
                Image = ViewWorksheet;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    LoanApp: Record Loans;
                    LoanProcess: Codeunit "Loans Process";
                    intProgressTotal: Integer;
                    intProgressI: Integer;
                    TimeProgress: TIME;
                    NoOfRecsProgress: Decimal;
                    NoOfProgressed: Integer;
                    Generating: Label 'Processing ...';
                    diaProgress: Dialog;
                    intProgress: Integer;
                begin

                    LoanApp.Reset();
                    if LoanApp.Find('-') then begin
                        intProgressTotal := LoanApp.COUNT;

                        intProgressI := 0;
                        TimeProgress := TIME;
                        NoOfRecsProgress := intProgressTotal DIV 100;
                        NoOfProgressed := 0;

                        diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
                        repeat
                            LoanApp."Loan Account" := LoanProcess.CreateLoanAccount(LoanApp."Member No.", LoanApp."Loan Product Type");
                            LoanApp.Modify();

                            intProgressI += 1;

                            IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                                NoOfProgressed := NoOfProgressed + intProgressI;
                                diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                                intProgressI := 0;
                                TimeProgress := TIME;
                            END;
                        until LoanApp.Next() = 0;
                        diaProgress.Close();
                    end;
                end;
            }

            action("SASRA Categorization")
            {
                ApplicationArea = Basic, Suite;
                Image = Default;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()

                begin
                    REPORT.Run(Report::"SASRA Loan Categorization", true, true);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        RecoveryAccent;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        RecoveryAccent;
    end;

    procedure RecoveryAccent()
    var
        myInt: Integer;
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
        LoansR: Record Loans;
        StyleExprTxt: Text[20];
        Pfac: Record "Product Factory";
}

