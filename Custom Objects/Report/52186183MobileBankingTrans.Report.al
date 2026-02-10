report 52186183 "Mobile Banking Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/ Mobile Banking Report.rdl';

    dataset
    {

        dataitem("Sky M-Banking Trans. Buffer"; "Sky M-Banking Trans. Buffer")
        {
            RequestFilterFields = "No.";

            column(No_; "No.")
            {
            }
            column(Originator_ID; "Originator ID")
            {

            }
            column(PESA_Type; "PESA Type")
            {
            }
            column(Action; Action)
            {
            }
            column(Sensitivity; Sensitivity)
            {

            }
            column(Command; Command)
            {
            }
            column(Charge; Charge)
            {
            }
            column(Identifier; Identifier)
            {
            }
            column(Initiator_Account; "Initiator Account")
            {
            }
            column(Initiator_Identifier; "Initiator Identifier")
            {
            }
            column(Initiator_Name; "Initiator Name")
            {
            }
            column(Initiator_Identifier_Type; "Initiator Identifier Type")
            {
            }
            column(Source_Identifier_Type; "Source Identifier Type")
            {

            }
            column(Source_Identifier; "Source Identifier")
            {
            }
            column(Source_Account; "Source Account")
            {
            }
            column(Source_Application; "Source Application")
            {

            }
            column(Source_Name; "Source Name")
            {
            }
            column(Source_Reference; "Source Reference")
            {
            }
            column(Initiator_Reference; "Initiator Reference")
            {
            }

            column(Sender_Identifier; "Sender Identifier")
            {
            }
            column(Sender_Identifier_Type; "Sender Identifier Type")
            {
            }
            column(Sender_Account; "Sender Account")
            {

            }
            column(Sender_Name; "Sender Name")
            {

            }
            column(Sender_Reference; "Sender Reference")
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
            column(Receiver_Identifier; "Receiver Identifier")
            {

            }
            column(Receiver_Identifier_Type; "Receiver Identifier Type")
            {

            }
            column(Receiver_Name; "Receiver Name")
            {

            }
            column(Receiver_Account; "Receiver Account")
            {

            }
            column(Receiver_Reference; "Receiver Reference")
            {

            }
            column(Beneficiary_Account; "Beneficiary Account")
            {

            }
            column(Beneficiary_Identifier; "Beneficiary Identifier")
            {

            }
            column(Beneficiary_Identifier_Type; "Beneficiary Identifier Type")
            {

            }
            column(Beneficiary_Name; "Beneficiary Name")
            {

            }
            column(Beneficiary_Reference; "Beneficiary Reference")
            {

            }
            column(Transaction_Amount; "Transaction Amount")
            {

            }
            column(Transaction_Description; "Transaction Description")
            {

            }
            column(Transaction_Category; "Transaction Category")
            {

            }
            column(Transaction_Source_Reference; "Transaction Source Reference")
            {

            }
            column(Request_Application; "Request Application")
            {

            }
            column(Transaction_Date_Time; "Transaction Date Time")
            {

            }
            column(Posted_By; "Posted By")
            {

            }
            column(Transaction_Type; "Transaction Type")
            {

            }
            column(Transaction_ID; "Transaction ID")
            {

            }
            column(Loan_No_; "Loan No.")
            {

            }
            column(Loan_Account; "Loan Account")
            {

            }
            column(Savings_Account; "Savings Account")
            {

            }
            column(Destination_Account; "Destination Account")
            {

            }
            column(Transaction_Status; "Transaction Status")
            {

            }
            column(Signed_Amount; "Signed Amount")
            {

            }

            trigger OnAfterGetRecord()
            var

            begin

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(AsAt; AsAt)
                {

                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";

        if AsAt = 0D then
            AsAt := today;
    end;

    var
        SNo: Integer;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        ShowTotoDetail: Boolean;
        Pfact: Record "Product Factory";
        Amount: decimal;
        TotalAmount: decimal;
        Nosav: Code[30];
        AsAt: Date;
        NoOfDormancy: Integer;
        realDormancy: Integer;
        BOSADeposits: Decimal;
        FOSADeposits: Decimal;
        MemberFact: Record "Member FactBox";
}
