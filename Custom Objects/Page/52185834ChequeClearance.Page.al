page 52185834 "Cheque Clearance"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Cashier Transactions";
    SourceTableView = WHERE(Posted = CONST(true),
                            Type = FILTER("Credit Cheque" | "Cheque Deposit"));
    ApplicationArea = Basic, Suite;
    usagecategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                ShowCaption = false;

                field(Select; Rec.Select)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    Caption = 'Transaction';
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    Caption = 'Date';
                    Editable = false;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    Caption = 'Time';
                    Editable = false;
                }
                field("Expected Maturity Date"; Rec."Expected Maturity Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Date Cleared"; Rec."Date Cleared")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Cleared By"; Rec."Cleared By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(View)
            {
                Caption = 'View';
                action("Account Card")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Card';
                }
            }
        }
        area(processing)
        {
            action(Process)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Clear Cheque';
                Image = PutawayLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SaccoT: Codeunit "Sacco Transactions";
                    CreditLedger: Record "Credit Ledger Entry";
                    SendSMS: codeunit SendSms;
                    Source: enum "SMS Source";
                    SMSMessage: Text;
                    MobileNo: code[20];
                    SavingsACC: Record "Savings Accounts";
                    Members: Record Members;
                begin
                    if Confirm('Are you sure you want to process the selected transactions?', false) = true then begin

                        Transactions.Reset;
                        Transactions.SetRange(Transactions.Select, true);
                        if Transactions.Find('-') then begin
                            repeat
                                if Transactions."Expected Maturity Date" > Today then
                                    Error('Cheque %1 cannot be cleared before maturity date %2', Transactions.No, Transactions."Expected Maturity Date");

                                CreditLedger.Reset;
                                CreditLedger.SetRange("Document No.", Transactions.No);
                                //CreditLedger.SetRange("Member No.", Transactions."Member No.");
                                if not CreditLedger.Find('-') then begin
                                    SaccoT.ClearCheques;
                                end;

                                if SavingsACC.Get(Transactions."Account No") then begin
                                    MobileNo := SavingsACC."Mobile Phone No";
                                    if MobileNo = '' then begin
                                        if Members.Get(Transactions."Member No.") then
                                            MobileNo := Members."Transactional Mobile Number";
                                    end;
                                    if MobileNo = '' then begin
                                        if Members.Get(Transactions."Member No.") then
                                            MobileNo := Members."Phone No.";
                                    end;

                                    SMSMessage := StrSubstNo('Dear %1, your cheque no. %2 for amount KES %3 has been cleared on %4.',
                                        SavingsACC.Name, Transactions."Cheque No", Transactions.Amount, Format(Today) + ' ' + Format(Time));
                                    if MobileNo <> '' then
                                        SendSMS.SendSms(Source::CHEQUE_CLEARANCE, MobileNo, SMSMessage, Format(Transactions."Account No"), '', true, 0, false, 'CBS', Transactions."Account No", 'CBS');
                                end;
                            // Transactions."Cheque Status" := Transactions."cheque status"::Cleared;
                            // Transactions."Date Cleared" := Today;
                            // Transactions."Cleared By" := UserId;
                            // Transactions.Modify(true);

                            until Transactions.Next = 0;
                        end
                        else
                            Error('No transactions selected for Clearance');
                        Message('Cheque Cleared Successfully!!!');
                    end;
                end;
            }
            action("Cancel Cheque Clearance")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Cheque Clearance';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SaccoT: Codeunit "Sacco Transactions";
                begin
                    if Confirm('Are you sure you want to cancel the clearance of the selected transactions?', false) = true then begin
                        SaccoT.CancelCheque;
                        Message('Cheque Clearance Cancelled Successfully!!!');
                    end;
                end;
            }
            action("Cleared Cheque Report")
            {
                ApplicationArea = Basic;
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    Transactions.Reset();
                    Transactions.SetRange(No, Rec.No);
                    Transactions.SetRange("Member No.", rec."Member No.");
                    if Transactions.FindFirst() then begin
                        Report.Run(Report::"Clear Cheque Report", true, false);
                    end;


                    // if (Rec.Type <> Rec.Type::"Cheque Deposit") or (Rec.Type <> Rec.Type::"Cheque Deposit") then
                    //     Error('Only applicable to Cheques');

                    // if Confirm('Are you sure you want to clear the selected Cheques?', false) = true then begin

                    //     Rec."Cheque Status" := Rec."Cheque Status"::Cleared;
                    //     Rec."Date Cleared" := Today;
                    //     Rec."Cleared By" := UserId;
                    //     Rec.Modify;

                    //     Message('Cheque Cleared Successfully!!!');

                    // end;
                end;
            }
        }
    }

    var
        Transactions: Record "Cashier Transactions";
}

