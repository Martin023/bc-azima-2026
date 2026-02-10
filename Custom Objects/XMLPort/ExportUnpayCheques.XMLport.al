#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185494 "Export Unpay Cheques"
{

    schema
    {
        textelement(Root)
        {
            tableelement("Cheque Issue Lines"; "Cheque Issue Lines")
            {
                XmlName = 'CHreceiptLines';
                fieldelement(Account_Name; "Cheque Issue Lines"."Account Name")
                {
                }
                fieldelement(Family_Coop_AccountNo; "Cheque Issue Lines"."Family Account No.")
                {
                }
                fieldelement(CH_Serial; "Cheque Issue Lines"."Cheque Serial No")
                {
                }
                fieldelement(Unpay_Code; "Cheque Issue Lines".Interpretation)
                {
                }
                fieldelement(Unpay_Date; "Cheque Issue Lines"."Unpay Date")
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
}
