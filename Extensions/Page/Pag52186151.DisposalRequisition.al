namespace ALProject.ALProject;
using Microsoft.Inventory.Setup;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Document;
using System.Automation;

page 52186151 "Disposal Requisition"
{
    Caption = 'Disposal Requisition';
    PromotedActionCategories = ',,,,,Generate Items,,,Approvals';
    PageType = Card;
    SourceTable = "Stock keeping";
    SourceTableView = where(Types = filter(Disposal));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    Editable = InvTcode;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(TotalItems; Rec.TotalItems)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Items field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Id field.';
                    Editable = false;
                }
            }
            part(Control3; "Disposal Lines")
            {
                ApplicationArea = Basic;
                SubPageLink = "Header No" = FIELD("No");
                Editable = Inst;

            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }

                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    //  // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin




                        VarVariant := Rec;




                        // Rec.Status := Rec.Status::Approved;
                        // Rec.MODIFY;

                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        //MESSAGE('Job Approved and now can be occupied')
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        Rec.TestField(Status, Rec.Status::Pending);
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnCancelDocApprovalRequest(VarVariant);

                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = all;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        Rec.TestField(Status, Rec.Status::Pending);


                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
            }
            action("Create Sales Invoice")
            {
                ApplicationArea = all;
                Image = Item;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    SalesInvoice: record "Sales Header";
                    SalesLines: record "Sales Line";
                    Disposallines: record "Disposal Lines";
                    itemNo: code[40];
                    itemName: text[100];
                    Expiry: date;
                    disposalReason: text[100];
                    disposalMthd: text[100];
                begin
                    itemNo := '';
                    itemName := '';
                    Expiry := 0D;
                    disposalReason := '';
                    rec.TestField(Status, rec.status::Approved);
                    SalesInvoice.Reset;
                    SalesInvoice.SetRange(SalesInvoice."Your Reference", Rec.No);
                    if SalesInvoice.Find('-') = true then
                        Error('Sales Invoice has already been created for Disposal Requisition, the Sales Invoice no is %1', Format(SalesInvoice."No."));



                    Disposallines.reset();
                    Disposallines.setrange("Header No", rec.No);
                    If Disposallines.FindFirst() then begin
                        if (Disposallines."Disposal Method" = Disposallines."Disposal Method"::"Sale by Public Tender") OR (Disposallines."Disposal Method" = Disposallines."Disposal Method"::"Sale To Staff") THEN begin

                            SalesInvoice.init();
                            SalesInvoice."No." := '';
                            SalesInvoice."Document Type" := SalesInvoice."Document Type"::Invoice;
                            SalesInvoice."Your Reference" := Format(rec.No);
                            SalesInvoice."Document Date" := rec.Date;
                            SalesInvoice."Sell-to Customer No." := '00100';
                            SalesInvoice.validate("Sell-to Customer No.");
                            SalesInvoice.insert(true);
                            Message('Sales Invoice No' + '' + SalesInvoice."No." + '' + 'has been Created');

                        end else
                            error('Disposal Method is not Viable for Sales Invoice');


                    end;
                end;




            }
            action(GenerateItems)
            {
                ApplicationArea = all;
                Caption = 'Generate Item';
                Image = Item;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                trigger OnAction()
                var

                begin
                    rec.TestField(Status, rec.status::Open);
                    //     StockLines.SetRange(StockLines."Header No", Rec."No");

                    //     if StockLines.Find('-') then
                    //         StockLines.DeleteAll;
                    InventorySetup.get();
                    StockLines.reset;
                    StockLines.SetRange(StockLines."Header No", Rec."No");
                    If StockLines.findfirst then begin
                        Item.Reset;
                        IF Item.Find('-') THEN begin


                            //         StockLines.Reset;

                            repeat
                            noticedate:=0D;
                                if Item."Disposal Date" <> 0D then begin
                                    noticedate := CalcDate('-' + format(InventorySetup."Item Expiry Notification"), Item."Disposal Date");

                                    If noticedate = Today then begin
                                        //                     ItemDueExpiryFound := True;
                                        StockLines.Init;
                                        StockLines."Header No" := REC.No;
                                        StockLines."Item No" := Item."No.";
                                        //                     StockLines."Item Name" := Item.Description;
                                        //                     StockLines.Expiry := Item."Disposal Date";
                                        //                     StockLines."Item Location" := Item."Location Filter";
                                        //                     Item.CalcFields(Inventory);
                                        //                     StockLines.Inventory := Item.Inventory;
                                        StockLines.Insert(true);

                                    end

                                end;
                            until Item.Next = 0;
                        end;
                        //     if not ItemDueExpiryFound then
                        //         Message('No items due for expiry');

                    end;



                end;


            }
        }

    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rec.Types := rec.Types::Disposal;
    end;

    trigger OnAfterGetCurrRecord()
    begin

        UpdateControls;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControls;

    end;

    trigger OnOpenPage()
    begin

        UpdateControls;

    end;


    var
        HREmployees: Record "HR Employees";
        // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        HRCodeunit: Codeunit "HR Codeunit2";

        PageEditable: Boolean;
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        DocMustbePending: Label 'This application request must be Pending';
        DMS: Record EDMS;
        //usersetup: record "User Setup";
        Item: record Item;
        StockLines: record "Disposal Lines";
        StockKeeping: record "Stock Keeping";
        InventorySetup: record "Inventory Setup";
        noticedate: date;
        ItemDueExpiryFound: Boolean;


    local procedure UpdateControls()
    begin
        if rec.Status <> rec.Status::Open then
            CurrPage.EDITABLE := false;


        if Rec.Status = Rec.Status::Open then begin
            InvTcode := true;
            Inst := true;
            DepType := false;
            IntMode := false;
            CurrCode := true;
            RespCenter := true;
            Rmks := true;
            WtaxCode := true;
            INVdate := true;
            pType := true;
            Freq := true;
            Intrate := true;
            Mmarketpage := true;
            Dimension := true;
            MKS := true;
        end;


        if Rec.Status = Rec.Status::Pending then begin
            InvTcode := false;
            Inst := false;
            DepType := false;
            IntMode := false;
            CurrCode := false;
            RespCenter := false;
            Rmks := false;
            WtaxCode := false;
            INVdate := false;
            pType := false;
            Freq := false;
            Intrate := false;
            Mmarketpage := false;
            Dimension := False;
            MKS := False;
        end;


        if Rec.Status = Rec.Status::Approved then begin
            InvTcode := false;
            Inst := false;
            DepType := false;
            IntMode := false;
            CurrCode := false;
            RespCenter := false;
            Rmks := false;
            WtaxCode := false;
            INVdate := false;
            pType := false;
            Freq := false;
            Intrate := false;
            Mmarketpage := false;
            Dimension := False;
            MKS := False;
        end;


    end;

    var
        IntMode: Boolean;
        CurrCode: Boolean;
        RespCenter: Boolean;
        Rmks: Boolean;
        WtaxCode: Boolean;
        INVdate: Boolean;
        pType: Boolean;
        Freq: Boolean;
        Intrate: Boolean;
        Mmarketpage: Boolean;
        InvTcode: Boolean;
        Inst: Boolean;
        DepType: Boolean;
        Dimension: Boolean;
        MKS: Boolean;




}
