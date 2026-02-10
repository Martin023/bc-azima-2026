page 52186117 "Approved Contract Details Card"
{
    Editable = false;
    PageType = Document;
    SourceTable = Contracts;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Contract No"; Rec."Contract No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
                {
                    Caption = 'Contract  Date';
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contractor Type"; Rec."Contractor Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contractor No"; Rec."Contractor No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contractor Name"; Rec."Contractor Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Tel No."; Rec."Tel No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Advocate Name"; Rec."Advocate Name")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Review Interval"; Rec."Renewal Clause")
                {
                    Caption = 'Monitoring Interval';
                    ApplicationArea = Basic, Suite;
                }
                field("Nature Of Service"; Rec."Nature Of Service")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Type Of Service"; Rec."Type Of Service")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Defect Liability Period"; Rec."Defect Liability Period")
                {
                    Editable = DefectLiabilityPeriodeditable;
                    ApplicationArea = Basic, Suite;
                }
                field("Support Period"; Rec."Support Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Warranty Period"; Rec."Warranty Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsible Employee"; Rec."Responsible Employee")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contract Description"; Rec."Contract Description")
                {
                    Caption = 'Contract Status';
                }
                field("Contract Amount"; Rec."Contract Sum")
                {
                    Editable = true;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Balance"; Rec."Total Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Others; "Contract Lines")
            {
                SubPageLink = "Document No." = FIELD("Contract No");
                Visible = true;
                ApplicationArea = Basic, Suite;
            }
            part("Contract Milestone Entries"; Milestones)
            {
                SubPageLink = "Contract No" = FIELD("Contract No");
                ApplicationArea = Basic, Suite;
            }
            field("Termination Reason"; Rec."Termination Reason")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Expectation)
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "Contract Expectation Details-L";
            }
            action(Contract)
            {
                ApplicationArea = Basic, Suite;
            }
            action("Contract Renewal")
            {
                ApplicationArea = Basic, Suite;
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Category10;
                PromotedIsBig = true;
                Scope = Page;

                trigger OnAction()
                begin

                    // IF "Contract Description"<>"Contract Description"::"1" THEN BEGIN
                    // CopyContr."Contractor Type":="Contractor Type";
                    // CopyContr."Renewed Contract":=TRUE;
                    // CopyContr."Contractor No":="Contractor No";
                    // CopyContr."Contractor Name":="Contractor Name";
                    // CopyContr.Address:=Address;
                    // CopyContr."Tel No.":="Tel No.";
                    // CopyContr."Contact Person":="Contact Person";
                    // CopyContr."Start Date":="Start Date";
                    // CopyContr."End Date":= "End Date";
                    // CopyContr."Contract Description":="Contract Description";
                    // CopyContr."Contract Duration":= "Contract Duration";
                    // CopyContr."Contract Type":="Contract Type";
                    // CopyContr."Contract Line":="Contract Line";
                    // CopyContr."Contract Amount":="Contract Amount";
                    // //CopyContr.Balance:=
                    // CopyContr."Asset/Service No":="Asset/Service No";
                    // CopyContr."Contract Cycle":= "Contract Cycle";
                    // CopyContr."Renewal No":="Contract No";
                    // CopyContr.INSERT(TRUE);
                    //
                    // "Renewal No":=CopyContr."Contract No";
                    // MODIFY;
                    // END ELSE
                    //   ERROR('The Contract is already Closed');
                end;
            }
            action("Contract Type")
            {
                RunObject = Page "Nature Of Services";
                // RunPageLink = Field4 = FIELD("Contract No");
                ApplicationArea = Basic, Suite;
            }
            action("Contract Cycle")
            {
                RunObject = Page "Contract Cycle";
                RunPageLink = Code = FIELD("Contract No");
                ApplicationArea = Basic, Suite;
            }
            action("Co&mments")
            {
                RunObject = Page "Comment Sheet";
                ApplicationArea = Basic, Suite;
            }
            action("Update Contract Milestone")
            {
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                begin
                    //
                    // ContMilestones.RESET;
                    // ContMilestones.SETRANGE(ContMilestones."Contract No","Contractor No");
                    //
                    //
                    //  LastStage:=FALSE;
                    //  Invoiced:=FALSE;
                    //  IF "Contract Description"<>"Contract Description"::"1" THEN
                    //     ERROR('The Contract should be Active for you to update the Milestones');
                    //  IF CONFIRM('Are you sure you would like to Update to Next MileStone?',FALSE)= TRUE THEN BEGIN
                    //    IF "Contract Cycle"='' THEN
                    //       ERROR('Enter a Contract Cycle/Contract Type Details');
                    //
                    //     ContMilestones.RESET;
                    //     ContMilestones.SETRANGE(ContMilestones."Contract No","Contract No");
                    //     ContMilestones.SETRANGE(ContMilestones." Committee Remarks",TRUE);
                    //     //If there exists records in contract milestone table then check wat stage and update with next
                    //     IF ContMilestones.FIND('-') THEN BEGIN
                    //        StageNo:=ContMilestones."Milestone Stage";
                    //        ContMilestones." Committee Remarks":=FALSE;
                    //        ContMilestones.MODIFY;
                    //        //Check whether Expectations Met for previous Stage
                    //         Expectations.RESET;
                    //         Expectations.SETRANGE(Expectations."Contract No","Contract No");
                    //         Expectations.SETRANGE(Expectations."Cycle Stage",StageNo);
                    //         Expectations.SETRANGE(Expectations.Done,FALSE);
                    //         IF Expectations.FIND('-') THEN
                    //            ERROR('There are Expectations for Stage No. %1 not met Ensure they are met first',StageNo);
                    //
                    //        //Check if payment was expected and whether there exists any invoice details
                    //            AllStages.RESET;
                    //            AllStages.SETRANGE(AllStages."Contract No","Contract No");
                    //            AllStages.SETRANGE(AllStages."Cycle Stage",StageNo);
                    //            IF AllStages.FIND('-') THEN BEGIN
                    //              IF AllStages."Payment Expected"=AllStages."Payment Expected"::Yes THEN BEGIN
                    //                 Expectations.RESET;
                    //                 Expectations.SETRANGE(Expectations."Contract No","Contract No");
                    //                 Expectations.SETRANGE(Expectations."Cycle Stage",StageNo);
                    //                 IF Expectations.FIND('-') THEN BEGIN
                    //                 REPEAT
                    //                   IF Expectations."Invoice No"<>'' THEN
                    //                     Invoiced:=TRUE;
                    //                 UNTIL Expectations.NEXT=0;
                    //                 //Call and Error if no Invoice Linked
                    //                 //ERROR('Payment was expected for Stage No %1 Please enter the Invoice No.',StageNo);
                    //                 END ELSE
                    //                  ERROR('Payment was expected for Stage No %1 Please enter the Invoice No.',StageNo);
                    //               IF NOT Invoiced THEN
                    //                  ERROR('Payment was expected for Stage No %1 Please enter the Invoice No.',StageNo);
                    //               END;
                    //          END;
                    //
                    //        //End Checking invoice
                    //        //End Checking Expectations
                    //
                    //        ContMilestones2.RESET;
                    //        ContMilestones2.SETRANGE(ContMilestones2."Sales Cycle Code","Contract Cycle");
                    //        ContMilestones2.SETRANGE(ContMilestones2."Contract Line Type","Contract Line Type");
                    //        ContMilestones2.SETRANGE(ContMilestones2.Stage,(StageNo+1));
                    //
                    //        IF ContMilestones2.FIND('-') THEN BEGIN
                    //        //Check if its Last Stage and Update as Last Stage
                    //          ChkContLastStage.RESET;
                    //          ChkContLastStage.SETRANGE(ChkContLastStage."Sales Cycle Code","Contract Cycle");
                    //          ChkContLastStage.SETRANGE(ChkContLastStage."Contract Line Type","Contract Line Type");
                    //          ChkContLastStage.SETRANGE(ChkContLastStage.Stage,(StageNo+2));
                    //          IF NOT ChkContLastStage.FIND('-') THEN
                    //            LastStage:=TRUE;
                    //           //
                    //           ContMilestones.INIT;
                    //           ContMilestones."Contract No":="Contract No";
                    //           ContMilestones."Sales Cycle Code":="Contract Cycle";
                    //           ContMilestones."Milestone Stage":=ContMilestones2.Stage;
                    //           ContMilestones."Stage Description":=ContMilestones2.Description;
                    //           //ContMilestones."Date of Change":=TODAY;
                    //           ContMilestones." Committee Remarks":=TRUE;
                    //           ContMilestones."Line No":=ContMilestones."Line No"::"1";
                    //           ContMilestones."Previous Sales Cycle Stage":= StageNo;
                    //           {Calculate Estimated Period Here}
                    //           ContMilestones2.TESTFIELD("Date Formula");
                    //              ContMilestones."Estimated Close Date":= CALCDATE(ContMilestones2."Date Formula", TODAY);
                    //           ContMilestones."Completed %":=ContMilestones2."Completed %";
                    //           ContMilestones."Date Closed":=TODAY;
                    //           //Update Status to Closed if Last Stage
                    //           IF LastStage THEN BEGIN
                    //            "Contract Description":= "Contract Description"::"3";
                    //            MODIFY;
                    //           END;
                    //           //End Updating
                    //           ContMilestones.INSERT;
                    //
                    //        END;
                    //     END ELSE BEGIN
                    //        ContMilestones2.RESET;
                    //        ContMilestones2.SETRANGE(ContMilestones2."Sales Cycle Code","Contract Cycle");
                    //        ContMilestones2.SETRANGE(ContMilestones2."Contract Line Type","Contract Line Type");
                    //        ContMilestones2.SETRANGE(ContMilestones2.Stage,1);
                    //        IF ContMilestones2.FIND('-') THEN BEGIN
                    //        //Check if its Last Stage and Update as Last Stage
                    //          ChkContLastStage.RESET;
                    //          ChkContLastStage.SETRANGE(ChkContLastStage."Sales Cycle Code","Contract Cycle");
                    //          ChkContLastStage.SETRANGE(ChkContLastStage."Contract Line Type","Contract Line Type");
                    //          ChkContLastStage.SETRANGE(ChkContLastStage.Stage,(StageNo+1));
                    //          IF NOT ChkContLastStage.FIND('-') THEN
                    //            LastStage:=TRUE;
                    //        //
                    //           ContMilestones.INIT;
                    //           ContMilestones."Contract No":="Contract No";
                    //           ContMilestones."Sales Cycle Code":="Contract Cycle";
                    //           ContMilestones."Milestone Stage":=ContMilestones2.Stage;
                    //           ContMilestones."Stage Description":=ContMilestones2.Description;
                    //           //ContMilestones."Date of Change":=TODAY;
                    //           ContMilestones." Committee Remarks":=TRUE;
                    //           ContMilestones."Line No":=ContMilestones."Line No"::"1";
                    //           ContMilestones."Previous Sales Cycle Stage":= StageNo;
                    //           ContMilestones."Date Closed":=TODAY;
                    //           {Calculate Estimated Period Here}
                    //           ContMilestones2.TESTFIELD("Date Formula");
                    //              ContMilestones."Estimated Close Date":= CALCDATE(ContMilestones2."Date Formula", TODAY);
                    //           ContMilestones."Completed %":=ContMilestones2."Completed %";
                    //           //Update Status to Closed if Last Stage
                    //           IF LastStage THEN BEGIN
                    //            "Contract Description":= "Contract Description"::"3";
                    //            MODIFY;
                    //           END;
                    //           //End Updating
                    //           ContMilestones.INSERT;
                    //
                    //        END;
                    //
                    //     END;
                    //
                    //  END;
                end;
            }
            action("Maintain Machine/Vehicles")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "Maintain Machne/Vehicles";
                RunPageLink = "No." = FIELD("Contract No");
                RunPageView = SORTING("No.");
            }
            action("Terminate Contract")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Terminate Contract';
                Image = CarryOutActionMessage;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    rec.TestField("Termination Reason");

                    if Confirm('Are you sure you want to Terminate This Contract?') then begin
                        rec.Terminated := true;
                        rec.Modify;
                        Message('Contract Number %1 has been Terminated', rec."Contract No");
                    end;
                end;
            }
            group(Approval)
            {

                Caption = 'Approval';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    ApprovalsMgmt: Codeunit 1535;
                    begin
                    ApprovalsMgmt.ApproveRecordApprovalRequest(rec.RecordId);
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
                     ApprovalsMgmt: Codeunit 1535;
                    begin
                     ApprovalsMgmt.RejectRecordApprovalRequest(rec.RecordId);
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
                    ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
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
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                     ApprovalsMgmt: Codeunit 1535;
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
                    ApprovalsMgmt: Codeunit 1535;
                    begin
                        VarVariant := Rec;
                     CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    ApprovalEntries: Page "Approval Entries";
                    approvalsMgmt: Codeunit 1535;
                    begin

                         ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;

    trigger OnInit()
    begin
        SupportPeriodEditable := true;
        WarrantyPeriodeditable := true;
        DefectLiabilityPeriodeditable := true;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        ContMilestones: Record Milestones;
        ContMilestones2: Record "Contract Cycle Stage";
        StageNo: Integer;
        CopyContr: Record Contracts;
        ChkContLastStage: Record "Contract Cycle Stage";
        LastStage: Boolean;
        Expectations: Record "Contract Expectation Details";
        AllStages: Record "All Stages Per Contract";
        Invoiced: Boolean;
        DefectLiabilityPeriodeditable: Boolean;
        SupportPeriodEditable: Boolean;
        WarrantyPeriodeditable: Boolean;
        //OnAfterGetCurrRecord: Integer;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;

    //[Scope('OnPrem')]
    procedure UpdateControls()
    begin
        //     IF "Contract Type"='SERVICES' THEN BEGIN
        //     DefectLiabilityPeriodeditable:=TRUE;
        //     SupportPeriodEditable:=FALSE;
        //     WarrantyPeriodeditable:=FALSE;
        //     CurrPage.UPDATE;
        //     END;
        //     IF "Contract Type"='CONSULTANCY' THEN BEGIN
        //     DefectLiabilityPeriodeditable:=FALSE;
        //     SupportPeriodEditable:=TRUE;
        //     WarrantyPeriodeditable:=FALSE;
        //     CurrPage.UPDATE;
        //     END;
        //     IF "Contract Type"='GOODS' THEN BEGIN
        //     DefectLiabilityPeriodeditable:=FALSE;
        //     SupportPeriodEditable:=FALSE;
        //     WarrantyPeriodeditable:=TRUE;
        //     CurrPage.UPDATE;
        //     END ;
    end;
}

