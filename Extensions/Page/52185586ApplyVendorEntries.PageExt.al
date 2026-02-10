#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185586 pageextension52185586 extends "Apply Vendor Entries"
{
    layout
    {
        modify("ApplyingVendLedgEntry.""Posting Date""")
        {
            ApplicationArea = Basic;
        }
        modify("ApplyingVendLedgEntry.""Document Type""")
        {
            ApplicationArea = Basic;
        }
        modify("ApplyingVendLedgEntry.""Document No.""")
        {
            ApplicationArea = Basic;
        }
        modify(ApplyingVendorNo)
        {

            //Unsupported feature: Property Modification (Name) on "ApplyingVendorNo(Control 71)".

            ApplicationArea = Basic;
        }
        modify(ApplyingDescription)
        {

            //Unsupported feature: Property Modification (Name) on "ApplyingDescription(Control 85)".

            ApplicationArea = Basic;
        }
        modify("ApplyingVendLedgEntry.""Currency Code""")
        {
            ApplicationArea = Basic;
        }
        modify("ApplyingVendLedgEntry.Amount")
        {
            ApplicationArea = Basic;
        }
        modify("ApplyingVendLedgEntry.""Remaining Amount""")
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
        modify("External Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor No.")
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

            //Unsupported feature: Property Modification (Name) on "ApplnAmountToApply(Control 92)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "ApplnAmountToApply(Control 92)".

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
        modify("Payment Reference")
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

            //Unsupported feature: Property Modification (Name) on "PmtDiscountAmount(Control 94)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""ApplyingVendLedgEntry.""Posting Date"""(Control 73)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ApplyingVendLedgEntry.""Document Type"""(Control 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ApplyingVendLedgEntry.""Document No."""(Control 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApplyingVendorNo(Control 71)".


        //Unsupported feature: Property Deletion (Visible) on "ApplyingVendorNo(Control 71)".

        modify(ApplyingVendorName)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ApplyingDescription(Control 85)".


        //Unsupported feature: Property Deletion (Visible) on "ApplyingDescription(Control 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ApplyingVendLedgEntry.""Currency Code"""(Control 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ApplyingVendLedgEntry.Amount"(Control 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ApplyingVendLedgEntry.""Remaining Amount"""(Control 83)".

        modify(AppliesToID)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "AppliesToID(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""External Document No."(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor No."(Control 8)".

        modify("Vendor Name")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Original Amount"(Control 61)".


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


        //Unsupported feature: Code Modification on ""Amount to Apply"(Control 90).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",Rec);

        IF (xRec."Amount to Apply" = 0) OR ("Amount to Apply" = 0) AND
           ((ApplnType = ApplnType::"Applies-to ID") OR (CalcType = CalcType::Direct))
        THEN
          SetVendApplId(FALSE);
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
          SetVendApplId;
        GET("Entry No.");
        AmounttoApplyOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount to Apply"(Control 90)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApplnAmountToApply(Control 92)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Discount Date"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Disc. Tolerance Date"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Reference"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Original Pmt. Disc. Possible"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Pmt. Disc. Possible"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CalcApplnRemainingAmount(""Remaining Pmt. Disc. Possible"")"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Max. Payment Tolerance"(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Open(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Positive(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApplnCurrencyCode(Control 49)".


        //Unsupported feature: Property Deletion (ShowCaption) on "ApplnCurrencyCode(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountToApply(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PmtDiscountAmount(Control 94)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApplnRounding(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AppliedAmount(Control 98)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApplyingAmount(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ControlBalance(Control 43)".

    }
    actions
    {
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

        //     //Unsupported feature: Property Modification (Image) on ""Show Only Selected Entries to Be Applied"(Action 5)".


        //     //Unsupported feature: Property Modification (Name) on ""Show Only Selected Entries to Be Applied"(Action 5)".

        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Applied E&ntries"(Action 31)".


        //Unsupported feature: Property Deletion (Promoted) on ""Applied E&ntries"(Action 31)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Applied E&ntries"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 57)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 57)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Detailed &Ledger Entries"(Action 63)".


        //Unsupported feature: Property Deletion (Promoted) on ""Detailed &Ledger Entries"(Action 63)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Detailed &Ledger Entries"(Action 63)".

        modify(Navigate)
        {
            Visible = false;
        }
        // modify("&Application")
        // {
        //     Visible = false;
        // }
        // modify(ActionSetAppliesToID)
        // {
        //     Visible = false;
        // }
        // modify(ActionPostApplication)
        // {
        //     Visible = false;
        // }
        // modify(Preview)
        // {
        //     Visible = false;
        // }
        // modify(Action7)
        // {
        //     Visible = false;
        // }


        //Unsupported feature: Code Modification on ""Show Only Selected Entries to Be Applied"(Action 5).OnAction".

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
            VendEntryApplID := USERID;
            IF VendEntryApplID = '' THEN
              VendEntryApplID := '***';
            SETRANGE("Applies-to ID",VendEntryApplID);
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Only Selected Entries to Be Applied"(Action 5)".


        //Unsupported feature: Property Deletion (Promoted) on ""Show Only Selected Entries to Be Applied"(Action 5)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Show Only Selected Entries to Be Applied"(Action 5)".

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
        //         action(ActionSetAppliesToID)
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

        //             //     SetVendApplId;
        //             // end;
        //         }
        //         // action(ActionPostApplication)
        //         // {
        //         //     ApplicationArea = Basic;
        //         //     Caption = 'Post Application';
        //         //     Ellipsis = true;
        //         //     Image = PostApplication;
        //         //     Promoted = true;
        //         //     PromotedCategory = Process;
        //         //     ShortCutKey = 'F9';

        //         //     trigger OnAction()
        //         //     begin
        //         //         PostDirectApplication(false);
        //         //     end;
        //         // }
        //     }
        // }
        // addafter("Show Only Selected Entries to Be Applied")
        // {
        //     separator(Action99)
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
        //                     VendEntryApplID := UserId;
        //                     if VendEntryApplID = '' then
        //                         VendEntryApplID := '***';
        //                     Rec.SetRange(Rec."Applies-to ID", VendEntryApplID);
        //                 end;
        //             end else
        //                 Rec.SetRange(Rec."Applies-to ID");
        //         end;
        //     }
        // }
        // addfirst(Processing)
        // {
        //     action("&Navigate")
        //     {
        //         ApplicationArea = Basic;
        //         Caption = '&Navigate';
        //         Image = Navigate;
        //         Promoted = true;
        //         PromotedCategory = Process;

        //         trigger OnAction()
        //         begin
        //             Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
        //             Navigate.Run;
        //         end;
        //     }
        // }
        moveafter("Detailed &Ledger Entries"; "Show Only Selected Entries to Be Applied")
    }


    //Unsupported feature: Property Modification (OptionString) on "CalcType(Variable 1027)".

    //var
    //>>>> ORIGINAL VALUE:
    //CalcType : Direct,GenJnlLine,PurchHeader;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CalcType : Direct,GenJnlLine,PurchHeader,PV;
    //Variable type has not been exported.

    var

        "Applies-to IDVisible": Boolean;

    var
        "***CoreTEC****": Integer;
        PVLine: Record 52185878;


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
      Vend.GET("Vendor No.");
      ApplnCurrencyCode := Vend."Currency Code";
      FindApplyingEntry;
    END;

    PurchSetup.GET;
    VendNameVisible := PurchSetup."Copy Vendor Name to Entries";

    AppliesToIDVisible := ApplnType <> ApplnType::"Applies-to Doc. No.";

    GLSetup.GET;

    IF CalcType = CalcType::GenJnlLine THEN
      CalcApplnAmount;
    PostingDone := FALSE;
    IsOfficeAddin := OfficeMgt.IsAvailable;
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
        RaiseError := ApplyingVendLedgEntry."Posting Date" < "Posting Date";
        OnBeforeEarlierPostingDateError(ApplyingVendLedgEntry,Rec,RaiseError,CalcType);
        IF RaiseError THEN BEGIN
          OK := FALSE;
          ERROR(
            EarlierPostingDateErr,ApplyingVendLedgEntry."Document Type",ApplyingVendLedgEntry."Document No.",
            "Document Type","Document No.");
        END;
      END;
      IF OK THEN BEGIN
        IF "Amount to Apply" = 0 THEN
          "Amount to Apply" := "Remaining Amount";
        CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",Rec);
      END;
    END;

    IF CheckActionPerformed THEN BEGIN
      Rec := ApplyingVendLedgEntry;
      "Applying Entry" := FALSE;
      IF AppliesToID = '' THEN BEGIN
        "Applies-to ID" := '';
        "Amount to Apply" := 0;
      END;
      CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",Rec);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      IF OK AND (ApplyingVendLedgEntry."Posting Date" < "Posting Date") THEN BEGIN
        OK := FALSE;
        ERROR(
          EarlierPostingDateErr,ApplyingVendLedgEntry."Document Type",ApplyingVendLedgEntry."Document No.",
          "Document Type","Document No.");
    #13..29
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetGenJnlLine(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetPurch(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "SetVendLedgEntry(PROCEDURE 13)".


    //Unsupported feature: Variable Insertion (Variable: VendEntry-Edit) (VariableCollection) on "SetApplyingVendLedgEntry(PROCEDURE 9)".


    //Unsupported feature: Property Deletion (Attributes) on "SetApplyingVendLedgEntry(PROCEDURE 9)".



    //Unsupported feature: Code Modification on "SetApplyingVendLedgEntry(PROCEDURE 9)".

    //procedure SetApplyingVendLedgEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeSetApplyingVendLedgEntry(ApplyingVendLedgEntry,GenJnlLine);

    CASE CalcType OF
      CalcType::PurchHeader:
        BEGIN
    #6..25
          IF "Applying Entry" THEN BEGIN
            IF ApplyingVendLedgEntry."Entry No." <> 0 THEN
              VendLedgEntry := ApplyingVendLedgEntry;
            CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",Rec);
            IF "Applies-to ID" = '' THEN
              SetVendApplId(FALSE);
            CALCFIELDS(Amount);
            ApplyingVendLedgEntry := Rec;
            IF VendLedgEntry."Entry No." <> 0 THEN BEGIN
              Rec := VendLedgEntry;
              "Applying Entry" := FALSE;
              SetVendApplId(FALSE);
            END;
            SETFILTER("Entry No.",'<> %1',ApplyingVendLedgEntry."Entry No.");
            ApplyingAmount := ApplyingVendLedgEntry."Remaining Amount";
    #41..47
          ApplyingVendLedgEntry."Posting Date" := GenJnlLine."Posting Date";
          ApplyingVendLedgEntry."Document Type" := GenJnlLine."Document Type";
          ApplyingVendLedgEntry."Document No." := GenJnlLine."Document No.";
          IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor THEN BEGIN
            ApplyingVendLedgEntry."Vendor No." := GenJnlLine."Bal. Account No.";
            Vendor.GET(ApplyingVendLedgEntry."Vendor No.");
            ApplyingVendLedgEntry.Description := Vendor.Name;
          END ELSE BEGIN
            ApplyingVendLedgEntry."Vendor No." := GenJnlLine."Account No.";
            ApplyingVendLedgEntry.Description := GenJnlLine.Description;
          END;
          ApplyingVendLedgEntry."Currency Code" := GenJnlLine."Currency Code";
          ApplyingVendLedgEntry.Amount := GenJnlLine.Amount;
          ApplyingVendLedgEntry."Remaining Amount" := GenJnlLine.Amount;
          CalcApplnAmount;
        END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #3..28
            "VendEntry-Edit".RUN(Rec);
            IF "Applies-to ID" = '' THEN
              SetVendApplId;
    #32..36
              SetVendApplId;
    #38..50
          ApplyingVendLedgEntry."Vendor No." := GenJnlLine."Account No.";
          ApplyingVendLedgEntry.Description := GenJnlLine.Description;
    #59..63

      //Added for PV
      CalcType::PV :
        BEGIN
          ApplyingVendLedgEntry."Posting Date" :=PVLine.Date ;
          ApplyingVendLedgEntry."Document Type" :=ApplyingVendLedgEntry."Document Type"::Payment;
          ApplyingVendLedgEntry."Document No." := PVLine.No;
          ApplyingVendLedgEntry."Vendor No." :=PVLine."Account No.";
          ApplyingVendLedgEntry.Description := PVLine."Account Name";
          ApplyingVendLedgEntry."Currency Code" := PVLine."Currency Code";
          ApplyingVendLedgEntry.Amount := PVLine.Amount;
          ApplyingVendLedgEntry."Remaining Amount" := -PVLine.Amount;
          CalcApplnAmount;
        END;
    END;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetVendApplId(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "SetVendApplId(PROCEDURE 10)".

    //procedure SetVendApplId();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF CalcType = CalcType::GenJnlLine THEN BEGIN
      RaiseError := ApplyingVendLedgEntry."Posting Date" < "Posting Date";
      OnBeforeEarlierPostingDateError(ApplyingVendLedgEntry,Rec,RaiseError,CalcType);
      IF RaiseError THEN
        ERROR(
          EarlierPostingDateErr,ApplyingVendLedgEntry."Document Type",ApplyingVendLedgEntry."Document No.",
          "Document Type","Document No.");
    END;

    IF ApplyingVendLedgEntry."Entry No." <> 0 THEN
      GenJnlApply.CheckAgainstApplnCurrency(
        ApplnCurrencyCode,"Currency Code",GenJnlLine."Account Type"::Vendor,TRUE);

    VendLedgEntry.COPY(Rec);
    IF CurrentRec THEN
      VendLedgEntry.SETRECFILTER
    ELSE
      CurrPage.SETSELECTIONFILTER(VendLedgEntry);
    IF GenJnlLineApply THEN
      VendEntrySetApplID.SetApplId(VendLedgEntry,ApplyingVendLedgEntry,GenJnlLine."Applies-to ID")
    ELSE
      VendEntrySetApplID.SetApplId(VendLedgEntry,ApplyingVendLedgEntry,PurchHeader."Applies-to ID");

    ActionPerformed := VendLedgEntry."Applies-to ID" <> '';
    CalcApplnAmount;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF (CalcType = CalcType::GenJnlLine) AND (ApplyingVendLedgEntry."Posting Date" < "Posting Date") THEN
      ERROR(
        EarlierPostingDateErr,ApplyingVendLedgEntry."Document Type",ApplyingVendLedgEntry."Document No.",
        "Document Type","Document No.");
    #9..14
    CurrPage.SETSELECTIONFILTER(VendLedgEntry);
    #19..21
    //Added for PV
    IF CalcType = CalcType::PV THEN
      VendEntrySetApplID.SetApplId(VendLedgEntry,ApplyingVendLedgEntry,PVLine."Applies-to ID")
    ELSE //Added for PV
    #22..25
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ExchAccGLJnlLine) (VariableCollection) on "CalcApplnAmount(PROCEDURE 7)".



    //Unsupported feature: Code Modification on "CalcApplnAmount(PROCEDURE 7)".

    //procedure CalcApplnAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeCalcApplnAmount(Rec,GenJnlLine);

    AppliedAmount := 0;
    PmtDiscAmount := 0;
    DifferentCurrenciesInAppln := FALSE;
    #6..26
            AppliedVendLedgEntry.SETFILTER("Entry No.",'<>%1',VendLedgEntry."Entry No.");
          END;

          HandleChosenEntries(0,VendLedgEntry."Remaining Amount",VendLedgEntry."Currency Code",VendLedgEntry."Posting Date");
        END;
      CalcType::GenJnlLine:
        BEGIN
          FindAmountRounding;
          IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor THEN
            CODEUNIT.RUN(CODEUNIT::"Exchange Acc. G/L Journal Line",GenJnlLine);

          CASE ApplnType OF
            ApplnType::"Applies-to Doc. No.":
    #40..78
                AppliedVendLedgEntry.SETRANGE(Open,TRUE);
                AppliedVendLedgEntry.SETRANGE("Applies-to ID",GenJnlLine."Applies-to ID");

                HandleChosenEntries(1,GenJnlLine2.Amount,GenJnlLine2."Currency Code",GenJnlLine2."Posting Date");
              END;
          END;
        END;
    #86..112
                AppliedVendLedgEntry.SETRANGE(Open,TRUE);
                AppliedVendLedgEntry.SETRANGE("Applies-to ID",PurchHeader."Applies-to ID");

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
    #3..29
          HandlChosenEntries(0,
            VendLedgEntry."Remaining Amount",
            VendLedgEntry."Currency Code",
            VendLedgEntry."Posting Date");
    #31..35
            ExchAccGLJnlLine.RUN(GenJnlLine);
    #37..81
                HandlChosenEntries(1,
                  GenJnlLine2.Amount,
                  GenJnlLine2."Currency Code",
                  GenJnlLine2."Posting Date");
    #83..115
                HandlChosenEntries(2,
                  ApplyingAmount,
                  ApplnCurrencyCode,
                  ApplnDate);
    #117..119

        //PV
      CalcType::PV:
        BEGIN
          FindAmountRounding;

          CASE ApplnType OF
            ApplnType::"Applies-to Doc. No." :
              BEGIN
                AppliedVendLedgEntry := Rec;
                WITH AppliedVendLedgEntry DO BEGIN
                  CALCFIELDS("Remaining Amount");

                  IF "Currency Code" <> ApplnCurrencyCode THEN
                    "Remaining Amount" :=
                      CurrExchRate.ExchangeAmtFCYToFCY(
                        ApplnDate,"Currency Code",ApplnCurrencyCode,"Remaining Amount");

                  AppliedAmount := AppliedAmount + ROUND("Remaining Amount",AmountRoundingPrecision);

                  IF NOT DifferentCurrenciesInAppln THEN
                    DifferentCurrenciesInAppln:= ApplnCurrencyCode <> "Currency Code";

                END;
                CheckRounding;
              END;

            ApplnType::"Applies-to ID" :
              BEGIN
                WITH VendLedgEntry DO BEGIN
                  AppliedVendLedgEntry.SETCURRENTKEY("Vendor No.",Open,Positive);
                  AppliedVendLedgEntry.SETRANGE("Vendor No.",PVLine."Account No.");
                  AppliedVendLedgEntry.SETRANGE(Open,TRUE);
                  AppliedVendLedgEntry.SETRANGE("Applies-to ID",PVLine."Applies-to ID");

                  {HandlChosenEntries(2,
                    GenJnlLine.Amount,
                    GenJnlLine."Currency Code",
                    GenJnlLine."Posting Date");}
                  HandlChosenEntries(2,
                    PVLine.Amount,
                    PVLine."Currency Code",
                    PVLine.Date);

                END;
              END;
          END;
        END;

        //PV
    END;
    */
    //end;


    //Unsupported feature: Code Modification on "CalcApplnRemainingAmount(PROCEDURE 4)".

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

    //Unsupported feature: Property Modification (Name) on "CalcApplnAmountToApply(PROCEDURE 11)".



    //Unsupported feature: Code Modification on "CalcApplnAmountToApply(PROCEDURE 11)".

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

    OnAfterCalcApplnAmountToApply(Rec,AmountToApply);
    EXIT(ApplnAmountToApply);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      EXIT(AmounttoApply);
    #5..9
        ApplnDate,"Currency Code",ApplnCurrencyCode,AmounttoApply,ValidExchRate);
    EXIT(ApplnAmountToApply);
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "CheckRounding(PROCEDURE 3)".


    //Unsupported feature: Property Insertion (Local) on "CheckRounding(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "GetVendLedgEntry(PROCEDURE 5)".


    //Unsupported feature: Variable Insertion (Variable: AppliedVendLedgEntryTemp) (VariableCollection) on "HandlChosenEntries(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Name) on "HandleChosenEntries(PROCEDURE 8)".



    //Unsupported feature: Code Modification on "HandleChosenEntries(PROCEDURE 8)".

    //procedure HandleChosenEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeHandledChosenEntries(Type,CurrentAmount,CurrencyCode,PostingDate,AppliedVendLedgEntry,IsHandled);
    IF IsHandled THEN
      EXIT;

    IF NOT AppliedVendLedgEntry.FINDSET(FALSE,FALSE) THEN
      EXIT;

    REPEAT
      TempAppliedVendLedgEntry := AppliedVendLedgEntry;
      TempAppliedVendLedgEntry.INSERT;
    UNTIL AppliedVendLedgEntry.NEXT = 0;

    FromZeroGenJnl := (CurrentAmount = 0) AND (Type = Type::GenJnlLine);

    REPEAT
      IF NOT FromZeroGenJnl THEN
        TempAppliedVendLedgEntry.SETRANGE(Positive,CurrentAmount < 0);
      IF TempAppliedVendLedgEntry.FINDFIRST THEN BEGIN
        ExchangeAmountsOnLedgerEntry(Type,CurrencyCode,TempAppliedVendLedgEntry,PostingDate);

        CASE Type OF
          Type::Direct:
            CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscVend(VendLedgEntry,TempAppliedVendLedgEntry,0,FALSE,FALSE);
          Type::GenJnlLine:
            CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscGenJnlVend(GenJnlLine2,TempAppliedVendLedgEntry,0,FALSE)
          ELSE
            CanUseDisc := FALSE;
        END;

        IF CanUseDisc AND
           (ABS(TempAppliedVendLedgEntry."Amount to Apply") >=
            ABS(TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible"))
        THEN
          IF ABS(CurrentAmount) >
             ABS(TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible")
          THEN BEGIN
            PmtDiscAmount += TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
            CurrentAmount += TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
          END ELSE
            IF ABS(CurrentAmount) =
               ABS(TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible")
            THEN BEGIN
              PmtDiscAmount += TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible" ;
              CurrentAmount +=
                TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
              AppliedAmount += CorrectionAmount;
            END ELSE
              IF FromZeroGenJnl THEN BEGIN
                PmtDiscAmount += TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                CurrentAmount +=
                  TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
              END ELSE BEGIN
                PossiblePmtdisc := TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                RemainingAmountExclDiscounts :=
                  TempAppliedVendLedgEntry."Remaining Amount" - PossiblePmtdisc - TempAppliedVendLedgEntry."Max. Payment Tolerance";
                IF ABS(CurrentAmount) + ABS(CalcOppositeEntriesAmount(TempAppliedVendLedgEntry)) >=
                   ABS(RemainingAmountExclDiscounts)
                THEN BEGIN
                  PmtDiscAmount += PossiblePmtdisc;
                  AppliedAmount += CorrectionAmount;
                END;
                CurrentAmount +=
                  TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
              END
        ELSE BEGIN
          IF ((CurrentAmount + TempAppliedVendLedgEntry."Amount to Apply") * CurrentAmount) >= 0 THEN
            AppliedAmount += CorrectionAmount;
          CurrentAmount += TempAppliedVendLedgEntry."Amount to Apply";
        END;
      END ELSE BEGIN
        TempAppliedVendLedgEntry.SETRANGE(Positive);
        TempAppliedVendLedgEntry.FINDFIRST;
        ExchangeAmountsOnLedgerEntry(Type,CurrencyCode,TempAppliedVendLedgEntry,PostingDate);
      END;

      IF OldPmtdisc <> PmtDiscAmount THEN
        AppliedAmount += TempAppliedVendLedgEntry."Remaining Amount"
      ELSE
        AppliedAmount += TempAppliedVendLedgEntry."Amount to Apply";
      OldPmtdisc := PmtDiscAmount;

      IF PossiblePmtdisc <> 0 THEN
        CorrectionAmount := TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Amount to Apply"
      ELSE
        CorrectionAmount := 0;

      IF NOT DifferentCurrenciesInAppln THEN
        DifferentCurrenciesInAppln := ApplnCurrencyCode <> TempAppliedVendLedgEntry."Currency Code";

      TempAppliedVendLedgEntry.DELETE;
      TempAppliedVendLedgEntry.SETRANGE(Positive);

    UNTIL NOT TempAppliedVendLedgEntry.FINDFIRST;
    CheckRounding;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF AppliedVendLedgEntry.FINDSET(FALSE,FALSE) THEN BEGIN
      REPEAT
        AppliedVendLedgEntryTemp := AppliedVendLedgEntry;
        AppliedVendLedgEntryTemp.INSERT;
      UNTIL AppliedVendLedgEntry.NEXT = 0;
    END ELSE
      EXIT;
    #13..17
        AppliedVendLedgEntryTemp.SETRANGE(Positive,CurrentAmount < 0);
      IF AppliedVendLedgEntryTemp.FINDFIRST THEN BEGIN
        ExchangeAmountsOnLedgerEntry(Type,CurrencyCode,AppliedVendLedgEntryTemp,"Posting Date");
    #21..23
            CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscVend(VendLedgEntry,AppliedVendLedgEntryTemp,0,FALSE,FALSE);
          Type::GenJnlLine:
            CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscGenJnlVend(GenJnlLine2,AppliedVendLedgEntryTemp,0,FALSE)
    #27..31
           (ABS(AppliedVendLedgEntryTemp."Amount to Apply") >= ABS(AppliedVendLedgEntryTemp."Remaining Amount" -
              AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible"))
        THEN BEGIN
          IF (ABS(CurrentAmount) > ABS(AppliedVendLedgEntryTemp."Remaining Amount" -
                AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible"))
          THEN BEGIN
            PmtDiscAmount := PmtDiscAmount + AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible";
            CurrentAmount := CurrentAmount + AppliedVendLedgEntryTemp."Remaining Amount" -
              AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible";
          END ELSE
            IF (ABS(CurrentAmount) = ABS(AppliedVendLedgEntryTemp."Remaining Amount" -
                  AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible"))
            THEN BEGIN
              PmtDiscAmount := PmtDiscAmount + AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible" ;
              CurrentAmount := CurrentAmount + AppliedVendLedgEntryTemp."Remaining Amount" -
                AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible";
              AppliedAmount := AppliedAmount + CorrectionAmount;
            END ELSE
              IF FromZeroGenJnl THEN BEGIN
                PmtDiscAmount := PmtDiscAmount + AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible";
                CurrentAmount := CurrentAmount +
                  AppliedVendLedgEntryTemp."Remaining Amount" - AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible";
              END ELSE BEGIN
                PossiblePmtdisc := AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible";
                IF (CurrentAmount + AppliedVendLedgEntryTemp."Remaining Amount" <= 0) <> (CurrentAmount <= 0) THEN BEGIN
                  PmtDiscAmount := PmtDiscAmount + PossiblePmtdisc;
                  AppliedAmount := AppliedAmount + CorrectionAmount;
                END;
            CurrentAmount := CurrentAmount + AppliedVendLedgEntryTemp."Remaining Amount" -
              AppliedVendLedgEntryTemp."Remaining Pmt. Disc. Possible";
              END;
        END ELSE BEGIN
          IF ((CurrentAmount + AppliedVendLedgEntryTemp."Amount to Apply") * CurrentAmount) >= 0 THEN
            AppliedAmount := AppliedAmount + CorrectionAmount;
          CurrentAmount := CurrentAmount + AppliedVendLedgEntryTemp."Amount to Apply";
        END;
      END ELSE BEGIN
        AppliedVendLedgEntryTemp.SETRANGE(Positive);
        AppliedVendLedgEntryTemp.FINDFIRST;
        ExchangeAmountsOnLedgerEntry(Type,CurrencyCode,AppliedVendLedgEntryTemp,"Posting Date");
    #75..77
        AppliedAmount := AppliedAmount + AppliedVendLedgEntryTemp."Remaining Amount"
      ELSE
        AppliedAmount := AppliedAmount + AppliedVendLedgEntryTemp."Amount to Apply";
    #81..83
        CorrectionAmount := AppliedVendLedgEntryTemp."Remaining Amount" - AppliedVendLedgEntryTemp."Amount to Apply"
    #85..88
        DifferentCurrenciesInAppln := ApplnCurrencyCode <> AppliedVendLedgEntryTemp."Currency Code";

      AppliedVendLedgEntryTemp.DELETE;
      AppliedVendLedgEntryTemp.SETRANGE(Positive);

    UNTIL NOT AppliedVendLedgEntryTemp.FINDFIRST;
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
      IF ApplyingVendLedgEntry."Entry No." <> 0 THEN BEGIN
        Rec := ApplyingVendLedgEntry;
    #4..13
        IF PreviewMode THEN
          VendEntryApplyPostedEntries.PreviewApply(Rec,NewDocumentNo,NewApplicationDate)
        ELSE
          Applied := VendEntryApplyPostedEntries.Apply(Rec,NewDocumentNo,NewApplicationDate);

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
          VendEntryApplyPostedEntries.Apply(Rec,NewDocumentNo,NewApplicationDate);

        IF NOT PreviewMode THEN BEGIN
    #20..27
    */
    //end;


    //Unsupported feature: Code Modification on "CheckActionPerformed(PROCEDURE 1011)".

    //procedure CheckActionPerformed();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ActionPerformed THEN
      EXIT(FALSE);
    IF (NOT (CalcType = CalcType::Direct) AND NOT OK AND NOT PostingDone) OR
       (ApplnType = ApplnType::"Applies-to Doc. No.")
    THEN
      EXIT(FALSE);
    EXIT((CalcType = CalcType::Direct) AND NOT OK AND NOT PostingDone);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    EXIT(CalcType = CalcType::Direct);
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetAppliesToID(PROCEDURE 1031)".


    //Unsupported feature: Property Deletion (Attributes) on "ExchangeAmountsOnLedgerEntry(PROCEDURE 14)".


    //Unsupported feature: Property Insertion (Local) on "ExchangeAmountsOnLedgerEntry(PROCEDURE 14)".



    //Unsupported feature: Code Modification on "ExchangeAmountsOnLedgerEntry(PROCEDURE 14)".

    //procedure ExchangeAmountsOnLedgerEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CalcVendLedgEntry.CALCFIELDS("Remaining Amount");

    IF Type = Type::Direct THEN
      CalculateCurrency := ApplyingVendLedgEntry."Entry No." <> 0
    ELSE
      CalculateCurrency := TRUE;

    IF (CurrencyCode <> CalcVendLedgEntry."Currency Code") AND CalculateCurrency THEN BEGIN
      CalcVendLedgEntry."Remaining Amount" :=
        CurrExchRate.ExchangeAmount(
          CalcVendLedgEntry."Remaining Amount",CalcVendLedgEntry."Currency Code",CurrencyCode,PostingDate);
      CalcVendLedgEntry."Remaining Pmt. Disc. Possible" :=
        CurrExchRate.ExchangeAmount(
          CalcVendLedgEntry."Remaining Pmt. Disc. Possible",CalcVendLedgEntry."Currency Code",CurrencyCode,PostingDate);
      CalcVendLedgEntry."Amount to Apply" :=
        CurrExchRate.ExchangeAmount(
          CalcVendLedgEntry."Amount to Apply",CalcVendLedgEntry."Currency Code",CurrencyCode,PostingDate);
    END;

    OnAfterExchangeAmountsOnLedgerEntry(CalcVendLedgEntry,VendLedgEntry,CurrencyCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
          CalcVendLedgEntry."Remaining Amount",
          CalcVendLedgEntry."Currency Code",
          CurrencyCode,PostingDate);
      CalcVendLedgEntry."Remaining Pmt. Disc. Possible" :=
        CurrExchRate.ExchangeAmount(
          CalcVendLedgEntry."Remaining Pmt. Disc. Possible",
          CalcVendLedgEntry."Currency Code",
          CurrencyCode,PostingDate);
      CalcVendLedgEntry."Amount to Apply" :=
        CurrExchRate.ExchangeAmount(
          CalcVendLedgEntry."Amount to Apply",
          CalcVendLedgEntry."Currency Code",
          CurrencyCode,PostingDate);
    END;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "OnBeforeEarlierPostingDateError(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Name) on "OnBeforeEarlierPostingDateError(PROCEDURE 16)".


    procedure "SetPVLine-Delete"(NewPVLine: Record 52185878; ApplnTypeSelect: Integer)
    var
        PaymentHeader: Record 52185888;
    begin

        PVLine := NewPVLine;

        if PVLine."Account Type" = PVLine."account type"::Vendor then
            ApplyingAmount := PVLine.Amount;
        //IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor THEN
        ApplyingAmount := PVLine.Amount;
        //Get Payments Header
        PaymentHeader.Reset;
        PaymentHeader.SetRange(PaymentHeader."No.", NewPVLine.No);
        if PaymentHeader.Find('-') then begin
            ApplnDate := PaymentHeader.Date;
            ApplnCurrencyCode := PaymentHeader."Currency Code";
            // CalcType := Calctype::PV;
        end;
        case ApplnTypeSelect of
            NewPVLine.FieldNo("Applies-to Doc. No."):
                ApplnType := Applntype::"Applies-to Doc. No.";
            NewPVLine.FieldNo("Applies-to ID"):
                ApplnType := Applntype::"Applies-to ID";
        end;

        SetApplyingVendLedgEntry;
    end;

    procedure SetPVLine(NewPVLine: Record "Payment Line"; var NewVendLedgEntry: Record "Vendor Ledger Entry"; ApplnTypeSelect: Integer)
    var
        PaymentHeader: Record "Payments Header";
    begin
        PVLine := NewPVLine;
        Rec.CopyFilters(NewVendLedgEntry);

        ApplyingAmount := PVLine.Amount;

        PaymentHeader.Reset;
        PaymentHeader.SetRange(PaymentHeader."No.", NewPVLine.No);

        if PaymentHeader.Find('-') then begin
            ApplnDate := PaymentHeader.Date;
            ApplnCurrencyCode := PaymentHeader."Currency Code";
            CalcType := Calctype::"Purchase Header";
        end;

        case ApplnTypeSelect of
            NewPVLine.FieldNo("Applies-to Doc. No."):
                ApplnType := Applntype::"Applies-to Doc. No.";
            NewPVLine.FieldNo("Applies-to ID"):
                ApplnType := Applntype::"Applies-to ID";
        end;
        SetApplyingVendLedgEntry;
    end;

}
