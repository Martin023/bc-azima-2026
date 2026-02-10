table 52185734 "Loan Product Charges"
{

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

    }

    keys
    {
        key(Key1; "Charge Code", "Product Code")
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
        if PFact.get(Rec."Product Code") then begin
            if Pfact.Status <> Pfact.status::Open then
                error('You can not modify charges when the product status is ' + format(Pfact.Status) + '.');
        end;
    end;

    var
        LoanChg: Record "Loan Charges";
        PFact: Record "Product Factory";
}

