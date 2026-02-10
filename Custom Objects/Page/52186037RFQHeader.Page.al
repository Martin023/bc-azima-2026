page 52186037 "RFQ Header"
{
    DeleteAllowed = false;
    PageType = Document;
    SourceTable = "Purchase Quote Header";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,Workflow';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = FieldEditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Purchase Reason"; Rec."Posting Description")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Reason';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contract Ref No."; Rec."Contract Ref No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Expected Closing Date"; Rec."Expected Closing Date")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        //Not allow back date
                        //IF TODAY > "Posting Date" THEN ERROR('Posting Date Cannot be %1',"Posting Date");
                    end;
                }
                field("Expected Opening Date"; Rec."Expected Opening Date")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        //Not allow back date
                        //IF TODAY > "Posting Date" THEN ERROR('Posting Date Cannot be %1',"Posting Date");
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Control1102755012; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Tender Expiry Date"; Rec."Tender Expiry Date")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        //Not allow back date
                        //IF TODAY > "Posting Date" THEN ERROR('Posting Date Cannot be %1',"Posting Date");
                    end;
                }
                field(Reference; Rec.Reference)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Internal Requisition No."; Rec."Internal Requisition No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
            }
            part(Control1102755015; "RFQ Subform")
            {
                ApplicationArea = Basic, Suite;
                Editable = FieldEditable;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action1102755017)
            {
                action("Get Document Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Get Document Lines';
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);

                        CurrPage.Update(true);
                        InsertRFQLines;
                    end;
                }
                action("Assign Vendor(s)")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Assign Vendor(s)';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Vends: Record "Quotation Request Vendors";
                    begin

                        Vends.Reset;
                        Vends.SetRange(Vends."Document Type", Rec."Document Type");
                        Vends.SetRange(Vends."Requisition Document No.", Rec."No.");

                        PAGE.Run(PAGE::"Quotation Request Vendors", Vends);
                    end;
                }
                action("Print/Preview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    var
                        Vends: Record "Quotation Request Vendors";
                    begin
                        Vends.Reset;
                        Vends.SetRange(Vends."Document Type", Rec."Document Type");
                        Vends.SetRange(Vends."Requisition Document No.", Rec."No.");

                        PQH.SetRecFilter;
                        PQH.SetFilter(PQH."Document Type", '%1', Rec."Document Type");
                        PQH.SetFilter("No.", Rec."No.");
                        // repvend.SetTableView(Vends);//here
                        // repvend.Run;
                    end;
                }
                action("Create Quotes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Vendor Quotes';
                    Image = VendorPayment;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        RFQLines: Record "Purchase Quote Line";
                        PurchaseHeader: Record "Purchase Header";
                        PurchaseLines: Record "Purchase Line";
                        Vends: Record "Quotation Request Vendors";
                    begin
                        Vends.SetRange(Vends."Requisition Document No.", Rec."No.");
                        if Vends.FindSet then
                            repeat
                                //create header
                                PurchaseHeader.Init;
                                PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Quote;
                                PurchaseHeader.DocApprovalType := PurchaseHeader.DocApprovalType::Quote;
                                PurchaseHeader."No." := '';
                                PurchaseHeader."Responsibility Center" := Rec."Responsibility Center";
                                PurchaseHeader."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                                PurchaseHeader."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                PurchaseHeader.Insert(true);
                                PurchaseHeader.Validate("Buy-from Vendor No.", Vends."Vendor No.");
                                PurchaseHeader."Responsibility Center" := Rec."Responsibility Center";
                                PurchaseHeader."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                                PurchaseHeader."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                //  PurchaseHeader.validate("RFQ No.","No.");
                                PurchaseHeader.Modify;
                                PurchaseHeader.Insert(true);

                                //create lines

                                RFQLines.SetRange(RFQLines."Document No.", Rec."No.");
                                if RFQLines.FindSet then
                                    repeat
                                        PurchaseLines.Init;
                                        PurchaseLines.TransferFields(RFQLines);
                                        PurchaseLines."Document Type" := PurchaseLines."Document Type"::Quote;
                                        PurchaseLines."Document No." := Rec."No.";
                                        PurchaseLines.Insert;
                                    /*
                                      ReqLines.VALIDATE(ReqLines."No.");
                                      ReqLines.VALIDATE(ReqLines.Quantity);
                                      ReqLines.VALIDATE(ReqLines."Direct Unit Cost");
                                      ReqLines.MODIFY;
                                    */
                                    until RFQLines.Next = 0;
                            until Vends.Next = 0;

                    end;
                }
                action("Bid Analysis")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bid Analysis';
                    Image = Worksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bid Analysis Worksheet";
                    RunPageLink = "RFQ No." = FIELD("No.");
                    Visible = false;

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        PurchaseLines: Record "Purchase Line";
                        ItemNoFilter: Text[250];
                        RFQNoFilter: Text[250];
                        InsertCount: Integer;
                        BidAnalysis: Record "Bid Analysis";
                    begin
                        //deletebidanalysis for this vendor
                        BidAnalysis.SetRange(BidAnalysis."RFQ No.", Rec."No.");
                        BidAnalysis.DeleteAll;


                        //insert the quotes from vendors

                        PurchaseHeader.SetRange(PurchaseHeader."No.", Rec."No.");
                        PurchaseHeader.FindSet;
                        repeat
                            PurchaseLines.Reset;
                            PurchaseLines.SetRange("Document No.", PurchaseHeader."No.");
                            if PurchaseLines.FindSet then
                                repeat
                                    BidAnalysis.Init;
                                    BidAnalysis."RFQ No." := Rec."No.";
                                    BidAnalysis."RFQ Line No." := PurchaseLines."Line No.";
                                    BidAnalysis."Quote No." := PurchaseLines."Document No.";
                                    BidAnalysis."Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                                    BidAnalysis."Item No." := PurchaseLines."No.";
                                    BidAnalysis.Description := PurchaseLines.Description;
                                    BidAnalysis.Quantity := PurchaseLines.Quantity;
                                    BidAnalysis."Unit Of Measure" := PurchaseLines."Unit of Measure";
                                    BidAnalysis.Amount := PurchaseLines."Direct Unit Cost";
                                    BidAnalysis."Line Amount" := BidAnalysis.Quantity * BidAnalysis.Amount;
                                    BidAnalysis.Insert(true);
                                    InsertCount += 1;
                                until PurchaseLines.Next = 0;
                        until PurchaseHeader.Next = 0;
                        //MESSAGE('%1 records have been inserted to the bid analysis',InsertCount);
                    end;
                }
                action("Quotation Printout")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Quotation Printout';
                    Image = Worksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                begin
                    
                    rec.Reset;
                    rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(Report::"RFQ Printout", true, true, Rec);
                    //rec.Reset;
                end;

            }
            group(Status)
            {
                Caption = 'Status';
                action(Cancel)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin

                        //check if the quotation for request number has already been used
                        /*
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        if Confirm('Cancel Document?', false) = false then begin exit end;
                        Rec.Status := Rec.Status::Cancelled;
                        Rec.Modify;

                    end;
                }
                action(Stop)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stop';
                    Image = Stop;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin

                        //check if the quotation for request number has already been used
                        /*
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        if Confirm('Close Document?', false) = false then begin exit end;
                        Rec.Status := Rec.Status::Closed;
                        Rec.Modify;

                    end;
                }
                action(Close)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Close Document';
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin

                        //check if the quotation for request number has already been used
                        /*
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        if Confirm('Close Document?', false) = false then begin exit end;
                        Rec.Status := Rec.Status::Closed;
                        Rec.Modify;

                    end;
                }
                action(Release)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        if Confirm('Release document?', false) = false then begin exit end;
                        //check if the document has any lines
                        Lines.Reset;
                        Lines.SetRange(Lines."Document Type", Rec."Document Type");
                        Lines.SetRange(Lines."Document No.", Rec."No.");
                        if Lines.FindFirst then begin
                            repeat
                                Lines.TestField(Lines.Quantity);
                                //Lines.TESTFIELD(Lines."Direct Unit Cost");
                                Lines.TestField("No.");
                            until Lines.Next = 0;
                        end
                        else begin
                            Error('Document has no lines');
                        end;
                        Rec.Status := Rec.Status::Released;
                        Rec."Released By" := UserId;
                        Rec."Release Date" := Today;
                        Rec.Modify;
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*
                        //check if the quotation for request number has already been used
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        //PurchHeader.SETRANGE(purchheader."request for quote no","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        if Confirm('Reopen Document?', false) = false then begin exit end;
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;

                    end;
                }
                action("Evaluation Report ")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Document;
                    Promoted = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        DMS.Reset;
                        DMS.SetRange(DMS.Key, DMS.Key::"Evaluation Report");
                        if DMS.Find('-') then begin
                            HyperLink(DMS."url path" + Rec."No.");
                        end;
                    end;
                }
            }
        }
    }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnInit()
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;
     trigger OnNewRecord(BelowxRec: Boolean)
    begin
       
        Rec."Assigned User ID" := UserId;
        usersetup.reset();
        usersetup.SetRange("User ID",UserId);
        IF usersetup.FindFirst() then begin
            rec."Shortcut Dimension 1 Code":=usersetup."Global Dimension 1 Code";
            rec."Shortcut Dimension 2 Code":=usersetup."Global Dimension 2 Code";
            rec."Responsibility Center":=usersetup."Responsibility Centre";
        end;
    end;

    var
        PurchHeader: Record "Purchase Header";
        PParams: Record "Purchase Quote Params";
        Lines: Record "Purchase Quote Line";
        PQH: Record "Purchase Quote Header";
        //here//repvend: Report "RFQ Report";
        DMS: Record EDMS;
        FieldEditable: Boolean;
        PurchaseLine: Record "Purchase Line";
        usersetup:record "User Setup";

    //[Scope('OnPrem')]
    procedure InsertRFQLines()
    var
        Counter: Integer;
        Collection: Record "Purchase Line";
        CollectionList: Page "PRF Lists";
        PurchaseQuoteLine: Record "Purchase Quote Line";
    begin
        CollectionList.LookupMode(true);
        if CollectionList.RunModal = ACTION::LookupOK then begin
            CollectionList.SetSelection(Collection);
            //Counter := Collection.COUNT
            /*PurchaseQuoteLine.RESET;
            PurchaseQuoteLine.SETRANGE("Document No.","No.");
            IF PurchaseQuoteLine.FIND('-') THEN
              ERROR('You only seclect One Prn for one RFQ');*/
            if Collection.FindSet then
                PurchaseLine.Reset;
            PurchaseLine.SetRange("Document No.", Collection."Document No.");
            if PurchaseLine.Find('-') then begin
                //  Counter:=PurchaseQuoteLine.COUNT;
                repeat

                    PurchaseQuoteLine.Reset;
                    PurchaseQuoteLine.SetRange("Document No.", Rec."No.");
                    PurchaseQuoteLine.SetRange("Document Type", Rec."Document Type");
                    PurchaseQuoteLine.SetRange("No.", PurchaseLine."No.");
                    if PurchaseQuoteLine.Find('-') then
                        Error('Line already selected');
                    Lines.Init;
                    Lines.TransferFields(PurchaseLine);
                    Lines."Document Type" := Rec."Document Type";
                    Lines."Document No." := Rec."No.";
                    Lines."Line No." := 0;
                    Lines."PRF No" := Collection."Document No.";
                    Lines."PRF Line No." := Collection."Line No.";
                    Lines.Insert(true);
                //Collection.Copied:=TRUE;
                //Collection.MODIFY
                until PurchaseLine.Next = 0;
            end;
        end;

    end;

    local procedure UpdateControls()
    begin
        if (Rec.Status = Rec.Status::Released) then begin
            FieldEditable := false;
        end else begin
            FieldEditable := true;
        end;
    end;
}

