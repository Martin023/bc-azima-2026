report 52187381 "Tenant Aging Report"
{
    Caption = 'Tenant Aging Report';
    RDLCLayout = './bc-azima-2026/Layout/Tenant Aging.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Account Type" = filter(Tenant));//, "Balance (LCY)" = filter(> 0));
            column(CustomerNo; "No.")
            {

            }
            column(CustomerName; Name)
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
            column(AgingDays; AgingDays)
            {

            }
            column(Balance__LCY_; "Balance (LCY)")
            {

            }
            column(TotalAmount0To30; TotalAmount0To30)
            {

            }
            column(TotalAmount31To90; TotalAmount31To90)
            {

            }
            column(TotalAmount91To180; TotalAmount91To180)
            {

            }
            column(TotalAmount181To360; TotalAmount181To360)
            {

            }
            column(TotalAmountOver360; TotalAmountOver360)
            {

            }
            column(Amount; Amount)
            {

            }

            trigger OnAfterGetRecord()

            begin

                TotalAmount0To30 := 0;
                TotalAmount31To90 := 0;
                TotalAmount91To180 := 0;
                TotalAmount181To360 := 0;
                TotalAmountOver360 := 0;
                Customer.CalcFields("Balance (LCY)");
                if Customer."Balance (LCY)" > 0 then begin
                    CustLedgerEntry.Reset();
                    CustLedgerEntry.SetRange("Customer No.", Customer."No.");
                    if CustLedgerEntry.FindSet() then begin
                        repeat
                            CustLedgerEntry.CalcFields(Amount);
                            AgingDays := 0;
                            AgingDays := Abs(CustLedgerEntry."Due Date" - AsAt);
                            case AgingDays of
                                0 .. 30:
                                    TotalAmount0To30 += CustLedgerEntry.Amount;
                                31 .. 90:
                                    TotalAmount31To90 += CustLedgerEntry.Amount;
                                91 .. 180:
                                    TotalAmount91To180 += CustLedgerEntry.Amount;
                                181 .. 360:
                                    TotalAmount181To360 += CustLedgerEntry.Amount;
                                else
                                    TotalAmountOver360 += CustLedgerEntry.Amount;
                            end;
                        until CustLedgerEntry.Next() = 0;
                    end;
                end else begin
                    TotalAmount0To30 := Customer."Balance (LCY)";
                end;

                // CurrReport.ColumnHeader(1, AgingBucket);
            end;

            trigger OnPreDataItem()
            begin

                CustLedgerEntry.SetFilter("Posting Date", '%1', AsAt);
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
                // field("As of Date"; Today)
                // {
                //     ApplicationArea = All;
                // }
                field(AsAt; AsAt)
                {
                    ApplicationArea = All;
                }
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
        AsAt: Date;
        AgingDays: Integer;
        AgingBucket: Text[100];
        TotalAmount0To30: Decimal;
        TotalAmount31To90: Decimal;
        TotalAmount91To180: Decimal;
        TotalAmount181To360: Decimal;
        TotalAmountOver360: Decimal;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CustLedgerEntry: Record "Cust. Ledger Entry";
}
