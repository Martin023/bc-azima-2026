page 52185727 "Member Group List"
{
    CardPageID = "Member Group";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Members;
    SourceTableView = WHERE("Account Type" = filter("Group Account"));
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
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Other Names"; Rec."Other Names")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Company Registration No."; Rec."Company Registration No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Passport No."; Rec."Secondary Identification")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }

                // field("Employer Code"; Rec."Employer Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Old Member No."; Rec."Old Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Group Account No."; GroupSavingsAccNo)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Group Savings Account Status"; GroupSavingsAccStatus)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Group Savings Account Status';
                }
                field("Group Savings Account Balance"; Rec."Group Savings Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Group Savings Account Balance';
                }

                field("FOSA Account"; Rec."FOSA Account")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ODS Account No.';
                }
                field("FOSA Account Status"; Rec."FOSA Account Status")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ODS Account Status';
                }
                field("FOSA Savings"; Rec."FOSA Savings")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ODS Account Balance';
                }
                field("Deposit Account No."; BOSAAccNo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deposit Account No.';
                }
                field("Deposit Account Status"; BOSAAccStatus)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deposit Account Status';
                }
                field("Deposit Account Balance"; Rec."BOSA Deposit")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deposit Account Balance';
                }
                field("Share Capital Account No."; ShareCapitalAccNo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Share Capital Account No.';
                }
                field("Share Capital Account Status"; ShareCapitalAccStatus)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Share Capital Account Status';
                }
                field("Share Capital Account Balance"; Rec."Share Capital")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Share Capital Account Balance';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        SavingsAccount.Reset();
        SavingsAccount.SetRange("Member No.", Rec."No.");
        SavingsAccount.SetLoadFields("Product Category", "Balance (LCY)", Status);
        if SavingsAccount.Find('-') then begin

            BOSAAccNo := '';
            FOSAAccNo := '';
            ShareCapitalAccNo := '';
            GroupSavingsAccNo := '';
            BOSAAccStatus := SavingsAccount.Status::" ";
            FOSAAccStatus := SavingsAccount.Status::" ";
            ShareCapitalAccStatus := SavingsAccount.Status::" ";
            GroupSavingsAccStatus := SavingsAccount.Status::" ";

            if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"BOSA Deposits" then begin
                BOSAAccNo := SavingsAccount."No.";
                BOSAAccStatus := SavingsAccount.Status;
            end;
            if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"FOSA Account" then begin
                FOSAAccNo := SavingsAccount."No.";
                FOSAAccStatus := SavingsAccount.Status;
            end;
            if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Share Capital" then begin
                ShareCapitalAccNo := SavingsAccount."No.";
                ShareCapitalAccStatus := SavingsAccount.Status;
            end;
            if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Chama Investment Account" then begin
                GroupSavingsAccNo := SavingsAccount."No.";
                GroupSavingsAccStatus := SavingsAccount.Status;
            end;
        end;

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SavingsAccount.Reset();
        SavingsAccount.SetRange("Member No.", Rec."No.");
        SavingsAccount.SetLoadFields("Product Category", "Balance (LCY)", Status);
        if SavingsAccount.Find('-') then begin


            BOSAAccNo := '';
            FOSAAccNo := '';
            ShareCapitalAccNo := '';
            GroupSavingsAccNo := '';
            BOSAAccStatus := SavingsAccount.Status::" ";
            FOSAAccStatus := SavingsAccount.Status::" ";
            ShareCapitalAccStatus := SavingsAccount.Status::" ";
            GroupSavingsAccStatus := SavingsAccount.Status::" ";

            if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"BOSA Deposits" then begin
                BOSAAccNo := SavingsAccount."No.";
                BOSAAccStatus := SavingsAccount.Status;
            end;
            if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"FOSA Account" then begin
                FOSAAccNo := SavingsAccount."No.";
                FOSAAccStatus := SavingsAccount.Status;
            end;
            if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Share Capital" then begin
                ShareCapitalAccNo := SavingsAccount."No.";
                ShareCapitalAccStatus := SavingsAccount.Status;
            end;
            if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Chama Investment Account" then begin
                GroupSavingsAccNo := SavingsAccount."No.";
                GroupSavingsAccStatus := SavingsAccount.Status;
            end;
        end;

    end;


    Var
        SavingsAccount: Record "Savings Accounts";
        BOSAAccNo: Code[20];
        BOSAAccStatus: Enum "Savings Account Status";
        FOSAAccNo: Code[20];
        FOSAAccStatus: Enum "Savings Account Status";
        ShareCapitalAccNo: Code[20];
        ShareCapitalAccStatus: Enum "Savings Account Status";
        GroupSavingsAccNo: Code[20];
        GroupSavingsAccStatus: Enum "Savings Account Status";
}

