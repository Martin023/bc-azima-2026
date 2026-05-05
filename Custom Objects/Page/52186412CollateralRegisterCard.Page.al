page 52186412 "Collateral Register Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Securities Register";
    PromotedActionCategories = 'New,Process,Reports,Comments,Approval request, SMS, Valuers,Archive';
    // Editable=IsEditable;


    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PageEditable;
                field("No."; Rec."No.")
                {
                    Caption = 'Storage No.';
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    Caption = 'Member No.';
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Caption = 'Member Name';
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Payroll/Staff No."; Rec."PF No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Collateral Owner"; Rec."Collateral Owner")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Collateral Category"; Rec."Collateral Category")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if Rec."Collateral Category" = Rec."Collateral Category"::" " then begin
                            Error('Collateral Category is required');
                        end
                        else
                            if Rec."Collateral Category" = Rec."Collateral Category"::Immovable then begin
                                EditableImmovable := true;
                                EditableMoveable := false;
                                EditableChattels := false;
                                EditableCashCollateral := false;
                            end;
                        //else
                        if Rec."Collateral Category" = rec."Collateral Category"::Moveable then begin
                            EditableImmovable := false;
                            EditableMoveable := true;
                            EditableChattels := false;
                            EditableCashCollateral := false;
                        end;
                        //else
                        if Rec."Collateral Category" = rec."Collateral Category"::Chattels then begin
                            EditableImmovable := false;
                            EditableMoveable := false;
                            EditableChattels := true;
                            EditableCashCollateral := false;
                        end;
                        if Rec."Collateral Category" = Rec."Collateral Category"::" " then begin
                            EditableImmovable := false;
                            EditableMoveable := false;
                            EditableChattels := false;
                            EditableCashCollateral := false;
                        end;
                    end;
                }
                // field("Reference No"; Rec."Reference No")
                // {
                // }
                // field("Storage No"; Rec."Storage No")
                // {
                // }
                // field("Loan No."; Rec."Loan No.")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = PageEditable;
                // }
                // // field("Loan Product"; Rec."Loan Product")
                // // {
                // //     ApplicationArea = Basic,Suite;
                // //     //Editable = PageEditable;
                // //     Editable = false;
                // // }
                // field("Loan Name"; Rec."Loan Name")
                // {
                //     Caption = 'Loan Product';
                //     ApplicationArea = Basic, Suite;
                //     //Editable = PageEditable;
                //     Editable = false;
                // }
                // field("Loan Amount"; Rec."Loan Amount")
                // {
                //     Editable = false;
                // }
                // field("Outstanding Balance"; Rec."Outstanding Balance")
                // {
                //     Editable = false;
                // }
                // field("Lending Unit"; Rec."Lending Unit")
                // {
                //     Editable = false;
                // }
                field("Loan Offer Letter Date"; Rec."Loan Offer Letter Date")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = PageEditable;
                }
                field("Collateral Type"; Rec."Collateral Type")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    //Editable = NotCashCollateral;
                    //Editable = PageEditable;
                }
                field("Collateral Ref No."; Rec."Collateral Ref No.")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = NotCashCollateral;
                    //Editable = PageEditable;
                }
                field(Collateral; Rec.Collateral)
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = NotCashCollateral;
                    Caption = 'Collateral Multiplier Code';
                    ShowMandatory = true;
                    //Editable = PageEditable;
                }
                field("Collateral Name"; Rec."Collateral Name")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    //Editable = NotCashCollateral;
                    //Visible = false;
                    //Editable = PageEditable;
                }
                // field("Collateral Types"; Rec."Collateral Types")
                // {
                //     ToolTip = 'Specifies the value of the Collateral Types field.';
                //     Editable  = False;
                // }

                field("Collateral Multiplier"; Rec."Collateral Multiplier")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Collateral Multiplier (%)';
                    Editable = false;
                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Collateral Value"; Rec."Collateral Value")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = NotCashCollateral;
                    ShowMandatory = true;
                }
                field("Collateral Limit"; Rec."Collateral Limit")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    //Editable = NotCashCollateral;
                }
                field("Amount to be Charged"; Rec."Amount to be Charged")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = NotCashCollateral;
                    //Editable = PageEditable;
                }
                field("Inward/Outward"; Rec."Inward/Outward")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Last Valuation Date"; Rec."Last Valuation Date")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = NotCashCollateral;
                }
                field("Valuer Name"; Rec."Valuer Name")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = NotCashCollateral;

                }
                field("Charge Type"; Rec."Charge Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Charge Type field.';
                    //Editable = NotCashCollateral;
                }
                field("Forced Sale Value"; Rec."Forced Sale Value")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = NotCashCollateral;
                }
                field("Market Value"; Rec."Market Value")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = NotCashCollateral;
                }
                field("Personal Guarantee Provided"; Rec."Personal Guarantee Provided")
                {
                    Editable = PageEditable;
                    ApplicationArea = Basic, Suite;
                }
                field("Collateral Perfected"; Rec."Collateral Perfected")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Next Valuation Date"; Rec."Next Valuation Date")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                Field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = False;
                }
                field("Branch Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Branch Code field.';
                    Editable = false;
                }
                field("Activity Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Activity Code field.';
                    Editable = false;
                }
                field("Captured By"; Rec."Captured By")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    Editable = False;
                    Visible = true;
                    ApplicationArea = Basic, Suite;
                    // trigger OnValidate()
                    // begin
                    //     UpdatePageControls
                    // end;
                }
            }
            group(Moveable)
            {
                Visible = EditableMoveable;
                Editable = PageEditable;

                field("Corporate Guarantee Provided"; Rec."Corporate Guarantee Provided")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Tracking Company"; Rec."Tracking Company")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Tracking Renewal Date"; Rec."Tracking Renewal Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Insurance Company"; Rec."Insurance Company")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = PageEditable;
                }
                field("Insurance Type"; Rec."Insurance Type")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = PageEditable;
                }
            }
            group(Immovable)
            {
                Visible = EditableImmovable;
                Editable = PageEditable;
                field("Collateral Hold Types"; Rec."Collateral Hold Types")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = PageEditable;
                    trigger OnValidate()
                    begin
                        if Rec."Collateral Hold Types" = Rec."Collateral Hold Types"::" " then begin
                            Error('Collateral Hold Types is required');
                        end
                        else if Rec."Collateral Hold Types" = Rec."Collateral Hold Types"::"Lease Hold" then begin
                            ExpiryEditable := true;
                        end
                        else if Rec."Collateral Hold Types" = Rec."Collateral Hold Types"::"Free Hold" then begin
                            ExpiryEditable := false;
                        end;
                    end;
                }
                field("Lease/Ownership Exp. Date"; Rec."Lease/Ownership Exp. Date")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = ExpiryEditable;
                }
                field("Years to Expiry"; Rec."Years to Expiry")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = False;
                }
                field("Spousal Consent"; Rec."Spousal Consent")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Spousal Consent field.';
                }
                field("Land Control Board Consent"; Rec."Land Control Board Consent")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Land Control Board Consent field.';
                }
                field("Law Firm Handling the Matter"; Rec."Law Firm Hanlding the Matter")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Law Firm Handling the Matter';
                    ToolTip = 'Specifies the value of the Law Firm Hanlding the Matter field.';
                }
                field("Law Firm Address"; Rec."Law Firm Address")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Law Firm Address field.';
                }
                field("Law Firm Physical Address"; Rec."Law Firm Physical Address")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Law Firm Physical Address field.';
                }
                field("Fees Payable to the firm"; Rec."Fees Payable to the firm")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Fees Payable to the firm field.';
                }
                field("Status of the fees"; Rec."Status of the fees")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Status of the fees field.';
                }
                field("Property Location"; Rec."Property Location")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Property Location field.';

                }
            }
            // group("Cash Collateral Details")
            // {
            //     Caption = 'Cash Collateral';
            //     Editable = EditableCashCollateral;
            //     field("Deposit Account"; Rec."Deposit Account")
            //     {
            //     }
            //     field("Deposit Account Name"; Rec."Deposit Account Name")
            //     {
            //         Editable = false;
            //     }
            //     field("Deposit Account No."; Rec."Deposit Account No.")
            //     {
            //         //Editable = false;
            //     }
            //     field("Deposit Account Balance"; Rec."Deposit Account Balance")
            //     {
            //         Editable = false;
            //     }
            //     field("Cash Collateral Amount"; Rec."Cash Collateral Amount")
            //     {
            //     }
            //     field("Cash Collateral Posted"; Rec."Cash Collateral Posted")
            //     {
            //         Editable = false;
            //     }
            // }
            group("Chattels Details")
            {
                Caption = 'Chattels Details';
                Visible = EditableChattels;
                Editable = PageEditable;
                Field("Collateral Description"; Rec."Collateral Description")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = PageEditable;
                }
                field("Affidavit Provided"; Rec."Affidavit Provided")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = PageEditable;
                }
                field("Affidavit Date"; Rec."Affidavit Date")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        //if Rec."Affidavit Provided" = Rec."Affidavit Provided"::Yes then begin
                        if Rec."Affidavit Provided" then begin
                            if Rec."Affidavit Date" = 0D then begin
                                Error('Affidavit Date is required');
                            end;
                        end;
                    end;
                }
                field("Chattel Make"; Rec."Chattel Make")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = PageEditable;
                }
                field("Model No."; Rec."Model No.")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = PageEditable;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = PageEditable;
                }
                field("Year of Purchase"; Rec."Year of Purchase")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = PageEditable;
                }
                field("Estimated Market Value"; Rec."Estimated Market Value")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = PageEditable;
                }
            }
            group(OtherDetails)
            {
                Caption = 'Other Details';
                Visible = PageEditable;
                // field("Security Category"; Rec."Security Category")
                // {
                // }
                field("Chargor/Owner Name"; Rec."Chargor/Owner Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Chargor/Owner KRA PIN"; Rec."Chargor/Owner KRA PIN")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Chargor/Owner ID No"; Rec."Chargor/Owner ID No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Chargor Phone No."; Rec."Chargor Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date of registration"; Rec."Date of registration")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Collateral Description"; Rec."Collateral Description")
                // { }
                // field("Lease/Ownership Exp. Date"; Rec."Lease/Ownership Exp. Date")
                // { }
                field("Date of Manufacture"; Rec."Date of Manufucture")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            // group("Case Forwarding")
            // {
            // Visible = false;
            // Editable = ForwardingEditable;
            // field("Send/Forward to"; Rec."Send/Forward to")
            // {
            //     Editable = ForwardingEditable;
            // }
            // field("Originating Department"; Rec."Originating Department")
            // {
            //     Caption = 'Originating Department';
            //     Editable = false;
            // }
            // field("Current Departmrnt"; Rec."Current Departmrnt")
            // {
            //     Caption = 'Current Department';
            //     Editable = false;
            // }

        }



        area(FactBoxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")//"Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = Const(52185840), "No." = field("No.");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Visible = NOT IsOfficeAddin;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    actions
    {
        area(creation)
        {
            // action("Co&mments")
            // {
            //     Caption = 'Comments';
            //     ApplicationArea = Basic, Suite;
            //     RunObject = Page "Comment Sheet";
            //     Visible = AtLegal;
            // }
            action("Security Valuers")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Security Valuers';
                Image = Action;
                Promoted = true;
                PromotedCategory = Category7;
                RunObject = page "Security Valuers List";
                RunPageLink = "Security No." = field("No.");

            }
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                PromotedCategory = Category5;
                Promoted = true;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                begin

                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.TestField("Collateral Category");
                    Rec.TestField("Account No.");
                    Rec.TestField("Account Name");
                    Rec.TESTFIELD("Collateral Owner");
                    // Rec.TestField("Loan No.");
                    // Rec.TestField("Loan Name");
                    //Rec.TestField("Loan Amount");
                    // Rec.TestField("Lending Unit");
                    //Rec.TestField("Loan Offer Letter Date");
                    Rec.TestField("Collateral Type");


                    //if Rec."Collateral Category" <> Rec."Collateral Category"::"Cash Collateral" then begin
                    // Rec.TestField("Amount to be Charged");
                    //Rec.TestField("Collateral Ref No.");
                    Rec.TestField("Collateral");
                    Rec.Testfield("Collateral Name");
                    Rec.TestField("Collateral Multiplier");
                    Rec.TestField("Collateral Value");
                    Rec.TestField("Collateral Limit");
                    Rec.TestField("Last Valuation Date");
                    //Rec.TestField("Forced Sale Value");
                    //Rec.TestField("Valuer Name");
                    Rec.TestField("Charge Type");
                    Rec.testfield("Market Value");
                    //end;

                    if Rec."Collateral Category" = Rec."Collateral Category"::Moveable then begin
                        //Rec.TestField("Personal Guarantee Provided");
                        //Rec.TestField("Corporate Guarantee Provided");
                        // Rec.TestField("Tracking Company");
                        // Rec.TestField("Insurance Company");
                        // Rec.TestField("Insurance Type");
                    end;
                    if Rec."Collateral Category" = Rec."Collateral Category"::Immovable then begin
                        // Rec.TestField("Collateral Hold Types");
                        //Rec.TestField("Lease/Ownership Exp. Date");
                        //Rec.TestField("Years to Expiry");
                        // Rec.TestField("Spousal Consent");
                        // Rec.TestField("Land Control Board Consent");
                        // Rec.TestField("Law Firm Hanlding the Matter");
                        // Rec.TestField("Law Firm Address");
                        // Rec.TestField("Law Firm Physical Address");
                        // Rec.TestField("Fees Payable to the firm");
                        // Rec.TestField("Status of the fees");
                        //Rec.TestField("Property Location");
                    end;

                    if Rec."Collateral Category" = Rec."Collateral Category"::Chattels then begin
                        // Rec.TestField("Collateral Description");
                        // Rec.TestField("Affidavit Provided");
                        // Rec.TestField("Affidavit Date");
                        // Rec.TestField("Chattel Make");
                        // Rec.TestField("Model No.");
                        // //Rec.TestField("Serial No.");
                        // Rec.TestField("Year of Purchase");
                        //Rec.TestField("Estimated Market Value");
                    end;

                    // if Rec."Collateral Category" = Rec."Collateral Category"::"Cash Collateral" then begin
                    //     Rec.TestField("Deposit Account");
                    //     Rec.TestField("Deposit Account Name");
                    //     Rec.TestField("Deposit Account No.");
                    //     Rec.TestField("Deposit Account Balance");
                    //     Rec.TestField("Cash Collateral Amount");
                    // end;
                    // if Rec."Collateral Owner" = Rec."Collateral Owner"::Chargor then
                    // begin
                    //     Rec.TestField("Chargor/Owner Name");
                    //     Rec.TestField("Chargor/Owner KRA PIN");
                    //     Rec.TestField("Chargor/Owner ID No");
                    //     Rec.TestField("Chargor Phone No.");
                    //     Rec.TestField("Date of registration");
                    //     //Rec.TestField("Date of Manufucture");
                    // end;

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                PromotedCategory = Category5;
                Image = Cancel;
                Promoted = true;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit 1535;
                begin
                    Rec.TestField(Status, Rec.Status::Pending);
                    if Confirm('Are you sure you want to cancel Approval Request?', false) = true then
                        VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action("Re-Open")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;

                trigger OnAction()
                begin
                    if (Rec.Status = Rec.Status::Rejected) or (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Archived) then begin
                        GlobalFunctions.CommentsManagement(Rec."No.");
                        if not Confirm('Are you sure you want to archive this record?') then exit;
                        Rec.Status := Rec.Status::open;
                        Rec.Validate(Status);
                        Rec.Modify();
                        Message('Record ropened succsessfully');
                    end;
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;

                trigger OnAction()
                var
                    ApprovalEntries: Page 658;
                    approvalsMgmt: Codeunit 1535;
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            // action("Send For Perfection")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Send to Legal';
            //     PromotedCategory = Process;
            //     Image = SendToLegal;
            //     Promoted = true;
            //     trigger OnAction()
            //     begin
            //         Rec.TestField(Status, Rec.Status::Approved);
            //         if Confirm('Are you sure you want to send to Legal?', false) = true then begin
            //             Rec."Security Stage" := Rec."Security Stage"::"At Legal";
            //             Rec.Modify;
            //         end;
            //     end;
            // }
            action(Archive)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Archive Application';
                Image = Archive;
                //Visible = RejectVisible;
                Promoted = true;
                PromotedCategory = Category8;

                trigger OnAction()
                var

                begin
                    GlobalFunctions.CommentsManagement(Rec."No.");
                    if not Confirm('Are you sure you want to archive this record?') then exit;
                    Rec.Status := Rec.Status::Archived;
                    Rec.Validate(Status);
                    Rec.Modify();
                    Message('Record archived succsessfully');
                end;
            }
            action(Reopen)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reopen Card';
                Image = ReOpen;
                Visible = ReopenVisible;

                trigger OnAction()
                var

                begin
                    GlobalFunctions.CommentsManagement(Rec."No.");

                    if not Confirm('Are you sure you want to open this record?') then exit;
                    GlobalFunctions.CancelApprovalManually(Rec.RecordId);
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                    CurrPage.Update();
                end;
            }

            // action(Comments)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = ViewComments;
            //     Promoted = true;
            //     PromotedCategory = Category4;

            //     RunObject = page "Comments List";
            //     RunPageLink = "Header No." = field("No.");
            //     RunPageView = where(Types = CONST(comment));
            // }
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
                action("Return Documents")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Send/Forward to" = Rec."Current Departmrnt" then Error('You cannot return this document to %1 while its already in %1', Rec."Send/Forward to");
                        Comments.Reset();
                        Comments.SetRange("Header No.", Rec."No.");
                        if Comments.FindLast() then begin
                            if Comments."Commented By" <> UserId then Error('Kindly leave a comment');
                            if Comments.Comment = '' then Error('Kindly leave a comment');
                        end else
                            Error('Kindly add a comment');
                        if not Confirm('Are you sure you want to return this document?') then exit;
                        if Rec."Originating Department" = Rec."Send/Forward to" then begin
                            // Rec."Originator Status" := Rec."Originator Status"::Returned;
                            // Rec."Recepient Status" := Rec."Recepient Status"::Returned;

                            CFPage.InsertTracker(Rec."No.", Rec."Send/Forward to", true, UserId, CurrentDateTime);
                            Rec."Current Departmrnt" := Rec."Send/Forward to";
                            Rec.Modify();
                            Message('Case sent successfully');
                        end
                        else begin
                            Error('You Can Only Return to the Originating Department!');
                        end;
                    end;
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
                        if Rec."Collateral Category" <> Rec."Collateral Category"::Immovable then Error('Only Collaterals of Collateral Category Immmovable can be send to legal for Perfection.');
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
            action("Send SMS")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send SMS';
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()

                begin
                    Rec.TestField("Collateral Owner");
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField("SMS Sent", false);
                    Members.Reset();
                    Members.SetRange("No.", Rec."Account No.");
                    if Members.Find('-') then begin
                        if Members."Phone No." <> '' then begin
                            if Confirm('Do you want to send an SMS to the Loanee?') then
                                if Rec."Collateral Owner" = Rec."Collateral Owner"::" " then begin
                                    Error('Collateral Owner is required')
                                end
                                else
                                    if Rec."Collateral Owner" = Rec."Collateral Owner"::Loanee then begin
                                        msg := 'Dear, ' + Rec."Account Name" + ', this is to formally inform you that the ' + Format(Rec."Charge Type") + ' over ' + 'Property Number - ' + Rec."Collateral Ref No." + ' ' + 'which you offered as collateral for' + ' ' + Rec."Loan Name" + ' ' + 'was successfully Discharged on the' + ' ' + Format(Today) + '.';
                                        SendSMS.SendSms(Source::"Security Perfection", Members."Phone No.", msg, ' ', ' ', false, 0, false, 'CBS', Rec."No.", 'CBS', Rec."Date of Registration");
                                    end
                                    else begin
                                        msg := 'Dear, ' + Rec."Account Name" + ', this is to formally inform you that the ' + Format(Rec."Charge Type") + ' over ' + 'Property Number - ' + Rec."Collateral Ref No." + ' ' + 'which you offered as collateral for' + ' ' + Rec."Loan Name" + ' ' + 'was successfully Discharged on the' + ' ' + FORMAT(TODAY) + '.';
                                        SendSMS.SendSms(Source::"Security Perfection", Members."Transactional Mobile Number", msg, ' ', ' ', false, 0, false, 'CBS', Rec."No.", 'CBS', Rec."Date of Registration");
                                    end;
                        end
                        else
                            if Rec."Collateral Owner" = Rec."Collateral Owner"::Chargor then begin
                                if Confirm('Do you want to send SMS to the Chargor') then
                                    msg := 'Dear ' + Rec."Chargor/Owner Name" + ',' + ' please note that the ' + FORMAT(Rec."Charge Type") + 'over Property No. ' + Rec."Collateral Ref No." + 'which you offered as collateral for' + ' ' + Rec."Loan Name" + ' ' + 'for ' + Rec."Account Name" + ' was successfully Discharged on the' + ' ' + FORMAT(TODAY) + '. ';
                                SendSMS.SendSms(Source::"Security Perfection", Rec."Chargor Phone No.", msg, ' ', ' ', false, 0, false, 'CBS', Rec."No.", 'CBS', Rec."Date of Registration");
                            end;
                        Rec."SMS Sent" := true;
                        Rec.Modify();
                        MESSAGE('Security Registered');
                        CurrPage.Close();
                    end;
                end;
            }

            // action("Post Lien")
            // {
            //     ApplicationArea = Basic, All;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     trigger OnAction()
            //     begin
            //         If not Confirm('Are you sure you want to post this Lien?') then
            //             exit
            //         else
            //             if Rec."Cash Collateral Amount" > Rec."Deposit Account Balance" then
            //                 Error('Member Deposit Balance is less than the Cash Collateral Amount.')
            //             else
            //                 if Rec."Cash Collateral Posted" = true then
            //                     Error('Cash Collateral already posted!')
            //                 else
            //                     Rec.TestField("Collateral Category", Rec."Collateral Category"::"Cash Collateral");
            //         //Rec.Testfield(Status, Rec.Status::Approved);
            //         Rec.TestField("Cash Collateral Posted", false);
            //         SavingsAccounts.Reset;
            //         SavingsAccounts.SetRange("Product Category", Rec."Deposit Account Name");
            //         SavingsAccounts.SetRange("Member No.", Rec."Account No.");
            //         if SavingsAccounts.Get(SavingsAccounts."No.") then
            //             HoldLien.Get(SavingsAccounts."Member No.");
            //         begin
            //             HoldLien.Init();
            //             HoldLien."Record No." := Rec."No.";
            //             HoldLien."Member No." := Rec."Account No.";
            //             HoldLien."Account No." := Rec."Deposit Account No.";
            //             HoldLien.Total := Rec."Cash Collateral Amount";
            //             HoldLien."Funds Status" := HoldLien."Funds Status"::WithHeld;
            //             HoldLien.Type := HoldLien.Type::Lien;
            //             HoldLien."Entry Date" := CurrentDateTime;
            //             HoldLien."Created By" := UserId;
            //             HoldLien."Responsibility Center" := Rec."Responsibility Center";
            //             HoldLien."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
            //             HoldLien."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
            //             HoldLien.Insert();
            //         end;
            //         Rec."Cash Collateral Posted" := true;
            //         Rec.Modify;
            //         Message('Lien Posted Successfully');
            //     end;
            // }

        }
    }

    trigger OnOpenPage()
    begin
        CurrPage.UPDATE;
        if Rec.Status = Rec.Status::Open then begin
            //CurrPage.Editable := true
            PageEditable := true;
            ForwardingEditable := false;
        end
        else begin
            //CurrPage.Editable := false;
            PageEditable := false;
            ForwardingEditable := true;
        end;
        PageControl();
        SetControlAppearance;
    end;

    //   trigger OnAfterGetRecord()
    //     begin
    //         IsEditable := (Rec.Status <> Rec.Status::Approved); 
    //     end;
    var
        IsOfficeAddin: Boolean;
        IsEditable: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        DocMustbePending: Label 'Document status Must be Pending';
        PageEditable: Boolean;
        Members: Record "Members";
        GlobalFunctions: Codeunit "Global Functions";
        DeferVisible: Boolean;
        SendApprovalVisible: Boolean;
        ReopenVisible: Boolean;
        RejectVisible: Boolean;
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
        ForwardingEditable: Boolean;


    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit 1535;
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);


        // if Rec.Status = Rec.Status::Deffered then begin
        //     DeferVisible := false;
        //     SendApprovalVisible := false;
        //     ReopenVisible := true;

        // end;
        if Rec.Status = Rec.Status::Archived then begin
            RejectVisible := false;
            SendApprovalVisible := false;
            ReopenVisible := true;

        end;
        if Rec.Status = Rec.Status::Rejected then begin
            ReopenVisible := true;
        end;

        if Rec.Status = Rec.Status::Approved then Begin
            PageEditable := false;
            ReopenVisible := true;
        end
        else
            PageEditable := true;

    end;

    local procedure PageControl()
    begin
        EditableCashCollateral := false;
        EditableMoveable := false;
        EditableImmovable := false;
        EditableChattels := false;
        NotCashCollateral := false;


        if Rec."Collateral Category" = Rec."Collateral Category"::Immovable then begin
            EditableImmovable := true;
            EditableMoveable := false;
            EditableChattels := false;
            EditableCashCollateral := false;
            NotCashCollateral := true;
        end;
        //else
        if Rec."Collateral Category" = rec."Collateral Category"::Moveable then begin
            EditableImmovable := false;
            EditableMoveable := true;
            EditableChattels := false;
            EditableCashCollateral := false;
            NotCashCollateral := true;
        end;
        //else
        if Rec."Collateral Category" = rec."Collateral Category"::Chattels then begin
            EditableImmovable := false;
            EditableMoveable := false;
            EditableChattels := true;
            EditableCashCollateral := false;
            NotCashCollateral := true;
        end
        // else
        //     if rec."Collateral Category" = rec."Collateral Category"::"Cash Collateral" then begin
        //         EditableImmovable := false;
        //         EditableMoveable := false;
        //         EditableChattels := false;
        //         EditableCashCollateral := true;
        //         NotCashCollateral := false;
        //     end;
    end;

    var
        SendSMS: Codeunit SendSms;
        msg: Text;
        Source: enum "SMS Source";
        EditableMoveable: Boolean;
        EditableImmovable: Boolean;
        EditableChattels: Boolean;
        EditableCashCollateral: Boolean;
        ExpiryEditable: Boolean;
        SavingsAccounts: Record "Savings Accounts";
        HoldLien: Record "One Month Installment";
        NotCashCollateral: Boolean;
}

