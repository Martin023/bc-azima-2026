page 52185855 "Guarantor Substitution"
{
    DeleteAllowed = false;
    PageType = Card;
    InsertAllowed = true;
    SourceTable = "Guarantors Substitution";
    // PromotedActionCategories = 'New,Process,Reports,Update Changes,Approvals,CRM Actions,EDMS,Refresh';
    PromotedActionCategories = 'New,Process,Reports,Update Changes,Approvals,Refresh';

    layout
    {
        area(content)
        {
            // group(CRM)
            // {
            //     Caption = 'CRM Information';
            //     field("CRM Application No."; Rec."CRM Application No.")
            //     {
            //         Editable = false;
            //     }
            //     field("CRM Created By"; Rec."CRM Created By")
            //     {
            //         Editable = false;
            //     }
            //     field("CRM Originating Branch"; Rec."CRM Originating Branch")
            //     {
            //         Editable = false;
            //     }
            //     field("CRM Notes"; Rec."CRM Notes")
            //     {
            //         Editable = false;
            //         MultiLine = true;
            //     }
            // }
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = all;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Account No."; Rec."Loan Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Account Status"; Rec."Account Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Current Savings"; Rec."Current Savings")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("FOSA Account"; Rec."FOSA Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Business Loan No."; Rec."Business Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Business Loan Shares"; Rec."Business Loan Shares")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approved By"; Rec."Approved By")

                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Rejected By"; Rec."Rejected By")
                {
                    Editable = false;
                }
            }
            part("Loan Guarantors Substitution"; "Loan Guarantors List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Loan Guarantors Substitution';
                Editable = LinesEdit;
                SubPageLink = "No." = FIELD("No.");
            }
        }

        area(factboxes)
        {
            part("Approved Images"; "Member Picture & Signature")
            {
                Caption = 'Member Images';
                SubPageLink = "Member No" = FIELD("Member No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Deffer)
            {
                action("Update Changes")
                {
                    ApplicationArea = Basic, Suite;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        LNGr: Record "Loan Guarantors and Security";
                        LoanRec: Record Loans;
                        AppraisaComme: Record "Loan Appraisal Comments";
                    begin
                        if Rec.Status <> Rec.Status::Approved then
                            Error(DocMustbeApproved);
                        if Rec.Posted = true then
                            Error(Err);
                        if not Confirm('Do you want to update the changes?') then exit;

                        Lguarant.Reset;
                        Lguarant.SetRange(Lguarant."No.", Rec."No.");
                        Lguarant.SetRange(Lguarant."Loan No", Rec."Loan No.");
                        if Lguarant.Find('-') then begin
                            repeat

                                Lguarantx.Reset;
                                Lguarantx.SetRange(Lguarantx."Loan No", Lguarant."Loan No");
                                // Lguarantx.SETRANGE(Lguarantx."Member No", Lguarant."Member No");
                                Lguarantx.SetRange(Lguarantx."Savings Account No./Member No.", Lguarant."Savings Account No.");
                                if Lguarantx.Find('-') then begin
                                    REPEAT
                                        Lguarantx.Substituted := Lguarant.Substituted;
                                        Lguarantx."Proportion Guaranteed" := Lguarant."Proportion Guaranteed";
                                        Lguarantx.PercentageGur := Lguarant.PercentageGur;
                                        Lguarantx."Member Substituted" := Lguarant."Member Substituted";
                                        Lguarantx.Modify;
                                    UNTIL Lguarantx.NEXT = 0;
                                end;

                                Lguarantors.Reset;
                                Lguarantors.SetRange(Lguarantors."Loan No", Lguarant."Loan No");
                                Lguarantors.SetRange(Lguarantors."Savings Account No./Member No.", Lguarant."Savings Account No.");
                                if not Lguarantors.Find('-') then begin
                                    Lguarantors.Init;
                                    Lguarantors."Loan No" := Lguarant."Loan No";
                                    Lguarantors."Guarantor Type" := Lguarant."Guarantor Type";
                                    Lguarantors."Staff/Payroll No." := Lguarant."Staff/Payroll No.";
                                    Lguarantors."Collateral Reg. No." := Lguarant."Collateral Reg. No.";
                                    Lguarantors."Collateral Value" := Lguarant."Collateral Value";
                                    Lguarantors."Member No" := Lguarant."Member No";
                                    Lguarantors."Proportion Guaranteed" := Lguarant."Proportion Guaranteed";
                                    Lguarantors."Savings Account No./Member No." := Lguarant."Savings Account No.";
                                    Lguarantors.Name := Lguarant.Name;
                                    Lguarantors."Amount Guaranteed" := Lguarant."Amount Guaranteed";
                                    Lguarantors."Loan Balance" := Lguarant."Loan Balance";
                                    Lguarantors."Deposits/Shares" := Lguarant.Shares;
                                    Lguarantors."Account No." := Lguarant."Member No";
                                    Lguarantors.Substituted := Lguarant.Substituted;
                                    Lguarantors.PercentageGur := Lguarant.PercentageGur;
                                    Lguarantors."ID No." := Lguarant."ID No.";
                                    Lguarantors."Member Substituted" := Lguarant."Member Substituted";
                                    Lguarantors."Loanee Name" := Rec.Name;

                                    SecuritiesRegister.RESET;
                                    SecuritiesRegister.SetRange("Loan No.", Lguarant."Loan No");
                                    if SecuritiesRegister.Find('-') then begin
                                        repeat
                                            SecuritiesRegister."Collateral Substituted" := Lguarant.Substituted;
                                            SecuritiesRegister.MODIFY;
                                        until SecuritiesRegister.NEXT = 0;
                                    end;

                                    //^^SMS

                                    if Members.Get(Lguarant."Member No") then begin
                                        if Loan.Get(Rec."Loan No.") then
                                            Loan.CalcFields("Outstanding Balance");
                                        CompInfo.Get;

                                        // msg := 'Dear Member, You have guaranteed  ' + Rec.Name + ' ' + Loan."Loan Product Type Name" + ' Loan of ' + Format(Loan."Outstanding Balance") +
                                        // // '. If in dispute call';
                                        //                                     msg := 'Dear Member, You are a guarantor for ' + Rec.Name + ' on a ' + Loan."Loan Product Type Name" + '  with an outstanding balance of ' + Format(Loan."Outstanding Balance") +
                                        //    '. If you have any concerns, please contact us.';


                                        //                                     SendSMS.SendSms(Source::LOAN_GUARANTORS, Members."Phone No.", msg, Format(Loan."Disbursement Account No"), '', true, 0, false, 'CBS', Loan."Disbursement Account No", 'CBS');
                                    end;
                                    //SMS
                                    Lguarantors."SMS Sent" := true;
                                    ;

                                    Lguarantors.Insert;
                                end;

                            until Lguarant.Next = 0;
                            if LoanRec.Get(Lguarant."Loan No") then begin
                                Members.Reset();
                                Members.SetRange("No.", LoanRec."Member No.");
                                if Members.FindFirst() then begin
                                    LoanRec.CalcFields("Outstanding Balance");
                                    CompInfo.Get;

                                    msg := 'Dear ' + Members."First Name" + ', Your Guarantor substitution has been done successfully';

                                    SendSMS.SendSms(Source::LOAN_GUARANTORS, Members."Phone No.", msg, Format(Loan."Disbursement Account No"), '', true, 0, false, 'CBS', Loan."Disbursement Account No", 'CBS');
                                end;
                                //outgoing  and incoming guarantor message
                                Lguarant.Reset;
                                Lguarant.SetRange(Lguarant."No.", Rec."No.");
                                Lguarant.SetRange(Substituted, true);
                                if Lguarant.FindFirst then begin
                                    repeat
                                        if Members.Get(Lguarant."Member No") then begin
                                            if Loan.Get(Rec."Loan No.") then
                                                Loan.CalcFields("Outstanding Balance");
                                            CompInfo.Get;
                                            //outgoing
                                            if Lguarant.Substituted = true then begin
                                                msg := 'Dear Member, You have been removed as a guarantor for ' + Rec.Name + ' on a ' + Loan."Loan Product Type Name" + ' loan. For any inquiries, please contact us.';


                                                SendSMS.SendSms(Source::LOAN_GUARANTORS, Members."Phone No.", msg, Format(Loan."Disbursement Account No"), '', true, 0, false, 'CBS', Loan."Disbursement Account No", 'CBS');
                                            end;
                                            //outgoing
                                            //incoming
                                            if Lguarant."Member Substituted" <> '' then begin
                                                msg := 'Dear Member, You are a guarantor for ' + Rec.Name + ' on a ' + Loan."Loan Product Type Name" + ' loan with an outstanding balance of ' + Format(Loan."Outstanding Balance") +
                                                     '. If you have any concerns, please contact us.';

                                                SendSMS.SendSms(Source::LOAN_GUARANTORS, Members."Phone No.", msg, Format(Loan."Disbursement Account No"), '', true, 0, false, 'CBS', Loan."Disbursement Account No", 'CBS');

                                            end;

                                            //incoming
                                        end;
                                    until Lguarant.Next = 0;
                                end;
                                // msg := 'Dear Member, You have guaranteed  ' + Rec.Name + ' ' + Loan."Loan Product Type Name" + ' Loan of ' + Format(Loan."Outstanding Balance") +
                                //         '. If in dispute call';

                                // SendSMS.SendSms(Source::LOAN_GUARANTORS, Members."Phone No.", msg, Format(Loan."Disbursement Account No"), '', true, 0, false, 'CBS', Loan."Disbursement Account No", 'CBS');
                                //outgoing guarantor message

                            end;
                        end;
                        Rec."Posted By" := UserId;
                        Rec.Posted := true;
                        rec.Status := Rec.Status::Posted;
                        Rec."Approval Date" := Today;
                        Rec."Approval Time" := Time;
                        Rec.Modify(true);
                        Message('Changes successfully updated');
                        AppraisaComme.Reset();
                        AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
                        AppraisaComme.SetRange(Commented, false);
                        if AppraisaComme.FindFirst() then begin
                            repeat
                                AppraisaComme.Commented := true;
                                AppraisaComme.Modify();
                            until AppraisaComme.next = 0;
                        end;
                    end;
                }
                // action("CRM Appsaisal Coments")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Guarantor CRM Appraisal comments';
                //     Promoted = true;
                //     PromotedCategory = Category6;
                //     PromotedIsBig = true;
                //     Image = Comment;
                //     RunObject = page 52187231;
                //     RunPageLink = "Loan No." = field("Loan No.");
                // }
                // action("Send Back to CRM")
                // {
                //     ApplicationArea = all;
                //     Image = Return;
                //     Enabled = CRmEdit;
                //     Promoted = true;

                //     PromotedCategory = Category6;
                //     trigger OnAction()
                //     var
                //         AppraisaComme: Record "Loan Appraisal Comments";
                //     begin
                //         Rec.TestField(Status, Rec.Status::Open);

                //         rec.TestField("CRM Application No.");
                //         AppraisaComme.Reset();
                //         AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
                //         AppraisaComme.SetRange(Commented, false);
                //         if not AppraisaComme.FindFirst() then
                //             Error('Appraisal Comments Must have a value')
                //         else
                //             if Confirm('This application will be sent back to CRM for editing. Are you sure you want to proceed?') then begin
                //                 Rec."Sent Back to CRM" := true;
                //                 Rec.Modify;
                //                 Message('Document has been sent back to CRM');
                //                 AppraisaComme.Reset();
                //                 AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
                //                 AppraisaComme.SetRange(Commented, false);
                //                 if AppraisaComme.FindFirst() then begin
                //                     repeat
                //                         AppraisaComme.Commented := true;
                //                         AppraisaComme.Modify();
                //                     until AppraisaComme.next = 0;
                //                 end;

                //             end;
                //         CurrPage.Close();
                //     end;
                // }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        GSubLines: Record "Loan Guarantors Sub";
                        TotalDepo: Decimal;
                    begin
                        Rec.TestField("Loan No.");
                        if Rec.Status <> Rec.Status::Open then
                            Error(DocMustbeOpen);
                        AppraisaComm.Reset();
                        AppraisaComm.SetRange("Loan No.", Rec."Loan No.");
                        AppraisaComm.SetRange(Commented, false);
                        if AppraisaComm.FindFirst() then begin
                            repeat
                                AppraisaComm.Commented := true;
                                AppraisaComm.Modify()
                            until AppraisaComm.Next() = 0
                        end;
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        CurrPage.Close();
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        if Rec.Status <> Rec.Status::Pending then
                            Error(DocMustbePending);
                        AppraisaComm.Reset();
                        AppraisaComm.SetRange("Loan No.", Rec."Loan No.");
                        AppraisaComm.SetRange(Commented, false);
                        if not AppraisaComm.FindFirst() then
                            Error('apprasal comments must have a value');

                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                        AppraisaComm.Reset();
                        AppraisaComm.SetRange("Loan No.", Rec."Loan No.");
                        AppraisaComm.SetRange(Commented, false);
                        if AppraisaComm.FindFirst() then begin
                            repeat
                                AppraisaComm.Commented := true;
                                AppraisaComm.Modify()
                            until AppraisaComm.Next() = 0
                        end;
                        CurrPage.Close();
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = all;
                    Caption = 'Reject';
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        if Confirm('Do you want to cancell this application') = true then begin
                            AppraisaComm.Reset();
                            AppraisaComm.SetRange("Loan No.", Rec."Loan No.");
                            AppraisaComm.SetRange(Commented, false);
                            if not AppraisaComm.FindFirst() then
                                Error('apprasal comments must have a value');
                            if Rec."Loan No." <> '' then begin
                                AppraisaComm.Reset();
                                AppraisaComm.SetRange("Loan No.", Rec."Loan No.");
                                AppraisaComm.SetRange(Commented, false);
                                if AppraisaComm.FindFirst() then begin
                                    repeat
                                        AppraisaComm.Commented := true;
                                        AppraisaComm.Modify()
                                    until AppraisaComm.Next() = 0
                                end;
                                Rec."Rejected By" := UserId;
                                Rec.Status := Rec.Status::Rejected;
                                Rec.Modify();
                            end;
                        end;
                        CurrPage.Close();
                    end;
                }
                action("Deffer Substitution")
                {
                    ApplicationArea = all;
                    Caption = 'Deffer Substitution';
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Image = Documents;
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        AppraisaComm.Reset();
                        AppraisaComm.SetRange("Loan No.", Rec."Loan No.");
                        AppraisaComm.SetRange(Commented, false);
                        if not AppraisaComm.FindFirst() then
                            Error('apprasal comments must have a value');
                        if not Confirm('Do you want to deffer?') then exit;

                        if Rec."Loan No." <> '' then begin

                            AppraisaComm.Reset();
                            AppraisaComm.SetRange("Loan No.", Rec."Loan No.");
                            AppraisaComm.SetRange(Commented, false);
                            if AppraisaComm.FindFirst() then begin
                                repeat
                                    AppraisaComm.Commented := true;
                                    AppraisaComm.Modify()
                                until AppraisaComm.Next() = 0
                            end;
                            Rec.Status := rec.Status::Deffered;
                            Rec.Modify(true);
                        end;
                        CurrPage.Close();

                    end;
                }

                action("Appsaisal Coments")
                {
                    ApplicationArea = all;
                    Caption = 'Guarantor Appraisal comments';
                    Promoted = true;
                    PromotedCategory = Category4;
                    Image = Comment;
                    RunObject = page 52187231;
                    RunPageLink = "Loan No." = field("Loan No.");
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var

                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action(Refresh)
                {
                    ApplicationArea = all;
                    PromotedIsBig = true;
                    Promoted = true;
                    Image = Refresh;
                    PromotedCategory = Category6;
                    trigger OnAction()
                    var
                        myInt: Integer;

                        LoanGr: Record "Loan Guarantors Sub";
                        TotaAmtGUR: Decimal;
                        PercentageGur: Decimal;
                        GuAmt: Decimal;
                        LoanR: Record Loans;
                        REqAmt: Decimal;
                        LONGU: Record "Loan Guarantors Sub";
                        MemberRec: Record Members;
                        OustandBal: Decimal;
                    begin
                        if Rec.Status = Rec.Status::Open then begin
                            if LoanR.Get(Rec."Loan No.") then begin
                                LoanR.CalcFields("Outstanding Balance");
                                OustandBal := LoanR."Outstanding Balance";
                                REqAmt := LoanR."Approved Amount";
                            end;
                            if MemberRec.Get(Rec."Member No.") then
                                if (MemberRec.Status <> MemberRec.Status::Deceased) and (MemberRec.Status <> MemberRec.Status::Closed) then begin
                                    LONGU.Reset();
                                    LONGU.SetRange(LONGU."Loan No", Rec."Loan No.");
                                    LONGU.SetRange("No.", Rec."No.");
                                    LONGU.SetRange(Substituted, false);
                                    if LONGU.Find('-') then begin
                                        LONGU.CalcSums("Amount Guaranteed");
                                        TotaAmtGUR := LONGU."Amount Guaranteed";
                                    end;
                                    PercentageGur := 0;
                                    LONGU.Reset();
                                    LONGU.SetRange(LONGU."Loan No", Rec."Loan No.");
                                    LONGU.SetRange("No.", Rec."No.");
                                    LONGU.SetRange(Substituted, false);
                                    if LONGU.Find('-') then begin
                                        repeat
                                            LONGU.PercentageGur := 0;
                                            LONGU."Proportion Guaranteed" := 0;
                                            if TotaAmtGUR <> 0 then begin
                                                LONGU.PercentageGur := Round((((LONGU."Amount Guaranteed" / TotaAmtGUR) * 100)), 0.01, '=');
                                                LONGU."Proportion Guaranteed" := Round(((OustandBal * LONGU.PercentageGur / 100)), 0.01, '=');
                                                LONGU.Modify();
                                            end;
                                        until LONGU.Next() = 0;
                                    end;
                                end;
                            Message('Calculations Updated');
                        end;

                    end;
                }
                action("Re-Open")
                {
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Caption = 'Re-Open Document';
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        if (Rec.Status <> Rec.Status::Deffered) and (Rec.Status <> Rec.Status::Rejected) and (Rec.Status <> Rec.Status::Approved) then
                            Error('you cannot open a record with status %1', Rec.Status);
                        AppraisaComm.Reset();
                        AppraisaComm.SetRange("Loan No.", Rec."Loan No.");
                        AppraisaComm.SetRange(Commented, false);
                        if not AppraisaComm.FindFirst() then
                            Error('apprasal comments must have a value');

                        if rec."Loan No." <> '' then begin
                            AppraisaComm.Reset();
                            AppraisaComm.SetRange("Loan No.", Rec."Loan No.");
                            AppraisaComm.SetRange(Commented, false);
                            if AppraisaComm.FindFirst() then begin
                                repeat
                                    AppraisaComm.Commented := true;
                                    AppraisaComm.Modify()
                                until AppraisaComm.Next() = 0
                            end;
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify(true);
                        end;

                    end;
                }
            }

            // group("EDMS Integration")
            // {
            //     action("Import")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Import File';
            //         Promoted = true;
            //         PromotedCategory = Category7;
            //         Image = Import;

            //         trigger OnAction()
            //         var
            //             Base64Convert: Codeunit "Base64 Convert";
            //             TempBlob: Codeunit "Temp Blob";
            //             InStr: InStream;

            //             EDMSFunctions: Codeunit "EDMS Functions";
            //             FileName: Text;
            //             FileContentsB64: Text;
            //         begin
            //             if Rec."Loan No." <> '' then begin
            //                 FileName := EDMSFunctions.PickEDMSFile(TempBlob);

            //                 TempBlob.CreateInStream(InStr);
            //                 FileContentsB64 := Base64Convert.ToBase64(InStr);

            //                 if FileContentsB64 <> '' then begin
            //                     UploadToEDMS(Rec, FileName, FileContentsB64);
            //                 end;
            //             end else begin
            //                 Error('Application No. is required for EDMS document upload');
            //             end;
            //         end;
            //     }
            //     action("EDMS File List")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = Documents;
            //         Promoted = true;
            //         PromotedCategory = Category7;

            //         RunObject = page "EDMS Files List";
            //         RunPageLink = "Application No." = field("No.");
            //         // RunPageMode = Create;
            //     }
            // }
            // action(Refresh)
            // {
            //     ApplicationArea = all;
            //     PromotedIsBig = true;
            //     Promoted = true;
            //     Image = Refresh;
            //     // PromotedCategory = Category8;
            //     trigger OnAction()
            //     var
            //         myInt: Integer;

            //         LoanGr: Record "Loan Guarantors Sub";
            //         TotaAmtGUR: Decimal;
            //         PercentageGur: Decimal;
            //         GuAmt: Decimal;
            //         LoanR: Record Loans;
            //         REqAmt: Decimal;
            //         LONGU: Record "Loan Guarantors Sub";
            //         MemberRec: Record Members;
            //         OustandBal: Decimal;
            //     begin
            //         if Rec.Status = Rec.Status::Open then begin
            //             if LoanR.Get(Rec."Loan No.") then begin
            //                 LoanR.CalcFields("Outstanding Balance");
            //                 OustandBal := LoanR."Outstanding Balance";
            //                 REqAmt := LoanR."Approved Amount";
            //             end;
            //             if MemberRec.Get(Rec."Member No.") then
            //                 if (MemberRec.Status <> MemberRec.Status::Deceased) and (MemberRec.Status <> MemberRec.Status::Closed) then begin
            //                     LONGU.Reset();
            //                     LONGU.SetRange(LONGU."Loan No", Rec."Loan No.");
            //                     LONGU.SetRange("No.", Rec."No.");
            //                     LONGU.SetRange(Substituted, false);
            //                     if LONGU.Find('-') then begin
            //                         LONGU.CalcSums("Amount Guaranteed");
            //                         TotaAmtGUR := LONGU."Amount Guaranteed";
            //                     end;
            //                     PercentageGur := 0;
            //                     LONGU.Reset();
            //                     LONGU.SetRange(LONGU."Loan No", Rec."Loan No.");
            //                     LONGU.SetRange("No.", Rec."No.");
            //                     LONGU.SetRange(Substituted, false);
            //                     if LONGU.Find('-') then begin
            //                         repeat
            //                             LONGU.PercentageGur := 0;
            //                             LONGU."Proportion Guaranteed" := 0;
            //                             if TotaAmtGUR <> 0 then begin
            //                                 LONGU.PercentageGur := Round((((LONGU."Amount Guaranteed" / TotaAmtGUR) * 100)), 0.01, '=');
            //                                 LONGU."Proportion Guaranteed" := Round(((OustandBal * LONGU.PercentageGur / 100)), 0.01, '=');
            //                                 LONGU.Modify();
            //                             end;
            //                         until LONGU.Next() = 0;
            //                     end;
            //                 end;
            //             Message('Calculations Updated');
            //         end;

            //     end;
            // }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;

        LoanGr: Record "Loan Guarantors Sub";
        TotaAmtGUR: Decimal;
        PercentageGur: Decimal;
        GuAmt: Decimal;
        LoanR: Record Loans;
        REqAmt: Decimal;
        LONGU: Record "Loan Guarantors Sub";
        MemberRec: Record Members;
        OustandBal: Decimal;

    begin
        OustandBal := 0;
        REqAmt := 0;
        SetControlAppearance;
        if Rec.Status = Rec.Status::Open then begin
            if LoanR.Get(Rec."Loan No.") then begin
                LoanR.CalcFields("Outstanding Balance");
                OustandBal := LoanR."Outstanding Balance";
                REqAmt := LoanR."Approved Amount";
            end;
            if MemberRec.Get(Rec."Member No.") then
                if (MemberRec.Status <> MemberRec.Status::Deceased) and (MemberRec.Status <> MemberRec.Status::Closed) then begin
                    LONGU.Reset();
                    LONGU.SetRange(LONGU."Loan No", Rec."Loan No.");
                    LONGU.SetRange("No.", Rec."No.");
                    LONGU.SetRange(Substituted, false);
                    if LONGU.Find('-') then begin
                        LONGU.CalcSums("Amount Guaranteed");
                        TotaAmtGUR := LONGU."Amount Guaranteed";
                    end;
                    PercentageGur := 0;
                    LONGU.Reset();
                    LONGU.SetRange(LONGU."Loan No", Rec."Loan No.");
                    LONGU.SetRange("No.", Rec."No.");
                    LONGU.SetRange(Substituted, false);
                    if LONGU.Find('-') then begin
                        repeat
                            LONGU.PercentageGur := 0;
                            LONGU."Proportion Guaranteed" := 0;
                            if TotaAmtGUR <> 0 then begin
                                LONGU.PercentageGur := Round((((LONGU."Amount Guaranteed" / TotaAmtGUR) * 100)), 0.01, '=');
                                LONGU."Proportion Guaranteed" := Round(((OustandBal * LONGU.PercentageGur / 100)), 0.01, '=');
                                LONGU.Modify();
                            end;
                        until LONGU.Next() = 0;
                    end;
                end;
        end;
    end;

    trigger OnAfterGetRecord()
    var
        LoanGr: Record "Loan Guarantors Sub";
        TotaAmtGUR: Decimal;
        PercentageGur: Decimal;
        GuAmt: Decimal;
        LoanR: Record Loans;
        REqAmt: Decimal;
        LONGU: Record "Loan Guarantors Sub";
        MemberRec: Record Members;
        OustandBal: Decimal;

    begin
        OustandBal := 0;
        REqAmt := 0;
        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
        SetControlAppearance;
        LInesEditable;
        if Rec.Status = Rec.Status::Open then begin
            if LoanR.Get(Rec."Loan No.") then begin
                LoanR.CalcFields("Outstanding Balance");
                OustandBal := LoanR."Outstanding Balance";
                REqAmt := LoanR."Approved Amount";
            end;
            if MemberRec.Get(Rec."Member No.") then
                if (MemberRec.Status <> MemberRec.Status::Deceased) and (MemberRec.Status <> MemberRec.Status::Closed) then begin
                    LONGU.Reset();
                    LONGU.SetRange(LONGU."Loan No", Rec."Loan No.");
                    LONGU.SetRange("No.", Rec."No.");
                    LONGU.SetRange(Substituted, false);
                    if LONGU.Find('-') then begin
                        LONGU.CalcSums("Amount Guaranteed");
                        TotaAmtGUR := LONGU."Amount Guaranteed";
                    end;
                    PercentageGur := 0;
                    LONGU.Reset();
                    LONGU.SetRange(LONGU."Loan No", Rec."Loan No.");
                    LONGU.SetRange("No.", Rec."No.");
                    LONGU.SetRange(Substituted, false);
                    if LONGU.Find('-') then begin
                        repeat
                            LONGU.PercentageGur := 0;
                            LONGU."Proportion Guaranteed" := 0;
                            if TotaAmtGUR <> 0 then begin
                                LONGU.PercentageGur := Round((((LONGU."Amount Guaranteed" / TotaAmtGUR) * 100)), 0.01, '=');
                                LONGU."Proportion Guaranteed" := Round(((OustandBal * LONGU.PercentageGur / 100)), 0.01, '=');
                                LONGU.Modify();
                            end;
                        until LONGU.Next() = 0;
                    end;
                end;
        end;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        LInesEditable;
    end;

    trigger OnOpenPage()
    begin
        LInesEditable;
        SetControlAppearance();
    end;

    trigger OnClosePage()
    var
        myInt: Integer;
        LoanGr: Record "Loan Guarantors Sub";
        TotaAmtGUR: Decimal;
        PercentageGur: Decimal;
        GuAmt: Decimal;
        LoanR: Record Loans;
        REqAmt: Decimal;
        LONGU: Record "Loan Guarantors Sub";
        MemberRec: Record Members;
        OustandBal: Decimal;
    begin
        OustandBal := 0;
        REqAmt := 0;
        if Rec.Status = Rec.Status::Open then begin
            if LoanR.Get(Rec."Loan No.") then begin
                LoanR.CalcFields("Outstanding Balance");
                OustandBal := LoanR."Outstanding Balance";
                REqAmt := LoanR."Approved Amount";
            end;
            if MemberRec.Get(Rec."Member No.") then
                if (MemberRec.Status <> MemberRec.Status::Deceased) and (MemberRec.Status <> MemberRec.Status::Closed) then begin
                    LONGU.Reset();
                    LONGU.SetRange(LONGU."Loan No", Rec."Loan No.");
                    LONGU.SetRange("No.", Rec."No.");
                    LONGU.SetRange(Substituted, false);
                    if LONGU.Find('-') then begin
                        LONGU.CalcSums("Amount Guaranteed");
                        TotaAmtGUR := LONGU."Amount Guaranteed";
                    end;
                    PercentageGur := 0;
                    LONGU.Reset();
                    LONGU.SetRange(LONGU."Loan No", Rec."Loan No.");
                    LONGU.SetRange("No.", Rec."No.");
                    LONGU.SetRange(Substituted, false);
                    if LONGU.Find('-') then begin
                        repeat
                            LONGU.PercentageGur := 0;
                            LONGU."Proportion Guaranteed" := 0;
                            if TotaAmtGUR <> 0 then begin
                                LONGU.PercentageGur := Round((((LONGU."Amount Guaranteed" / TotaAmtGUR) * 100)), 0.01, '=');
                                LONGU."Proportion Guaranteed" := Round(((OustandBal * LONGU.PercentageGur / 100)), 0.01, '=');
                                LONGU.Modify();
                            end;
                        until LONGU.Next() = 0;
                    end;
                end;
        end;
    end;


    procedure UploadToEDMS(Rec: Record "Guarantors Substitution"; FileName: Text; FileContentsB64: Text)
    var
        EDMSFunctions: Codeunit "EDMS Functions";

        ApplicantMember: Record Members;
        Loan: Record Loans;

        IDNumber: Text;
        ApplicationType: Label 'LGS'; // Loan Guarantor Substitution
        PFNumber: Text;
    begin
        Loan.Reset;
        Loan.SetRange("Loan No.", Rec."Loan No.");

        if Loan.FindFirst then begin

            ApplicantMember.Reset;

            ApplicantMember.SetRange("No.", Loan."Member No.");

            if ApplicantMember.FindFirst then begin
                if ApplicantMember."Primary Identification Type" = ApplicantMember."Primary Identification Type"::"ID Number" then begin
                    IDNumber := ApplicantMember."Primary Identification";
                end else
                    if ApplicantMember."Secondary Identification Type" = ApplicantMember."Secondary Identification Type"::"ID Number" then begin
                        IDNumber := ApplicantMember."Secondary Identification";
                    end else begin
                        IDNumber := ApplicantMember."Primary Identification";
                    end;

                if ApplicantMember."Payroll/Staff No." <> '' then begin
                    PFNumber := ApplicantMember."Payroll/Staff No.";
                end else begin
                    PFNumber := IDNumber;
                end;

                Loan.Reset;
                Loan.SetRange("Loan No.", Rec."Loan No.");

                EDMSFunctions.EDMSLoanFileUpload(
                    IDNumber,
                    ApplicantMember.Name,
                    Loan."Loan Product Type Name",
                    PfNumber,
                    ApplicantMember."No.",
                    Rec."No.",
                    Rec."Loan No.",
                    FileName,
                    FileContentsB64,
                    false
                );
            end;
        end;
    end;

    var
        Lguarant: Record "Loan Guarantors Sub";
        Lguarantx: Record "Loan Guarantors and Security";
        Lguarantors: Record "Loan Guarantors and Security";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        AppraisaComm: Record "Loan Appraisal Comments";
        DocMustbeOpen: Label 'This application request must be open';
        DocMustbePending: Label 'This application request must be Pending';
        DocMustbeApproved: Label 'This document must be approved before updating';
        Err: Label 'Changes have been Done';
        LoanGua: Record "Loan Guarantors and Security";
        LinesEdit: Boolean;
        Members: Record Members;
        CompInfo: Record "Company Information";
        SendSMS: Codeunit SendSms;
        Source: Enum "SMS Source";
        msg: Text;
        Loan: Record Loans;
        CRmEdit: Boolean;
        SecuritiesRegister: Record "Securities Register";

    local procedure SetControlAppearance()
    var
    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if Rec.Status = Rec.Status::Open then
            CurrPage.Editable := true
        else
            CurrPage.Editable := false;

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);

        if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Pending) then begin
            LinesEdit := false;
            CRmEdit := false;
        end else begin
            LinesEdit := true;
            CRmEdit := true;
        end;
    end;

    //[Scope('OnPrem')]
    procedure LInesEditable()
    begin
        if (Rec.Status = Rec.Status::Pending) or (Rec.Status = Rec.Status::Approved) then begin
            CurrPage.Editable := false;
            LinesEdit := false;
        end;

        if Rec.Status = Rec.Status::Open then
            LinesEdit := true;
    end;
}

