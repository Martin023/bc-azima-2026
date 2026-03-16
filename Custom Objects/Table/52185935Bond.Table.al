table 52185835 Bond
{
    DrillDownPageID = "Bond List";
    LookupPageID = "Bond List";

    fields
    {
        field(1; "Bond No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "Bond No." <> xRec."Bond No." then begin
                    BondSetup.Get;
                    NoSeriesMgt.TestManual(BondSetup."Bond Nos.");

                    "No. Series" := '';
                end;

                TestField("Bond Status", "Bond Status"::Open);
                UserSetup.Get(UpperCase(UserId));
                //**UserSetup.TESTFIELD("Branch Code");
            end;
        }
        field(2; "Member No."; Code[20])
        {
            TableRelation = Members."No.";

            trigger OnValidate()
            begin
                TestField("Bond Type");
                TestField("Bond Status", "Bond Status"::Open);
                Members.Get("Member No.");
                "Member Name" := Members.Name;
                "Member Address" := Members."Current Address";
                "Member Post Code" := Members."Post Code";
                "Member City" := Members.City;
            end;
        }
        field(3; "Bond Type"; Option)
        {
            OptionCaption = ' ,Bid-Bond,Perfomance Bond';
            OptionMembers = " ","Bid-Bond","Perfomance Bond";

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
            end;
        }
        field(4; "Member Name"; Text[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
            end;
        }
        field(5; "Member Address"; Text[50])
        {

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
            end;
        }
        field(6; "Member Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode("Member City","Member Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
                PostCode.ValidateCity("Member City", "Member Post Code", "Member Country", "Member Country Code", true);
            end;
        }
        field(7; "Member City"; Text[30])
        {

            trigger OnLookup()
            begin
                //PostCode.LookUpCity("Member City","Member Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
                PostCode.ValidateCity("Member City", "Member Post Code", "Member Country", "Member Country Code", true);
            end;
        }
        field(8; "Member Contact Person"; Text[30])
        {

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
            end;
        }
        field(9; "Member Country Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode("Member City","Member Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
                //PostCode.ValidateCity("Member City","Member Post Code");
            end;
        }
        field(10; "Member Country"; Text[30])
        {

            trigger OnLookup()
            begin
                //PostCode.LookUpCity("Member City","Member Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
                //PostCode.ValidateCity("Member City","Member Post Code");
            end;
        }
        field(14; "Beneficiary No."; Code[30])
        {
            TableRelation = "Bond Company";

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
                TestField("Member No.");
                TestField("Bond Type");
                BondCompany.Get("Beneficiary No.");
                "Beneficiary Name" := BondCompany.Name;
                "Beneficiary Address" := BondCompany.Address;
                "Beneficiary Post Code" := BondCompany."Post Code";
                "Beneficiary City" := BondCompany.City;
                if "Bond Type" = "Bond Type"::"Perfomance Bond" then
                    "Cash Cover Required" := BondCompany."Cash Cover Required";
            end;
        }
        field(15; "Beneficiary Name"; Text[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
            end;
        }
        field(16; "Beneficiary Address"; Text[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
            end;
        }
        field(17; "Beneficiary Post Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode("Beneficiary City","Beneficiary Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
                //PostCode.ValidateCity("Beneficiary City","Beneficiary Post Code");
            end;
        }
        field(18; "Beneficiary City"; Text[30])
        {
            Editable = false;

            trigger OnLookup()
            begin
                //PostCode.LookUpCity("Beneficiary City","Beneficiary Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
                //PostCode.ValidateCity("Beneficiary City","Beneficiary Post Code");
            end;
        }
        field(30; "Valid From"; Date)
        {

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
                if "Valid To" <> 0D then
                    "Bond Validity Days" := "Valid To" - "Valid From";
            end;
        }
        field(31; "Valid To"; Date)
        {

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
                if "Valid From" <> 0D then
                    "Bond Validity Days" := "Valid To" - "Valid From";
            end;
        }
        field(32; "Method of Communication"; Option)
        {
            Enabled = false;
            OptionCaption = ' ,Swift,Courier,Over-the-Counter';
            OptionMembers = " ",Swift,Courier,"Over-the-Counter";

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
            end;
        }
        field(33; "Tender Details"; Text[250])
        {

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
            end;
        }
        field(34; "Order/Contract Date"; Date)
        {

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
            end;
        }
        field(35; Purpose; Text[250])
        {

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
            end;
        }
        field(36; "Cash Cover Required"; Boolean)
        {

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
                TestField("Bond Type", "Bond Type"::"Perfomance Bond");
                BondCompany.Get("Beneficiary No.");
                if ("Bond Type" = "Bond Type"::"Perfomance Bond") and
                (Amount > BondCompany."Max. Perf. Bond without Securi") and ("Cash Cover Required" = false) then
                    if not Confirm('Set Cash Cover Required to False?', false) then Error('User Cancelled');
            end;
        }
        field(37; "Bond Validity Days"; Integer)
        {
            Editable = false;
        }
        field(38; "Cash Cover Refunded"; Boolean)
        {
            Editable = false;

            trigger OnValidate()
            begin
                Error('Cannot be changed manually');
            end;
        }
        field(50; Amount; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
                TestField("Beneficiary No.");
                BondCompany.Get("Beneficiary No.");
                if Amount <= BondCompany."Max. Perf. Bond without Securi" then
                    "Cash Cover Required" := false
                else begin
                    if "Bond Type" = "Bond Type"::"Perfomance Bond" then begin
                        if Amount > BondCompany."Max. Perf. Bond without Securi" then
                            "Cash Cover Required" := true;
                    end;
                end;
            end;
        }
        field(51; "Branch Code"; Code[20])
        {
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                Error('Cannot be changed manually');
            end;
        }
        field(52; "Application Date"; Date)
        {

            trigger OnValidate()
            begin
                TestField("Bond Status", "Bond Status"::Open);
            end;
        }
        field(100; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(101; "Bond Status"; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Sent to Bank,Rejected by Bank,Issued,Cancelled';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,"Sent to Bank","Rejected by Bank",Issued,Cancelled;

            trigger OnValidate()
            begin
                //ERROR('Cannot be changed manually');
            end;
        }
        field(103; "Created By"; Code[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                Error('Cannot be changed manually');
            end;
        }
        field(104; "Sent for approval By"; Code[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                Error('Cannot be changed manually');
            end;
        }
        field(105; "Rejected/Approved By"; Code[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                Error('Cannot be changed manually');
            end;
        }
        field(106; "Sent to Chase Bank By"; Code[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                Error('Cannot be changed manually');
            end;
        }
        field(107; "Sent for Approval DateTime"; DateTime)
        {
            Editable = false;

            trigger OnValidate()
            begin
                Error('Cannot be changed manually');
            end;
        }
        field(108; "Rejected/Approved Date Time"; DateTime)
        {
            Editable = false;

            trigger OnValidate()
            begin
                Error('Cannot be changed manually');
            end;
        }
        field(109; "Rejection Comment"; Text[50])
        {

            trigger OnValidate()
            begin
                if ("Bond Status" <> "Bond Status"::"Pending Approval") and ("Bond Status" <> "Bond Status"::"Sent to Bank") then
                    Error('Rejection comment only when pending approval or when Sent to Bank');
            end;
        }
        field(110; "Bond Created DateTime"; DateTime)
        {
            Editable = false;

            trigger OnValidate()
            begin
                Error('Cannot be changed manually');
            end;
        }
        field(111; "Rejcted/Apprvd by Chase Bnk By"; Code[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                Error('Cannot be changed manually');
            end;
        }
        field(112; "Rejcted/Apprvd -Chase Bnk Time"; DateTime)
        {
            Editable = false;

            trigger OnValidate()
            begin
                Error('Cannot be changed manually');
            end;
        }
        field(113; "Issued By"; Code[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                Error('Cannot be changed manually');
            end;
        }
        field(114; "Issued DateTime"; DateTime)
        {
            Editable = false;

            trigger OnValidate()
            begin
                Error('Cannot be changed manually');
            end;
        }
        field(115; "Sent to Chase Bank Time"; DateTime)
        {
            Editable = false;

            trigger OnValidate()
            begin
                Error('Cannot be changed manually');
            end;
        }
        field(116; "Sent Online"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Bond No.")
        {
            Clustered = true;
        }
        key(Key2; "Bond Type")
        {
        }
        key(Key3; "Valid From")
        {
        }
        key(Key4; "Valid To")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lvConfirmString: Text[30];
        lvBondSecurity: Record "Bond Security";
    begin
        TestField("Bond Status", "Bond Status"::Open);
        lvConfirmString := StrSubstNo('Delete %1 Bond %2 by %3', Format("Bond Type"), "Bond No.", "Member Name");
        if Confirm(lvConfirmString, false) then begin
            lvBondSecurity.Reset;
            lvBondSecurity.SetRange("Bond No.", "Bond No.");
            lvBondSecurity.DeleteAll;
        end;
    end;

    trigger OnInsert()
    begin
        if "Bond No." = '' then begin
            BondSetup.Get;
            BondSetup.TestField("Bond Nos.");
            "Bond No." := NoSeriesMgt.GetNextNo(BondSetup."Bond Nos.");
            // NoSeriesMgt.InitSeries(BondSetup."Bond Nos.", xRec."No. Series", 0D, "Bond No.", "No. Series");
        end;

        "Created By" := UserId;
        "Bond Created DateTime" := CurrentDateTime;

        UserSetup.Get(UpperCase(UserId));
        //**IF UserSetup."Branch Code" = '' THEN ERROR('User must be assigned a branch');
        //"Branch Code":= UserSetup."Branch Code";
    end;

    trigger OnRename()
    begin
        TestField("Bond Status", "Bond Status"::Open);
    end;

    var
        Members: Record Members;
        PostCode: Record "Post Code";
        BondSetup: Record "Bond Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        BondCompany: Record "Bond Company";
        UserSetup: Record "User Setup";
        Bond: Record Bond;
        BondSecurity: Record "Bond Security";

    // [Scope('OnPrem')]
    // procedure AssistEdit(OldBond: Record Bond): Boolean
    // var
    //     Bond: Record Bond;
    // begin
    //     with Bond do begin
    //         Bond := Rec;
    //         BondSetup.Get;
    //         BondSetup.TestField("Bond Nos.");
    //         if NoSeriesMgt.SelectSeries(BondSetup."Bond Nos.", OldBond."No. Series", "No. Series") then begin
    //             NoSeriesMgt.SetSeries("Bond No.");
    //             Rec := Bond;
    //             exit(true);
    //         end;
    //     end;
    // end;

    procedure AssistEdit(OldBond: Record Bond): Boolean
    var
        Bond: Record Bond;
        NoSeries: Codeunit "No. Series";
        BondSetup: Record "Bond Setup";
    begin
        Bond.Copy(Rec);

        if not BondSetup.Get() then
            Error('Bond Setup is missing.');

        BondSetup.TestField("Bond Nos.");

        if NoSeries.LookupRelatedNoSeries(BondSetup."Bond Nos.", OldBond."No. Series", Bond."No. Series")
        then begin
            Bond."Bond No." := NoSeries.GetNextNo(Bond."No. Series");
            Rec := Bond;
            exit(true);
        end;

        exit(false);
    end;

    // [Scope('OnPrem')]
    procedure IssueBond(prBondNo: Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        lvBondSecurity: Record "Bond Security";
        lvFirstLineNo: Integer;
        lvLastLineNo: Integer;
        lvTotalAmtRequired: Decimal;
        lvChargeAmount: Decimal;
        lvCashCoverAmount: Decimal;
        lvPrimeAccNo: Code[20];
        lvDescriptionString: Text[100];
        lvRemainingAmtChg: Decimal;
        lvStimaChargePercent: Decimal;
        lvBondNoOfDays: Integer;
        lvVendor: Record "Savings Accounts";
        lvCashCoverAcct: Code[20];
        lvPrimeAvailableBalance: Decimal;
        lvStimaChargeShare: Decimal;
    begin
        BondSetup.Get;
        Bond.Get(prBondNo);
        BondSetup.TestField("Bond Post Gen. Journal Templat");
        BondSetup.TestField("Bond Post Gen. Journal Batch");


        BondSetup.TestField("Excise Duty Account");
        if Bond."Bond Type" = Bond."Bond Type"::"Bid-Bond" then begin
            BondSetup.TestField("Bid-Bond Charge %(per quarter)");
            if (BondSetup."Bid Bond Charge-Stima Share%" + BondSetup."Bid Bond Charge-Bank Share%") <> 100 then
                Error('Allocation percentages for Bid Bond Charges must sum up to 100');
            if BondSetup."Bid Bond Charge-Stima Share%" <> 0 then
                BondSetup.TestField("Bid-Bond Charges Income Acc.");
            if BondSetup."Bid Bond Charge-Bank Share%" <> 0 then
                BondSetup.TestField("Bid-Bond Chg Bank Share Vendor");
        end else
            if Bond."Bond Type" = Bond."Bond Type"::"Perfomance Bond" then begin
                BondSetup.TestField("Perf.Bond Charge%(per quarter)");
                if (BondSetup."Perf. Bond Charge-Stima Share%" + BondSetup."Perf. Bond Charge-Bank Share%") <> 100 then
                    Error('Allocation percentages for Bid Bond Charges must sum up to 100');
                if BondSetup."Perf. Bond Charge-Stima Share%" <> 0 then
                    BondSetup.TestField("Performance Charge Income Acc.");
                if BondSetup."Perf. Bond Charge-Bank Share%" <> 0 then
                    BondSetup.TestField("Perf.Bond Chg Bank Share Vendo");
            end;

        //determine charges to customer
        lvBondNoOfDays := Bond."Valid To" - Bond."Valid From";
        if Bond."Bond Type" = Bond."Bond Type"::"Bid-Bond" then begin
            lvChargeAmount := Round(lvBondNoOfDays / 90 * Bond.Amount * BondSetup."Bid-Bond Charge %(per quarter)" / 100, 0.05);
            if lvChargeAmount < BondSetup."Bid Bond Minimum Charge" then
                lvChargeAmount := BondSetup."Bid Bond Minimum Charge";
        end else
            if Bond."Bond Type" = Bond."Bond Type"::"Perfomance Bond" then begin
                lvChargeAmount := Round(lvBondNoOfDays / 90 * Bond.Amount * BondSetup."Perf.Bond Charge%(per quarter)" / 100, 0.05);
                if lvChargeAmount < BondSetup."Performance Bond Min. Charg" then
                    lvChargeAmount := BondSetup."Performance Bond Min. Charg";
            end;

        //determine if there is cash cover required to be deducted
        lvCashCoverAmount := 0;
        if Bond."Bond Type" = Bond."Bond Type"::"Perfomance Bond" then begin
            lvBondSecurity.Reset;
            lvBondSecurity.SetRange("Bond No.", Bond."Bond No.");
            lvBondSecurity.SetRange(Type, lvBondSecurity.Type::"Cash Cover");
            if lvBondSecurity.FindFirst then
                lvCashCoverAmount := lvBondSecurity.Value;
        end;

        //authenticate amounts
        // lvPrimeAccNo := GetMemberPrimeAccount(Bond."Member No.");
        if lvPrimeAccNo = '' then Error('No Unblocked Prime Account found for Member %1.', Bond."Member No.");
        if lvCashCoverAmount > 0 then begin
            BondSetup.TestField("Performance Bond Acc. Type");
            lvVendor.Reset;
            lvVendor.SetRange(lvVendor."Member No.", Bond."Member No.");
            lvVendor.SetRange(lvVendor."Product Type", BondSetup."Performance Bond Acc. Type");
            if not lvVendor.FindFirst then
                Error('Member %1 must have account of type %2 for Bond cash cover.',
                Bond."Member No.", BondSetup."Performance Bond Acc. Type")
            else begin
                if lvVendor.Blocked <> lvVendor.Blocked::" " then
                    Error('Member %1 account of type %2 is blocked.', Bond."Member No.", BondSetup."Performance Bond Acc. Type");
                lvCashCoverAcct := lvVendor."No.";
            end;
        end;

        //check of all monies are available
        lvChargeAmount := lvChargeAmount * 1.1;
        lvTotalAmtRequired := lvChargeAmount + lvCashCoverAmount;
        // lvPrimeAvailableBalance := CalculateAccountBalance(lvPrimeAccNo);
        if (lvTotalAmtRequired) > lvPrimeAvailableBalance then
            Error('Insufficient fund in Savings account. Required amount is %1', lvTotalAmtRequired);

        //start to post
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", BondSetup."Bond Post Gen. Journal Templat");
        GenJnlLine.SetRange("Journal Batch Name", BondSetup."Bond Post Gen. Journal Batch");
        if GenJnlLine.FindLast then
            lvFirstLineNo := GenJnlLine."Line No." + 10000
        else
            lvFirstLineNo := 10000;
        lvLastLineNo := lvFirstLineNo;

        //LINES FOR CHARGES
        //create line for debiting PRIME
        GenJnlLine.Reset;
        GenJnlLine."Journal Template Name" := BondSetup."Bond Post Gen. Journal Templat";
        GenJnlLine."Journal Batch Name" := BondSetup."Bond Post Gen. Journal Batch";
        GenJnlLine."Line No." := lvFirstLineNo;
        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Employee);
        GenJnlLine.Validate("Account No.", lvPrimeAccNo);
        GenJnlLine.Validate("Posting Date", Today);
        GenJnlLine.Validate("Document No.", Bond."Bond No.");
        lvDescriptionString := StrSubstNo('Charge-%1 to %2', Format(Bond."Bond Type"), Bond."Beneficiary Name");
        GenJnlLine.Description := CopyStr(lvDescriptionString, 1, 50);
        GenJnlLine.Validate(Amount, lvChargeAmount);
        GenJnlLine."Shortcut Dimension 1 Code" := Bond."Branch Code";
        GenJnlLine.Validate("Shortcut Dimension 1 Code");
        //GenJnlLine.Status := GenJnlLine.Status :: Approved;
        GenJnlLine.Insert;

        //add line for stma share
        lvStimaChargePercent := 0;
        if Bond."Bond Type" = Bond."Bond Type"::"Bid-Bond" then
            lvStimaChargePercent := BondSetup."Bid Bond Charge-Stima Share%"
        else
            if Bond."Bond Type" = Bond."Bond Type"::"Perfomance Bond" then
                lvStimaChargePercent := BondSetup."Perf. Bond Charge-Stima Share%";

        if lvStimaChargePercent > 0 then begin
            lvLastLineNo += 10000;
            lvStimaChargeShare := Round(lvChargeAmount * lvStimaChargePercent / 100, 0.1);
            GenJnlLine.Reset;
            GenJnlLine."Journal Template Name" := BondSetup."Bond Post Gen. Journal Templat";
            GenJnlLine."Journal Batch Name" := BondSetup."Bond Post Gen. Journal Batch";
            GenJnlLine."Line No." := lvLastLineNo;
            GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"G/L Account");
            if Bond."Bond Type" = Bond."Bond Type"::"Bid-Bond" then
                GenJnlLine.Validate("Account No.", BondSetup."Bid-Bond Charges Income Acc.")
            else
                if Bond."Bond Type" = Bond."Bond Type"::"Perfomance Bond" then
                    GenJnlLine.Validate("Account No.", BondSetup."Performance Charge Income Acc.");
            GenJnlLine.Validate("Posting Date", Today);
            GenJnlLine.Validate("Document No.", Bond."Bond No.");
            lvDescriptionString := StrSubstNo('Charge-%1 from %2', Format(Bond."Bond Type"), Bond."Member Name");
            GenJnlLine.Description := CopyStr(lvDescriptionString, 1, 50);
            GenJnlLine.Validate(Amount, -1 * (Round(lvStimaChargeShare / 1.1, 0.1)));
            GenJnlLine."Shortcut Dimension 1 Code" := Bond."Branch Code";
            GenJnlLine.Validate("Shortcut Dimension 1 Code");
            //GenJnlLine.Status := GenJnlLine.Status :: Approved;
            GenJnlLine.Insert;

            lvRemainingAmtChg := 0;
            lvRemainingAmtChg := lvStimaChargeShare + GenJnlLine.Amount;       //  GenJnlLine.Amount is negative
            lvLastLineNo += 10000;
            GenJnlLine.Reset;
            GenJnlLine."Journal Template Name" := BondSetup."Bond Post Gen. Journal Templat";
            GenJnlLine."Journal Batch Name" := BondSetup."Bond Post Gen. Journal Batch";
            GenJnlLine."Line No." := lvLastLineNo;
            GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"G/L Account");
            GenJnlLine.Validate("Account No.", BondSetup."Excise Duty Account");
            GenJnlLine.Validate("Posting Date", Today);
            GenJnlLine.Validate("Document No.", Bond."Bond No.");
            lvDescriptionString := StrSubstNo('%1 from %2', Format(Bond."Bond Type"), Bond."Member Name");
            GenJnlLine.Description := CopyStr(lvDescriptionString, 1, 50);
            GenJnlLine.Validate(Amount, -lvRemainingAmtChg);
            GenJnlLine."Shortcut Dimension 1 Code" := Bond."Branch Code";
            GenJnlLine.Validate("Shortcut Dimension 1 Code");
            //GenJnlLine.Status := GenJnlLine.Status :: Approved;
            GenJnlLine.Insert;
        end;

        lvRemainingAmtChg := 0;
        lvRemainingAmtChg := lvChargeAmount - lvStimaChargeShare;

        //line for chase bank - payable
        if lvRemainingAmtChg > 0 then begin
            lvLastLineNo += 10000;
            GenJnlLine.Reset;
            GenJnlLine."Journal Template Name" := BondSetup."Bond Post Gen. Journal Templat";
            GenJnlLine."Journal Batch Name" := BondSetup."Bond Post Gen. Journal Batch";
            GenJnlLine."Line No." := lvLastLineNo;
            GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Vendor);
            if Bond."Bond Type" = Bond."Bond Type"::"Bid-Bond" then
                GenJnlLine.Validate("Account No.", BondSetup."Bid-Bond Chg Bank Share Vendor")
            else
                if Bond."Bond Type" = Bond."Bond Type"::"Perfomance Bond" then
                    GenJnlLine.Validate("Account No.", BondSetup."Perf.Bond Chg Bank Share Vendo");
            GenJnlLine.Validate("Posting Date", Today);
            GenJnlLine.Validate("Document No.", Bond."Bond No.");
            lvDescriptionString := StrSubstNo('Chg-%1 from %2', Format(Bond."Bond Type"), Bond."Member Name");
            GenJnlLine.Description := CopyStr(lvDescriptionString, 1, 50);
            if Bond."Bond Type" = Bond."Bond Type"::"Bid-Bond" then
                GenJnlLine.Validate(Amount, -lvRemainingAmtChg)
            else
                if Bond."Bond Type" = Bond."Bond Type"::"Perfomance Bond" then
                    GenJnlLine.Validate(Amount, -lvRemainingAmtChg);
            GenJnlLine."Shortcut Dimension 1 Code" := Bond."Branch Code";
            GenJnlLine.Validate("Shortcut Dimension 1 Code");
            //GenJnlLine.Status := GenJnlLine.Status :: Approved;
            GenJnlLine.Insert;
        end;

        //LINES FOR CASH COVER
        if (lvCashCoverAmount > 0) and (Bond."Bond Type" = Bond."Bond Type"::"Perfomance Bond") then begin
            if lvCashCoverAcct = '' then Error('Cash Cover account for member must have be existing');
            //debit prime
            lvLastLineNo += 10000;
            GenJnlLine.Reset;
            GenJnlLine."Journal Template Name" := BondSetup."Bond Post Gen. Journal Templat";
            GenJnlLine."Journal Batch Name" := BondSetup."Bond Post Gen. Journal Batch";
            GenJnlLine."Line No." := lvLastLineNo;
            GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Employee);
            GenJnlLine.Validate("Account No.", lvPrimeAccNo);
            GenJnlLine.Validate("Posting Date", Today);
            GenJnlLine.Validate("Document No.", Bond."Bond No.");
            lvDescriptionString := StrSubstNo('Cash cover %1 to %2', Format(Bond."Bond Type"), Bond."Beneficiary Name");
            GenJnlLine.Description := CopyStr(lvDescriptionString, 1, 50);
            GenJnlLine.Validate(Amount, lvCashCoverAmount);
            GenJnlLine."Shortcut Dimension 1 Code" := Bond."Branch Code";
            GenJnlLine.Validate("Shortcut Dimension 1 Code");
            //GenJnlLine.Status := GenJnlLine.Status :: Approved;
            GenJnlLine.Insert;

            //credit cash cover
            lvLastLineNo += 10000;
            GenJnlLine.Reset;
            GenJnlLine."Journal Template Name" := BondSetup."Bond Post Gen. Journal Templat";
            GenJnlLine."Journal Batch Name" := BondSetup."Bond Post Gen. Journal Batch";
            GenJnlLine."Line No." := lvLastLineNo;
            GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Employee);
            GenJnlLine.Validate("Account No.", lvCashCoverAcct);
            GenJnlLine.Validate("Posting Date", Today);
            GenJnlLine.Validate("Document No.", Bond."Bond No.");
            lvDescriptionString := StrSubstNo('Cash cover %1 to %2', Format(Bond."Bond Type"), Bond."Beneficiary Name");
            GenJnlLine.Description := CopyStr(lvDescriptionString, 1, 50);
            GenJnlLine.Validate(Amount, -lvCashCoverAmount);
            GenJnlLine."Shortcut Dimension 1 Code" := Bond."Branch Code";
            GenJnlLine.Validate("Shortcut Dimension 1 Code");
            //GenJnlLine.Status := GenJnlLine.Status :: Approved;
            GenJnlLine.Insert;
        end;

        //POST LINES
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", BondSetup."Bond Post Gen. Journal Templat");
        GenJnlLine.SetRange("Journal Batch Name", BondSetup."Bond Post Gen. Journal Batch");
        GenJnlLine.SetRange("Line No.", lvFirstLineNo, lvLastLineNo);
        if GenJnlLine.FindSet then
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnlLine);
    end;

    // [Scope('OnPrem')]
    procedure RefundCashCover(prBondNo: Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        lvBondSecurity: Record "Bond Security";
        lvFirstLineNo: Integer;
        lvLastLineNo: Integer;
        lvCashCoverAmount: Decimal;
        lvPrimeAccNo: Code[20];
        lvDescriptionString: Text[100];
        lvVendor: Record "Savings Accounts";
        lvCashCoverAcct: Code[20];
        lvCashCoverAvailableBalance: Decimal;
    begin
        BondSetup.Get;
        Bond.Get(prBondNo);
        BondSetup.TestField("Bond Post Gen. Journal Templat");
        BondSetup.TestField("Bond Post Gen. Journal Batch");
        Bond.TestField("Bond Type", Bond."Bond Type"::"Perfomance Bond");
        Bond.TestField("Cash Cover Refunded", false);

        //determine if there is cash cover required to be deducted
        lvCashCoverAmount := 0;
        lvBondSecurity.Reset;
        lvBondSecurity.SetRange("Bond No.", Bond."Bond No.");
        lvBondSecurity.SetRange(Type, lvBondSecurity.Type::"Cash Cover");
        if lvBondSecurity.FindFirst then
            lvCashCoverAmount := lvBondSecurity.Value;

        if lvCashCoverAmount = 0 then Error('Cash cover was not retained during bond issuing.');

        //authenticate amounts
        // lvPrimeAccNo := GetMemberPrimeAccount(Bond."Member No.");
        if lvPrimeAccNo = '' then Error('No Unblocked Prime Account found for Member %1.', Bond."Member No.");

        BondSetup.TestField("Performance Bond Acc. Type");
        lvVendor.Reset;
        lvVendor.SetRange(lvVendor."Member No.", Bond."Member No.");
        lvVendor.SetRange(lvVendor."Product Type", BondSetup."Performance Bond Acc. Type");
        if not lvVendor.FindFirst then
            Error('Member %1 must have account of type %2 for Bond cash cover.',
            Bond."Member No.", BondSetup."Performance Bond Acc. Type")
        else begin
            if lvVendor.Blocked <> lvVendor.Blocked::" " then
                Error('Member %1 account of type %2 is blocked.', Bond."Member No.", BondSetup."Performance Bond Acc. Type");
            lvCashCoverAcct := lvVendor."No.";
        end;

        //check of all monies are available
        // lvCashCoverAvailableBalance := CalculateAccountBalance(lvCashCoverAcct);
        if (lvCashCoverAmount) > lvCashCoverAvailableBalance then
            Error('Insufficient fund in cash cover account. Available amount is %1', lvCashCoverAvailableBalance);

        //start to post
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", BondSetup."Bond Post Gen. Journal Templat");
        GenJnlLine.SetRange("Journal Batch Name", BondSetup."Bond Post Gen. Journal Batch");
        if GenJnlLine.FindLast then
            lvFirstLineNo := GenJnlLine."Line No." + 10000
        else
            lvFirstLineNo := 10000;
        lvLastLineNo := lvFirstLineNo;


        //LINES FOR CASH COVER
        if (lvCashCoverAmount > 0) and (Bond."Bond Type" = Bond."Bond Type"::"Perfomance Bond") then begin
            if lvCashCoverAcct = '' then Error('Cash Cover account for member must have be existing');
            //debit prime
            GenJnlLine.Reset;
            GenJnlLine."Journal Template Name" := BondSetup."Bond Post Gen. Journal Templat";
            GenJnlLine."Journal Batch Name" := BondSetup."Bond Post Gen. Journal Batch";
            GenJnlLine."Line No." := lvFirstLineNo;
            GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Employee);
            GenJnlLine.Validate("Account No.", lvPrimeAccNo);
            GenJnlLine.Validate("Posting Date", Today);
            GenJnlLine.Validate("Document No.", Bond."Bond No.");
            lvDescriptionString := StrSubstNo('Cash cover refund-%1 to %2', Format(Bond."Bond Type"), Bond."Beneficiary Name");
            GenJnlLine.Description := CopyStr(lvDescriptionString, 1, 50);
            GenJnlLine.Validate(Amount, -lvCashCoverAmount);
            //GenJnlLine.Status := GenJnlLine.Status :: Approved;
            GenJnlLine.Insert;

            //credit cash cover
            lvLastLineNo += 10000;
            GenJnlLine.Reset;
            GenJnlLine."Journal Template Name" := BondSetup."Bond Post Gen. Journal Templat";
            GenJnlLine."Journal Batch Name" := BondSetup."Bond Post Gen. Journal Batch";
            GenJnlLine."Line No." := lvLastLineNo;
            GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::Employee);
            GenJnlLine.Validate("Account No.", lvCashCoverAcct);
            GenJnlLine.Validate("Posting Date", Today);
            GenJnlLine.Validate("Document No.", Bond."Bond No.");
            lvDescriptionString := StrSubstNo('Cash cover refund-%1 to %2', Format(Bond."Bond Type"), Bond."Beneficiary Name");
            GenJnlLine.Description := CopyStr(lvDescriptionString, 1, 50);
            GenJnlLine.Validate(Amount, lvCashCoverAmount);
            //GenJnlLine.Status := GenJnlLine.Status :: Approved;
            GenJnlLine.Insert;
        end;

        //POST LINES
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", BondSetup."Bond Post Gen. Journal Templat");
        GenJnlLine.SetRange("Journal Batch Name", BondSetup."Bond Post Gen. Journal Batch");
        GenJnlLine.SetRange("Line No.", lvFirstLineNo, lvLastLineNo);
        if GenJnlLine.FindSet then
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnlLine);

        Bond."Cash Cover Refunded" := true;
        Bond.Modify;
    end;

    // [Scope('OnPrem')]
    procedure GetMemberPrimeAccount(prMemberNo: Code[20]) PrimeAccNo: Code[20]
    var
        lvVendor: Record "Savings Accounts";
    begin
        lvVendor.Reset;
        lvVendor.SetRange(lvVendor."Member No.", prMemberNo);
        lvVendor.SetRange(lvVendor."Loan Disbursement Account", true);
        if lvVendor.FindFirst then
            exit(lvVendor."No.")
        else
            exit('');
    end;

    // [Scope('OnPrem')]
    procedure CalculateAccountBalance(AccountNo: Code[20]) AccountAvailableBalance: Decimal
    var
        SavingsAccounts: Record "Savings Accounts";
        lvMinBalance: Decimal;
    begin
        AccountAvailableBalance := 0;
        SavingsAccounts.Reset;
        //Vendor.SETRANGE (Vendor."Creditor Type",Vendor."Creditor Type" :: Account);
        SavingsAccounts.SetFilter(SavingsAccounts."No.", AccountNo);
        if SavingsAccounts.FindFirst then begin
            lvMinBalance := 0;
            if SavingsAccounts."Product Type" = 'PRIME' then
                lvMinBalance := 500;
            if SavingsAccounts."Product Type" = 'JUNIOR' then
                lvMinBalance := 500;

            SavingsAccounts.CalcFields("Balance (LCY)", "Uncleared Cheques", "ATM Transactions");
            AccountAvailableBalance := SavingsAccounts."Balance (LCY)" - (SavingsAccounts."Uncleared Cheques" + SavingsAccounts."ATM Transactions" + lvMinBalance); //add minimum balance
            exit(AccountAvailableBalance);
        end;
    end;
}

