page 52186010 "Posted Staff Advance Account"
{
    Caption = 'Work Advance Retirement';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Staff Advance Surrender Header";
    SourceTableView = WHERE(Posted = CONST(true));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Surrender Date"; Rec."Surrender Date")
                // {
                //     Editable = "Surrender DateEditable";
                // }
                // field("Account No."; Rec."Account No.")
                // {
                //     Editable = "Account No.Editable";

                //     trigger OnValidate()
                //     begin
                //         AccountName := GetCustName("Account No.");
                //     end;
                // }
                // field(AccountName; Rec.AccountName)
                // {
                //     Editable = false;
                // }
                // field("Imprest Issue Doc. No"; Rec."Imprest Issue Doc. No")
                // {
                //     Editable = "Imprest Issue Doc. NoEditable";
                // }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Difference; Rec.Difference)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Imprest Issue Date"; Rec."Imprest Issue Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Advance Issue Date';
                    Editable = false;
                }
                // field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                // {
                //     Editable = false;

                //     trigger OnValidate()
                //     begin
                //         DimName1 := GetDimensionName("Global Dimension 1 Code", 1);
                //     end;
                // }
                // field(DimName1; Rec.DimName1)
                // {
                //     Editable = false;
                // }
                // field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                // {
                //     Editable = false;

                //     trigger OnValidate()
                //     begin
                //         DimName2 := GetDimensionName("Global Dimension 2 Code", 2);
                //     end;
                // }
                // field(DimName2; Rec.DimName2)
                // {
                //     Editable = false;
                // }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Bank Code"; Rec."Bank Code")
                // {
                //     Editable = "Surrender Posting DateEditable";
                // }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("Responsibility Center"; Rec."Responsibility Center")
                // {
                //     Editable = "Responsibility CenterEditable";
                // }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("Surrender Posting Date"; Rec."Surrender Posting Date")
                // {
                //     Caption = 'Retire Posting date';
                //     Editable = "Surrender Posting DateEditable";
                // }
                field("Allow Overexpenditure"; Rec."Allow Overexpenditure")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Open for Overexpenditure by"; Rec."Open for Overexpenditure by")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date opened for OvExpenditure"; Rec."Date opened for OvExpenditure")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            // part(ImprestLines; "Staff Advanc Surrender Details")
            // {
            //     Editable = ImprestLinesEditable;
            //     SubPageLink = "Surrender Doc No." = FIELD(No);
            // }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("Cancel Document")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;

                    // trigger OnAction()
                    // begin
                    //     //Post Committment Reversals
                    //     TestField(Status, Status::Approved);
                    //     if Confirm(Text002, true) then begin
                    //         Doc_Type := Doc_Type::Imprest;
                    //         BudgetControl.ReverseEntries(Doc_Type, "Imprest Issue Doc. No");
                    //         Status := Status::Cancelled;
                    //         Modify;
                    //     end;
                    // end;
                }
                separator(Action1102755015)
                {
                }
                action("Open for OverExpenditure")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Open for OverExpenditure';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //Opening should only be for Pending Documents
                        //TESTFIELD(Status,Status::Pending);
                        //Open for Overexpenditure
                        Rec."Allow Overexpenditure" := true;
                        Rec."Open for Overexpenditure by" := UserId;
                        Rec."Date opened for OvExpenditure" := Today;
                        Rec.Modify;
                        //Open lines

                        //here
                        // Payline.Reset;
                        // Payline.SetRange(Payline."Surrender Doc No.", No);
                        // if Payline.Find('-') then begin
                        //     repeat
                        //         Payline."Allow Overexpenditure" := true;
                        //         Payline."Open for Overexpenditure by" := UserId;
                        //         Payline."Date opened for OvExpenditure" := Today;
                        //         Payline.Modify;
                        //     until Payline.Next = 0;
                        // end;
                        //End open for Overexpenditure
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.Reset;
                        Rec.SetFilter(No, Rec.No);
                        //REPORT.Run(52185778, true, true, Rec);
                        Rec.Reset;
                    end;
                }
                action(Upload)
                {
                    ApplicationArea = Basic, Suite;
                    Image = TransmitElectronicDoc;

                    trigger OnAction()
                    var
                        vartest: Variant;
                        TestFile: File;
                        FilePath: Text;
                        FileName: Text;
                        DocNo: Code[20];
                        varLink: Text;
                        DocRecRef: RecordRef;
                        MyFieldRef: FieldRef;
                        LinkId: Integer;
                        CopyFrom: Text;
                        CopyTo: Text;
                    begin
                        // if Upload('Upload file', 'C:\', 'Text file(*.txt)|*.txt|PDF file(*.pdf)|*.pdf|EXCEL File(*.xlsx)|*.xlsx|WORD File(*.docx)|*.docx|ALL Files(*.*)|*.*', 'Upload.txt', vartest) then begin
                        //     Message('File successfully uploaded to the server', vartest);
                        //TestFile.OPEN(vartest);
                        //FileName:=TestFile.NAME;
                        //MESSAGE('%1',FileName);

                        DocNo := Rec.No;
                        DocRecRef.Open(DATABASE::"Staff Advance Surrender Header");
                        MyFieldRef := DocRecRef.Field(1);
                        MyFieldRef.Value := DocNo;
                        if DocRecRef.Find('=') then begin
                            LinkId := DocRecRef.AddLink(vartest);
                            //here
                            // RecordLinks.Get(LinkId);
                            // RecordLinks.Validate(Type);
                            //  MESSAGE('link %1 added successfully',LinkId);
                            /*
                            //taken to record links table for server side processing
                            RecordLinks.GET(LinkId);
                            CopyFrom:=RecordLinks.URL1;
                            FileName:=GetFileName(RecordLinks.URL1);
                            CopyTo:='C:\NavAttachments\'+FileName;
                            FILE.COPY(CopyFrom,CopyTo);
                            RecordLinks.URL1:=CopyTo;
                            RecordLinks.Description:=FileName;
                            RecordLinks.MODIFY;
                            */
                        end
                        else
                            Message('Link not added');

                        // end
                        // else
                        //     Error('File not Successfully uploaded');

                    end;
                }
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
                    // // //ApprovalEntries: Page "Approval Entries";
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*
                        DocumentType := DocumentType::"Payment Voucher";
                        ApprovalEntries.SetRecordFilters(DATABASE::"Payments Header","Document Type","No.");
                        ApprovalEntries.RUN;
                        */
                        //here//ApprovalsMgmt.OpenApprovalEntriesPage(RecordId)

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPageUpdate;
    end;

    trigger OnInit()
    begin
        ImprestLinesEditable := true;
        "Surrender Posting DateEditable" := true;
        "Responsibility CenterEditable" := true;
        "Imprest Issue Doc. NoEditable" := true;
        "Surrender DateEditable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        //check if the documenent has been added while another one is still pending
        TravAccHeader.Reset;
        TravAccHeader.SetRange(TravAccHeader.Cashier, UserId);
        TravAccHeader.SetRange(TravAccHeader.Status, Rec.Status::Pending);

        if TravAccHeader.Count > 0 then begin
            Error('There are still some pending document(s) on your account. Please list & select the pending document to use.  ');
        end;
        //*********************************END ****************************************//

        Rec."User ID" := UserId;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //here//"Responsibility Center" := UserMgt.GetPurchasesFilter();
        //OnAfGetCurrRecord;
        UpdateControls;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        //SETFILTER(Status,'<>Cancelled');

        /*
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center" ,UserMgt.GetPurchasesFilter());
          FILTERGROUP(0);
        END;
        */

    end;

    var
        RecPayTypes: Record "Receipts and Payment Types";
        TarriffCodes: Record "Tariff Code s";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cash Office User Template";
        LineNo: Integer;
        NextEntryNo: Integer;
        CommitNo: Integer;
        ImprestDetails: Record "Staff Advanc Surrender Details";
        EntryNo: Integer;
        GLAccount: Record "G/L Account";
        IsImprest: Boolean;
        GenledSetup: Record "Cash Office Setup";
        ImprestAmt: Decimal;
        DimName1: Text[60];
        DimName2: Text[60];
        // CashPaymentLine: Record "Cash Payment Line";
        PaymentLine: Record "Staff Advance Lines";
        CurrSurrDocNo: Code[20];
        //here//JournalPostSuccessful: Codeunit "Journal Post Successful";
        Commitments: Record Committment;
        BCSetup: Record "Budgetary Control Setup";
        //here//BudgetControl: Codeunit "Budgetary Control";
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance,StaffSurrender;
        ImprestReq: Record "Staff Advance Header";
        //here//UserMgt: Codeunit "User Setup Management BR";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        AccountName: Text[100];
        Text000: Label 'You have not specified the Actual Amount Spent. This document will only reverse the committment and you will have to receipt the total amount returned.';
        Text001: Label 'Document Not Posted';
        //here//AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        Text002: Label 'Are you sure you want to Cancel this Document?';
        TravAccHeader: Record "Staff Advance Surrender Header";
        //here//CheckBudgetAvail: Codeunit "Budgetary Control";
        Payline: Record "Staff Advanc Surrender Details";
        Temp: Record "Cash Office User Template";
        SurrBatch: Code[10];
        SurrTemplate: Code[10];

        "Surrender DateEditable": Boolean;

        "Account No.Editable": Boolean;

        "Imprest Issue Doc. NoEditable": Boolean;

        "Responsibility CenterEditable": Boolean;

        "Surrender Posting DateEditable": Boolean;

        ImprestLinesEditable: Boolean;
        Text19053222: Label 'Enter Advance Accounting Details below';
        StatusEditable: Boolean;
        RecRef: RecordRef;
        RecordLinks: Record "Record Link";
        FileName: Text;

    //[Scope('OnPrem')]
    procedure GetDimensionName(var "Code": Code[20]; DimNo: Integer) Name: Text[60]
    var
        GLSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
    begin
        /*Get the global dimension 1 and 2 from the database*/
        Name := '';

        GLSetup.Reset;
        GLSetup.Get();

        DimVal.Reset;
        DimVal.SetRange(DimVal.Code, Code);

        if DimNo = 1 then begin
            DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 1 Code");
        end
        else
            if DimNo = 2 then begin
                DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 2 Code");
            end;
        if DimVal.Find('-') then begin
            Name := DimVal.Name;
        end;

    end;

    //[Scope('OnPrem')]
    procedure UpdateControls()
    begin
        if Rec.Status <> Rec.Status::Pending then begin
            "Surrender DateEditable" := false;
            "Account No.Editable" := false;
            "Imprest Issue Doc. NoEditable" := false;
            "Responsibility CenterEditable" := true;
            "Surrender Posting DateEditable" := true;
            //   ImprestLinesEditable :=FALSE;
        end else begin
            "Surrender DateEditable" := true;
            "Account No.Editable" := true;
            "Imprest Issue Doc. NoEditable" := true;
            "Responsibility CenterEditable" := true;
            "Surrender Posting DateEditable" := false;
            //   ImprestLinesEditable :=TRUE;

        end;
    end;

    //[Scope('OnPrem')]
    procedure GetCustName(No: Code[20]) Name: Text[100]
    var
        Cust: Record Customer;
    begin
        Name := '';
        if Cust.Get(No) then
            Name := Cust.Name;
        exit(Name);
    end;

    //[Scope('OnPrem')]
    procedure UpdateforNoActualSpent()
    begin
        Rec.Posted := true;
        Rec.Status := Rec.Status::Posted;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;
        Rec.Modify;
        //Tag the Source Imprest Requisition as Surrendered
        ImprestReq.Reset;
        ImprestReq.SetRange(ImprestReq."No.", Rec."Imprest Issue Doc. No");
        if ImprestReq.Find('-') then begin
            ImprestReq."Surrender Status" := ImprestReq."Surrender Status"::Full;
            ImprestReq.Modify;
        end;
        //End Tag
        //Post Committment Reversals
        Doc_Type := Doc_Type::StaffSurrender;
        //here//BudgetControl.ReverseEntries(Doc_Type, "Imprest Issue Doc. No");
    end;

    //[Scope('OnPrem')]
    procedure CompareAllAmounts()
    begin
    end;

    //[Scope('OnPrem')]
    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCsetup: Record "Budgetary Control Setup";
    begin
        if BCsetup.Get() then begin
            if not BCsetup.Mandatory then begin
                Exists := false;
                exit;
            end;
        end else begin
            Exists := false;
            exit;
        end;
        Exists := false;
        Payline.Reset;
        Payline.SetRange(Payline."Surrender Doc No.", Rec.No);
        Payline.SetRange(Payline.Committed, false);
        Payline.SetRange(Payline."Budgetary Control A/C", true);
        if Payline.Find('-') then
            Exists := true;
    end;

    local procedure OnAfGetCurrRecord()
    begin
        /*
        xRec := Rec;
        //Update Controls as necessary
        //SETFILTER(Status,'<>Cancelled');
        UpdateControl;
        DimName1:=GetDimensionName("Global Dimension 1 Code",1);
        DimName2:=GetDimensionName("Shortcut Dimension 2 Code",2);
        AccountName:=GetCustName("Account No.");
        */

    end;

    //[Scope('OnPrem')]
    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        AccountName := GetCustName(Rec."Account No.");
        DimName1 := GetDimensionName(Rec."Global Dimension 1 Code", 1);
        DimName2 := GetDimensionName(Rec."Global Dimension 2 Code", 2);
        CurrPage.Update;
    end;

    //[Scope('OnPrem')]
    procedure InsertBalancing()
    begin
        //insert customer balancing
        LineNo := LineNo + 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := SurrTemplate;
        GenJnlLine."Journal Batch Name" := SurrBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := Rec."Account No.";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        //Set these fields to blanks
        GenJnlLine."Posting Date" := Rec."Surrender Posting Date";
        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
        GenJnlLine.Validate("Gen. Posting Type");
        GenJnlLine."Gen. Bus. Posting Group" := '';
        GenJnlLine.Validate("Gen. Bus. Posting Group");
        GenJnlLine."Gen. Prod. Posting Group" := '';
        GenJnlLine.Validate("Gen. Prod. Posting Group");
        GenJnlLine."VAT Bus. Posting Group" := '';
        GenJnlLine.Validate("VAT Bus. Posting Group");
        GenJnlLine."VAT Prod. Posting Group" := '';
        GenJnlLine.Validate("VAT Prod. Posting Group");
        GenJnlLine."Document No." := Rec.No;
        //Rec.CALCFIELDS(Difference);
        GenJnlLine.Amount := -Rec.Amount;//ImprestDetails."Actual Spent";
        GenJnlLine.Validate(GenJnlLine.Amount);
        //GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::Customer;
        //GenJnlLine."Bal. Account No.":=ImprestDetails."Advance Holder";
        GenJnlLine.Description := 'Advance Surrendered by staff';
        //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        GenJnlLine."Currency Code" := Rec."Currency Code";
        GenJnlLine.Validate("Currency Code");
        //Take care of Currency Factor
        GenJnlLine."Currency Factor" := Rec."Currency Factor";
        GenJnlLine.Validate("Currency Factor");

        GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

        //Application of Surrender entries
        if GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer then begin
            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
            GenJnlLine."Applies-to Doc. No." := Rec."Imprest Issue Doc. No";
            GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
            GenJnlLine."Applies-to ID" := Rec."Apply to ID";
        end;

        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;


        LineNo := LineNo + 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := SurrTemplate;
        GenJnlLine."Journal Batch Name" := SurrBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := Rec."Bank Code";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        //Set these fields to blanks
        GenJnlLine."Posting Date" := Rec."Surrender Posting Date";
        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
        GenJnlLine.Validate("Gen. Posting Type");
        GenJnlLine."Gen. Bus. Posting Group" := '';
        GenJnlLine.Validate("Gen. Bus. Posting Group");
        GenJnlLine."Gen. Prod. Posting Group" := '';
        GenJnlLine.Validate("Gen. Prod. Posting Group");
        GenJnlLine."VAT Bus. Posting Group" := '';
        GenJnlLine.Validate("VAT Bus. Posting Group");
        GenJnlLine."VAT Prod. Posting Group" := '';
        GenJnlLine.Validate("VAT Prod. Posting Group");
        GenJnlLine."Document No." := Rec.No;
        Rec.CalcFields(Difference);
        GenJnlLine.Amount := Rec.Difference;
        GenJnlLine.Validate(GenJnlLine.Amount);
        //GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::Customer;
        //GenJnlLine."Bal. Account No.":=ImprestDetails."Advance Holder";
        GenJnlLine.Description := 'Advance Surrendered by staff';
        //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        GenJnlLine."Currency Code" := Rec."Currency Code";
        GenJnlLine.Validate("Currency Code");
        //Take care of Currency Factor
        GenJnlLine."Currency Factor" := Rec."Currency Factor";
        GenJnlLine.Validate("Currency Factor");

        GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

        //Application of Surrender entries
        if GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer then begin
            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
            GenJnlLine."Applies-to Doc. No." := Rec."Imprest Issue Doc. No";
            GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
            GenJnlLine."Applies-to ID" := Rec."Apply to ID";
        end;

        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
    end;
}

