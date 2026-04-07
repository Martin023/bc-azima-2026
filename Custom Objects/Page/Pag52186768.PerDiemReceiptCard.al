namespace KenpipeCBS.KenpipeCBS;
using System.Automation;

page 52186768 "Per-Diem Receipt Card"
{
    Caption = 'Per-Diem/Claims Payment Card';
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
                }
                field("SMS Charge"; Rec."SMS Charge")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    ValuesAllowed = "Bank Account";
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("Document No"; Rec."Document No")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = DocNo;
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


                field("Income Type"; Rec."Income Type")
                {
                    ApplicationArea = Basic, Suite;
                    ValuesAllowed = SAYE, Claims;
                }
                field("Posting date"; Rec."Posting date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic, Suite;
                    editable = false;

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
            part(Control17; "Per-Diem Lines")
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
                Caption = 'Import Per Diems';
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

                // action("Net Salary")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Image = ReverseRegister;
                //     Promoted = true;
                //     PromotedCategory = "Report";
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     begin
                //         Rec.TestField(Posted, true);
                //         Rec.Reset;
                //         Rec.SetFilter(No, Rec.No);
                //         REPORT.Run(Report::"Net Salary Report", true, true, Rec);
                //     end;
                // }
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
                                    SalaryLines.TestField("Document No.");
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
                                    SalaryLines.TestField("Document No.");

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
                                    SalaryLines.TestField("Document No.");

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
                // action("Check for Mutiple Salaries")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Image = "Report";
                //     Promoted = true;
                //     PromotedCategory = "Report";

                //     trigger OnAction()
                //     var
                //         SalaryLines: Record "Salary Lines";
                //     begin

                //         SalaryLines.Reset;
                //         SalaryLines.SetRange(SalaryLines."Salary Header No.", rec.No);
                //         if SalaryLines.Find('-') then
                //             REPORT.Run(Report::"Check Mutiple Salary", true, false, SalaryLines);
                //     end;
                // }
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
                        GenSetup.Get();
                        if GenSetup."Disable Salary SMS" = true then begin
                            if not Confirm('Per diem, SMS has been disabled, do you wish to proceed without notifications to members?') then exit;
                        end;
                        if Confirm('Are you sure you want to post?', false) = false then
                            exit;
                        SaccoT.PostPerDiem(Rec);
                    end;

                }

            }

            // group("Request Approval")
            // {
            //     Caption = 'Request Approval';
            //     action(SendApprovalRequest)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Send A&pproval Request';
            //         Enabled = NOT OpenApprovalEntriesExist;
            //         Image = SendApprovalRequest;
            //         Promoted = true;
            //         PromotedCategory = Category4;

            //         trigger OnAction()
            //         var
            //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //         begin

            //             if Rec.Status <> Rec.Status::Open then
            //                 Error(DocMustbeOpen);
            //             if rec."Income Type" = rec."Income Type"::" " then Error('Kindly set the correct income type before proceeding!');

            //             Rec.TestField("Transaction Type");
            //             Rec.TestField("Document No");
            //             Rec.TestField(Remarks);
            //             Rec.TestField(Amount);
            //             if Rec."Donnot Recover" = false then begin
            //                 Rec.TestField("Employer Code");
            //                 Rec.TestField("Last Loan Issue Date");
            //             end;
            //             Rec.TestField("Posting date");
            //             Rec.TestField("Account No");
            //             //Rec.TestField("Account Name");

            //             Rec.CalcFields("Scheduled Amount");

            //             if Rec.Validated = false then
            //                 Error('Kinldy validate the salary batch before proceeding');

            //             if Rec."Mutiple Salaries Checked" = false then
            //                 Error('Kindly check for multiple salaries before proceeding');

            //             if Rec."Scheduled Amount" <> Rec.Amount then
            //                 Error('Scheduled amount and Amount must be the same');


            //             SalaryLines.Reset;
            //             SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
            //             if SalaryLines.Find('-') then begin
            //                 repeat
            //                     if SalaryLines."Account Not Found" = true then begin
            //                         Error('Kinldy reconcile all the unfound accounts for this employer before proceeding');
            //                     end;
            //                     if SalaryLines."Posting Date" <> rec."Posting date" then
            //                         Error('kindly Validate the lines again to update the posting dates to match header & lines');
            //                 until
            //                 SalaryLines.Next = 0;
            //             end;



            //             SalaryLines.Reset;
            //             SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
            //             if SalaryLines.Find('-') then begin
            //                 repeat
            //                     if SalaryLines."Multiple Salary" = true then begin
            //                         Error('Kinldy reconcile all the Multiple accounts for this employer before proceeding');
            //                     end;
            //                 until
            //                 SalaryLines.Next = 0;
            //             end;


            //             VarVariant := Rec;
            //             if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
            //                 CustomApprovals.OnSendDocForApproval(VarVariant);

            //             CurrPage.Close();
            //         end;
            //     }
            //     action("Re-Open ")
            //     {
            //         Image = ReOpen;
            //         Promoted = true;
            //         PromotedCategory = Category4;
            //         PromotedIsBig = true;
            //         ApplicationArea = Basic, Suite;

            //         trigger OnAction()
            //         begin
            //             if rec.Posted = false then begin
            //                 rec.Status := rec.Status::Open;
            //                 rec.Modify;
            //                 Message('Document open successfuly');
            //             end;
            //         end;
            //     }
            //     action(CancelApprovalRequest)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Cancel Approval Re&quest';
            //         Enabled = OpenApprovalEntriesExist;
            //         Image = Cancel;
            //         Promoted = true;
            //         PromotedCategory = Category4;

            //         trigger OnAction()
            //         var
            //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //         begin

            //             if Rec.Status <> Rec.Status::Pending then
            //                 Error(DocMustbePending);

            //             VarVariant := Rec;
            //             CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
            //         end;
            //     }
            //     action(Approvals)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Approvals';
            //         Image = Approvals;
            //         Visible = true;

            //         trigger OnAction()
            //         var
            //             ApprovalEntries: Page "Approval Entries";
            //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //         begin
            //             ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
            //         end;

            //     }
            // }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        if Rec.Posted then
            CurrPage.Editable := false;
    end;

    trigger OnAfterGetRecord()
    begin
        if Rec.Posted then
            CurrPage.Editable := false;
    end;



    trigger OnNextRecord(Steps: Integer): Integer
    begin

        if Rec.Posted then
            CurrPage.Editable := false;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Posted then
            CurrPage.Editable := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Income Type" := rec."Income Type"::SAYE;
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

}