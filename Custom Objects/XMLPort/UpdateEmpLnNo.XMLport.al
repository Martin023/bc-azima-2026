#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185534 "Update Emp Ln No"
{
    Format = VariableText;

    schema
    {
        textelement(ln)
        {
            tableelement(Loans; Loans)
            {
                AutoUpdate = true;
                XmlName = 'loans';
                fieldelement(a; Loans."Loan No.")
                {
                }
                fieldelement(b; Loans."Employer Loan No.")
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

    trigger OnPostXmlPort()
    begin
        Message('Employer Loan Nos. Updated Successfully');
    end;
}
