table 52185934 "Approval Entry Archive"
{
    Caption = 'Approval Entry';

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order, ';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ";
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Sequence No."; Integer)
        {
            Caption = 'Sequence No.';
        }
        field(5; "Approval Code"; Code[20])
        {
            Caption = 'Approval Code';
        }
        field(6; "Sender ID"; Code[50])
        {
            Caption = 'Sender ID';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            // trigger OnLookup()
            // begin
            //     UserMgt.LookupUserID("Sender ID");
            // end;
        }
        field(7; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
        }
        field(8; "Approver ID"; Code[60])
        {
            Caption = 'Approver ID';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            // trigger OnLookup()
            // begin
            //     UserMgt.LookupUserID("Approver ID");
            // end;
        }
        field(9; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Created,Open,Canceled,Rejected,Approved';
            OptionMembers = Created,Open,Canceled,Rejected,Approved;

            trigger OnValidate()
            begin
                if (xRec.Status = Status::Created) and (Status = Status::Open) then
                    "Date-Time Sent for Approval" := CreateDateTime(Today, Time);
            end;
        }
        field(10; "Date-Time Sent for Approval"; DateTime)
        {
            Caption = 'Date-Time Sent for Approval';
        }
        field(11; "Last Date-Time Modified"; DateTime)
        {
            Caption = 'Last Date-Time Modified';
        }
        field(12; "Last Modified By User ID"; Code[50])
        {
            Caption = 'Last Modified By User ID';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            // trigger OnLookup()
            // begin
            //     UserMgt.LookupUserID("Last Modified By User ID");
            // end;
        }
        field(13; Comment; Boolean)
        {
            CalcFormula = Exist("Approval Comment Line" WHERE("Table ID" = FIELD("Table ID"),
                                                               "Record ID to Approve" = FIELD("Record ID to Approve")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(15; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(16; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
        }
        field(17; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(18; "Approval Type"; Option)
        {
            Caption = 'Approval Type';
            OptionCaption = 'Workflow User Group,Sales Pers./Purchaser,Approver';
            OptionMembers = "Workflow User Group","Sales Pers./Purchaser",Approver;
        }
        field(19; "Limit Type"; Option)
        {
            Caption = 'Limit Type';
            OptionCaption = 'Approval Limits,Credit Limits,Request Limits,No Limits,Loan Interest Rate';
            OptionMembers = "Approval Limits","Credit Limits","Request Limits","No Limits","Loan Interest Rate";
        }
        field(20; "Available Credit Limit (LCY)"; Decimal)
        {
            Caption = 'Available Credit Limit (LCY)';
        }
        field(21; "Pending Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Record ID to Approve" = FIELD("Record ID to Approve"),
                                                        Status = FILTER(Created | Open),
                                                        "Workflow Step Instance ID" = FIELD("Workflow Step Instance ID")));
            Caption = 'Pending Approvals';
            FieldClass = FlowField;
        }
        field(22; "Record ID to Approve"; RecordID)
        {
            Caption = 'Record ID to Approve';
        }
        field(23; "Delegation Date Formula"; DateFormula)
        {
            Caption = 'Delegation Date Formula';
        }
        field(26; "Number of Approved Requests"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Record ID to Approve" = FIELD("Record ID to Approve"),
                                                        Status = FILTER(Approved),
                                                        "Workflow Step Instance ID" = FIELD("Workflow Step Instance ID")));
            Caption = 'Number of Approved Requests';
            FieldClass = FlowField;
        }
        field(27; "Number of Rejected Requests"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Record ID to Approve" = FIELD("Record ID to Approve"),
                                                        Status = FILTER(Rejected),
                                                        "Workflow Step Instance ID" = FIELD("Workflow Step Instance ID")));
            Caption = 'Number of Rejected Requests';
            FieldClass = FlowField;
        }
        field(29; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(30; "Workflow Step Instance ID"; Guid)
        {
            Caption = 'Workflow Step Instance ID';
        }
        field(31; "Related to Change"; Boolean)
        {
            CalcFormula = Exist("Workflow - Record Change" WHERE("Workflow Step Instance ID" = FIELD("Workflow Step Instance ID"),
                                                                  "Record ID" = FIELD("Record ID to Approve")));
            Caption = 'Related to Change';
            FieldClass = FlowField;
        }
        field(50000; "Primary Rec"; Code[100])
        {
            Editable = false;
        }
        field(50001; "Record Identity No."; Code[50])
        {
        }
        field(50002; "Member Rec"; Code[100])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Record ID to Approve", "Workflow Step Instance ID", "Sequence No.")
        {
        }
        key(Key3; "Table ID", "Document Type", "Document No.", "Sequence No.", "Record ID to Approve")
        {
        }
        key(Key4; "Approver ID", Status)
        {
        }
        key(Key5; "Sender ID")
        {
        }
        key(Key6; "Due Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        "Last Date-Time Modified" := CreateDateTime(Today, Time);
        "Last Modified By User ID" := UserId;
    end;

    var
        UserMgt: Codeunit "User Management";
        PageManagement: Codeunit "Page Management";
        RecNotExistTxt: Label 'The record does not exist.';
        ChangeRecordDetailsTxt: Label '; %1 changed from %2 to %3', Comment = 'Prefix = Record information %1 = field caption %2 = old value %3 = new value. Example: Customer 123455; Credit Limit changed from 100.00 to 200.00';

    // [Scope('OnPrem')]
    procedure ShowRecord()
    var
        RecRef: RecordRef;
    begin
        if not RecRef.Get("Record ID to Approve") then
            exit;
        RecRef.SetRecFilter;
        PageManagement.PageRun(RecRef);
    end;

    // [Scope('OnPrem')]
    // procedure RecordCaption(): Text
    // var
    //     "Object": Record "Object";
    //     RecRef: RecordRef;
    //     PageNo: Integer;
    // begin
    //     if not RecRef.Get("Record ID to Approve") then
    //         exit;
    //     PageNo := PageManagement.GetPageID(RecRef);
    //     if PageNo = 0 then
    //         exit;
    //     Object.Get(Object.Type::Page, '', PageNo);

    //     Object.CalcFields(Caption);
    //     exit(StrSubstNo('%1 %2', Object.Caption, "Document No."));
    // end;

    // [Scope('OnPrem')]
    procedure RecordDetails(): Text
    var
        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
        RecRef: RecordRef;
        ChangeRecordDetails: Text;
        LoanApplic: Record Loans;
        memberrec: Record Members;
    begin
        if not RecRef.Get("Record ID to Approve") then
            exit(RecNotExistTxt);

        // ChangeRecordDetails := GetChangeRecordDetails;
        "Primary Rec" := Format("Record ID to Approve", 0, 1);
        "Member Rec" := Format("Record ID to Approve", 0, 2);
        case RecRef.Number of
            DATABASE::"Sales Header":
                begin
                    RecRef.SetTable(SalesHeader);
                    SalesHeader.CalcFields(Amount);
                    exit(StrSubstNo('%1 ; %2: %3', SalesHeader."Sell-to Customer Name",
                        SalesHeader.FieldCaption(Amount), SalesHeader.Amount));
                end;
            DATABASE::"Purchase Header":
                begin
                    RecRef.SetTable(PurchHeader);
                    PurchHeader.CalcFields(Amount);
                    exit(StrSubstNo('%1 ; %2: %3', PurchHeader."Buy-from Vendor Name",
                        PurchHeader.FieldCaption(Amount), PurchHeader.Amount));
                end;
            else
                exit(Format("Record ID to Approve", 0, 1) + ChangeRecordDetails);
        end;
    end;

    // [Scope('OnPrem')]
    procedure IsOverdue(): Boolean
    begin
        exit((Status in [Status::Created, Status::Open]) and ("Due Date" < Today));
    end;

    // [Scope('OnPrem')]
    procedure GetCustVendorDetails(var CustVendorNo: Code[20]; var CustVendorName: Text[50])
    var
        PurchaseHeader: Record "Purchase Header";
        SalesHeader: Record "Sales Header";
        Customer: Record Customer;
        RecRef: RecordRef;
    begin
        if not RecRef.Get("Record ID to Approve") then
            exit;

        case "Table ID" of
            DATABASE::"Purchase Header":
                begin
                    RecRef.SetTable(PurchaseHeader);
                    CustVendorNo := PurchaseHeader."Pay-to Vendor No.";
                    CustVendorName := PurchaseHeader."Pay-to Name";
                end;
            DATABASE::"Sales Header":
                begin
                    RecRef.SetTable(SalesHeader);
                    CustVendorNo := SalesHeader."Bill-to Customer No.";
                    CustVendorName := SalesHeader."Bill-to Name";
                end;
            DATABASE::Customer:
                begin
                    RecRef.SetTable(Customer);
                    CustVendorNo := Customer."No.";
                    CustVendorName := Customer.Name;
                end;
        end;
    end;

    // [Scope('OnPrem')]
    procedure GetChangeRecordDetails() ChangeDetails: Text
    var
        WorkflowRecordChange: Record "Workflow - Record Change";
        OldValue: Text;
        NewValue: Text;
    begin
        WorkflowRecordChange.SetRange("Record ID", "Record ID to Approve");
        WorkflowRecordChange.SetRange("Workflow Step Instance ID", "Workflow Step Instance ID");

        if WorkflowRecordChange.FindSet then
            repeat
                WorkflowRecordChange.CalcFields("Field Caption");
                NewValue := WorkflowRecordChange.GetFormattedNewValue(true);
                OldValue := WorkflowRecordChange.GetFormattedOldValue(true);
                ChangeDetails += StrSubstNo(ChangeRecordDetailsTxt, WorkflowRecordChange."Field Caption",
                    OldValue, NewValue);
            until WorkflowRecordChange.Next = 0;
    end;
}

