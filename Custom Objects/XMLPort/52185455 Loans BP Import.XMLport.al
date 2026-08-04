#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185555 "Loans BP"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Checkoff Buffer"; "Checkoff Buffer")
            {
                XmlName = 'LoansBP';
                fieldelement(No; "Checkoff Buffer".No)
                {
                }
                fieldelement(CheckoffNo; "Checkoff Buffer"."Checkoff No")
                {
                    FieldValidate = yes;

                }
                fieldelement(EmployerCode; "Checkoff Buffer"."Employer Code")
                {
                    FieldValidate = yes;
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

                fieldelement(ProductID; "Checkoff Buffer"."Product Code")
                {
                    FieldValidate = yes;
                    // MinOccurs = Once;
                }
                fieldelement(Remarks; "Checkoff Buffer".remarks)
                {
                    FieldValidate = yes;
                    MinOccurs = Once;

                }
                trigger OnBeforeInsertRecord()
                begin
                    if "Checkoff Buffer".Amount <= 0 then
                        Error('Amount must be greater than zero.');
                    "Checkoff Buffer".TestField("Product Code");
                    "Checkoff Buffer".TestField("Employer Code");
                    "Checkoff Buffer".TestField("Upload No.");

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
            area(content)
            {
                group("No|CheckoffNo|EmployerCode|PayrollNo|Amount|ProductID|Remarks")
                {
                    field(HeaderTemplate; HeaderTemplate)
                    {
                        ApplicationArea = All;
                        Caption = 'Copy this header';
                        Editable = false;
                        ToolTip = 'Copy this text and paste it into the first row of your Excel file.';
                    }


                }
            }
        }

        actions
        {
        }
    }

    trigger OninitXmlPort()
    begin
        HeaderTemplate := 'No|CheckoffNo|EmployerCode|PayrollNo|Amount|ProductID|Remarks';
    end;

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
        HeaderTemplate: Text[250];
        Response: Integer;
        Error001: label 'Invalid option, please respond with 2,3 OR 4.';
        Text01: label 'Upload done successfully';

}