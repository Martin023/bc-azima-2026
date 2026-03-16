page 52187100 "Staff Welfare "
{
    ApplicationArea = All;
    Caption = 'Staff Welfare ';
    PageType = Card;
    SourceTable = "Staff Welfare";
    PromotedActionCategories = ',,,,,,,,Approvals';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Payroll No"; Rec."Payroll No")
                {

                    ToolTip = 'Specifies the value of the Payroll No field.';
                }

                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }

                field("Pin No"; Rec."Pin No")
                {
                    ToolTip = 'Specifies the value of the Pin No field.';
                }
                field(Beneficiary; Rec.Beneficiary)
                {
                    ToolTip = 'Specifies the value of the Beneficiary field.';
                }
                field(Relationship; Rec.Relationship)
                {
                    ToolTip = 'Specifies the value of the Relationship field.';
                }
                field("Claim reason"; Rec."Claim reason")
                {
                    ToolTip = 'Specifies the value of the Claim reason field.';
                }
                field("Claim Amount"; Rec."Claim Amount")
                {

                }
                field(Status; Rec.Status)
                {

                }
                field(Comments; Rec.Comments)
                {

                }
                field(Posted; Rec.Posted)
                {

                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = basic;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(52187100),
                "No." = field(No);

            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Send Approval Request")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category9;

                trigger OnAction()

                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);


                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category9;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    if Rec.Status <> Rec.Status::"Pending Approval" then
                        Error(DocMustbePending);

                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category9;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action(Defer)
            {
                ApplicationArea = All;
                Caption = 'Defer';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    rec.TestField(Comments);
                    Rec.Status := Rec.Status::Deferred;
                    MESSAGE('Record Deferred');
                end;
            }
            action(Post)
            {
                ApplicationArea = All;
                Caption = 'Post';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    StaffWelfare: record "Staff Welfare";
                begin
                    Rec.TestField(Status, Rec.status::Approved);
                    if rec.posted = true then exit;

                    PostStaffWelfare(Rec);
                    Message('Transaction Posted Successfully');

                end;
            }
        }

    }
    trigger OnOpenPage()
    begin
        if rec.Status = rec.Status::Approved then begin
            CurrPage.Editable := false;
        end;
    end;

    var
        VarVariant: Variant;
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";

    procedure PostStaffWelfare(Var StaffWelfare: record "Staff Welfare")
    var
        myInt: Integer;
        LoanRec: Record Loans;

        SaccoTrans: Codeunit "Sacco Transactions";
        Jtemplate: Code[20];
        JBatch: Code[20];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        AcctNo: Code[20];
        Desc: Text[150];
        BalAcctType: Enum "Gen. Journal Account Type";
        BalAcctNo: Code[20];
        Amt: Decimal;
        ExtDocNo: Code[20];
        Loan: Code[20];
        TransType: enum "Transaction Types";
        Dim1: Code[20];
        Dim2: Code[20];
        SystemCreated: Boolean;
        UserSetup: Record "User Setup";
        Capitalized: Decimal;
        ProductFactory: Record "Product Factory";
        Temp: record "Banking User Template";
        SavingsAcc: record "Savings Accounts";
        HrSetup: record "HR Setup";
    begin
        StaffWelfare.Reset();
        StaffWelfare.SetRange(No, rec.No);
        if StaffWelfare.FindFirst() then begin
            SavingsAcc.Reset();
            SavingsAcc.SetRange("Payroll/Staff No.", StaffWelfare."Employee Code");
            SavingsAcc.setrange("Product Category", SavingsAcc."Product Category"::"FOSA Account");
            If SavingsAcc.FindFirst() then begin


                Temp.Get(UserId);

                // Jtemplate := Temp."Staff Welfare Template";
                // JBatch := Temp."Staff Welfare Batch";
                Jtemplate := Temp."Loans Template";
                JBatch := Temp."Loans Batch";

                UserSetup.Get(UserId);
                Dim1 := UserSetup."Global Dimension 1 Code";
                Dim2 := UserSetup."Global Dimension 2 Code";
                DocNo := StaffWelfare.No;
                ExtDocNo := StaffWelfare.No;
                PDate := Today;
                Desc := Format(StaffWelfare."Claim reason");
                Amt := StaffWelfare."Claim Amount";
                AcctNo := SavingsAcc."No.";
                BalAcctNo := ProductFactory."Loan Interest Account [G/L]";
                SaccoTrans.InitJournal(Jtemplate, JBatch);
                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::Savings, AcctNo, Desc, BalAcctType::"G/L Account",
                                        '', -Amt, ExtDocNo, LoanRec."Loan No.", TransType::" ", Dim1, Dim2, SystemCreated);
                HrSetup.Get();
                HrSetup.TestField("Staff Welfare G/L ");
                AcctNo := HrSetup."Staff Welfare G/L ";
                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType::"G/L Account", AcctNo, Desc, BalAcctType::"G/L Account",
                                        '', Amt, ExtDocNo, '', TransType::" ", Dim1, Dim2, SystemCreated); //4708138300
                SaccoTrans.PostJournal(Jtemplate, JBatch);

                StaffWelfare.ModifyAll(Posted, true);
            end;
        end;


    end;




}
