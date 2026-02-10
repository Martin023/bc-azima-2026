xmlport 52185560 "Employee Upload"
{
    Caption = 'Employees';
    Format=VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement(HREmployees; "HR Employees")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                
                fieldelement(a; HREmployees."No.")
                {
                    FieldValidate=no;
                }
                fieldelement(b; HREmployees."First Name")
                {
                    FieldValidate=no;
                }
                fieldelement(c; HREmployees."Middle Name")
                {
                    FieldValidate=no;
                }
                fieldelement(d; HREmployees."Last Name")
                {
                    FieldValidate=no;
                }
                fieldelement(e;HREmployees."Date Of Birth")
                {
                    FieldValidate=no;
                }
                fieldelement(f;HREmployees."Full Name")
                {
                    FieldValidate=no;
                }
                fieldelement(g; HREmployees.City)
                {
                    FieldValidate=no;
                }
              
                fieldelement(h; HREmployees."Postal Address")
                {
                    FieldValidate=no;
                }
                fieldelement(i; HREmployees.County)
                {
                    FieldValidate=no;
                }
                fieldelement(j; HREmployees."Home Phone Number")
                {
                    FieldValidate=no;
                }
                fieldelement(k; HREmployees."Cellular Phone Number")
                {
                    FieldValidate=no;
                }
                fieldelement(l; HREmployees."E-Mail")
                {
                    FieldValidate=no;
                }
        
                fieldelement(m; HREmployees."ID Number")
                {
                    FieldValidate=no;
                }
             
                fieldelement(n; HREmployees.Gender)
                {
                    FieldValidate=no;
                }
                fieldelement(o; HREmployees.Status)
                {
                    FieldValidate=no;
                }
                fieldelement(p; HREmployees."Company E-Mail")
                {
                    FieldValidate=no;
                }
             
                fieldelement(q; HREmployees."Full / Part Time")
                {
                    FieldValidate=no;
                }
                
                fieldelement(r;HREmployees."Contract Type")
                {
                    FieldValidate=no;
                }
                 fieldelement(s;HREmployees."Contract End Date")
                {
                    FieldValidate=no;
                }
                fieldelement(t; HREmployees."Marital Status")
                {
                    FieldValidate=no;
                }
                fieldelement(u; HREmployees."Vehicle Registration Number")
                {
                    FieldValidate=no;
                }
                fieldelement(v; HREmployees.Disabled)
                {
                    FieldValidate=no;
                }
                fieldelement(w; HREmployees.Initials)
                {
                    FieldValidate=no;
                }
                fieldelement(x; HREmployees.Age)
                {
                    FieldValidate=no;
                }
                fieldelement(y; HREmployees."End Of Probation Date")
                {
                    FieldValidate=no;
                }
               fieldelement(z; HREmployees."Pension Scheme Join")
                {
                    FieldValidate=no;
                }
                fieldelement(aa; HREmployees."Medical Scheme Join")
                {
                    FieldValidate=no;
                }
                fieldelement(ab; HREmployees."Allow Overtime")
                {
                    FieldValidate=no;
                }
               fieldelement(ac; HREmployees."First Language (R/W/S)")
                {
                    FieldValidate=no;
                }
                 fieldelement(ad; HREmployees."Second Language (R/W/S)")
                {
                    FieldValidate=no;
                }
                fieldelement(ae; HREmployees."Additional Language")
                {
                    FieldValidate=no;
                }
                fieldelement(af; HREmployees."Job ID")
                {
                    FieldValidate=no;
                }
                fieldelement(ag;HREmployees."Date Of Join")
                {
                    FieldValidate=no;
                }
                fieldelement(ah; HREmployees.Citizenship)
                {
                    FieldValidate=no;
                }
              
                fieldelement(ai; HREmployees."Name Of Manager")
                {
                    FieldValidate=no;
                }
                fieldelement(aj; HREmployees."User ID")
                {
                    FieldValidate=no;
                }
                fieldelement(ak; HREmployees."PIN No.")
                {
                    FieldValidate=no;
                }
                fieldelement(al; HREmployees."NSSF No.")
                {
                    FieldValidate=no;
                }
                fieldelement(am; HREmployees."NHIF No.")
                {
                    FieldValidate=no;
                }
        
                fieldelement(an; HREmployees."Sacco Staff No")
                {
                    FieldValidate=no;
                }
             
               fieldelement(ao; HREmployees."Job Title")
                {
                    FieldValidate=no;
                }
                fieldelement(ap; HREmployees."Payroll Posting Group")
                {
                    FieldValidate=no;
                }
               fieldelement(aq; HREmployees."Retirement date")
                {
                    FieldValidate=no;
                }
             
                fieldelement(ar; HREmployees."Salary Grade")
                {
                    FieldValidate=no;
                }
                
                fieldelement(as;HREmployees."Bank Account Number")
                {
                    FieldValidate=no;
                }
               fieldelement(at; HREmployees."Payroll Type")
                {
                    FieldValidate=no;
                }
                fieldelement(au; HREmployees."Global Dimension 1 Code")
                {
                    FieldValidate=no;
                }
                fieldelement(av; HREmployees."Global Dimension 2 Code")
                {
                    FieldValidate=no;
                }
                fieldelement(aw; HREmployees.Grade)
                {
                    FieldValidate=no;
                }
                fieldelement(ax; HREmployees."Member No.")
                {
                    FieldValidate=no;
                }
                fieldelement(ay; HREmployees."Primary Identification Type")
                {
                    FieldValidate=no;
                }
                fieldelement(az; HREmployees."Secondary Identification Type")
                {
                    FieldValidate=no;
                }
                fieldelement(ba; HREmployees."Primary Identification")
                {
                    MinOccurs=Zero;
                }
                 fieldelement(bb; HREmployees."Secondary Identification")
                {
                    MinOccurs=Zero;
                }

            }  
        }
    }
}                