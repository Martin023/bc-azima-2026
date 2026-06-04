page 52185735 "Dividend Progression"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Listpart;
    SourceTable = "Dividend Progression";
    UsageCategory = Lists;
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // field("Header No."; Rec."Header No.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Processing Date"; Rec."Processing Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dividend Calc. Method"; Rec."Dividend Calc. Method")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; MemberName)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Shares; Rec.Shares)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Qualifying Shares"; Rec."Qualifying Shares")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Gross Dividends"; Rec."Gross Dividends")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Witholding Tax"; Rec."Witholding Tax")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Net Dividends"; Rec."Net Dividends")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Month Name"; Rec."Month Name")
                { ApplicationArea = Basic, Suite; }
                field(Forfeited; Rec.Forfeited)
                { ApplicationArea = Basic, Suite; }

            }
        }
    }

    /*
        actions
        {
            area(creation)
            {
                action("Dividend Process")
                {
                    Caption = 'Generate Dividends';
                    ApplicationArea = Basic, Suite;
                    Image = Add;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = report "Dividend Generation";
                }
                action("Queue Dividend Process")
                {
                    ApplicationArea = All, Basic, Suite;
                    Caption = 'Start Dividend Process';
                    Image = Action;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        theSavingsAccount: Record "Savings Accounts";
                    begin
                        theSavingsAccount.Reset();

                        theSavingsAccount.SetFilter("Product Type", '%1|%2', '1', '4');

                        Codeunit.Run(Codeunit::"Dividends Job Queue Manager", theSavingsAccount);
                    end;
                }
                action("Clear Progressions")
                {
                    ApplicationArea = All, Basic, Suite;
                    Caption = 'Clear Dividend Progression';
                    Image = Action;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        DividendProgression: Record "Dividend Progression";
                        DividendYear: Label 'Dividend Year';
                    begin
                        if confirm('Do you wish to clear all unposted dividend progressions?') then begin
                            DividendProgression.Reset;
                            DividendProgression.SetRange(Posted, false);
                            //DividendProgression.SetRange("Account No", "Savings Accounts"."No.");
                            DividendProgression.DeleteAll(true);
                            Message('All unposted dividend progressions have been cleared');
                        end
                        else
                            message('Clearing of dividend progressions cancelled');
                    end;
                }
                action("Check Dividend Advance Qualification")
                {
                    ApplicationArea = All, Basic, Suite;
                    Caption = 'Check Dividend Advance Qualification';
                    Image = Action;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        loansProcess: Codeunit "Loans Process";
                        QualifiedAmount: Decimal;
                        LNRec: Record Loans;
                        DivloanBal: Decimal;
                        NetAmt: Decimal;
                        MemberClosure: Record "Membership Closure";
                        DivSetup: Record "Dividend SetUp";
                        DividendProgression: Record "Dividend Progression";
                        ProdFac: record "Product Factory";
                        LoanLimit: Decimal;

                    begin
                        QualifiedAmount := 0;
                        DivloanBal := 0;
                        NetAmt := 0;
                        LoanLimit := 0;

                        Message('Member No %1', Rec."Member No");
                        if Members.Get(Rec."Member No") then begin
                            Message('Member Status %1', Members.Status);
                            Message('Member Subflag %1', Members."Subflag");
                            if Members.Subflag = Members.Subflag::Withdrawal THEN BEGIN
                                if MemberClosure.Get(Rec."Member No") then begin
                                    Message('Closure Date %1', MemberClosure."Closing Date");
                                end
                            END;

                            //Member Status
                            //Member Subflag
                            //IF withdrawn show closure date

                            LNRec.RESET;
                            LNRec.SETRANGE(LNRec."Member No.", Members."No.");
                            LNRec.SETFILTER(LNRec."Outstanding Balance", '>0');
                            LNRec.SetLoadFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
                            LNRec.SetAutoCalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest", "Amount In Arreas SASRA");
                            IF LNRec.Find('-') THEN BEGIN
                                REPEAT
                                    DivloanBal := DivloanBal + LNRec."Amount In Arreas SASRA";
                                //+ (LNRec."Outstanding Balance");// + LNRec."Outstanding Interest" + LNRec."Daily Interest");
                                UNTIL LNRec.NEXT = 0;
                            END;
                            Message('Loan Arrears %1', DivloanBal);

                            Message('Net Dividends %1', Rec."Net Dividends");

                            ProdFac.Reset;
                            ProdFac.SetRange("Product Class Type", ProdFac."Product Class Type"::Loan);
                            ProdFac.SetRange(Status, ProdFac.Status::Active);
                            ProdFac.Setrange("Type of Discounting", ProdFac."Type of Discounting"::"Dividend Discounting");
                            if ProdFac.Find('-') then begin
                                DividendProgression.RESET;
                                DividendProgression.SETRANGE("Member No", Members."No.");
                                DividendProgression.SETRANGE("End Date", DivSetup."Discounting Start Date", DivSetup."Discounting End Date");
                                if DividendProgression.Find('-') then begin
                                    // DividendProgression.CALCSUMS("Gross Dividends", "Net Dividends");
                                    DividendProgression.CALCSUMS("Net Dividends");
                                    QualifiedAmount := (ProdFac."Discounting %" / 100 * DividendProgression."Net Dividends");
                                end;
                            end;

                            Message('Qualified Amount %1', QualifiedAmount);

                            NetAmt := Round((loansProcess.ComputeDividendsDiscounting(Members."No.", '1',false)), 1, '<');
                            Message('Net Amount %1', NetAmt);


                            if QualifiedAmount > NetAmt then
                                LoanLimit := QualifiedAmount - NetAmt
                            else
                                LoanLimit := 0;

                            Message('Loan Limit %1', LoanLimit);

                            // IF QualifiedAmount > DivloanBal then
                            //     NetAmt := QualifiedAmount - DivloanBal
                            // else
                            //     NetAmt := 0;
                            // Message('Net Amount %1', NetAmt);

                            //Loan Arrears
                            //Qualified Amount
                            // Discounted Amount
                            //Netc Qualifes AMt - Arrears
                            //IF DCS Bal as 15/03 is less than Qualifying Amt then Exit
                            //Account Closure in 2024 & 2025
                            //Rejoining in 2024 & 2025
                        end;
                    end;


                }
            }
        }
        */
    trigger OnAfterGetRecord()
    var
    begin
        if Members.Get(Rec."Member No") then
            MemberName := Members.Name;
    end;

    var
        Members: Record Members;
        MemberName: Text[100];

}

//ArREARS
//Qualified AMount


