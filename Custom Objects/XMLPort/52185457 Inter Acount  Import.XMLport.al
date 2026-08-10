xmlport 52185557 "Inter Account"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Both;
    Caption = 'Refund_Account_ Transfer';
    schema
    {

        textelement(Root)
        {
            tableelement(RAT; "Refund,Account Transfer lines")
            {
                fieldattribute(HeaderNo; RAT."Refund Header No.")
                {
                }
                fieldattribute(SourceAccount; RAT."Source Account")
                {
                    FieldValidate = No;
                }
                fieldattribute(SourceLoanNo; RAT."Source Loan No.")
                {
                    FieldValidate = No;
                }
                fieldattribute(SourceLoanTransactionType; RAT."Source Loan Transaction.")
                {
                    FieldValidate = No;
                }
                fieldattribute(SourceDescription; RAT."Source Description")
                {
                }
                fieldattribute(DestinationAccount; RAT."Destination Account")
                {
                    FieldValidate = No;
                }
                fieldattribute(LoanNo; RAT."Loan No.")
                {
                    FieldValidate = No;
                }
                fieldattribute(Amount; RAT.Amount)
                {
                    FieldValidate = No;
                }
                fieldattribute(DestinationDescription; RAT."Destination Description")
                {
                }
                trigger OnBeforeInsertRecord()
                begin
                    If RAT.Amount <= 0 then Error(' Amount must be an absolute value');
                    RAT.TestField("Source Description");
                    RAT.TestField("Destination Description");
                end;



                trigger OnAfterInitRecord()
                begin

                    RAT."Upload Response" := Response;
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
                group("Excel Layout")
                {
                    field(ExcelLayout; ExcelLayout)
                    {
                    }
                }
            }
        }
    }

    var
        SalaryHeaderNo: Code[50];
        ExcelLayout: Text;

    // trigger OninitXmlPort()
    // begin
    //     ExcelLayout := 'AccountNo|EmployerCode|StaffNo|MemberNo|Amount|DocumentNo';
    // end;

    trigger OninitXmlPort()
    begin
        ExcelLayout := 'HeaderNo|SourceAccount|SourceLoanNo|SourceLoanTransactionType|SourceDescription|DestinationAccount|LoanNo|Amount|DestinationDescription';
    end;

    trigger OnPostXmlPort()
    begin
        Message(Text01);
    end;

    trigger OnPreXmlPort()
    var
        OptionStrings: text;

    begin
        OptionStrings := ' ,&Member No,&Account No.';
        Response := StrMenu(OptionStrings, 1);
        if Response = 1 then
            Error(Error001)
        ELSE
            IF (Response = 2) or (response = 3) then
                RAT."Upload Response" := Response;
        RAT."Name" := Acc.Name;
        RAT."ID No." := Acc."ID No.";
        RAT."Account Name" := Acc."Product Name";
        RAT."Global Dimension 1 Code" := Acc."Global Dimension 1 Code";
        RAT."Global Dimension 2 Code" := Acc."Global Dimension 2 Code";
        RAT."Staff No." := Acc."Payroll/Staff No.";


    end;



    var
        // [RunOnClient]
        // Window: dotnet Interaction;
        MyComment: Text;
        Response: Integer;
        Error001: label 'Invalid option, please respond with 2,3 OR 4.';
        Text01: label 'Upload done successfully';
        window: Dialog;
        Acc: Record "Savings Accounts";
}

