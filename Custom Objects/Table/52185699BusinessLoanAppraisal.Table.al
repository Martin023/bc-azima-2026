table 52185699 "Business Loan Appraisal"
{

    fields
    {
        field(1; "Loan No."; Code[50])
        {
        }
        field(2; "Financial Classification Code"; Option)
        {
            Editable = false;
            OptionCaption = 'Cash Sales,Credit sales,Cost of Sales,Household Income,Business Expenses,Houselold Expenses,Current Assets,Fixed Assets,Short Term Liabilities,Long Term Liabilities,Current Assets(Stock),Formula';
            OptionMembers = "Cash Sales","Credit sales","Cost of Sales","Household Income","Business Expenses","Houselold Expenses","Current Assets","Fixed Assets","Short Term Liabilities","Long Term Liabilities","Current Assets(Stock)",Formula;
        }
        field(3; Description; Text[50])
        {
            Editable = false;
        }
        field(4; "Amount (LCY)"; Decimal)
        {
        }
        field(5; "Code"; Code[50])
        {
            Editable = false;
            TableRelation = "Financial Appraisal setup"."Classifiaction Code";

            trigger OnValidate()
            begin
                if FinCode.Get(Code) then
                    "Financial Classification Code" := FinCode."Financial Classifiaction";
            end;
        }
        field(6; Position; Integer)
        {
            Editable = false;
        }
        field(7; "Loan With Sacco"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Loan No.", Position)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        FinCode: Record "Financial Appraisal setup";
}

