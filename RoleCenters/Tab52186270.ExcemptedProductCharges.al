table 52186270 "Excempted Product Charges"
{
    Caption = 'Excempted Product Charges';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Charge Code"; Code[20])
        {
            TableRelation = "Loan Charges"."Charge Code";

            trigger OnValidate()
            begin
                if LoanChg.Get("Charge Code") then begin
                    "Charge Description" := LoanChg."Charge Description";
                    "Charge Amount" := LoanChg."Charge Amount";
                    "Charge Method" := LoanChg."Charge Method";
                    Percentage := LoanChg.Percentage;
                    "Charging Option" := LoanChg."Charging Option";
                    "Effect Excise Duty" := LoanChg."Effect Excise Duty";
                end;
            end;
        }
        field(2; "Charge Description"; Text[70])
        {
        }
        field(3; "Charge Amount"; Decimal)
        {
        }
        field(4; "Use Percentage"; Boolean)
        {
            Enabled = true;
        }
        field(5; Percentage; Decimal)
        {
        }
        field(6; "Charge Type"; Option)
        {
            OptionCaption = 'General,Top up,External Loan,Deposit Boosting,Asset Finance,Loan Restructure,Loan Reschedule';
            OptionMembers = General,"Top up","External Loan",Boosting,"Asset Finance","Loan Restructure","Loan Reschedule",;
        }
        field(7; "Charging Option"; Option)
        {
            OptionMembers = ,"On Approved Amount","On Net Amount";
        }
        field(8; "Product Code"; Code[20])
        {
        }
        field(21; "Loan No."; Code[20])
        {
        }
        field(9; "Charges G_L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(10; Minimum; Decimal)
        {
        }
        field(11; Maximum; Decimal)
        {
        }
        field(12; "Additional Charge %"; Decimal)
        {
        }
        field(13; "Effect Excise Duty"; Option)
        {
            Editable = false;
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;
        }
        field(14; Prorate; Option)
        {
            OptionCaption = ' ,Appraisal,Insurance';
            OptionMembers = " ",Appraisal,Insurance;
        }
        field(15; "Charge Method"; Option)
        {
            OptionCaption = 'Flat Amount,% of Amount,Staggered';
            OptionMembers = "Flat Amount","% of Amount",Staggered;
        }
        field(16; "Staggered Charge Code"; Code[20])
        {
            TableRelation = "Tiered Charges Header";
        }
        field(17; Excempt; Boolean)
        {
            trigger OnValidate()
            var
                myInt: Integer;
                GenSetup: Record "General Set-Up";
                Loans: Record Loans;
                SalProc: Record "Salary Lines";
                EndDateSalo: date;
            begin
                GenSetup.Get();
                if GenSetup."Excempt Charges Expiry Date" <> 0D then
                    if GenSetup."Excempt Charges Expiry Date" < today then Error('The expiry for this process exceeded. Date %1 .', GenSetup."Excempt Charges Expiry Date");
                if excempt = true then begin
                    Loans.get(Rec."Loan No.");
                    //EndDateSalo:=calcdate('40D',today);
                    SalProc.Reset;
                    SalProc.SetRange("Member No.", Loans."Member No.");
                    // SalProc.SetRange("Posting Date", EndDateSalo, Today);
                    SalProc.SetRange(Posted, true);
                    if not SalProc.Find('-') then begin
                        Error('This member has not channeled salary through the sacco.');
                    end;
                    "Excempt By" := UserId;
                    "Excempt Date" := Today;
                    "Excempt Date Time" := time;
                end;
            end;
        }
        field(18; "Excempt Date"; Date)
        {
            Editable = false;
        }
        field(19; "Excempt Date Time"; Time)
        {
            Editable = false;
        }
        field(20; "Excempt By"; Code[50])
        { Editable = false; }

    }

    keys
    {
        key(Key1; "Charge Code", "Product Code", "Loan No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Charge Code", "Charge Description")
        {

        }
    }
    trigger OnDelete()
    begin
        ValidateEntries;

    end;

    trigger OnInsert()
    begin
        ValidateEntries
    end;

    trigger OnModify()
    begin
        ValidateEntries;
    end;

    procedure ValidateEntries()
    begin
        if Loans.get(Rec."Loan No.") then begin
            if Loans.Status <> Loans.status::Open then
                error('You can not modify charges when the Loans status is ' + format(Loans.Status) + '.');
        end;
    end;

    var
        LoanChg: Record "Loan Charges";
        PFact: Record "Product Factory";
        Loans: Record loans;
}

