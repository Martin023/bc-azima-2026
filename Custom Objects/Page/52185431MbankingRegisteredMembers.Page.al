page 52185431 "Mbanking Registered Members"
{
    CardPageID = "Savings Account Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    ShowFilter = true;
    SourceTable = "Savings Accounts";
    SourceTableView = WHERE("Transactional Mobile No" = FILTER(<> ''));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Old Account No"; Rec."Old Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field(Salutation; Rec.Salutation)
                // {
                //     Caption = 'Salutation';
                // }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transactional Mobile No"; Rec."Transactional Mobile No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Send Statement Freq."; Rec."Send Statement Freq.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Statement Date"; Rec."Last Statement Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Group Account No"; Rec."Group Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("ATM No."; Rec.NewStr)
                // {
                // }
                field("Product Category"; Rec."Product Category")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field(HideBal; Rec.HideBal)
                // {
                //     Caption = 'Balance (LCY)';
                // }
                field("Employer Account No"; Rec."Employer Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Disbursement Account"; Rec."Loan Disbursement Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Salary Through FOSA"; Rec."Salary Through FOSA")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        NewStr := '';
        if StrLen(Rec."ATM No.") > 4 then begin
            Str := (CopyStr(Rec."ATM No.", StrLen(Rec."ATM No.") - 3, 4));
            NewStr := 'xxxxxxxx' + Str;
        end;

        Rec.CalcFields("Balance (LCY)");
        Evaluate(HideBal, Format(Rec."Balance (LCY)"));
        //HideBal:='X.XX';
        if UserSetup.Get(UserId) then begin
            if UserSetup."Show Hidden Balance" = false then begin
                if Rec."Product Category" = Rec."Product Category"::"Unallocated Fund" then
                    HideBal := 'X.XX';
                if Rec."Loan Disbursement Account" = true then
                    HideBal := 'X.XX';
            end;
        end;
        if Members.Get(Rec."Member No.") then begin
            Salutation := Members.Salutation;
        end;
    end;

    trigger OnOpenPage()
    begin
        NewStr := '';
        if StrLen(Rec."ATM No.") > 4 then begin
            Str := (CopyStr(Rec."ATM No.", StrLen(Rec."ATM No.") - 3, 4));
            NewStr := 'xxxxxxxx' + Str;
        end;
        Rec.CalcFields("Balance (LCY)");
        Evaluate(HideBal, Format(Rec."Balance (LCY)"));

        if UserSetup.Get(UserId) then begin
            if UserSetup."Show Hidden Balance" = false then begin
                if Rec."Product Category" = Rec."Product Category"::"Unallocated Fund" then
                    HideBal := 'X.XX';
                if Rec."Loan Disbursement Account" = true then
                    HideBal := 'X.XX';
            end;
        end;
        if Members.Get(Rec."Member No.") then begin
            Salutation := Members.Salutation;
        end;
    end;

    var
        Str: Code[30];
        NewStr: Code[30];
        Members: Record Members;
        Salutation: Code[10];
        HideBal: Text;
        UserSetup: Record "User Setup";
}

