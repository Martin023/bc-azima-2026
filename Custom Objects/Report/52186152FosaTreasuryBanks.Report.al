#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186152 "FOSA Treasury Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/FOSA Treasury Report.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = where("Bank Type" = const(Treasury));

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
            column(Bank_Account_No_; "Bank Account No.")
            {
            }
            column(No_; "No.")
            {
            }
            column(Bank_Branch_No_; "Bank Branch No.")
            {

            }
            column(Name; Name)
            {
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            column(Balance__LCY_; "Balance (LCY)")
            {
            }
            column(Max__Witholding_Balance; "Max. Witholding Balance")
            {
            }
            column(SNo; SNo)
            {
            }


            trigger OnAfterGetRecord()
            begin
                SNo += 1;
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
        PrintedBy: Code[50];
        TransType: Record "Transaction Types";
        SavAcc: Record "Savings Accounts";
        TotalTransactions: Decimal;
        DatePosted: Date;
        DoB: Date;
        SNo: Integer;
        PrintedAt: Text;
        Members: Record "Members";
        PostingDate: Date;
        Source: Text[200];
        Purpose: Text[100];
        RegistrationDate: Text;
        SavingsAccounts: Record "Savings Accounts";
        Employer: Text;
        PostedBy: Text;
        MemberName: Text;
        MemberNumber: Text;
        IDNumber: Text;
        BranchCode: Code[10];
        GLAcc: Code[10];
        GLName: Text;
        ProductFactory: Record "Product Factory";
        CustomerPostingGroup: Record "Customer Posting Group";
        GLAccount: Record "G/L Account";
        FirstDate: Text;
        LastDate: Text;
        CashierTrans: Record "Cashier Transactions";
}
