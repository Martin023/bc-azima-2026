#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186411 tableextension52186411 extends "Gen. Journal Line"
{
    fields
    {
        modify("FA Posting Type")
        {


            trigger OnAfterValidate()
            begin
                initializevisibility();
            end;
        }




        field(50000; "Transaction Type"; enum "Transaction Types")
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*IF "Transaction Type"="Transaction Type"::"Registration Fee" THEN
                  Description:='Registration Fee';
                IF "Transaction Type"="Transaction Type"::Loan THEN
                  Description:='Loan';
                IF "Transaction Type"="Transaction Type"::Repayment THEN
                  Description:='Loan Repayment';
                IF "Transaction Type"="Transaction Type"::Withdrawal THEN
                  Description:='Withdrawal';
                IF "Transaction Type"="Transaction Type"::"Interest Due" THEN
                  Description:='Interest Due';
                IF "Transaction Type"="Transaction Type"::"Interest Paid" THEN
                  Description:='Interest Paid';
                IF "Transaction Type"="Transaction Type"::"Benevolent Fund" THEN
                  Description:='ABF Fund';
                IF "Transaction Type"="Transaction Type"::"Deposit Contribution" THEN
                  Description:='Shares Contribution';
                IF "Transaction Type"="Transaction Type"::"Appraisal Fee" THEN
                  Description:='Appraisal Fee';
                IF "Transaction Type"="Transaction Type"::"Application` Fee" THEN
                  Description:='Application Fee';
                IF "Transaction Type"="Transaction Type"::"Unallocated Funds" THEN
                  Description:='Unallocated Funds';
                         */


                //GenSet.GET;
                /*
                IF "Account Type"="Account Type"::Member THEN BEGIN
                CustMember.RESET;
                CustMember.SETRANGE(CustMember."No.","Account No.");
                IF CustMember.FIND('-') THEN BEGIN
                IF "Transaction Type"="Transaction Type"::Bills THEN
                "Bal. Account No.":=GenSet."Bill Account"
                ELSE
                "Bal. Account No.":='';
                END;
                END;
                
                
                
                PartOfAcc:='';
                
                PartOfAcc:=COPYSTR("Account No.",1,3);
                
                IF ((PartOfAcc='S01') OR (PartOfAcc='S02') OR (PartOfAcc='S06') OR (PartOfAcc='S09')  ) AND ("Transaction Type"<>"Transaction Type"::"Deposit Contribution") THEN
                ERROR('The chosen transaction type should be deposit contribution');
                
                IF ((PartOfAcc='S03') OR (PartOfAcc='S04')) AND ("Transaction Type"<>"Transaction Type"::"Share Capital") THEN
                ERROR('The chosen transaction type should be share Capital');
                
                IF ((PartOfAcc='L01') OR (PartOfAcc='L04') OR (PartOfAcc='L05')) AND ("Transaction Type"<>"Transaction Type"::" ") THEN
                ERROR('The transaction type should be blank');
                */



            end;
        }
        field(50001; "Loan No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans."Loan No." where("Loan Account" = field("Account No."),
                                                    Posted = const(true));

            trigger OnValidate()
            begin
                // IF Loans.GET("Loan No") THEN BEGIN
                //     "Member No." := Loans."Member No.";
                // END;

            end;
        }
        field(50006; "Fixed Deposit Contract"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = CONST(Savings)) "Fixed Deposit Contract"."No." where("Fixed Deposit Account No." = field("Account No."),
                                                    Status = const(Approved));

            trigger OnValidate()
            begin
            end;
        }


        field(50002; "Loan Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Loan Span"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Short Term,Long Term';
            OptionMembers = " ","Short Term","Long Term";
        }

        field(39005600; "Grant No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005601; "Purch. Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005602; "Close Year Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39005603; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Rec.GetCurrency;
                Rec."Debit Amount" := ROUND(Rec."Debit Amount", Currency."Amount Rounding Precision");
                Rec.Correction := Rec."Debit Amount" < 0;
                Rec.Amount := Rec."Debit Amount";
                Rec.Validate(Rec.Amount);
            end;
        }
        field(39005604; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Rec.GetCurrency;
                Rec."Credit Amount" := ROUND(Rec."Credit Amount", Currency."Amount Rounding Precision");
                Rec.Correction := Rec."Credit Amount" < 0;
                Rec.Amount := -Rec."Credit Amount";
                Rec.Validate(Rec.Amount);
            end;
        }
        field(39005605; "Lease No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005620; "Staff/Payroll No"; Code[20])
        {

        }
        field(39005606; "Property Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005607; "Transaction Code 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005608; "Tenant No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005609; Posted; Boolean)
        {
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Account Type" = CONST(Employee)) Employee

            ELSE
            IF ("Account Type" = CONST(Savings)) "Savings Accounts"
            ELSE
            IF ("Account Type" = CONST(Credit)) "Credit Accounts";
        }
        field(39005610; "Customer/Member/Vend Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        modify("Account No.")
        {
            TableRelation = if ("Account Type" = CONST(Savings)) "Savings Accounts"
            ELSE
            if ("Account Type" = CONST(Credit)) "Credit Accounts";

            trigger OnBeforeValidate()
            var
                members: record "Members";
                GlAcc: record "G/L Account";
                CustMember: record Customer;
                Vendor: record Vendor;
            begin
                if "Account Type" = "Account Type"::Savings then begin
                    if SavaCC.Get("Account No.") then begin
                        Description := SavaCC."Product Name";
                        if members.get(SavaCC."Member No.") then
                            "Customer/Member/Vend Name" := members.Name;
                    end;
                end;
                if "Account Type" = "Account Type"::Credit then begin
                    if CreditACC.Get("Account No.") then begin
                        Description := CreditACC."Product Name";
                        "Member No." := CreditACC."Member No.";
                        if members.get(CreditACC."Member No.") then
                            "Customer/Member/Vend Name" := members.Name;
                    end;
                end;
                if "Account Type" = "Account Type"::"G/L Account" then begin
                    if GlAcc.Get("Account No.") then begin
                        "Customer/Member/Vend Name" := GlAcc.Name;
                    end;
                end;
                if "Account Type" = "Account Type"::Customer then begin
                    if CustMember.Get("Account No.") then begin
                        "Customer/Member/Vend Name" := CustMember.Name;
                    end;
                end;
                if "Account Type" = "Account Type"::Vendor then begin
                    if Vendor.Get("Account No.") then begin
                        "Customer/Member/Vend Name" := Vendor.Name;
                    end;
                end;
            end;
        }

    }
    Var
        SavaCC: Record "Savings Accounts";
        CreditACC: Record "Credit Accounts";
        Loans: Record loans;

    var
        FAVisible: boolean;

    procedure initializevisibility()
    begin
        FAVisible := True;
    end;
}
