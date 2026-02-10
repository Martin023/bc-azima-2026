page 52186053 "Overtime Claim List-Cancelled"
{
    CardPageID = "Overtime Claim Header";
    Editable = false;
    PageType = List;
    SourceTable = "Overtime Claim Header";
    SourceTableView = WHERE(Status = CONST(Cancelled));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Claim No"; Rec."Claim No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Overtime Week Days"; Rec."Total Overtime Week Days")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Total Overtime Weekend & Holid"; Rec."Total Overtime Weekend & Holid")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Total Overtime Hrs"; Rec."Total Overtime Hrs")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print/Preview")
            {
                ApplicationArea = Basic, Suite;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);

                    Rec.Reset;
                    Rec.SetFilter("Claim No", Rec."Claim No");
                    //REPORT.Run(39005909, true, true, Rec);
                    Rec.Reset;
                end;
            }
            separator(Action15)
            {
            }
            action("Cancel Document")
            {
                ApplicationArea = Basic, Suite;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Text000: Label 'Are you sure you want to cancel this Document?';
                    Text001: Label 'You have selected not to Cancel the Document';
                begin

                    Rec.TestField(Status, Rec.Status::Approved);
                    if Confirm(Text000, true) then begin
                        Rec.Status := Rec.Status::Cancelled;
                        Rec.Modify;
                    end else
                        Error(Text001);
                end;
            }
            group(Navigate)
            {
                Caption = 'Navigate';
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    //// //ApprovalEntries: Page "Approval Entries";
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*
                        DocumentType := DocumentType::"Payment Voucher";
                        ApprovalEntries.SetRecordFilters(DATABASE::"Payments Header","Document Type","No.");
                        ApprovalEntries.RUN;
                        */
                        // ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId)

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ActivatControls;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();

        ActivatControls;
    end;

    trigger OnOpenPage()
    begin

        if UserMgt.GetPurchasesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FilterGroup(0);
        end;
        ActivatControls;
    end;

    var
        //// //ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TravelConference;
        //DocPrint: Codeunit "Document-Print";
        CheckLedger: Record "Check Ledger Entry";
        CheckManagement: Codeunit CheckManagement;
        HasLines: Boolean;
        ApprovalEntry: Record "Approval Entry";
        UserMgt: Codeunit "User Setup Management BR";
        AllKeyFieldsEntered: Boolean;

    //[Scope('OnPrem')]
    procedure ActivatControls()
    begin
        /*
          IF Status <> Status::Pending THEN BEGIN
                CurrPage.Lines.EDITABLE :=FALSE;
                CurrPage."Responsibility Center".EDITABLE := FALSE;
                CurrPage.Department.EDITABLE := FALSE;
        
                CurrPage.UPDATECONTROLS;
          END ELSE BEGIN
               CurrPage.Lines.EDITABLE :=TRUE;
               CurrPage."Responsibility Center".EDITABLE := TRUE;
                CurrPage.Department.EDITABLE := TRUE;
        
               CurrPage.UPDATECONTROLS;
          END
        */

    end;

    //[Scope('OnPrem')]
    procedure AllFieldsEntered(): Boolean
    var
        OTLines: Record "Overtime Claim Lines";
    begin
        AllKeyFieldsEntered := true;
        OTLines.Reset;
        OTLines.SetRange(OTLines."Claim No", Rec."Claim No");
        if OTLines.Find('-') then begin
            repeat
                if (OTLines."Work Description/Reason" = '') or (OTLines.Amount <= 0) or (OTLines.Date = 0D) then
                    AllKeyFieldsEntered := false;
            until OTLines.Next = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;
}

