#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185508 " Next of Kin"
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
                 fieldelement(a;"Next of KIN"."Record ID")
                {
                FieldValidate=no;
                }
                fieldelement(b;"Next of KIN".Identification)
                {
                    FieldValidate=no;
                }
                fieldelement(c; "Next of KIN".Name)
                {
                     FieldValidate=No;
                }
                fieldelement(d; "Next of KIN".Relationship)
                {
                     FieldValidate=No;
                }
                 fieldelement(e; "Next of KIN"."Is a Beneficiary")
                 {
                    FieldValidate=no;
                 }
                 fieldelement(f;"Next of KIN"."Date of Birth")
                 {
                    FieldValidate=no;
                 }
                 fieldelement(g;"Next of KIN".Address)
                 {
                    FieldValidate=no;
                 }
                fieldelement(h; "Next of KIN".Telephone)
                {
                    FieldValidate=no;
                }
                 fieldelement(i; "Next of KIN".Email)
                {
                     FieldValidate=No;
                }
                fieldelement(j;"Next of KIN".Allocation)
                {
                FieldValidate=no;
                }
                fieldelement(k;"Next of KIN".Deceased)
                {
                    FieldValidate=no;
                }
                fieldelement(l; "Next of KIN"."Is Nominee")
                {
                     FieldValidate=No;
                }
                fieldelement(m; "Next of KIN"."Identification Type")
                {
                     FieldValidate=No;
                }
                 fieldelement(n; "Next of KIN"."Is Contact Person")
                 {
                    FieldValidate=no;
                 }
                 fieldelement(o;"Next of KIN".Removed)
                 {
                    FieldValidate=no;
                 }
                 fieldelement(p;"Next of KIN"."Is A WitNess")
                 {
                    FieldValidate=no;
                 }
                fieldelement(q; "Next of KIN"."Member Name")
                {
                    FieldValidate=no;
                }
                 fieldelement(r; "Next of KIN"."Date Approved")
                {
                     FieldValidate=No;
                }
                fieldelement(s; "Next of KIN".Gender)
                {
                     FieldValidate=No;
                }
                fieldelement(t; "Next of KIN"."Member Name")
                {
                     FieldValidate=No;
                     MinOccurs=zero;
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
