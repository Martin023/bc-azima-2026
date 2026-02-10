#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185542 Member
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement(Membership;"Members")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a;Membership."No.")
                {
                    FieldValidate = No;
                }
                fieldelement(b;Membership.Salutation)
                {
                    FieldValidate=No;
                }
                fieldelement(c;Membership."name")
                {
                    FieldValidate=No;
                }
                fieldelement(d;Membership."First Name")
                {
                    FieldValidate=No;
                }
                fieldelement(e;Membership."Middle Name")
                {
                    FieldValidate=No;
                }
                fieldelement(f;Membership."Other Names")
                {
                    FieldValidate=No;
                }
                fieldelement(g;Membership."Current Address")
                {
                    FieldValidate=no;
                }
                fieldelement(h;Membership."Home Address")
                {
                    FieldValidate=No;
                }
                fieldelement(i;Membership."Phone No.")
                {
                    FieldValidate=no;
                }
                fieldelement(j;Membership."Global Dimension 1 Code")
                {
                    FieldValidate=No;
                }
                fieldelement(k;Membership."Global Dimension 2 Code")
                {
                    FieldValidate=no;
                }
                fieldelement(l;Membership.Nationality)
                {
                    FieldValidate=no;
                }
                fieldelement(m;Membership."Post Code")
                {
                    FieldValidate=no;
                }
                fieldelement(n;Membership."E-Mail")
                {
                    FieldValidate=no;
                }
                fieldelement(o;Membership."Responsibility Center")
                {
                    FieldValidate=no;
                }
                fieldelement(p;Membership."Registration Date")
                {
                    FieldValidate=no;
                }
                fieldelement(q;Membership.Status)
                {
                    FieldValidate=no;
                }
                fieldelement(r;Membership.Subflag)
                {
                    FieldValidate=no;
                }
                fieldelement(s;Membership."Employer Code")
                {
                    FieldValidate=no;
                }
                fieldelement(t;Membership.County)
                {
                    FieldValidate=No;

                }
                fieldelement(u;Membership."Terms of Employment")
                {
                    FieldValidate=no;

                }
                fieldelement(v;Membership."Work Station")
                {
                    FieldValidate=no;
                }
                fieldelement(w;Membership."Country Of Operation")
                {
                    FieldValidate=no;
                }
                fieldelement(x;Membership."Employment Designation")
                {
                    FieldValidate=no;
                }
                fieldelement(y;Membership.City)
                {
                    FieldValidate=No;
                }
                fieldelement(z;Membership."Date of Birth")
                {
                    FieldValidate=No;
                }
                fieldelement(aa;Membership."Payroll/Staff No.")
                {
                    FieldValidate=No;
                }
                fieldelement(ab;membership."Marital Status")
                {
                    FieldValidate=no;

                }
                fieldelement(ac;Membership.Gender)
                {
                    FieldValidate=no;
                }
                fieldelement(ad;Membership."Account Category")
                {
                    FieldValidate=no;
                }
                fieldelement(ae;Membership."Group Account No.")
                {
                    FieldValidate=no;
                }
                fieldelement(af;Membership."Type of Application")
                {
                    FieldValidate=no;
                }
                fieldelement(ag;Membership."Member Class")
                {
                    FieldValidate=no;
                }
                fieldelement(ah;Membership."Account Type")
                {
                    FieldValidate=No;
                }
                 fieldelement(ai;Membership."Account Profile")
                {
                    FieldValidate=No;
                }
                fieldelement(aj;Membership.Religion)
                {
                    FieldValidate = No;
                }
                fieldelement(ak;Membership."P.I.N Number")
                {
                    FieldValidate=No;
                }
                fieldelement(al;Membership."Rejoinig Date")
                {
                    FieldValidate=No;
                }
                fieldelement(am;Membership."Primary Identification Type")
                {
                    FieldValidate=No;
                    MinOccurs=zero;
                }
                fieldelement(an;Membership."Secondary Identification Type")
                {
                    FieldValidate=No;
                    MinOccurs=zero;
                }
                fieldelement(ao;Membership."Primary Identification")
                {
                    FieldValidate=No;
                    MinOccurs=zero;
                }
                fieldelement(ap;Membership."Secondary Identification")
                {
                    FieldValidate=no;
                    MinOccurs=zero;
                }
                fieldelement(aq;Membership."From Another Sacco")
                {
                    FieldValidate=No;
                    MinOccurs=zero;
                }
                fieldelement(ar;Membership."Old Member No.")
                {
                    FieldValidate=no;
                    MinOccurs=zero;
                }
                fieldelement(as;Membership."Principle Member")
                {
                    FieldValidate=No;
                    MinOccurs=zero;
                }
                fieldelement(at;Membership."Recruited By")
                {
                    FieldValidate=no;
                    MinOccurs=zero;
                }
                fieldelement(au;Membership."Recruited By Name")
                {
                    FieldValidate=no;
                    MinOccurs=zero;
                }
                fieldelement(av;Membership."Recruited by Type")
                {
                    FieldValidate=no;
                    MinOccurs=zero;
                }
                fieldelement(aw;Membership."Has Joined Business Loans")
                {
                    FieldValidate=no;
                    MinOccurs=zero;
                }
                fieldelement(ax;Membership."Electrol Zone Descr.")
                {
                    FieldValidate=no;
                    MinOccurs=zero;
                }
                fieldelement(ay;Membership."CRM Application No.")
                {
                    FieldValidate=no;
                    MinOccurs=zero;
                }
                fieldelement(az;Membership."Contribution Start Date")
                {
                    FieldValidate=no;
                    MinOccurs=zero;
                }
                fieldelement(ba;Membership."Transactional Mobile Number")
                {
                    FieldValidate=no;
                    MinOccurs=zero;
                }
                fieldelement(bb;Membership.Age)
                {
                    FieldValidate=no;
                    MinOccurs=zero;
                }
                fieldelement(bc;Membership."TSC Number")
                {
                    FieldValidate=No;
                    MinOccurs=zero;

                }
                fieldelement(bd;Membership."Company Registration No.")
                {
                    FieldValidate=no;
                    MinOccurs=zero;

                }
                fieldelement(be;Membership."Allocated Officer")
                {
                    FieldValidate=no;
                    MinOccurs=zero;
                }
                fieldelement(bf;Membership."Allocated Officer Name")
                {
                    FieldValidate=no;
                    MinOccurs=zero;
                }
                fieldelement(bg;Membership."Contribution Effective Date")
                {
                    FieldValidate=no;
                    MinOccurs=zero;
                }
                fieldelement(bh;Membership."Delegates Zone")
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
        Message('Members Upload completed successfully');
    end;
}