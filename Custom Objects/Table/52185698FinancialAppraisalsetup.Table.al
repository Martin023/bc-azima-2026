table 52185698 "Financial Appraisal setup"
{

    fields
    {
        field(1; "Classifiaction Code"; Code[50])
        {
        }
        field(2; "Financial Classifiaction"; Option)
        {
            OptionCaption = 'Cash Sales,Credit sales,Cost of Sales,Household Income,Business Expenses,Houselold Expenses,Current Assets,Fixed Assets,Short Term Liabilities,Long Term Liabilities,Current Assets(Stock),Formula';
            OptionMembers = "Cash Sales","Credit sales","Cost of Sales","Household Income","Business Expenses","Houselold Expenses","Current Assets","Fixed Assets","Short Term Liabilities","Long Term Liabilities","Current Assets(Stock)",Formula;
        }
        field(3; Description; Text[30])
        {
        }
        field(4; Position; Integer)
        {
        }
    }

    keys
    {
        key(Key1; Position, "Classifiaction Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

