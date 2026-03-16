page 52186366 "Micro Member  List"
{
    CardPageID = "Member Single";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Members;
    SourceTableView = WHERE("Account Type" = filter(<>"Single Member Account"));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

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
                field(Salutation; Rec.Salutation)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Second Name"; Rec."Middle Name")
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
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
               
                field("Primary Identification";Rec."Primary Identification")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Secondary Identification";Rec."Secondary Identification")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                
                
                field("Old Member No."; Rec."Old Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
              
                field("Group Account No."; Rec."Group Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
              
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Registration Date"; Rec."Registration Date")
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
            action("Social Listening Sites")
            {
                ApplicationArea = Basic, Suite;
                Image = Alerts;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Social Listening Sites";
                RunPageLink = "Account No." = FIELD("No.");
            }
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
                    //REPORT.Run(52185692, true, false, CustMembr);
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
                    //if CustMembr.Find('-') then
                    //REPORT.Run(52186055, true, false, CustMembr);
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
                    //if CustMembr.Find('-') then
                    //REPORT.Run(52186291, true, false, CustMembr);
                end;
            }
        }
    }

    var
        UserSetup: Record "User Setup";
        CustMembr: Record Members;
}

