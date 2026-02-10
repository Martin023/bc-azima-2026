#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185642 pageextension52185642 extends Navigate
{
    layout
    {
        modify(DocNoFilter)
        {
            ApplicationArea = Basic;
        }
        modify(PostingDateFilter)
        {
            ApplicationArea = Basic;
        }
        modify(ContactType)
        {
            ApplicationArea = Basic;
        }
        modify(ContactNo)
        {
            ApplicationArea = Basic;
        }
        modify(ExtDocNo)
        {
            ApplicationArea = Basic;
        }
        modify(SerialNoFilter)
        {
            ApplicationArea = Basic;
        }
        modify(LotNoFilter)
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Table ID")
        {
            ApplicationArea = Basic;
        }
        modify("Table Name")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Records")
        {
            ApplicationArea = Basic;
        }
        modify(DocType)
        {
            ApplicationArea = Basic;
        }
        modify(SourceType)
        {
            ApplicationArea = Basic;
        }
        modify(SourceNo)
        {
            ApplicationArea = Basic;
        }
        modify(SourceName)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "DocNoFilter(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PostingDateFilter(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ContactType(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ContactNo(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ExtDocNo(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SerialNoFilter(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LotNoFilter(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Table ID"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Table Name"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Records"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DocType(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SourceType(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SourceNo(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SourceName(Control 14)".

    }
    actions
    {
        modify(Show)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (RunPageMode) on "Show(Action 21)".

        }
        modify(Find)
        {
            ApplicationArea = Basic;
        }
        modify(Print)
        {
            ApplicationArea = Basic;
        }
        modify(FindByDocument)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on "FindByDocument(Action 2)".


            //Unsupported feature: Property Insertion (PromotedIsBig) on "FindByDocument(Action 2)".


            //Unsupported feature: Property Insertion (PromotedCategory) on "FindByDocument(Action 2)".

        }
        modify(FindByBusinessContact)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on "FindByBusinessContact(Action 27)".


            //Unsupported feature: Property Insertion (PromotedIsBig) on "FindByBusinessContact(Action 27)".


            //Unsupported feature: Property Insertion (PromotedCategory) on "FindByBusinessContact(Action 27)".

        }
        modify(FindByItemReference)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on "FindByItemReference(Action 28)".


            //Unsupported feature: Property Insertion (PromotedIsBig) on "FindByItemReference(Action 28)".


            //Unsupported feature: Property Insertion (PromotedCategory) on "FindByItemReference(Action 28)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Show(Action 21)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Show(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Find(Action 29)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Find(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Print(Action 34)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Print(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FindByDocument(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FindByBusinessContact(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FindByItemReference(Action 28)".

    }

    //Unsupported feature: Property Modification (Data type) on "DocNoFilter(Variable 1068)".

    //var
    //>>>> ORIGINAL VALUE:
    //DocNoFilter : Text;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DocNoFilter : Code;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "DocType(Variable 1074)".

    //var
    //>>>> ORIGINAL VALUE:
    //DocType : 100;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DocType : 50;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "SourceName(Variable 1077)".

    //var
    //>>>> ORIGINAL VALUE:
    //SourceName : 100;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SourceName : 50;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "NewSerialNo(Variable 1136)".

    //var
    //>>>> ORIGINAL VALUE:
    //NewSerialNo : 50;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NewSerialNo : 20;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "NewLotNo(Variable 1122)".

    //var
    //>>>> ORIGINAL VALUE:
    //NewLotNo : 50;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NewLotNo : 20;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "SerialNoFilter(Variable 1157)".

    //var
    //>>>> ORIGINAL VALUE:
    //SerialNoFilter : Text;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SerialNoFilter : Code;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "LotNoFilter(Variable 1158)".

    //var
    //>>>> ORIGINAL VALUE:
    //LotNoFilter : Text;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //LotNoFilter : Code;
    //Variable type has not been exported.

    var
        //ApplicationManagement: Codeunit ApplicationManagement;

    var
        [SecurityFiltering(Securityfilter::Filtered)]
        SavingAccLedgEntry: Record 52185732;
        CreditAccLedgeEntry: Record 52185733;

    //Unsupported feature: Property Deletion (Attributes) on "SetDoc(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "FindExtRecords(PROCEDURE 8)".

    //procedure FindExtRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FoundRecords := FALSE;
    CASE ContactType OF
      ContactType::Vendor:
    #4..31
            SalesShptHeader.SETCURRENTKEY("Sell-to Customer No.","External Document No.");
            SalesShptHeader.SETFILTER("Sell-to Customer No.",ContactNo);
            SalesShptHeader.SETFILTER("External Document No.",ExtDocNo);
            InsertIntoDocEntry(Rec,DATABASE::"Sales Shipment Header",0,Text005,SalesShptHeader.COUNT);
          END;
          IF SalesInvHeader.READPERMISSION THEN BEGIN
            SalesInvHeader.RESET;
            SalesInvHeader.SETCURRENTKEY("Sell-to Customer No.","External Document No.");
            SalesInvHeader.SETFILTER("Sell-to Customer No.",ContactNo);
            SalesInvHeader.SETFILTER("External Document No.",ExtDocNo);
            InsertIntoDocEntry(Rec,DATABASE::"Sales Invoice Header",0,Text003,SalesInvHeader.COUNT);
          END;
          IF ReturnRcptHeader.READPERMISSION THEN BEGIN
            ReturnRcptHeader.RESET;
            ReturnRcptHeader.SETCURRENTKEY("Sell-to Customer No.","External Document No.");
            ReturnRcptHeader.SETFILTER("Sell-to Customer No.",ContactNo);
            ReturnRcptHeader.SETFILTER("External Document No.",ExtDocNo);
            InsertIntoDocEntry(Rec,DATABASE::"Return Receipt Header",0,Text017,ReturnRcptHeader.COUNT);
          END;
          IF SalesCrMemoHeader.READPERMISSION THEN BEGIN
            SalesCrMemoHeader.RESET;
            SalesCrMemoHeader.SETCURRENTKEY("Sell-to Customer No.","External Document No.");
            SalesCrMemoHeader.SETFILTER("Sell-to Customer No.",ContactNo);
            SalesCrMemoHeader.SETFILTER("External Document No.",ExtDocNo);
            InsertIntoDocEntry(Rec,DATABASE::"Sales Cr.Memo Header",0,Text004,SalesCrMemoHeader.COUNT);
          END;
          FindUnpostedServDocs(SOServHeader."Document Type"::Order,sText021,SOServHeader);
          FindUnpostedServDocs(SIServHeader."Document Type"::Invoice,sText022,SIServHeader);
          FindUnpostedServDocs(SCMServHeader."Document Type"::"Credit Memo",sText024,SCMServHeader);
          IF ServShptHeader.READPERMISSION THEN
            IF ExtDocNo = '' THEN BEGIN
              ServShptHeader.RESET;
              ServShptHeader.SETCURRENTKEY("Customer No.");
              ServShptHeader.SETFILTER("Customer No.",ContactNo);
              InsertIntoDocEntry(Rec,DATABASE::"Service Shipment Header",0,sText005,ServShptHeader.COUNT);
            END;
          IF ServInvHeader.READPERMISSION THEN
            IF ExtDocNo = '' THEN BEGIN
              ServInvHeader.RESET;
              ServInvHeader.SETCURRENTKEY("Customer No.");
              ServInvHeader.SETFILTER("Customer No.",ContactNo);
              InsertIntoDocEntry(Rec,DATABASE::"Service Invoice Header",0,sText003,ServInvHeader.COUNT);
            END;
          IF ServCrMemoHeader.READPERMISSION THEN
            IF ExtDocNo = '' THEN BEGIN
              ServCrMemoHeader.RESET;
              ServCrMemoHeader.SETCURRENTKEY("Customer No.");
              ServCrMemoHeader.SETFILTER("Customer No.",ContactNo);
              InsertIntoDocEntry(Rec,DATABASE::"Service Cr.Memo Header",0,sText004,ServCrMemoHeader.COUNT);
            END;

          DocExists := FINDFIRST;

    #85..92
      SetSource(0D,'','',0,'');
      MESSAGE(Text001);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..34
            InsertIntoDocEntry(
              DATABASE::"Sales Shipment Header",0,Text005,SalesShptHeader.COUNT);
    #36..41
            InsertIntoDocEntry(
              DATABASE::"Sales Invoice Header",0,Text003,SalesInvHeader.COUNT);
    #43..48
            InsertIntoDocEntry(
              DATABASE::"Return Receipt Header",0,Text017,ReturnRcptHeader.COUNT);
    #50..55
            InsertIntoDocEntry(
              DATABASE::"Sales Cr.Memo Header",0,Text004,SalesCrMemoHeader.COUNT);
    #57..60
          IF ServShptHeader.READPERMISSION THEN BEGIN
    #62..65
              InsertIntoDocEntry(
                DATABASE::"Service Shipment Header",0,sText005,ServShptHeader.COUNT);
            END;
          END;
          IF ServInvHeader.READPERMISSION THEN BEGIN
    #69..72
              InsertIntoDocEntry(
                DATABASE::"Service Invoice Header",0,sText003,ServInvHeader.COUNT);
            END;
          END;
          IF ServCrMemoHeader.READPERMISSION THEN BEGIN
    #76..79
              InsertIntoDocEntry(
                DATABASE::"Service Cr.Memo Header",0,sText004,ServCrMemoHeader.COUNT);
            END;
          END;
    #82..95
    */
    //end;


    //Unsupported feature: Code Modification on "FindRecords(PROCEDURE 2)".

    //procedure FindRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeFindRecords(HideDialog);
    IF NOT HideDialog THEN
      Window.OPEN(Text002);
    RESET;
    DELETEALL;
    "Entry No." := 0;

    FindPostedDocuments;
    FindLedgerEntries;

    OnAfterNavigateFindRecords(Rec,DocNoFilter,PostingDateFilter);
    DocExists := FINDFIRST;

    SetSource(0D,'','',0,'');
    IF DocExists THEN BEGIN
      IF (NoOfRecords(DATABASE::"Cust. Ledger Entry") + NoOfRecords(DATABASE::"Vendor Ledger Entry") <= 1) AND
         (GetDocumentCount <= 1)
      THEN BEGIN
        SetSourceForService;
        SetSourceForSales;
        SetSourceForPurchase;
        SetSourceForServiceDoc;

        IsSourceUpdated := FALSE;
        OnFindRecordsOnAfterSetSource(
          Rec,PostingDate,DocType2,DocNo2,SourceType2,SourceNo2,DocNoFilter,PostingDateFilter,IsSourceUpdated);
        IF IsSourceUpdated THEN
          SetSource(PostingDate,DocType2,DocNo2,SourceType2,SourceNo2);
      END ELSE BEGIN
        IF DocNoFilter <> '' THEN
          IF PostingDateFilter = '' THEN
            MESSAGE(Text011)
          ELSE
            MESSAGE(Text012);
      END;
    END ELSE
      IF PostingDateFilter = '' THEN
        MESSAGE(Text013)
      ELSE
        MESSAGE(Text014);

    OnAfterFindRecords(Rec,DocNoFilter,PostingDateFilter);

    IF UpdateForm THEN
      UpdateFormAfterFindRecords;

    IF NOT HideDialog THEN
      Window.CLOSE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Window.OPEN(Text002);
    #4..6
    FindIncomingDocumentRecords;
    IF SalesShptHeader.READPERMISSION THEN BEGIN
      SalesShptHeader.RESET;
      SalesShptHeader.SETFILTER("No.",DocNoFilter);
      SalesShptHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Sales Shipment Header",0,Text005,SalesShptHeader.COUNT);
    END;
    IF SalesInvHeader.READPERMISSION THEN BEGIN
      SalesInvHeader.RESET;
      SalesInvHeader.SETFILTER("No.",DocNoFilter);
      SalesInvHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Sales Invoice Header",0,Text003,SalesInvHeader.COUNT);
    END;
    IF ReturnRcptHeader.READPERMISSION THEN BEGIN
      ReturnRcptHeader.RESET;
      ReturnRcptHeader.SETFILTER("No.",DocNoFilter);
      ReturnRcptHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Return Receipt Header",0,Text017,ReturnRcptHeader.COUNT);
    END;
    IF SalesCrMemoHeader.READPERMISSION THEN BEGIN
      SalesCrMemoHeader.RESET;
      SalesCrMemoHeader.SETFILTER("No.",DocNoFilter);
      SalesCrMemoHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Sales Cr.Memo Header",0,Text004,SalesCrMemoHeader.COUNT);
    END;
    IF ServShptHeader.READPERMISSION THEN BEGIN
      ServShptHeader.RESET;
      ServShptHeader.SETFILTER("No.",DocNoFilter);
      ServShptHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Service Shipment Header",0,sText005,ServShptHeader.COUNT);
    END;
    IF ServInvHeader.READPERMISSION THEN BEGIN
      ServInvHeader.RESET;
      ServInvHeader.SETFILTER("No.",DocNoFilter);
      ServInvHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Service Invoice Header",0,sText003,ServInvHeader.COUNT);
    END;
    IF ServCrMemoHeader.READPERMISSION THEN BEGIN
      ServCrMemoHeader.RESET;
      ServCrMemoHeader.SETFILTER("No.",DocNoFilter);
      ServCrMemoHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Service Cr.Memo Header",0,sText004,ServCrMemoHeader.COUNT);
    END;
    IF IssuedReminderHeader.READPERMISSION THEN BEGIN
      IssuedReminderHeader.RESET;
      IssuedReminderHeader.SETFILTER("No.",DocNoFilter);
      IssuedReminderHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Issued Reminder Header",0,Text006,IssuedReminderHeader.COUNT);
    END;
    IF IssuedFinChrgMemoHeader.READPERMISSION THEN BEGIN
      IssuedFinChrgMemoHeader.RESET;
      IssuedFinChrgMemoHeader.SETFILTER("No.",DocNoFilter);
      IssuedFinChrgMemoHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Issued Fin. Charge Memo Header",0,Text007,
        IssuedFinChrgMemoHeader.COUNT);
    END;
    IF PurchRcptHeader.READPERMISSION THEN BEGIN
      PurchRcptHeader.RESET;
      PurchRcptHeader.SETFILTER("No.",DocNoFilter);
      PurchRcptHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Purch. Rcpt. Header",0,Text010,PurchRcptHeader.COUNT);
    END;
    IF PurchInvHeader.READPERMISSION THEN BEGIN
      PurchInvHeader.RESET;
      PurchInvHeader.SETFILTER("No.",DocNoFilter);
      PurchInvHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Purch. Inv. Header",0,Text008,PurchInvHeader.COUNT);
    END;
    IF ReturnShptHeader.READPERMISSION THEN BEGIN
      ReturnShptHeader.RESET;
      ReturnShptHeader.SETFILTER("No.",DocNoFilter);
      ReturnShptHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Return Shipment Header",0,Text018,ReturnShptHeader.COUNT);
    END;
    IF PurchCrMemoHeader.READPERMISSION THEN BEGIN
      PurchCrMemoHeader.RESET;
      PurchCrMemoHeader.SETFILTER("No.",DocNoFilter);
      PurchCrMemoHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Purch. Cr. Memo Hdr.",0,Text009,PurchCrMemoHeader.COUNT);
    END;
    IF ProductionOrderHeader.READPERMISSION THEN BEGIN
      ProductionOrderHeader.RESET;
      ProductionOrderHeader.SETRANGE(
        Status,
        ProductionOrderHeader.Status::Released,
        ProductionOrderHeader.Status::Finished);
      ProductionOrderHeader.SETFILTER("No.",DocNoFilter);
      InsertIntoDocEntry(
        DATABASE::"Production Order",0,Text99000000,ProductionOrderHeader.COUNT);
    END;
    IF PostedAssemblyHeader.READPERMISSION THEN BEGIN
      PostedAssemblyHeader.RESET;
      PostedAssemblyHeader.SETFILTER("No.",DocNoFilter);
      InsertIntoDocEntry(
        DATABASE::"Posted Assembly Header",0,Text025,PostedAssemblyHeader.COUNT);
    END;
    IF TransShptHeader.READPERMISSION THEN BEGIN
      TransShptHeader.RESET;
      TransShptHeader.SETFILTER("No.",DocNoFilter);
      TransShptHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Transfer Shipment Header",0,Text019,TransShptHeader.COUNT);
    END;
    IF TransRcptHeader.READPERMISSION THEN BEGIN
      TransRcptHeader.RESET;
      TransRcptHeader.SETFILTER("No.",DocNoFilter);
      TransRcptHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Transfer Receipt Header",0,Text020,TransRcptHeader.COUNT);
    END;
    IF PostedWhseShptLine.READPERMISSION THEN BEGIN
      PostedWhseShptLine.RESET;
      PostedWhseShptLine.SETCURRENTKEY("Posted Source No.","Posting Date");
      PostedWhseShptLine.SETFILTER("Posted Source No.",DocNoFilter);
      PostedWhseShptLine.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Posted Whse. Shipment Line",0,
        PostedWhseShptLine.TABLECAPTION,PostedWhseShptLine.COUNT);
    END;
    IF PostedWhseRcptLine.READPERMISSION THEN BEGIN
      PostedWhseRcptLine.RESET;
      PostedWhseRcptLine.SETCURRENTKEY("Posted Source No.","Posting Date");
      PostedWhseRcptLine.SETFILTER("Posted Source No.",DocNoFilter);
      PostedWhseRcptLine.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Posted Whse. Receipt Line",0,
        PostedWhseRcptLine.TABLECAPTION,PostedWhseRcptLine.COUNT);
    END;
    IF GLEntry.READPERMISSION THEN BEGIN
      GLEntry.RESET;
      GLEntry.SETCURRENTKEY("Document No.","Posting Date");
      GLEntry.SETFILTER("Document No.",DocNoFilter);
      GLEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"G/L Entry",0,GLEntry.TABLECAPTION,GLEntry.COUNT);
    END;
    IF VATEntry.READPERMISSION THEN BEGIN
      VATEntry.RESET;
      VATEntry.SETCURRENTKEY("Document No.","Posting Date");
      VATEntry.SETFILTER("Document No.",DocNoFilter);
      VATEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"VAT Entry",0,VATEntry.TABLECAPTION,VATEntry.COUNT);
    END;
    IF CustLedgEntry.READPERMISSION THEN BEGIN
      CustLedgEntry.RESET;
      CustLedgEntry.SETCURRENTKEY("Document No.");
      CustLedgEntry.SETFILTER("Document No.",DocNoFilter);
      CustLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Cust. Ledger Entry",0,CustLedgEntry.TABLECAPTION,CustLedgEntry.COUNT);
    END;
    IF DtldCustLedgEntry.READPERMISSION THEN BEGIN
      DtldCustLedgEntry.RESET;
      DtldCustLedgEntry.SETCURRENTKEY("Document No.");
      DtldCustLedgEntry.SETFILTER("Document No.",DocNoFilter);
      DtldCustLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Detailed Cust. Ledg. Entry",0,DtldCustLedgEntry.TABLECAPTION,DtldCustLedgEntry.COUNT);
    END;

    IF ReminderEntry.READPERMISSION THEN BEGIN
      ReminderEntry.RESET;
      ReminderEntry.SETCURRENTKEY(Type,"No.");
      ReminderEntry.SETFILTER("No.",DocNoFilter);
      ReminderEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Reminder/Fin. Charge Entry",0,ReminderEntry.TABLECAPTION,ReminderEntry.COUNT);
    END;
    IF VendLedgEntry.READPERMISSION THEN BEGIN
      VendLedgEntry.RESET;
      VendLedgEntry.SETCURRENTKEY("Document No.");
      VendLedgEntry.SETFILTER("Document No.",DocNoFilter);
      VendLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Vendor Ledger Entry",0,VendLedgEntry.TABLECAPTION,VendLedgEntry.COUNT);
    END;
    IF DtldVendLedgEntry.READPERMISSION THEN BEGIN
      DtldVendLedgEntry.RESET;
      DtldVendLedgEntry.SETCURRENTKEY("Document No.");
      DtldVendLedgEntry.SETFILTER("Document No.",DocNoFilter);
      DtldVendLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Detailed Vendor Ledg. Entry",0,DtldVendLedgEntry.TABLECAPTION,DtldVendLedgEntry.COUNT);
    END;
    IF ItemLedgEntry.READPERMISSION THEN BEGIN
      ItemLedgEntry.RESET;
      ItemLedgEntry.SETCURRENTKEY("Document No.");
      ItemLedgEntry.SETFILTER("Document No.",DocNoFilter);
      ItemLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Item Ledger Entry",0,ItemLedgEntry.TABLECAPTION,ItemLedgEntry.COUNT);
    END;
    IF ValueEntry.READPERMISSION THEN BEGIN
      ValueEntry.RESET;
      ValueEntry.SETCURRENTKEY("Document No.");
      ValueEntry.SETFILTER("Document No.",DocNoFilter);
      ValueEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Value Entry",0,ValueEntry.TABLECAPTION,ValueEntry.COUNT);
    END;
    IF PhysInvtLedgEntry.READPERMISSION THEN BEGIN
      PhysInvtLedgEntry.RESET;
      PhysInvtLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
      PhysInvtLedgEntry.SETFILTER("Document No.",DocNoFilter);
      PhysInvtLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Phys. Inventory Ledger Entry",0,PhysInvtLedgEntry.TABLECAPTION,PhysInvtLedgEntry.COUNT);
    END;
    IF ResLedgEntry.READPERMISSION THEN BEGIN
      ResLedgEntry.RESET;
      ResLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
      ResLedgEntry.SETFILTER("Document No.",DocNoFilter);
      ResLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Res. Ledger Entry",0,ResLedgEntry.TABLECAPTION,ResLedgEntry.COUNT);
    END;
    FindJobRecords;
    IF BankAccLedgEntry.READPERMISSION THEN BEGIN
      BankAccLedgEntry.RESET;
      BankAccLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
      BankAccLedgEntry.SETFILTER("Document No.",DocNoFilter);
      BankAccLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Bank Account Ledger Entry",0,BankAccLedgEntry.TABLECAPTION,BankAccLedgEntry.COUNT);
    END;
    IF CheckLedgEntry.READPERMISSION THEN BEGIN
      CheckLedgEntry.RESET;
      CheckLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
      CheckLedgEntry.SETFILTER("Document No.",DocNoFilter);
      CheckLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Check Ledger Entry",0,CheckLedgEntry.TABLECAPTION,CheckLedgEntry.COUNT);
    END;
    IF FALedgEntry.READPERMISSION THEN BEGIN
      FALedgEntry.RESET;
      FALedgEntry.SETCURRENTKEY("Document No.","Posting Date");
      FALedgEntry.SETFILTER("Document No.",DocNoFilter);
      FALedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"FA Ledger Entry",0,FALedgEntry.TABLECAPTION,FALedgEntry.COUNT);
    END;
    IF MaintenanceLedgEntry.READPERMISSION THEN BEGIN
      MaintenanceLedgEntry.RESET;
      MaintenanceLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
      MaintenanceLedgEntry.SETFILTER("Document No.",DocNoFilter);
      MaintenanceLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Maintenance Ledger Entry",0,MaintenanceLedgEntry.TABLECAPTION,MaintenanceLedgEntry.COUNT);
    END;
    IF InsuranceCovLedgEntry.READPERMISSION THEN BEGIN
      InsuranceCovLedgEntry.RESET;
      InsuranceCovLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
      InsuranceCovLedgEntry.SETFILTER("Document No.",DocNoFilter);
      InsuranceCovLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Ins. Coverage Ledger Entry",0,InsuranceCovLedgEntry.TABLECAPTION,InsuranceCovLedgEntry.COUNT);
    END;
    IF CapacityLedgEntry.READPERMISSION THEN BEGIN
      CapacityLedgEntry.RESET;
      CapacityLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
      CapacityLedgEntry.SETFILTER("Document No.",DocNoFilter);
      CapacityLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Capacity Ledger Entry",0,CapacityLedgEntry.TABLECAPTION,CapacityLedgEntry.COUNT);
    END;
    IF WhseEntry.READPERMISSION THEN BEGIN
      WhseEntry.RESET;
      WhseEntry.SETCURRENTKEY("Reference No.","Registering Date");
      WhseEntry.SETFILTER("Reference No.",DocNoFilter);
      WhseEntry.SETFILTER("Registering Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Warehouse Entry",0,WhseEntry.TABLECAPTION,WhseEntry.COUNT);
    END;

    IF ServLedgerEntry.READPERMISSION THEN BEGIN
      ServLedgerEntry.RESET;
      ServLedgerEntry.SETCURRENTKEY("Document No.","Posting Date");
      ServLedgerEntry.SETFILTER("Document No.",DocNoFilter);
      ServLedgerEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Service Ledger Entry",0,ServLedgerEntry.TABLECAPTION,ServLedgerEntry.COUNT);
    END;
    IF WarrantyLedgerEntry.READPERMISSION THEN BEGIN
      WarrantyLedgerEntry.RESET;
      WarrantyLedgerEntry.SETCURRENTKEY("Document No.","Posting Date");
      WarrantyLedgerEntry.SETFILTER("Document No.",DocNoFilter);
      WarrantyLedgerEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Warranty Ledger Entry",0,WarrantyLedgerEntry.TABLECAPTION,WarrantyLedgerEntry.COUNT);
    END;

    IF CostEntry.READPERMISSION THEN BEGIN
      CostEntry.RESET;
      CostEntry.SETCURRENTKEY("Document No.","Posting Date");
      CostEntry.SETFILTER("Document No.",DocNoFilter);
      CostEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Cost Entry",0,CostEntry.TABLECAPTION,CostEntry.COUNT);
    END;

    //Bett
    IF SavingAccLedgEntry.READPERMISSION THEN BEGIN
      SavingAccLedgEntry.RESET;
      SavingAccLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
      SavingAccLedgEntry.SETFILTER("Document No.",DocNoFilter);
      SavingAccLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Savings Ledger Entry",0,SavingAccLedgEntry.TABLECAPTION,SavingAccLedgEntry.COUNT);
    END;

    IF CreditAccLedgeEntry.READPERMISSION THEN BEGIN
      CreditAccLedgeEntry.RESET;
      CreditAccLedgeEntry.SETCURRENTKEY("Document No.","Posting Date");
      CreditAccLedgeEntry.SETFILTER("Document No.",DocNoFilter);
      CreditAccLedgeEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Credit Ledger Entry",0,CreditAccLedgeEntry.TABLECAPTION,CreditAccLedgeEntry.COUNT);
    END;

    //Bett

    #12..16
         (NoOfRecords(DATABASE::"Sales Invoice Header") + NoOfRecords(DATABASE::"Sales Cr.Memo Header") +
          NoOfRecords(DATABASE::"Sales Shipment Header") + NoOfRecords(DATABASE::"Issued Reminder Header") +
          NoOfRecords(DATABASE::"Issued Fin. Charge Memo Header") + NoOfRecords(DATABASE::"Purch. Inv. Header") +
          NoOfRecords(DATABASE::"Return Shipment Header") + NoOfRecords(DATABASE::"Return Receipt Header") +
          NoOfRecords(DATABASE::"Purch. Cr. Memo Hdr.") + NoOfRecords(DATABASE::"Purch. Rcpt. Header") +
          NoOfRecords(DATABASE::"Service Invoice Header") + NoOfRecords(DATABASE::"Service Cr.Memo Header") +
          NoOfRecords(DATABASE::"Service Shipment Header") +
          NoOfRecords(DATABASE::"Transfer Shipment Header") + NoOfRecords(DATABASE::"Transfer Receipt Header") <= 1)
      THEN BEGIN
        // Service Management
        IF NoOfRecords(DATABASE::"Service Ledger Entry") = 1 THEN BEGIN
          ServLedgerEntry.FINDFIRST;
          IF ServLedgerEntry.Type = ServLedgerEntry.Type::"Service Contract" THEN
            SetSource(
              ServLedgerEntry."Posting Date",FORMAT(ServLedgerEntry."Document Type"),ServLedgerEntry."Document No.",
              2,ServLedgerEntry."Service Contract No.")
          ELSE
            SetSource(
              ServLedgerEntry."Posting Date",FORMAT(ServLedgerEntry."Document Type"),ServLedgerEntry."Document No.",
              2,ServLedgerEntry."Service Order No.")
        END;
        IF NoOfRecords(DATABASE::"Warranty Ledger Entry") = 1 THEN BEGIN
          WarrantyLedgerEntry.FINDFIRST;
          SetSource(
            WarrantyLedgerEntry."Posting Date",'',WarrantyLedgerEntry."Document No.",
            2,WarrantyLedgerEntry."Service Order No.")
        END;

        // Sales
        IF NoOfRecords(DATABASE::"Cust. Ledger Entry") = 1 THEN BEGIN
          CustLedgEntry.FINDFIRST;
          SetSource(
            CustLedgEntry."Posting Date",FORMAT(CustLedgEntry."Document Type"),CustLedgEntry."Document No.",
            1,CustLedgEntry."Customer No.");
        END;
        IF NoOfRecords(DATABASE::"Detailed Cust. Ledg. Entry") = 1 THEN BEGIN
          DtldCustLedgEntry.FINDFIRST;
          SetSource(
            DtldCustLedgEntry."Posting Date",FORMAT(DtldCustLedgEntry."Document Type"),DtldCustLedgEntry."Document No.",
            1,DtldCustLedgEntry."Customer No.");
        END;
        IF NoOfRecords(DATABASE::"Sales Invoice Header") = 1 THEN BEGIN
          SalesInvHeader.FINDFIRST;
          SetSource(
            SalesInvHeader."Posting Date",FORMAT("Table Name"),SalesInvHeader."No.",
            1,SalesInvHeader."Bill-to Customer No.");
        END;
        IF NoOfRecords(DATABASE::"Sales Cr.Memo Header") = 1 THEN BEGIN
          SalesCrMemoHeader.FINDFIRST;
          SetSource(
            SalesCrMemoHeader."Posting Date",FORMAT("Table Name"),SalesCrMemoHeader."No.",
            1,SalesCrMemoHeader."Bill-to Customer No.");
        END;
        IF NoOfRecords(DATABASE::"Return Receipt Header") = 1 THEN BEGIN
          ReturnRcptHeader.FINDFIRST;
          SetSource(
            ReturnRcptHeader."Posting Date",FORMAT("Table Name"),ReturnRcptHeader."No.",
            1,ReturnRcptHeader."Sell-to Customer No.");
        END;
        IF NoOfRecords(DATABASE::"Sales Shipment Header") = 1 THEN BEGIN
          SalesShptHeader.FINDFIRST;
          SetSource(
            SalesShptHeader."Posting Date",FORMAT("Table Name"),SalesShptHeader."No.",
            1,SalesShptHeader."Sell-to Customer No.");
        END;
        IF NoOfRecords(DATABASE::"Posted Whse. Shipment Line") = 1 THEN BEGIN
          PostedWhseShptLine.FINDFIRST;
          SetSource(
            PostedWhseShptLine."Posting Date",FORMAT("Table Name"),PostedWhseShptLine."No.",
            1,PostedWhseShptLine."Destination No.");
        END;
        IF NoOfRecords(DATABASE::"Issued Reminder Header") = 1 THEN BEGIN
          IssuedReminderHeader.FINDFIRST;
          SetSource(
            IssuedReminderHeader."Posting Date",FORMAT("Table Name"),IssuedReminderHeader."No.",
            1,IssuedReminderHeader."Customer No.");
        END;
        IF NoOfRecords(DATABASE::"Issued Fin. Charge Memo Header") = 1 THEN BEGIN
          IssuedFinChrgMemoHeader.FINDFIRST;
          SetSource(
            IssuedFinChrgMemoHeader."Posting Date",FORMAT("Table Name"),IssuedFinChrgMemoHeader."No.",
            1,IssuedFinChrgMemoHeader."Customer No.");
        END;

        IF NoOfRecords(DATABASE::"Service Invoice Header") = 1 THEN BEGIN
          ServInvHeader.FINDFIRST;
          SetSource(
            ServInvHeader."Posting Date",FORMAT("Table Name"),ServInvHeader."No.",
            1,ServInvHeader."Bill-to Customer No.");
        END;
        IF NoOfRecords(DATABASE::"Service Cr.Memo Header") = 1 THEN BEGIN
          ServCrMemoHeader.FINDFIRST;
          SetSource(
            ServCrMemoHeader."Posting Date",FORMAT("Table Name"),ServCrMemoHeader."No.",
            1,ServCrMemoHeader."Bill-to Customer No.");
        END;
        IF NoOfRecords(DATABASE::"Service Shipment Header") = 1 THEN BEGIN
          ServShptHeader.FINDFIRST;
          SetSource(
            ServShptHeader."Posting Date",FORMAT("Table Name"),ServShptHeader."No.",
            1,ServShptHeader."Customer No.");
        END;

        // Purchase
        IF NoOfRecords(DATABASE::"Vendor Ledger Entry") = 1 THEN BEGIN
          VendLedgEntry.FINDFIRST;
          SetSource(
            VendLedgEntry."Posting Date",FORMAT(VendLedgEntry."Document Type"),VendLedgEntry."Document No.",
            2,VendLedgEntry."Vendor No.");
        END;
        IF NoOfRecords(DATABASE::"Detailed Vendor Ledg. Entry") = 1 THEN BEGIN
          DtldVendLedgEntry.FINDFIRST;
          SetSource(
            DtldVendLedgEntry."Posting Date",FORMAT(DtldVendLedgEntry."Document Type"),DtldVendLedgEntry."Document No.",
            2,DtldVendLedgEntry."Vendor No.");
        END;
        IF NoOfRecords(DATABASE::"Purch. Inv. Header") = 1 THEN BEGIN
          PurchInvHeader.FINDFIRST;
          SetSource(
            PurchInvHeader."Posting Date",FORMAT("Table Name"),PurchInvHeader."No.",
            2,PurchInvHeader."Pay-to Vendor No.");
        END;
        IF NoOfRecords(DATABASE::"Purch. Cr. Memo Hdr.") = 1 THEN BEGIN
          PurchCrMemoHeader.FINDFIRST;
          SetSource(
            PurchCrMemoHeader."Posting Date",FORMAT("Table Name"),PurchCrMemoHeader."No.",
            2,PurchCrMemoHeader."Pay-to Vendor No.");
        END;
        IF NoOfRecords(DATABASE::"Return Shipment Header") = 1 THEN BEGIN
          ReturnShptHeader.FINDFIRST;
          SetSource(
            ReturnShptHeader."Posting Date",FORMAT("Table Name"),ReturnShptHeader."No.",
            2,ReturnShptHeader."Buy-from Vendor No.");
        END;
        IF NoOfRecords(DATABASE::"Purch. Rcpt. Header") = 1 THEN BEGIN
          PurchRcptHeader.FINDFIRST;
          SetSource(
            PurchRcptHeader."Posting Date",FORMAT("Table Name"),PurchRcptHeader."No.",
            2,PurchRcptHeader."Buy-from Vendor No.");
        END;
        IF NoOfRecords(DATABASE::"Posted Whse. Receipt Line") = 1 THEN BEGIN
          PostedWhseRcptLine.FINDFIRST;
          SetSource(
            PostedWhseRcptLine."Posting Date",FORMAT("Table Name"),PostedWhseRcptLine."No.",
            2,'');
        END;
    #29..41
    IF UpdateForm THEN
      UpdateFormAfterFindRecords;
    Window.CLOSE;
    */
    //end;

    //Unsupported feature: Property Modification (Name) on "FindJobEntries(PROCEDURE 26)".



    //Unsupported feature: Code Modification on "FindJobEntries(PROCEDURE 26)".

    //procedure FindJobEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF JobLedgEntry.READPERMISSION THEN BEGIN
      JobLedgEntry.RESET;
      JobLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
      JobLedgEntry.SETFILTER("Document No.",DocNoFilter);
      JobLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(Rec,DATABASE::"Job Ledger Entry",0,JobLedgEntry.TABLECAPTION,JobLedgEntry.COUNT);
    END;
    IF JobWIPEntry.READPERMISSION THEN BEGIN
      JobWIPEntry.RESET;
      JobWIPEntry.SETFILTER("Document No.",DocNoFilter);
      JobWIPEntry.SETFILTER("WIP Posting Date",PostingDateFilter);
      InsertIntoDocEntry(Rec,DATABASE::"Job WIP Entry",0,JobWIPEntry.TABLECAPTION,JobWIPEntry.COUNT);
    END;
    IF JobWIPGLEntry.READPERMISSION THEN BEGIN
      JobWIPGLEntry.RESET;
      JobWIPGLEntry.SETCURRENTKEY("Document No.","Posting Date");
      JobWIPGLEntry.SETFILTER("Document No.",DocNoFilter);
      JobWIPGLEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(Rec,DATABASE::"Job WIP G/L Entry",0,JobWIPGLEntry.TABLECAPTION,JobWIPGLEntry.COUNT);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
      InsertIntoDocEntry(
        DATABASE::"Job Ledger Entry",0,JobLedgEntry.TABLECAPTION,JobLedgEntry.COUNT);
    #7..11
      InsertIntoDocEntry(
        DATABASE::"Job WIP Entry",0,JobWIPEntry.TABLECAPTION,JobWIPEntry.COUNT);
    #13..18
      InsertIntoDocEntry(
        DATABASE::"Job WIP G/L Entry",0,JobWIPGLEntry.TABLECAPTION,JobWIPGLEntry.COUNT);
    END;
    */
    //end;


    //Unsupported feature: Code Modification on "FindIncomingDocumentRecords(PROCEDURE 27)".

    //procedure FindIncomingDocumentRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF IncomingDocument.READPERMISSION THEN BEGIN
      IncomingDocument.RESET;
      IncomingDocument.SETFILTER("Document No.",DocNoFilter);
      IncomingDocument.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(Rec,DATABASE::"Incoming Document",0,IncomingDocument.TABLECAPTION,IncomingDocument.COUNT);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
      InsertIntoDocEntry(
        DATABASE::"Incoming Document",0,IncomingDocument.TABLECAPTION,IncomingDocument.COUNT);
    END;
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: PageId) (ParameterCollection) on "GetPageId(PROCEDURE 29)".


    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "GetPageId(PROCEDURE 29)".


    //Unsupported feature: Variable Insertion (Variable: MiniPagesMapping) (VariableCollection) on "GetPageId(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Name) on "FindEmployeeRecords(PROCEDURE 29)".



    //Unsupported feature: Code Modification on "FindEmployeeRecords(PROCEDURE 29)".

    //procedure FindEmployeeRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF EmplLedgEntry.READPERMISSION THEN BEGIN
      EmplLedgEntry.RESET;
      EmplLedgEntry.SETCURRENTKEY("Document No.");
      EmplLedgEntry.SETFILTER("Document No.",DocNoFilter);
      EmplLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(Rec,DATABASE::"Employee Ledger Entry",0,EmplLedgEntry.TABLECAPTION,EmplLedgEntry.COUNT);
    END;
    IF DtldEmplLedgEntry.READPERMISSION THEN BEGIN
      DtldEmplLedgEntry.RESET;
      DtldEmplLedgEntry.SETCURRENTKEY("Document No.");
      DtldEmplLedgEntry.SETFILTER("Document No.",DocNoFilter);
      DtldEmplLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(Rec,DATABASE::"Detailed Employee Ledger Entry",0,DtldEmplLedgEntry.TABLECAPTION,DtldEmplLedgEntry.COUNT);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF MiniPagesMapping.READPERMISSION THEN
      IF MiniPagesMapping.GET(PageId) THEN
        EXIT(MiniPagesMapping."Substitute Page ID");

    EXIT(PageId);
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateFormAfterFindRecords(PROCEDURE 15)".

    //procedure UpdateFormAfterFindRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeUpdateFormAfterFindRecords;

    ShowEnable := DocExists;
    PrintEnable := DocExists;
    CurrPage.UPDATE(FALSE);
    DocExists := FINDFIRST;
    IF DocExists THEN;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #3..7
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "InsertIntoDocEntry(PROCEDURE 3)".


    //Unsupported feature: Property Insertion (Local) on "InsertIntoDocEntry(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "InsertIntoDocEntry(PROCEDURE 3)".

    //procedure InsertIntoDocEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF DocNoOfRecords = 0 THEN
      EXIT;

    WITH TempDocumentEntry DO BEGIN
      INIT;
      "Entry No." := "Entry No." + 1;
      "Table ID" := DocTableID;
      "Document Type" := DocType;
      "Table Name" := COPYSTR(DocTableName,1,MAXSTRLEN("Table Name"));
      "No. of Records" := DocNoOfRecords;
      INSERT;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF DocNoOfRecords = 0 THEN
      EXIT;
    INIT;
    "Entry No." := "Entry No." + 1;
    "Table ID" := DocTableID;
    "Document Type" := DocType;
    "Table Name" := COPYSTR(DocTableName,1,MAXSTRLEN("Table Name"));
    "No. of Records" := DocNoOfRecords;
    INSERT;
    */
    //end;


    //Unsupported feature: Code Modification on "ShowRecords(PROCEDURE 6)".

    //procedure ShowRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeNavigateShowRecords(
      "Table ID",DocNoFilter,PostingDateFilter,ItemTrackingSearch,Rec,IsHandled,
      SalesInvHeader,SalesCrMemoHeader,PurchInvHeader,PurchCrMemoHeader,ServInvHeader,ServCrMemoHeader);
    IF IsHandled THEN
      EXIT;

    IF ItemTrackingSearch THEN
      ItemTrackingNavigateMgt.Show("Table ID")
    ELSE
    #11..14
          ShowSalesHeaderRecords;
        DATABASE::"Sales Invoice Header":
          IF "No. of Records" = 1 THEN
            PAGE.RUN(PAGE::"Posted Sales Invoice",SalesInvHeader)
          ELSE
            PAGE.RUN(PAGE::"Posted Sales Invoices",SalesInvHeader);
        DATABASE::"Sales Cr.Memo Header":
          IF "No. of Records" = 1 THEN
            PAGE.RUN(PAGE::"Posted Sales Credit Memo",SalesCrMemoHeader)
          ELSE
            PAGE.RUN(PAGE::"Posted Sales Credit Memos",SalesCrMemoHeader);
        DATABASE::"Return Receipt Header":
          IF "No. of Records" = 1 THEN
            PAGE.RUN(PAGE::"Posted Return Receipt",ReturnRcptHeader)
    #29..44
            PAGE.RUN(0,IssuedFinChrgMemoHeader);
        DATABASE::"Purch. Inv. Header":
          IF "No. of Records" = 1 THEN
            PAGE.RUN(PAGE::"Posted Purchase Invoice",PurchInvHeader)
          ELSE
            PAGE.RUN(PAGE::"Posted Purchase Invoices",PurchInvHeader);
        DATABASE::"Purch. Cr. Memo Hdr.":
          IF "No. of Records" = 1 THEN
            PAGE.RUN(PAGE::"Posted Purchase Credit Memo",PurchCrMemoHeader)
          ELSE
            PAGE.RUN(PAGE::"Posted Purchase Credit Memos",PurchCrMemoHeader);
        DATABASE::"Return Shipment Header":
          IF "No. of Records" = 1 THEN
            PAGE.RUN(PAGE::"Posted Return Shipment",ReturnShptHeader)
    #59..97
          PAGE.RUN(0,VendLedgEntry);
        DATABASE::"Detailed Vendor Ledg. Entry":
          PAGE.RUN(0,DtldVendLedgEntry);
        DATABASE::"Employee Ledger Entry":
          ShowEmployeeLedgerEntries;
        DATABASE::"Detailed Employee Ledger Entry":
          ShowDetailedEmployeeLedgerEntries;
        DATABASE::"Item Ledger Entry":
          PAGE.RUN(0,ItemLedgEntry);
        DATABASE::"Value Entry":
    #108..152
          PAGE.RUN(0,WarrantyLedgerEntry);
        DATABASE::"Cost Entry":
          PAGE.RUN(0,CostEntry);
        DATABASE::"Pstd. Phys. Invt. Order Hdr":
          PAGE.RUN(0,PstdPhysInvtOrderHdr);
      END;

    OnAfterNavigateShowRecords(
      "Table ID",DocNoFilter,PostingDateFilter,ItemTrackingSearch,Rec,
      SalesInvHeader,SalesCrMemoHeader,PurchInvHeader,PurchCrMemoHeader,ServInvHeader,ServCrMemoHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #8..17
            PAGE.RUN(GetPageId(PAGE::"Posted Sales Invoice"),SalesInvHeader)
          ELSE
            PAGE.RUN(GetPageId(PAGE::"Posted Sales Invoices"),SalesInvHeader);
        DATABASE::"Sales Cr.Memo Header":
          IF "No. of Records" = 1 THEN
            PAGE.RUN(GetPageId(PAGE::"Posted Sales Credit Memo"),SalesCrMemoHeader)
          ELSE
            PAGE.RUN(GetPageId(PAGE::"Posted Sales Credit Memos"),SalesCrMemoHeader);
    #26..47
            PAGE.RUN(GetPageId(PAGE::"Posted Purchase Invoice"),PurchInvHeader)
          ELSE
            PAGE.RUN(GetPageId(PAGE::"Posted Purchase Invoices"),PurchInvHeader);
        DATABASE::"Purch. Cr. Memo Hdr.":
          IF "No. of Records" = 1 THEN
            PAGE.RUN(GetPageId(PAGE::"Posted Purchase Credit Memo"),PurchCrMemoHeader)
          ELSE
            PAGE.RUN(GetPageId(PAGE::"Posted Purchase Credit Memos"),PurchCrMemoHeader);
    #56..100
    #105..155
        //Bett
        DATABASE::"Savings Ledger Entry":
          PAGE.RUN(0,SavingAccLedgEntry);
        DATABASE::"Credit Ledger Entry":
          PAGE.RUN(0,CreditAccLedgeEntry);
        //Bett
      END;
    */
    //end;


    //Unsupported feature: Code Modification on "ShowSalesHeaderRecords(PROCEDURE 28)".

    //procedure ShowSalesHeaderRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Table ID",DATABASE::"Sales Header");

    CASE "Document Type" OF
    #4..7
          PAGE.RUN(0,SOSalesHeader);
      "Document Type"::Invoice:
        IF "No. of Records" = 1 THEN
          PAGE.RUN(PAGE::"Sales Invoice",SISalesHeader)
        ELSE
          PAGE.RUN(0,SISalesHeader);
      "Document Type"::"Return Order":
    #15..17
          PAGE.RUN(0,SROSalesHeader);
      "Document Type"::"Credit Memo":
        IF "No. of Records" = 1 THEN
          PAGE.RUN(PAGE::"Sales Credit Memo",SCMSalesHeader)
        ELSE
          PAGE.RUN(0,SCMSalesHeader);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
          PAGE.RUN(GetPageId(PAGE::"Sales Invoice"),SISalesHeader)
    #12..20
          PAGE.RUN(GetPageId(PAGE::"Sales Credit Memo"),SCMSalesHeader)
    #22..24
    */
    //end;


    //Unsupported feature: Code Modification on "SetPostingDate(PROCEDURE 9)".

    //procedure SetPostingDate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TextManagement.MakeDateFilter(PostingDate);
    SETFILTER("Posting Date",PostingDate);
    PostingDateFilter := GETFILTER("Posting Date");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF ApplicationManagement.MakeDateFilter(PostingDate) = 0 THEN;
    SETFILTER("Posting Date",PostingDate);
    PostingDateFilter := GETFILTER("Posting Date");
    */
    //end;


    //Unsupported feature: Code Modification on "FindUnpostedSalesDocs(PROCEDURE 14)".

    //procedure FindUnpostedSalesDocs();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesHeader."SECURITYFILTERING"(SECURITYFILTER::Filtered);
    IF SalesHeader.READPERMISSION THEN BEGIN
      SalesHeader.RESET;
      SalesHeader.SETCURRENTKEY("Sell-to Customer No.","External Document No.");
      SalesHeader.SETFILTER("Sell-to Customer No.",ContactNo);
      SalesHeader.SETFILTER("External Document No.",ExtDocNo);
      SalesHeader.SETRANGE("Document Type",DocType);
      InsertIntoDocEntry(Rec,DATABASE::"Sales Header",DocType,DocTableName,SalesHeader.COUNT);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
      InsertIntoDocEntry(DATABASE::"Sales Header",DocType,DocTableName,SalesHeader.COUNT);
    END;
    */
    //end;


    //Unsupported feature: Code Modification on "FindUnpostedServDocs(PROCEDURE 16)".

    //procedure FindUnpostedServDocs();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ServHeader."SECURITYFILTERING"(SECURITYFILTER::Filtered);
    IF ServHeader.READPERMISSION THEN
      IF ExtDocNo = '' THEN BEGIN
        ServHeader.RESET;
        ServHeader.SETCURRENTKEY("Customer No.");
        ServHeader.SETFILTER("Customer No.",ContactNo);
        ServHeader.SETRANGE("Document Type",DocType);
        InsertIntoDocEntry(Rec,DATABASE::"Service Header",DocType,DocTableName,ServHeader.COUNT);
      END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ServHeader."SECURITYFILTERING"(SECURITYFILTER::Filtered);
    IF ServHeader.READPERMISSION THEN BEGIN
    #3..7
        InsertIntoDocEntry(DATABASE::"Service Header",DocType,DocTableName,ServHeader.COUNT);
      END;
    END;
    */
    //end;


    //Unsupported feature: Code Modification on "FindTrackingRecords(PROCEDURE 22)".

    //procedure FindTrackingRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Window.OPEN(Text002);
    DELETEALL;
    "Entry No." := 0;

    CLEAR(ItemTrackingNavigateMgt);
    ItemTrackingNavigateMgt.FindTrackingRecords(SerialNoFilter,LotNoFilter,'','');

    ItemTrackingNavigateMgt.Collect(TempRecordBuffer);
    TempRecordBuffer.SETCURRENTKEY("Table No.","Record Identifier");
    IF TempRecordBuffer.FIND('-') THEN
      REPEAT
        TempRecordBuffer.SETRANGE("Table No.",TempRecordBuffer."Table No.");

        DocNoOfRecords := 0;
        IF TempRecordBuffer.FIND('-') THEN
          REPEAT
            TempRecordBuffer.SETRANGE("Record Identifier",TempRecordBuffer."Record Identifier");
            TempRecordBuffer.FIND('+');
            TempRecordBuffer.SETRANGE("Record Identifier");
            DocNoOfRecords += 1;
          UNTIL TempRecordBuffer.NEXT = 0;

        InsertIntoDocEntry(Rec,TempRecordBuffer."Table No.",0,TempRecordBuffer."Table Name",DocNoOfRecords);

        TempRecordBuffer.SETRANGE("Table No.");
      UNTIL TempRecordBuffer.NEXT = 0;

    OnAfterNavigateFindTrackingRecords(Rec,SerialNoFilter,LotNoFilter);

    DocExists := FIND('-');

    UpdateFormAfterFindRecords;
    Window.CLOSE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    TempRecordBuffer.SETCURRENTKEY("Table No.","Search Record ID");
    #10..16
            TempRecordBuffer.SETRANGE("Search Record ID",TempRecordBuffer."Search Record ID");
            TempRecordBuffer.FIND('+');
            TempRecordBuffer.SETRANGE("Search Record ID");
    #20..22
        InsertIntoDocEntry(
          TempRecordBuffer."Table No.",0,TempRecordBuffer."Table Name",DocNoOfRecords);
    #24..27
    #30..33
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetTracking(PROCEDURE 20)".


    //Unsupported feature: Property Deletion (Attributes) on "FindRecordsOnOpen(PROCEDURE 21)".


    //Unsupported feature: Property Deletion (Attributes) on "UpdateNavigateForm(PROCEDURE 23)".


    //Unsupported feature: Property Deletion (Attributes) on "ReturnDocumentEntry(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Data type) on "FindExtRecords(PROCEDURE 8).DateFilter2(Variable 1002)".


    //Unsupported feature: Property Insertion (Length) on "FindExtRecords(PROCEDURE 8).DateFilter2(Variable 1002)".


    //Unsupported feature: Property Modification (Data type) on "FindExtRecords(PROCEDURE 8).DocNoFilter2(Variable 1003)".


    //Unsupported feature: Property Insertion (Length) on "FindExtRecords(PROCEDURE 8).DocNoFilter2(Variable 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "FindRecords(PROCEDURE 2).DocType2(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "FindRecords(PROCEDURE 2).DocNo2(Variable 1004)".


    //Unsupported feature: Deletion (VariableCollection) on "FindRecords(PROCEDURE 2).SourceType2(Variable 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "FindRecords(PROCEDURE 2).SourceNo2(Variable 1005)".


    //Unsupported feature: Deletion (VariableCollection) on "FindRecords(PROCEDURE 2).PostingDate(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "FindRecords(PROCEDURE 2).IsSourceUpdated(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "FindRecords(PROCEDURE 2).HideDialog(Variable 1006)".


    //Unsupported feature: Deletion (ParameterCollection) on "InsertIntoDocEntry(PROCEDURE 3).TempDocumentEntry(Parameter 1004)".


    //Unsupported feature: Property Modification (Length) on "SetSource(PROCEDURE 5).DocType2(Parameter 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "ShowRecords(PROCEDURE 6).IsHandled(Variable 1000)".


    //Unsupported feature: Property Insertion (Length) on "SetPostingDate(PROCEDURE 9).PostingDate(Parameter 1000)".


    //Unsupported feature: Property Insertion (Length) on "SetDocNo(PROCEDURE 10).DocNo(Parameter 1000)".


    //Unsupported feature: Property Modification (Data type) on "MakeExtFilter(PROCEDURE 11).DateFilter(Parameter 1000)".


    //Unsupported feature: Property Insertion (Length) on "MakeExtFilter(PROCEDURE 11).DateFilter(Parameter 1000)".


    //Unsupported feature: Property Modification (Data type) on "MakeExtFilter(PROCEDURE 11).DocNoFilter(Parameter 1002)".


    //Unsupported feature: Property Insertion (Length) on "MakeExtFilter(PROCEDURE 11).DocNoFilter(Parameter 1002)".


    //Unsupported feature: Property Modification (Length) on "SetTracking(PROCEDURE 20).SerialNo(Parameter 1000)".


    //Unsupported feature: Property Modification (Length) on "SetTracking(PROCEDURE 20).LotNo(Parameter 1001)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
