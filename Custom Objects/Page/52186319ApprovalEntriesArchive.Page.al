page 52186319 "Approval Entries Archive"
{
    Caption = 'Approval Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Approval Entry Archive";
    SourceTableView = SORTING("Record ID to Approve", "Workflow Step Instance ID", "Sequence No.")
                      ORDER(Ascending);
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                // field(Overdue; Rec.Overdue)
                // {
                //     Caption = 'Overdue';
                //     Editable = false;
                //     ToolTip = 'Overdue Entry';
                // }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Limit Type"; Rec."Limit Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approval Type"; Rec."Approval Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(RecordIDText; RecordIDText)
                {
                    Caption = 'To Approve';
                }
                field(Details; RecordDetails)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sender ID"; Rec."Sender ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Available Credit Limit (LCY)"; Rec."Available Credit Limit (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date-Time Sent for Approval"; Rec."Date-Time Sent for Approval")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Date-Time Modified"; Rec."Last Date-Time Modified")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Modified By User ID"; Rec."Last Modified By User ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            part(Change; "Workflow Change List FactBox")
            {
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                UpdatePropagation = SubPart;
                Visible = ShowChangeFactBox;
                ApplicationArea = Basic, Suite;
            }
            systempart(Control5; Links)
            {
                Visible = false;
                ApplicationArea = Basic, Suite;
            }
            systempart(Control4; Notes)
            {
                Visible = true;
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Show")
            {
                Caption = '&Show';
                Image = View;
                action("Record")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Record';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        rec.ShowRecord();
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalCommentLine: Record "Approval Comment Line";
                    begin
                        ApprovalCommentLine.SetRange("Table ID", Rec."Table ID");
                        ApprovalCommentLine.SetRange("Record ID to Approve", rec."Record ID to Approve");
                        PAGE.Run(PAGE::"Approval Comments", ApprovalCommentLine);
                    end;
                }
                action("O&verdue Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'O&verdue Entries';
                    Image = OverdueEntries;

                    trigger OnAction()
                    begin
                        rec.SetFilter(Status, '%1|%2', Rec.Status::Created, Rec.Status::Open);
                        rec.SetFilter("Due Date", '<%1', Today);
                    end;
                }
                action("All Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'All Entries';
                    Image = Entries;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status);
                        Rec.SetRange("Due Date");
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Delegate")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                // ApprovalsMgmt: Codeunit 1535;
                begin
                    CurrPage.SetSelectionFilter(ApprovalEntry);
                    // ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        //ShowChangeFactBox := CurrPage.Change.PAGE.SetFilterFromApprovalEntry(Rec);
    end;

    trigger OnAfterGetRecord()
    begin
        Overdue := Overdue::" ";
        if FormatField(Rec) then
            Overdue := Overdue::Yes;

        RecordIDText := Format(rec."Record ID to Approve", 0, 1);
    end;

    trigger OnOpenPage()
    begin
        if Usersetup.Get(UserId) then
            rec.SetCurrentKey("Table ID", "Document Type", "Document No.");
    end;

    var
        Usersetup: Record "User Setup";
        Overdue: Option Yes," ";
        RecordIDText: Text;
        ShowChangeFactBox: Boolean;
        RecordDetails: Text;

    //[Scope('OnPrem')]
    procedure Setfilters(TableId: Integer; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocumentNo: Code[20])
    begin
        if TableId <> 0 then begin
            rec.FilterGroup(2);
            rec.SetCurrentKey("Table ID", "Document Type", "Document No.");
            rec.SetRange("Table ID", TableId);
            rec.SetRange("Document Type", DocumentType);
            if DocumentNo <> '' then
                rec.SetRange("Document No.", DocumentNo);
            rec.FilterGroup(0);
        end;
    end;

    local procedure FormatField(ApprovalEntry: Record "Approval Entry Archive"): Boolean
    begin
        if (rec.Status in [rec.Status::Created, rec.Status::Open]) then begin
            if ApprovalEntry."Due Date" < Today then
                exit(true);

            exit(false);
        end;
    end;

    //[Scope('OnPrem')]
    procedure CalledFrom()
    begin
        Overdue := Overdue::" ";
    end;
}

