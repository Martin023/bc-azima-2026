table 52185675 "HR Staff Loan Typesw"
{
    // DrillDownPageID = "HR Shift Management Card";
    // LookupPageID = "HR Shift Management Card";

    fields
    {
        field(1; "Code"; Code[10])
        {

            trigger OnValidate()
            begin
                if Code <> xRec.Code then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."HR Loan Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Product Description"; Text[30])
        {
        }
        field(3; "Source of Financing"; Code[10])
        {
        }
        field(4; "Interest rate"; Decimal)
        {
        }
        field(9; "Interest Calculation Method"; Option)
        {
            OptionMembers = ,"No Interest","Flat Rate","Reducing Balances";
        }
        field(11; "Insurance %"; Decimal)
        {
        }
        field(17; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(24; "Grace Period"; DateFormula)
        {
        }
        field(26; "Name of Source of Funding"; Text[30])
        {
            Editable = false;
        }
        field(27; Rounding; Option)
        {
            OptionMembers = Nearest,Down,Up;
        }
        field(28; "Rounding Precision"; Decimal)
        {
            InitValue = 1;
            MaxValue = 1;
            MinValue = 0.01;
        }
        field(30; "No of Installment"; Integer)
        {
        }
        field(31; "Loan No Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(32; "New Numbers"; Code[10])
        {
        }
        field(33; "Instalment Period"; DateFormula)
        {
        }
        field(40; "Max. Loan Amount"; Decimal)
        {
        }
        field(44; "Repayment Method"; Option)
        {
            OptionMembers = Amortised,"Reducing Balance","Straight Line",Constants;
        }
        field(45; "Grace Period - Principle (M)"; Integer)
        {
        }
        field(46; "Grace Period - Interest (M)"; Integer)
        {
        }
        field(47; "Min. Loan Amount"; Decimal)
        {
        }
        field(50; "Loan Account"; Code[20])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin

            end;
        }
        field(51; "Loan Interest Account"; Code[20])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin

            end;
        }
        field(52; "Receivable Interest Account"; Code[20])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin

            end;
        }
        field(54; "Action"; Option)
        {
            OptionCaption = ' ,Off Set Commitments,Discounting';
            OptionMembers = " ","Off Set Commitments",Discounting;
        }
        field(56; "Top Up Commision Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(57; "Top Up Commision"; Decimal)
        {
        }
        field(58; Source; Option)
        {
            OptionCaption = 'BOSA,FOSA,Investment,MICRO,HR';
            OptionMembers = BOSA,FOSA,Investment,MICRO,HR;
        }
        field(59; "Recovery Priority"; Integer)
        {
        }
        field(60; "Check Off Recovery"; Boolean)
        {
        }
        field(61; "SMS Description"; Text[50])
        {
        }
        field(62; "Default Installements"; Integer)
        {
        }
        field(63; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(64; Applications; Decimal)
        {
        }
        field(65; "Issued Amount"; Decimal)
        {
        }
        field(66; "Min No. Of Guarantors"; Integer)
        {
        }
        field(67; "Min Re-application Period"; DateFormula)
        {
        }
        field(68; "Check Off Loan No."; Integer)
        {
        }
        field(72; "Mode of Qualification"; Option)
        {
            OptionCaption = 'Normal Sacco,Fosa,Security';
            OptionMembers = "Normal Sacco",Fosa,Security;
        }
        field(73; "Product Currency Code"; Code[10])
        {
            Editable = false;
            TableRelation = Currency.Code;
        }
        field(76; "Repayment Frequency"; Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quaterly,Yearly';
            OptionMembers = Daily,Weekly,Monthly,Quaterly,Yearly;
        }
        field(82; "Recovery Mode"; Option)
        {
            OptionCaption = 'Checkoff,Standing Order,Salary';
            OptionMembers = Checkoff,"Standing Order",Salary;
        }
        field(83; "Deposit Multiplier"; Decimal)
        {
        }
        field(84; "Car Loan"; Boolean)
        {
        }
        field(85; "Min Application Period"; DateFormula)
        {
        }
        field(86; "Salary Multiplier"; Decimal)
        {
        }
        field(87; "Payroll Code"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Recovery Priority")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", "Product Description")
        {
        }
    }

    trigger OnDelete()
    begin

    end;

    trigger OnInsert()
    begin
        //IF Source=Source::BOSA THEN BEGIN
        if Code = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."HR Loan Nos.");
            "Code" := NoSeriesMgt.GetNextNo(HRSetup."HR Loan Nos.");
            // NoSeriesMgt.InitSeries(HRSetup."HR Loan Nos.", xRec."No. Series", 0D, Code, "No. Series");
        end;
    end;

    trigger OnModify()
    begin


    end;

    trigger OnRename()
    begin

    end;

    var
        HRSetup: Record "HR Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        Text000: Label 'You cannot change %1 because there are one or more ledger entries associated with this account.';

    [Scope('OnPrem')]
    procedure TestNoEntriesExist(CurrentFieldName: Text[100]; GLNO: Code[20])
    var
        GLLedgEntry: Record "G/L Entry";
    begin
        /*

         //To prevent change of field
        GLLedgEntry.SETCURRENTKEY(GLLedgEntry."G/L Account No.");
        GLLedgEntry.SETRANGE("G/L Account No.",GLNO);
       IF GLLedgEntry.FIND('-') THEN
         ERROR(
         Text000,
          CurrentFieldName)
          */

    end;
}

