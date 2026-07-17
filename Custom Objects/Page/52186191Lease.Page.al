page 52186191 Lease
{
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = Lease;
    //SourceTableView = WHERE(Blocked = CONST(false),
    //Commenced = CONST(false));
    PromotedActionCategories = 'New,Process,Reports,Approvals';
    layout
    {
        area(content)
        {
            group("Lease Information")
            {
                Caption = 'Lease Information';
                Editable = ApprovedEditable;
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
                field("Size in Sq. Ft."; Rec."Size in Sq. Ft.")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = false;
                }
                field("Escalation For Leases"; Rec."Escalation For Leases")
                {
                    Caption = 'Escalation Percentage';
                    ApplicationArea = Basic, Suite;
                    //Editable = False;
                }
                field("Escalation Frequency"; Rec."Escalation Frequency")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = False;
                }
                field("Lease Period"; Rec."Lease Period")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = False;
                }
                field("Property No."; Rec."Property No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Propert/Asset No.';
                }
                // field("Property Asset No."; Rec."Building Asset No.")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                //}
                field("Property Name"; Rec."Property Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Building Location"; Rec."Building Location")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Land Ref No."; Rec."L.R. No.")
                {
                    Caption = 'Land Ref No.';
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
                    //Caption = 'Office Name';
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    //Caption = 'Office Type';
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
                    Editable = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Created By';
                    Editable = false;
                    Visible = true;
                }
                field("Created At"; Rec."Created at")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = False;
                }
                field("Lease Status"; Rec."Lease Status")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date Allocated"; Rec."Date Allocated")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Lease TAT"; Rec."Lease TAT")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Caption = 'Lease TAT (Days)';
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
                Editable = ApprovedEditable;

                // field("Branch Name"; Rec."Branch Name")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }

                // field("Department Name"; Rec."Department Name")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
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
                    Editable = true;
                }

                field("Next Bill Date"; Rec."Next Bill Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
            }
            part(Control1102755030; "Lease Line")
            {
                SubPageLink = "Lease No." = FIELD("No.");
                ApplicationArea = Basic, Suite;
                Editable = ApprovedEditable;
            }
            group("Case Forwarding")
            {
                Editable = ForwardingEditable;
                field("Send/Forward to"; Rec."Send/Forward to")
                {
                    //Editable = ForwardingEditable;
                }
                field("Originating Department"; Rec."Originating Department")
                {
                    Caption = 'Originating Department';
                    Editable = false;
                }
                field("Current Departmrnt"; Rec."Current Department")
                {
                    Caption = 'Current Department';
                    Editable = false;
                }
            }
            group("Other Details")
            {
                Caption = 'Other Details';
                Editable = ApprovedEditable;
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
                field("End Remarks"; Rec."End Remarks")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Escalation")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Escalalation';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ReviewFrequency: Dateformula;
                    LastReviewDate: Date;
                    Charge: Record Charges;

                begin
                    Rec.testfield("Lease Commence Date");
                    //Rec.testfield("Billing Frequency");
                    //rec.TestField(Status, rec.Status::Approved);

                    LeaseLine.Reset;
                    LeaseLine.SetRange(LeaseLine."Lease No.", Rec."No.");
                    if LeaseLine.Find('-') then begin
                        repeat
                            Charge.Reset();
                            Charge.SetRange(Code, LeaseLine."Charge No.");
                            Charge.SetRange(Charge."Is Rent", true);
                            if Charge.FindFirst() then begin
                                FValue := LeaseLine."Review Frequency Value";
                                EffectDate := 0D;
                                ReviewFrequency := LeaseLine."Review Frequency";
                                if LeaseLine."Review End Date" = 0D then
                                    LastReviewDate := LeaseLine."Review Start Date"
                                else
                                    LastReviewDate := LeaseLine."Review End Date";

                                //if not (LeaseLine."Review End Date" = Today) then begin
                                LR.Reset;
                                LR.SetRange(LR."Lease No.", Rec."No.");
                                LR.SetRange(LR."Charge No.", LeaseLine."Charge No.");
                                LR.Setrange("Effected Date", CalcDate(Format(LeaseLine."Review Frequency"), CalcDate((Format((LeaseLine."Review Frequency"))), Today)));
                                LR.SetRange("Effect Date", CalcDate(ReviewFrequency, LastReviewDate));
                                //LR.Setrange("Effected Date", CalcDate(Format(LeaseLine."Review Frequency"), CalcDate((Format((LeaseLine."Review Frequency"))), Today)));

                                LR.SetRange(LR.Effected, true);
                                if LR.FindFirst then begin
                                    Error('Lease already has already been escalated and Effected');
                                end

                                else begin
                                    LR.Reset;
                                    LR.SetRange(LR."Lease No.", LeaseLine."Lease No.");
                                    LR.SetRange(LR."Charge No.", LeaseLine."Charge No.");
                                    LR.Setrange("Effected Date", LeaseLine."Review Start Date", CalcDate(ReviewFrequency, LastReviewDate));
                                    LR.SetRange(LR.Effected, false);
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
                                EffectDate := 0D;
                                ReviewFrequency := LeaseLine."Review Frequency";
                                if LeaseLine."Review End Date" = 0D then
                                    LastReviewDate := LeaseLine."Review Start Date"
                                else
                                    LastReviewDate := LeaseLine."Review End Date";
                                //OldAmount:=Total;

                                "OldAmount[Rate]" := LeaseLine."Amount Exclusive VAT";
                                if LeaseLine."Review Amount" = 0 then
                                    "OldAmount[Rate]" := LeaseLine."Amount Exclusive VAT" else
                                    "OldAmount[Rate]" := LeaseLine."Review Amount";
                                //repeat
                                //EffectDate := CalcDate(Format(FValue) + Format(FType), EffectDate);

                                EffectDate := CalcDate(ReviewFrequency, LastReviewDate);
                                Message('%1', EffectDate);
                                if Today >= EffectDate then begin
                                    //LeaseLine."Review Is Rate ?" := true;
                                    //LeaseLine."Review Is Amount" := true;
                                    //if LeaseLine."Review Is Rate ?" = true then begin
                                    "NewAmount[Rate]" := "OldAmount[Rate]" + (("OldAmount[Rate]" * LeaseLine."Review Rate") / 100);
                                    //"NewAmount[ReviewAmount]" := "OldAmount[ReviewAmount]" + LeaseLine."Review Amount";
                                    //end;
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
                                    LR.Effected := true;
                                    //LR."Old Amount[Review Amount]" := "OldAmount[ReviewAmount]";
                                    LR."Effect Date" := EffectDate;
                                    //LR."New [Review Amount]" := "NewAmount[ReviewAmount]";
                                    LR."New [Rate Amount]" := "NewAmount[Rate]";
                                    LR.Insert;
                                    //set the old amount to be the same as the new amount
                                    // OldAmount:=NewAmount;
                                    "OldAmount[Rate]" := "NewAmount[Rate]";
                                    "OldAmount[ReviewAmount]" := "NewAmount[ReviewAmount]";
                                    //until EffectDate >= LeaseLine."Review End Date";
                                    LeaseLine."Review End Date" := EffectDate;
                                    LeaseLine."Review Amount" := "NewAmount[Rate]";
                                    LeaseLine.Review := true;
                                    LeaseLine.Modify;
                                end
                                else
                                    error('Review Date is not due yet');
                                //end;
                                //check if the review is rate based or a flat figure

                                LR.Reset;
                                LR.SetRange(LR."Lease No.", LeaseLine."Lease No.");
                                LR.SetRange(LR."Charge No.", LeaseLine."Charge No.");
                                PAGE.Run(PAGE::"Lease Charge Review View", LR);
                            end;
                        until LeaseLine.Next = 0;

                    end else
                        error('No lines exists for review.');
                end;
            }
            action("View Escalations")
            {
                Caption = 'View Escalations';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    LR.Reset;
                    LR.SetRange(LR."Lease No.", LeaseLine."Lease No.");
                    //LR.SetRange(LR."Charge No.", LeaseLine."Charge No.");
                    PAGE.Run(PAGE::"Lease Charge Review View", LR);
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Visible = true;

                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Enabled = NOT OpenApprovalEntriesExist;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin

                        //IF LinesCommitted THEN
                        // ERROR('All Lines should be committed');
                        //Rec.TestField("Lease Commence Date");
                        // Rec.TestField("Billing Frequency");
                        //TESTFIELD("Billing Frequency Value");
                        //Rec.TestField("Duration Type");
                        //Rec.TestField("Duration Value");
                        //Rec.TestField("Letter Of Offer");
                        Rec.TestField("Date Registered");
                        Rec.TestField("Tenant Name");
                        Rec.TestField("Size in Sq. Ft.");
                        Rec.TestField("Building Location");
                        //Rec.TestField("Escalation For Leases");
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
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = True;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        //here//ApprovalEntry."Document Type" := ApprovalEntry."Document Type"::"17";
                        ApprovalEntries.SetRecordFilters(DATABASE::Lease, ApprovalEntry."Document Type", Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Promoted = true;
                    PromotedCategory = Category4;
                    Enabled = OpenApprovalEntriesExist;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                // action("Terminate Lease")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Terminate Lease';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     Visible = true;

                //     trigger OnAction()
                //     begin
                //         if Confirm('Are You sure You want to Terminate the Lease Document?', false) = false then begin exit end;

                //         LeaseLine.Reset;
                //         LeaseLine.SetRange(LeaseLine."Lease No.", Rec."No.");
                //         if LeaseLine.Find('-') then begin
                //             Rec."Expiry Date" := Today;
                //             //Rec.Status := Rec.Status::Closed;
                //             Rec.Commenced := false;
                //             Rec.Select := false;
                //             Rec."Terminated" := true;
                //             LeaseLine.DeleteAll;
                //             Rec.Modify;
                //             Message('Lease has been Terminated');
                //         end;
                //     end;
                // }
                action("Allocate Office")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Allocate Office';
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are You sure You want to Allocate the selected unit?', false) = false then begin exit end;
                        Unt.Reset;
                        Unt.SetRange("Property No.", Rec."Property No.");
                        Unt.SetRange(Unt."Unit Code", Rec."Unit Code");
                        if Unt.Find('-') then begin
                            Unt."Unit Status" := Unt."Unit Status"::Occupied;
                            Unt.Occupied := true;
                            Unt.Modify;
                        end;
                        Rec."Lease Status" := Rec."Lease Status"::Active;
                        Rec.Commenced := true;
                        Rec."Date Allocated" := Today;
                        Rec."Lease TAT" := Rec."Date Allocated" - Rec."Date Registered";
                        Rec.Modify;
                        Tenants.RESET;
                        Tenants.SETRANGE("No.", Rec."Tenant No.");
                        IF tenants.Find('-') then begin
                            msg := 'Dear ' + Tenants."Name" + ', Your Lease with AZIMA DT SACCO of Lease Reference No.' + Rec."No." + 'The Office assigned to you is' + Rec."Unit Code" + 'situated on ' + Rec."Floor Name" + 'in ' + Rec."Property Name" + 'of Land Reference No. ' + Rec."L.R. No." + ' has been finalized and the Lease has been Commenced. Thank You for choosing AZIMA DT SACCO as your preferred Landlord.';
                            SendSMS.SendSms(Source::"LEASE", Tenants."Phone No.", msg, ' ', ' ', false, 0, false, 'CBS', Lease."No.", 'CBS', Today);
                        end;
                        Message('Selected Unit has been Allocated, the Lease has been Commenced and SMS sent to Tenant!');

                    end;
                }
                action("Inactivate Lease")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Terminate Lease';
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to terminate this lease?', false) = false then begin exit end;
                        Rec.TestField("End Remarks");
                        Unt.Reset;
                        Unt.SetRange(Unt."Unit Code", Rec."Unit Code");
                        if Unt.Find('-') then
                            Unt."Unit Status" := Unt."Unit Status"::Vacant;
                        Unt.Occupied := false;
                        Unt.Modify;

                        // LeaseLine.Reset();
                        // LeaseLine.SetRange("No.", LeaseLine."Lease No.");
                        // if LeaseLine.Find('-') then

                        // LeaseLine.Modify();
                        LeaseLine."Date Vacated" := Today;
                        Rec.Blocked := true;
                        Rec.Terminated := true;
                        Rec."Lease Status" := Rec."Lease Status"::Terminated;
                        Rec."Termination Date" := Today;
                        Rec.Modify;
                        Message('Selected Lease is Terminated.');
                    end;
                }
                action("Renew Lease")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Renew Lease';
                    Promoted = true;
                    PromotedCategory = Process;

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
                            Rec.Blocked := false;
                            Rec.Terminated := false;
                            LeaseLine.DeleteAll;
                            Rec.Modify;
                        end;
                        Rec.Terminated := false;
                        Rec."Renew Lease" := true;
                        Rec."Lease Status" := Rec."Lease Status"::Renewed;
                        Rec."Date Renewed" := Today;
                        Rec.Modify();
                    end;
                }
            }
            group("Document Forwarding")
            {
                action("Document Comments")
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
                action("Return Documents")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Send/Forward to" = Rec."Current Department" then Error('You cannot return this document to %1 while its already in %1', Rec."Send/Forward to");
                        Comments.Reset();
                        Comments.SetRange("Header No.", Rec."No.");
                        if Comments.FindLast() then begin
                            if Comments."Commented By" <> UserId then Error('Kindly leave a comment');
                            if Comments.Comment = '' then Error('Kindly leave a comment');
                        end else
                            Error('Kindly add a comment');
                        if not Confirm('Are you sure you want to return this document?') then exit;
                        if Rec."Originating Department" = Rec."Send/Forward to" then begin
                            // Rec."Originator Status" := Rec."Originator Status"::Returned;
                            // Rec."Recepient Status" := Rec."Recepient Status"::Returned;

                            CFPage.InsertTracker(Rec."No.", Rec."Send/Forward to", true, UserId, CurrentDateTime);
                            Rec."Current Department" := Rec."Send/Forward to";
                            Rec.Modify();
                            Message('Case sent successfully');
                        end
                        else begin
                            Error('You Can Only Return to the Originating Department!');
                        end;
                    end;
                }
                action("Send Case")
                {
                    ApplicationArea = Basic, Suite;
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // Visible = SendCaseVisible;

                    trigger OnAction()
                    var
                    begin
                        if Rec."Send/Forward to" = Rec."Current Department" then Error('You cannot send this document to %1 while its already in %1', Rec."Send/Forward to");
                        Comments.Reset();
                        Comments.SetRange("Header No.", Rec."No.");
                        if Comments.FindLast() then begin
                            if Comments."Commented By" <> UserId then Error('Kindly leave a comment');
                            if Comments.Comment = '' then Error('Kindly leave a comment');
                        end else
                            Error('Kindly add a comment');
                        if not Confirm('Are you sure you want to send this case?') then exit;
                        // Rec."Originator Status" := Rec."Originator Status"::Sent;
                        // Rec."Recepient Status" := Rec."Recepient Status"::New;
                        Rec."Current Department" := Rec."Send/Forward to";

                        // if (CurrentUsersDept <> Rec."Originating Department") and (Rec."Send/Forward to" = Rec."Originating Department") then begin
                        //     Rec."Originator Status" := Rec."Originator Status"::Returned;
                        //     Rec."Recepient Status" := Rec."Recepient Status"::Returned;
                        // end;
                        CFPage.InsertTracker(Rec."No.", Rec."Send/Forward to", true, UserId, CurrentDateTime);
                        Rec.Modify();
                        Message('Case sent successfully');
                    end;
                }
                action("Case Tracker")
                {
                    ApplicationArea = Basic, Suite;
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Category4;

                    RunObject = page "CF Tracker List";
                    RunPageLink = "Header No." = field("No.");
                }
            }

        }
    }

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Approved then
            //CurrPage.editable := false;
        ApprovedEditable := True;
        ForwardingEditable := True;
        Pagecontrol();
        // else
        // ForwardingEditable := False;
    end;

    local procedure Pagecontrol()
    begin
        ApprovedEditable := false;
        ForwardingEditable := false;

        if rec.Status = rec.Status::Open then begin
            ApprovedEditable := true;
            ForwardingEditable := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            ApprovedEditable := false;
            ForwardingEditable := true;
        end;

        if rec.Status = rec.Status::Pending then begin
            ApprovedEditable := False;
            ForwardingEditable := false;
        end;
        if rec.Status = rec.Status::Rejected then begin
            ApprovedEditable := False;
            ForwardingEditable := false;
        end;
    end;

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
        Unt: Record Unit;
        ApprovedEditable: Boolean;
        OpenApprovalEntriesExist: boolean;
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
        ForwardingEditable: Boolean;
        Tenants: Record Customer;
        SendSMS: Codeunit SendSms;
        msg: Text;
        Source: enum "SMS Source";
}

