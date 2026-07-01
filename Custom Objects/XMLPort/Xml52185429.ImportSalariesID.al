namespace AZIMA.AZIMA;

xmlport 52185429 "Import Salaries ID"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Salary Lines"; "Salary Lines")
            {
                XmlName = 'SalaryLines';

                fieldattribute(IDno; "Salary Lines"."ID No.") { }
                fieldattribute(Amount; "Salary Lines".Amount)
                {
                }
                fieldattribute(Document_No; "Salary Lines"."Document No.")
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    if SalaryHeaderNo = '' then
                        Error('Salary Header No. was not initialized.');

                    if ("Salary Lines"."ID No." = '') then
                        Error('ID No. must be provided.');

                    // if "Salary Lines".Amount <= 0 then
                    //     Error('Amount must be greater than zero.');

                    "Salary Lines"."Salary Header No." := SalaryHeaderNo;
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
                group("ID No.|Amount|DocumentNo")
                {
                    field(AccountNo; SalaryHeaderNo)
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

    trigger OnPostXmlPort()
    begin
        Message('Salary Uploaded Successfuly');
    end;

    procedure SetHeaderNo(HeaderNo: Code[50])
    begin
        SalaryHeaderNo := HeaderNo;
    end;

}