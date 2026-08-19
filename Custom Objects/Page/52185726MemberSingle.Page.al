page 52185726 "Member Single"
{
    DeleteAllowed = false;

    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Information,Records Edits,Files,,EDMS,Business Loans Edits,IPRS';
    SourceTable = Members;

    layout
    {
        area(content)
        {
            // group(IPRS)
            // {
            //     Editable = false;
            //     Caption = 'IPRS Information';
            //     field("IPRS ID Type"; Rec."IPRS ID Type")
            //     {
            //         Editable = false;
            //         Caption = 'IPRS ID Type';
            //     }
            //     field("IPRS ID"; Rec."IPRS ID")
            //     {
            //         Editable = false;
            //         Caption = 'IPRS ID';
            //     }
            //     field("IPRS Full Names"; Rec."IPRS Full Names")
            //     {
            //         Editable = false;
            //         Caption = 'IPRS Full Names';
            //     }
            //     field("IPRS ID Serial No"; Rec."IPRS ID Serial No")
            //     {
            //         Editable = false;
            //         Caption = 'IPRS ID Serial No';
            //     }
            //     field("IPRS Verified"; Rec."IPRS Verified")
            //     {
            //         Editable = false;
            //         Caption = 'IPRS Verified?';
            //     }
            //     field("IPRS Verified At"; Rec."IPRS Verified At")
            //     {
            //         Editable = false;
            //         Caption = 'IPRS Verified At';
            //     }
            // }
            group(General)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("CRM Application No."; Rec."CRM Application No.")
                // {
                //     ApplicationArea = all;
                // }
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = all;
                }
                field("Old Member No."; Rec."Old Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Salutation; Rec.Salutation)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Other Names"; Rec."Other Names")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }

                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Registration Time"; Rec."Registration Time")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Rejoinig Date"; Rec."Rejoinig Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Rejoining Time"; Rec."Rejoining Time")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }

                field("ID No."; Rec."Primary Identification")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ID Number';
                    Visible = GroupAccout;
                }
                field("Primary Identification Type"; Rec."Primary Identification Type")
                {

                }
                field("Primary Identification"; Rec."Primary Identification")
                {

                }
                field("Secondary Identification Type"; Rec."Secondary Identification Type")
                {

                }
                field("Passport No."; Rec."Secondary Identification")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("P.I.N Number"; Rec."P.I.N Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Date Of birth';
                    Editable = true;
                    Visible = true;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = Basic, Suite;
                }

                // field(NotAvailable; Rec.NotAvailable)
                // {
                //     Caption = 'Alert';
                //     Style = Attention;
                //     StyleExpr = TRUE;
                // }
                // field("Branch Official"; Rec.BranchOfficial)
                // {
                // }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic, Suite;
                    ValuesAllowed = Male, Female;
                    // Visible = GroupDetailsVisible;
                }
                field(txtMarital; Rec."Marital Status")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Marital Status';
                    // Visible = GroupDetailsVisible;
                }
                field("Member Segment"; Rec."Member Segment")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("From Another Sacco"; Rec."From Another Sacco")
                {

                }
                field("Member Class"; Rec."Member Class")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Sub Class"; Rec."Sub Class")
                // {

                // }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                    // Visible = GroupAccout;
                    trigger OnValidate()
                    begin
                        Rec.TestField("Employer Code");
                    end;
                }
                field("Society Position"; Rec."Society Position")
                {
                    Editable = false;
                }
                field("Group Account No"; Rec."Group Account No.")
                {
                    Editable = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;



                    trigger OnValidate()
                    begin
                        /*StatusPermissions.RESET;
                        StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
                        StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::"9");
                        IF StatusPermissions.FIND('-') = FALSE THEN
                        ERROR('You do not have permissions to change the account status.');*/
                    end;
                }
                field(Subflag; Rec.Subflag)
                {
                    Caption = 'Sub Status';
                    ApplicationArea = Basic, Suite;

                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Account Type"; Rec."Account Type")
                {

                }
                field("Is SACCO Account"; Rec."Is SACCO Account")
                {
                    ApplicationArea = all;
                }
                field("Status Change Statistics"; Rec."Status Change Statistics")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("captured by"; Rec."captured by")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    Caption = 'Created By';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic, Suite;
                    // Caption = 'Approved and Created By';

                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Has Joined Business Loans"; Rec."Has Joined Business Loans")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Card Printing Times"; Rec."Card Printing Times.")
                {
                    Editable = false;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Branch Name"; Rec."Branch Name")
                {

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Activity Name"; Rec."Activity Name")
                { }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }

            }
            group("Communication ")
            {
                Editable = false;
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post Code/City';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Permanent Post Code"; Rec."Permanent Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    ;
                }
                field("Permanent City"; Rec."Permanent City")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Current Address"; Rec."Current Address")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Home Address"; Rec."Home Address")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Phone No."; Rec."Phone No.")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = true;
                // }
                field("Office Telephone No."; Rec."Office Telephone No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Office Telephone No.';
                    Editable = true;
                }
                field("Transactional Mobile Number"; Rec."Transactional Mobile Number")
                {

                }

                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Group Account.")
            {
                Editable = false;
                Visible = GroupDetails;

                field("Group Account No."; Rec."Group Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Company Registration No."; Rec."Company Registration No.")
                {
                    ApplicationArea = Basic, Suite;
                }

            }
            group("Other Information")
            {

                Editable = false;
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Payroll/Staff No"; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Caption = 'Company No.';
                    ShowMandatory = true;
                }
                // field("Allow Retiree M-Loans"; Rec."Allow Retiree M-Loans")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Allow retiree access to mobile loans?';
                // }
                // field("Deposit Contribution Met"; Rec."Deposit Contribution Met")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Deposit Contribution Met';
                //     ToolTip = 'Member satisfied the 3-consecutive-month deposit activity requirement.';
                //     Editable = true;
                // }

                // field("TSC Number"; Rec."TSC Number")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
                field("Contribution Effective Date"; Rec."Contribution Effective Date")
                {
                    Caption = 'Deduction Commence Date';
                }
                field("Contribution Mode"; Rec."Contribution Mode")
                { }
                // field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                // {
                //     ApplicationArea = Basic, Suite;
                //     ShowMandatory = true;
                // }
                // field("Branch Name"; Rec."Branch Name")
                // {

                // }
                // field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                // {
                //     ApplicationArea = Basic, Suite;
                //     ShowMandatory = true;
                // }
                // field("Activity Name"; Rec."Activity Name")
                // { }
                // field("Relationship Manager"; Rec."Relationship Manager")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                // }
                field("Introducer Type"; Rec."Recruited by Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Introduced By"; Rec."Recruited By")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Recruitment Location"; Rec."Recruitment Location")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Introducer's Name"; Rec."Recruited By Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Hide; Rec.Hide)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Default Account")
            {
                field("Default Product"; Rec."Default Product")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Aizma Biashara")
            {
                field("Deposit Contribution Met"; Rec."Deposit Contribution Met")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deposit Contribution Met';
                    ToolTip = 'Member satisfied the 3-consecutive-month deposit activity requirement.';
                    Editable = true;
                }
                field("Deposit Contribution Met ModBy"; Rec."Deposit Contribution Met ModBy")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deposit Contribution Met Modified By';
                    Editable = false;
                }
                field("Deposit Contribution Mod At"; Rec."Deposit Contribution Mod At")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deposit Contribution Met Modified At';
                    Editable = false;
                }
                // field("Bank Code"; Rec."Bank Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Branch Code"; Rec."Branch Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Bank Account No."; Rec."Bank Account No.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
            }
            group("Dividend Advance")
            {
                Editable = true;
                Caption = 'Mazao Loan';
                field("Block Div Advance"; Rec."Block Div Advance")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    Caption = 'Block Dividend Advance Loan';
                }
                field("Div Advance %"; Rec."Div Advance %")
                {
                }
                field("Div Advance % Modified By"; Rec."Div Advance % Modified By")
                {
                }
                field("Div Advance % Modified At"; Rec."Div Advance % Modified At")
                {
                }
            }


            // }
            // group("Business Loan Details")
            // {
            //     field("BL Global Dimension 1 Code"; Rec."BL Global Dimension 1 Code")
            //     {

            //     }
            //     field("BL Global Dimension 2 Code"; Rec."BL Global Dimension 2 Code")
            //     {

            //     }
            //     field("BL Responsibility Center"; Rec."BL Responsibility Center")
            //     {

            //     }
            //     field("BL Created By"; Rec."BL Created By")
            //     {

            //     }
            //     field("BL Registration Date"; Rec."BL Registration Date")
            //     {

            //     }
            //     field("BL Type of Business"; Rec."BL Type of Business")
            //     {

            //     }
            //     field("BL Business Location"; Rec."BL Business Location")
            //     {

            //     }
            //     field("BL Relationship Manager"; Rec."BL Relationship Manager")
            //     {

            //     }
            //     field("BL Wholesale/Retail"; Rec."BL Wholesale/Retail")
            //     {

            //     }
            //     field("BL Current Capital"; Rec."BL Current Capital")
            //     {

            //     }
            //     field("BL No. of Employees"; Rec."BL No. of Employees")
            //     {

            //     }
            //     field("BL Annual Turnover"; Rec."BL Annual Turnover")
            //     {

            //     }
            // }

        }

        area(factboxes)
        {
            part("Approved Images"; "Member Picture & Signature")
            {
                ApplicationArea = Basic;

                Caption = 'Approved Images';
                SubPageLink = "Member No" = FIELD("No.");
            }
            // part("Member FactBox"; "Member FactBox")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Member FactBox';
            //     SubPageLink = "Member No." = field("No.");
            // }
            part(Control4; "Savings Statistics")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Member No." = FIELD("No.");
                Visible = Not HideAccount;

            }
            part(LoanFactBox; "Loans Factbox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Member No." = FIELD("No.");
                Visible = Not HideAccount;
            }

        }
    }

    actions
    {
        area(creation)
        {
            action("Div Advance")
            {
                ApplicationArea = All;
                Promoted = True;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    if NOT Confirm('Do you want to block access to Dividend Advance Loan for this Member?') then
                        exit
                    else begin
                        Rec."Block Div Advance" := True;
                        Rec."Blocked By" := USERID;
                        Rec.Modify;
                    end;

                end;
            }
            separator(Action28)
            {
            }
            // action(Sendmail)
            // {
            //     ApplicationArea = all;
            //     Promoted = true;
            //     PromotedCategory = category4;
            //     trigger OnAction()
            //     var
            //         Sendmai: Codeunit EmailCodeunit;
            //     begin
            //         Sendmai.SendEmails();
            //     end;
            // }
            action(Dependancies)
            {
                Caption = 'Next Of Kin List';
                ApplicationArea = Basic, Suite;
                Image = Relationship;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Next of KIN";
                RunPageLink = "Record ID" = FIELD("No.");
                Enabled = not HideAccount;
            }
            separator(Action58)
            {
            }
            action(Nominees)
            {
                Visible = false;
                ApplicationArea = Basic, Suite;
                Caption = 'Sinkfund Members';
                Image = Relationship;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Nominee List";
                RunPageLink = "Record ID" = FIELD("No.");
                Enabled = not HideAccount;
            }
            separator(Action31)
            {
            }
            action("Picture & Signature")
            {
                ApplicationArea = Basic, Suite;
                Image = Signature;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Member Picture & Signature";
                RunPageLink = "Member No" = FIELD("No.");
                Enabled = not HideAccount;

            }
            separator(Action41)
            {
            }
            // action("Information Base")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Information Base';
            //     Image = CancelAttachment;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "Loanee Information Base";
            //     RunPageLink = "Member No." = FIELD("No.");
            //     Enabled = not HideAccount;

            // }
            // action("Member Document")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = Allocations;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     RunObject = Page "Member Documents";
            //     RunPageLink = "Reference No." = FIELD("No.");
            //     Enabled = not HideAccount;

            // }
            separator(Action78)
            {
            }
            action("Account Association")
            {
                ApplicationArea = Basic, Suite;
                Image = Vendor;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = not HideAccount;


                trigger OnAction()
                begin
                    AccountAssociations.Reset;
                    if AccountAssociations.FindLast then
                        AccountAssociations.EntyNo := EntryNo + 1;

                    AccountSignatories.Reset;
                    AccountSignatories.SetRange("ID Number", Rec."Primary Identification");
                    if AccountSignatories.Find('-') then begin
                        repeat

                            AccountAssociations.Reset;
                            AccountAssociations.SetRange("Account No.", AccountSignatories."Account No");
                            if not AccountAssociations.Find('-') then begin
                                AccountAssociations.Init;
                                AccountAssociations.EntyNo := EntryNo;
                                AccountAssociations."Member No." := Rec."No.";

                                //      AccountAssociations.Type:=AccountSignatories.Type;
                                AccountAssociations."ID No." := Rec."Primary Identification";
                                AccountAssociations.Description := 'Signatory';
                                AccountAssociations."Account No." := AccountSignatories."Account No";
                                if CustMembr.Get(AccountSignatories."Account No") then
                                    AccountAssociations."Account Name" := CustMembr.Name;
                                AccountAssociations.Insert;
                            end else begin
                                AccountAssociations.EntyNo := EntryNo;
                                AccountAssociations."Member No." := Rec."No.";

                                //AccountAssociations.Type:=AccountSignatories.Type;
                                AccountAssociations."ID No." := Rec."Primary Identification";
                                AccountAssociations.Description := 'Signatory';
                                AccountAssociations."Account No." := AccountSignatories."Account No";
                                if CustMembr.Get(AccountSignatories."Account No") then
                                    AccountAssociations."Account Name" := CustMembr.Name;
                                AccountAssociations.Modify;
                            end;
                        until AccountSignatories.Next = 0;
                    end;

                    AccountAssociations.Reset;
                    AccountAssociations.SetRange("Member No.", Rec."No.");
                    if AccountAssociations.Find('-') then
                        PAGE.Run(Page::"Account Association", AccountAssociations);
                end;
            }
            separator(Action89)
            {
            }
            // action("Social Listening Sites")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = Alerts;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     RunObject = Page "Social Listening Sites";
            //     RunPageLink = "Account No." = FIELD("No.");
            // }
            separator(Action74)
            {
            }
            action("Member Collaterals")
            {
                ApplicationArea = Basic, Suite;
                Image = AvailableToPromise;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Member Collaterals";
                RunPageLink = "Member No" = FIELD("No.");
                Visible = false;
            }
            separator(Action77)
            {
            }

            action("Check Off Advice")
            {
                ApplicationArea = Basic, Suite;
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Checkoff Advice";
                RunPageLink = "Member No." = FIELD("No.");
                Enabled = not HideAccount;

            }

            // action("Run Generated Advice")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = Installments;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     trigger OnAction()
            //     var
            //         LoansProcess: Codeunit "Loans Process";
            //         CheckOffAdviceLine: Record "Checkoff Advice Line";
            //     begin
            //         LoansProcess.TriggeredAdvice(Rec);
            //         CheckOffAdviceLine.Reset();
            //         CheckOffAdviceLine.SetRange("Member No.", Rec."No.");
            //         if CheckOffAdviceLine.Find('-') then begin
            //             Report.Run(52186856, true, false, CheckOffAdviceLine);
            //         end;
            //     end;
            // }
            // action("Trigger Advice")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = BlanketOrder;
            //     Promoted = true;
            //     PromotedCategory = Category4;

            //     trigger OnAction()
            //     var
            //         LoansProcess: Codeunit "Loans Process";
            //         TriggeredAdviceLine: Record "Triggered Advice Line";
            //     begin
            //         TriggeredAdviceLine.Reset();
            //         TriggeredAdviceLine.SetRange("Member No.", Rec."No.");
            //         if TriggeredAdviceLine.Find('-') then begin
            //             TriggeredAdviceLine.DeleteAll();
            //         end;

            //         LoansProcess.TriggeredAdvice(Rec);

            //         Message('Complete');


            //     end;
            // }

            // action("Preview Triggered Advice")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = PreviewChecks;
            //     Promoted = true;
            //     PromotedCategory = Category4;

            //     trigger OnAction()
            //     var
            //         LoansProcess: Codeunit "Loans Process";
            //         TriggeredAdviceLine: Record "Triggered Advice Line";
            //     begin

            //         TriggeredAdviceLine.Reset();
            //         TriggeredAdviceLine.SetRange("Member No.", Rec."No.");
            //         if TriggeredAdviceLine.Find('-') then
            //             Report.Run(52186194, true, false, TriggeredAdviceLine);
            //     end;
            // }
            action("Checkoff Advice Variance")
            {
                ApplicationArea = Basic, Suite;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Checkoff Advice Variance";
                Visible = false;
            }
            separator(Action92)
            {
            }
            // action("Promise Topay")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = PaymentDays;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "Promise Topay Header";
            //     RunPageLink = "Member No." = FIELD("No.");
            //     RunPageView = where("Promise Status" = const(Active));
            //     RunPageMode = View;
            //     Enabled = not HideAccount;

            // }
            // action("Prorata")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = PaymentForecast;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "Member Prorata";
            //     RunPageLink = "Member No" = FIELD("No.");
            // }
            separator(Action90)
            {
            }
            action("Dividend Instructions")
            {
                ApplicationArea = Basic, Suite;
                Image = InsertAccount;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Dividend Instructions - Member";
                RunPageLink = "Member No." = FIELD("No.");
            }
            separator(Action1300)
            {
            }
            action("Create Account")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create Account';
                Image = NewCustomer;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Create one or two accounts for this member';
                Enabled = not HideAccount;

                trigger OnAction()
                var
                    CreateAccountsReport: Report CreateAccountsProducts;
                    MemberRec: Record Members;
                begin
                    // Validate member exists
                    if not MemberRec.Get(Rec."No.") then
                        Error('Member %1 not found', Rec."No.");

                    CreateAccountsReport.SetMemberFilter(Rec."No.");
                    CreateAccountsReport.RunModal();
                end;
            }
            action("Recover Entrance Fees")
            {
                ApplicationArea = Basic, Suite;
                Image = Accounts;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = Rec.Status = Rec.Status::Active;
                trigger OnAction()
                var
                    CurrentMembers: Record Members;
                begin
                    CurrentMembers.reset;
                    CurrentMembers.setRange("No.", Rec."No.");
                    if CurrentMembers.findfirst() then
                        REPORT.Run(Report::"Recover Entrance Fee Report", true, true, CurrentMembers)
                end;
            }
            separator(Action70)
            {
            }
            action(FingerPrints)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'FingerPrints';
                Image = Filed;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin


                    FingerprintProcessingFn.RunInputFingerPrints(Rec."No.", Rec.Name, Rec."Primary Identification");
                end;
            }
            // action("Recover Loan From Deposits")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = ReceiveLoaner;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Visible = true;
            //     Enabled = false;
            //     trigger OnAction()
            //     var
            //         RecoveryLines: Record "Loan Recovery Lines";
            //         GuarantorsAttached: Boolean;
            //         FirstName: Text;
            //         PhoneNumber: Text;
            //         Loans: Record Loans;
            //         PeriodicActivities: Codeunit "Periodic Activities";
            //     begin
            //         if Confirm('Are you sure you want to recover this loan?') then begin
            //             // CheckLinesAmountAgainstLoan();
            //             // PostUpfrontInterests();
            //             // Commit();


            //             GlobalFunctions.GetMemberData(Members."No.", FirstName, PhoneNumber);
            //             PeriodicActivities.RecoverLoanFromDeposit(Rec."No.");

            //             // if Loans.Get(Rec."Loan No.") then begin
            //             //     if GuarantorsAttached then
            //             //         msg := 'Dear ' + FirstName + ' your defaulted ' + Loans."Loan Product Type Name" + ' KES ' + Format(Rec."Total Balance") + ' has been attached to your guarantors. ' + ForMoreInfo
            //             //     else
            //             //         msg := 'Dear ' + FirstName + ' your defaulted ' + Loans."Loan Product Type Name" + ' KES ' + Format(Rec."Total Balance") + ' has been attached to your deposits. ' + ForMoreInfo;
            //             // end;
            //             // SendSMS.SendSms(SMSSource::DMU, Members."Phone No.", msg, Format(Rec."No."), '', true, 0, false, 'CBS', Rec."No.", 'CBS');
            //             // Message('Process completed Successfully');
            //         end;
            //     end;
            // }
            action("Check Dividend Advance Qualification")
            {
                ApplicationArea = All, Basic, Suite;
                Caption = 'Check Dividend Advance Qualification';
                Image = Action;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    loansProcess: Codeunit "Loans Process";
                    QualifiedAmount: Decimal;
                    LoanArr: Record Loans;
                    DivloanBal: Decimal;
                    NetAmt: Decimal;
                    MemberClosure: Record "Membership Closure";
                    DivSetup: Record "Dividend SetUp";
                    DividendProgression: Record "Dividend Progression";
                    ProdFac: record "Product Factory";
                    Members: record members;
                    Arrears: Decimal;
                    DivDiscRem: Decimal;
                    LNRec: record Loans;
                    SavAcc: record "Savings Accounts";
                    NetDiv: Decimal;
                    LoanII: record Loans;
                    SASRAarr: Decimal;
                    AsAt: Date;
                begin
                    QualifiedAmount := 0;
                    DivloanBal := 0;
                    NetAmt := 0;
                    DivloanBal := 0;
                    DivDiscRem := 0;
                    Arrears := 0;

                    members.reset;
                    Members.SetRange("No.", rec."No.");
                    if Members.FindFirst() then begin
                        // Message('Member Status %1', Members.Status);
                        // Message('Member Subflag %1', Members."Subflag")


                        if Members."Block Div Advance" = true then begin
                            Message('Member Blocked div Advance Qualified= %1', QualifiedAmount);
                        end;

                        if Members."Rejoinig Date" <> 0D then begin
                            if Date2DMY(Members."Rejoinig Date", 3) = Date2DMY(Today, 3) then begin
                                MemberClosure.Reset;
                                MemberClosure.Setrange("Member No.", Members."No.");
                                MemberClosure.Setrange(Posted, true);
                                if MemberClosure.findfirst() then begin
                                    Message('You withdrew from the SACCO on %1 and rejoined the SACCO on date %2. You therefore do not qualify for Dividends Advance Loan.', MemberClosure."Closing Date", Members."Rejoinig Date");
                                end;
                            end;
                        end;

                        if Members."Closure Date" <> 0D then begin
                            if (Date2DMY(Members."Closure Date", 3) = Date2DMY(Today, 3)) OR ((Date2DMY(Members."Closure Date", 3)) = (Date2DMY(Members."Closure Date", 3) - 1))
                            then begin
                                Message('You withdrew from the SACCO On the date %1', Members."Closure Date");
                            end;
                        end;
                    end;

                    if not ProdFac.get('DAL') then begin
                        Message('The Porduct is not set up Qualified amount = %1', QualifiedAmount);
                        exit;
                    end;
                    if not DivSetup.GET then begin
                        Message('Dividend setup does not exist');
                        exit;
                    end;

                    //Check if member has withdrawn any part of deposits
                    DividendProgression.RESET;
                    DividendProgression.SETRANGE("Member No", Members."No.");
                    DividendProgression.SETRANGE("End Date", DivSetup."Discounting Start Date", DivSetup."Discounting End Date");
                    DividendProgression.SetCurrentKey("Qualifying Shares");
                    DividendProgression.SetAscending("Qualifying Shares", false);
                    DividendProgression.setrange("Product Type", '1');
                    if DividendProgression.FindFirst() then begin
                        SavAcc.reset;
                        SavAcc.setrange("Product Type", '1');
                        SavAcc.setrange("Member No.", Members."No.");
                        if SavAcc.FindFirst() then begin
                            SavAcc.CalcFields("Balance (LCY)");
                            if DividendProgression."Qualifying Shares" > SavAcc."Balance (LCY)" then
                                Message('You have partially withdrawn your deposit: Qualification = 0')
                        end;
                    end;

                    LNRec.RESET;
                    LNRec.SETRANGE(LNRec."Member No.", Members."No.");
                    LNRec.Setfilter(LNRec."Recovery Mode", '=%1', LNRec."Recovery Mode"::Dividend);
                    // LNRec.SetFilter(LNRec."Loan Product Type", '<>%1|<>%2', 'BGL', 'FGL');
                    LNRec.SETFILTER(LNRec."Outstanding Balance", '>0');

                    LNRec.SetLoadFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
                    LNRec.SetAutoCalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
                    IF LNRec.FINDSET THEN BEGIN
                        REPEAT
                            DivloanBal := DivloanBal + (LNRec."Outstanding Balance");// + LNRec."Outstanding Interest" + LNRec."Daily Interest");
                        UNTIL LNRec.NEXT = 0;
                    END;
                    Message('Existing dividend Loans = %1', DivloanBal);

                    DividendProgression.RESET;
                    DividendProgression.SETRANGE("Member No", Members."No.");
                    DividendProgression.SETRANGE("End Date", DivSetup."Discounting Start Date", DivSetup."Discounting End Date");
                    // DividendProgression.CALCSUMS("Gross Dividends", "Net Dividends");
                    DividendProgression.CALCSUMS("Net Dividends");
                    NetDiv := DividendProgression."Net Dividends";

                    Message('Net earned dividends = %1', NetDiv);

                    if Members."Div Advance %" > 0 then begin
                        Message('This member has an exceptional dividend discounting % of &%1', Members."Div Advance %");
                        DivDiscRem := (Members."Div Advance %" / 100 * DividendProgression."Net Dividends") - DivloanBal;
                        if DivDiscRem < 0 then DivDiscRem := 0;

                        Message('Dividend qualification on %1 % is %2', Members."Div Advance %", DivDiscRem);
                    end
                    else begin
                        DivDiscRem := (ProdFac."Discounting %" / 100 * DividendProgression."Net Dividends") - DivloanBal;
                        if DivDiscRem < 0 then DivDiscRem := 0;
                        Message('Dividend qualification on %1 % is %2', ProdFac."Discounting %", DivDiscRem);
                    end;
                    // if Date2DMY(Today, 1) >= 8 then
                    //     AsAt := calcdate('-CM', Today) + 6
                    // else
                    AsAt := Today;

                    LoanII.Reset();
                    LoanII.SetRange("Member No.", Members."No.");
                    LoanII.CalcFields("Total Balance");
                    LoanII.SetFilter("Total Balance", '>0');
                    if LoanII.FindSet() then begin
                        repeat
                            loansProcess.CalculateLoanArrears(LoanII, SASRAarr, SASRAarr, AsAt, true);
                        until LoanII.next = 0;
                    end;

                    // LoanII.Reset();
                    // LoanII.SetRange("Member No.", Members."No.");
                    // LoanII.SetRange("Loan Product Type", 'DAL');
                    // LoanII.setfilter("Disbursement Date", '%1..%2', calcdate('-CY', Today), Today);
                    // if not LoanII.findfirst() then begin
                    LoanArr.Reset();
                    LoanArr.setRange("Member No.", Members."No.");
                    LoanArr.SetFilter("Loan Product Type", '<>FGL&<>BGL');
                    LoanArr.CalcFields("Total Balance", "Amount In Arreas SASRA");
                    //LoanArr.CalcFields("Loans Category-SASRA");
                    //LoanArr.SetFilter("Loans Category-SASRA", '<>%1', LoanArr."Loans Category-SASRA"::Perfoming);
                    LoanArr.SetFilter("Total Balance", '>0');
                    LoanArr.setfilter("Amount In Arreas SASRA", '>0');
                    if LoanArr.findset() then begin
                        repeat
                            LoanArr.CalcFields("Amount In Arreas SASRA");
                            Arrears += LoanArr."Amount In Arreas SASRA";
                        until LoanArr.next() = 0;
                    end;
                    Message('Total Arrears %1', round(Arrears, 1, '>'));
                    // end
                    // else
                    //     Message('The member had already been deducted arrears hence current arrears to be deducted is 0.');

                    if DivDiscRem > Arrears then
                        NetAmt := Round((DivDiscRem - Arrears), 1, '>')
                    else
                        NetAmt := 0;

                    Message('Net Amount to be disbursed %1', NetAmt);

                end;


            }
            // action(VerifyPrints)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'VerifyPrints';
            //     Image = ValidateEmailLoggingSetup;
            //     Promoted = true;
            //     PromotedCategory = Process;

            //     trigger OnAction()
            //     var
            //         MyGuid: Guid;
            //     begin

            //     end;
            // }
            separator(Action69)
            {
            }
            action("Member Statistics")
            {
                ApplicationArea = Basic, Suite;
                Image = StatisticsGroup;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Member Statistics";
                RunPageLink = "No." = FIELD("No.");
                Enabled = not HideAccount;


                trigger OnAction()
                begin
                    if Rec.Hide = true then begin
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Show Hidden" = false then
                                Error('You do not have permissions to view this account information.');
                        end;
                    end;
                end;

            }
            group(Mbanking)
            {
                Caption = 'Mbanking';
                Image = CheckList;

                action("Mobile Loan Eligibility")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Check Mobile Loan Eligibility';
                    Image = CheckList;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Calculate mobile loan eligibility for this member.';

                    trigger OnAction()
                    var
                        MobileLoanEligibilityPage: Page "Mobile Loan Eligibility";
                    begin
                        MobileLoanEligibilityPage.SetMemberNo(Rec."No.");
                        MobileLoanEligibilityPage.RunModal();
                    end;
                }
                action("Blocked Loan Products")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Blocked Loan Products';
                    Image = CheckList;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'View or manage the mobile loan products this member is blocked from applying for.';

                    RunObject = Page "Mobile Loan Restrictions";
                    RunPageLink = "Member No." = FIELD("No.");
                }
            }
            action("Activate Member")
            {
                ApplicationArea = Basic, Suite;
                Image = Accounts;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = Rec.Status = Rec.Status::New;
                trigger OnAction()
                var
                    CurrentMembers: Record Members;
                begin
                    CurrentMembers.reset;
                    CurrentMembers.setRange("No.", Rec."No.");
                    if CurrentMembers.findfirst() then
                        REPORT.Run(Report::"Registration Fee Recovery", true, true, CurrentMembers)
                end;
            }

            action(Flags)
            {
                ApplicationArea = Basic, Suite;
                Image = ViewComments;
                Promoted = true;
                Caption = 'Flags';
                PromotedCategory = Category4;


                RunObject = page "Comments List";
                RunPageLink = "Header No." = field("No.");
                RunPageView = where(Types = CONST("Member Flagging"));
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

            // group("Edits Business Loans")
            // {
            //     action("BL New Edit")
            //     {
            //         Caption = 'New Edit';
            //         ApplicationArea = Basic, Suite;
            //         Image = Edit;
            //         Promoted = true;
            //         PromotedCategory = Category9;

            //         trigger OnAction()
            //         var
            //             PresentEdits: Integer;
            //         begin
            //             EditType := EditType::"Business Loan";
            //             Clear(SystemEdits);
            //             EditsHelper.Reset();
            //             EditsHelper.SetRange("Record No.", Rec."No.");
            //             EditsHelper.SetRange("Workflow Status", EditsHelper."Workflow Status"::Open);
            //             if EditsHelper.Find('-') then begin
            //                 PresentEdits := EditsHelper.Count;
            //                 if Confirm('There is another edit that exist for this member, do you still want to open a new one?') then begin
            //                     CreateNewEdit();
            //                 end else begin
            //                     if Confirm('Would you wish to have a look at the existing one(s)') then begin
            //                         if PresentEdits = 1 then begin
            //                             if SystemEdits.Get(EditsHelper."Edits Header No.") then
            //                                 Page.Run(52187317, SystemEdits);
            //                         end else begin
            //                             EditsHelper.Reset();
            //                             EditsHelper.SetRange("Record No.", Rec."No.");
            //                             if EditsHelper.Find('-') then
            //                                 Page.Run(52187316, EditsHelper);
            //                         end;
            //                     end;
            //                 end;
            //             end else
            //                 CreateNewEdit();
            //         end;
            //     }

            //     action("New Open List")
            //     {
            //         Caption = 'Open List';
            //         ApplicationArea = Basic, Suite;
            //         Image = OpenJournal;
            //         Promoted = true;
            //         PromotedCategory = Category9;

            //         // RunObject = Page "Edits Helper";
            //         // RunPageLink = "Record No." = FIELD("No.");
            //         // RunPageView = where("Workflow Status" = const(Open));

            //         trigger OnAction()
            //         var
            //             PresentEdits: Integer;
            //         begin
            //             EditType := EditType::"Business Loan";
            //             PresentEdits := 0;
            //             EditsHelper.Reset();
            //             EditsHelper.SetRange("Record No.", Rec."No.");
            //             EditsHelper.SetRange("Workflow Status", EditsHelper."Workflow Status"::Open);
            //             if EditsHelper.Find('-') then begin
            //                 PresentEdits := EditsHelper.Count;

            //                 if PresentEdits > 0 then begin
            //                     Page.Run(52187316, EditsHelper);
            //                 end;
            //             end;
            //             if PresentEdits = 0 then begin
            //                 if Confirm('There are no open edits for this member, Would you like to create one?') then begin
            //                     CreateNewEdit();
            //                 end;
            //             end;
            //         end;
            //     }
            //     action("BL Pending List")
            //     {
            //         Caption = 'Pending List';
            //         ApplicationArea = Basic, Suite;
            //         Image = Production;
            //         Promoted = true;
            //         PromotedCategory = Category9;

            //         RunObject = Page "Edits Helper";
            //         RunPageLink = "Record No." = FIELD("No.");
            //         RunPageView = where("Workflow Status" = filter(Pending | Approved), Posted = const(false));
            //     }
            //     action("BL Posted List")
            //     {
            //         Caption = 'Posted List';
            //         ApplicationArea = Basic, Suite;
            //         Image = Completed;
            //         Promoted = true;
            //         PromotedCategory = Category9;

            //         RunObject = Page "Edits Helper";
            //         RunPageLink = "Record No." = FIELD("No.");
            //         RunPageView = where(Posted = const(true));
            //     }
            //     action("BL Rejected Cases")
            //     {
            //         Caption = 'Rejected Cases';
            //         ApplicationArea = Basic, Suite;
            //         Image = Production;
            //         Promoted = true;
            //         PromotedCategory = Category9;
            //         RunObject = Page "Edits Helper";
            //         RunPageLink = "Record No." = FIELD("No.");
            //         RunPageView = where("Workflow Status" = const(Rejected), Posted = const(false));
            //     }
            // }



        }
        area(reporting)
        {
            action(Statement)
            {
                ApplicationArea = Basic, Suite;
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";
                Caption = 'Summary Statement.';
                Enabled = not HideAccount;


                trigger OnAction()
                begin
                    if Rec.Hide = true then begin
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Show Hidden" = false then
                                Error('You do not have permissions to view this account information.');
                        end;
                    end;


                    CustMembr.Reset;
                    CustMembr.SetRange(CustMembr."No.", Rec."No.");
                    if CustMembr.Find('-') then
                        REPORT.Run(Report::"Member Detailed Statement", true, false, CustMembr);
                end;
            }
            action("Loan Statement")
            {
                ApplicationArea = Basic, Suite;
                Image = CreateCreditMemo;
                Promoted = true;
                PromotedCategory = "Report";
                Enabled = not HideAccount;

                Visible = true;

                trigger OnAction()
                begin
                    if Rec.Hide = true then begin
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Show Hidden" = false then
                                Error('You do not have permissions to view this account information.');
                        end;
                    end;


                    CustMembr.Reset;
                    CustMembr.SetRange(CustMembr."No.", Rec."No.");
                    if CustMembr.Find('-') then
                        // REPORT.Run(52185767, true, false, CustMembr);
                        REPORT.Run(Report::"Member Loan Statement II", true, false, CustMembr);
                end;
            }
            action("New Member Statement")
            {
                ApplicationArea = Basic, Suite;
                Image = Customer;
                Promoted = true;
                Visible = false;
                PromotedCategory = "Report";
                Enabled = not HideAccount;


                trigger OnAction()
                begin
                    if Rec.Hide = true then begin
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Show Hidden" = false then
                                Error('You do not have permissions to view this account information.');
                        end;
                    end;

                    CustMembr.Reset;
                    CustMembr.SetRange(CustMembr."No.", Rec."No.");
                    if CustMembr.Find('-') then
                        REPORT.Run(52185928, true, false, CustMembr);
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
                Visible = false;
            }
            action("Dividend Slip")
            {
                ApplicationArea = Basic, Suite;
                Image = Database;
                Promoted = true;
                PromotedCategory = "Report";
                Visible = true;
                Enabled = not HideAccount;


                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    DividendProgression.RESET;
                    DividendProgression.SETRANGE("Member No", Rec."No.");
                    if DividendProgression.FIND('-') then begin
                        REPORT.RUN(Report::"Dividend Slip B64", TRUE, FALSE, DividendProgression);
                    end;
                end;
            }
            action("Loans Guaranteed List")
            {
                ApplicationArea = Basic, Suite;
                Image = Documents;
                Promoted = true;
                PromotedCategory = Category4;

                // RunObject = page "Loan Guarantors and Security";
                RunPageLink = "Member No" = field("No.");
                RunPageView = where("Outstanding Balance" = filter(> 0), Substituted = const(false));
                RunObject = page "Loans Guaranteed List";
                Enabled = not HideAccount;

                // RunPageMode = Create;
            }
            action("Your Loan Guarantors")
            {
                ApplicationArea = Basic, Suite;
                Image = Documents;
                Promoted = true;
                PromotedCategory = Category4;

                // RunObject = page "Loan Guarantors and Security";
                RunPageLink = "Member Guaranteed" = field("No.");
                RunPageView = where("Outstanding Balance" = filter(> 0), Substituted = const(false));
                RunObject = page "Your Loan Guarantors";
                Enabled = not HideAccount;
            }
            action("Member Active STOs")
            {
                ApplicationArea = Basic, Suite;
                Image = Documents;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = page "Standing Order List";
                RunPageView = where(Status = filter(Approved));
                RunPageLink = "Member No." = field("No.");
                Enabled = not HideAccount;
            }
            action("SMS(es) Sent to Member")
            {
                ApplicationArea = Basic, Suite;
                Image = Documents;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = page "Sky SMS Messages";
                RunPageLink = receiver = field("Phone No.");
                Enabled = not HideAccount;
            }

            // RunPageMode = Create;
            separator(Action25)
            {
            }
            action("E-Mail Statement")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'E-Mail Statement';
                Image = Email;
                Promoted = true;
                PromotedCategory = Category6;

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    CustMembr := Rec;
                    CurrPage.SetSelectionFilter(CustMembr);
                    CustMembr.EmailRecords(true);
                end;
            }
            // action("MEMBER [FILE]")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = Document;
            //     Promoted = true;
            //     PromotedCategory = Category6;

            //     trigger OnAction()
            //     var
            //         DMS: Record EDMS;
            //     begin
            //         DMS.Reset;
            //         DMS.SetRange(DMS.Key, DMS.Key::"Member File");
            //         if DMS.Find('-') then begin
            //             HyperLink(DMS."url path" + Rec."No.");
            //         end;
            //     end;
            // }
            action("Verify Application")
            {
                ApplicationArea = Basic, Suite;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category7;
                Visible = VerifyApplicationVisible;

                trigger OnAction()
                var
                    theMemberApplication: Record "Member Application";
                begin
                    if not Confirm('Are you sure you want to verify this member?') then exit;
                    Rec.Status := Rec.Status::New;
                    Rec.Subflag := Rec.Subflag::"First time";
                    Rec."M-S Verified At" := CurrentDateTime;
                    Rec."M-S Verified By" := UserId;
                    Rec.Modify();
                    Message('Record successfully verified');

                    if theMemberApplication.Get(Rec."Application No.") then begin
                        theMemberApplication.Status := theMemberApplication.Status::Approved;
                        theMemberApplication."Approved By" := UserId;
                        theMemberApplication."Date Approved" := Today;
                        theMemberApplication."Approval Time" := Time;

                        theMemberApplication.Modify();
                    end;
                end;
            }
            action("Reject Application")
            {
                ApplicationArea = Basic, Suite;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Category7;
                Visible = RejectionApplicationVisible;

                trigger OnAction()
                var
                    theMemberApplication: Record "Member Application";
                begin
                    if Rec."Rejection Reason" = '' then Error('Rejection reason must have a value');
                    if not Confirm('Are you sure you want to reject this member?') then exit;
                    Rec.Status := Rec.Status::Open;
                    Rec.Subflag := Rec.Subflag::Rejected;
                    Rec."M-S Verified At" := CurrentDateTime;
                    Rec."M-S Verified By" := UserId;
                    Rec.Modify();
                    Message('Record rejected verified');

                    if theMemberApplication.Get(Rec."Application No.") then begin
                        theMemberApplication.Status := theMemberApplication.Status::Rejected;

                        theMemberApplication.Modify();
                    end;
                end;
            }
            action("New Member Statement ")
            {
                ApplicationArea = Basic, Suite;
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";
                Visible = true;
                Caption = 'Member Detailed Statement';
                Enabled = not HideAccount;


                trigger OnAction()
                begin
                    if Rec.Hide = true then begin
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Show Hidden" = false then
                                Error('You do not have permissions to view this account information.');
                        end;
                    end;


                    GlobalFunctions.FlagAccounts(Rec."No.");
                    CustMembr.Reset;
                    CustMembr.SetRange(CustMembr."No.", Rec."No.");
                    if CustMembr.Find('-') then
                        //REPORT.Run(52186055, true, false, CustMembr);
                        REPORT.RUN(Report::"Member and loan Statement", TRUE, FALSE, CustMembr)
                end;
            }

            action("Makeup")
            {
                ApplicationArea = Basic, Suite;
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                var
                    SavingsAccounts: Record "Savings Accounts";
                begin
                    if Rec.Hide = true then begin
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Show Hidden" = false then
                                Error('You do not have permissions to view this account information.');
                        end;
                    end;

                    SavingsAccounts.Reset();
                    SavingsAccounts.SetRange("Member No.", Rec."No.");
                    if SavingsAccounts.FindFirst() then
                        REPORT.RUN(Report::"Member's Statement", TRUE, FALSE, SavingsAccounts)
                end;
            }
            action("Member Statement[ Historical ]")
            {
                ApplicationArea = Basic, Suite;
                Image = Document;
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;
                Enabled = not HideAccount;


                trigger OnAction()
                begin
                    if Rec.Hide = true then begin
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Show Hidden" = false then
                                Error('You do not have permissions to view this account information.');
                        end;
                    end;

                    CustMembr.Reset;
                    CustMembr.SetRange(CustMembr."No.", Rec."No.");
                    if CustMembr.Find('-') then
                        //REPORT.Run(52186291, true, false, CustMembr);
                        REPORT.RUN(Report::"Member Statement-H.Users", TRUE, FALSE, CustMembr);
                end;
            }

            action("Your Loan Guarantors Report")
            {
                ApplicationArea = Basic, Suite;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                Enabled = not HideAccount;

                trigger OnAction()
                var
                    LoanGuarantorsRec: Record "Credit Accounts"; // ;
                begin
                    LoanGuarantorsRec.SetRange("Member No.", Rec."No.");
                    // LoanGuarantorsRec.SetFilter("Outstanding Balance", '>0');
                    // LoanGuarantorsRec.SetRange(Substituted, false);

                    Report.RunModal(Report::"Loan Guarators Reports", true, false, LoanGuarantorsRec);
                end;

            }

            action("Loans Guaranteed Report")
            {
                ApplicationArea = Basic, Suite;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                Enabled = not HideAccount;

                trigger OnAction()
                var
                    LoanGuarantorsRec: Record Members; // ;
                begin
                    LoanGuarantorsRec.SetRange("No.", Rec."No.");
                    // LoanGuarantorsRec.SetFilter("Outstanding Balance", '>0');
                    // LoanGuarantorsRec.SetRange(Substituted, false);

                    Report.RunModal(Report::"Loan Guaranteed", true, false, LoanGuarantorsRec);
                end;

            }

            action("Member Card")
            {
                ApplicationArea = Basic, Suite;
                Image = Document;
                Promoted = true;
                PromotedCategory = "Report";
                Visible = true;

                trigger OnAction()
                begin
                    if Rec.Hide = true then begin
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Show Hidden" = false then
                                Error('You do not have permissions to view this account information.');
                        end;
                    end;

                    CustMembr.Reset;
                    CustMembr.SetRange(CustMembr."No.", Rec."No.");
                    if CustMembr.Find('-') then
                        REPORT.RUN(Report::"Member Card", TRUE, FALSE, CustMembr);
                end;
            }

            action("Loans Guaranteed")
            {
                ApplicationArea = Basic, Suite;
                Image = Document;
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;
                Enabled = not HideAccount;


                trigger OnAction()
                begin
                    if Rec.Hide = true then begin
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Show Hidden" = false then
                                Error('You do not have permissions to view this account information.');
                        end;
                    end;

                    CustMembr.Reset;
                    CustMembr.SetRange(CustMembr."No.", Rec."No.");
                    if CustMembr.Find('-') then
                        REPORT.RUN(Report::"Loan Guaranteed", TRUE, FALSE, CustMembr);
                end;
            }
            action("Loans Guarantors")
            {
                ApplicationArea = Basic, Suite;
                Image = Document;
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;
                Enabled = not HideAccount;


                trigger OnAction()
                begin
                    if Rec.Hide = true then begin
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Show Hidden" = false then
                                Error('You do not have permissions to view this account information.');
                        end;
                    end;

                    CustMembr.Reset;
                    CustMembr.SetRange(CustMembr."No.", Rec."No.");
                    if CustMembr.Find('-') then
                        REPORT.RUN(Report::"Loan Guarators Reports", TRUE, FALSE, CustMembr);
                end;
            }

            group("Certificate Management")
            {
                action(Passport)
                {
                    ApplicationArea = all;
                    Image = Certificate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Certificate Management";
                    Caption = 'Passport';
                    RunPageLink = "Record ID" = FIELD("No."), "Document Type" = filter(Passport);
                }
                action("Tax Exemption")
                {
                    ApplicationArea = all;
                    Image = Certificate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Certificate Management";
                    Caption = 'Tax Excemption';
                    RunPageLink = "Record ID" = FIELD("No."), "Document Type" = filter("Tax Exemption");
                }
                action("Contract")
                {
                    ApplicationArea = all;
                    Image = Certificate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Certificate Management";
                    Caption = 'Contract';
                    RunPageLink = "Record ID" = FIELD("No."), "Document Type" = filter("Contract");
                }
                action("Member Sub-Status Log")
                {
                    ApplicationArea = all;
                    Image = Certificate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Member Sub-Status Tracker";
                    Caption = 'Member Sub-Flag Logs';
                    RunPageLink = "Member No." = field("No.");
                }
            }

            // group("EDMS Integration")
            // {
            //     Visible = ShowEDMS;
            //     action("Import")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Import File';
            //         Promoted = true;
            //         PromotedCategory = Category8;
            //         Image = Import;

            //         trigger OnAction()
            //         var
            //             Base64Convert: Codeunit "Base64 Convert";
            //             TempBlob: Codeunit "Temp Blob";
            //             InStr: InStream;

            //             EDMSFunctions: Codeunit "EDMS Functions";
            //             FileName: Text;
            //             FileContentsB64: Text;

            //             IDNumber: Text;
            //             ApplicationType: Label 'MA'; // Member Application
            //             PFNumber: Text;
            //         begin
            //             if Rec."Application No." <> '' then begin
            //                 FileName := EDMSFunctions.PickEDMSFile(TempBlob);

            //                 TempBlob.CreateInStream(InStr);
            //                 FileContentsB64 := Base64Convert.ToBase64(InStr);

            //                 if FileContentsB64 <> '' then begin
            //                     UploadToEDMS(Rec, FileName, FileContentsB64);
            //                 end;
            //             end else begin
            //                 Error('Application No. is required for EDMS document upload');
            //             end;
            //         end;
            //     }
            //     action("EDMS File List")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = Documents;
            //         Promoted = true;
            //         PromotedCategory = Category8;

            //         RunObject = page "EDMS Files List";
            //         RunPageLink = "Application No." = field("Application No.");
            //         // RunPageMode = Create;
            //     }
            // }
            // group("IPRS Integration")
            // {
            //     action("IPRS File List")
            //     {
            //         Caption = 'IPRS Verification';
            //         ApplicationArea = Basic, Suite;
            //         Image = UserSetup;
            //         Promoted = true;
            //         PromotedCategory = Category10;

            //         trigger OnAction()
            //         var
            //             IPRS: Codeunit "IPRS Integration";
            //         begin
            //             if Rec."IPRS Verified" then begin
            //                 // Ask user to confirm re-verification
            //                 // Confirm user is aware of charges
            //                 if Confirm('This member is already verified with IPRS. Do you wish to proceed with the IPRS verification of this member again? Standard charges apply') then begin
            //                     IPRS.ValidateMember(Rec);
            //                 end;
            //             end else begin
            //                 // Confirm user is aware of charges
            //                 if Confirm('Do you wish to proceed with the IPRS verification of this member? Standard charges apply') then begin
            //                     IPRS.ValidateMember(Rec);
            //                 end;
            //             end;
            //         end;
            //     }
            // }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //*
        "BranchOfficial??";
        lblIDVisible := true;
        lblDOBVisible := true;
        lblRegNoVisible := false;
        lblRegDateVisible := false;
        lblGenderVisible := true;
        txtGenderVisible := true;
        lblMaritalVisible := true;
        txtMaritalVisible := true;

        if Rec."Account Category" <> Rec."Account Category"::" " then begin
            lblIDVisible := false;
            lblDOBVisible := false;
            lblRegNoVisible := true;
            lblRegDateVisible := true;
            lblGenderVisible := false;
            txtGenderVisible := false;
            lblMaritalVisible := false;
            txtMaritalVisible := false;
        end;

        if Rec."Global Dimension 1 Code" <> 'MICRO' then begin
            GroupDetailsVisible := false;
            txtMaritalVisible := false;
        end else begin
            GroupDetailsVisible := true;
        end;

        //--...Missing Data
        NotAvailable := NotAvailableData(Rec);
    end;



    trigger OnInit()
    begin
        //*
        txtMaritalVisible := true;
        lblMaritalVisible := true;
        txtGenderVisible := true;
        lblGenderVisible := true;
        lblRegDateVisible := true;
        lblRegNoVisible := true;
        lblDOBVisible := true;
        lblIDVisible := true;

    end;

    trigger OnOpenPage()
    var
        GlobalFunctions: Codeunit "Global Functions";
    begin
        if (Rec.Age = 0) and (Rec."Date of Birth" <> 0D) then begin
            Rec.Age := Round(((Today - Rec."Date of Birth") / 365), 1, '<');
            Rec.Modify();
        end;
        GlobalFunctions.FlagAccounts(Rec."No.");
        GlobalFunctions.DisplayLienMessage(Rec."No.");
        //*check if delegate
        "BranchOfficial??";


        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup."Show Hidden" then begin
                // Full access — Show Hidden overrides everything, including High Profile/PEP
            end else begin
                if UserSetup."Member No." <> '' then begin
                    // Self-service member — always allowed to view own record, even if High Profile/PEP
                    if Rec."No." <> UserSetup."Member No." then
                        Error('You are only allowed to view your own account.');
                end else begin
                    // Staff without Show Hidden — blocked from High Profile/PEP accounts
                    if (Rec."Account Profile" = Rec."Account Profile"::"High Profile") or (Rec."Account Profile" = Rec."Account Profile"::"Politically Exposed") then
                        Error('You are not allowed to view this account');
                end;
            end;
        end else
            Error('You are not set up in user setup');
        GroupControls;
        AccountAccessLogging;
        CheckMemberInfomation;

        if Rec."Application No." <> '' then begin
            ShowEDMS := true;
        end else begin
            ShowEDMS := false;
        end;

        HideAccount := GlobalFunctions.HideAccount(Rec."No.");
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
        if Rec."Member Class" = 'B' then begin
            CheckoffEntries.Reset();
            CheckoffEntries.SetRange("Member No.", Rec."No.");
            if CheckoffEntries.Find('-') then begin
                Rec."Member Class" := 'A';
                Rec.Modify;
            end;
        end;
    end;

    var
        ShowEDMS: Boolean;
        lblIDVisible: Boolean;

        lblDOBVisible: Boolean;

        lblRegNoVisible: Boolean;

        lblRegDateVisible: Boolean;

        lblGenderVisible: Boolean;

        txtGenderVisible: Boolean;

        lblMaritalVisible: Boolean;

        txtMaritalVisible: Boolean;
        VerifyApplicationVisible: Boolean;
        RejectionApplicationVisible: Boolean;
        AccNo: Code[20];
        GenledSetup: Record "General Set-Up";
        GroupAccout: Boolean;
        GroupDetails: Boolean;
        GroupDetailsVisible: Boolean;
        CustMembr: Record Members;
        FingerprintProcessingFn: Codeunit "Fingerprint Processing Fn";
        UserSetup: Record "User Setup";
        AccountSignatories: Record "Account Signatories";
        Customer: Record Customer;
        Vendor: Record Vendor;
        AccountAssociations: Record "Account Associations";
        EntryNo: Integer;
        BranchOfficial: Text[100];
        DelegateMembers: Record "Delegate Members";
        NotAvailable: Text;

        SystemEdits: Record "System Edits";
        SystemEditsFilters: Record "System Edits Filters";
        Members: Record Members;
        RecRef: RecordRef;
        EditsHelper: Record "Edits Helper";
        SystemEditsCodeunit: Codeunit "System Editss";
        Action: Option SetFilter,PostChanges;
        CheckoffEntries: Record "Checkoff Lines";
        GlobalFunctions: Codeunit "Global Functions";
        DividendProgression: Record "Dividend Progression";
        HideAccount: Boolean;
        EditType: Option " ","Business Loan","Records";

    local procedure GroupControls()
    begin
        // if Rec."Group Type" <> Rec."Group Type"::" " then begin
        //     GroupAccout := false;
        //     GroupDetails := true;
        // end else begin
        //     GroupAccout := true;
        //     GroupDetails := false;
        // end;
    end;

    //[Scope('OnPrem')]
    procedure "BranchOfficial??"()
    begin
        DelegateMembers.Reset;
        DelegateMembers.SetRange(DelegateMembers."Delegate MNO.", Rec."No.");
        DelegateMembers.SetRange(DelegateMembers.Retired, false);
        if DelegateMembers.Find('-') then begin
            BranchOfficial := 'Yes';
        end;
    end;

    //[Scope('OnPrem')]
    procedure AccountAccessLogging()
    var
        AccountAccessLog: Record "Account Access Log";
    begin
        AccountAccessLog.Init;
        AccountAccessLog.Source := AccountAccessLog.Source::Member;
        AccountAccessLog."Account No." := Rec."No.";
        AccountAccessLog.Date := Today;
        AccountAccessLog."Info Source" := AccountAccessLog."Info Source"::"Member Card";
        AccountAccessLog.Time := Time;
        AccountAccessLog."User Id" := UserId;
        AccountAccessLog."Account Status" := Format(Rec.Status);
        AccountAccessLog.Insert(true);
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

    local procedure NotAvailableData(Members: Record Members) Str: Text[250]
    var
        ImageData: Record "Image Data";
        NextofKIN: Record "Next of KIN";
    begin
        //Check Condation available

        NextofKIN.Reset;
        NextofKIN.SetRange("Record ID", Members."No.");
        if not NextofKIN.Find('-') then begin
            Str := 'KIN/'
        end;

        // ImageData.Reset;
        // ImageData.SetRange("Member No", Members."No.");
        // if ImageData.Find('-') then begin
        //     ImageData.CalcFields(Picture, Signature);
        //     if (ImageData.Picture.HasValue = false) or (ImageData.Signature.HasValue = false) then begin
        //         Str := Str + 'Picture and Signature/'
        //     end;
        // end;


        if Members."Date of Birth" = 0D then begin
            Str := Str + 'Date of Birth/';
        end;

        if Members."Phone No." = '' then begin
            Str := Str + 'Phone No./'
        end;

        if Members."E-Mail" = '' then begin
            Str := Str + 'E-mail'
        end;
    end;

    procedure UploadToEDMS(Rec: Record Members; FileName: Text; FileContentsB64: Text)
    var
        EDMSFunctions: Codeunit "EDMS Functions";

        IDNumber: Text;
        ApplicationType: Label 'MA'; // Member Application
        PFNumber: Text;
    begin
        if Rec."Primary Identification Type" = Rec."Primary Identification Type"::"ID Number" then begin
            IDNumber := Rec."Primary Identification";
        end else
            if Rec."Secondary Identification Type" = Rec."Secondary Identification Type"::"ID Number" then begin
                IDNumber := Rec."Secondary Identification";
            end else begin
                IDNumber := Rec."Primary Identification";
            end;

        if Rec."Payroll/Staff No." <> '' then begin
            PFNumber := Rec."Payroll/Staff No.";
        end else begin
            PFNumber := Rec."No.";
        end;

        EDMSFunctions.EDMSMemberFileUpload(
            IDNumber,
            Rec.Name,
            ApplicationType,
            PfNumber,
            Rec."No.",
            Rec."Application No.",
            FileName,
            FileContentsB64
        );
    end;
}

