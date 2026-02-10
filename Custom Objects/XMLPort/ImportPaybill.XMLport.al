#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185427 "Import Paybill"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Mpesa Manual Upload"; "Mpesa Manual Upload")
            {
                AutoUpdate = true;
                XmlName = 'Mpesa';
                fieldelement(A; "Mpesa Manual Upload"."Receipt No.")
                {
                }
                fieldelement(B; "Mpesa Manual Upload"."Completion Time")
                {
                }
                fieldelement(C; "Mpesa Manual Upload"."Initiation Time")
                {
                }
                fieldelement(D; "Mpesa Manual Upload".Details)
                {
                }
                fieldelement(E; "Mpesa Manual Upload"."Transaction Status")
                {
                }
                fieldelement(F; "Mpesa Manual Upload"."Paid In")
                {
                }
                fieldelement(G; "Mpesa Manual Upload".Withdrawn)
                {
                }
                fieldelement(H; "Mpesa Manual Upload".Balance)
                {
                }
                fieldelement(I; "Mpesa Manual Upload"."Balance Confirmed")
                {
                }
                fieldelement(J; "Mpesa Manual Upload"."Reason Type")
                {
                }
                fieldelement(K; "Mpesa Manual Upload"."Other Party Info")
                {
                }
                fieldelement(L; "Mpesa Manual Upload"."Linked Transaction ID")
                {
                }
                fieldelement(M; "Mpesa Manual Upload"."A/C No.")
                {
                }
                fieldelement(n; "Mpesa Manual Upload"."Transaction Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(o; "Mpesa Manual Upload"."Transaction Type")
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInitRecord()
                begin
                    "Mpesa Manual Upload"."Date Uploaded" := Today;

                    "Mpesa Manual Upload".Validated := false;
                    "Mpesa Manual Upload".Transfered := false;
                    "Mpesa Manual Upload"."Needs Change" := false;
                    "Mpesa Manual Upload"."Already Posted" := false;
                end;
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
        // [RunOnClient]
        // Window: dotnet Interaction;
        MyComment: Text;
        Response: Integer;
        Error001: label 'Invalid option, please respond with 1,2 or 3.';
        Text01: label 'Upload done successfully';
}
