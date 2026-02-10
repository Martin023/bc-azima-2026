#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185554 "Savings BP"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Checkoff Buffer"; "Checkoff Buffer")
            {
                XmlName = 'SavingsBP';
                fieldelement(No; "Checkoff Buffer".No)
                {
                }
                fieldelement(CheckoffNo; "Checkoff Buffer"."Checkoff No")
                {
                    FieldValidate = Yes;
                }
                fieldelement(UploadNo; "Checkoff Buffer"."Upload No.")
                {
                    FieldValidate = yes;
                    MinOccurs = Once;
                }
                fieldelement(Amount; "Checkoff Buffer".Amount)
                {
                    FieldValidate = yes;
                    MinOccurs = Once;
                }
                fieldelement(EmployerCode; "Checkoff Buffer"."Employer Code")
                {
                    FieldValidate = yes;
                    MinOccurs = Once;
                }
                fieldelement(ProductID; "Checkoff Buffer"."Product Code")
                {
                    fieldvalidate = yes;
                    MinOccurs = Once;
                }
                // fieldelement(SearchCode; "Checkoff Buffer"."Search Code")
                // {
                //     FieldValidate = no;
                //     //MinOccurs = Once;
                // }
                fieldelement(Remarks; "Checkoff Buffer".Remarks)
                {
                    fieldvalidate = yes;
                    MinOccurs = Once;
                }
                trigger OnBeforeInsertRecord()
                begin
                    if "Checkoff Buffer".Amount <= 0 then
                        Error('Amount must be grater than zero.');
                    "Checkoff Buffer".TestField("Product Code");
                    "Checkoff Buffer".TestField("Employer Code");
                    "Checkoff Buffer".TestField("Upload No.");
                    //"Checkoff Buffer".TestField("Search Code");
                end;

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

