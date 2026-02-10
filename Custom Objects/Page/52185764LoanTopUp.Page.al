page 52185764 "Loan Top Up"
{
    PageType = List;
    SourceTable = "Loans Top up";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;

                }
                field("Loan Top Up"; Rec."Loan Top Up")
                {
                    ApplicationArea = Basic, Suite;

                }

                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Source Unit"; Rec."Source Unit")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Principle Top Up"; Rec."Principle Top Up")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Interest Top Up"; Rec."Interest Top Up")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Daily Interest"; Rec."Daily Interest")
                { ApplicationArea = Basic, Suite; }
                field("Total Top Up"; Rec."Total Top Up")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Monthly Repayment"; Rec."Monthly Repayment")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Interest Paid"; Rec."Interest Paid")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("ID. NO"; Rec."ID. NO")
                {
                    ApplicationArea = Basic, Suite;

                }
                field(Commision; Rec.Commision)
                {
                    ApplicationArea = Basic, Suite;

                }
                field("One Month Interest"; Rec."One Month Interest")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Insurance rebate"; Rec."Insurance rebate")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Loan Account"; Rec."Loan Account")
                {
                    ApplicationArea = Basic, Suite;

                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
        loansRec: Record Loans;
        LoAnTop: Record "Loans Top up";
    begin
        if rec."Loan No." <> '' then begin
            loansRec.Reset();
            loansRec.SetRange("Loan No.", Rec."Loan No.");
            loansRec.SetRange(Posted, true);
            if loansRec.FindFirst() then
                CurrPage.Editable := false;
            if Rec."Loan No." <> '' then begin
                LoAnTop.Reset();
                LoAnTop.SetRange("Loan No.", Rec."Loan No.");
                if LoAnTop.FindFirst() then begin
                    if LoAnTop."Loan Top Up" <> '' then begin
                        loansRec.Reset();
                        loansRec.SetRange("Loan No.", Rec."Loan No.");
                        loansRec.SetRange("Source Unit", loansRec."Source Unit"::BOSA);
                        if loansRec.FindFirst() then begin
                            if (loansRec."Current User" <> UserId) and (loansRec."Current User" <> '') then begin
                                CurrPage.Editable := false;
                                message('User %1 is operating on the card', loansRec."Current User");
                            end;
                        end;
                    end;
                end;
            end;
        end;

    end;
}

