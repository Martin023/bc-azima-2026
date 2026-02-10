report 52187398 "Adjusted Fixed Assets"
{
    ApplicationArea = All;
    Caption = 'Adjusted Fixed Assets';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = rdlc;
    RDLCLayout = './bc-kenpipe-2024/Layout/Adjusted Fixed Assets.rdl';
    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            RequestFilterFields = "No.", "FA Class Code", "FA Location Code";
            column(AssetNo; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(BrandName; "Brand Name")
            {
            }
            column(PurchasePrice; "Purchase Price")
            {
            }
            column(AdjustmentDate; AdjustmentDate) { }
            column(AdjustmentAmount; AdjustmentAmount) { }
            column(CommentonAdjustemnt; CommentonAdjustemnt) { }
            column(OriginalValue; OriginalValue) { }
            column(AdjustedValue; AdjustedValue) { }
            column(PurchaseDate; "Purchase Date")
            {
            }
            column(RegistrationNo; "Registration No.")
            {
            }
            column(ResponsibilityCenter; "Responsibility Center")
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
            trigger OnAfterGetRecord()
            begin
                OriginalValue := 0;
                AdjustedValue := 0;
                AdjustmentDate := 0D;
                AdjustmentAmount := 0;
                CommentonAdjustemnt := '';


                FALedgerEntries.RESET;
                FALedgerEntries.SETRANGE("FA No.", FixedAsset."No.");
                FALedgerEntries.SetRange(Reversed, false);
                //FALedgerEntries.SetRange("FA Posting Category");
                FALedgerEntries.SetFilter("FA Posting Type", '%1|%2|%3|%4|%5|%6|%7|%8',
                    FALedgerEntries."FA Posting Type"::"Appreciation",
                    //FALedgerEntries."FA Posting Type"::"Acquisition Cost",
                    FALedgerEntries."FA Posting Type"::"Write-Down",
                    FALedgerEntries."FA Posting Type"::"Proceeds on Disposal",
                    FALedgerEntries."FA Posting Type"::"Book Value on Disposal",
                    FALedgerEntries."FA Posting Type"::"Custom 1",
                    FALedgerEntries."FA Posting Type"::"Custom 2",
                    FALedgerEntries."FA Posting Type"::"Salvage Value",
                    FALedgerEntries."FA Posting Type"::"Gain/Loss");

                if FALedgerEntries.FindFirst() THEN
                    repeat
                        OriginalValue := FALedgerEntries.Amount;
                    until FALedgerEntries.Next = 0;

                if not FALedgerEntries.FindFirst() then begin
                    repeat
                        AdjustmentDate := FALedgerEntries."Posting Date";
                        AdjustmentAmount := FALedgerEntries.Amount;
                        CommentonAdjustemnt := FORMAT(FALedgerEntries."FA Posting Type");
                        AdjustedValue := OriginalValue - AdjustmentAmount;
                    until FALedgerEntries.Next = 0;
                end;


                //  Adjustment audit trail (listing all assets where there has been an adjustment posting in the period or year, including the adjustment values and reasons)
                // i.        Asset reference code--------
                // ii.        Asset description--------------
                // iii.        Date of adjustment----------
                // iv.        Original value ---Purchase price
                // v.        Adjustment amount ---
                // vi.        Adjusted value
                // vii.        Comment on adjustment.


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
        FALedgerEntries: Record "FA Ledger Entry";
        AdjustmentDate: Date;
        AdjustmentAmount: Decimal;
        CommentonAdjustemnt: Text;
        OriginalValue: Decimal;
        AdjustedValue: Decimal;

}
