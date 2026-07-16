namespace MNS.MNS;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.FixedAssets.Ledger;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.FixedAssets.Setup;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.Foundation.Company;

report 52185986 "Fixed Asset Movement Schedule"
{
    ApplicationArea = All;
    Caption = 'Fixed Asset Movement Schedule';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Fixed Asset Movement Schedule.rdl';
    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            DataItemTableView = where(Acquired = const(true));

            RequestFilterFields = "No.", "FA Class Code";
            column(Asset_No_; "No.") { }
            column(Description; Description) { }
            column(FA_Class_Code; "FA Class Code") { }
            column(TotalNBV; TotalNBV) { }
            column(BalanceBF; BalanceBF) { }
            column(AssetAdditions; AssetAdditions) { }
            column(Depreciation; Depreciation) { }
            column(AccDepreciation; AccDepreciation) { }
            column(BalanceBFTotals; BalanceBFTotals) { }
            //column(MarkedforDisposalDepreciation; MarkedforDisposalDepreciation) { }
            //column(MarkedforDisposalAcquisition; MarkedforDisposalAcquisition) { }
            column(ChargeForTheYearWithinTheYear; ChargeForTheYearWithinTheYear) { }
            column(ChargeForTheYearBeforeStartDate; ChargeForTheYearBeforeStartDate) { }
            column(AccumulatedDepreciationforDisposal; AccumulatedDepreciationforDisposal) { }
            column(BalAsAtEndDateCost; BalAsAtEndDateCost) { }
            column(BalAsAtEndDateAccumDep; BalAsAtEndDateAccumDep) { }
            column(NBVAsAtEndDate; NBVAsAtEndDate) { }
            column(TotalDepreciations; TotalDepreciations) { }
            //column(TotalCost; Cost) { }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
            column(Disposals; Disposals) { }
            column(AssetAdditionsPlusBalanceBF; AssetAdditionsPlusBalanceBF) { }
            //column(BalanceAsAtEndDate; BalanceAsAtEndDate) { }
            //column(CostBalAsAtEndDate; CostBalAsAtEndDate) { }
            column(AccumulatedDepreciationAsAtEndDate; AccumulatedDepreciationAsAtEndDate) { }
            column(DepreciationForDisposalTotal; DepreciationForDisposalTotal) { }
            column(AdditionsTotals; AdditionsTotals) { }
            column(DisposalaAcquisitionCosts; DisposalaAcquisitionCosts) { }
            column(ChargeWithinTheYearTotals; ChargeWithinTheYearTotals) { }
            column(TotalDepreciationsBF; TotalDepreciationsBF) { }
            column(TotalBalAstEndDate; TotalBalAstEndDate) { }
            column(AccDepAsAtEndDateTotal; AccDepAsAtEndDateTotal) { }
            column(Straight_Line__; Straight_Line__) { }
            // dataitem("FA Ledger Entry"; "FA Ledger Entry")
            // {
            //     DataItemLinkReference = "Fixed Asset";
            //     DataItemLink = "FA Class Code" = field("FA Class Code");
            //     //DataItemLink = "FA No." = field("No.");
            //     column(Straight_Line__; "Straight-Line %") { }
            //     trigger OnAfterGetRecord()
            //     begin

            //     end;
            // }
            trigger OnAfterGetRecord()
            begin
                AssetAdditions := 0;
                BalanceBF := 0;
                ChargeForTheYearBeforeStartDate := 0;
                ChargeForTheYearWithinTheYear := 0;
                Disposals := 0;
                AccumulatedDepreciationforDisposal := 0;
                Straight_Line__ := 0;

                // FALedgerEntries.RESET;
                // FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                // IF FALedgerEntries.Find('-') THEN begin
                //     Straight_Line__ := FALedgerEntries."Straight-Line %";
                // end;
                //if FALedgerEntries.get("Fixed Asset"."No.") then Straight_Line__ := FALedgerEntries."Straight-Line %";

                FAClass.Reset();
                FAClass.SetRange(Code, "Fixed Asset"."FA Class Code");
                if FAClass.Find('-') then begin
                    Straight_Line__ := FAClass."Straight-Line %";
                end;
                FALedgerEntries.RESET;
                FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                FALedgerEntries.SetFilter("Posting Date", StartDateFilter);
                FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::"Acquisition Cost");
                FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::" ");
                if FALedgerEntries.Find('-') then begin
                    FALedgerEntries.CalcSums(Amount);
                    BalanceBF := FALedgerEntries.Amount;
                    //Straight_Line__ := FALedgerEntries."Straight-Line %";
                end;

                FALedgerEntries.RESET;
                FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                FALedgerEntries.SetFilter("Posting Date", StartDateFilter);
                FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::"Depreciation");
                FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::" ");
                if FALedgerEntries.Find('-') then begin
                    FALedgerEntries.CalcSums(Amount);
                    ChargeForTheYearBeforeStartDate := FALedgerEntries.Amount;
                    //Straight_Line__ := FALedgerEntries."Straight-Line %";
                end;

                FALedgerEntries.Reset();
                FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                FALedgerEntries.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::"Acquisition Cost");
                FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::" ");
                if FALedgerEntries.Find('-') then begin
                    FALedgerEntries.CalcSums(Amount);
                    AssetAdditions := FALedgerEntries.Amount;
                    //Straight_Line__ := FALedgerEntries."Straight-Line %";
                end;

                FALedgerEntries.Reset();
                FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                FALedgerEntries.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
                FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::" ");
                if FALedgerEntries.Find('-') then begin
                    FALedgerEntries.CalcSums(Amount);
                    ChargeForTheYearWithinTheYear := FALedgerEntries.Amount;
                    //Straight_Line__ := FALedgerEntries."Straight-Line %";
                end;

                FALEDGERENTRIES.RESET;
                FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                FALEDGERENTRIES.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::Disposal);
                FALedgerEntries.SetRange(FALedgerEntries."FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
                IF FALedgerEntries.FIND('-') THEN begin
                    FALedgerEntries.CalcSums(Amount);
                    DepreciationForDisposalTotal := FALedgerEntries.Amount;
                    //Straight_Line__ := FALedgerEntries."Straight-Line %";
                end;

                FALedgerEntries.Reset();
                FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                FALEDGERENTRIES.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::Disposal);
                FALedgerEntries.SetRange(FALedgerEntries."FA Posting Type", FALedgerEntries."FA Posting Type"::"Acquisition Cost");
                IF FALedgerEntries.FIND('-') THEN begin
                    FALedgerEntries.CalcSums(Amount);
                    Disposals := FALedgerEntries.Amount;
                    //Straight_Line__ := FALedgerEntries."Straight-Line %";
                end;


                // FALedgerEntries.Reset();
                // FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                // FALedgerEntries.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                // FALedgerEntries.SetFilter("FA Posting Type", '%1|%2', FALedgerEntries."FA Posting Type"::"Acquisition Cost", FALedgerEntries."FA Posting Type"::Depreciation);
                // FALedgerEntries.SetLoadFields("FA Posting Type", "Posting Date", "FA Posting Category", "Amount", "FA Class Code");
                // IF FALedgerEntries.Find('-') THEN begin
                //     case
                //         FALedgerEntries."FA Posting Type" of
                //         FALedgerEntries."FA Posting Type"::"Acquisition Cost":
                //             begin
                //                 FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::"Acquisition Cost");
                //                 FALedgerEntries.CalcSums(Amount);
                //                 AssetAdditions := FALedgerEntries.Amount;

                //                 if FALedgerEntries."FA Posting Category" = FALedgerEntries."FA Posting Category"::Disposal then begin
                //                     FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::"Acquisition Cost");
                //                     FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::Disposal);
                //                     FALedgerEntries.CalcSums(Amount);
                //                     Disposals := FALedgerEntries.Amount;
                //                 end;
                //             end;

                //         FALedgerEntries."FA Posting Type"::Depreciation:
                //             begin
                //                 FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
                //                 FALedgerEntries.CalcSums(Amount);
                //                 ChargeForTheYearWithinTheYear := FALedgerEntries.Amount;

                //                 if FALedgerEntries."FA Posting Category" = FALedgerEntries."FA Posting Category"::Disposal then begin
                //                     FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
                //                     FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::Disposal);
                //                     FALedgerEntries.CalcSums(Amount);
                //                     AccumulatedDepreciationforDisposal := FALedgerEntries.Amount;
                //                 end;
                //             end;
                //     end;
                // end;


                // FALedgerEntries.RESET;
                // FALedgerEntries.SetFilter("Posting Date", StartDateFilter);
                // FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::" ");
                // FALedgerEntries.SETFILTER(FALedgerEntries."FA Posting Type", '%1|%2', FALedgerEntries."FA Posting Type"::"Acquisition Cost", FALedgerEntries."FA Posting Type"::Depreciation);
                // FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                // FALedgerEntries.SetLoadFields("FA Posting Type", "Posting Date", "FA Posting Category", "Amount", "FA Class Code");
                // IF FALedgerEntries.Find('-') THEN begin
                //     case
                //         FALedgerEntries."FA Posting Type" of
                //         FALedgerEntries."FA Posting Type"::"Acquisition Cost":
                //             begin
                //                 FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::"Acquisition Cost");
                //                 FALedgerEntries.CalcSums(Amount);
                //                 BalanceBF := FALedgerEntries.Amount;
                //             end;
                //         FALedgerEntries."FA Posting Type"::Depreciation:
                //             begin
                //                 FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
                //                 FALedgerEntries.CalcSums(Amount);
                //                 ChargeForTheYearBeforeStartDate := FALedgerEntries.Amount;
                //             end;
                //     end;

                BalAsAtEndDateCost := AssetAdditions + Disposals + BalanceBF;
                BalAsAtEndDateAccumDep := ChargeForTheYearBeforeStartDate + AccumulatedDepreciationforDisposal + ChargeForTheYearWithinTheYear;
                NBVAsAtEndDate := BalAsAtEndDateCost + BalAsAtEndDateAccumDep;

                //end;
            end;


            trigger OnPreDataItem()

            begin
                StartDateFilter := '..' + Format(StartDate);
                EndDateFilter := '..' + Format(EndDate);

                FALedgerEntries.RESET;
                FALedgerEntries.SetFilter("Posting Date", StartDateFilter);
                FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::" ");
                FALedgerEntries.SetRange(FALedgerEntries."FA Posting Type", FALedgerEntries."FA Posting Type"::"Acquisition Cost");
                FALedgerEntries.CalcSums(Amount);
                BalanceBFTotals := FALedgerEntries.Amount;

                FALedgerEntries.Reset();
                FALEDGERENTRIES.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::" ");
                FALedgerEntries.SetRange(FALedgerEntries."FA Posting Type", FALedgerEntries."FA Posting Type"::"Acquisition Cost");
                FALedgerEntries.CalcSums(Amount);
                AdditionsTotals := FALedgerEntries.Amount;

                // FALedgerEntries.Reset();
                // FALedgerEntries.SetFilter("Posting Date", EndDateFilter);
                // FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::" ");
                // FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::"Acquisition Cost");
                // FALedgerEntries.CalcSums(Amount);
                // BalanceAsAtEndDate := FALedgerEntries.Amount;

                FALedgerEntries.Reset();
                FALEDGERENTRIES.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::Disposal);
                FALedgerEntries.SetRange(FALedgerEntries."FA Posting Type", FALedgerEntries."FA Posting Type"::"Acquisition Cost");
                FALedgerEntries.CalcSums(Amount);
                DisposalaAcquisitionCosts := FALedgerEntries.Amount;

                FALedgerEntries.RESET;
                FALedgerEntries.SetFilter("Posting Date", StartDateFilter);
                FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::" ");
                FALedgerEntries.SetRange(FALedgerEntries."FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
                FALedgerEntries.CalcSums(Amount);
                TotalDepreciationsBF := FALedgerEntries.Amount;

                FALedgerEntries.Reset();
                FALEDGERENTRIES.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::Disposal);
                FALedgerEntries.SetRange(FALedgerEntries."FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
                FALedgerEntries.CalcSums(Amount);
                DepreciationForDisposalTotal := FALedgerEntries.Amount;

                FALedgerEntries.Reset();
                FALEDGERENTRIES.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::" ");
                FALedgerEntries.SetRange(FALedgerEntries."FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
                FALedgerEntries.CalcSums(Amount);
                ChargeWithinTheYearTotals := FALedgerEntries.Amount;

                TotalBalAstEndDate := BalanceBFTotals + AdditionsTotals + DisposalaAcquisitionCosts;
                AccDepAsAtEndDateTotal := TotalDepreciationsBF + ChargeWithinTheYearTotals + DepreciationForDisposalTotal;
                TotalNBV := TotalBalAstEndDate + AccDepAsAtEndDateTotal;
                //AdditionsTotals := BalanceBFTotals - BalanceAsAtEndDate;

                // FALedgerEntries.Reset();
                // FALEDGERENTRIES.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                // FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::" ");
                // FALedgerEntries.SetFilter(FALedgerEntries."FA Posting Type", '%1|%2', FALedgerEntries."FA Posting Type"::Depreciation, FALEDGERENTRIES."FA Posting Type"::"Acquisition Cost");
                // case FALedgerEntries."FA Posting Type" of
                //     FALedgerEntries."FA Posting Type"::"Acquisition Cost":
                //         begin
                //             FALedgerEntries.CalcSums(Amount);
                //             AdditionsTotals := FALedgerEntries.Amount;
                //             while FALedgerEntries."FA Posting Category" = FALedgerEntries."FA Posting Category"::Disposal do begin
                //                 FALedgerEntries.CalcSums(Amount);
                //                 Disposals := FALedgerEntries.Amount;
                //             end;
                //         end;

                //     FALedgerEntries."FA Posting Type"::Depreciation:
                //         begin
                //             FALedgerEntries.CalcSums(Amount);
                //             ChargeWithinTheYearTotals := FALedgerEntries.Amount;
                //             while FALedgerEntries."FA Posting Category" = FALedgerEntries."FA Posting Category"::Disposal do begin
                //                 FALedgerEntries.CalcSums(Amount);
                //                 DepreciationForDisposalTotal := FALedgerEntries.Amount;
                //             end;
                //         end;
                // end;
            END;

            trigger OnPostDataItem()


            begin


            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(StartDate; StartDate) { }
                    field(EndDate; EndDate) { }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    // procedure GetAllMovementValues(Var FAledgerEntries: Record "FA Ledger Entry"; FAssets: Record "Fixed Asset"; StartDate: Date; EndDate: Date; BalanceBF: Decimal)
    // begin
    //     "FA Ledger Entry".SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
    //     if "FA Ledger Entry".Find('-') then begin
    //         case
    //             "FA Ledger Entry"."FA Posting Type" of
    //             "FA Ledger Entry"."FA Posting Type"::"Acquisition Cost":
    //                 begin
    //                     IF "FA Ledger Entry"."Posting Date" < StartDate THEN begin
    //                         "FA Ledger Entry".CalcSums(Amount);
    //                         BalanceBF += "FA Ledger Entry".Amount;
    //                     end
    //                     else if "FA Ledger Entry"."Posting Date" > StartDate then begin
    //                         while "FA Ledger Entry"."Posting Date" < EndDate do begin
    //                             "FA Ledger Entry".CalcSums(Amount);
    //                             AssetAdditions += "FA Ledger Entry".Amount;
    //                             if "FA Ledger Entry"."FA Posting Category" = "FA Ledger Entry"."FA Posting Category"::Disposal then begin
    //                                 "FA Ledger Entry".CalcSums(Amount);
    //                                 Disposals += "FA Ledger Entry".Amount;
    //                             end;
    //                         end;
    //                     end;
    //                 end;

    //             "FA Ledger Entry"."FA Posting Type"::Depreciation:
    //                 begin
    //                     IF "FA Ledger Entry"."Posting Date" < StartDate THEN begin
    //                         "FA Ledger Entry".CalcSums(Amount);
    //                         ChargeForTheYearBeforeStartDate += "FA Ledger Entry".Amount;
    //                     end
    //                     else if "FA Ledger Entry"."Posting Date" > StartDate then begin
    //                         while "FA Ledger Entry"."Posting Date" < EndDate do begin
    //                             "FA Ledger Entry".CalcSums(Amount);
    //                             ChargeWithinTheYearTotals += "FA Ledger Entry".Amount;
    //                             if "FA Ledger Entry"."FA Posting Category" = "FA Ledger Entry"."FA Posting Category"::Disposal then begin
    //                                 "FA Ledger Entry".CalcSums(Amount);
    //                                 Disposals += "FA Ledger Entry".Amount;
    //                             end;
    //                         end;

    //                     end;
    //                 end;
    //         end;

    //     end;
    // end;

    var
        StartDate: Date;
        EndDate: Date;
        BalanceBF: Decimal;
        AssetAdditions: Decimal;
        Depreciation: Decimal;
        Disposals: Decimal;
        AccDepreciation: Decimal;
        // MarkedforDisposalDepreciation: Decimal;
        AccumulatedDepreciationforDisposal: Decimal;
        //MarkedforDisposalAcquisition: Decimal;
        BalAsAtEndDateCost: Decimal;
        BalAsAtEndDateAccumDep: Decimal;
        ChargeForTheYearWithinTheYear: Decimal;
        ChargeForTheYearBeforeStartDate: Decimal;
        ChargeForTheYearBeforeEndDate: Decimal;
        TotalDepreciations: Decimal;
        NBVAsAtEndDate: Decimal;
        FALedgerEntries: Record "FA Ledger Entry";
        //FALedgerEntriesT: Record "FA Ledger Entry";
        Straight_Line__: Decimal;
        StartDateFilter: Text;
        EndDateFilter: Text;
        BalanceAsAtEndDate: Decimal;
        AssetAdditionsPlusBalanceBF: Decimal;
        //Cost: Decimal;
        //CostBalAsAtEndDate: Decimal;
        AccumulatedDepreciationAsAtEndDate: Decimal;
        BalanceBFTotals: Decimal;
        DepreciationForDisposalTotal: Decimal;
        ChargeWithinTheYearTotals: Decimal;
        TotalDepreciationsBF: Decimal;
        DisposalaAcquisitionCosts: Decimal;
        AdditionsTotals: Decimal;
        TotalBalAstEndDate: Decimal;
        AccDepAsAtEndDateTotal: Decimal;
        TotalNBV: Decimal;
        FAClass: Record "FA Class";


}
