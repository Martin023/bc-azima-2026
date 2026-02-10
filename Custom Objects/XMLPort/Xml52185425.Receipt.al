namespace ALProject.ALProject;

xmlport 52185425 "Receipt "
{
    Format = VariableText;
    Direction = both;

    schema
    {
        textelement(Root)
        {
            tableelement(ReceiptLine; "Receipt Line")
            {
                fieldattribute(No; ReceiptLine.No)
                {
                }
                // fieldattribute(Type; ReceiptLine.Type)
                // {

                // }
                fieldattribute(AccountType; ReceiptLine."Account Type")
                {
                }
                fieldattribute(AccountNo; ReceiptLine."Account No.")
                {
                }
                fieldattribute(Description; ReceiptLine.Description)
                {

                }
                fieldattribute(Paymode; ReceiptLine."Pay Mode")
                {

                }

                fieldattribute(ChequeDepositSlipDate; ReceiptLine."Cheque/Deposit Slip Date")
                {
                }
                fieldattribute(ChequeDepositSlipNo; ReceiptLine."Cheque/Deposit Slip No")
                {
                }
                fieldattribute(Amount; ReceiptLine.Amount)
                {

                }
                fieldattribute(LoanNo; ReceiptLine."Loan No.")
                {
                }
                fieldattribute(TransType; ReceiptLine."Transaction Type")
                {

                }
                fieldattribute(Branch; ReceiptLine."Global Dimension 1 Code")
                {

                }
                fieldattribute(Activity; ReceiptLine."Shortcut Dimension 2 Code")
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
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Processing completed successfully');
    end;
}
