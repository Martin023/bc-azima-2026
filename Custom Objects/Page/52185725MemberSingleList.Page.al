page 52185725 "Member Single List"
{
    Caption = 'Member Single List';
    CardPageID = "Member Single";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Members;
    SourceTableView = WHERE("Account Type" = const("Single Member Account"));
    UsageCategory = Lists;
    ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Reports,Information, ,Category7_caption,Category8_caption,Category9_caption,Category10_caption';


    layout
    {
        area(content)
        {
            repeater(Control13)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Old Member No."; Rec."Old Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field(Salutation; Rec.Salutation)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Other Names"; Rec."Other Names")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("P.I.N Number"; Rec."P.I.N Number")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Subflag; Rec.Subflag)
                {
                    Caption = 'Sub Status';
                    ApplicationArea = Basic, Suite;
                }
                // field("Primary Identification Type"; Rec."Primary Identification Type")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Primary Identification"; Rec."Primary Identification")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Secondary Identification Type"; Rec."Secondary Identification Type")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Secondary Identification"; Rec."Secondary Identification")
                // {
                //     ApplicationArea = Basic, Suite;
                // }

                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Employer Name"; Rec."Employer Name")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
                // field("Recruited By"; Rec."Recruited By")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Recruited By';
                // }
                // field("Recruited by Type"; Rec."Recruited by Type")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Group Account No."; Rec."Group Account No.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Rejoining Date"; Rec."Rejoinig Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Rejoining Date';
                }
                field("Member Class"; Rec."Member Class")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Request for ATM"; Rec."Request for ATM")
                {
                    ApplicationArea = all;
                }
                field("Request Mobile Banking"; Rec."Request Mobile Banking")
                {
                    ApplicationArea = all;
                }
                field("BOSA Deposit"; Rec."BOSA Deposit")
                {
                    ApplicationArea = all;
                }
                // field("Old Account Name"; Rec."Old Account Name")
                // {
                //     ApplicationArea = All;
                // }
                // field("Witness ID No."; Rec."Witness ID No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Witness Name"; Rec."Witness Name")
                // {
                //     ApplicationArea = all;
                // }
                // field("2ND Witness ID No."; Rec."2nd Witness ID No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("2ND Witness Name"; Rec."2nd Witness Name")
                // {
                //     ApplicationArea = all;
                // }
                // field(DigitCustodian; MembList.GetDigitCustodian(Rec."No."))
                // {
                //     Caption = 'Digit Custodian';
                //     Editable = false;
                // }

            }
        }
    }

    actions
    {
        area(creation)
        {
            separator(Action56)
            {
            }
            action("Next of KIN")
            {
                ApplicationArea = Basic, Suite;
                Image = Relationship;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Next of KIN";
                RunPageLink = "Record ID" = FIELD("No.");
            }
            separator(Action54)
            {
            }
            action("Family Member")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sinkfund Members';
                Image = Relationship;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Nominee List";
                RunPageLink = "Record ID" = FIELD("No.");
            }
            separator(Action52)
            {
            }
            action("Import Picure")
            {
                ApplicationArea = Basic, Suite;
                Image = Picture;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    RegistrationProcess: Codeunit "Registration Process";
                    Type: Option "Picture","Signature";
                begin
                    RegistrationProcess.ImportMemberPictures(Type::Picture);
                end;
            }
            action("Import Signature")
            {
                ApplicationArea = Basic, Suite;
                Image = Picture;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    RegistrationProcess: Codeunit "Registration Process";
                    Type: Option "Picture","Signature";
                begin
                    RegistrationProcess.ImportMemberPictures(Type::Signature);
                end;
            }
            action("Picture & Signature")
            {
                ApplicationArea = Basic, Suite;
                Image = Signature;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Member Picture & Signature";
                RunPageLink = "Member No" = FIELD("No.");
            }
            separator(Action50)
            {
            }
            action("Member Document")
            {
                ApplicationArea = Basic, Suite;
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Member Documents";
                RunPageLink = "Reference No." = FIELD("No.");
            }
            separator(Action48)
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
            separator(Action44)
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
            separator(Action42)
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
            }
            separator(Action40)
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
        }
        area(reporting)
        {
            action(Statement)
            {
                ApplicationArea = Basic, Suite;
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";

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
                    //if CustMembr.Find('-') then
                    //REPORT.Run(52185621, true, false, CustMembr);
                end;
            }
            separator(Action27)
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
            separator(Action26)
            {
            }
            action("E-Mail Statement")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'E-Mail Statement';
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
            action("New Member Statement ")
            {
                ApplicationArea = Basic, Suite;
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";

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
            action("Member Statement[ Historical ]")
            {
                ApplicationArea = Basic, Suite;
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";

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
                        REPORT.Run(52185903, true, false, CustMembr);
                end;
            }
            action("Determine TAT")
            {
                ApplicationArea = Basic, Suite;
                Image = Turnover;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    MemberApplication: Record "Member Application";
                    GlobalFunctions: Codeunit "Global Functions";
                    Days: Integer;
                    Hours: Integer;
                    Minutes: Integer;
                    WorkedOnNonWorkingPeriod: Boolean;
                    Duration: Duration;
                begin
                    MemberApplication.Reset();
                    MemberApplication.SetRange("Primary Identification", Rec."Primary Identification");
                    if MemberApplication.FindFirst() then begin
                        repeat
                            if MemberApplication."Type of Application" = MemberApplication."Type of Application"::Readmission then begin
                                GlobalFunctions.HoursBetweenPeriods(MemberApplication."Application Date", MemberApplication."Application Time",
                                Rec."Rejoinig Date", Rec."Rejoining Time", Duration, WorkedOnNonWorkingPeriod);
                            end;
                            if MemberApplication."Type of Application" = MemberApplication."Type of Application"::"New Registration" then begin
                                GlobalFunctions.HoursBetweenPeriods(MemberApplication."Application Date", MemberApplication."Application Time",
                                                                Rec."Registration Date", Rec."Registration Time", Duration, WorkedOnNonWorkingPeriod);
                            end;
                            Message(Format(Duration));
                        until MemberApplication.Next() = 0;
                    end else
                        Message('This member was not created in BC');
                end;
            }

            action("Update Insiders Data")
            {
                ApplicationArea = Basic, Suite;
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    GlobalFunctions: Codeunit "Global Functions";

                begin
                    GlobalFunctions.UpdateInsiders();
                end;
            }

            action("Update Image Data")
            {
                ApplicationArea = Basic, Suite;
                Image = ImportDatabase;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    LoanApp: Record Loans;
                    LoanProcess: Codeunit "Loans Process";
                    intProgressTotal: Integer;
                    intProgressI: Integer;
                    TimeProgress: TIME;
                    NoOfRecsProgress: Decimal;
                    NoOfProgressed: Integer;
                    Generating: Label 'Processing ...';
                    diaProgress: Dialog;
                    intProgress: Integer;
                    ImageData: Record "Image Data";
                    Members: Record Members;
                begin
                    Members.Reset();
                    if Members.Find('-') then begin

                        intProgressTotal := Members.COUNT;

                        intProgressI := 0;
                        TimeProgress := TIME;
                        NoOfRecsProgress := intProgressTotal DIV 100;
                        NoOfProgressed := 0;

                        diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
                        repeat
                            ImageData.Reset();
                            ImageData.SetRange("Member No", Members."No.");
                            if not ImageData.FindFirst() then begin
                                ImageData.Init();
                                ImageData."Member No" := Members."No.";
                                ImageData."ID Number" := Members."Primary Identification";
                                ImageData.Insert();
                            end;

                            intProgressI += 1;

                            IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                                NoOfProgressed := NoOfProgressed + intProgressI;
                                diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                                intProgressI := 0;
                                TimeProgress := TIME;
                            END;
                        until Members.Next() = 0;
                        diaProgress.Close();
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
    begin
        // HideAccount := GlobalFunctions.HideAccount(Rec."No.");

        // if HideAccount then begin
        //     Rec.SetFilter("Account Profile", '<>%1', Rec."Account Profile"::"Normal Member");

        // end;
    end;



    var
        UserSetup: Record "User Setup";
        CustMembr: Record Members;
        HideAccount: Boolean;
        GlobalFunctions: Codeunit "Global Functions";

        MembList: page "Member List";
}

