table 52185718 "Standing Order Lines"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Document No."; Code[20])
        {
        }
        field(17; "Destination Account Type"; Enum "Gen. Journal Account Type")
        {
            // OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,External,Fixed Asset,IC Partner,Internal,Credit';
            // OptionMembers = "G/L Account",Customer,Vendor,"Bank Account",External,"Fixed Asset","IC Partner",Internal,Credit;


            trigger OnValidate()
            begin
                if "Destination Account Type" = "Destination Account Type"::"G/L Account" then begin
                    if STOHeader.Get("Document No.") then begin
                        if STOHeader."Allow Partial Deduction" = true then
                            Error('An external standing order cannot be partially deducted');
                        "Member No" := STOHeader."Member No.";
                    end;
                end;


                // IF STOHeader.GET("Document No.") THEN BEGIN
                //     IF STOHeader."Income Type" = STOHeader."Income Type"::Periodic THEN BEGIN
                //         IF "Destination Account Type" <> Rec."Destination Account Type"::Credit THEN
                //             ERROR('Destination account type must be credit');
                //     END;
                // END;

                // if STOHeader.Get("Document No.") then begin
                //     if STOHeader."Income Type" = STOHeader."Income Type"::Salary then begin
                //         if ("Destination Account Type" = Rec."Destination Account Type"::"G/L Account") then
                //             Error('Destination account type cannot be external');
                //     end;
                // end;
            end;
        }
        field(18; "Destination Account No."; Code[50])
        {
            TableRelation = IF ("Destination Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Destination Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Destination Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Destination Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Destination Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Destination Account Type" = CONST(Savings)) "Savings Accounts"
            ELSE
            IF ("Destination Account Type" = CONST(Credit)) "Credit accounts" WHERE("Balance (LCY)" = filter(> 0));

            trigger OnValidate()
            begin
                if "Destination Account Type" = "Destination Account Type"::Savings then begin
                    if Account.Get("Destination Account No.") then begin
                        "Destination Account Name" := Account.Name;
                        Account.CalcFields("Balance (LCY)");
                        "Destination Account Balance" := Account."Balance (LCY)";
                        "Product Description" := Account."Product Name";
                    end;
                end;

                if "Destination Account Type" = "Destination Account Type"::"G/L Account" then begin
                    if BankAcc.Get("Destination Account No.") then begin
                        "Destination Account Name" := BankAcc.Name;
                        "Bank Code" := BankAcc."Bank No.";
                        "Product Description" := BankAcc.Name;



                        if STOHeader.Get("Document No.") then begin
                            if STOHeader."Allow Partial Deduction" = true then
                                Error('An external standing order cannot be partially deducted');
                        end;
                    end;

                    if "Destination Account Type" = "Destination Account Type"::"G/L Account" then begin
                        if StrLen("Destination Account No.") > 14 then
                            Error('Invalid Bank Account No. Please enter a bank account with less than 15 digits.');
                    end;


                end;

                if "Destination Account Type" = "Destination Account Type"::Credit then begin
                    if Cust.Get("Destination Account No.") then begin
                        "Destination Account Name" := Cust.Name;
                    end;
                end;

                /*
                STOLines.RESET;
                STOLines.SETRANGE(STOLines."Document No.","Document No.");
                IF STOLines.FIND('-')=TRUE THEN //BEGIN
                //IF STOLines.COUNT>1 THEN
                  ERROR('Only one entry is allowed for this type of standing order, Please delete the lines before proceeding');
                //END;
                */

            end;
        }
        field(19; "Destination Account Name"; Text[80])
        {
            Editable = false;
        }
        field(20; "Loan No."; Code[20])
        {
            //TableRelation = IF ("Destination Account No." = FILTER(<> '')) Loans WHERE("Loan Account" = FIELD("Destination Account No."), "Total Balance" = filter(> 0));
            TableRelation = Loans."Loan No." where("Total Balance" = filter(> 0));

            trigger OnValidate()
            var
                Loans: Record "Loans";
            begin
                if Loans.Get("Loan No.") then begin
                    Loans.CalcFields("Total Balance");
                    if Loans."Total Balance" <= 0 then
                        Error('This Loan has no outstanding balance');

                    if Loans."Loan Account" = '' then error('Kindly specify all Loan accounts before proceeding');
                    "Destination Account No." := Loans."Loan Account";
                    "Destination Account Name" := Loans."Member Name";
                    "Destination Account Balance" := Loans."Total Balance";
                    "Product Description" := Loans."Loan Product Type Name";
                end;
                if "Loan No." <> '' then begin
                    STOHeader.reset;
                    STOHeader.SetRange(Status, STOHeader.Status::Approved);
                    STOHeader.setfilter("No.", '<>%1', rec."Document No.");
                    if STOHeader.findset()
                    then begin
                        repeat
                            STOLines.reset;
                            STOLines.setrange("Document No.", STOHeader."No.");
                            STOLines.setrange("Loan No.", Rec."Loan No.");
                            // STOLines.setfilter("Document No.", '<>%1', rec."Document No.");
                            if STOLines.find('-') then begin
                                Error('This Loan has another standing order No. %1', STOLines."Document No.");
                            end;
                        until STOHeader.next = 0;
                    end;
                    STOLines.reset;
                    STOLines.setrange("Document No.", rec."Document No.");
                    STOLines.setrange("Loan No.", Rec."Loan No.");
                    STOLines.setfilter("Entry No.", '<>%1', rec."Entry No.");
                    // STOLines.setfilter("Document No.", '<>%1', rec."Document No.");
                    if STOLines.find('-') then begin
                        Error('This Loan has another standing order No. %1', STOLines."Document No.");
                    end;
                end;
            end;
        }
        field(21; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                if Amount < 0 then
                    Error(LessThanZeroAmount);


                if "Destination Account Type" = "Destination Account Type"::Credit then begin
                    if "Loan No." = '' then
                        Error('Kindly specify the loan no. before proceeding');

                end;

                "Remaining Amount" := Amount;
            end;
        }
        field(22; "Bank Code"; Code[10])
        {
            TableRelation = "Bank Code Structure".Code;

            trigger OnValidate()
            begin
                if "Destination Account Type" = "Destination Account Type"::Savings then
                    Error('Only applicable FOR external STOs');

                BankCodeStructure.Reset;
                BankCodeStructure.SetRange(BankCodeStructure.Code, "Bank Code");
                if BankCodeStructure.Find('-') then
                    "Bank Name" := BankCodeStructure.Name;
            end;
        }
        field(23; "Branch Code"; Code[10])
        {
            TableRelation = "Bank Code Structure".Code;

            trigger OnValidate()
            begin
                if "Destination Account Type" <> "Destination Account Type"::"G/L Account" then
                    Error('Only applicable for external STOs');


                BankCodeStructure.Reset;
                BankCodeStructure.SetRange(BankCodeStructure.Code, "Branch Code");
                if BankCodeStructure.Find('-') then begin
                    "Bank Code" := BankCodeStructure.Code;
                    "Bank Name" := BankCodeStructure.Name;
                    "Branch Name" := BankCodeStructure.Name;
                end;

                if "Branch Code" = '' then begin
                    "Bank Code" := '';
                    "Bank Name" := '';
                    "Bank Account No." := '';
                end;
            end;
        }
        field(24; "Bank Name"; Text[100])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Destination Account Type" <> "Destination Account Type"::"G/L Account" then
                    Error('Only applicable for external STOs');
            end;
        }
        field(25; "Bank Account No."; Code[15])
        {

            trigger OnValidate()
            begin
                if "Destination Account Type" <> "Destination Account Type"::"G/L Account" then
                    Error('Only applicable for external STOs');

                // //*
                // IF "Destination Account Type" = "Destination Account Type"::External THEN BEGIN
                // IF STRLEN("Bank Account No.") <>13 THEN
                // ERROR('Invalid Bank account No. Please enter the correct Bank Account No.');
                // END;
            end;
        }
        field(26; Balance; Decimal)
        {
        }
        field(27; "Branch Name"; Text[150])
        {
        }
        field(28; "Member No"; Code[20])
        {
        }
        field(29; "OutStanding Bills"; Decimal)
        {
            CalcFormula = Sum("Credit Ledger Entry".Amount WHERE("Loan No" = FIELD("Loan No."),
                                                                  "Transaction Type" = FILTER(Bills)));
            FieldClass = FlowField;
        }
        field(30; "Amount Deducted"; Decimal)
        {
        }
        field(31; "Remaining Amount"; Decimal)
        {
        }
        field(32; "Transaction Type"; Enum "Transaction Types")
        {
            ValuesAllowed = " ", Repayment, "Interest Paid", Armotised;
            trigger OnValidate()
            var
                ErrorOnInvalidTransType: Label 'Transaction type -%1- is disabled on this document. Please contact your system administrator.';
            begin
                // case "Transaction Type" of
                //     "Transaction Type"::Loan:
                //         begin
                //             Error(ErrorOnInvalidTransType, "Transaction Type");
                //         end;
                // end;
            end;
        }
        field(33; "Destination Account Balance"; Decimal)
        {
            Editable = false;
        }
        field(34; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected,Stopped,Cancelled';
            OptionMembers = Open,Pending,Approved,Rejected,Stopped,Cancelled;
            FieldClass = FlowField;
            Calcformula = Lookup("Standing Order Header".Status WHERE("No." = FIELD("Document No.")));
        }
        field(35; "Product Description"; Text[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Destination Account No.", "Loan No.", "Member No")
        {
            Clustered = true;
        }
        key(Key2; "Destination Account Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Validate("Destination Account Type");
        if STOHeader.Get("Document No.") then begin
            "Member No" := STOHeader."Member No.";
        end;
    end;

    trigger OnModify()
    begin
        if STOHeader.Get("Document No.") then begin
            "Member No" := STOHeader."Member No.";
        end;
    end;

    var
        Account: Record "Savings Accounts";
        BankAcc: Record "Bank Account";
        BankCodeStructure: Record "Bank Code Structure";
        Cust: Record "Credit Accounts";
        StrTel: Text;
        LessThanZeroAmount: Label 'Amount cannot be less than zero (0)';
        STOHeader: Record "Standing Order Header";
        STOLines: Record "Standing Order Lines";
}

