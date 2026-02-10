xmlport 52185435 "General SMS Lines"
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement("General SMS Lines"; "General SMS Lines")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'GeneralSMS';


                fieldelement(a; "General SMS Lines"."Phone Number")
                {
                    FieldValidate = yes;
                }
                fieldelement(b; "General SMS Lines"."Header No")
                {
                    FieldValidate = no;
                }
                //                 fieldelement(b; "General SMS Lines".SMS)
                // {
                //     FieldValidate = no;
                // }

            }
        }
    }
    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Uploaded successfully');
    end;
}
