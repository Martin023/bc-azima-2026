page 52186503 "Sky M-Banking Trans. Buf. Card"
{
    ApplicationArea = All;
    Caption = 'Sky M-Banking Transactions Buffer Card';
    PageType = Card;
    SourceTable = "Sky M-Banking Trans. Buffer";

    DataCaptionFields = "Transaction Type";

    ModifyAllowed = true;
    InsertAllowed = false;
    DeleteAllowed = false;

    PromotedActionCategories = ',,,Reversals';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Information';

                field("Originator ID"; Rec."Originator ID")
                {
                    ToolTip = 'Specifies the value of the Originator ID field.';
                }
                // field("Transaction Type"; Rec."Transaction Type")
                // {
                //     ToolTip = 'Specifies the value of the Transaction Type field.';
                // }
                field("Transaction Status"; Rec."Transaction Status")
                {
                    ToolTip = 'Specifies the value of the Transaction Status field.';
                }
                field("PESA Type"; Rec."PESA Type")
                {
                    ToolTip = 'Specifies the value of the PESA Type field.';
                }
                field("Action"; Rec."Action")
                {
                    ToolTip = 'Specifies the value of the Action field.';
                }
                field(Command; Rec.Command)
                {
                    ToolTip = 'Specifies the value of the Command field.';
                }
                field(Sensitivity; Rec.Sensitivity)
                {
                    ToolTip = 'Specifies the value of the Sensitivity field.';
                }
                field(Charge; Rec.Charge)
                {
                    ToolTip = 'Specifies the value of the Charge field.';
                }
                field("Identifier Type"; Rec."Identifier Type")
                {
                    ToolTip = 'Specifies the value of the Identifier Type field.';
                }
                field(Identifier; Rec.Identifier)
                {
                    ToolTip = 'Specifies the value of the Identifier field.';
                }
                field("Transaction Amount"; Rec."Transaction Amount")
                {
                    ToolTip = 'Specifies the value of the Transaction Amount field.';
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ToolTip = 'Specifies the value of the Transaction Description field.';
                }
                field("Transaction Category"; Rec."Transaction Category")
                {
                    ToolTip = 'Specifies the value of the Transaction Category field.';
                }
                field("Transaction Source Reference"; Rec."Transaction Source Reference")
                {
                    ToolTip = 'Specifies the value of the Transaction Source Reference field.';
                }
                field("Request Application"; Rec."Request Application")
                {
                    ToolTip = 'Specifies the value of the Request Application field.';
                }
                field("Source Application"; Rec."Source Application")
                {
                    ToolTip = 'Specifies the value of the Source Application field.';
                }
                field("Transaction Date Time"; Rec."Transaction Date Time")
                {
                    ToolTip = 'Specifies the value of the Transaction Date Time field.';
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ToolTip = 'Specifies the value of the Transaction Date field.';
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ToolTip = 'Specifies the value of the Transaction Time field.';
                }
                field("Posted"; Rec.Posted) { Editable = false; }
                field("Posting Date"; Rec."Posting Date") { Editable = false; }
                field("Posting Time"; Rec."Posting Time") { Editable = false; }
                field("Posted By"; Rec."Posted By") { Editable = false; }

                field("Needs Change"; Rec."Needs Change")
                {
                    Editable = PageEditable;
                    trigger OnValidate()
                    begin
                        if not Confirm('Are you sure you want to proceed? This transaction will be processed with the current changes.') then begin
                            Error('Changes will not be processed');
                        end else begin
                            Message('Changes will be processed');
                        end;
                    end;
                }
                field("Needs Change Reason"; Rec."Needs Change Reason") { Editable = false; }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Editable = PageEditable;
                    trigger OnValidate()
                    begin
                        if not ((Rec."Transaction Type" = Rec."Transaction Type"::"Mpesa Deposit") or 
                        (Rec."Transaction Type" = Rec."Transaction Type"::"Loan Repayment") or
                        (Rec."Transaction Type" = Rec."Transaction Type"::"Coop B2B Deposit") or
                        (Rec."Transaction Type" = Rec."Transaction Type"::"Coop P2F Deposit")
                        ) then begin
                            Error('Allowed transaction types for change are: %1, %2, %3 or %4',
                            Format(Rec."Transaction Type"::"Mpesa Deposit"),
                            Format(Rec."Transaction Type"::"Loan Repayment"),
                            Format(Rec."Transaction Type"::"Coop B2B Deposit"),
                            Format(Rec."Transaction Type"::"Coop P2F Deposit"));
                        end;
                    end;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    Editable = PageEditable and (Rec."Transaction Type" = Rec."Transaction Type"::"Loan Repayment");
                    trigger OnValidate()
                    begin
                        Rec.Validate("Loan No.");
                    end;
                }
                field("Loan Account"; Rec."Loan Account") { Editable = false; }
                field("Savings Account"; Rec."Savings Account")
                {
                    Editable = PageEditable and ((Rec."Transaction Type" = Rec."Transaction Type"::"Mpesa Deposit") or (Rec."Transaction Type" = Rec."Transaction Type"::"Coop B2B Deposit") or (Rec."Transaction Type" = Rec."Transaction Type"::"Coop P2F Deposit"));
                    trigger OnValidate()
                    begin
                        Rec.Validate("Savings Account");
                    end;
                }
                field("Destination Account"; Rec."Destination Account")
                {
                    Editable = false;
                }

                field("Change Type"; Rec."Change Type") { Editable = false; }
                field("Changed By"; Rec."Changed By") { Editable = false; }
                field("Changed Date"; Rec."Changed Date") { Editable = false; }
                field("Changed Time"; Rec."Changed Time") { Editable = false; }
                field("Try Posting Count"; Rec."Try Posting Count") { }
            }
            group(Initiator)
            {
                Caption = 'Initiator Details';

                field("Initiator Account"; Rec."Initiator Account")
                {
                    ToolTip = 'Specifies the value of the Transaction Initiator Account field.';
                }
                field("Initiator Identifier"; Rec."Initiator Identifier")
                {
                    ToolTip = 'Specifies the value of the Transaction Initiator Identifier field.';
                }
                field("Initiator Identifier Type"; Rec."Initiator Identifier Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Initiator Identifier Type field.';
                }
                field("Initiator Name"; Rec."Initiator Name")
                {
                    ToolTip = 'Specifies the value of the Transaction Initiator Name field.';
                }
                field("Initiator Other Details"; Rec."Initiator Other Details")
                {
                    ToolTip = 'Specifies the value of the Transaction Initiator Other Details field.';
                    MultiLine = true;
                }
                field("Initiator Reference"; Rec."Initiator Reference")
                {
                    ToolTip = 'Specifies the value of the Transaction Initiator Reference field.';
                }
            }
            group(Source)
            {
                Caption = 'Source Details';

                field("Source Account"; Rec."Source Account")
                {
                    ToolTip = 'Specifies the value of the Transaction Source Account field.';
                }
                field("Source Identifier"; Rec."Source Identifier")
                {
                    ToolTip = 'Specifies the value of the Transaction Source Identifier field.';
                }
                field("Source Identifier Type"; Rec."Source Identifier Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Source Identifier Type field.';
                }
                field("Source Name"; Rec."Source Name")
                {
                    ToolTip = 'Specifies the value of the Transaction Source Name field.';
                }
                field("Source Other Details"; Rec."Source Other Details")
                {
                    ToolTip = 'Specifies the value of the Transaction Source Other Details field.';
                    MultiLine = true;
                }
                field("Source Reference"; Rec."Source Reference")
                {
                    ToolTip = 'Specifies the value of the Transaction Source Reference field.';
                }
            }
            group(Sender)
            {
                Caption = 'Sender Details';

                field("Sender Account"; Rec."Sender Account")
                {
                    ToolTip = 'Specifies the value of the Transaction Sender Account field.';
                }
                field("Sender Identifier"; Rec."Sender Identifier")
                {
                    ToolTip = 'Specifies the value of the Transaction Sender Identifier field.';
                }
                field("Sender Identifier Type"; Rec."Sender Identifier Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Sender Identifier Type field.';
                }
                field("Sender Name"; Rec."Sender Name")
                {
                    ToolTip = 'Specifies the value of the Transaction Sender Name field.';
                }
                field("Sender Other Details"; Rec."Sender Other Details")
                {
                    ToolTip = 'Specifies the value of the Transaction Sender Other Details field.';
                    MultiLine = true;
                }
                field("Sender Reference"; Rec."Sender Reference")
                {
                    ToolTip = 'Specifies the value of the Transaction Sender Reference field.';
                }
            }
            group(Receiver)
            {
                Caption = 'Receiver Details';

                field("Receiver Account"; Rec."Receiver Account")
                {
                    ToolTip = 'Specifies the value of the Transaction Receiver Account field.';
                }
                field("Receiver Identifier"; Rec."Receiver Identifier")
                {
                    ToolTip = 'Specifies the value of the Transaction Receiver Identifier field.';
                }
                field("Receiver Identifier Type"; Rec."Receiver Identifier Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Receiver Identifier Type field.';
                }
                field("Receiver Name"; Rec."Receiver Name")
                {
                    ToolTip = 'Specifies the value of the Transaction Receiver Name field.';
                }
                field("Receiver Other Details"; Rec."Receiver Other Details")
                {
                    ToolTip = 'Specifies the value of the Transaction Receiver Other Details field.';
                    MultiLine = true;
                }
                field("Receiver Reference"; Rec."Receiver Reference")
                {
                    ToolTip = 'Specifies the value of the Transaction Receiver Reference field.';
                }
            }
            group(Beneficiary)
            {
                Caption = 'Beneficiary Details';

                field("Beneficiary Account"; Rec."Beneficiary Account")
                {
                    ToolTip = 'Specifies the value of the Transaction Beneficiary Account field.';
                }
                field("Beneficiary Identifier"; Rec."Beneficiary Identifier")
                {
                    ToolTip = 'Specifies the value of the Transaction Beneficiary Identifier field.';
                }
                field("Beneficiary Identifier Type"; Rec."Beneficiary Identifier Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Beneficiary Identifier Type field.';
                }
                field("Beneficiary Name"; Rec."Beneficiary Name")
                {
                    ToolTip = 'Specifies the value of the Transaction Beneficiary Name field.';
                }
                field("Beneficiary Other Details"; Rec."Beneficiary Other Details")
                {
                    ToolTip = 'Specifies the value of the Transaction Beneficiary Other Details field.';
                    MultiLine = true;
                }
                field("Beneficiary Reference"; Rec."Beneficiary Reference")
                {
                    ToolTip = 'Specifies the value of the Transaction Beneficiary Reference field.';
                }
            }
        }
    }


    actions
    {
        area(creation)
        {
            action("Deposit Reversal")
            {
                Caption = 'Deposit Reversal';
                Visible = DepositReversible;
                Enabled = DepositReversible;
                ApplicationArea = Basic, Suite;
                Image = ReverseRegister;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    Rec.TestField(Posted, false);
                    Rec.TestField("Needs Change", true);

                    if not Confirm('Are you sure you want to proceed? This transaction will be reversed.') then begin
                        Error('Transaction will NOT be reversed');
                    end else begin
                        Rec."Changed By" := UserId;
                        Rec."Changed Date" := Today;
                        Rec."Changed Time" := Time;
                        Rec."Change Type" := Rec."Change Type"::Reverse;
                        Rec."Needs Change Reason" := 'Paybill Reversal';

                        Rec.Posted := true;
                        Rec."Needs Change" := false;

                        Rec.Modify;

                        Message('Transaction has been reversed successfully');
                    end;
                end;
            }
            action("Withdrawal Reversal")
            {
                Caption = 'Withdrawal Reversal';
                Visible = WithdrawalReversible;
                Enabled = WithdrawalReversible;
                ApplicationArea = Basic, Suite;
                Image = ReverseRegister;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    Rec.TestField("Transaction Status", Rec."Transaction Status"::" ");
                    Rec.TestField(Posted, false);

                    if not Confirm('Are you sure you want to proceed? This withdrawal transaction will be reversed.') then begin
                        Error('Transaction will NOT be reversed');
                    end else begin
                        Rec."Transaction Status" := Rec."Transaction Status"::REVERSE_CONFIRMED;
                        Rec."Changed By" := UserId;
                        Rec."Changed Date" := Today;
                        Rec."Changed Time" := Time;
                        Rec."Change Type" := Rec."Change Type"::Reverse;
                        Rec."Needs Change Reason" := 'Reversal: ' + Format(Rec."Transaction Type");

                        Rec.Modify;

                        Message('Withdrawal transaction has been reversed successfully');
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        PageEditable := Rec."Needs Change";
        // Deposits
        if (Rec."Transaction Type" = Rec."Transaction Type"::"Mpesa Deposit") or (Rec."Transaction Type" = Rec."Transaction Type"::"Loan Repayment") or 
        (Rec."Transaction Type" = Rec."Transaction Type"::"Coop B2B Deposit") or (Rec."Transaction Type" = Rec."Transaction Type"::"Coop P2F Deposit") then begin
            if (Rec."Needs Change" = true) and (Rec.Posted = false) then begin
                DepositReversible := true;
            end;
        end;
        // Withdrawals
        if Rec."Transaction Status" = Rec."Transaction Status"::" " then begin
            case Rec."Transaction Type" of
                Rec."Transaction Type"::Airtime,
                Rec."Transaction Type"::"Mpesa Withdrawal",
                Rec."Transaction Type"::"Bank Transfer",
                Rec."Transaction Type"::"Utility Payment":
                    begin
                        WithdrawalReversible := true;
                    end;
                else
            end;
        end;
    end;

    trigger OnOpenPage()
    begin
        PageEditable := Rec."Needs Change";
        // Deposits
        if (Rec."Transaction Type" = Rec."Transaction Type"::"Mpesa Deposit") or (Rec."Transaction Type" = Rec."Transaction Type"::"Loan Repayment") or 
        (Rec."Transaction Type" = Rec."Transaction Type"::"Coop B2B Deposit") or (Rec."Transaction Type" = Rec."Transaction Type"::"Coop P2F Deposit") then begin
            if (Rec."Needs Change" = true) and (Rec.Posted = false) then begin
                DepositReversible := true;
            end;
        end;

        // Withdrawals
        if Rec."Transaction Status" = Rec."Transaction Status"::" " then begin
            case Rec."Transaction Type" of
                Rec."Transaction Type"::Airtime,
                Rec."Transaction Type"::"Mpesa Withdrawal",
                Rec."Transaction Type"::"Bank Transfer",
                Rec."Transaction Type"::"Utility Payment":
                    begin
                        WithdrawalReversible := true;
                    end;
                else
            end;
        end;

        FnRestrictAccess;
    end;

    trigger OnClosePage()
    begin
        PageEditable := Rec."Needs Change";
        // Deposits
        if (Rec."Transaction Type" = Rec."Transaction Type"::"Mpesa Deposit") or (Rec."Transaction Type" = Rec."Transaction Type"::"Loan Repayment")
        or (Rec."Transaction Type" = Rec."Transaction Type"::"Coop B2B Deposit") or (Rec."Transaction Type" = Rec."Transaction Type"::"Coop P2F Deposit") then begin
            if (Rec."Needs Change" = true) and (Rec.Posted = false) then begin
                DepositReversible := true;
            end;
        end;

        // Withdrawals
        if Rec."Transaction Status" = Rec."Transaction Status"::" " then begin
            case Rec."Transaction Type" of
                Rec."Transaction Type"::Airtime,
                Rec."Transaction Type"::"Mpesa Withdrawal",
                Rec."Transaction Type"::"Bank Transfer",
                Rec."Transaction Type"::"Utility Payment":
                    begin
                        WithdrawalReversible := true;
                    end;
                else
            end;
        end;
    end;

    var
        StatusPermission: Record "Status Change Permissions.";

    //[Scope('OnPrem')]
    procedure FnRestrictAccess()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestrictViewTxt: Label 'You do not have permission on View,Read,Modify on this Page. Contact system administrator for assistance. %1 - %2';
    begin
        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", DATABASE.UserId);
        StatusPermission.SetRange("Mbanking - View", true);
        if Rec."Needs Change" then begin
            StatusPermission.SetRange("Mbanking - Edit", true);
        end;

        if not StatusPermission.Find('-') then begin
            // CurrPage.Editable := false;
            Error(ErrorOnRestrictViewTxt, UserId, Rec.TableCaption);
        end
        // else begin
        //     CurrPage.Editable := true;
        // end;
    end;

    var
        PageEditable: Boolean;
        DepositReversible: Boolean;
        WithdrawalReversible: Boolean;
}
