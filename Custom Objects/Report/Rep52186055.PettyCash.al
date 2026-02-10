report 52186055 "Petty Cash"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Petty Cash.rdl';
    dataset
    {
        dataitem(CashPaymentsHeader; "Payments Header")
        {
            DataItemTableView = where("Payment Type" = filter("petty cash"));
            column(BankName; "Bank Name")
            {
            }
            column(BudgetCenterName; "Budget Center Name")
            {
            }
            column(Cashier; Cashier)
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(CurrencyFactor; "Currency Factor")
            {
            }
            column(CurrentSourceACBal; "Current Source A/C Bal.")
            {
            }
            column(Date; "Date")
            {
            }
            column(DatePosted; "Date Posted")
            {
            }
            column(FromEntryNo; "From Entry No.")
            {
            }
            column(FunctionName; "Function Name")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(No; "No.")
            {
            }
            column(NoPrinted; "No. Printed")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(OnBehalfOf; "On Behalf Of")
            {
            }
            column(Payee; Payee)
            {
            }
            column(PayingBankAccount; "Paying Bank Account")
            {
            }
            column(PaymentType; "Payment Type")
            {
            }
            column(Posted; Posted)
            {
            }
            column(PostedBy; "Posted By")
            {
            }
            column(RegisterNumber; "Register Number")
            {
            }
            column(ResponsibilityCenter; "Responsibility Center")
            {
            }
            column(Select; Select)
            {
            }
            column(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
            {
            }
            column(Status; Status)
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TimePosted; "Time Posted")
            {
            }
            column(ToEntryNo; "To Entry No.")
            {
            }

            column(TotalNetAmount; "Total Net Amount")
            {
            }

            column(TotalVATAmount; "Total VAT Amount")
            {
            }
            column(TotalWitholdingTaxAmount; "Total Witholding Tax Amount")
            {
            }
            dataitem("Cash Payment Line"; "Payment Line")
            {
                DataItemLink = No = field("No.");

                column(Type; Type)
                {

                }
                column(Account_No_; "Account No.")
                {

                }
                column(Account_Name; "Account Name")
                {

                }
                column(Amount; Amount)
                {

                }
                column(Net_Amount; "Net Amount")
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
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;


    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
