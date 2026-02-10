table 52185743 "Other Commitements Clearance"
{
    DrillDownPageID = "Other Commitments Clearance";
    LookupPageID = "Other Commitments Clearance";

    fields
    {
        field(1; "Loan No."; Code[50])
        {
            NotBlank = true;
            TableRelation = Loans."Loan No.";

            trigger OnValidate()
            begin
                if LoanApp.Get("Loan No.") and (rec."Loan No." <> '') then begin
                    if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) then
                        Error(Text001, LoanApp.Status);
                end;
            end;


        }
        field(2; Description; Text[50])
        {
            trigger Onvalidate()
            begin
                if LoanApp.Get("Loan No.") and (rec."Loan No." <> '') then begin
                    if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) then
                        Error(Text001, LoanApp.Status);
                end;
            end;

        }
        field(3; Payee; Text[50])
        {
            NotBlank = true;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(4; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                if LoanApp.Get("Loan No.") and (rec."Loan No." <> '') then begin
                    if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) then
                        Error(Text001, LoanApp.Status);
                end;

                if Amount < 0 then
                    Error('Amount cannot be less than 0');

                if LoanApp.Get("Loan No.") then begin
                    NetAmt := 0;
                    // NetAmt := LoansProcess.ComputeCharges(LoanApp."Approved Amount", LoanApp."Loan Product Type", LoanApp."Loan No.", 0);
                    NetAmt := LoanApp."Approved Amount";

                    if NetAmt - Amount <= 0 then
                        Error(Text002);
                end;
            end;
        }
        field(5; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(6; "Bankers Cheque No"; Code[20])
        {
        }
        field(7; "Bankers Cheque No 2"; Code[20])
        {
        }
        field(8; "Bankers Cheque No 3"; Code[20])
        {
        }
        field(9; "Batch No."; Code[20])
        {
        }
        field(10; "Affects 2/3 Rule"; Boolean)
        {
            Editable = false;
        }
        field(11; "Monthly Deduction"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Monthly Deduction" > 0 then
                    "Affects 2/3 Rule" := true
                else
                    "Affects 2/3 Rule" := false;
            end;
        }
        field(12; "Vendor No."; Code[20])
        {
            Caption = 'Account No.';

            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting), "Direct Posting" = const(true),
                                                                                          Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Savings")) "Savings Accounts"
            else
            if ("Account Type" = const(Credit)) "Credit Accounts" where("Balance (LCY)" = filter(> 0));

            /*  TableRelation = Vendor."No." WHERE("Vendor Type" = FILTER("External Loans"));
*/
            trigger OnValidate()
            begin
                if LoanApp.Get("Loan No.") and (rec."Loan No." <> '') then begin
                    if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) then
                        Error(Text001, LoanApp.Status);
                end;

                Amount := 0;
                "Destination Loan No." := '';
                "Vendor Name" := '';
                if "Account Type" = "Account Type"::Credit then begin
                    Credit.get("Vendor No.");
                    "Vendor Name" := Credit.Name;
                end;
                if "Account Type" = "Account Type"::Savings then begin

                    Savings.get("Vendor No.");
                    "Vendor Name" := Savings.Name;
                end;
                if "Account Type" = "Account Type"::"G/L Account" then begin

                    GLAccount.get("Vendor No.");
                    "Vendor Name" := GLAccount.Name;

                end;
                if "Account Type" = "Account Type"::Vendor then begin
                    Vend.get("Vendor No.");
                    "Vendor Name" := Vend.Name;
                end;
                if "Account Type" = "Account Type"::Customer then begin
                    Customer.get("Vendor No.");
                    "Vendor Name" := Customer.Name;
                end;
            end;

        }
        field(13; "Vendor Name"; Text[50])
        {
            Caption = 'Account Name';
            Editable = false;
        }
        field(14; "Account Type"; Enum "Gen. Journal Account Type")
        {
            ValuesAllowed = "G/L Account", "Customer", "Vendor", "Savings", "Credit";
            trigger OnValidate()
            begin
                if LoanApp.Get("Loan No.") and (rec."Loan No." <> '') then begin
                    if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) then
                        Error(Text001, LoanApp.Status);
                end;

                Amount := 0;
                "Vendor No." := '';
                "Destination Loan No." := '';
            end;

        }

        field(15; "Destination Loan No."; Code[30])
        {
            TableRelation = IF ("Account Type" = CONST(Credit)) Loans."Loan No." WHERE("Loan Account" = FIELD("Vendor No."),
                                                                                                  Posted = CONST(true),
                                                                                                  "Total Loan Balance" = FILTER(> 0));
            trigger OnValidate()
            begin
                if LoanApp.Get("Loan No.") and (rec."Loan No." <> '') then begin
                    if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) then
                        Error(Text001, LoanApp.Status);
                end;

                Amount := 0;
                if LoanApp.Get("Destination Loan No.") then begin
                    LoanApp.CalcFields("Total Balance");
                    Amount := LoanApp."Total Balance";

                    // if LoanApps.Get("Loan No.") then begin
                    //     NetAmt := 0;
                    //     NetAmt := LoansProcess.ComputeCharges(LoanApps."Approved Amount", LoanApps."Loan Product Type", LoanApps."Loan No.", 0);
                    //     if NetAmt < 0 then NetAmt := 0;
                    //     if Amount > NetAmt then
                    //         Amount := NetAmt;

                    // end;
                end;
            end;
        }

        field(16; Posted; Boolean)
        {
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "Loan No.", "Vendor No.", Description, Amount)
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
        key(Key2; Payee)
        {
        }
        key(Key3; "Batch No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if LoanApp.Get("Loan No.") then begin
            if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) then
                Error(Text001, LoanApp.Status);
        end;
    end;

    trigger OnInsert()
    begin
        if LoanApp.Get("Loan No.") then begin
            if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) then
                Error(Text001, LoanApp.Status);
        end;
    end;

    trigger OnModify()
    begin

    end;

    // trigger OnRename()
    // begin
    //     if LoanApp.Get("Loan No.") then begin
    //         if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) then
    //             Error(Text001, LoanApp.Status);
    //     end;
    // end;

    var
        Text001: Label 'You cannot modify this since the loan is already %1';
        LoanApp: Record Loans;
        LoanApps: Record Loans;
        NetAmt: Decimal;
        LoansProcess: Codeunit "Loans Process";
        Text002: Label 'The approved amount is not sufficient to offset commitments';
        Vend: Record Vendor;
        Credit: Record "Credit Accounts";
        Savings: Record "Savings Accounts";
        GLAccount: record "G/L Account";
        Customer: Record Customer;
}

