page 52185744 "Savings Account Card"
{
    Caption = 'Savings Account Card';

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Request Approval,Activities';
    RefreshOnActivate = true;
    SourceTable = "Savings Accounts";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field("Old Account No"; Rec."Old Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = not HideAccount;
                }
                field("Product Category"; Rec."Product Category")
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
                field("Send Statement Freq."; Rec."Send Statement Freq.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    OptionCaption = ' ,New,Active,Dormant,Frozen,Withdrawal Application,Withdrawn,Deceased,Defaulter,Closed';
                }
                field("Status Change Reason"; Rec."Status Change Reason")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Salary Through FOSA"; Rec."Salary Through FOSA")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = not HideAccount;

                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Status Change Statistics"; Rec."Status Change Statistics")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = not HideAccount;

                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = not HideAccount;

                    // Visible = false;

                    trigger OnDrillDown()
                    var
                        DtldCustLedgEntry: Record "Savings Ledger Entry";
                        CustLedgEntry: Record "Savings Ledger Entry";
                    begin
                        /*DtldCustLedgEntry.SETRANGE("Customer No.","No.");
                        COPYFILTER("Global Dimension 1 Filter",DtldCustLedgEntry."Initial Entry Global Dim. 1");
                        COPYFILTER("Global Dimension 2 Filter",DtldCustLedgEntry."Initial Entry Global Dim. 2");
                        COPYFILTER("Currency Filter",DtldCustLedgEntry."Currency Code");
                        CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
                        */

                    end;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = not HideAccount;

                }
                // field("ATM No."; Rec.NewStr)
                // {
                // }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Withdrawal Date"; Rec."Last Withdrawal Date")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = not HideAccount;

                }
                field("Employer Account No"; Rec."Employer Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile Loan Blocked"; Rec."Mobile Loan Blocked")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile Loan Blocked By"; Rec."Mobile Loan Blocked By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile Loan Date  Blocked"; Rec."Mobile Loan Date  Blocked")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile Loan Un Blocked By"; Rec."Mobile Loan Un Blocked By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Disbursement Account"; Rec."Loan Disbursement Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Can Guarantee Loan"; Rec."Can Guarantee Loan")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("SASRA Savings Category"; Rec."SASRA Savings Category")
                {
                    Editable = false;
                    Visible = not HideAccount;

                }
            }
            group(ChannelTransactionSetup)
            {
                Caption = 'Channels Transaction Setup';

                field("ATM Withdrawal Limit"; Rec."ATM Withdrawal Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Daily Withdrawals Limit"; Rec."ATM Daily Withdrawals Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile Withdrawal Limit"; Rec."Mobile Withdrawal Limit")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Mobile Daily Withdrawal Limit"; Rec."Mobile Daily Withdrawal Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Fixed Deposit")
            {
                Caption = 'Fixed Deposit';
                Editable = false;
                Visible = IsFixedDeposit;
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Fixed Deposit Type"; Rec."Fixed Deposit Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("FD Duration"; Rec."FD Duration")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'FD Duration';
                }
                field("Fixed Deposit Status"; Rec."Fixed Deposit Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("FD Maturity Date"; Rec."FD Maturity Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = not HideAccount;

                }
                field("FD Date Renewed"; Rec."FD Date Renewed")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Neg. Interest Rate"; Rec."Neg. Interest Rate")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = not HideAccount;

                }
                field("FD Maturity Instructions"; Rec."FD Maturity Instructions")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Savings Account No."; Rec."Savings Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fixed Deposit cert. no"; Rec."Fixed Deposit cert. no")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fixed Deposit Amount"; Rec."Fixed Deposit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = not HideAccount;

                }
                field("Interest Earned"; Rec."Interest Earned")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = not HideAccount;

                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                Editable = false;
                field("Office Telephone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Office Telephone No.';
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = not HideAccount;

                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Nationality; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nationality';
                }
                field("Current Address"; Rec."Current Address")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Home Address"; Rec."Home Address")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                }
            }
            group(Hide)
            {
                Caption = 'Hide';
                Editable = false;
                Visible = true;
                field(Control75; Rec.Hide)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Sweeping)
            {
                Caption = 'Sweeping';
                Editable = false;
                visible = false;
                field("Enable Sweeping"; Rec."Enable Sweeping")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("External Account No"; Rec."External Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Trans)
            {
                Editable = false;
                Caption = 'Trans';
                field(Savacc; Rec."Savings Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Savings Account No';
                }
                field("Amount to Transfer"; Rec."Amount to Transfer")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(monthlycont; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Monthly Contribution';
                    Visible = not HideAccount;

                }
            }
            group("Foreign Currency")
            {
                Caption = 'Foreign Currency';
                Visible = false;
                Editable = false;
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Importance = Promoted;
                }
            }
            group("Change Logs")
            {
                Caption = 'Change Logs';
                Editable = false;
                field("Change Log Entries"; Rec."Change Log Entries")
                {
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control12; "CRM Statistics FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
                Visible = CRMIsCoupledToRecord;
            }
            //here
            // part(Control11; "Social Listening FactBox")
            // {
            //     SubPageLink = "Source Type" = CONST(Customer),
            //                   "Source No." = FIELD("No.");
            //     Visible = SocialListeningVisible;
            // }
            // part(Control10; "Social Listening Setup FactBox")
            // {
            //     SubPageLink = "Source Type" = CONST(Customer),
            //                   "Source No." = FIELD("No.");
            //     UpdatePropagation = Both;
            //     Visible = SocialListeningSetupVisible;
            // }
            part(Control9; "Sales Hist. Sell-to FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            part(Control8; "Sales Hist. Bill-to FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            part(Control7; "Savings Statistics FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = not HideAccount;

            }
            part(Control6; "Dimensions FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Table ID" = CONST(18),
                              "No." = FIELD("No.");
                Visible = false;
            }
            part(Control5; "Service Hist. Sell-to FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            part(Control4; "Service Hist. Bill-to FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control2; Links)
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            systempart(Control1; Notes)
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
        }
    }


    actions
    {
        area(navigation)
        {
            group("&Customer")
            {
                Caption = '&Customer';
                Image = Customer;
                action(ApprovalEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    begin
                        // // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
        }
        area(processing)
        {
            group(Process)
            {
                Caption = 'Process';
                action("Transfer Funds ")
                {
                    ApplicationArea = Basic, Suite;
                    Image = TransferFunds;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //Transfer Funds


                        if (Rec."Product Type" <> '804') or (Rec."Product Type" <> '807') then
                            Error('Sorry process not available for this account, kinldy use the account transfer');

                        Temp.Get(UserId);

                        Jtemplate := Temp."Transfer Journal Template";
                        JBatch := Temp."Transfer Journal Batch";


                        if Jtemplate = '' then begin
                            Error(Text0001);
                        end;

                        if JBatch = '' then begin
                            Error(Text0002);
                        end;

                        Rec.CalcFields("Balance (LCY)");


                        Rec.TestField("Savings Account No.");
                        if Rec."Product Type" <> '807' then
                            Rec.TestField("Amount to Transfer");
                        Rec.TestField("Registration Date");

                        if Confirm('Are you sure you want to transfer fund from this account to the main account?', false) = false then
                            exit;

                        if AccountTypes.Get(Rec."Product Type") then begin

                            GenJournalLine.Reset;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", Jtemplate);
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
                            if GenJournalLine.Find('-') then
                                GenJournalLine.DeleteAll;

                            if AccountTypes."Product ID" = '807' then begin


                                //Amount
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := JBatch;
                                GenJournalLine."Document No." := 'TR-' + Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Employee;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Rec."Balance (LCY)";
                                //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                                //GenJournalLine."Bal. Account No.":='2-13-001090';
                                //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Msingi Mbora Savings';
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := JBatch;
                                GenJournalLine."Document No." := 'TR-' + Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Employee;
                                GenJournalLine."Account No." := Rec."Savings Account No.";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Rec."Balance (LCY)" * -1;
                                //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                                //GenJournalLine."Bal. Account No.":='2-13-001090';
                                //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                //GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Msingi Mbora Savings';
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;



                                CommMbora := Rec."Balance (LCY)" * 0.02;

                                //Commision

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := JBatch;
                                GenJournalLine."Document No." := 'TR-' + Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Employee;
                                GenJournalLine."Account No." := Rec."Savings Account No.";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := CommMbora;
                                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := '2-13-001013';
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Commission on withdrawal';
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                CountNo := 0;
                                IntForf := 0;

                                IntBuffer.Reset;
                                IntBuffer.SetRange(IntBuffer."Account No", Rec."No.");
                                //IntBuffer.SETRANGE(IntBuffer.Transferred,FALSE);
                                if IntBuffer.Find('-') then begin
                                    repeat
                                        IntForf := IntForf + IntBuffer."Interest Amount";
                                        CountNo := CountNo + 1;
                                    until IntBuffer.Next = 0;
                                end;



                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := JBatch;
                                GenJournalLine."Document No." := 'TR-' + Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Employee;
                                GenJournalLine."Account No." := Rec."Savings Account No.";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := IntForf;
                                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := '1-11-000013';
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Forfeited Interest';
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                InsurancePrem := CountNo * Rec."Monthly Contribution";


                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := JBatch;
                                GenJournalLine."Document No." := 'TR-' + Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Employee;
                                GenJournalLine."Account No." := Rec."Savings Account No.";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := InsurancePrem;
                                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := '2-13-001013';
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Insurance Premium';
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                IntBuffer.Reset;
                                IntBuffer.SetRange(IntBuffer."Account No", Rec."No.");
                                IntBuffer.SetRange(IntBuffer.Transferred, false);
                                if IntBuffer.Find('-') then begin
                                    repeat
                                        IntBuffer.Transferred := true;
                                        IntBuffer.Modify;
                                    until IntBuffer.Next = 0;
                                end;

                            end else begin
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := JBatch;
                                GenJournalLine."Document No." := 'TR-' + Rec."No.";
                                GenJournalLine."External Document No." := Rec."Savings Account No.";
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Employee;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Funds Transfer';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Rec."Amount to Transfer";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := JBatch;
                                GenJournalLine."Document No." := 'TR-' + Rec."No.";
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Employee;
                                GenJournalLine."Account No." := Rec."Savings Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Funds Transfer';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -(Rec."Amount to Transfer");
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Penalty charge
                                LastWithdrawalDate := Rec."Registration Date";
                                if Rec."Product Type" = '804' then begin
                                    if Rec."Last Withdrawal Date" <> 0D then
                                        LastWithdrawalDate := Rec."Last Withdrawal Date";
                                end;

                                //Bett
                                if Rec."Last Withdrawal Date" <> 0D then
                                    LastWithdrawalDate := Rec."Last Withdrawal Date";

                                if Rec."Product Type" = '804' then begin

                                    if Confirm('Do you want to effect penalty on this account?', false) = true then begin

                                        if AccountTypes."Savings Withdrawal penalty" > 0 then begin
                                            if (CalcDate(AccountTypes."Savings Duration", LastWithdrawalDate) > Today) then begin
                                                AccountTypes.TestField(AccountTypes."Savings Penalty Account");
                                                //check balance
                                                if Rec."Balance (LCY)" < (Rec."Amount to Transfer" + AccountTypes."Savings Withdrawal penalty" + AccountTypes."Minimum Balance") then
                                                    Error('This will lead to account being elow minimum balance due to penalty');

                                                LineNo := LineNo + 10000;

                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := Jtemplate;
                                                GenJournalLine."Journal Batch Name" := JBatch;
                                                GenJournalLine."Document No." := 'TR-' + Rec."No.";
                                                GenJournalLine."External Document No." := Rec."No.";
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Employee;
                                                GenJournalLine."Account No." := Rec."No.";
                                                GenJournalLine."Posting Date" := Today;
                                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                                GenJournalLine.Amount := AccountTypes."Savings Withdrawal penalty";
                                                //ROUND("Amount to Transfer"*(AccountTypes."Savings Withdrawal penalty"/100),1,'>');
                                                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                                                GenJournalLine."Bal. Account No." := AccountTypes."Savings Penalty Account";
                                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                                GenJournalLine.Description := 'Withdrawal Penalty';
                                                GenJournalLine.Validate(GenJournalLine.Amount);
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;

                                            end;
                                        end;
                                    end;
                                end;



                                if Rec."Product Type" <> '804' then begin


                                    if AccountTypes."Savings Withdrawal penalty" > 0 then begin
                                        if (CalcDate(AccountTypes."Savings Duration", LastWithdrawalDate) > Today) then begin

                                            AccountTypes.TestField(AccountTypes."Savings Penalty Account");
                                            //check balance
                                            if Rec."Balance (LCY)" < (Rec."Amount to Transfer" +/*AccountTypes."Savings Withdrawal penalty"*/+AccountTypes."Minimum Balance") then
                                                Error('This will lead to account being elow minimum balance due to penalty');

                                            LineNo := LineNo + 10000;

                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                            GenJournalLine."Journal Batch Name" := JBatch;
                                            GenJournalLine."Document No." := 'TR-' + Rec."No.";
                                            GenJournalLine."External Document No." := Rec."No.";
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Employee;
                                            GenJournalLine."Account No." := Rec."No.";
                                            GenJournalLine."Posting Date" := Today;
                                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                                            GenJournalLine.Amount := AccountTypes."Savings Withdrawal penalty";
                                            //ROUND("Amount to Transfer"*(AccountTypes."Savings Withdrawal penalty"/100),1,'>');
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                                            GenJournalLine."Bal. Account No." := AccountTypes."Savings Penalty Account";
                                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine.Description := 'Withdrawal Penalty';
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;

                                        end;
                                    end;
                                end;
                            end;

                            //Penalty charge

                            //Penalty charge


                            //Post New
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                            GenJournalLine.SetRange("Journal Batch Name", JBatch);
                            if GenJournalLine.Find('-') then begin
                                //CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post New", GenJournalLine);
                            end;
                            //Post New

                            Rec."Last Withdrawal Date" := Today;
                            Rec."Amount to Transfer" := 0;
                            Rec.Modify;

                            Message('Funds transfered successfully.');

                        end;
                        //Transfer Funds

                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Activities';
                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                Visible = false;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF ApprovalsMgmt.CheckCustomerApprovalsWorkflowEnabled(Rec) THEN
                        //  ApprovalsMgmt.OnSendCustomerForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.OnCancelCustomerApprovalRequest(Rec);
                    end;
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
            }
            action(Statement)
            {
                ApplicationArea = Basic, Suite;
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";
                Enabled = not HideAccount;


                trigger OnAction()
                var
                    SavingsAccounts: Record "Savings Accounts";
                begin

                    if Rec.Hide = true then begin
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Show Hidden" = false then
                                Error('You do not have permissions to view this account information.');
                        end;
                    end;


                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange(SavingsAccounts."No.", Rec."No.");
                    if SavingsAccounts.Find('-') then
                        REPORT.Run(Report::"Savings Statement", true, false, SavingsAccounts);
                end;
            }
            action("Information Base")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Information Base';
                Image = CancelAttachment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Loanee Information Base";
                RunPageLink = "Member No." = FIELD("No.");
                Enabled = not HideAccount;

            }
            action("Process Fixed")
            {
                ApplicationArea = Basic, Suite;
                Enabled = IsFixedDeposit and not HideAccount;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = false;


                trigger OnAction()
                begin
                    //52018503

                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange(SavingsAccounts."No.", Rec."No.");
                    //if SavingsAccounts.Find('-') then
                    //REPORT.Run(52185895, true, false, SavingsAccounts);
                end;
            }
            action("Fixed Deposit History")
            {
                ApplicationArea = Basic, Suite;
                Enabled = IsFixedDeposit and not HideAccount;
                Image = Splitlines;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Fixed Deposit History";
                RunPageLink = "Account No." = FIELD("No.");
                Visible = false;

            }
            action(Signatories)
            {
                ApplicationArea = Basic, Suite;
                Image = Signature;
                Promoted = true;
                PromotedCategory = Category5;
                Visible = true;
                RunObject = Page "Signatories List";
                RunPageLink = "Account No" = FIELD("No.");
            }
            action("Picture & Signature")
            {
                ApplicationArea = Basic, Suite;
                Image = Signature;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    ProductTypeID: Code[20];
                    IDNumber: Code[20];
                    ImageData: Record "Image Data";
                begin
                    case Rec."Product Category" of
                    end;

                    if Rec."Member No." = '' then
                        IDNumber := ProductTypeID
                    else
                        IDNumber := Rec."Member No.";

                    ImageData.Reset;
                    ImageData.SetRange(ImageData."Member No", IDNumber);
                    if ImageData.Find('-') then begin
                        PAGE.Run(Page::"Member Picture & Signature", ImageData);
                    end;
                end;
            }
            action("Next of KIN")
            {
                ApplicationArea = Basic, Suite;
                Image = Relationship;
                Promoted = true;
                PromotedCategory = Category5;
                RunObject = Page "Next of KIN";
                RunPageLink = "Record ID" = FIELD("Member No.");
                Enabled = not HideAccount;
            }
            action("Fixed Deposit Certificate")
            {
                ApplicationArea = Basic, Suite;
                Enabled = IsFixedDeposit and not HideAccount;
                Image = FixedAssets;
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;


                trigger OnAction()
                begin
                    if Rec."Product Category" <> Rec."Product Category"::"Fixed Deposit" then
                        Error('Only applicable to fixed deposit');

                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange(SavingsAccounts."No.", Rec."No.");
                    //if SavingsAccounts.Find('-') then
                    //REPORT.Run(/*52018504*/52185643, true, false, SavingsAccounts);

                end;
            }
            action(SendText)
            {
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                var
                    SavingsAccounts: Record "Savings Accounts";
                    ReturndFieldName: Text;
                    Separator: Text;
                    Value: Text;
                    WorkString: Text;
                    String1: Text;
                    String2: Text;
                    String3: Text;
                    String4: Text;
                    String5: Text;
                    SetupCode: Text;
                    MsgBodyCode: Text;
                    // RegistrationMngt: Codeunit "Registration Process";
                    // SendSms: Codeunit SendSms;
                    ActualMsg: Text[130];
                    // PeriodicActivities: Codeunit "Periodic Activities";
                    Times: Integer;
                    NumberOccr: Integer;
                    MsgBodyCode2: Text;
                    Pos: Integer;
                    i: Integer;
                    NumberOccr1: Integer;
                begin
                    //Get the Field Name----------|
                    ReturndFieldName := SavingsAccounts.GetSMSFieldName(SavingsAccounts);

                    //STRLEN(DELCHR(ReturndFieldName, '<=>', DELCHR(ReturndFieldName,'<=>', '[')));
                    Times := StrLen(DelChr(ReturndFieldName, '=', DelChr(ReturndFieldName, '=', '[')));

                    //Split the Field Name--------|

                    //IF Times>0 THEN BEGIN
                    //  REPEAT

                    //String1 := PeriodicActivities.Token(ReturndFieldName, '[');
                    if String1 <> '' then begin

                        //Get the Code----------------|
                        SetupCode := SavingsAccounts.GetSMSCode(SavingsAccounts, String1);

                        //Get the SMS Codes-----------|
                        MsgBodyCode := SavingsAccounts.GetSMSFormat();
                        NumberOccr := StrLen(DelChr(MsgBodyCode, '=', DelChr(MsgBodyCode, '=', ']')));
                        //IF NumberOccr=2 THEN



                        NumberOccr1 := NumberOccr;

                        if NumberOccr > 0 then begin
                            repeat
                                Pos := StrPos(MsgBodyCode, '[');
                                MsgBodyCode := DelStr(MsgBodyCode, 1, Pos);
                                Message('After- %1', MsgBodyCode2);

                                ActualMsg := SavingsAccounts.GetAcualSMSFormat();
                                NumberOccr := NumberOccr - 1;
                            until NumberOccr = 0;
                        end;
                        //NumberOccr End..
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
        SetControlApprearance;

        StyleTxt := Rec.SetStyle;
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
        CRMIsCoupledToRecord := CRMIntegrationEnabled and CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RecordId);
        // OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    trigger OnAfterGetRecord()
    begin
        StyleTxt := Rec.SetStyle;
        NewStr := '';
        if StrLen(Rec."ATM No.") > 4 then begin
            Str := (CopyStr(Rec."ATM No.", StrLen(Rec."ATM No.") - 3, 4));
            NewStr := 'xxxxxxxx' + Str;
        end;

        if Members.Get(Rec."Member No.") then begin
            Salutation := Members.Salutation;
        end;
    end;

    trigger OnInit()
    begin
        ContactEditable := true;
        MapPointVisible := true;
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit "Online Map Management";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        Text001: Label 'Message %1';
        Text002: Label 'Message %1';
        GlobalFunctions: Codeunit "Global Functions";
    begin
        GlobalFunctions.FlagAccounts(Rec."Member No.");
        if not MapMgt.TestSetup then
            MapPointVisible := false;

        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
        NewStr := '';
        if StrLen(Rec."ATM No.") > 4 then begin
            Str := (CopyStr(Rec."ATM No.", StrLen(Rec."ATM No.") - 3, 4));
            NewStr := 'xxxxxxxx' + Str;
        end;

        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst() then begin
            if Members.Get(Rec."Member No.") then begin
                if not UserSetup."Show Hidden" then begin
                    if (Members."Account Profile" = Members."Account Profile"::"High Profile") or (Members."Account Profile" = Members."Account Profile"::"Politically Exposed") then
                        Error('You are not allowed to view this account');
                    if Rec."Account Profile" <> Rec."Account Profile"::"Normal Member" then
                        Message('This is a restricted account. By you viewing this account access logs are maintained');
                end;
            end;
        end else
            Error('You are not set up in user setup');


        if Members.Get(Rec."Member No.") then begin
            Salutation := Members.Salutation;
        end;
        AccountAccessLogging;
        CheckMemberInfomation;

        HideAccount := GlobalFunctions.HideAccount(Rec."Member No.");
    end;

    var
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        CalendarMgmt: Codeunit "Calendar Management";
        // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        StyleTxt: Text;

        MapPointVisible: Boolean;

        ContactEditable: Boolean;

        SocialListeningSetupVisible: Boolean;

        SocialListeningVisible: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        IsFixedDeposit: Boolean;
        SavingsAccounts: Record "Savings Accounts";
        Str: Code[30];
        Position: Integer;
        Length: Integer;
        NewStr: Code[30];
        UserSetup: Record "User Setup";
        AccountTypes: Record "Product Factory";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        CommMbora: Decimal;
        IntForf: Integer;
        CountNo: Integer;
        IntBuffer: Record "Interest Buffer";
        InsurancePrem: Decimal;
        LastWithdrawalDate: Date;
        Temp: Record "Banking User Template";
        Jtemplate: Code[10];
        JBatch: Code[10];
        Text0001: Label 'Ensure the Transfer Journal Template is set up in Banking User Setup';
        Text0002: Label 'Ensure the Transfer Journal Batch is set up in Banking User Setup';
        Salutation: Code[10];
        Members: Record Members;
        AccountAccessLog: Record "Account Access Log";

        GlobalFunctions: Codeunit "Global Functions";
        HideAccount: Boolean;

    local procedure SetControlApprearance()
    begin
        //SetSocialListeningFactboxVisibility;
        //ContactEditable := "Primary Contact No." = '';
        if Rec."Product Category" = Rec."Product Category"::"Fixed Deposit" then
            IsFixedDeposit := true
        else
            IsFixedDeposit := false;
    end;

    local procedure ContactOnAfterValidate()
    begin
        SetControlApprearance;
    end;

    local procedure SetSocialListeningFactboxVisibility()
    var
    //SocialListeningMgt: Codeunit "Social Listening Management";
    begin
        /////SocialListeningMgt.GetCustFactboxVisibility(Rec,SocialListeningSetupVisible,SocialListeningVisible);
    end;

    //[Scope('OnPrem')]
    procedure AccountAccessLogging()
    var
        AccountAccessLog: Record "Account Access Log";
    begin
        AccountAccessLog.Init;
        AccountAccessLog.Source := AccountAccessLog.Source::Account;
        AccountAccessLog."Account No." := Rec."No.";
        AccountAccessLog.Date := Today;
        AccountAccessLog."Info Source" := AccountAccessLog."Info Source"::"Savings Card";
        AccountAccessLog.Time := Time;
        AccountAccessLog."User Id" := UserId;
        AccountAccessLog."Account Status" := Format(Rec.Status);
        AccountAccessLog.Insert(true);
    end;

    procedure CheckMemberInfomation()
    var
        LoaneeInfomationBase: Record "Loanee Infomation Base";
    begin
        LoaneeInfomationBase.Reset();
        LoaneeInfomationBase.SetRange("Member No.", Rec."No.");
        LoaneeInfomationBase.SetFilter(Info, '<>%1', '');
        if LoaneeInfomationBase.Find('-') then begin
            repeat
                if (LoaneeInfomationBase."Expiry Date" = 0D) or (LoaneeInfomationBase."Expiry Date" > Today) then
                    Message(LoaneeInfomationBase.Info);
            until LoaneeInfomationBase.Next = 0;
        end;

    end;
}

