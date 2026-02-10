#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185500 "Import Telephone Nos"
{
    Format = VariableText;

    schema
    {
        textelement("<import_bulksms>")
        {
            XmlName = 'Import_BulkSMS';
            tableelement("Bulk SMS Lines"; "Bulk SMS Lines")
            {
                XmlName = 'Import_BulkSMS';
                fieldelement(No; "Bulk SMS Lines".No)
                {
                }
                fieldelement(MemberNo; "Bulk SMS Lines"."Member No")
                {
                    FieldValidate = No;
                    MinOccurs = Zero;
                }
                fieldelement(Code; "Bulk SMS Lines".Code)
                {
                    FieldValidate = No;
                    MinOccurs = Zero;
                }
                fieldelement(SMSMessages; "Bulk SMS Lines"."Text Message")
                {
                    FieldValidate = No;
                    MinOccurs = Zero;
                }
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }
}
