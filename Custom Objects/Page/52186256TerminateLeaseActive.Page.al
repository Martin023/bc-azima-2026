page 52186256 "Terminate Lease-Active"
{
    Editable = true;
    PageType = Card;
    SourceTable = Lease;
    //SourceTableView = WHERE(Blocked = CONST(false),
                            //Commenced = CONST(true));
    SourceTableView = where ("Terminated" = CONST(true));

    layout
    {
        area(content)
        {
            group("Lease Information")
            {
                Caption = 'Lease Information';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Lease No.';
                    Editable = false;
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Document Date';
                }
                field("Tenant No."; Rec."Tenant No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Tenant Name"; Rec."Tenant Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Escalation For Leases"; Rec."Escalation For Leases")
                {
                    Caption = 'Escalation Percentage';
                    ApplicationArea = Basic, Suite;
                }
                field("Escalation Frequency"; Rec."Escalation Frequency")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Lease Period"; Rec."Lease Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Property No."; Rec."Property No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Property Name"; Rec."Property Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("L.R. No."; Rec."L.R. No.")
                {
                    Caption = 'Fixed Asset No.';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Property Type"; Rec."Property Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        if Rec."Property Type" = 'RESIDENTIAL' then
                            "Area square ftVisible" := true;
                    end;
                }
                field("Floor No."; Rec."Floor No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Floor Name"; Rec."Floor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Unit Name';
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Unit Type Description"; Rec."Unit Type Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Landlord No."; Rec."Landlord No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }
                field("Landlord Name"; Rec."Landlord Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }

                field("Meter No."; Rec."Meter No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Area square ft"; Rec."Area square ft")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = "Area square ftVisible";
                }
                field("Total Amount Excl. VAT"; Rec."Total Amount Excl. VAT")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Total VAT Amount"; Rec."Total VAT Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Lease Type"; Rec."Lease Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Captured By';
                    Editable = false;
                    Visible = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = False;
                }
                field(Terminated; Rec.Terminated)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = False;
                }
            }
            group("Lease Billing")
            {
                Caption = 'Lease Billing';
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Lease Commence Date"; Rec."Lease Commence Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Duration Type"; Rec."Duration Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Duration Value"; Rec."Duration Value")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Billing Frequency"; Rec."Billing Frequency")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Billing Mode';
                }
                field("Last Bill Date"; Rec."Last Bill Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Last Escalation Date"; Rec."Last Escalation Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Next Bill Date"; Rec."Next Bill Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            part(Control1102755030; "Lease Line")
            {
                SubPageLink = "Lease No." = FIELD("No.");
                ApplicationArea = Basic, Suite;
            }
            group("Other Details")
            {
                Caption = 'Other Details';
                field("Letter Of Offer"; Rec."Letter Of Offer")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Lease Agreement Ref. No."; Rec."Lease Agreement Ref. No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Lease Agreement Signed"; Rec."Lease Agreement Signed")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&View Lease Review")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&View Lease Review';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    LeaseLine.Reset;
                    LeaseLine.SetRange(LeaseLine."Lease No.", Rec."No.");
                    if LeaseLine.Find('-') then begin
                        repeat
                            if LeaseLine.Review = true then begin
                                LR.Reset;
                                LR.SetRange(LR."Lease No.", Rec."No.");
                                LR.SetRange(LR."Charge No.", LeaseLine."Charge No.");
                                LR.SetRange(LR.Effected, true);
                                if LR.FindFirst then begin
                                    Error('Lease already has reviews tied to the Charge and Effected');
                                end

                                else begin
                                    LR.Reset;
                                    LR.SetRange(LR."Lease No.", LeaseLine."Lease No.");
                                    LR.SetRange(LR."Charge No.", LeaseLine."Charge No.");
                                    LR.DeleteAll;
                                end;

                                // if LeaseLine."Review Frequency" = LeaseLine."Review Frequency"::Days then begin
                                //     FType := 'D';
                                // end
                                // else
                                //     if LeaseLine."Review Frequency" = LeaseLine."Review Frequency"::Weeks then begin
                                //         FType := 'W';
                                //     end
                                //     else
                                //         if LeaseLine."Review Frequency" = LeaseLine."Review Frequency"::Months then begin
                                //             FType := 'M';
                                //         end
                                //         else
                                //             if LeaseLine."Review Frequency" = LeaseLine."Review Frequency"::Quarters then begin
                                //                 FType := 'Q';
                                //             end
                                //             else
                                //                 if LeaseLine."Review Frequency" = LeaseLine."Review Frequency"::Years then begin
                                //                     FType := 'Y';
                                //                 end;

                                FValue := LeaseLine."Review Frequency Value";
                                EffectDate := LeaseLine."Review Start Date";
                                //OldAmount:=Total;
                                "OldAmount[Rate]" := LeaseLine."Amount Exclusive VAT";
                                "OldAmount[ReviewAmount]" := LeaseLine."Amount Exclusive VAT";
                                repeat
                                    EffectDate := CalcDate(Format(FValue) + Format(FType), EffectDate);
                                    //check if the review is rate based or a flat figure
                                    LeaseLine."Review Is Rate ?" := true;
                                    LeaseLine."Review Is Amount" := true;
                                    if LeaseLine."Review Is Rate ?" = true then begin
                                        "NewAmount[Rate]" := "OldAmount[Rate]" + (("OldAmount[Rate]" * LeaseLine."Review Rate") / 100);
                                        "NewAmount[ReviewAmount]" := "OldAmount[ReviewAmount]" + LeaseLine."Review Amount";
                                    end;
                                    LR.Reset;
                                    if LR.FindLast then begin
                                        IntC := LR."Line No.";
                                    end
                                    else begin
                                        IntC := 0;
                                    end;
                                    IntC := IntC + 1;

                                    //insert the values and display the same
                                    LR.Init;
                                    LR."Line No." := IntC;
                                    LR."Lease No." := LeaseLine."Lease No.";
                                    LR."Charge No." := LeaseLine."Charge No.";
                                    LR."Charge Name" := LeaseLine."Charge Name";
                                    LR."Old Amount[Rate]" := "OldAmount[Rate]";
                                    LR."Old Amount[Review Amount]" := "OldAmount[ReviewAmount]";
                                    LR."Effect Date" := EffectDate;
                                    LR."New [Review Amount]" := "NewAmount[ReviewAmount]";
                                    LR."New [Rate Amount]" := "NewAmount[Rate]";
                                    LR.Insert;
                                    //set the old amount to be the same as the new amount
                                    // OldAmount:=NewAmount;
                                    "OldAmount[Rate]" := "NewAmount[Rate]";
                                    "OldAmount[ReviewAmount]" := "NewAmount[ReviewAmount]";
                                until EffectDate >= LeaseLine."Review End Date";
                            end;

                            LR.Reset;
                            LR.SetRange(LR."Lease No.", LeaseLine."Lease No.");
                            LR.SetRange(LR."Charge No.", LeaseLine."Charge No.");
                            PAGE.Run(PAGE::"Lease Charge Review View", LR);
                        until LeaseLine.Next = 0;
                    end;
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Visible = true;
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    begin

                        //here//ApprovalEntry."Document Type" := ApprovalEntry."Document Type"::"17";
                        ApprovalEntries.SetRecordFilters(DATABASE::Lease, ApprovalEntry."Document Type", Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin

                        //IF LinesCommitted THEN
                        // ERROR('All Lines should be committed');
                        Rec.TestField("Lease Commence Date");
                        // Rec.TestField("Billing Frequency");
                        //TESTFIELD("Billing Frequency Value");
                        Rec.TestField("Duration Type");
                        Rec.TestField("Duration Value");
                        Rec.TestField("Letter Of Offer");
                        Rec.TestField(User);

                        if Rec.Status = Rec.Status::Approved then begin
                            Error('Lease Approval Request has Already been Approved');
                        end
                        else
                            if Rec.Status = Rec.Status::"Pending" then begin
                                Error('Lease Approval Request is Already at the Pending Level');
                            end
                            else

                        VarVariant := Rec;
                        rec.Status := rec.Status::Approved;
                        rec.Modify();
                        //if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        //    CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action("Terminate Lease")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Terminate Lease';

                    trigger OnAction()
                    begin
                        if Confirm('Are You sure You want to Terminate the Lease?', false) = false then begin exit end;

                        LeaseLine.Reset;
                        LeaseLine.SetRange(LeaseLine."Lease No.", Rec."No.");
                        if LeaseLine.Find('-') then begin
                            Rec."Expiry Date" := Today;
                            //Rec.Status := Rec.Status::Closed;
                            Rec.Commenced := false;
                            Rec.Select := false;
                            Rec."Terminated" := true;
                            LeaseLine.DeleteAll;
                            Rec.Modify;
                            Message('Lease has been Terminated');
                        end;
                    end;
                }
                action("Renew Lease")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Renew Lease';

                    trigger OnAction()
                    begin

                        if Confirm('Are You sure You want to Re-New the Lease Document?', false) = false then begin exit end;

                        LeaseLine.Reset;
                        LeaseLine.SetRange(LeaseLine."Lease No.", Rec."No.");
                        if LeaseLine.Find('-') then begin
                            Rec."Lease Commence Date" := Today;
                            Rec."Expiry Date" := Today;
                            Rec."Billing Frequency" := Rec."Billing Frequency"::Monthly;
                            Rec."Duration Type" := Rec."Duration Type"::Years;
                            Rec."Duration Value" := 0;
                            Rec.Status := Rec.Status::Open;
                            Rec.Commenced := false;
                            Rec.Select := false;
                            Rec."Renew Lease" := true;
                            LeaseLine.DeleteAll;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        "Area square ftVisible" := true;
    end;

    var
        LR: Record "Lease Charge Review";
        IntC: Integer;
        EffectDate: Date;
        "NewAmount[Rate]": Decimal;
        FType: Text[30];
        FValue: Integer;
        "OldAmount[Rate]": Decimal;
        LeaseLine: Record "Lease Line";
        "NewAmount[ReviewAmount]": Decimal;
        "OldAmount[ReviewAmount]": Decimal;
        Lease: Record Lease;
        PropertyCharges: Record "Unit Setup Charges";
        ApprovalEntry: Record "Approval Entry";
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,Lease;
        Status1: Boolean;
        StatusTrue: Option;
        D: Date;
        "Area square ftVisible": Boolean;
        VarVariant: Variant;
}

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Date Registered"; Rec."Date Registered")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Property No."; Rec."Property No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("L.R. No."; Rec."L.R. No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Property Name"; Rec."Property Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Floor No."; Rec."Floor No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Floor Name"; Rec."Floor Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Unit Code"; Rec."Unit Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Unit Type"; Rec."Unit Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Unit Type Description"; Rec."Unit Type Description")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Landlord No."; Rec."Landlord No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Landlord Name"; Rec."Landlord Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Tenant No."; Rec."Tenant No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Tenant Name"; Rec."Tenant Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Total Amount Excl. VAT"; Rec."Total Amount Excl. VAT")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Total VAT Amount"; Rec."Total VAT Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Meter No."; Rec."Meter No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Previous Reading"; Rec."Previous Reading")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = true;
//                 }
//                 field("Current Reading"; Rec."Current Reading")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = true;
//                     Enabled = true;
//                 }
//                 field("Nairobi Pr Reading"; Rec."Nairobi Pr Reading")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Nairobi Cur Reading"; Rec."Nairobi Cur Reading")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(User; Rec.User)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Lease Balance"; Rec."Lease Balance")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Area square ft"; Rec."Area square ft")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(FirstBilling; Rec.FirstBilling)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Prepayment; Rec.Prepayment)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             part(Control1102755026; "Lease Line")
//             {
//                 ApplicationArea = Basic, Suite;
//                 SubPageLink = "Lease No." = FIELD("No.");
//             }
//             group("Termination Details")
//             {
//                 Caption = 'Termination Details';
//                 field("Termination Notice Date"; Rec."Termination Notice Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Termination Reason"; Rec."Termination Reason")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Termination Date"; Rec."Termination Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             group(Billing)
//             {
//                 Caption = 'Billing';
//                 field("Lease Commence Date"; Rec."Lease Commence Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Duration Type"; Rec."Duration Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Duration Value"; Rec."Duration Value")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Expiry Date"; Rec."Expiry Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Billing Frequency"; Rec."Billing Frequency")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Billing Frequency Value"; Rec."Billing Frequency Value")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Last Bill Date"; Rec."Last Bill Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Next Bill Date"; Rec."Next Bill Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = true;
//                 }
//             }
//             group("Other Details")
//             {
//                 Caption = 'Other Details';
//                 field("Letter Of Offer"; Rec."Letter Of Offer")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Lease Agreement Ref. No."; Rec."Lease Agreement Ref. No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Blocked; Rec.Blocked)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Commenced; Rec.Commenced)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Lease Agreement Signed"; Rec."Lease Agreement Signed")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group(Action7)
//             {
//                 action("Terminate Lease")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Terminate Lease';
//                     Image = ClosePeriod;

//                     trigger OnAction()
//                     begin
//                         if not Confirm(ConfirmLeaseTerm, true, false) then
//                             exit else
//                             if Rec."Termination Date" <= Today then begin

//                                 Rec.TestField("Termination Notice Date");
//                                 Rec.TestField("Termination Date");
//                                 Rec.TestField("Termination Reason");
//                                 Rec."Next Bill Date" := 0D;
//                                 Rec.Blocked := true;
//                                 Rec.Modify;
//                             end else
//                                 Error('Termination Date is Not Due');
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         LeaseLine: Record "Lease Line";
//         LR: Record "Lease Charge Review";
//         IntC: Integer;
//         EffectDate: Date;
//         "NewAmount[Rate]": Decimal;
//         FType: Text[30];
//         FValue: Integer;
//         "OldAmount[Rate]": Decimal;
//         "NewAmount[ReviewAmount]": Decimal;
//         "OldAmount[ReviewAmount]": Decimal;
//         Lease: Record Lease;
//         PropertyCharges: Record "Unit Setup Charges";
//         ApprovalEntry: Record "Approval Entry";
//         Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
//         // //ApprovalEntries: Page "Approval Entries";
//         DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,Lease;
//         Status1: Boolean;
//         StatusTrue: Option;
//         FrmCalendar: Page "Units Meter Rating";
//         D: Date;
//         SalesHeader: Record "Sales Header";
//         SalesLine: Record "Sales Line";
//         CreatePrepaymentText: Label 'Sales Prepayment No %1 has been created Successfully';
//         ConfirmPrepText: Label 'Are you sure you want to create deferement Invoice';
//         PrepaymentErr: Label 'You CANNOT create Deferement Invoice if Prepayment is not selected';
//         DoceumentErr: Label 'Prepayment Invoice for %1 was already created.';
//         ConfirmLeaseTerm: Label 'Are you sure you want to Terminate Lease';
// }

