report 52187399 "Disposal FA audit trail"
{
    ApplicationArea = All;
    Caption = 'Depreciation FA audit trail';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Disposal FA audit trail.rdl';
    defaultlayout = RDLC;

    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            ;
            column(AssetRefNo; "Asset No.")
            {
            }
            column(FADescription; Description)
            {
            }
            column(PurchasePrice; "Purchase Price")
            {
            }
            column(DisposalDate; DisposalDate)
            {
            }
            column(DisposalPrice; DisposalPrice)
            {
            }
            column(GainonLossDisposal; ProceeedsonDisposal)
            {
            }
            column(Writedown; WriteDownValue)
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
            var
                myInt: Integer;

            begin
                DisposalDate := 0D;
                GainonLossDisposal := 0;

                DepreciationBook.RESET;
                DepreciationBook.Setrange("FA No.", FixedAsset."Asset No.");
                if DepreciationBook.Find('-') then begin
                    DisposalDate := DepreciationBook."Disposal Date";
                    WriteDownValue := DepreciationBook."Write-Down";
                end;

                FALedgerEntry.RESET;
                FALedgerEntry.SETRANGE("FA No.", FixedAsset."Asset No.");
                // FALedgerEntry.SETRANGE("Posting Date", 0D, DisposalDate);
                FALedgerEntry.SetRange("FA Posting Type", FALedgerEntry."FA Posting Type"::"Gain/Loss");
                if FALedgerEntry.Find('-') then begin
                    GainonLossDisposal := FALedgerEntry.Amount;
                end;

                FALedgerEntry.RESET;
                FALedgerEntry.SETRANGE("FA No.", FixedAsset."Asset No.");
                //FALedgerEntry.SETRANGE("Posting Date", 0D, DisposalDate);
                FALedgerEntry.SetRange("FA Posting Type", FALedgerEntry."FA Posting Type"::"Proceeds on Disposal");
                if FALedgerEntry.Find('-') then begin
                    ProceeedsonDisposal := FALedgerEntry.Amount;
                end;

                FALedgerEntry.RESET;
                FALedgerEntry.SETRANGE("FA No.", FixedAsset."Asset No.");
                //FALedgerEntry.SETRANGE("Posting Date", 0D, DisposalDate);
                FALedgerEntry.SetRange("FA Posting Type", FALedgerEntry."FA Posting Category"::"Disposal");
                if FALedgerEntry.Find('-') then begin
                    DisposalPrice := FALedgerEntry.Amount;
                end
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
        DepreciationBook: Record "FA Depreciation Book";
        DisposalDate: Date;
        WriteDownValue: Decimal;
        FALedgerEntry: Record "FA Ledger Entry";
        GainonLossDisposal: Decimal;
        ProceeedsonDisposal: Decimal;
        DisposalPrice: Decimal;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
