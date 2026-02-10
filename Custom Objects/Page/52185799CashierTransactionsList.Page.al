page 52185799 "Cashier Transactions List"
{
    CardPageID = "Cashier Transactions";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Cashier Transactions";
    SourceTableView = SORTING(No)
                      ORDER(Descending)
                      WHERE(Posted = CONST(false));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque Type"; Rec."Cheque Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Discount Cheque")
            {
                ApplicationArea = Basic, Suite;
                Image = MakeAgreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;
                Visible = false;
                RunObject = Page "Cheque Discounting";
                RunPageLink = No = FIELD(No),
                              Type = CONST("Cheque Deposit");
            }
            action("Stop Cheque")
            {
                ApplicationArea = Basic, Suite;
                Image = VoidCheck;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    SaccoT: Codeunit "Sacco Transactions";
                begin

                    //here//SaccoT.StopCheque(Rec);
                end;
            }
            action("Clear Lien")
            {
                ApplicationArea = Basic, Suite;
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin

                    if Rec.Type <> Rec.Type::Lien then
                        Error('Only applicable to Lien');

                    if Confirm('Are you sure you want to process the selected transactions?', false) = true then begin

                        Rec."Cheque Status" := Rec."Cheque Status"::Honoured;
                        Rec."Date Cleared" := Today;
                        Rec."Cleared By" := UserId;
                        Rec.Modify;

                        Message('Lien processed successfully');

                    end;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        // Temp.Get(UserId);

        // Jtemplate := Temp."Cashier Journal Template";
        // Jbatch := Temp."Cashier Journal Batch";
        // TillNo := Temp."Default  Bank";
        // MemberNo := Temp."Member No.";
        // Excess := Temp."Excess Account";
        // Shortage := Temp."Shortage Account";

        // if Jtemplate = '' then begin
        //     Error(Text0001);
        // end;
        // if Jbatch = '' then begin
        //     Error(Text0002);
        // end;

        // if TillNo = '' then begin
        //     Error(Text0003);
        // end;

        // if MemberNo = '' then begin
        //     Error(Text0004);
        // end;

        // if Shortage = '' then begin
        //     Error(Text0005);
        // end;

        // if Excess = '' then begin
        //     Error(Text0006);
        // end;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetRange(Cashier, UserId);
    end;

    var
        Temp: Record "Banking User Template";
        Jtemplate: Code[20];
        Jbatch: Code[20];
        TillNo: Code[20];
        MemberNo: Code[20];
        Text0001: Label 'Ensure the Cashier journal Template is set up in Banking User Setup';
        Text0002: Label 'Ensure the Cashier journal Batch is set up in Banking User Setup';
        Text0003: Label 'Ensure the Default Bank is set up in Banking User Setup';
        Text0004: Label 'Ensure the Cashier Member no is set up in Banking User Setup';
        Excess: Code[20];
        Shortage: Code[20];
        Text0005: Label 'Ensure the Cashier Shortage Account is set up in Banking User Setup';
        Text0006: Label 'Ensure the Cashier Excess Account iis set up in Banking User Setup';
}

