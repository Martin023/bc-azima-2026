page 52185728 "Member Group"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Information,Group Edits, ,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Members;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Membership Date';
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("P.I.N Number"; Rec."P.I.N Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Company Registration No."; Rec."Company Registration No.")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        AccoutTypeControl;
                    end;
                }

                field("Account Type"; Rec."Account Type")
                {

                }
                field("Group Type"; Rec."Group Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {

                }


                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Status Change Statistics"; Rec."Status Change Statistics")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Allocated Officer"; Rec."Allocated Officer")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Recruited By"; Rec."Recruited By")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Recruited By';
                }
            }
            group(Multiple)
            {
                Visible = MultipleEdit;

                field("Group Registration No."; Rec."Company Registration No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Group Registration No.';
                }

            }
            group(Business)
            {
                Visible = BusinessEdit;

                field("Business Registration No."; Rec."Company Registration No.")
                {
                    ApplicationArea = Basic, Suite;
                }

            }
            group("Communication Details")
            {
                field("Office Telephone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Office Telephone No.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Current Address"; Rec."Current Address")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P.O. BOX';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'City';
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
            }
            group("Bank Details")
            {
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Group Members")
            {
                ApplicationArea = Basic, Suite;
                Image = Signature;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Signatories List";
                RunPageLink = "Account No" = FIELD("No.");
                RunPageMode = View;

            }
            // action("Group Members Report")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = Relatives;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     PromotedIsBig = true;

            //     trigger OnAction()
            //     begin
            //         AccountSignatories.Reset;
            //         AccountSignatories.SetRange(AccountSignatories."Account No", Rec."No.");
            //         //if AccountSignatories.Find('-') then
            //         //REPORT.Run(52186379, true, false, AccountSignatories);
            //     end;
            // }
            // action("Member Document")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = Allocations;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     RunObject = Page "PrCasual Payroll Setup";
            //     //RunPageLink = Field6 = FIELD("No.");
            // }

            // action("Social Listening Sites")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = Alerts;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     RunObject = Page "Social Listening Sites";
            //     RunPageLink = "Account No." = FIELD("No.");
            // }

            // action("Member Collaterals")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = AvailableToPromise;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "Member Collaterals";
            //     RunPageLink = "Member No" = FIELD("No.");
            //     Visible = false;
            // }

            action("Dividend Instructions")
            {
                ApplicationArea = Basic, Suite;
                Image = InsertAccount;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Dividend Instructions - Member";
                RunPageLink = "Member No." = FIELD("No.");
            }
            action("Member Statistics")
            {
                ApplicationArea = Basic, Suite;
                Image = StatisticsGroup;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Member Statistics";
                RunPageLink = "No." = FIELD("No.");
            }

            group("Edits Records")
            {
                action("New Edit")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Edit;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        PresentEdits: Integer;
                    begin
                        EditType := EditType::Records;
                        Clear(SystemEdits);
                        EditsHelper.Reset();
                        EditsHelper.SetRange("Record No.", Rec."No.");
                        EditsHelper.SetRange("Workflow Status", EditsHelper."Workflow Status"::Open);
                        if EditsHelper.Find('-') then begin
                            PresentEdits := EditsHelper.Count;
                            if Confirm('There is another edit that exist for this member, do you still want to open a new one?') then begin
                                CreateNewEdit();
                            end else begin
                                if Confirm('Would you wish to have a look at the existing one(s)') then begin
                                    if PresentEdits = 1 then begin
                                        if SystemEdits.Get(EditsHelper."Edits Header No.") then
                                            Page.Run(52187317, SystemEdits);
                                    end else begin
                                        EditsHelper.Reset();
                                        EditsHelper.SetRange("Record No.", Rec."No.");
                                        if EditsHelper.Find('-') then
                                            Page.Run(52187316, EditsHelper);
                                    end;
                                end;
                            end;
                        end else
                            CreateNewEdit();
                    end;
                }

                action("Open List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = OpenJournal;
                    Promoted = true;
                    PromotedCategory = Category5;

                    // RunObject = Page "Edits Helper";
                    // RunPageLink = "Record No." = FIELD("No.");
                    // RunPageView = where("Workflow Status" = const(Open));

                    trigger OnAction()
                    var
                        PresentEdits: Integer;
                    begin
                        EditType := EditType::Records;
                        PresentEdits := 0;
                        EditsHelper.Reset();
                        EditsHelper.SetRange("Record No.", Rec."No.");
                        EditsHelper.SetRange("Workflow Status", EditsHelper."Workflow Status"::Open);
                        if EditsHelper.Find('-') then begin
                            PresentEdits := EditsHelper.Count;

                            if PresentEdits > 0 then begin
                                Page.Run(52187316, EditsHelper);
                            end;
                        end;
                        if PresentEdits = 0 then begin
                            if Confirm('There are no open edits for this member, Would you like to create one?') then begin
                                CreateNewEdit();
                            end;
                        end;
                    end;
                }
                action("Pending List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Production;
                    Promoted = true;
                    PromotedCategory = Category5;

                    RunObject = Page "Edits Helper";
                    RunPageLink = "Record No." = FIELD("No.");
                    RunPageView = where("Workflow Status" = filter(Pending | Approved), Posted = const(false));
                }
                action("Posted List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Completed;
                    Promoted = true;
                    PromotedCategory = Category5;

                    RunObject = Page "Edits Helper";
                    RunPageLink = "Record No." = FIELD("No.");
                    RunPageView = where(Posted = const(true));
                }
                action("Rejected Cases")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Production;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Edits Helper";
                    RunPageLink = "Record No." = FIELD("No.");
                    RunPageView = where("Workflow Status" = const(Rejected), Posted = const(false));
                }
            }
        }
        area(reporting)
        {
            action(Statement)
            {
                ApplicationArea = Basic, Suite;
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";
                Caption = 'Member Detailed Statemnet';

                trigger OnAction()
                begin
                    CustMembr.Reset;
                    CustMembr.SetRange(CustMembr."No.", Rec."No.");
                    if CustMembr.Find('-') then
                        //REPORT.Run(52186055, true, false, CustMembr);
                        REPORT.RUN(Report::"Member and loan Statement", TRUE, FALSE, CustMembr)
                end;
            }
            separator(Action66)
            {
            }
            action("Dividend Deduction")
            {
                ApplicationArea = Basic, Suite;
                Image = Database;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Page "Dividend Posting Buffer";
                RunPageLink = "Member No." = FIELD("No.");
            }
            separator(Action25)
            {
            }
            action("E-Mail Statement")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&E-Mail Statement';
                Image = Email;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    CustMembr := Rec;
                    CurrPage.SetSelectionFilter(CustMembr);
                    CustMembr.EmailRecords(true);
                end;
            }
            action("MEMBER [FILE]")
            {
                ApplicationArea = Basic, Suite;
                Image = Document;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    DMS: Record EDMS;
                begin
                    DMS.Reset;
                    DMS.SetRange(DMS.Key, DMS.Key::"Member File");
                    if DMS.Find('-') then begin
                        HyperLink(DMS."url path" + Rec."No.");
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        AccoutTypeControl;
    end;

    trigger OnOpenPage()
    begin
        AccoutTypeControl;
    end;

    procedure CreateNewEdit()
    begin
        SystemEdits.Init();
        SystemEdits."Table ID" := 52185700;
        if SystemEdits.Insert(true) then begin
            RecRef.Open(52185700);
            SystemEditsFilters.Init();
            SystemEditsFilters."Record ID" := SystemEdits."No.";
            SystemEditsFilters."Field ID" := 1;
            SystemEditsFilters."Field Name" := RecRef.Field(1).Name;
            SystemEditsFilters.Filter := Rec."No.";
            SystemEditsFilters.Insert();

            EditsHelper.Init();
            EditsHelper."Record No." := Rec."No.";
            EditsHelper."Edits Header No." := SystemEdits."No.";
            EditsHelper."Edit Type" := EditType;
            EditsHelper.Insert();

            Rec."Marked For Edits" := true;
            Rec.Modify();

            SystemEditsCodeunit.SetFilterFields(52185700, SystemEdits."No.", Action::SetFilter, RecRef, RecRef);

            Page.Run(52187317, SystemEdits);
        end;
    end;

    var

        lblIDVisible: Boolean;

        lblDOBVisible: Boolean;

        lblRegNoVisible: Boolean;

        lblRegDateVisible: Boolean;

        lblGenderVisible: Boolean;

        txtGenderVisible: Boolean;

        lblMaritalVisible: Boolean;

        txtMaritalVisible: Boolean;
        AccNo: Code[20];
        GenledSetup: Record "General Set-Up";
        GroupAccout: Boolean;
        GroupDetails: Boolean;
        GroupDetailsVisible: Boolean;
        CustMembr: Record Members;
        FingerprintProcessingFn: Codeunit "Fingerprint Processing Fn";
        MultipleEdit: Boolean;
        BusinessEdit: Boolean;
        AccountSignatories: Record "Account Signatories";
        EditsHelper: Record "Edits Helper";
        SystemEditsCodeunit: Codeunit "System Editss";
        Action: Option SetFilter,PostChanges;
        CheckoffEntries: Record "Checkoff Lines";
        GlobalFunctions: Codeunit "Global Functions";
        DividendProgression: Record "Dividend Progression";
        HideAccount: Boolean;
        EditType: Option " ","Business Loan","Records";

        RecRef: RecordRef;

        SystemEdits: Record "System Edits";
        SystemEditsFilters: Record "System Edits Filters";

    //[Scope('OnPrem')]
    procedure AccoutTypeControl()
    begin
        // case Rec."Single Party/Multiple" of
        //     Rec."Single Party/Multiple"::Multiple:
        //         begin
        //             MultipleEdit := true;
        //             BusinessEdit := false;
        //         end;

        //     Rec."Single Party/Multiple"::Business:
        //         begin
        //             BusinessEdit := true;
        //             MultipleEdit := false;
        //         end;

        // end;
    end;
}

