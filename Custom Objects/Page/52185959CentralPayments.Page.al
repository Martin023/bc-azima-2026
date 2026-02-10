page 52185959 "Central Payments"
{
    Editable = false;
    PageType = List;
    SourceTable = "Central Payment";
    SourceTableView = WHERE(Status = FILTER(<> Posted));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Paid By"; Rec."Paid By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Date"; Rec."Document Date")
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
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Paid"; Rec."Date Paid")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Last Date-Time Modified"; Rec."Last Date-Time Modified")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Last Modified By ID"; Rec."Last Modified By ID")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Due Date"; Rec."Due Date")
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
            group("&Show")
            {
                Caption = '&Show';
                Image = View;
                action(Document)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Document';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.ShowDocument;
                    end;
                }
                action("<Page Comments>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Funds Mgt Comment Sheet";
                    RunPageLink = "Table Id" = FIELD("Table ID"),
                                  "Document Type" = FIELD("Document Type"),
                                  "Document No." = FIELD("Document No.");
                    RunPageView = SORTING("Table Id", "Document Type", "Document No.");
                }
                action("O&verdue Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'O&verdue Entries';
                    Image = OverdueEntries;

                    trigger OnAction()
                    begin
                        Rec.SetFilter(Status, '%1|%2', Rec.Status::Open, Rec.Status::Canceled);
                        Rec.SetFilter("Due Date", '<%1', Today);
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
            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Post';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    CentralPayment: Record "Central Payment";
                    PaymentHeaderForm: Page "Payment Header";
                    PaymentHeader: Record "Payments Header";
                    PettyCashForm: Page "Cash Payment Header";
                    ImprestHeader: Record "Imprest Header";
                    //    ImprestHeaderForm: Page "Imprest Request Header";
                    StaffAdvance: Record "Staff Advance Header";
                    StaffAdvanceForm: Page "Staff Advance Request";
                begin
                    /*
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                    IF ApprovalEntry.FIND('-') THEN
                      REPEAT
                        ApprovalMgt.ApproveApprovalRequest(ApprovalEntry);
                      UNTIL ApprovalEntry.NEXT = 0;
                    */
                    CurrPage.SetSelectionFilter(CentralPayment);
                    if CentralPayment.Find('-') then
                        repeat
                            case CentralPayment."Table ID" of
                                DATABASE::"Payments Header":
                                    begin
                                        case CentralPayment."Document Type" of
                                            CentralPayment."Document Type"::"Payment Voucher":
                                                begin
                                                    PaymentHeader.Get(CentralPayment."Document No.");
                                                    if PaymentHeader."Cheque No." = '' then PaymentHeader."Cheque No." := Rec."Cheque No.";
                                                    if PaymentHeader."Cheque Type" = 0 then PaymentHeader."Cheque Type" := Rec."Cheque type";
                                                    if PaymentHeader."Payment Release Date" = 0D then PaymentHeader."Payment Release Date" := Rec."Release Date";
                                                    PaymentHeader.Modify;
                                                    PaymentHeaderForm.SetRecord(PaymentHeader);
                                                    PaymentHeaderForm.CheckPVRequiredItems(PaymentHeader);
                                                    PaymentHeaderForm.PostPaymentVoucher(PaymentHeader);
                                                    CentralPayment.Status := CentralPayment.Status::Posted;
                                                    CentralPayment.Modify;
                                                end;

                                            CentralPayment."Document Type"::"Petty Cash":
                                                begin
                                                    PaymentHeader.Get(CentralPayment."Document No.");
                                                    if PaymentHeader."Cheque No." = '' then PaymentHeader."Cheque No." := Rec."Cheque No.";
                                                    if PaymentHeader."Cheque Type" = 0 then PaymentHeader."Cheque Type" := Rec."Cheque type";
                                                    if PaymentHeader."Payment Release Date" = 0D then PaymentHeader."Payment Release Date" := Rec."Release Date";
                                                    PaymentHeader.Modify;
                                                    PettyCashForm.SetRecord(PaymentHeader);
                                                    PettyCashForm.CheckPVRequiredItems(PaymentHeader);
                                                    PettyCashForm.PostPaymentVoucher(PaymentHeader);
                                                    CentralPayment.Status := CentralPayment.Status::Posted;
                                                    CentralPayment.Modify;
                                                end
                                        end
                                    end;

                                DATABASE::"Imprest Header":
                                    begin
                                        ImprestHeader.Get(CentralPayment."Document No.");
                                        if ImprestHeader."Payment Release Date" = 0D then ImprestHeader."Payment Release Date" := Rec."Release Date";
                                        ImprestHeader.Modify;
                                        // ImprestHeaderForm.SetRecord(ImprestHeader);
                                        // ImprestHeaderForm.CheckImprestRequiredItems(ImprestHeader);
                                        // ImprestHeaderForm.PostImprest(ImprestHeader);
                                        CentralPayment.Status := CentralPayment.Status::Posted;
                                        CentralPayment.Modify;
                                    end;

                                DATABASE::"Staff Advance Header":
                                    begin
                                        StaffAdvance.Get(CentralPayment."Document No.");
                                        if StaffAdvance."Payment Release Date" = 0D then StaffAdvance."Payment Release Date" := Rec."Release Date";
                                        StaffAdvance.Modify;
                                        StaffAdvanceForm.SetRecord(StaffAdvance);
                                        StaffAdvanceForm.CheckImprestRequiredItems(StaffAdvance);
                                        StaffAdvanceForm.PostImprest(StaffAdvance);
                                        CentralPayment.Status := CentralPayment.Status::Posted;
                                        CentralPayment.Modify;
                                    end


                                else
                                    exit;
                            end
                        until CentralPayment.Next = 0;

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //REPORT.Run(39005899, false, false);
        Rec.SetRange(DocumentPosted, false);
    end;
}

