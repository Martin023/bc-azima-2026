page 52186232 "Approved Leases"
{
    PageType = Card;
    SourceTable = Lease;
    SourceTableView = WHERE(Blocked = CONST(false),
                            Commenced = CONST(false));

    layout
    {
        area(content)
        {
            group("Lease Information")
            {
                Caption = 'Lease Information';
                field("No."; Rec."No.")
                {
                    Caption = 'Lease No.';
                    ApplicationArea = Basic, Suite;
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    Caption = 'Document Date';
                    ApplicationArea = Basic, Suite;
                }
                field("Property No."; Rec."Property No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Property Name"; Rec."Property Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("L.R. No."; Rec."L.R. No.")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Property Type"; Rec."Property Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        if rec."Property Type" = 'RESIDENTIAL' then
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
                }
                field("Unit Description"; Rec."Unit Description")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Unit Type Description"; Rec."Unit Type Description")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Landlord No."; Rec."Landlord No.")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Landlord Name"; Rec."Landlord Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Tenant No."; Rec."Tenant No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Tenant Name"; Rec."Tenant Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Meter No."; Rec."Meter No.")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Area square ft"; Rec."Area square ft")
                {
                    Editable = false;
                    Visible = "Area square ftVisible";
                    ApplicationArea = Basic, Suite;
                }
                field("Total Amount Excl. VAT"; Rec."Total Amount Excl. VAT")
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
            group("Lease Billing")
            {
                Caption = 'Lease Billing';
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
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
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Billing Frequency"; Rec."Billing Frequency")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Billing Frequency Value"; Rec."Billing Frequency Value")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Bill Date"; Rec."Last Bill Date")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Next Bill Date"; Rec."Next Bill Date")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
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
                field("Letting Fee"; Rec."Letting Fee")
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
                    LeaseLine.SetRange(LeaseLine."Lease No.", rec."No.");
                    if LeaseLine.Find('-') then begin
                        if LeaseLine.Review = true then begin
                            LR.Reset;
                            LR.SetRange(LR."Lease No.", rec."No.");
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

                        // ApprovalEntry."Document Type" := ApprovalEntry."Document Type"::"63";
                        //ApprovalEntries.SetRecordFilters(DATABASE::Lease, ApprovalEntry."Document Type", rec."No.");
                        //ApprovalEntries.Run;
                    end;
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                    // ApprovalMgt: Codeunit 1535;
                    begin
                        //IF LinesCommitted THEN
                        // ERROR('All Lines should be committed');

                        if rec.Status = rec.Status::Approved then begin


                            Error('Lease Approval Request has Already been Approved');
                        end
                        // ELSE
                        //  IF ApprovalMgt.SendLeaseApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';

                    trigger OnAction()
                    var
                    // ApprovalMgt: Codeunit 1535;
                    begin
                        //IF ApprovalMgt.CancelLeaseApprovalRequest(Rec,TRUE,TRUE) THEN;
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
        PropertyCharges: Record "Property Charges";
        ApprovalEntry: Record "Approval Entry";
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        //// //ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,Lease;
        Status1: Boolean;
        StatusTrue: Option;

        "Area square ftVisible": Boolean;
}

