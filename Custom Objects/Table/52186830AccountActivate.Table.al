table 52186833 "Account Activation"
{
    DrillDownPageId = "Account Activation List";
    LookupPageId = "Account Activation List";

    fields
    {
        field(1; No; Code[10])
        {
            Editable = false;
        }
        field(2; Date; Date)
        {
            Editable = false;

        }
        field(3; "Member No"; Code[20])
        {
            TableRelation = Members;

            trigger OnValidate()
            begin
                // "Account Balance" := 0;
                "Account Name" := '';
                "Member Name" := '';
                "Account No" := '';
                // "Closure Date" := 0D;
                Members.Reset;
                Members.SetRange("No.", "Member No");
                if Members.Find('-') then begin
                    if (Members.Subflag = Members.Subflag::Deceased) then
                        Error('This member subflag is %1 hence cannot be activated. Try rejoining the member.', Members.Subflag);
                end;
                "Member Name" := Members.Name;
            end;
        }
        field(4; "Member Name"; Text[100])
        {
            Editable = false;
        }
        field(5; "Account No"; Code[20])
        {
            // TableRelation = "Savings Accounts" WHERE("Member No." = FIELD("Member No"),
            //                                           Status = FILTER(Dormant),
            //                                           "Product Category" = FILTER("Fixed Deposit" | "FOSA Account" |
            //                                           SAYE | "Junior Account" | "Biashara Account"));

            TableRelation = IF (Action = filter(Activate)) "Savings Accounts" WHERE("Member No." = FIELD("Member No"),

                                                      Status = FILTER(Dormant | Frozen | Closed), "Source Unit" = filter(FOSA))

            ELSE
            IF (Action = filter(Block)) "Savings Accounts" WHERE("Member No." = FIELD("Member No"),
                                                      Status = FILTER(Dormant | Frozen | Active),
                                                      "Source Unit" = filter(FOSA))
            ELSE
            IF (Action = filter(Freeze)) "Savings Accounts" WHERE("Member No." = FIELD("Member No"),
                                                      Status = FILTER(Dormant | Active),
                                                      "Source Unit" = filter(FOSA))
            else
            if (Action = filter(Unblock)) "Savings Accounts" where("Member No." = FIELD("Member No"), Blocked = filter(<> " "),
                                                      "Source Unit" = filter(FOSA));

            trigger OnValidate()
            begin
                "Account Balance" := 0;
                "Account Name" := '';

                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("No.", "Account No");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    "Account Balance" := SavingsAccounts."Balance (LCY)";
                    "Account Name" := SavingsAccounts.Name;
                end;
            end;
        }
        field(6; "Reason For Account Closure"; Text[100])
        {
        }
        field(7; "Account Balance"; Decimal)
        {
            Editable = false;
        }
        field(8; "Activation Date"; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Activation Date" <> Today then "Activation Date" := Today;
            end;
        }
        field(9; "User Id"; Code[50])
        {
            Editable = false;
        }
        field(10; Activated; Boolean)
        {
            Editable = false;
        }
        field(11; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Rejected,Approved,Activated,Blocked,Frozen';
            OptionMembers = Open,Pending,Rejected,Approved,Activated,Blocked,Frozen;

            trigger OnValidate()
            begin
                if (Rec.Status = Status::Rejected) or (Rec.Status = Status::Approved) then begin
                    Comments.Reset();
                    Comments.SetRange("Commented By", UserId);
                    Comments.SetRange("Viewd By Somebody Else", false);
                    Comments.SetRange("Header No.", No);
                    if not Comments.FindFirst() then
                        Error('Please add a comment before performing this action');
                end;
            end;
        }
        field(12; "Account Name"; Text[100])
        {
            Editable = false;
        }
        field(13; "No. Series"; Code[20])
        {
            Editable = false;
        }
        field(14; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(15; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(16; "Activated By"; Code[50])
        {
            Editable = false;
        }
        field(17; "Date Activated"; Date)
        {
            Editable = false;
        }
        field(18; "Transaction Type"; Code[10])
        {
            TableRelation = "Transaction Types".Code where(Type = filter("Account Activate"));//.Code WHERE("Product Type" = FIELD("Product Type"));
        }
        field(19; Action; Option)
        {
            OptionMembers = " ",Activate,Block,Freeze,Unblock;
        }
        field(20; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Credit,Debit,All';
            OptionMembers = " ",Credit,Debit,All;
        }
        field(21; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(22; "Reason for the Action"; Text[100])
        {

        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
            MembNoSeries.Get;
            MembNoSeries.TestField(MembNoSeries."Account Activation");
            No := NoSeriesMgt.GetNextNo(MembNoSeries."Account Activation");
            // NoSeriesMgt.InitSeries(MembNoSeries."Account Activation", xRec.No, 0D, No, "No. Series");
            "User Id" := UserId;
            "Activation Date" := Today;
            rec.Date := Today;

        end;
        if UserSetup.Get(UserId) then begin
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        end;
    end;

    var
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        MembNoSeries: Record "Banking No Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        Comments: Record Comments;
}

