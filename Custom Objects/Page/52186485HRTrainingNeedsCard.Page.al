page 52186485 "HR Training Needs Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Reopen,Training Need,,,,Approvals';
    SourceTable = "HR Training Needs";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                //Editable = FieldEditable;
                group(Control44)
                {
                    ShowCaption = false;
                    grid(Control43)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control42)
                        {
                            ShowCaption = false;
                            field("Code"; Rec.Code)
                            {
                                ApplicationArea = Basic;
                            }
                            field(Description; Rec.Description)
                            {
                                ApplicationArea = Basic;
                                NotBlank = true;
                                ShowMandatory = true;
                                Editable = InvTcode;
                            }
                        }
                    }
                }
                field("Training Category"; Rec."Training Category")
                {
                    ApplicationArea = Basic;
                    Editable = InvTcode;

                }
                field("Training Type"; Rec."Training Type")
                {
                    ApplicationArea = Basic;
                    Editable = InvTcode;

                }
                field(Other; Rec.Other)
                {
                    Editable = InvTcode;

                }
                field("Total Costs"; Rec."Total Costs")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Need Source"; Rec."Need Source")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Editable = InvTcode;

                }
                group(Control41)
                {
                    ShowCaption = false;
                    grid(Control40)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control32)
                        {
                            ShowCaption = false;
                            field("User ID"; Rec."User ID")
                            {
                                Editable = false;
                            }
                            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                            {
                                ApplicationArea = Basic;
                                editable = false;
                            }
                            field("Responsibility Center"; Rec."Responsibility Center")
                            {
                                ApplicationArea = Basic;
                                editable = false;
                            }
                            field(Status; Rec.Status)
                            {
                                ApplicationArea = Basic;
                                editable = false;
                            }
                            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                            {
                                ApplicationArea = Basic;
                                editable = false;
                            }
                        }
                    }
                }
                group(Control36)
                {
                    ShowCaption = false;
                    grid(Control35)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control34)
                        {
                            ShowCaption = false;
                            field("Start Date"; Rec."Start Date")
                            {
                                ApplicationArea = Basic;
                                ShowMandatory = true;
                                Editable = InvTcode;

                            }
                            field("End Date"; Rec."End Date")
                            {
                                ApplicationArea = Basic;
                                Editable = InvTcode;

                            }
                            field("Re-Assessment Date"; Rec."Re-Assessment Date")
                            {
                                ApplicationArea = Basic;
                                Editable = InvTcode;

                            }
                        }
                    }
                }
                group(Control39)
                {
                    ShowCaption = false;
                    grid(Control38)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control37)
                        {
                            ShowCaption = false;
                            field(Location; Rec.Location)
                            {
                                ApplicationArea = Basic;
                                Editable = InvTcode;

                            }
                            field(Provider; Rec.Provider)
                            {
                                ApplicationArea = Basic;
                                Editable = InvTcode;


                            }
                            field("Provider Name"; Rec."Provider Name")
                            {
                                ApplicationArea = Basic;
                                editable = false;
                            }
                            field("Other Provider"; Rec."Other Provider")
                            {
                                ApplicationArea = Basic;
                                Editable = InvTcode;

                            }
                        }
                    }
                }
            }
            // group(Bonding)
            // {
            //     Caption = 'Bonding';
            //     //Editable = FieldEditable;
            //     field("Employee Sponsorship"; Rec."Employee Sponsorship")
            //     {
            //         Editable = InvTcode;


            //     }
            //     field("Bondage Required?"; Rec."Bondage Required?")
            //     {
            //         ApplicationArea = Basic;
            //         Editable = InvTcode;

            //     }
            //     field("Bondage Start Date"; Rec."Bondage Start Date")
            //     {
            //         ApplicationArea = Basic;
            //     }
            //     field("Bondage Duration"; Rec."Bondage Duration")
            //     {
            //         ApplicationArea = Basic;


            //     }
            //     field("Bondage Release Date"; Rec."Bondage Release Date")
            //     {
            //         ApplicationArea = Basic;
            //     }
            //     field("Allow Early Exit if Bonded?"; Rec."Allow Early Exit if Bonded?")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Allow Early Exit with Conditions? If its a Bonded Training';
            //         Editable = InvTcode;

            //     }
            // }
        }
        area(factboxes)
        {
            systempart(Control26; Outlook)
            {
                ApplicationArea = Basic;
            }
            systempart(Control25; Notes)
            {
                ApplicationArea = Basic;
            }
            part("Attached Documents"; "Doc. Attachment List Factbox")//"Doc. Attachment List Factbox")
            {
                ApplicationArea = basic;
                Caption = 'Attachments';

            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Training Costs")
                {
                    ApplicationArea = Basic;
                    Caption = 'Training Costs';
                    Image = TaskList;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Training Cost";
                    RunPageLink = "Training ID" = FIELD(Code);
                }
                // action("Training Bonding Conditions")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Training Bonding Conditions';
                //     Image = BOM;
                //     Promoted = true;
                //     PromotedCategory = Category5;
                //     RunObject = Page "HR Training Bonding Cond. List";
                //     RunPageLink = "Training Bonding Code" = FIELD(Code);
                // }
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);

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
            }
            group(Functions)
            {
                Caption = 'Functions';
                action(Close)
                {
                    ApplicationArea = Basic;
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Confirm(Txt001, true) = false then exit;
                        Rec.Closed := true;
                    end;
                }
                action("Re-Open")
                {
                    ApplicationArea = Basic;
                    Image = OpenJournal;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Confirm(Txt002, true) = false then exit;
                        Rec.Closed := false;
                        rec.Status := rec.status::New;
                        rec.modify(true);
                    end;
                }
                action(Commentss)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    Caption = 'Comment';
                    PromotedCategory = Category4;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field(Code);
                    RunPageView = where(Types = CONST(comment));
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnInit()
    begin

    end;

    trigger OnOpenPage()
    begin
        UpdateControls;


    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."User ID" := UserId;
        usersetup.reset();
        usersetup.SetRange("User ID", UserId);
        IF usersetup.FindFirst() then begin
            rec."Global Dimension 1 Code" := usersetup."Global Dimension 1 Code";
            rec."Global Dimension 2 Code" := usersetup."Global Dimension 2 Code";
            rec."Responsibility Center" := usersetup."Responsibility Centre";



        end;
    end;

    var
        HRTrainingBondingCond: Record "HR Training Bonding Conditions";
        FieldEditable: Boolean;
        Txt001: Label 'Do you want to close this training need?';
        Txt002: Label 'Do you want to reopen this training need?';
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        HRCodeunit: Codeunit "HR Codeunit2";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExist: Boolean;
        usersetup: record "User Setup";
        InvTcode: boolean;

    procedure UpdateControls()
    begin


        if Rec.Status = Rec.Status::New then begin
            InvTcode := true;

        end;


        if Rec.Status = Rec.Status::"Pending Approval" then begin
            InvTcode := false;

        end;


        if Rec.Status = Rec.Status::Approved then begin
            InvTcode := false;

        end;


    end;

}

