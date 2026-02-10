page 52185732 "Dividend Simulation Header"
{
    PageType = Document;
    SourceTable = "Dividend Simulation Header";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    Caption = 'Dividend Simulation';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
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
                field("G/L Account"; Rec."G/L Account")
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
                field(Deposits; Rec.Deposits)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Weighted Amount"; Rec."Weighted Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Payout"; Rec."Total Payout")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control1; "Dividend Simulation Lines")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("S&imulation")
            {
                Caption = 'S&imulation';
                Image = "Order";
                action(Dividends)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Simulate Dividends';
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    var
                        DividendPeriod: Integer;
                        DividendAccount: Code[20];
                        ErrDivPeriod: Label 'Dividend Period cannot be Zero';
                        ErrDivAccount: Label 'A Dividend Account is Expected';
                        MsgComplete: Label 'Simulation Complete Enter the Total Amount available to calculate the Dividend Rate ';
                    begin
                        Rec.TestField("Start Date");
                        Rec.TestField("End Date");
                        GetSavingsContribution.getDividendRate(Rec);
                        Message(MsgComplete);
                    end;
                }
                action("A&pprovals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'A&pprovals';
                    Image = Approvals;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page 658;
                    begin
                        //here//ApprovalEntries.SetRecordFilters(DATABASE::Table50019, 0, "No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                }
                action("Calculate Overall Dividends")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Member Dividends';
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = Process;
                }
                // action("Assembly Orders")
                // {
                //     ApplicationArea = Basic, Suite;
                //     AccessByPermission = TableData "BOM Component" = R;
                //     Caption = 'Assembly Orders';
                //     Image = AssemblyOrder;
                //     Promoted = true;
                //     PromotedCategory = Process;

                //     trigger OnAction()
                //     var
                //         AssembleToOrderLink: Record "Assemble-to-Order Link";
                //     begin
                //     end;
                // }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    //  ApprovalsMgmt: Codeunit 1535;
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
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    //  ApprovalsMgmt: Codeunit 1535;
                    begin
                        //  // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    //   ApprovalsMgmt: Codeunit 1535;
                    begin
                        //  ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Remove From Job Queue")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        //CancelBackgroundPosting;
                    end;
                }
                // action("Preview Dividends")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Preview Dividends';
                //     Image = ViewPostedOrder;
                //     Promoted = true;
                //     PromotedCategory = Process;

                //     trigger OnAction()
                //     begin
                //         //ShowPreview;
                //     end;
                // }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlVisibility;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    var
        JobQueueVisible: Boolean;
        //  ApprovalsMgmt: Codeunit 1535;
        GetSavingsContribution: Codeunit "Dividend Process";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;

    //[Scope('OnPrem')]
    procedure SetControlAppearance()
    var
    //  ApprovalsMgmt: Codeunit 1535;
    begin
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    //[Scope('OnPrem')]
    procedure SetControlVisibility()
    var
    // ApprovalsMgmt: Codeunit 1535;
    begin
        //JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

