#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185485 "FA Journals"
{
    Format = VariableText;

    schema
    {
        textelement(Name)
        {
            tableelement("FA Journal";"FA Journal Line")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'FAJournals';
                fieldelement(a; "FA Journal"."Journal Template Name")
                {
                    FieldValidate = no;
                }
                fieldelement(b; "FA Journal"."Journal Batch Name")
                {
                    FieldValidate = no;
                }
                fieldelement(c; "FA Journal"."Line No.")
                {
                    FieldValidate = no;
                }
                fieldelement(d; "FA Journal"."Depreciation Book Code")
                {
                    FieldValidate = no;
                }
                fieldelement(e; "FA Journal"."FA Posting Type")
                {
                    FieldValidate = no;
                }
                fieldelement(f; "FA Journal"."FA No.")
                {
                    FieldValidate = no;
                }
                fieldelement(g; "FA Journal"."FA Posting Date")
                {
                    FieldValidate = no;
                }
                fieldelement(h; "FA Journal"."Document No.")
                {
                    FieldValidate = no;
                }
                fieldelement(i; "FA Journal".Description)
                {
                    FieldValidate = no;
                }
                fieldelement(j; "FA Journal".Amount)
                {
                    FieldValidate = no;
                }


                fieldelement(k; "FA Journal"."FA Posting Group")
                {
                    FieldValidate = no;
                }
                fieldelement(l; "FA Journal"."Shortcut Dimension 1 Code")
                {
                    FieldValidate = no;
                }


                fieldelement(m; "FA Journal"."Shortcut Dimension 2 Code")
                {
                    FieldValidate = no;
                    MinOccurs=zero;
                }
                


            }
        }
    }
    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Process completed successfully');
    end;
}