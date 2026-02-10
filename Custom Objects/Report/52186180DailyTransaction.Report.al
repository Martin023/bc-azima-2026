#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186180 "Daily Transactions Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Daily Transactions Report.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Posting Date", "Global Dimension 1 Code", "Global Dimension 2 Code", "User ID", "Document No.";
            column(Document_No_; "Document No.")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Document_Date; "Document Date")
            {

            }
            column(Description; Description)
            {

            }
            column(Debit_Amount; "Debit Amount")
            {

            }
            column(Credit_Amount; "Credit Amount")
            {

            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {

            }
            column(User_ID; "User ID")
            {

            }
            column(External_Document_No_; "External Document No.")
            {

            }
            column(Source_Type; "Source Type")
            {

            }
            column(Source_No_; "Source No.")
            {

            }
            column(Last_Modified_DateTime; "Last Modified DateTime")
            {

            }
            column(SNo; SNo)
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
            column(MemName; MemName)
            {

            }
            column(MemNo; MemNo)
            {

            }
            column(IDNo; IDNo)
            {

            }
            column(Desc; Desc)
            {

            }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;

                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("No.", "G/L Entry"."Source No.");
                if SavingsAccounts.FindFirst() then begin
                    IDNo := SavingsAccounts."ID No.";
                    MemNo := SavingsAccounts."Member No.";
                    MemName := SavingsAccounts.Name;
                end;

                UserSetup.Reset();
                UserSetup.SetRange("User ID", "G/L Entry"."User ID");
                if UserSetup.FindFirst() then begin
                    // StaffNo:=UserSetup.no
                end;

                CashierTrans.Reset();
                CashierTrans.SetRange(No, copystr("External Document No.", 1, 20));
                if CashierTrans.FindFirst() then begin
                    Desc := CashierTrans.Type;
                end;
            end;

            trigger OnPreDataItem()
            begin

            end;

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
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Desc: Enum "Fosa Transaction Types";
        CalcRunningAccBalance: Codeunit "Calc. Running Acc. Balance";
        BankAcc: Record "Bank Account";
        AccountNo: Code[100];
        AccountName: Text[100];
        SavingsAccounts: Record "Savings Accounts";
        IDNo: Code[20];
        SNo: Integer;
        MemNo: Code[20];
        MemName: Text[100];
        StaffNo: Code[20];
        UserSetup: Record "User Setup";
        CashierTrans: Record "Cashier Transactions";

}
