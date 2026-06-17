table 52186000 "BOSA Account Activation"
{
    DrillDownPageId = "BOSA Account Activation List";
    LookupPageId = "BOSA Account Activation List";

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

                "Account Name" := '';
                "Member Name" := '';
                "Account No" := '';
                "FOSA Main Account No." := '';

                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("Member No.", "Member No");
                if SavingsAccounts.Find('-') then begin
                    "FOSA Main Account No." := SavingsAccounts."No.";
                end;

                Members.Reset;
                Members.SetRange("No.", "Member No");
                if Members.Find('-') then begin
                    if (Members.Subflag = Members.Subflag::Withdrawal) or (Members.Subflag = Members.Subflag::Deceased) then begin
                        Error('This member subflag is %1 hence cannot be activated. Try rejoining the member.', Members.Subflag);
                    end;
                    "Member Name" := Members.Name;
                    "Payroll/Staff No." := Members."Payroll/Staff No.";
                end;

                ProdFact.Reset();
                ProdFact.SetRange("Product Category", ProdFact."Product Category"::"Share Capital");
                if ProdFact.Find('-') then
                    "Share Monthly Contribution" := ProdFact."Minimum Contribution";
            end;
        }
        field(4; "Member Name"; Text[100])
        {
            Editable = false;
        }
        field(5; "Account No"; Code[20])
        {

            TableRelation = IF (Action = filter(Activate)) "Savings Accounts" WHERE("Member No." = FIELD("Member No"),
                                                      Status = FILTER(Dormant | Frozen | Closed),
                                                      "Source Unit" = filter(BOSA))
            ELSE
            IF (Action = filter(Block)) "Savings Accounts" WHERE("Member No." = FIELD("Member No"),
                                                      Status = FILTER(Dormant | Frozen | Active),
                                                       "Source Unit" = filter(BOSA))
            ELSE
            IF (Action = filter(Freeze)) "Savings Accounts" WHERE("Member No." = FIELD("Member No"),
                                                      Status = FILTER(Dormant | Active),
                                                       "Source Unit" = filter(BOSA))
            else
            if (Action = filter(Unblock)) "Savings Accounts" where("Member No." = FIELD("Member No"), Blocked = filter(<> " "),
                                                      "Source Unit" = filter(BOSA));

            trigger OnValidate()
            begin
                "Account Balance" := 0;
                "Account Name" := '';

                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("No.", "Account No");
                if SavingsAccounts.Find('-') then begin
                    "Product Name" := SavingsAccounts."Product Name";
                end;

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

            // trigger OnValidate()
            // begin
            //     if "Activation Date" <> Today then "Activation Date" := Today;
            // end;
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
        field(19; "Payroll/Staff No."; Code[20])
        {
            TableRelation = Members."Payroll/Staff No." where("No." = field("Member No"));
            Editable = false;
        }
        field(20; "FOSA Main Account No."; Code[20])
        {
            Description = 'LookUp to Savings Account Table';
            Editable = false;
            TableRelation = "Savings Accounts"."No." WHERE("Member No." = FIELD("Member No"), "Loan Disbursement Account" = filter(true),
                                                      "Product Category" = FILTER("FOSA Account"), "Salary Through FOSA" = filter(true));
        }
        field(21; "Share Monthly Contribution"; Decimal)
        {
            TableRelation = "Product Factory"."Minimum Deposit Contribution" where("Product Category" = filter("Share Capital"));
            Editable = false;
        }
        field(22; Action; Option)
        {
            OptionMembers = " ",Activate,Block,Freeze,Unblock;
            ValuesAllowed = Activate, Block, Unblock;
        }
        field(23; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Credit,Debit,All';
            OptionMembers = " ",Credit,Debit,All;
        }
        field(24; Posted; Boolean)
        {
            Editable = false;

        }
        field(25; "Date Posted"; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Date Posted" <> Today then "Date Posted" := Today;
            end;
        }
        field(26; "Transaction Time"; Time)
        {
            Editable = false;
        }
        field(27; "Product Name"; Text[50])
        {
            Editable = false;
        }
        field(28; "Time Posted"; Time)
        {
            Editable = false;
        }
        field(29; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(30; "Responsibility Center"; Code[20])
        {
            Editable = false;
            TableRelation = "Responsibility CenterBR";
        }
        field(31; Remarks; text[900])
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
            MembNoSeries.TestField(MembNoSeries."BOSA Account Activation");
            No := NoSeriesMgt.GetNextNo(MembNoSeries."BOSA Account Activation");
            // NoSeriesMgt.InitSeries(MembNoSeries."BOSA Account Activation", xRec.No, 0D, No, "No. Series");
            "User Id" := UserId;
            "Activation Date" := Today;
            rec.Date := Today;
            "Transaction Time" := Time;

        end;
        if UserSetup.Get(UserId) then begin
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;
    end;

    var
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        MembNoSeries: Record "Banking No Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        GlobalFunctions: Codeunit "Global Functions";
        ProdFact: Record "Product Factory";
        Comments: Record Comments;

    procedure CheckBalAfterChrg(AccNo: Code[20]; TransactionTypes: record "Transaction Types")
    var
        TransactionCharges: record "Transaction Charges";
        SavAcc: Record "Savings Accounts";
        FosaAcc: record "Savings Accounts";
    begin
        TransactionTypes.Reset;
        TransactionTypes.SetRange(Code, TransactionTypes.code);
        if TransactionTypes.Find('-') then begin
            TransactionCharges.Reset;
            TransactionCharges.SetRange("Transaction Type", TransactionTypes.Code);
            //TransactionCharges.setrange("G/L Account")
            if TransactionCharges.Find('-') then begin
                TransactionCharges.CalcSums("Charge Amount");
                if SavAcc.get(Rec."Account No") then begin
                    SavAcc.TestField(Status, SavAcc.Status::Dormant);
                    if SavAcc."Product Category" = SavAcc."Product Category"::"BOSA Deposits" then begin
                        //charge ODS not BOSA Acc.
                        // FosaAcc.Reset();
                        // FosaAcc.SetRange("Product Type", '191');
                        // FosaAcc.SetRange("Member No.", SavAcc."Member No.");
                        // if FosaAcc.FindFirst() then begin
                        //     if FosaAcc.GetAvailableBalance(FosaAcc."No.");
                        // end;
                    end;
                    if SavAcc."Product Type" = '191' then begin

                    end;
                end;
            end;
        end;
    end;
}

