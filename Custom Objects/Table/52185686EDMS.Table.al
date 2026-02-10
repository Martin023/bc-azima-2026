table 52185686 EDMS
{

    fields
    {
        field(1; "url path"; Text[200])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Key"; Option)
        {
            OptionMembers = " ","Member File","Member Statement",Invoice,"Delivery Note","Evaluation Report","Proc File","Employee File","Loan File","member App","Board Minutes","Interview Results","Award Letter",Contract,"Loan App","Online Loans","Appraisal File";
        }
    }

    keys
    {
        key(Key1; "url path")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

