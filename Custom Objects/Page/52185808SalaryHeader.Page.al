page 52185808 "Salary Header"
{
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "Salary Header";
    PromotedActionCategories = 'New,Process,Report,Workflows, ,Request Approval,Adjustments';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = TransType;
                }
                field("SMS Charge"; Rec."SMS Charge")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = TransType;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = AccType;
                    ValuesAllowed = "G/L Account";
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = AccNo;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = EmployerC;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = DocNo;
                }
                // field(Month; Rec.Month)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = DocNo;
                // }
                // field(Year; Rec.Year)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = DocNo;

                //     trigger OnValidate()
                //     begin
                //         rec.Remarks := Format(Rec."Employer Code") + ' - ' + Format(rec.Month, 0, '<Month Text>') + ' - '
                //                       + Format(Date2DMY(rec."Posting Date", 3)) + Format(Rec."Income Type");
                //     end;
                // }

                field("Start Date"; Rec."Start Date")
                {

                }
                field("End Date"; Rec."End Date")
                {
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = Amnt;
                }
                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Count"; Rec."Total Count")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Total Posted Count"; Rec."Total Posted Count")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("Last Loan Issue Date"; Rec."Last Loan Issue Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = LastloanDate;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Income Type"; Rec."Income Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = IncType;
                    ValuesAllowed = Salary, Pension;
                }
                field("Posting date"; Rec."Posting date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = Pdate;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Donnot Recover"; Rec."Donnot Recover")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    editable = false;
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    editable = false;

                }
            }
            part(Control17; "Salary Lines")
            {
                SubPageLink = "Salary Header No." = FIELD(No);
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Salaries")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import Salaries';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    SalLines: Record "Salary Lines";
                begin
                    if rec.Posted then error('You cannot import salaries for a posted batch');
                    SalLines.Reset;
                    SalLines.SetRange("Salary Header No.", rec.No);
                    if SalLines.findfirst() then
                        error('You cannot import salaries for a batch that has already been imported. Kindly clear lines first');
                    if rec.status <> rec.status::open then error('Salary batch status must be open');
                    xmlport.Run(XmlPort::"Import Salaries", true, true);
                end;
            }
            group(Process)
            {
                Caption = 'Process';
                // action(Print)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Image = ConfirmAndPrint;
                //     Promoted = true;
                //     PromotedCategory = "Report";
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     begin
                //         Rec.Reset;
                //         Rec.SetFilter(No, Rec.No);
                //         REPORT.Run(report::salary pr, true, true, Rec);
                //     end;
                // }
                action("Net Salary")
                {
                    ApplicationArea = Basic, Suite;
                    Image = ReverseRegister;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Posted, true);
                        Rec.Reset;
                        Rec.SetFilter(No, Rec.No);
                        REPORT.Run(Report::"Net Salary Report", true, true, Rec);
                    end;
                }
                action(Validate)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Translation;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        SalaryLines: Record "Salary Lines";
                        SavingsAccounts: Record "Savings Accounts";
                        StrMenuTxt: Label '&Staff No.,&Account No.,&Member No';
                        Selection: Integer;
                    begin
                        if Rec."Donnot Recover" = false then
                            Rec.TestField("Employer Code");
                        rec.TestField("Posting date");

                        Selection := StrMenu(StrMenuTxt, 3);

                        if Selection = 0 then
                            exit;

                        if Selection = 1 then begin
                            SalaryLines.Reset;
                            SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
                            if SalaryLines.Find('-') then begin
                                repeat
                                    SavingsAccounts.Reset;
                                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"FOSA Account");
                                    SavingsAccounts.SetFilter(SavingsAccounts."Employer Code", Rec."Employer Code");
                                    SavingsAccounts.SetRange(SavingsAccounts."Payroll/Staff No.", SalaryLines."Staff No.");
                                    SavingsAccounts.SetCurrentKey("Product Type");
                                    SavingsAccounts.SetFilter(SavingsAccounts."Product Type", '191');
                                    if SavingsAccounts.Find('-') then begin

                                        SalaryLines."Account Not Found" := false;
                                        //SalaryLines.Posted := false;
                                        SalaryLines.Modify;

                                        if SavingsAccounts."Payroll/Staff No." <> '' then begin
                                            SalaryLines."Account No." := SavingsAccounts."No.";
                                            if SavingsAccounts.Blocked <> SavingsAccounts.Blocked::" " then
                                                SalaryLines."Blocked Accounts" := true
                                            else
                                                SalaryLines."Blocked Accounts" := false;

                                            SalaryLines."ID No." := SavingsAccounts."ID No.";
                                            SalaryLines."Account No." := SavingsAccounts."No.";

                                            SalaryLines.Status := SavingsAccounts.Status;
                                            SalaryLines."Member No." := SavingsAccounts."Member No.";
                                            SalaryLines.Name := SavingsAccounts.Name;
                                            SalaryLines."Employer Code" := SavingsAccounts."Employer Code";
                                            SalaryLines."Global Dimension 1 Code" := SavingsAccounts."Global Dimension 1 Code";
                                            SalaryLines."Global Dimension 2 Code" := SavingsAccounts."Global Dimension 2 Code";
                                            SalaryLines."Posting Date" := Rec."Posting date";
                                            SalaryLines."Posting Time" := Time;
                                            SalaryLines."Actual Date Posted" := Today;
                                        end else
                                            SalaryLines."Account Not Found" := true;
                                        //SalaryLines.Posted := false;
                                        SalaryLines.Modify;
                                        // SavingsAccounts."Salary Through FOSA" := true;
                                        // SavingsAccounts.Modify;
                                    end else
                                        SalaryLines."Account Not Found" := true;
                                    //SalaryLines.Posted := false;
                                    SalaryLines.Modify;
                                until SalaryLines.Next = 0;
                            end;
                        end;

                        if Selection = 2 then begin
                            SalaryLines.Reset;
                            SalaryLines.SetRange(SalaryLines."Salary Header No.", rec.No);
                            if SalaryLines.Find('-') then begin

                                repeat
                                    SavingsAccounts.Reset;
                                    // if Rec."Donnot Recover" = false then
                                    // SavingsAccounts.SetFilter(SavingsAccounts."Employer Code", Rec."Employer Code");
                                    SavingsAccounts.SetRange(SavingsAccounts."No.", SalaryLines."Account No.");
                                    SavingsAccounts.SetFilter(SavingsAccounts."Product Type", '191');
                                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"FOSA Account");
                                    if SavingsAccounts.Find('-') then begin
                                        SalaryLines."Account Not Found" := false;
                                        //SalaryLines.Posted := false;
                                        SalaryLines.Modify;
                                        // SavingsAccounts."Salary Through FOSA" := true;
                                        // SavingsAccounts.Modify;
                                        if SavingsAccounts.Blocked <> SavingsAccounts.Blocked::" " then
                                            SalaryLines."Blocked Accounts" := true
                                        else
                                            SalaryLines."Blocked Accounts" := false;
                                        SalaryLines."ID No." := SavingsAccounts."ID No.";
                                        SalaryLines."Account No." := SavingsAccounts."No.";
                                        SalaryLines.Status := SavingsAccounts.Status;
                                        SalaryLines."Member No." := SavingsAccounts."Member No.";
                                        SalaryLines.Name := SavingsAccounts.Name;
                                        SalaryLines."Employer Code" := SavingsAccounts."Employer Code";
                                        SalaryLines."Global Dimension 1 Code" := SavingsAccounts."Global Dimension 1 Code";
                                        SalaryLines."Global Dimension 2 Code" := SavingsAccounts."Global Dimension 2 Code";
                                        //SalaryLines.Posted := false;
                                        SalaryLines."Posting Date" := Rec."Posting date";
                                        SalaryLines."Posting Time" := Time;
                                        SalaryLines."Actual Date Posted" := Today;
                                    end else
                                        SalaryLines."Account Not Found" := true;
                                    //SalaryLines.Posted := false;
                                    SalaryLines.Modify;
                                until SalaryLines.Next = 0;
                            end;
                        end;
                        if Selection = 3 then begin
                            SalaryLines.Reset;
                            SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
                            if SalaryLines.Find('-') then begin
                                repeat
                                    SavingsAccounts.Reset;
                                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", SalaryLines."Member No.");
                                    SavingsAccounts.SetFilter(SavingsAccounts."Product Type", '191');
                                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"FOSA Account");
                                    if SavingsAccounts.Find('-') then begin

                                        SalaryLines."Account Not Found" := false;
                                        //SalaryLines.Posted := false;
                                        SalaryLines.Modify;

                                        if SavingsAccounts."ID No." <> '' then begin
                                            if SavingsAccounts.Blocked <> SavingsAccounts.Blocked::" " then
                                                SalaryLines."Blocked Accounts" := true
                                            else
                                                SalaryLines."Blocked Accounts" := false;

                                            SalaryLines."ID No." := SavingsAccounts."ID No.";
                                            SalaryLines."Account No." := SavingsAccounts."No.";
                                            SalaryLines.Status := SavingsAccounts.Status;
                                            SalaryLines."Member No." := SavingsAccounts."Member No.";
                                            SalaryLines.Name := SavingsAccounts.Name;
                                            SalaryLines."Employer Code" := SavingsAccounts."Employer Code";
                                            SalaryLines."Global Dimension 1 Code" := SavingsAccounts."Global Dimension 1 Code";
                                            SalaryLines."Global Dimension 2 Code" := SavingsAccounts."Global Dimension 2 Code";
                                            SalaryLines."Posting Date" := Today;
                                            SalaryLines."Posting Time" := Time;
                                            SalaryLines."Actual Date Posted" := Today;
                                        end else
                                            SalaryLines."Account Not Found" := true;
                                        //SalaryLines.Posted := false;
                                        SalaryLines.Modify;

                                        //   SavingsAccounts."Salary Through FOSA" := true;
                                        //   SavingsAccounts.Modify;
                                    end else
                                        SalaryLines."Account Not Found" := true;
                                    //SalaryLines.Posted := false;
                                    SalaryLines.Modify;


                                until SalaryLines.Next = 0;
                            end;
                        end;

                        Rec.Validated := true;
                        Rec.Modify;
                        Message('Salary Lines Validated sucessfully');
                    end;
                }
                action("Check for Mutiple Salaries")
                {
                    ApplicationArea = Basic, Suite;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    var
                        SalaryLines: Record "Salary Lines";
                    begin

                        SalaryLines.Reset;
                        SalaryLines.SetRange(SalaryLines."Salary Header No.", rec.No);
                        if SalaryLines.Find('-') then
                            REPORT.Run(Report::"Check Mutiple Salary", true, false, SalaryLines);
                    end;
                }
                action("Clear Unvalidated Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Translation;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        rec.TestField(Posted, false);
                        //rec.TestField(Status, rec.Status::Open);
                        SalaryLines.Reset;
                        SalaryLines.SetRange(SalaryLines."Salary Header No.", rec.No);
                        SalaryLines.SetRange("Account Not Found", true);
                        if SalaryLines.Find('-') then
                            repeat
                                SalaryLines.Delete();
                            until SalaryLines.Next() = 0;
                    end;
                }
            }
            group(Action22)
            {
                //Caption = 'Post Bulk';
                // action(Post)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Image = Post;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     Enabled = false;

                //     trigger OnAction()
                //     var
                //         SaccoT: Codeunit "Sacco Transactions";
                //         GenSetup: record "General Set-Up";
                //     begin
                //         SalaryLines.Reset;
                //         SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
                //         if SalaryLines.FindSet() then begin
                //             repeat
                //                 if SalaryLines."Multiple Salary" = true then begin
                //                     Error('Kinldy reconcile all the Multiple accounts for this employer before proceeding');
                //                 end;
                //             until
                //             SalaryLines.Next = 0;
                //         end;
                //         if Rec.Status <> Rec.Status::Approved then
                //             Error('The salary batch has not been approved');
                //         GenSetup.Get();
                //         if GenSetup."Disable Salary SMS" = true then begin
                //             if not Confirm('Salary SMS has been disabled, do you wish to proceed without notifications to members?') then exit;
                //         end;
                //         if Confirm('Are you sure you want to post Salaries?', false) = false then
                //             exit;
                //         SaccoT.PostSalary(Rec, true);
                //     end;
                // }
                action(PostLineByline)
                {
                    ApplicationArea = Basic, Suite;
                    Image = PostApplication;
                    Promoted = true;
                    PromotedCategory = Process;
                    Caption = 'Post';

                    trigger OnAction()
                    var
                        SaccoT: Codeunit "Sacco Transactions";
                        GenSetup: record "General Set-Up";
                    begin
                        SalaryLines.Reset;
                        SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
                        if SalaryLines.FindSet() then begin
                            repeat
                                if SalaryLines."Multiple Salary" = true then begin
                                    Error('Kinldy reconcile all the Multiple accounts for this employer before proceeding');
                                end;
                            until
                            SalaryLines.Next = 0;
                        end;
                        if Rec.Status <> Rec.Status::Approved then
                            Error('The salary batch has not been approved');
                        GenSetup.Get();
                        if GenSetup."Disable Salary SMS" = true then begin
                            if not Confirm('Salary SMS has been disabled, do you wish to proceed without notifications to members?') then exit;
                        end;
                        if Confirm('Are you sure you want to post Salaries?', false) = false then
                            exit;
                        SaccoT.PostSalaryLineByLine(Rec);
                    end;

                }
                // action(SendToJournal)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Image = Post;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     Enabled = false;

                //     trigger OnAction()
                //     var
                //         SaccoT: Codeunit "Sacco Transactions";
                //         GenSetup: record "General Set-Up";
                //     begin
                //         SalaryLines.Reset;
                //         SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
                //         if SalaryLines.FindSet() then begin
                //             repeat
                //                 if SalaryLines."Multiple Salary" then
                //                     Error('Kinldy reconcile all the Multiple accounts for this employer before proceeding');
                //                 if SalaryLines."Account Not Found" then Error('Kinldy reconcile all accounts not found for this employer before proceeding');
                //             until
                //             SalaryLines.Next = 0;
                //         end;
                //         if Rec.Status <> Rec.Status::Approved then
                //             Error('The salary batch has not been approved');
                //         // GenSetup.Get();
                //         // if GenSetup."Disable Salary SMS" = true then begin
                //         //     if not Confirm('Salary SMS has been disabled, do you wish to proceed without notifications to members?') then exit;
                //         // end;
                //         SaccoT.PostSalary(Rec, false);
                //     end;
                // }
                action(SendSMS)
                {
                    ApplicationArea = Basic, Suite;
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    //Enabled = false;

                    trigger OnAction()
                    var
                        SaccoT: Codeunit "Sacco Transactions";
                        GenSetup: record "General Set-Up";
                        Account: Record "Savings Accounts";
                        MobileNo: code[50];
                        Memb: Record Members;
                        Text0005: label 'Your Salary of KES. ';
                        Text0006: label ' has been credited to your FOSA account ';
                        Text0007: label ' on ';
                        Text0008: text;
                        msg: text;
                        SendSMS: Codeunit SendSms;
                        Source: enum "SMS Source";
                        GlobalFunctions: Codeunit "Global Functions";
                    begin
                        if Rec.Status <> Rec.Status::Approved then
                            Error('The salary batch has not been approved');
                        if not rec.Posted then Error('This Salary Batch is not posted');
                        if Confirm('Are you sure you want to send Salary SMS?', false) = false then
                            exit;
                        SalaryLines.Reset;
                        SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
                        if SalaryLines.FindSet() then begin
                            repeat
                                if Account.get(SalaryLines."Account No.") then begin
                                    MobileNo := Account."Mobile Phone No";
                                    if MobileNo = '' then begin
                                        if Memb.get(Account."Member No.") then
                                            MobileNo := Memb."Phone No.";
                                    end;
                                    Text0008 := Gensetup."Salary SMS Suffix";
                                    msg := Text0005 + Format(SalaryLines.Amount) + Text0006 + Text0007 + SaccoT.ddMMyyyy(Today) + ' ' + Format(Time) + '. Your new Ordinary account balance is KES ' + Format(GlobalFunctions.GetSavingsAccountAvailableBalance(Account, true));

                                    SendSMS.SendSms(Source::SALARY_PROCESSING, MobileNo, msg, Format(SalaryLines."Account No."), '', true, 0, false, 'CBS', SalaryLines."Account No.", 'CBS');
                                end;
                            until
                            SalaryLines.Next = 0;
                        end;

                    end;
                }
                action(MarkSalaryAsPosted)
                {
                    //Enabled = false;
                    trigger OnAction()
                    var
                        SalLines: record "Salary Lines";
                        SavingsLedgerEntry: record "Savings Ledger Entry";
                        SalHeaD: record "Salary Header";
                        STOHEAD: record "Standing Order Header";
                        STOline: Record "Standing Order Lines";
                        Loans: record Loans;
                        Cleared: Boolean;
                    begin
                        SalHeaD.get(rec.No);
                        //if not SalHeaD."Sent to Journal" then Error('This Batch has not been sent to journal');
                        SalLines.Reset;
                        SalLines.SetRange(SalLines."Salary Header No.", SalHeaD.No);
                        SalLines.SetRange(Posted, false);
                        if SalLines.FindSet() then begin
                            repeat
                                SavingsLedgerEntry.reset;
                                SavingsLedgerEntry.SetCurrentKey("Document No.", "Posting Date", "Customer No."); // Use indexed fields if possible
                                SavingsLedgerEntry.SetRange("Document No.", SalHeaD.No);
                                SavingsLedgerEntry.SetRange("Posting Date", SalHeaD."Posting date");
                                SavingsLedgerEntry.SetRange("Customer No.", SalLines."Account No.");
                                if SavingsLedgerEntry.Find('-') then begin
                                    SalLines."Posting Date" := SalHeaD."Posting date";
                                    SalLines.Posted := true;
                                    SalLines.Modify;
                                end;
                            until SalLines.Next = 0;
                        end;
                        SalLines.Reset;
                        SalLines.SetRange(SalLines."Salary Header No.", SalHeaD.No);
                        SalLines.SetRange(Posted, false);
                        if not SalLines.findfirst then begin
                            SalHeaD.Posted := true;
                            SalHeaD."Posted By" := UserId;
                            SalHeaD.Modify;
                            Message('Salaries posted successfully');
                            exit;
                        end;
                        SalLines.Reset;
                        SalLines.SetRange(SalLines."Salary Header No.", SalHeaD.No);
                        SalLines.SetRange(Posted, false);
                        if SalLines.findfirst then begin
                            repeat
                                SalLines."Posting Date" := SalHeaD."Posting date";
                                SalLines.Posted := true;
                                SalLines.Modify;
                            until salLines.Next() = 0;
                        end;
                        SalHeaD.Posted := true;
                        SalHeaD."Posted By" := UserId;
                        SalHeaD.Modify;

                        // Close completed standng orders
                        Cleared := false;
                        STOHEAD.reset;
                        STOHEAD.SetRange(Status, STOHEAD.Status::Approved);
                        if STOHEAD.FindSet() then begin
                            // TO DO - close;
                            // repeat
                            //     STOline.Reset();
                            //     STOline.setrange("Document No.", STOHEAD."No.");
                            //     STOLine.SetRange("Destination Account Type", STOLine."Destination Account Type"::Credit);
                            //     if STOline.findset()
                            //     then begin
                            //         Cleared := true;
                            //         if Loans.Get(STOline."Loan No.") then begin
                            //             Loans.CalcFields("Total Balance");
                            //             if Loans."Total Balance" > 0 then begin
                            //                 Cleared := false;
                            //             end;
                            //         end;
                            //     end;
                            // until STOHEAD.Next() = 0;
                            // if Cleared then begin
                            //     STOHEAD.Status := STOHEAD.Status::Stopped;
                            //     STOHEAD.Modify;
                            // end;
                        end;
                        Message('Salary lines have successfully been marked as posted.');

                    end;
                }
            }

            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        if Rec.Status <> Rec.Status::Open then
                            Error(DocMustbeOpen);
                        if rec."Income Type" = rec."Income Type"::" " then Error('Kindly set the correct income type before proceeding!');

                        Rec.TestField("Transaction Type");
                        Rec.TestField("Document No");
                        Rec.TestField(Remarks);
                        Rec.TestField(Amount);
                        if Rec."Donnot Recover" = false then begin
                            Rec.TestField("Employer Code");
                            Rec.TestField("Last Loan Issue Date");
                        end;
                        Rec.TestField("Posting date");
                        Rec.TestField("Account No");
                        Rec.TestField("SMS Charge");

                        Rec.CalcFields("Scheduled Amount");

                        if Rec.Validated = false then
                            Error('Kinldy validate the salary batch before proceeding');

                        if Rec."Mutiple Salaries Checked" = false then
                            Error('Kindly check for multiple salaries before proceeding');

                        if Rec."Scheduled Amount" <> Rec.Amount then
                            Error('Scheduled amount and Amount must be the same');


                        SalaryLines.Reset;
                        SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
                        if SalaryLines.Find('-') then begin
                            repeat
                                if SalaryLines."Account Not Found" = true then begin
                                    Error('Kinldy reconcile all the unfound accounts for this employer before proceeding');
                                end;
                                if SalaryLines."Posting Date" <> rec."Posting date" then
                                    Error('kindly Validate the lines again to update the posting dates to match header & lines');
                            until
                            SalaryLines.Next = 0;
                        end;



                        SalaryLines.Reset;
                        SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
                        if SalaryLines.Find('-') then begin
                            repeat
                                if SalaryLines."Multiple Salary" = true then begin
                                    Error('Kinldy reconcile all the Multiple accounts for this employer before proceeding');
                                end;
                            until
                            SalaryLines.Next = 0;
                        end;


                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);

                        CurrPage.Close();
                    end;
                }
                action("Re-Open ")
                {
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        if rec.Posted = false then begin
                            rec.Status := rec.Status::Open;
                            rec.Modify;
                            Message('Document open successfuly');
                        end
                        else
                            Error('This document has already been posted.');
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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        if Rec.Status <> Rec.Status::Pending then
                            Error(DocMustbePending);

                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Visible = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;

                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Income Type" := rec."Income Type"::Salary;
    end;

    trigger OnAfterGetCurrRecord()
    begin

        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;

    trigger OnAfterGetRecord()
    begin
        //SetControlAppearance;
        UpdateControl;

        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;

    trigger OnInit()
    begin
        UpdateControl;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin

        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        DocMustbeOpen: Label 'This application request must be open';
        DocMustbePending: Label 'This application request must be Pending';
        TransType: Boolean;
        AccType: Boolean;
        AccNo: Boolean;
        DocNo: Boolean;
        Rmarks: Boolean;
        Amnt: Boolean;
        EmployerC: Boolean;
        IncType: Boolean;
        Pdate: Boolean;
        SalaryLines: Record "Salary Lines";
        LastloanDate: Boolean;

    local procedure SetControlAppearance()
    begin
        message('approvals here');
    end;

    // var
    //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    // begin

    //    OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
    //     OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    // end;
    procedure UpdateControl()
    begin

        if Rec.Status = Rec.Status::Open then begin
            AccNo := true;
            TransType := true;
            AccType := true;
            DocNo := true;
            Rmarks := true;
            Amnt := true;
            EmployerC := true;
            Pdate := true;
            IncType := true;
            LastloanDate := true;

        end;


        if Rec.Status = Rec.Status::Pending then begin
            AccNo := false;
            TransType := false;
            AccType := false;
            DocNo := false;
            Rmarks := false;
            Amnt := false;
            EmployerC := false;
            Pdate := false;
            IncType := false;
            LastloanDate := false;

        end;


        if Rec.Status = Rec.Status::Rejected then begin
            AccNo := false;
            TransType := false;
            AccType := false;
            DocNo := false;
            Rmarks := false;
            Amnt := false;
            EmployerC := false;
            Pdate := false;
            IncType := false;
            LastloanDate := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            AccNo := false;
            TransType := false;
            AccType := false;
            DocNo := false;
            Rmarks := false;
            Amnt := false;
            EmployerC := false;
            Pdate := false;
            IncType := false;
            LastloanDate := false;

        end;
    end;
}

