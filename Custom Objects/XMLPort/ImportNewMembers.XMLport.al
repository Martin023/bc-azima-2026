#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185511 "Import New Members"
{
    Format = VariableText;

    schema
    {
        textelement("<import_loans>")
        {
            XmlName = 'New_Members';
            tableelement("Sky New Members Buffer"; "Sky New Members Buffer")
            {
                XmlName = 'New_Members';
                fieldattribute(first_name; "Sky New Members Buffer"."First Name")
                {
                }
                fieldattribute(second_name; "Sky New Members Buffer"."Second Name")
                {
                }
                fieldattribute(last_name; "Sky New Members Buffer"."Last Name")
                {
                }
                fieldattribute(phone; "Sky New Members Buffer".Phone)
                {
                }
                fieldattribute(id_no; "Sky New Members Buffer"."ID No")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Sky New Members Buffer"."Created By" := UserId;
                        "Sky New Members Buffer"."Created At" := CurrentDatetime;
                    end;
                }
                fieldattribute(service_no; "Sky New Members Buffer"."Service Number")
                {
                }
                fieldattribute(dob; "Sky New Members Buffer"."Date of Birth")
                {
                }
                fieldattribute(monthly_amount; "Sky New Members Buffer"."Montly Amount")
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
