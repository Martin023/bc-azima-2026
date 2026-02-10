#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185499 "Checkoff Buffer"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Checkoff Buffer"; "Checkoff Buffer")
            {
                XmlName = 'CheckoffBuffer';
                fieldelement(No; "Checkoff Buffer".No)
                {
                }
                fieldelement(CheckoffNo; "Checkoff Buffer"."Checkoff No")
                {
                }
                fieldelement(UploadNo; "Checkoff Buffer"."Upload No.")
                {
                }
                fieldelement(Name; "Checkoff Buffer".Name)
                {
                }
                fieldelement(EmployerCode; "Checkoff Buffer"."Employer Code")
                {
                }
                fieldelement(LoanNo; "Checkoff Buffer"."Loan No")
                {
                }
                fieldelement(Amount; "Checkoff Buffer".Amount)
                {
                }
                fieldelement(Interest; "Checkoff Buffer".Interest)
                {
                    MinOccurs = Zero;
                }
                fieldelement(SearchCode; "Checkoff Buffer"."Search Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Type; "Checkoff Buffer".Type)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Empl; "Checkoff Buffer".Balance)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInitRecord()
                begin
                    "Checkoff Buffer"."User Id" := UserId;
                    "Checkoff Buffer"."Upload Response" := Response;
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

    trigger OnPostXmlPort()
    begin
        Message(Text01);
    end;

    trigger OnPreXmlPort()
    var
        OptionStrings: text;

    begin
        OptionStrings := ' ,&Member No,&Payroll No,&ID No';
        Response := StrMenu(OptionStrings, 1);
        if Response = 1 then
            Error(Error001)
        ELSE
            IF (Response = 2) or (response = 3) or (response = 4) then
                "Checkoff Buffer"."Upload Response" := Response;

    end;

    var
        // [RunOnClient]
        // Window: dotnet Interaction;
        MyComment: Text;
        Response: Integer;
        Error001: label 'Invalid option, please respond with 2,3 OR 4.';
        Text01: label 'Upload done successfully';
        window: Dialog;
}