#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185491 " Next of Kinup"
{

    Format = VariableText;
    Direction = Both;

    schema
    {
        textelement(Root)
        {
            tableelement("Next of KIN"; "Next of KIN")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'NextKin';
                fieldelement(a; "Next of KIN"."Record ID")
                {
                    FieldValidate = no;
                }
                fieldelement(b; "Next of KIN".Identification)
                {
                    FieldValidate = no;
                }
                fieldelement(c; "Next of KIN".Name)
                {
                    FieldValidate = No;
                }



            }
        }
    }

    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Upload of next of Kin successful');
    end;
}
