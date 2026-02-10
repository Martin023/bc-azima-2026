#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185477 "Import leave balance"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Vendor; Vendor)
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'SalaryLines';
                fieldelement(HNo; Vendor."No.")
                {
                    FieldValidate = no;
                }
                fieldelement(AccountNo; Vendor.Name)
                {
                }
                fieldelement(Status; Vendor.Status)
                {
                }
                fieldelement(pg; Vendor."Vendor Posting Group")
                {
                }
                fieldelement(sn; Vendor."Search Name")
                {
                }
                fieldelement(gbpbg; Vendor."Gen. Bus. Posting Group")
                {
                }
                fieldelement(vat; Vendor."VAT Bus. Posting Group")
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
        Message('Salary Uploaded Successfuly');
    end;
}
