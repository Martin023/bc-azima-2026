page 52186640 "HR Training Feedback"
{
    Caption='Training Evaluation';

    PageType = Card;
    SourceTable = "HR Training Feedback Form";
    PromotedActionCategories=',,,,,,,,Approvals';


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable=false;
                }
                field("Course Title"; Rec."Course Title")
                {
                    ApplicationArea = Basic;
                    
                }
                field("Program Name";Rec."Program Name")
                {
                     ApplicationArea = Basic;
                    

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable=false;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = Basic;
                    Editable=false;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = Basic;
                    Editable=false;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                    Editable=false;
                }
                field(Provider; Rec.Provider)
                {
                    ApplicationArea = Basic;
                    Editable=false;
                }
                field("Provider Name"; Rec."Provider Name")
                {
                    ApplicationArea = Basic;
                    Editable=false;
                }
                // field("Purpose of Training"; Rec."Purpose of Training")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    editable=false;
                }
                // field(Directorate; Rec.Directorate)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'County';
                // }
                // field("Directorate Name"; Rec."Directorate Name")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'County Name';
                //     Visible = true;
                // }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                    editable=false;
                }
                // field("Department Name"; Rec."Department Name")
                // {
                //     ApplicationArea = Basic;
                // }
                // field(Station; Rec.Station)
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Station Name"; Rec."Station Name")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Text 1"; Rec."Text 1")
                {
                    ApplicationArea = Basic;
                    Caption = '1.Please state how the course has benefited you and the organization';
                    MultiLine = true;
                }
                field("Text 2"; Rec."Text 2")
                {
                    ApplicationArea = Basic;
                    Caption = '2.Which specific areas do you think need improvement in your area of operation?';
                    MultiLine = true;
                }
                field("Text 3"; Rec."Text 3")
                {
                    ApplicationArea = Basic;
                    Caption = '3.How will you use the skills acquired to address the problem?';
                    MultiLine = true;
                }
                // field("Text 4"; Rec."Text 4")
                // {
                //     ApplicationArea = Basic;
                //     Caption = '4.Provide timeline within which you will cascade the skills learned to others in your Department/organization';
                //     MultiLine = true;
                // }
                field("Text 5"; Rec."Text 5")
                {
                    ApplicationArea = Basic;
                    Caption = '5.What skills did you acquire from the training attended.';
                    MultiLine = true;
                }
                // field("Text 6"; Rec."Text 6")
                // {
                //     ApplicationArea = Basic;
                //     Caption = '6.Target Group that can benefit from the skills acquired';
                //     MultiLine = true;
                // }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    editable=false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    editable=false;
                }
                field("User ID";Rec."User ID")
                {
                     ApplicationArea = Basic;
                    editable=false;

                }
                label(Control1)
                {
                    ShowCaption = false;
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            // group("&Show")
            // {
            //     Caption = '&Show';
            //     action(Comments)
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Comments';
            //         Image = Comment;
            //         Promoted = true;
            //         PromotedCategory = Category5;

            //         trigger OnAction()
            //         var
            //             DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition";
            //         begin
            //             /*
            //             DocumentType:=DocumentType::"Training Application";

            //             ApprovalComments.SetRecordFilters(DATABASE::"HR Training Applications",DocumentType,"Application No");
            //             ApprovalComments.SetUpLine(DATABASE::"HR Training Applications",DocumentType,"Application No");
            //             ApprovalComments.RUN;
            //             */

            //         end;
            //     }
            // }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                // action(Approve)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Approve';
                //     Image = Approvals;
                //     Promoted = true;
                //     PromotedCategory = Category9;
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     begin
                //         Rec.Status := Rec.Status::Approved;
                //     end;
                // }
                // action(Reject)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Reject';
                //     Image = Reject;
                //     Promoted = true;
                //     PromotedCategory = Category9;
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     begin
                //         Rec.Status := Rec.Status::"Rejected.";
                //     end;
                // }
                // action("&Approvals")
                // {
                //     ApplicationArea = Basic;
                //     Caption = '&Approvals';
                //     Enabled = false;
                //     Image = Approvals;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     Visible = false;

                //     trigger OnAction()
                //     var
                //         //DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Disciplinary Approvals","Activity Approval","Exit Approval","Medical Claim Approval",Jv,BackToOffice;
                //     //// //ApprovalEntries: Page "Approval Entries";
                //     begin
                //         /*
                //         DocumentType:=DocumentType::BackToOffice;
                //         ApprovalEntries.SetRecordFilters(DATABASE::"HRBack To Office Form",DocumentType,"Document No");
                //         ApprovalEntries.RUN;
                //         */

                //     end;
                // }
                // action("&Send Approval &Request")
                // {
                //     ApplicationArea = Basic;
                //     Caption = '&Send Approval &Request';
                //     Enabled = true;
                //     Image = SendApprovalRequest;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     Visible = true;

                //     trigger OnAction()
                //     begin

                //         if Confirm('Send this Application for Approval?', true) = false then exit;
                //         //ApprovalMgt.SendBackOfficeAppApprovalRequest(Rec);
                //     end;
                // }
            //     action("&Cancel Approval request")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = '&Cancel Approval request';
            //         Enabled = false;
            //         Image = Cancel;
            //         Promoted = true;
            //         PromotedCategory = Category4;
            //         Visible = false;

            //         trigger OnAction()
            //         begin

            //             if Confirm('Are you sure you want to cancel the approval request', true) = false then exit;
            //             //ApprovalMgt.CancelBackOfficeAppApprovalReq(Rec,TRUE,TRUE);
            //         end;
            //     }
            //     action("&Print")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = '&Print';
            //         Image = PrintForm;
            //         Promoted = true;
            //         PromotedCategory = Category4;
            //         //RunObject = Report Report39005550;

            //         trigger OnAction()
            //         begin
            //             /*
            //            HRTrainingApplications.SETRANGE(HRTrainingApplications."Application No","Application No");
            //            IF HRTrainingApplications.FIND('-') THEN
            //            //REPORT.Run(52185874,TRUE,TRUE,HRTrainingApplications);
            //             */

            //         end;
            //     }
            // }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        VarVariant := Rec;
                         if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                         CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        if rec.status=rec.status::"Pending Approval" then begin
                         if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                         CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
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
                    // ApprovalEntries: Page 658;
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        // // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
        }
    }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        
        usersetup.reset();
        usersetup.SetRange("User ID",UserId);
        IF usersetup.FindFirst() then begin
            //rec."Global Dimension 1 Code":=usersetup."Global Dimension 1 Code";
            //rec."Global Dimension 2 Code":=usersetup."Global Dimension 2 Code";
            rec."Responsibility Center":=usersetup."Responsibility Centre";
    end;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Approved then
            CurrPage.Editable := false;
    end;
   
      
   

    var
         ApprovalMgt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        usersetup:record "User Setup";
}

