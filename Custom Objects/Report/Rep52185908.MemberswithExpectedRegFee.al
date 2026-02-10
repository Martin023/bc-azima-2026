report 52185908 "Members with Expected Reg Fee"
{
    ApplicationArea = All;
    Caption = 'Members with Expected Reg Fee';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Members with Expected Reg Fee.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where(status = const(New));
            RequestFilterFields = "Registration Date", "Rejoinig Date";

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
            column(No; "No.")
            {
            }
            column(PayrollStaffNo; "Payroll/Staff No.")
            {
            }
            column(Name; Name)
            {
            }
            column(RegistrationDate; "Registration Date")
            {
            }
            column(MemberClass; "Member Class")
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(ExpectedAmounts; ExpectedAmounts)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if MemberClass.GET(Members."Member Class") then begin
                    ExpectedAmounts := MemberClass."Entrance Fee";

                    SavingsAccount.Reset();
                    SavingsAccount.SETRANGE("Product Category", SavingsAccount."Product Category"::"Entrance Fee");
                    if SavingsAccount.FINDFIRST then begin
                        if not (SavingsAccount.GetAvailableBalance(SavingsAccount."No.") = 0) then
                            CurrReport.SKIP;
                    end;
                    // else begin
                    //     ProductSetUp.reset;
                    //     ProductSetUp.SetRange("Product Category", ProductSetUp."Product Category"::"Entrance Fee");
                    //     if ProductSetUp.FINDFIRST then begin
                    //         AccNo := RegistrationProcessCU.CreateSavingsAccountNo(ProductSetUp."Product ID", Members."Global Dimension 1 Code", Members."No.");
                    //     RegistrationProcessCU.AutoCreateSavingsAccount(AccNo, Members."No.", ProductSetUp."Product ID");
                    // end;
                end;
            end;
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
        SavingsAccount: Record "Savings Accounts";
        MemberClass: Record "Member Classes";
        ExpectedAmounts: Decimal;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text[250];
        CompanyTelephone: Text[250];
        CommunicationOnline: Text[250];

}
