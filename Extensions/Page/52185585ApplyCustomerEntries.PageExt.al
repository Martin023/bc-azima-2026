#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185585 pageextension52185585 extends "Apply Customer Entries"
{
    layout
    {
        modify("ApplyingCustLedgEntry.""Posting Date""")
        {
            ApplicationArea = Basic;
        }
        modify("ApplyingCustLedgEntry.""Document Type""")
        {
            ApplicationArea = Basic;
        }
        modify("ApplyingCustLedgEntry.""Document No.""")
        {
            ApplicationArea = Basic;
        }
        modify(ApplyingCustomerNo)
        {

            //Unsupported feature: Property Modification (Name) on "ApplyingCustomerNo(Control 71)".

            ApplicationArea = Basic;
        }
        modify(ApplyingDescription)
        {

            //Unsupported feature: Property Modification (Name) on "ApplyingDescription(Control 85)".

            ApplicationArea = Basic;
        }
        modify("ApplyingCustLedgEntry.""Currency Code""")
        {
            ApplicationArea = Basic;
        }
        modify("ApplyingCustLedgEntry.Amount")
        {
            ApplicationArea = Basic;
        }
        modify("ApplyingCustLedgEntry.""Remaining Amount""")
        {
            ApplicationArea = Basic;
        }
        // modify(AppliesToID)
        // {

        //     //Unsupported feature: Property Modification (Name) on "AppliesToID(Control 22)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Visible) on "AppliesToID(Control 22)".

        // }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Original Amount")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Amount")
        {
            ApplicationArea = Basic;
        }
        modify("CalcApplnRemainingAmount(""Remaining Amount"")")
        {
            ApplicationArea = Basic;
        }
        modify("Amount to Apply")
        {
            ApplicationArea = Basic;
        }
        modify(ApplnAmountToApply)
        {

            //Unsupported feature: Property Modification (Name) on "ApplnAmountToApply(Control 93)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "ApplnAmountToApply(Control 93)".

        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Pmt. Discount Date")
        {
            ApplicationArea = Basic;
        }
        modify("Pmt. Disc. Tolerance Date")
        {
            ApplicationArea = Basic;
        }
        modify("Original Pmt. Disc. Possible")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            ApplicationArea = Basic;
        }
        modify("CalcApplnRemainingAmount(""Remaining Pmt. Disc. Possible"")")
        {
            ApplicationArea = Basic;
        }
        modify("Max. Payment Tolerance")
        {
            ApplicationArea = Basic;
        }
        modify(Open)
        {
            ApplicationArea = Basic;
        }
        modify(Positive)
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify(ApplnCurrencyCode)
        {
            ApplicationArea = Basic;
        }
        modify(AmountToApply)
        {
            ApplicationArea = Basic;
        }
        modify(PmtDiscountAmount)
        {

            //Unsupported feature: Property Modification (Name) on "PmtDiscountAmount(Control 91)".

            ApplicationArea = Basic;
        }
        modify(ApplnRounding)
        {
            ApplicationArea = Basic;
        }
        modify(AppliedAmount)
        {
            ApplicationArea = Basic;
        }
        modify(ApplyingAmount)
        {
            ApplicationArea = Basic;
        }
        modify(ControlBalance)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""ApplyingCustLedgEntry.""Posting Date"""(Control 73)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ApplyingCustLedgEntry.""Document Type"""(Control 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ApplyingCustLedgEntry.""Document No."""(Control 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApplyingCustomerNo(Control 71)".


        //Unsupported feature: Property Deletion (Visible) on "ApplyingCustomerNo(Control 71)".

        modify(ApplyingCustomerName)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ApplyingDescription(Control 85)".


        //Unsupported feature: Property Deletion (Visible) on "ApplyingDescription(Control 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ApplyingCustLedgEntry.""Currency Code"""(Control 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ApplyingCustLedgEntry.Amount"(Control 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ApplyingCustLedgEntry.""Remaining Amount"""(Control 83)".

        modify(AppliesToID)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "AppliesToID(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 8)".

        modify("Customer Name")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Original Amount"(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 12)".

        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Amount"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CalcApplnRemainingAmount(""Remaining Amount"")"(Control 33)".


        //Unsupported feature: Code Modification on ""Amount to Apply"(Control 89).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit",Rec);

        IF (xRec."Amount to Apply" = 0) OR ("Amount to Apply" = 0) AND
           ((ApplnType = ApplnType::"Applies-to ID") OR (CalcType = CalcType::Direct))
        THEN
          SetCustApplId(FALSE);
        GET("Entry No.");
        AmountToApplyOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
           (ApplnType = ApplnType::"Applies-to ID")
        THEN
          SetCustApplId;
        GET("Entry No.");
        AmounttoApplyOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount to Apply"(Control 89)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApplnAmountToApply(Control 93)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Discount Date"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Disc. Tolerance Date"(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Original Pmt. Disc. Possible"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Pmt. Disc. Possible"(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CalcApplnRemainingAmount(""Remaining Pmt. Disc. Possible"")"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Max. Payment Tolerance"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Open(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Positive(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApplnCurrencyCode(Control 48)".


        //Unsupported feature: Property Deletion (ShowCaption) on "ApplnCurrencyCode(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountToApply(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PmtDiscountAmount(Control 91)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApplnRounding(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AppliedAmount(Control 97)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApplyingAmount(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ControlBalance(Control 42)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1903096107(Control 1903096107)".

    }
    actions
    {
        modify("Reminder/Fin. Charge Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Applied E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Detailed &Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        // modify("Show Only Selected Entries to Be Applied")
        // {
        //     Caption = 'Preview Posting';
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Image) on ""Show Only Selected Entries to Be Applied"(Action 3)".


        //     //Unsupported feature: Property Modification (Name) on ""Show Only Selected Entries to Be Applied"(Action 3)".

        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Reminder/Fin. Charge Entries"(Action 38)".


        //Unsupported feature: Property Deletion (Promoted) on ""Reminder/Fin. Charge Entries"(Action 38)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Reminder/Fin. Charge Entries"(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applied E&ntries"(Action 95)".


        //Unsupported feature: Property Deletion (Promoted) on ""Applied E&ntries"(Action 95)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Applied E&ntries"(Action 95)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 53)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 53)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Detailed &Ledger Entries"(Action 62)".


        //Unsupported feature: Property Deletion (Promoted) on ""Detailed &Ledger Entries"(Action 62)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Detailed &Ledger Entries"(Action 62)".

        // modify("&Navigate")
        // {
        //     Visible = false;
        // }
        // modify("&Application")
        // {
        //     Visible = false;
        // }
        // modify("Set Applies-to ID")
        // {
        //     Visible = false;
        // }
        // modify("Post Application")
        // {
        //     Visible = false;
        // }
        // modify(Preview)
        // {
        //     Visible = false;
        // }
        // modify(Action5)
        // {
        //     Visible = false;
        // }


        //Unsupported feature: Code Modification on ""Show Only Selected Entries to Be Applied"(Action 3).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowAppliedEntries := NOT ShowAppliedEntries;
        IF ShowAppliedEntries THEN
          IF CalcType = CalcType::GenJnlLine THEN
            SETRANGE("Applies-to ID",GenJnlLine."Applies-to ID")
          ELSE BEGIN
            CustEntryApplID := USERID;
            IF CustEntryApplID = '' THEN
              CustEntryApplID := '***';
            SETRANGE("Applies-to ID",CustEntryApplID);
          END
        ELSE
          SETRANGE("Applies-to ID");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostDirectApplication(TRUE);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Only Selected Entries to Be Applied"(Action 3)".


        //Unsupported feature: Property Deletion (Promoted) on ""Show Only Selected Entries to Be Applied"(Action 3)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Show Only Selected Entries to Be Applied"(Action 3)".

        modify(ShowPostedDocument)
        {
            Visible = false;
        }
        modify(ShowDocumentAttachment)
        {
            Visible = false;
        }
        // addafter("Ent&ry")
        // {
        //     group("&Application")
        //     {
        //         Caption = '&Application';
        //         Image = Apply;
        //         action("Set Applies-to ID")
        //         {
        //             ApplicationArea = Basic;
        //             Caption = 'Set Applies-to ID';
        //             Image = SelectLineToApply;
        //             Promoted = true;
        //             PromotedCategory = Process;
        //             PromotedIsBig = true;
        //             ShortCutKey = 'Shift+F11';

        //             // trigger OnAction()
        //             // begin
        //             //     if (CalcType = Calctype::GenJnlLine) and (ApplnType = Applntype::"Applies-to Doc. No.") then
        //             //         Error(CannotSetAppliesToIDErr);

        //             //     SetCustApplId;
        //             // end;
        //         }
        //         action("Post Application")
        //         {
        //             ApplicationArea = Basic;
        //             Caption = 'Post Application';
        //             Ellipsis = true;
        //             Image = PostApplication;
        //             Promoted = true;
        //             PromotedCategory = Process;
        //             ShortCutKey = 'F9';

        //             // trigger OnAction()
        //             // begin
        //             //     PostDirectApplication(false);
        //             // end;
        //         }
        //     }
        // }
        // addafter("Show Only Selected Entries to Be Applied")
        // {
        //     separator(Action87)
        //     {
        //         Caption = '-';
        //     }
        //     action("Show Only Selected Entries to Be Applied")
        //     {
        //         ApplicationArea = Basic;
        //         Caption = 'Show Only Selected Entries to Be Applied';
        //         Image = ShowSelected;

        //         trigger OnAction()
        //         begin
        //             ShowAppliedEntries := not ShowAppliedEntries;
        //             if ShowAppliedEntries then begin
        //                 if CalcType = Calctype::GenJnlLine then
        //                     Rec.SetRange(Rec."Applies-to ID", GenJnlLine."Applies-to ID")
        //                 else begin
        //                     CustEntryApplID := UserId;
        //                     if CustEntryApplID = '' then
        //                         CustEntryApplID := '***';
        //                     Rec.SetRange(Rec."Applies-to ID", CustEntryApplID);
        //                 end;
        //             end else
        //                 Rec.SetRange(Rec."Applies-to ID");
        //         end;
        //     }
        // }
        addfirst(Processing)
        {
            // action("&Navigate")
            // {
            //     ApplicationArea = Basic;
            //     Caption = '&Navigate';
            //     Image = Navigate;
            //     Promoted = true;
            //     PromotedCategory = Process;

            //     // trigger OnAction()
            //     // begin
            //     //     Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
            //     //     Navigate.Run;
            //     // end;
            // }
        }
        moveafter("Detailed &Ledger Entries"; "Show Only Selected Entries to Be Applied")
    }


    //Unsupported feature: Property Modification (OptionString) on "CalcType(Variable 1029)".

    //var
    //>>>> ORIGINAL VALUE:
    //CalcType : Direct,GenJnlLine,SalesHeader,ServHeader;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CalcType : Direct,GenJnlLine,SalesHeader,ServHeader,Receipt;
    //Variable type has not been exported.

    var

        "Applies-to IDVisible": Boolean;

    var
        ReceiptLine: Record 52185877;
        ReceiptHeader: Record 52185889;
        GenJnlLineApply: Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ApplnType = ApplnType::"Applies-to Doc. No." THEN
      CalcApplnAmount;
    HasDocumentAttachment := HasPostedDocAttachment;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF ApplnType = ApplnType::"Applies-to Doc. No." THEN
      CalcApplnAmount;
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    AppliesToIDVisible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Applies-to IDVisible" := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF CalcType = CalcType::Direct THEN BEGIN
      Cust.GET("Customer No.");
      ApplnCurrencyCode := Cust."Currency Code";
      FindApplyingEntry;
    END;

    SalesSetup.GET;
    CustNameVisible := SalesSetup."Copy Customer Name to Entries";

    AppliesToIDVisible := ApplnType <> ApplnType::"Applies-to Doc. No.";

    GLSetup.GET;

    IF ApplnType = ApplnType::"Applies-to Doc. No." THEN
      CalcApplnAmount;
    PostingDone := FALSE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    "Applies-to IDVisible" := ApplnType <> ApplnType::"Applies-to Doc. No.";
    #11..16
    */
    //end;


    //Unsupported feature: Code Modification on "OnQueryClosePage".

    //trigger OnQueryClosePage(CloseAction: Action): Boolean
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF CloseAction = ACTION::LookupOK THEN
      LookupOKOnPush;
    IF ApplnType = ApplnType::"Applies-to Doc. No." THEN BEGIN
      IF OK THEN BEGIN
        RaiseError := ApplyingCustLedgEntry."Posting Date" < "Posting Date";
        OnBeforeEarlierPostingDateError(ApplyingCustLedgEntry,Rec,RaiseError,CalcType);
        IF RaiseError THEN BEGIN
          OK := FALSE;
          ERROR(
            EarlierPostingDateErr,ApplyingCustLedgEntry."Document Type",ApplyingCustLedgEntry."Document No.",
            "Document Type","Document No.");
        END;
      END;
      IF OK THEN BEGIN
        IF "Amount to Apply" = 0 THEN
          "Amount to Apply" := "Remaining Amount";
        CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit",Rec);
      END;
    END;
    IF (CalcType = CalcType::Direct) AND NOT OK AND NOT PostingDone THEN BEGIN
      Rec := ApplyingCustLedgEntry;
      "Applying Entry" := FALSE;
      "Applies-to ID" := '';
      "Amount to Apply" := 0;
      CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit",Rec);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      IF OK AND (ApplyingCustLedgEntry."Posting Date" < "Posting Date") THEN BEGIN
        OK := FALSE;
        ERROR(
          EarlierPostingDateErr,ApplyingCustLedgEntry."Document Type",ApplyingCustLedgEntry."Document No.",
          "Document Type","Document No.");
    #13..26
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetGenJnlLine(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetSales(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "SetService(PROCEDURE 8)".


    //Unsupported feature: Property Deletion (Attributes) on "SetCustLedgEntry(PROCEDURE 13)".


    //Unsupported feature: Variable Insertion (Variable: CustEntry-Edit) (VariableCollection) on "SetApplyingCustLedgEntry(PROCEDURE 9)".


    //Unsupported feature: Property Deletion (Attributes) on "SetApplyingCustLedgEntry(PROCEDURE 9)".



    //Unsupported feature: Code Modification on "SetApplyingCustLedgEntry(PROCEDURE 9)".

    //procedure SetApplyingCustLedgEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeSetApplyingCustLedgEntry(AppliedCustLedgEntry,GenJnlLine);

    CASE CalcType OF
      CalcType::SalesHeader:
        BEGIN
    #6..44
          IF "Applying Entry" THEN BEGIN
            IF ApplyingCustLedgEntry."Entry No." <> 0 THEN
              CustLedgEntry := ApplyingCustLedgEntry;
            CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit",Rec);
            IF "Applies-to ID" = '' THEN
              SetCustApplId(FALSE);
            CALCFIELDS(Amount);
            ApplyingCustLedgEntry := Rec;
            IF CustLedgEntry."Entry No." <> 0 THEN BEGIN
              Rec := CustLedgEntry;
              "Applying Entry" := FALSE;
              SetCustApplId(FALSE);
            END;
            SETFILTER("Entry No.",'<> %1',ApplyingCustLedgEntry."Entry No.");
            ApplyingAmount := ApplyingCustLedgEntry."Remaining Amount";
    #60..67
          ApplyingCustLedgEntry."Posting Date" := GenJnlLine."Posting Date";
          ApplyingCustLedgEntry."Document Type" := GenJnlLine."Document Type";
          ApplyingCustLedgEntry."Document No." := GenJnlLine."Document No.";
          IF GenJnlLine."Bal. Account Type" = GenJnlLine."Account Type"::Customer THEN BEGIN
            ApplyingCustLedgEntry."Customer No." := GenJnlLine."Bal. Account No.";
            Customer.GET(ApplyingCustLedgEntry."Customer No.");
            ApplyingCustLedgEntry.Description := Customer.Name;
          END ELSE BEGIN
            ApplyingCustLedgEntry."Customer No." := GenJnlLine."Account No.";
            ApplyingCustLedgEntry.Description := GenJnlLine.Description;
          END;
          ApplyingCustLedgEntry."Currency Code" := GenJnlLine."Currency Code";
          ApplyingCustLedgEntry.Amount := GenJnlLine.Amount;
          ApplyingCustLedgEntry."Remaining Amount" := GenJnlLine.Amount;
          CalcApplnAmount;
        END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #3..47
            "CustEntry-Edit".RUN(Rec);
            IF "Applies-to ID" = '' THEN
              SetCustApplId;
    #51..55
              SetCustApplId;
    #57..70
          ApplyingCustLedgEntry."Customer No." := GenJnlLine."Account No.";
          ApplyingCustLedgEntry.Description := GenJnlLine.Description;
    #79..83

      //Receipts
      CalcType::Receipt:
        BEGIN
          ApplyingCustLedgEntry."Entry No." := 1;
          ApplyingCustLedgEntry."Posting Date" := ReceiptLine.Date;
          ApplyingCustLedgEntry."Document Type" := ApplyingCustLedgEntry."Document Type"::Invoice;
          ApplyingCustLedgEntry."Document No." := ReceiptLine.No;
          ApplyingCustLedgEntry."Customer No." := ReceiptLine."Account No.";
          ApplyingCustLedgEntry.Description := ReceiptLine."Account Name";
          ApplyingCustLedgEntry."Currency Code" := ReceiptLine."Currency Code";
          ApplyingCustLedgEntry.Amount := -ReceiptLine.Amount;
          ApplyingCustLedgEntry."Remaining Amount" := -ReceiptLine.Amount;
          CalcApplnAmount;
        END;
    END;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetCustApplId(PROCEDURE 11)".



    //Unsupported feature: Code Modification on "SetCustApplId(PROCEDURE 11)".

    //procedure SetCustApplId();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF CalcType = CalcType::GenJnlLine THEN BEGIN
      RaiseError := ApplyingCustLedgEntry."Posting Date" < "Posting Date";
      OnBeforeEarlierPostingDateError(ApplyingCustLedgEntry,Rec,RaiseError,CalcType);
      IF RaiseError THEN
        ERROR(
          EarlierPostingDateErr,ApplyingCustLedgEntry."Document Type",ApplyingCustLedgEntry."Document No.",
          "Document Type","Document No.");
    END;

    IF ApplyingCustLedgEntry."Entry No." <> 0 THEN
      GenJnlApply.CheckAgainstApplnCurrency(
        ApplnCurrencyCode,"Currency Code",GenJnlLine."Account Type"::Customer,TRUE);

    CustLedgEntry.COPY(Rec);
    IF CurrentRec THEN BEGIN
      CustLedgEntry.SETRECFILTER;
      CustEntrySetApplID.SetApplId(CustLedgEntry,ApplyingCustLedgEntry,"Applies-to ID")
    END ELSE BEGIN
      CurrPage.SETSELECTIONFILTER(CustLedgEntry);
      CustEntrySetApplID.SetApplId(CustLedgEntry,ApplyingCustLedgEntry,GetAppliesToID)
    END;

    CalcApplnAmount;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF (CalcType = CalcType::GenJnlLine) AND (ApplyingCustLedgEntry."Posting Date" < "Posting Date") THEN
      ERROR(
        EarlierPostingDateErr,ApplyingCustLedgEntry."Document Type",ApplyingCustLedgEntry."Document No.",
        "Document Type","Document No.");
    #9..14
    CurrPage.SETSELECTIONFILTER(CustLedgEntry);

    CustEntrySetApplID.SetApplId(CustLedgEntry,ApplyingCustLedgEntry,GetAppliesToID);

    CalcApplnAmount;
    */
    //end;


    //Unsupported feature: Code Modification on "GetAppliesToID(PROCEDURE 16)".

    //procedure GetAppliesToID();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CASE CalcType OF
      CalcType::GenJnlLine:
        AppliesToID := GenJnlLine."Applies-to ID";
      CalcType::SalesHeader:
        AppliesToID := SalesHeader."Applies-to ID";
      CalcType::ServHeader:
        AppliesToID := ServHeader."Applies-to ID";
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
      CalcType::Receipt://Receipt
        AppliesToID := ReceiptLine."Applies-to ID";
    END;
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ExchAccGLJnlLine) (VariableCollection) on "CalcApplnAmount(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (Attributes) on "CalcApplnAmount(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "CalcApplnAmount(PROCEDURE 4)".

    //procedure CalcApplnAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeCalcApplnAmount(Rec,GenJnlLine);

    AppliedAmount := 0;
    PmtDiscAmount := 0;
    DifferentCurrenciesInAppln := FALSE;
    #6..23
            AppliedCustLedgEntry.SETFILTER("Entry No.",'<>%1',ApplyingCustLedgEntry."Entry No.");
          END;

          HandleChosenEntries(0,CustLedgEntry."Remaining Amount",CustLedgEntry."Currency Code",CustLedgEntry."Posting Date");
        END;
      CalcType::GenJnlLine:
        BEGIN
          FindAmountRounding;
          IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer THEN
            CODEUNIT.RUN(CODEUNIT::"Exchange Acc. G/L Journal Line",GenJnlLine);

          CASE ApplnType OF
            ApplnType::"Applies-to Doc. No.":
    #37..75
                AppliedCustLedgEntry.SETRANGE(Open,TRUE);
                AppliedCustLedgEntry.SETRANGE("Applies-to ID",GenJnlLine."Applies-to ID");

                HandleChosenEntries(1,GenJnlLine2.Amount,GenJnlLine2."Currency Code",GenJnlLine2."Posting Date");
              END;
          END;
        END;
    #83..112
                AppliedCustLedgEntry.SETRANGE(Open,TRUE);
                AppliedCustLedgEntry.SETRANGE("Applies-to ID",GetAppliesToID);

                HandleChosenEntries(2,ApplyingAmount,ApplnCurrencyCode,ApplnDate);
              END;
          END;
        END;
    END;

    OnAfterCalcApplnAmount(Rec,AppliedAmount,ApplyingAmount);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #3..26
          HandlChosenEntries(0,
            CustLedgEntry."Remaining Amount",
            CustLedgEntry."Currency Code",
            CustLedgEntry."Posting Date");
    #28..32
            ExchAccGLJnlLine.RUN(GenJnlLine);
    #34..78
                HandlChosenEntries(1,
                  GenJnlLine2.Amount,
                  GenJnlLine2."Currency Code",
                  GenJnlLine2."Posting Date");
    #80..115
                HandlChosenEntries(2,
                  ApplyingAmount,
                  ApplnCurrencyCode,
                  ApplnDate);
    #117..119

     //Receipts
      CalcType::Receipt:
        BEGIN
          FindAmountRounding;

          CASE ApplnType OF
            ApplnType::"Applies-to Doc. No.":
              BEGIN
                AppliedCustLedgEntry := Rec;
                WITH AppliedCustLedgEntry DO BEGIN
                  CALCFIELDS("Remaining Amount");

                  IF "Currency Code" <> ApplnCurrencyCode THEN
                    "Remaining Amount" :=
                      CurrExchRate.ExchangeAmtFCYToFCY(
                        ApplnDate,"Currency Code",ApplnCurrencyCode,"Remaining Amount");

                  AppliedAmount := ROUND("Remaining Amount",AmountRoundingPrecision);

                  IF NOT DifferentCurrenciesInAppln THEN
                    DifferentCurrenciesInAppln := ApplnCurrencyCode <> "Currency Code";

                END;
                CheckRounding;
              END;

            ApplnType::"Applies-to ID":
              BEGIN
                AppliedCustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive);
                AppliedCustLedgEntry.SETRANGE("Customer No.",ReceiptLine."Account No.");

                AppliedCustLedgEntry.SETRANGE(Open,TRUE);
                AppliedCustLedgEntry.SETRANGE("Applies-to ID",ReceiptLine."Applies-to ID");

                HandlChosenEntries(2,
                  GenJnlLine.Amount,
                  GenJnlLine."Currency Code",
                  GenJnlLine."Posting Date");

              END;
          END;
        END;
     //Receipts
    END;
    */
    //end;


    //Unsupported feature: Code Modification on "CalcApplnRemainingAmount(PROCEDURE 6)".

    //procedure CalcApplnRemainingAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ValidExchRate := TRUE;
    IF ApplnCurrencyCode = "Currency Code" THEN
      EXIT(Amount);
    #4..6
    ApplnRemainingAmount :=
      CurrExchRate.ApplnExchangeAmtFCYToFCY(
        ApplnDate,"Currency Code",ApplnCurrencyCode,Amount,ValidExchRate);

    OnAfterCalcApplnRemainingAmount(Rec,ApplnRemainingAmount);
    EXIT(ApplnRemainingAmount);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
    EXIT(ApplnRemainingAmount);
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ApplnAmounttoApply) (VariableCollection) on "CalcApplnAmounttoApply(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Name) on "CalcApplnAmountToApply(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "CalcApplnAmountToApply(PROCEDURE 10)".

    //procedure CalcApplnAmountToApply();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ValidExchRate := TRUE;

    IF ApplnCurrencyCode = "Currency Code" THEN
      EXIT(AmountToApply);

    IF ApplnDate = 0D THEN
      ApplnDate := "Posting Date";
    ApplnAmountToApply :=
      CurrExchRate.ApplnExchangeAmtFCYToFCY(
        ApplnDate,"Currency Code",ApplnCurrencyCode,AmountToApply,ValidExchRate);

    OnAfterCalcApplnAmountToApply(Rec,ApplnAmountToApply);
    EXIT(ApplnAmountToApply);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      EXIT(AmounttoApply);
    #5..7
    ApplnAmounttoApply :=
      CurrExchRate.ApplnExchangeAmtFCYToFCY(
        ApplnDate,"Currency Code",ApplnCurrencyCode,AmounttoApply,ValidExchRate);
    EXIT(ApplnAmounttoApply);
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "CheckRounding(PROCEDURE 3)".


    //Unsupported feature: Property Insertion (Local) on "CheckRounding(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "GetCustLedgEntry(PROCEDURE 5)".


    //Unsupported feature: Variable Insertion (Variable: AppliedCustLedgEntryTemp) (VariableCollection) on "HandlChosenEntries(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Name) on "HandleChosenEntries(PROCEDURE 14)".



    //Unsupported feature: Code Modification on "HandleChosenEntries(PROCEDURE 14)".

    //procedure HandleChosenEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeHandledChosenEntries(Type,CurrentAmount,CurrencyCode,PostingDate,AppliedCustLedgEntry,IsHandled);
    IF IsHandled THEN
      EXIT;

    IF NOT AppliedCustLedgEntry.FINDSET(FALSE,FALSE) THEN
      EXIT;

    REPEAT
      TempAppliedCustLedgEntry := AppliedCustLedgEntry;
      TempAppliedCustLedgEntry.INSERT;
    UNTIL AppliedCustLedgEntry.NEXT = 0;

    FromZeroGenJnl := (CurrentAmount = 0) AND (Type = Type::GenJnlLine);

    REPEAT
      IF NOT FromZeroGenJnl THEN
        TempAppliedCustLedgEntry.SETRANGE(Positive,CurrentAmount < 0);
      IF TempAppliedCustLedgEntry.FINDFIRST THEN BEGIN
        ExchangeAmountsOnLedgerEntry(Type,CurrencyCode,TempAppliedCustLedgEntry,PostingDate);

        CASE Type OF
          Type::Direct:
            CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscCust(CustLedgEntry,TempAppliedCustLedgEntry,0,FALSE,FALSE);
          Type::GenJnlLine:
            CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(GenJnlLine2,TempAppliedCustLedgEntry,0,FALSE)
          ELSE
            CanUseDisc := FALSE;
        END;

        IF CanUseDisc AND
           (ABS(TempAppliedCustLedgEntry."Amount to Apply") >=
            ABS(TempAppliedCustLedgEntry."Remaining Amount" - TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible"))
        THEN
          IF (ABS(CurrentAmount) >
              ABS(TempAppliedCustLedgEntry."Remaining Amount" - TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible"))
          THEN BEGIN
            PmtDiscAmount += TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
            CurrentAmount += TempAppliedCustLedgEntry."Remaining Amount" - TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
          END ELSE
            IF (ABS(CurrentAmount) =
                ABS(TempAppliedCustLedgEntry."Remaining Amount" - TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible"))
            THEN BEGIN
              PmtDiscAmount += TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
              CurrentAmount +=
                TempAppliedCustLedgEntry."Remaining Amount" - TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
              AppliedAmount += CorrectionAmount;
            END ELSE
              IF FromZeroGenJnl THEN BEGIN
                PmtDiscAmount += TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                CurrentAmount +=
                  TempAppliedCustLedgEntry."Remaining Amount" - TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
              END ELSE BEGIN
                PossiblePmtDisc := TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                RemainingAmountExclDiscounts :=
                  TempAppliedCustLedgEntry."Remaining Amount" - PossiblePmtDisc - TempAppliedCustLedgEntry."Max. Payment Tolerance";
                IF ABS(CurrentAmount) + ABS(CalcOppositeEntriesAmount(TempAppliedCustLedgEntry)) >=
                   ABS(RemainingAmountExclDiscounts)
                THEN BEGIN
                  PmtDiscAmount += PossiblePmtDisc;
                  AppliedAmount += CorrectionAmount;
                END;
                CurrentAmount +=
                  TempAppliedCustLedgEntry."Remaining Amount" - TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
              END
        ELSE BEGIN
          IF ((CurrentAmount + TempAppliedCustLedgEntry."Amount to Apply") * CurrentAmount) <= 0 THEN
            AppliedAmount += CorrectionAmount;
          CurrentAmount += TempAppliedCustLedgEntry."Amount to Apply";
        END
      END ELSE BEGIN
        TempAppliedCustLedgEntry.SETRANGE(Positive);
        TempAppliedCustLedgEntry.FINDFIRST;
        ExchangeAmountsOnLedgerEntry(Type,CurrencyCode,TempAppliedCustLedgEntry,PostingDate);
      END;

      IF OldPmtDisc <> PmtDiscAmount THEN
        AppliedAmount += TempAppliedCustLedgEntry."Remaining Amount"
      ELSE
        AppliedAmount += TempAppliedCustLedgEntry."Amount to Apply";
      OldPmtDisc := PmtDiscAmount;

      IF PossiblePmtDisc <> 0 THEN
        CorrectionAmount := TempAppliedCustLedgEntry."Remaining Amount" - TempAppliedCustLedgEntry."Amount to Apply"
      ELSE
        CorrectionAmount := 0;

      IF NOT DifferentCurrenciesInAppln THEN
        DifferentCurrenciesInAppln := ApplnCurrencyCode <> TempAppliedCustLedgEntry."Currency Code";

      TempAppliedCustLedgEntry.DELETE;
      TempAppliedCustLedgEntry.SETRANGE(Positive);

    UNTIL NOT TempAppliedCustLedgEntry.FINDFIRST;
    CheckRounding;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF AppliedCustLedgEntry.FINDSET(FALSE,FALSE) THEN BEGIN
      REPEAT
        AppliedCustLedgEntryTemp := AppliedCustLedgEntry;
        AppliedCustLedgEntryTemp.INSERT;
      UNTIL AppliedCustLedgEntry.NEXT = 0;
    END ELSE
      EXIT;
    #13..17
        AppliedCustLedgEntryTemp.SETRANGE(Positive,CurrentAmount < 0);
      IF AppliedCustLedgEntryTemp.FINDFIRST THEN BEGIN
        ExchangeAmountsOnLedgerEntry(Type,CurrencyCode,AppliedCustLedgEntryTemp,"Posting Date");
    #21..23
            CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscCust(CustLedgEntry,AppliedCustLedgEntryTemp,0,FALSE,FALSE);
          Type::GenJnlLine:
            CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(GenJnlLine2,AppliedCustLedgEntryTemp,0,FALSE)
    #27..31
           (ABS(AppliedCustLedgEntryTemp."Amount to Apply") >= ABS(AppliedCustLedgEntryTemp."Remaining Amount" -
              AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible"))
        THEN BEGIN
          IF (ABS(CurrentAmount) > ABS(AppliedCustLedgEntryTemp."Remaining Amount" -
                AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible"))
          THEN BEGIN
            PmtDiscAmount := PmtDiscAmount + AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible";
            CurrentAmount := CurrentAmount + AppliedCustLedgEntryTemp."Remaining Amount" -
              AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible";
          END ELSE
            IF (ABS(CurrentAmount) = ABS(AppliedCustLedgEntryTemp."Remaining Amount" -
                  AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible"))
            THEN BEGIN
              PmtDiscAmount := PmtDiscAmount + AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible" + PossiblePmtDisc;
              CurrentAmount := CurrentAmount + AppliedCustLedgEntryTemp."Remaining Amount" -
                AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible" - PossiblePmtDisc;
              PossiblePmtDisc := 0;
              AppliedAmount := AppliedAmount + CorrectionAmount;
            END ELSE
              IF FromZeroGenJnl THEN BEGIN
                PmtDiscAmount := PmtDiscAmount + AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible";
                CurrentAmount := CurrentAmount +
                  AppliedCustLedgEntryTemp."Remaining Amount" - AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible";
              END ELSE BEGIN
                PossiblePmtDisc := AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible";
                IF (CurrentAmount + AppliedCustLedgEntryTemp."Remaining Amount" >= 0) <> (CurrentAmount >= 0) THEN BEGIN
                  PmtDiscAmount := PmtDiscAmount + PossiblePmtDisc;
                  AppliedAmount := AppliedAmount + CorrectionAmount;
                END;
                CurrentAmount := CurrentAmount + AppliedCustLedgEntryTemp."Remaining Amount" -
                  AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible";
              END;
        END ELSE BEGIN
          IF ((CurrentAmount - PossiblePmtDisc + AppliedCustLedgEntryTemp."Amount to Apply") * CurrentAmount) <= 0 THEN BEGIN
            PmtDiscAmount := PmtDiscAmount + PossiblePmtDisc;
            CurrentAmount := CurrentAmount - PossiblePmtDisc;
            PossiblePmtDisc := 0;
            AppliedAmount := AppliedAmount + CorrectionAmount;
          END;
          CurrentAmount := CurrentAmount + AppliedCustLedgEntryTemp."Amount to Apply";
        END;
      END ELSE BEGIN
        AppliedCustLedgEntryTemp.SETRANGE(Positive);
        AppliedCustLedgEntryTemp.FINDFIRST;
        ExchangeAmountsOnLedgerEntry(Type,CurrencyCode,AppliedCustLedgEntryTemp,"Posting Date");
    #75..77
        AppliedAmount := AppliedAmount + AppliedCustLedgEntryTemp."Remaining Amount"
      ELSE
        AppliedAmount := AppliedAmount + AppliedCustLedgEntryTemp."Amount to Apply";
    #81..83
        CorrectionAmount := AppliedCustLedgEntryTemp."Remaining Amount" - AppliedCustLedgEntryTemp."Amount to Apply"
    #85..88
        DifferentCurrenciesInAppln := ApplnCurrencyCode <> AppliedCustLedgEntryTemp."Currency Code";

      AppliedCustLedgEntryTemp.DELETE;
      AppliedCustLedgEntryTemp.SETRANGE(Positive);

    UNTIL NOT AppliedCustLedgEntryTemp.FINDFIRST;
    CheckRounding;
    */
    //end;

    //Unsupported feature: Property Modification (Name) on "AmountToApplyOnAfterValidate(PROCEDURE 19038179)".



    //Unsupported feature: Code Modification on "PostDirectApplication(PROCEDURE 15)".

    //procedure PostDirectApplication();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF CalcType = CalcType::Direct THEN BEGIN
      IF ApplyingCustLedgEntry."Entry No." <> 0 THEN BEGIN
        Rec := ApplyingCustLedgEntry;
    #4..13
        IF PreviewMode THEN
          CustEntryApplyPostedEntries.PreviewApply(Rec,NewDocumentNo,NewApplicationDate)
        ELSE
          Applied := CustEntryApplyPostedEntries.Apply(Rec,NewDocumentNo,NewApplicationDate);

        IF (NOT PreviewMode) AND Applied THEN BEGIN
          MESSAGE(Text012);
          PostingDone := TRUE;
          CurrPage.CLOSE;
        END;
      END ELSE
        ERROR(Text002);
    END ELSE
      ERROR(Text003);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..16
          CustEntryApplyPostedEntries.Apply(Rec,NewDocumentNo,NewApplicationDate);

        IF NOT PreviewMode THEN BEGIN
    #20..27
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "ExchangeAmountsOnLedgerEntry(PROCEDURE 20)".


    //Unsupported feature: Property Insertion (Local) on "ExchangeAmountsOnLedgerEntry(PROCEDURE 20)".



    //Unsupported feature: Code Modification on "ExchangeAmountsOnLedgerEntry(PROCEDURE 20)".

    //procedure ExchangeAmountsOnLedgerEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CalcCustLedgEntry.CALCFIELDS("Remaining Amount");

    IF Type = Type::Direct THEN
      CalculateCurrency := ApplyingCustLedgEntry."Entry No." <> 0
    ELSE
      CalculateCurrency := TRUE;

    IF (CurrencyCode <> CalcCustLedgEntry."Currency Code") AND CalculateCurrency THEN BEGIN
      CalcCustLedgEntry."Remaining Amount" :=
        CurrExchRate.ExchangeAmount(
          CalcCustLedgEntry."Remaining Amount",CalcCustLedgEntry."Currency Code",CurrencyCode,PostingDate);
      CalcCustLedgEntry."Remaining Pmt. Disc. Possible" :=
        CurrExchRate.ExchangeAmount(
          CalcCustLedgEntry."Remaining Pmt. Disc. Possible",CalcCustLedgEntry."Currency Code",CurrencyCode,PostingDate);
      CalcCustLedgEntry."Amount to Apply" :=
        CurrExchRate.ExchangeAmount(
          CalcCustLedgEntry."Amount to Apply",CalcCustLedgEntry."Currency Code",CurrencyCode,PostingDate);
    END;

    OnAfterExchangeAmountsOnLedgerEntry(CalcCustLedgEntry,CustLedgEntry,CurrencyCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
          CalcCustLedgEntry."Remaining Amount",
          CalcCustLedgEntry."Currency Code",
          CurrencyCode,PostingDate);
      CalcCustLedgEntry."Remaining Pmt. Disc. Possible" :=
        CurrExchRate.ExchangeAmount(
          CalcCustLedgEntry."Remaining Pmt. Disc. Possible",
          CalcCustLedgEntry."Currency Code",
          CurrencyCode,PostingDate);
      CalcCustLedgEntry."Amount to Apply" :=
        CurrExchRate.ExchangeAmount(
          CalcCustLedgEntry."Amount to Apply",
          CalcCustLedgEntry."Currency Code",
          CurrencyCode,PostingDate);
    END;
    */
    //end;
  
    procedure SetReceipts(NewReceiptLine: Record "Receipt Line"; var NewCustLedgEntry: Record "Cust. Ledger Entry"; ApplnTypeSelect: Integer)
    var
        TotalAdjCostLCY: Decimal;
    begin
        ReceiptLine := NewReceiptLine;
        Rec.CopyFilters(NewCustLedgEntry);
        ApplyingAmount := -ReceiptLine.Amount;

        ReceiptHeader.Reset;
        ReceiptHeader.SetRange(ReceiptHeader."No.", NewReceiptLine.No);
        if ReceiptHeader.Find('-') then begin
            ApplnDate := ReceiptHeader.Date;
            ApplnCurrencyCode := ReceiptHeader."Currency Code";
            CalcType := Calctype::Receipt;
        end;
        case ApplnTypeSelect of
            ReceiptLine.FieldNo("Applies-to Doc. No."):
                ApplnType := Applntype::"Applies-to Doc. No.";
            ReceiptLine.FieldNo("Applies-to ID"):
                ApplnType := Applntype::"Applies-to ID";
        end;

        SetApplyingCustLedgEntry1;
    end;

    procedure SetApplyingCustLedgEntry1()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeSetApplyingCustLedgEntry1(TempApplyingCustLedgEntry, GenJnlLine, SalesHeader, CalcType, ReceiptLine, IsHandled);
        if not IsHandled then begin
            case CalcType of
                // CalcType::"Sales Header":
                //     SetApplyingCustledgEntrySalesHeader();
                // CalcType::"Service Header":
                //     SetApplyingCustledgEntryServiceHeader();
                // CalcType::"Gen. Jnl. Line":
                //     SetApplyingCustLedgEntryGenJnlLine();
                // CalcType::Direct:
                //     SetApplyingCustLedgEntryDirect();
                CalcType::Receipt:
                    SetApplyingCustLedgEntryReceiptLine();

            end;

            CalcApplnAmount1();
        end;

        OnAfterSetApplyingCustLedgEntry(TempApplyingCustLedgEntry, ReceiptLine, SalesHeader);
    end;

    local procedure SetApplyingCustLedgEntryReceiptLine()
    var
        Customer: Record Customer;
    begin
        TempApplyingCustLedgEntry."Entry No." := 1;
        TempApplyingCustLedgEntry."Posting Date" := ReceiptLine.Date;
        TempApplyingCustLedgEntry."Document Type" := TempApplyingCustLedgEntry."Document Type"::Invoice;
        TempApplyingCustLedgEntry."Document No." := ReceiptLine.No;
        TempApplyingCustLedgEntry.Description := ReceiptLine."Account No.";
        TempApplyingCustLedgEntry."Currency Code" := ReceiptLine."Currency Code";
        TempApplyingCustLedgEntry.Amount := -ReceiptLine.Amount;
        TempApplyingCustLedgEntry."Remaining Amount" := -ReceiptLine.Amount;


        OnAfterSetApplyingCustLedgEntryReceiptlLine(TempApplyingCustLedgEntry, ReceiptLine);
    end;

    procedure CalcApplnAmount1()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCalcApplnAmount(
            Rec, ReceiptLine, SalesHeader, AppliedCustLedgEntry, CalcType.AsInteger(), ApplnType.AsInteger(), IsHandled);
        if not IsHandled then begin
            AppliedAmount := 0;
            PmtDiscAmount := 0;
            DifferentCurrenciesInAppln := false;

            case CalcType of
                CalcType::Receipt:
                    BEGIN
                        FindAmountRounding;

                        CASE ApplnType OF
                            ApplnType::"Applies-to Doc. No.":
                                BEGIN
                                    AppliedCustLedgEntry := Rec;
                                    WITH AppliedCustLedgEntry DO BEGIN
                                        CALCFIELDS("Remaining Amount");

                                        IF "Currency Code" <> ApplnCurrencyCode THEN
                                            "Remaining Amount" :=
                                              CurrExchRate.ExchangeAmtFCYToFCY(
                                                ApplnDate, "Currency Code", ApplnCurrencyCode, "Remaining Amount");

                                        AppliedAmount := ROUND("Remaining Amount", AmountRoundingPrecision);

                                        IF NOT DifferentCurrenciesInAppln THEN
                                            DifferentCurrenciesInAppln := ApplnCurrencyCode <> "Currency Code";

                                    END;
                                    CheckRounding;
                                END;

                            ApplnType::"Applies-to ID":
                                BEGIN
                                    AppliedCustLedgEntry.SETCURRENTKEY("Customer No.", Open, Positive);
                                    AppliedCustLedgEntry.SETRANGE("Customer No.", ReceiptLine."Account No.");

                                    AppliedCustLedgEntry.SETRANGE(Open, TRUE);
                                    AppliedCustLedgEntry.SETRANGE("Applies-to ID", ReceiptLine."Applies-to ID");

                                    HandleChosenEntries(2,
                                      GenJnlLine.Amount,
                                      GenJnlLine."Currency Code",
                                      GenJnlLine."Posting Date");

                                END;
                        END;
                    END;
            //Receipts
            end;
        end;

        OnAfterCalcApplnAmount(Rec, AppliedAmount, ApplyingAmount, CalcType, AppliedCustLedgEntry, ReceiptLine);
    end;


    [IntegrationEvent(true, false)]
    local procedure OnBeforeSetApplyingCustLedgEntry1(var ApplyingCustLedgEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header"; var CalcType: Enum "Customer Apply Calculation Type"; ReceiptLine: Record "Receipt Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetApplyingCustLedgEntryReceiptlLine(var TempApplyingCustLedgEntry: Record "Cust. Ledger Entry" temporary; var ReceiptlLine: Record "Receipt Line")
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterCalcApplnAmount(CustLedgerEntry: Record "Cust. Ledger Entry"; var AppliedAmount: Decimal; var ApplyingAmount: Decimal; var CalcType: Enum "Customer Apply Calculation Type"; var AppliedCustLedgEntry: Record "Cust. Ledger Entry"; var ReceiptLine: Record "Receipt Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalcApplnAmount(var CustLedgerEntry: Record "Cust. Ledger Entry"; var ReceiptLine: Record "Receipt Line"; SalesHeader: Record "Sales Header"; var AppliedCustLedgerEntry: Record "Cust. Ledger Entry"; CalculationType: Option; ApplicationType: Option; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterSetApplyingCustLedgEntry(var ApplyingCustLedgEntry: Record "Cust. Ledger Entry"; ReceiptLine: Record "Receipt Line"; SalesHeader: Record "Sales Header")
    begin
    end;



}
