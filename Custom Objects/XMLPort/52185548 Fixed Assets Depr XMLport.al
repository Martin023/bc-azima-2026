#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185548 "Fixed Asset Dpr Book"
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement("FA Depreciation Book";"FA Depreciation Book" )
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a;"FA Depreciation Book"."FA No.")
                {
                    FieldValidate = No;
                }
                fieldelement(b;"FA Depreciation Book"."Depreciation Book Code")
                {
                    FieldValidate = No;
                }
                fieldelement(c;"FA Depreciation Book"."Depreciation Method")
                {
                    FieldValidate = No;
                }
                fieldelement(d;"FA Depreciation Book"."Depreciation Starting Date")
                {
                    FieldValidate = No;
                }
                fieldelement(e;"FA Depreciation Book"."Straight-Line %")
                {
                    FieldValidate = No;
                }
                fieldelement(f;"FA Depreciation Book"."FA Posting Group")
                {
                    FieldValidate = No;
                }
                fieldelement(g;"FA Depreciation Book"."Depreciation Ending Date")
                {
                    FieldValidate = No;
                }
                fieldelement(h;"FA Depreciation Book"."Acquisition Date")
                {
                    FieldValidate = No;
                }
                fieldelement(i;"FA Depreciation Book"."Disposal Date")
                {
                    FieldValidate = No;
                }
                fieldelement(j;"FA Depreciation Book"."Last Acquisition Cost Date")
                {
                    FieldValidate = No;
                }
                fieldelement(k;"FA Depreciation Book"."Last Depreciation Date")
                {
                    FieldValidate = No;
                }
                fieldelement(l;"FA Depreciation Book"."Last Appreciation Date")
                {
                    FieldValidate = No;
                }
                fieldelement(m;"FA Depreciation Book".Description)
                {
                    FieldValidate = No;
                }
                fieldelement(n;"FA Depreciation Book"."Main Asset/Component")
                {
                    FieldValidate = No;
                }
                fieldelement(o;"FA Depreciation Book"."Component of Main Asset")
                {
                    FieldValidate = No;
                }
                fieldelement(p;"FA Depreciation Book"."Default FA Depreciation Book")
                {
                    MinOccurs=zero;
                    FieldValidate = No;
                }

  

            }
        }
    }

    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Upload of loans successful');
    end;
}
