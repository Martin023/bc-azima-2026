report 52186096 "Bank Transactions Aging report"
{
    ApplicationArea = All;
    Caption = 'Bank Transactions Aging report';
    UsageCategory = ReportsAndAnalysis;
    RdLcLayout = './bc-kenpipe-2024/Layout/Bank Transactions Aging report.rdl';
    dataset
    {
        dataitem(BankAccountLedgerEntry; "Bank Account Ledger Entry")
        {
            DataItemTableView = where(Open = filter(True));

            RequestFilterFields = "Posting Date", "Bank Account No.";

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
            column(Posting_Date; "Posting Date")
            {
            }
            column(Amount__LCY_; "Amount (LCY)")
            {
            }
            column(description; Description)
            {
            }
            column(Document_No_; "Document No.")
            {
            }
            column(UserID; "User ID")
            {
            }
            column(externalDocumentNo; "External Document No.")
            {
            }
            column("Performing"; "0-30 Days Performing (1%)")
            {
            }
            column("Watch"; "31-90 Days Watch (5%)")
            {
            }
            column("Substandard"; "91-180 Days Substandard (25%)")
            {
            }
            column("Doubtful"; "181-360 Days Doubtful (50%)")
            {
            }
            column("Loss"; "Over 360 Days Loss (100%)")
            {
            }
            column(NoOfDays; NoOfDays)
            {
            }
            trigger OnPreDataItem()
            begin
                BankAccountLedgerEntry.setfilter("Posting Date", '<=%1', AsAt);
            end;

            trigger OnAfterGetRecord()
            begin
                "0-30 Days Performing (1%)" := 0;
                "31-90 Days Watch (5%)" := 0;
                "91-180 Days Substandard (25%)" := 0;
                "181-360 Days Doubtful (50%)" := 0;
                "Over 360 Days Loss (100%)" := 0;
                NoOfDays := AsAt - BankAccountLedgerEntry."Posting Date";
                if NoOfDays < 0 then
                    NoOfDays := 0;
                case NoOfDays of
                    0 .. 30:
                        "0-30 Days Performing (1%)" := BankAccountLedgerEntry."Amount (LCY)"; //* 0.01;
                    31 .. 90:
                        "31-90 Days Watch (5%)" := BankAccountLedgerEntry."Amount (LCY)"; //;* 0.05;
                    91 .. 180:
                        "91-180 Days Substandard (25%)" := BankAccountLedgerEntry."Amount (LCY)"; //* 0.25;
                    181 .. 360:
                        "181-360 Days Doubtful (50%)" := BankAccountLedgerEntry."Amount (LCY)";// * 0.50;
                    else
                        "Over 360 Days Loss (100%)" := BankAccountLedgerEntry."Amount (LCY)";
                end;
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
                group(AsAtGrp)
                {
                    field(AsAt; AsAt)
                    {
                        ApplicationArea = All;
                        Caption = 'As At';
                        ToolTip = 'As At';
                    }
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

        if AsAt = 0D then
            AsAt := Today;
    end;



    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        NoOfDays: Integer;
        "0-30 Days Performing (1%)": Decimal;
        "31-90 Days Watch (5%)": Decimal;
        "91-180 Days Substandard (25%)": Decimal;
        "181-360 Days Doubtful (50%)": Decimal;
        "Over 360 Days Loss (100%)": Decimal;
        AsAt: Date;

}