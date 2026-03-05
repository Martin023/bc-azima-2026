page 52186180 "Customer Card-Tenant"
{
    Caption = 'Customer Card';
    DeleteAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Customer;
    //SourceTableView = WHERE("Account Type" = CONST(Tenant));
    PromotedActionCategories = 'New,Process,Reports,Approvals,Case Forwarding, Attachments';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Tenant No.';
                    Editable = false;

                    // trigger OnAssistEdit()
                    // begin
                    //     if Rec.AssistEdit(xRec) then
                    //         CurrPage.Update;
                    // end;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Tenant Name';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    Caption = 'Account Type';
                    ToolTip = 'Account Type';
                    trigger OnValidate()
                    begin
                        if Rec."Account Type" = Rec."Account Type"::Tenant then
                            VisibleTenant := True
                        else
                            VisibleTenant := False;
                    end;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Address 2"; Rec."Physical Address")
                {
                    Caption = 'Physical Address';
                    ApplicationArea = Basic, Suite;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post Code';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Introduced By"; rec."Introduced By")
                {
                    ApplicationArea = Basic, Suite;
                    OptionCaption = 'Board,Staff,Self,Member,Current Tenant,Former Tenant,Media';
                    ShowMandatory = true;
                }
                field("Tenant Referees Name"; Rec."Tenant Referees")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Tenant Referees Phone"; Rec."Tenant Referees Phone")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Type of Business"; Rec."Type of Business")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("KRA PIN"; Rec."KRA PIN")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("at Person"; Rec."Contact Person")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Primary Contact No."; Rec."Primary Contact Number")
                {
                    Caption = 'Contact Person No.';
                    ApplicationArea = Basic, Suite;
                }
                // field(Contact; Rec.Contact)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = ContactEditable;

                //     trigger OnValidate()
                //     begin
                //         ContactOnAfterValidate;
                //     end;
                // }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnDrillDown()
                    var
                        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                        CustLedgEntry: Record "Cust. Ledger Entry";
                    begin
                        DtldCustLedgEntry.SetRange("Customer No.", Rec."No.");
                        Rec.CopyFilter("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                        Rec.CopyFilter("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                        Rec.CopyFilter("Currency Filter", DtldCustLedgEntry."Currency Code");
                        CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
                    end;
                }
                field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = False;
                }
                // field("Document Limit"; Rec."Document Limit")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
            }
            // group("Tenancy Details")
            // {
            //     //Visible = VisibleTenant;
            //     Caption = 'Tenancy Details';
            //     field("Company Profile"; Rec."Company Profile")
            //     {
            //         MultiLine = true;
            //         ApplicationArea = Basic, Suite;
            //         ToolTip = 'A brief Description of the company';
            //     }
            //     field("Entrance Date"; Rec."Entrance Date")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("Start Date"; Rec."Start Date")
            //     {
            //         Caption = 'Lease Start Date';
            //         ApplicationArea = Basic, Suite;
            // //     }
            //     field("End Date"; Rec."End Date")
            //     {
            //         Caption = 'Lease End Date';
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("Lease Period"; Rec."Lease Period")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("Rent Rate"; Rec."Rent Rate")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("Escalation For Leases"; Rec."Escalation For Leases")
            //     {
            //     Caption = 'Escalation Percentage';
            //     ApplicationArea = Basic, Suite;
            // }
            // field("Escalation Frequency"; Rec."Escalation Frequency")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            // field("Lease Grace Period"; Rec."Lease Grace Period")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            // field("Tenant Referees Name"; Rec."Tenant Referees")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            // field("Tenant Referees Phone"; Rec."Tenant Referees Phone")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            //     field("Size in Sq. Ft."; Rec."Size in Sq. Ft.")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            // }

            group("Case Forwarding")
            {
                field("Send/Forward to"; Rec."Send/Forward to")
                {

                }
                field("Originating Department"; Rec."Originating Department")
                {
                    Editable = false;
                }
                field("Current Departmrnt"; Rec."Current Departmrnt")
                {
                    Editable = false;
                }

            }
            part(Control1102755002; "Lease-List")
            {
                //Visible = VisibleTenant;
                SubPageLink = "Tenant No." = FIELD("No.");
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                    NotBlank = false;
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ICPartnerCodeOnAfterValidate;
                    end;
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Tenant Posting Group';
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::Customer), "No." = field("No.");
            }
        }
    }
    actions
    {
        area(navigation)
        {
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                Promoted = true;
                PromotedCategory = Category5;
                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
            group("&Tenant")
            {
                Caption = '&Tenant';
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ledger E&ntries';
                    RunObject = Page "Customer Ledger Entries";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                group("Sales &History")
                {
                    Caption = 'Sales &History';
                    action("Used as &Sell-to Customer")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Used as &Sell-to Customer';

                        trigger OnAction()
                        begin
                            //SalesInfoPaneMgt.LookupCustHistory("No.",FALSE);
                        end;
                    }
                    action("Used as &Bill-to Customer")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Used as &Bill-to Customer';

                        trigger OnAction()
                        begin
                            //SalesInfoPaneMgt.LookupCustHistory("No.",TRUE);
                        end;
                    }
                }
                group("Issued Documents")
                {
                    Caption = 'Issued Documents';
                    action("Issued &Reminders")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Issued &Reminders';
                        RunObject = Page "Issued Reminder";
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Posting Date");
                    }
                    action("Issued &Finance Charge Memos")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Issued &Finance Charge Memos';
                        RunObject = Page "Issued Finance Charge Memo";
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Posting Date");
                    }
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Customer),
                                  "No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(18),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action("Bank Accounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts';
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No." = FIELD("No.");
                }
                action("Ship-&to Addresses")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ship-&to Addresses';
                    RunObject = Page "Ship-to Address";
                    RunPageLink = "Customer No." = FIELD("No.");
                }
                action("C&ontact")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'C&ontact';

                    trigger OnAction()
                    begin
                        Rec.ShowContact;
                    end;
                }
                separator(Action100)
                {
                }
                action(Statistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                }
                action("Information Base")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Flagging Information Base';
                    Image = CancelAttachment;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loanee Information Base";
                    RunPageLink = "Member No." = FIELD("No.");
                }
                action(Contracts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Contracts';
                    Image = FileContract;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Contracts List";
                    RunPageLink = "Contractor No" = FIELD("No.");
                }
                action("Report Statement")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';

                    trigger OnAction()
                    var
                        Customer: Record Customer;
                    begin
                        Customer.Reset;
                        Customer.SetRange(Customer."No.", Rec."No.");
                        if Customer.Find('-') then
                            REPORT.RUN(Report::"Tenant Statement", TRUE, FALSE, Customer)
                    end;
                }
                action("Send Email")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send Email';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var

                    begin
                        Rec.TestField(Rec."E-Mail");
                        SendEmailWithAttachment(rec."E-Mail");
                        Message('Email sent Successfully!');
                    end;
                }
                action("Statistics by C&urrencies")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics by C&urrencies';
                }
                action("Entry Statistics")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Entry Statistics';
                    RunObject = Page "Customer Entry Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                }
                action("S&ales")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'S&ales';
                    RunObject = Page "Customer Sales";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                }
                separator(Action115)
                {
                }
                // action("Cross Re&ferences")
                // {
                //     Caption = 'Cross Re&ferences';
                //     RunObject = Page "Cross References";
                //     RunPageLink = "Cross-Reference Type" = CONST(Customer),
                //                   "Cross-Reference Type No." = FIELD("No.");
                //     RunPageView = SORTING("Cross-Reference Type", "Cross-Reference Type No.");
                // }
                separator(Action125)
                {
                }
                action("Ser&vice Contracts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ser&vice Contracts';
                    Image = ServiceAgreement;
                    RunObject = Page "Customer Service Contracts";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Ship-to Code");
                }
                action("Service &Items")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Service &Items';
                    RunObject = Page "Service Items";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Ship-to Code", "Item No.", "Serial No.");
                }
                separator(Action138)
                {
                }
                action("&Jobs")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Jobs';
                    RunObject = Page "Job Card";
                    RunPageLink = "Bill-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Bill-to Customer No.");
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Apply Template")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Apply Template';
                    Ellipsis = true;
                    Image = ApplyTemplate;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        TemplateMgt: Codeunit "Config. Template Management";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        TemplateMgt.UpdateFromTemplateSelection(RecRef);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        if Rec."Account Type" = Rec."Account Type"::Tenant then begin
                            Rec.Testfield("No.");
                            Rec.TestField(Name);
                            Rec.TestField("Physical Address");
                            Rec.TestField("Account Type");
                            // Rec.TestField("Entrance Date");
                            // Rec.TestField("Start Date");
                            // Rec.TestField("End Date");
                            // Rec.TestField("Rent Rate");
                            // //Rec.TestField("Lease Grace Period");
                            // Rec.TestField("Tenant Referees");
                            // Rec.TestField("Tenant Referees Phone");
                            // Rec.TestField("Size in Sq. Ft.");
                            //Rec.TestField("Company Profile");
                            //Rec.TestField("Physical Address");

                        end;
                        if ApprovalsMgmt.CheckCustomerApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendCustomerForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.OnCancelCustomerApprovalRequest(Rec);
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
                        if Rec."Send/Forward to" = Rec."Current Departmrnt" then Error('You cannot send this document to %1 while its already in %1', Rec."Send/Forward to");
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
                        Rec."Current Departmrnt" := Rec."Send/Forward to";

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

    trigger OnAfterGetRecord()
    begin
        ActivateFields;

        OnAfGetCurrRecord;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        RecordFound: Boolean;
    begin
        RecordFound := Rec.Find(Which);
        CurrPage.Editable := RecordFound or (Rec.GetFilter("No.") = '');
        exit(RecordFound);
    end;

    trigger OnInit()
    begin
        ContactEditable := true;
        MapPointVisible := true;
    end;

    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     Rec."Account Type" := Rec."Account Type"::Tenant;
    //     OnAfGetCurrRecord;
    // end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit "Online Map Management";
    begin
        // if rec.Status = rec.Status::Approved then
        //     CurrPage.Editable := false;
        ActivateFields;
        if not MapMgt.TestSetup then
            MapPointVisible := false;

        CheckMemberInfomation();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Account Type" := rec."Account Type"::Tenant;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        NoSeriesMgt: Codeunit "No. Series";
    begin
        if rec."No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Tenant Nos");
            // NoSeriesMgt.InitSeries(NoSetup."Tenant Nos", xRec."No. Series", 0D, rec."No.", NoSetup."Tenant Nos");

            rec."No." := NoSeriesMgt.GetNextNo(NoSetup."Tenant Nos");


        end;
    end;

    var
        NoSetup: Record "Sales & Receivables Setup";
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
        CustomizedCalEntry: Record "Customized Calendar Entry";
        Text001: Label 'Do you want to allow payment tolerance for entries that are currently open?';
        CustomizedCalendar: Record "Customized Calendar Change";
        Text002: Label 'Do you want to remove payment tolerance from entries that are currently open?';
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        MapPointVisible: Boolean;
        ContactEditable: Boolean;
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        DetailsEditable: Boolean;
        VisibleTenant: Boolean;
        StatementFileNameTxt: Label 'Statement', Comment = 'Shortened form of ''Customer Statement''';

    //[Scope('OnPrem')]
    procedure ActivateFields()
    begin
        ContactEditable := Rec."Primary Contact No." = '';
    end;

    local procedure ContactOnAfterValidate()
    begin
        ActivateFields;
    end;

    local procedure ICPartnerCodeOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure OnAfGetCurrRecord()
    begin
        xRec := Rec;
        ActivateFields;
    end;


    procedure CheckMemberInfomation()
    var
        LoaneeInfomationBase: Record "Loanee Infomation Base";
    begin
        LoaneeInfomationBase.Reset();
        LoaneeInfomationBase.SetRange("Member No.", Rec."No.");
        LoaneeInfomationBase.SetFilter(Info, '<>%1', '');
        if LoaneeInfomationBase.Find('-') then begin
            repeat
                if (LoaneeInfomationBase."Expiry Date" = 0D) or (LoaneeInfomationBase."Expiry Date" > Today) then
                    Message(LoaneeInfomationBase.Info);
            until LoaneeInfomationBase.Next = 0;
        end;

    end;

    procedure SendEmailWithAttachment(var emailadress: Text[50])
    var
        ReportExample: Report "Tenant Statement";
        Email: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        InStr: Instream;
        OutStr: OutStream;
        ReportParameters: Text;
        TxtRecipientsList: List of [Text];
    begin

        ReportParameters := ReportExample.RunRequestPage();
        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(Report::"Tenant Statement", ReportParameters, ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(InStr);

        TxtRecipientsList.Add(emailadress);
        EmailMsg.Create(emailadress, 'Subject-Statement', 'Body-Sending Tenant Statement');
        EmailMsg.AddAttachment('FileName.pdf', 'PDF', InStr);
        Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    end;
}



