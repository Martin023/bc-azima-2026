#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185513 "Change Log Enteies"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Change Log Entry"; "Change Log Entry")
            {
                XmlName = 'ChangeLogEnt';
                fieldelement(UserID; "Change Log Entry"."User ID")
                {
                }
                fieldelement(TransDate; "Change Log Entry"."Date and Time")
                {
                }
                fieldelement(TransType; "Change Log Entry"."Type of Change")
                {
                }
                fieldelement(OldValue; "Change Log Entry"."Old Value")
                {
                }
                fieldelement(NewValue; "Change Log Entry"."New Value")
                {
                }
                fieldelement(TableAffected; "Change Log Entry"."Table Caption")
                {
                }
                fieldelement(ColumnAffected; "Change Log Entry"."Field Caption")
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
