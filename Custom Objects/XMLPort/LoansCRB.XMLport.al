#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185502 "Loans CRB"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("CRB Data"; "CRB Data")
            {
                AutoUpdate = false;
                XmlName = 'LoanCRB';
                fieldelement(B; "CRB Data"."Forename 1")
                {
                }
                fieldelement(c; "CRB Data"."Forename 2")
                {
                }
                fieldelement(d; "CRB Data"."Forename 3")
                {
                }
                fieldelement(ForeName3; "CRB Data".Salutation)
                {
                }
                fieldelement(Tradingas; "CRB Data"."Name 3")
                {
                }
                fieldelement(e; "CRB Data"."Date of Birth")
                {
                    FieldValidate = no;
                }
                fieldelement(f; "CRB Data"."Client Code")
                {
                }
                fieldelement(g; "CRB Data"."Account Number")
                {
                }
                fieldelement(OldAccNo; "CRB Data"."Name 3")
                {
                }
                fieldelement(h; "CRB Data".Gender)
                {
                }
                fieldelement(i; "CRB Data".Nationality)
                {
                }
                fieldelement(j; "CRB Data"."Marital Status")
                {
                }
                fieldelement(k; "CRB Data"."Primary Identification code")
                {
                }
                fieldelement(l; "CRB Data"."Primary Identification Number")
                {
                }
                fieldelement(m; "CRB Data"."Secondary Identification code")
                {
                }
                fieldelement(n; "CRB Data"."Secondary Identification")
                {
                }
                fieldelement(o; "CRB Data"."Other Identification Type")
                {
                }
                fieldelement(p; "CRB Data"."Other Identification Number")
                {
                }
                fieldelement(PassportNo; "CRB Data"."Name 3")
                {
                }
                fieldelement(q; "CRB Data"."Mobile No")
                {
                }
                fieldelement(r; "CRB Data"."Home Telephone")
                {
                }
                fieldelement(s; "CRB Data"."Work Telephone")
                {
                }
                fieldelement(t; "CRB Data"."Postal Address 1")
                {
                }
                fieldelement(u; "CRB Data"."Postal Address 2")
                {
                }
                fieldelement(v; "CRB Data"."Postal Location Town")
                {
                }
                fieldelement(w; "CRB Data"."Postal Location Country")
                {
                }
                fieldelement(x; "CRB Data"."Post Code")
                {
                }
                fieldelement(y; "CRB Data"."Physical Address 1")
                {
                }
                fieldelement(z; "CRB Data"."Physical Address 2")
                {
                }
                fieldelement(ab; "CRB Data"."Plot Number")
                {
                }
                fieldelement(ac; "CRB Data"."Location Town")
                {
                }
                fieldelement(ad; "CRB Data"."Location Country")
                {
                }
                fieldelement(ae; "CRB Data"."Date of Physical Address")
                {
                }
                fieldelement(af; "CRB Data"."PIN Number")
                {
                }
                fieldelement(ag; "CRB Data"."Customer Work Email")
                {
                }
                fieldelement(ah; "CRB Data"."Employer Name")
                {
                }
                fieldelement(ai; "CRB Data"."Employer Industry Type")
                {
                }
                fieldelement(aj; "CRB Data"."Employment Date")
                {
                }
                fieldelement(ak; "CRB Data"."Employment Type")
                {
                }
                fieldelement(am; "CRB Data"."Income Amount")
                {
                }
                fieldelement(an; "CRB Data"."Lenders Registered Name")
                {
                }
                fieldelement(ao; "CRB Data"."Lenders Trading Name")
                {
                }
                fieldelement(ap; "CRB Data"."Lenders Branch Name")
                {
                }
                fieldelement(aq; "CRB Data"."Lenders Branch Code")
                {
                }
                fieldelement(ar; "CRB Data"."Account Type")
                {
                }
                fieldelement(ba; "CRB Data"."Account Product Type")
                {
                }
                fieldelement(bb; "CRB Data"."Date Account Opened")
                {
                }
                fieldelement(bc; "CRB Data"."Installment Due Date")
                {
                }
                fieldelement(bd; "CRB Data"."Original Amount")
                {
                }
                fieldelement(be; "CRB Data"."Currency of Facility")
                {
                }
                fieldelement(bf; "CRB Data"."Amount in Kenya shillings")
                {
                }
                fieldelement(bg; "CRB Data"."Current Balance")
                {
                }
                fieldelement(bh; "CRB Data"."Overdue Balance")
                {
                }
                fieldelement(bi; "CRB Data"."Overdue Date")
                {
                }
                fieldelement(bj; "CRB Data"."No of Days in Arreas")
                {
                }
                fieldelement(bk; "CRB Data"."No of Installment In")
                {
                }
                fieldelement(bm; "CRB Data"."Performing / NPL Indicator")
                {
                }
                fieldelement(bn; "CRB Data"."Account Status")
                {
                }
                fieldelement(bo; "CRB Data"."Account Status Date")
                {
                }
                fieldelement(bp; "CRB Data"."Account Closure Reason")
                {
                }
                fieldelement(bq; "CRB Data"."Repayment Period")
                {
                }
                fieldelement(br; "CRB Data"."Deferred Payment Date")
                {
                }
                fieldelement(bs; "CRB Data"."Deferred Payment")
                {
                }
                fieldelement(bt; "CRB Data"."Payment Frequency")
                {
                }
                fieldelement(bv; "CRB Data"."Disbursement Date")
                {
                }
                fieldelement(bw; "CRB Data"."Insallment Amount")
                {
                }
                fieldelement(bx; "CRB Data"."Date of Latest Payment")
                {
                }
                fieldelement(by; "CRB Data"."Last Payment Amount")
                {
                }
                fieldelement(bz; "CRB Data"."Type of Security")
                {
                }
                fieldelement(GroupID; "CRB Data"."Name 3")
                {
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

    var
        CRBPage: Page "CRB Data";
}
