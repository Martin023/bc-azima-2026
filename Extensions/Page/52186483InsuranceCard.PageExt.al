#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186483 pageextension52186483 extends "Insurance Card"

{
    PromotedActionCategories = 'New,Home,Report, Approvals,Process,Assets List';
    layout
    {
        addafter("No.")
        {
            field("Asset Insurance"; Rec."Asset Insurance")
            {
                ApplicationArea = Basic;
                Caption = 'Asset Insurance';
                ToolTip = 'Asset Insurance whether single asset or collective assets';
                trigger OnValidate()
                var
                    myInt: Integer;
                begin

                    Rec."Insurance Vendor No." := '';
                    Rec."Insurance Type" := '';
                    Rec."Policy No." := '';
                    Rec."Effective Date" := 0D;
                    Rec."Expiration Date" := 0D;
                    Rec."Annual Premium" := 0;
                    Rec."Policy Coverage" := 0;
                    Rec."Blocked" := false;
                    //Rec."Insurance Status" := Rec."Insurance Status"::"New";
                    Rec."Renewal Date" := 0D;
                    Rec."Fixed Asset No." := '';
                    //Rec."FA Class Code" := '';
                    Rec."FA Subclass Code" := '';
                    Rec."FA Location Code" := '';
                    Rec."Insurer" := '';
                    Rec."Insurer Name" := '';
                    Rec."Insurance Cover" := '';
                    Rec."Book Value" := 0;
                    REc.Description := '';

                    if Rec."Asset Insurance" = Rec."Asset Insurance"::" " then begin
                        VisibleSingleAsset := false;
                        VisibleCollectiveAsset := false;
                        VisibleNonAsset := false;
                    end;
                    //else
                    if Rec."Asset Insurance" = Rec."Asset Insurance"::"Single Asset" then begin
                        VisibleSingleAsset := true;
                        VisibleCollectiveAsset := false;
                        VisibleNonAsset := false;
                    end;
                    //else
                    if
                    Rec."Asset Insurance" = Rec."Asset Insurance"::"Multiple Assets" then begin
                        VisibleSingleAsset := false;
                        VisibleCollectiveAsset := true;
                        VisibleNonAsset := false;
                    end;
                    //else
                    if Rec."Asset Insurance" = Rec."Asset Insurance"::"Non Assets" then begin
                        VisibleSingleAsset := false;
                        VisibleCollectiveAsset := false;
                        VisibleNonAsset := true;
                    end;
                end;
                //end;
            }
            field("Asset Classification"; Rec."FA Class Code")
            {
                ApplicationArea = Basic;
                Caption = 'FA Class Code';
                ToolTip = 'FA Class Code';
                Visible = VisibleSingleAsset OR VisibleCollectiveAsset;
                trigger OnValidate()
                var
                    myInt: Integer;

                begin

                    Rec."Insurance Vendor No." := '';
                    Rec."Insurance Type" := '';
                    Rec."Policy No." := '';
                    Rec."Effective Date" := 0D;
                    Rec."Expiration Date" := 0D;
                    Rec."Annual Premium" := 0;
                    Rec."Policy Coverage" := 0;
                    Rec."Blocked" := false;
                    //Rec."Insurance Status" := Rec."Insurance Status"::"New";
                    Rec."Renewal Date" := 0D;
                    Rec."Fixed Asset No." := '';
                    //Rec."FA Class Code" := '';
                    Rec."FA Subclass Code" := '';
                    Rec."FA Location Code" := '';
                    Rec."Insurer" := '';
                    Rec."Insurer Name" := '';
                    Rec."Insurance Cover" := '';
                    Rec."Book Value" := 0;
                    REc.Description := '';

                    if Rec."Asset Insurance" = Rec."Asset Insurance"::"Multiple Assets" then begin

                        FA.RESET;
                        FA.Setrange("FA Class Code", Rec."FA Class Code");
                        FA.SetRange(Acquired, true);
                        if FA.Find('-') then begin
                            repeat
                                //CollectiveAssets.DeleteAll();
                                CollectiveAssets.Init();
                                CollectiveAssets."Insurance No." := Rec."No.";
                                CollectiveAssets."Asset No." := FA."No.";
                                CollectiveAssets.Description := FA.Description;
                                CollectiveAssets."FA Class Code" := FA."FA Class Code";
                                CollectiveAssets."FA Subclass Code" := FA."FA Subclass Code";
                                CollectiveAssets."FA Location Code" := FA."FA Location Code";
                                FADepBook.RESET;
                                FADepBook.SetRange("FA No.", FA."No.");
                                if FADepBook.Find('-') then begin
                                    FADepBook.CALCFIELDS(FADepBook."Book Value");
                                    CollectiveAssets."Book Value" := FADepBook."Book Value";
                                end;
                                CollectiveAssets.Insert();
                            until FA.Next() = 0;
                        end;

                    end;
                end;
            }

            field("Fixed Asset No."; Rec."Fixed Asset No.")
            {
                ApplicationArea = Basic;
                Caption = 'Fixed Asset No.';
                ToolTip = 'Fixed Asset No.';
                Visible = VisibleSingleAsset;
            }
        }
        addafter(Description)
        {
            field("Insurer"; Rec."Insurer")
            {
                ApplicationArea = Basic;
                Caption = 'Insurer';
                ToolTip = 'Insurer';
            }
            field("Insurer Name"; Rec."Insurer Name")
            {
                ApplicationArea = Basic;
                Caption = 'Insurer Name';
                ToolTip = 'Insurer Name';
                Editable = false;
            }
            field("Insurance Coverage"; Rec."Insurance Cover")
            {
                ApplicationArea = Basic;
                Caption = 'Insurance Coverage';
                ToolTip = 'Insurance Coverage';
            }
        }
        addafter("Expiration Date")
        {
            field("Renewal Date"; Rec."Renewal Date")
            {
                ApplicationArea = Basic;
                Caption = 'Renewal Date';
                ToolTip = 'Renewal Date';
            }

        }
        addafter("Search Description")
        {
            field("Book Value"; Rec."Book Value")
            {
                ApplicationArea = Basic;
                Caption = 'Book Value';
                ToolTip = 'Book Value';
                Editable = false;
                Visible = VisibleSingleAsset;
            }
        }
        addafter("Last Date Modified")
        {
            field("Created By"; Rec."Created By")
            {
                ApplicationArea = Basic;
                Caption = 'Created By';
                ToolTip = 'Created By';
                Editable = false;
            }
            field("Created Date"; Rec."Created Date")
            {
                ApplicationArea = Basic;
                Caption = 'Created Date';
                ToolTip = 'Created Date';
                Editable = false;
            }
            field("Resposibility Center"; Rec."Responsibility Centre")
            {
                ApplicationArea = Basic;
                Caption = 'Resposibility Center';
                ToolTip = 'Resposibility Center';
                Editable = false;
            }
            field("Branch Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = Basic;
                Caption = 'Branch Code';
                ToolTip = 'Branch Code';
                Editable = false;
            }
            field("Activity Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = Basic;
                Caption = 'Activity Code';
                ToolTip = 'Activity Code';
                Editable = false;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
                Caption = 'Status';
                ToolTip = 'Status';
                Editable = false;
            }
            field("Insurance Status"; Rec."Insurance Status")
            {
                ApplicationArea = Basic;
                Caption = 'Insurance Status';
                ToolTip = 'Insurance Status';
                Editable = false;
            }
            // part("Collective Asset Insurance"; "Collective Asset Insurance")
            // {
            //     Visible = VisibleCollectiveAsset;
            //     ApplicationArea = Basic;
            //     Editable = TRUE;
            //     Caption = 'Collective Asset Insurance';
            //     SubpageLink = "Insurance No." = field("Fixed Asset No.");
            // }
        }

        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Insurance Vendor No.")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Effective Date")
        {
            ApplicationArea = Basic;
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                if Rec."Effective Date" > Today() then
                    Error('Effective Date cannot be greater than today');

            end;
        }
        modify("Expiration Date")
        {
            ApplicationArea = Basic;
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                if Rec."Expiration Date" < Rec."Effective Date" then
                    Error('Expiration Date cannot be less than Effective Date');
            end;
        }
        modify("Insurance Type")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Policy No.")
        {
            ApplicationArea = Basic;
        }
        modify("Search Description")
        {
            ApplicationArea = Basic;
        }
        modify("Annual Premium")
        {
            ApplicationArea = Basic;
        }
        modify("Policy Coverage")
        {
            ApplicationArea = Basic;
        }
        modify(Blocked)
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        // modify("Last Date Modified")
        // {
        //     ApplicationArea = Basic;
        // }

        modify("FA Class Code")
        {
            ApplicationArea = Basic;
            Editable = false;
            Visible = VisibleSingleAsset;

        }
        modify("FA Subclass Code")
        {
            ApplicationArea = Basic;
            Editable = false;
            Visible = VisibleSingleAsset;
        }
        modify("FA Location Code")
        {
            ApplicationArea = Basic;
            Editable = false;
            Visible = VisibleSingleAsset;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insurance Vendor No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Effective Date"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expiration Date"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insurance Type"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Policy No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Search Description"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Annual Premium"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Policy Coverage"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Blocked(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date Modified"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Class Code"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Subclass Code"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Location Code"(Control 34)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".


        addafter("FA Location Code")
        {
            // group("Collective Asset")
            // {
            part("Collective Asset Insurance"; "Collective Asset Insurance")
            {
                Visible = VisibleCollectiveAsset;
                ApplicationArea = Basic;
                Editable = TRUE;
                Caption = 'Collective Asset Insurance';
                SubpageLink = "Insurance No." = field("No."), "FA Class Code" = field("FA Class Code");
            }
            //}
        }
    }

    actions
    {
        addafter("Analysis")
        {
            action("Assets")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Collective Asset Insurance Assets';
                Image = Catalog;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "Collective Asset Insurance";
                RunpageLink = "Insurance No." = field("No.");
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.TestField("Asset Insurance", Rec."Asset Insurance"::"Multiple Assets");
                    if Rec."Asset Insurance" <> Rec."Asset Insurance"::"Multiple Assets" then
                        Error('Insurance Type must be Multiple Assets');
                    begin
                        FA.RESET;
                        FA.Setrange("FA Class Code", Rec."FA Class Code");
                        if FA.Find('-') then begin
                            repeat
                                CollectiveAssets.DeleteAll();
                                CollectiveAssets.Init();
                                CollectiveAssets."Insurance No." := Rec."No.";
                                CollectiveAssets."Asset No." := FA."No.";
                                CollectiveAssets.Description := FA.Description;
                                CollectiveAssets."FA Class Code" := FA."FA Class Code";
                                CollectiveAssets."FA Subclass Code" := FA."FA Subclass Code";
                                CollectiveAssets."FA Location Code" := FA."FA Location Code";
                                FADepBook.RESET;
                                FADepBook.SetRange("FA No.", FA."No.");
                                if FADepBook.FindFirst() then begin
                                    FADepBook.CALCFIELDS(FADepBook."Book Value");
                                    CollectiveAssets."Book Value" := FADepBook."Book Value";
                                end;
                            until FA.Next() = 0;
                        end;
                    end;
                end;
            }
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
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    //Rec.TestField("Fixed Asset No.");
                    Rec.TestField(Insurer);
                    Rec.TestField("Insurer Name");
                    Rec.TestField("Effective Date");
                    Rec.TestField("Expiration Date");
                    //Rec.TestField("Insurance Type");
                    Rec.TestField("Policy No.");
                    Rec.TestField("Renewal Date");

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
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    if Rec.Status <> Rec.Status::Pending then
                        Error(DocMustbePending);

                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action("Re-Open Document")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category4;
                Image = ReOpen;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Open then
                        Error('Document is Open!');
                    if not Confirm('Are you sure you want to re-open this document?') then exit;
                    GlobalFunctions.CancelApprovalManually(Rec.RecordId);
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                    Message('Document Reopened Sucessfully.');
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action("Activate Insurance")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Activate Insurance';
                //Image = ActivateInsurance;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Open then
                        Error('Document is Open!');
                    if not Confirm('Are you sure you want to Activate this Insurance?') then exit;
                    CollectiveAssets.Reset();
                    CollectiveAssets.SetRange("Insurance No.", Rec."No.");
                    if CollectiveAssets.FindSet() then
                        repeat
                            CollectiveAssets.Insured := true;
                            CollectiveAssets.Modify;
                        until CollectiveAssets.Next() = 0;
                    Rec."Insurance Status" := Rec."Insurance Status"::Active;
                    Rec.Modify;
                    Message('Insurance Activated Sucessfully.');
                end;
            }
        }
        // modify(Statistics)
        // {
        //     ApplicationArea = Basic, Suite;
        //     Visible = false;
        // }
        // modify("Total Value Ins&ured per FA")
        // {
        //     ApplicationArea = Basic, Suite;
        //     Visible = false;
        // }
        // modify("Uninsured FAs")
        // {
        //     ApplicationArea = Basic, Suite;
        //     Visible = false;
        // }
        // modify(Register)
        // {
        //     ApplicationArea = Basic, Suite;
        //     Visible = false;
        // }
    }
    // trigger OnOpenPage();
    // begin
    //     if UserSetup.Get(Rec."Created By") then begin
    //         Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
    //         Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
    //         Rec."Responsibility Centre" := UserSetup."Responsibility Centre";
    //         Rec."Created By" := UserId;
    //         Rec.SystemCreatedAt := CURRENTDATETIME;
    //         Rec.Modify;
    //     end;
    // end;

    trigger OnOpenPage()
    var
        myInt: Integer;

    begin
        if Rec."Asset Insurance" = Rec."Asset Insurance"::" " then begin
            VisibleSingleAsset := false;
            VisibleCollectiveAsset := false;
            VisibleNonAsset := false;
        end;
        //else
        if Rec."Asset Insurance" = Rec."Asset Insurance"::"Single Asset" then begin
            VisibleSingleAsset := true;
            VisibleCollectiveAsset := false;
            VisibleNonAsset := false;
        end;
        //else
        if
        Rec."Asset Insurance" = Rec."Asset Insurance"::"Multiple Assets" then begin
            VisibleSingleAsset := false;
            VisibleCollectiveAsset := true;
            VisibleNonAsset := false;
        end;
        //else
        if Rec."Asset Insurance" = Rec."Asset Insurance"::"Non Assets" then begin
            VisibleSingleAsset := false;
            VisibleCollectiveAsset := false;
            VisibleNonAsset := true;
        end;

    end;


    Var
        UserSetup: Record "User Setup";
        PageEdit: Boolean;
        VarVariant: Variant;
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VisibleSingleAsset: Boolean;
        VisibleCollectiveAsset: Boolean;
        FA: Record "Fixed Asset";
        CollectiveAssets: Record "Collective Asset Insurance";
        FADepBook: Record "FA Depreciation Book";
        VisibleNonAsset: Boolean;
        GlobalFunctions: Codeunit "Global Functions";
    // actions
    // {
    //     modify("Coverage Ledger E&ntries")
    //     {
    //         ApplicationArea = Basic;
    //     }
    //     modify("Co&mments")
    //     {
    //         ApplicationArea = Basic;
    //     }
    //     modify(Dimensions)
    //     {
    //         ApplicationArea = Basic;
    //     }
    //     modify(Statistics)
    //     {
    //         ApplicationArea = Basic;
    //     }
    //     modify("Total Value Ins&ured per FA")
    //     {
    //         ApplicationArea = Basic;
    //     }
    //     modify(List)
    //     {
    //         ApplicationArea = Basic;
    //     }
    //     modify("Uninsured FAs")
    //     {
    //         ApplicationArea = Basic;
    //     }
    //     modify("Tot. Value Insured")
    //     {
    //         ApplicationArea = Basic;
    //     }
    //     modify("Coverage Details")
    //     {
    //         ApplicationArea = Basic;
    //     }
    //     modify(Register)
    //     {
    //         ApplicationArea = Basic;
    //     }
    //     modify(Analysis)
    //     {
    //         ApplicationArea = Basic;
    //     }

    //Unsupported feature: Property Deletion (ToolTipML) on ""Coverage Ledger E&ntries"(Action 44)".


    //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 7)".


    //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 84)".


    //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 6)".


    //Unsupported feature: Property Deletion (ToolTipML) on ""Total Value Ins&ured per FA"(Action 23)".


    //Unsupported feature: Property Deletion (ToolTipML) on "List(Action 1900084706)".


    //Unsupported feature: Property Deletion (ToolTipML) on ""Uninsured FAs"(Action 1901158106)".


    //Unsupported feature: Property Deletion (ToolTipML) on ""Tot. Value Insured"(Action 1907944406)".


    //Unsupported feature: Property Deletion (ToolTipML) on ""Coverage Details"(Action 1904097106)".


    //Unsupported feature: Property Deletion (ToolTipML) on "Register(Action 1903807106)".


    //Unsupported feature: Property Deletion (ToolTipML) on "Analysis(Action 1901105406)".

    //}
}
