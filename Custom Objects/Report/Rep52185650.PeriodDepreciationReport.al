report 52186849 "FA Period Depreciation Report"
{
    ApplicationArea = All;
    Caption = 'FA Period Depreciation Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Period Depreciation Report.rdl';
    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            DataItemTableView = where(Acquired = const(true));
            RequestFilterFields = "FA Class Code", "No.", "FA Posting Group";
            column(No; "No.")
            {
            }
            column(BookValue; BookValue) { }
            column(NetBookValue; NetBookValue) { }
            column(AcquisitionDate; AcquistionDate) { }
            column(AcquisitionCost; AcquisitionCost) { }
            column(DepreciationRate; DepreciationRate) { }
            column(Description; description)
            {
            }
            column(FA_Class_Code; "FA Class Code")
            {
            }
            column(TotalDepreciation; TotalDepreciation)
            {
            }
            column(CumulativeDepreciation; CumulativeDepreciation)
            {
            }
            column(PDate; PDate)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
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
            // dataitem("FA Ledger Entry"; "FA Ledger Entry")
            // {
            //     DataItemLink = "FA No." = field("No.");
            //     column(FANo; "FA No.")
            //     {
            //     }

            trigger OnAfterGetRecord()
            begin
                DepreciationRate := 0;
                AcquisitionCost := 0;
                BookValue := 0;
                AcquistionDate := 0D;
                CumulativeDepreciation := 0;
                TotalDepreciation := 0;
                NetBookValue := 0;
                PDate := 0D;


                FALedgerEntry.reset();
                FALedgerEntry.SetRange("FA No.", "Fixed Asset"."No.");
                // "FA Ledger Entry".CalcSums(Amount);
                // CumulativeDepreciation := "FA Ledger Entry".Amount;
                //"FA Ledger Entry".SetFilter("FA Posting Category","FA Ledger Entry"."FA Posting Category"::" ");
                FALedgerEntry.SetRange("FA Posting Type", FALedgerEntry."FA Posting Type"::Depreciation);
                FALedgerEntry.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                if FALedgerEntry.Find('-') then begin
                    repeat

                        PDate := FALedgerEntry."Posting Date";
                        TotalDepreciation := FALedgerEntry.Amount;
                    until FALedgerEntry.Next = 0;
                end;


                FADepBook.Reset;
                FADepBook.SetRange("FA No.", "Fixed Asset"."No.");
                if fadepbook.Find('-') then begin
                    FADepBook.CalcFields("Acquisition Cost", "Book Value");
                    AcquisitionCost := FADepBook."Acquisition Cost";
                    BookValue := FADepBook."Book Value";
                    AcquistionDate := FADepBook."Acquisition Date";
                    DepreciationRate := FADepBook."Straight-Line %";
                    // if FADepBook."Depreciation Method" = FADepBook."Depreciation Method"::"Straight-Line" then
                    //     DepreciationRate := FADepBook."Straight-Line %"
                    // else if FADepBook."Depreciation Method" = FADepBook."Depreciation Method"::"Declining-Balance 1" then
                    //     DepreciationRate := FADepBook."Declining-Balance %";
                end;
                NetBookValue := AcquisitionCost - TotalDepreciation;
            end;

            // Depreciation history report (summarizing the depreciation by period for the year per asset category)
            // i. Asset category
            // ii. Depreciation period
            // iii. Period depreciation amount
            // iv. Accumulated depreciation amount
            //}
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group("Date Filter")
                {
                    field("Start Date:"; StartDate)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = True;
                    }
                    field("End Date:"; EndDate)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
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

        TotalDepreciation := 0;
        CumulativeDepreciation := 0;
        if StartDate = 0D then StartDate := 19900101D;
        if EndDate = 0D then EndDate := Today;
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text[250];
        CompanyTelephone: Text[250];
        CommunicationOnline: Text[250];
        StartDate: Date;
        EndDate: Date;
        TotalDepreciation: Decimal;
        CumulativeDepreciation: Decimal;
        FADepBook: Record "FA Depreciation Book";
        BookValue: Decimal;
        AcquistionDate: Date;
        AcquisitionCost: Decimal;
        NetBookValue: Decimal;
        DepreciationRate: Decimal;
        FALedgerEntry: Record "FA Ledger Entry";
        PDate: Date;
}
