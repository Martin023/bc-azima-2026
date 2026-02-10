#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187138 pageextension52187138 extends "Purchase Invoice"
{
    PromotedActionCategories = 'New,Process,Reports,Check Budgetary Availability,EDMS,,Refresh/Reset Posting Date,Workflows';
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Vendor No.")
        {
            ApplicationArea = Basic;
        }
        modify("Order Address Code")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Vendor Name")
        {
            ApplicationArea = Basic;
        }
        // modify("Vendor Authorization No.")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Buy-from Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Contact")
        {
            ApplicationArea = Basic;
        }
        // modify("Pay-to Vendor No.")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Pay-to Name")
        {
            ApplicationArea = Basic;
        }
        modify("Pay-to Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Pay-to Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Pay-to Contact")
        {
            ApplicationArea = Basic;
        }
        // modify("Ship-to Code")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Ship-to Name")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Contact")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Location Code"(Control 115)".

        }
        modify("Purchaser Code")
        {
            ApplicationArea = Basic;
        }
        modify("Assigned User ID")
        {
            ApplicationArea = Basic;
        }
        // modify("Currency Code")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        moveafter(Status; "Currency Code")

        modify("Payment Terms Code")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Discount %")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Method Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Method Code")
        {
            ApplicationArea = Basic;
        }
        // modify("Requested Receipt Date")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Job Queue Status")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Description")
        {
            Visible = true;
        }


        modify("Vendor Invoice No.")
        {
            Visible = true;
        }
        // addafter("Vendor Invoice No.")
        // {
        //     field("Posting Description."; Rec."Posting Description")
        //     {

        //     }
        // }


        //trigger OnLookup(var Text: Text): Boolean
        //begin
        /*
        DimMgt.LookupDimValueCodeNoUpdate(1);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 113)".



        //Unsupported feature: Code Insertion on ""Shortcut Dimension 2 Code"(Control 111)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
        /*
        DimMgt.LookupDimValueCodeNoUpdate(2);
        */
        //end;


        // modify(Amount)
        // {
        //     Visible = false;
        // }
        // modify("Power BI Report FactBox")
        // {
        //     Visible = false;
        // }


    }
    actions
    {
        addafter("&Invoice")
        {
            action("Check Budgetary Availability")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Check Budgetary Availability';
                Image = Balance;
                PromotedCategory = Category4;
                promoted = true;
                trigger OnAction()
                var
                    BCSetup: Record "Budgetary Control Setup";
                begin
                    if not (Rec.Status = Rec.Status::Open) then
                        error('Document must be Open');
                    BCSetup.Get;
                    if not BCSetup.Mandatory then
                        if not Confirm('Budget check is not mandatory. Do you want to continue?', false) then
                            exit;
                    // if not AllFieldsEntered then
                    //     Error('Some of the Key Fields on the Lines: ACCOUNT NO or AMOUNT Have not been Entered please RECHECK your entries');

                    //First Check whether other lines are already committed.
                    Commitments.Reset;
                    Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::PurchInvoice);
                    Commitments.SetRange(Commitments."Document No.", Rec."No.");
                    if Commitments.Find('-') then begin
                        if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then begin exit end;
                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::PurchInvoice);
                        Commitments.SetRange(Commitments."Document No.", Rec."No.");
                        Commitments.DeleteAll;
                    end;
                    CheckBudgetAvail.CheckPurchase(Rec);
                end;
            }
            action(CancelBudgetCommitment)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Budget Commitment';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if not (Rec.Status = Rec.Status::Open) then begin
                        Error('Document must be Pending/Open');
                    end;
                    if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then begin exit end;

                    Commitments.Reset;
                    Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::PurchInvoice);
                    Commitments.SetRange(Commitments."Document No.", Rec."No.");
                    Commitments.DeleteAll;

                    PayLine.Reset;
                    PayLine.SetRange(PayLine."No.", Rec."No.");
                    if PayLine.Find('-') then begin
                        repeat
                            PayLine.Committed := false;
                            PayLine.Modify;
                        until PayLine.Next = 0;
                    end;
                end;
            }

            group("EDMS Integration")
            {
                action("Import")
                {
                    ApplicationArea = All;
                    Caption = 'Import File';
                    Promoted = true;
                    PromotedCategory = Category5;
                    Image = Import;

                    trigger OnAction()
                    var
                        Base64Convert: Codeunit "Base64 Convert";
                        TempBlob: Codeunit "Temp Blob";
                        InStr: InStream;

                        EDMSFunctions: Codeunit "EDMS Functions";
                        FileName: Text;
                        FileContentsB64: Text;

                        IDNumber: Text;
                        ApplicationType: Label 'MA'; // Member Application
                        PFNumber: Text;
                    begin
                        if Rec."No." <> '' then begin
                            FileName := EDMSFunctions.PickEDMSFile(TempBlob);

                            TempBlob.CreateInStream(InStr);
                            FileContentsB64 := Base64Convert.ToBase64(InStr);

                            if FileContentsB64 <> '' then begin
                                // UploadToEDMS(Rec, FileName, FileContentsB64);
                            end;
                        end else begin
                            Error('Application No. is required for EDMS document upload');
                        end;
                    end;
                }
                action("EDMS File List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Category5;

                    RunObject = page "EDMS Files List";
                    RunPageLink = "Application No." = field("No.");
                    // RunPageMode = Create;
                }
                action(ApprovalComments)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approval Comments';
                    Image = Comment;
                    PromotedCategory = Category8;
                    Promoted = true;
                    //Enabled = Rec.Status <> Rec.Status::Released;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
                action("Refresh")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Category7;
                    trigger OnAction()
                    begin
                        rec.Validate(Status);
                        CurrPage.Update();
                        Message('Page Refreshed');
                    end;
                }
                action("Reset Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Restore;
                    Promoted = true;
                    PromotedCategory = Category7;
                    trigger OnAction()
                    var
                        PostedInvoice: Record "Purch. Inv. Header";
                    begin
                        PostedInvoice.Reset();
                        PostedInvoice.SetRange("Pre-Assigned No.", Rec."No.");
                        if Not PostedInvoice.FindFirst() then begin
                            rec."Posting Date" := today;
                            rec.Modify;
                            Message('Posting Date has been reset succcessfuly');
                        end
                        else
                            Error('This document has been posted and cannot be reset');
                    end;
                }

            }
        }

        modify(Statistics)
        {
            ApplicationArea = Basic;

        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Approvals)
        {
            ApplicationArea = Basic;
        }
        // modify(Release)
        // {
        //     ApplicationArea = Basic;
        // }
        modify(Reopen)
        {
            ApplicationArea = Basic;
        }
        modify(SendApprovalRequest)
        {
            ApplicationArea = Basic;
            trigger OnBeforeAction()
            var
                myInt: Integer;
                BudgetaryControlCU: codeunit "Budgetary Control";
            begin
                if LinesCommitmentStatus then begin
                    //Check if Gl budgeting is mandatory
                    // if BudgetaryControlCU.CheckIfAccountIsBudgeted(Rec) then
                    Error('There are some lines that have not been committed');
                end;

            end;
            //Enabled = not OpenApprovalEntriesExist;
        }
        modify(CancelApprovalRequest)
        {
            ApplicationArea = Basic;
            //Enabled = OpenApprovalEntriesExist;

            //Unsupported feature: Property Modification (Image) on "CancelApprovalRequest(Action 12)".

        }
        addafter(CancelApprovalRequest)
        {
        }
        // modify(Post)
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (PromotedCategory) on "Post(Action 52)".

        // }
        modify(Preview)
        {
            ApplicationArea = Basic;
        }
        modify(TestReport)
        {
            ApplicationArea = Basic;
        }
        modify(PostAndPrint)
        {
            ApplicationArea = Basic;


        }
        modify(PostBatch)
        {
            ApplicationArea = Basic;

        }
        modify(RemoveFromJobQueue)
        {
            ApplicationArea = Basic;
        }
        modify(Vendor)
        {
            Visible = false;
        }
    }

    var
        //ApprovalEntries: Page "Approval Entries";
        approvalsMgmt: Codeunit "Approvals Mgmt.";


    var
        DimMgt: Codeunit DimensionManagement;
        Commitments: Record Committment;
        CheckBudgetAvail: Codeunit "Budgetary Control";
        PayLine: Record "Purchase Line";
        ReadyToPostQst: Boolean;

    procedure AllFieldsEntered(): Boolean
    begin
        PayLine.RESET;
        PayLine.SETRANGE("Document No.", Rec."No.");
        if PayLine.FINDSET then begin
            repeat
                if PayLine."No." = '' then
                    exit(false);
                if PayLine.Amount = 0 then
                    exit(false);
            until PayLine.NEXT = 0;
        end;
    end;

    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCsetup: Record "Budgetary Control Setup";
    begin
        Exists := false;
        if BCsetup.Get() then begin
            if not BCsetup.Mandatory then begin
                Exists := false;
                exit;
            end;

            Exists := false;
            PayLine.Reset;
            PayLine.SetRange(PayLine."Document No.", Rec."No.");
            PayLine.SetRange(PayLine.Committed, false);
            if PayLine.Find('-') then begin
                repeat
                    if CheckBudgetAvail.CheckIfAccountIsBudgeted(Payline) then begin
                        Exists := true;
                        exit;
                    end;
                until PayLine.Next = 0;
            end;
        end;
    end;

}
