namespace MNS.MNS;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.FixedAssets.Ledger;

report 52186178 MovementScheduleII
{
    ApplicationArea = All;
    Caption = 'MovementScheduleII';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/MovementScheduleII.rdl';

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            //DataItemTableView = where(Acquired = const(true));

            RequestFilterFields = "No.", "FA Class Code";
            column(Asset_No_; "No.") { }
            column(Description; Description) { }
            column(FA_Class_Code; "FA Class Code") { }
            column(BalanceBF; BalanceBF) { }
            column(AssetAdditions; AssetAdditions) { }
            column(Depreciation; Depreciation) { }
            column(AccDepreciation; AccDepreciation) { }
            column(BalanceBFTotals; BalanceBFTotals) { }
            column(MarkedforDisposalDepreciation; MarkedforDisposalDepreciation) { }
            column(MarkedforDisposalAcquisition; MarkedforDisposalAcquisition) { }
            column(ChargeForTheYearWithinTheYear; ChargeForTheYearWithinTheYear) { }
            column(ChargeForTheYearBeforeStartDate; ChargeForTheYearBeforeStartDate) { }
            column(AccumulatedDepreciationforDisposal; AccumulatedDepreciationforDisposal) { }
            column(BalAsAtEndDateCost; BalAsAtEndDateCost) { }
            column(BalAsAtEndDateAccumDep; BalAsAtEndDateAccumDep) { }
            column(NBVAsAtEndDate; NBVAsAtEndDate) { }
            column(TotalDepreciations; TotalDepreciations) { }
            column(TotalCost; Cost) { }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
            column(Disposals; Disposals) { }
            //Column(Straight_Line__; Straight_Line__) { }
            column(AssetAdditionsPlusBalanceBF; AssetAdditionsPlusBalanceBF) { }
            column(BalanceAsAtEndDate; BalanceAsAtEndDate) { }
            column(CostBalAsAtEndDate; CostBalAsAtEndDate) { }
            column(AccumulatedDepreciationAsAtEndDate; AccumulatedDepreciationAsAtEndDate) { }


            column(DepreciationForDisposalTotal; DepreciationForDisposalTotal) { }
            column(AdditionsTotals; AdditionsTotals) { }
            column(DisposalaAcquisitionCosts; DisposalaAcquisitionCosts) { }
            column(ChargeWithinTheYearTotals; ChargeWithinTheYearTotals) { }
            column(TotalDepreciationsBF; TotalDepreciationsBF) { }
            column(TotalBalAstEndDate; TotalBalAstEndDate) { }
            column(AccDepAsAtEndDateTotal; AccDepAsAtEndDateTotal) { }

            dataitem("FA Ledger Entry"; "FA Ledger Entry")
            {
                DataItemLinkReference = "Fixed Asset";
                DataItemLink = "FA Class Code" = field("FA Class Code");
                column(Straight_Line__; "Straight-Line %") { }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin

                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

                StartDateFilter := '..' + Format(StartDate);
                EndDateFilter := '..' + Format(EndDate);

                FALedgerEntries.Reset();
                FALedgerEntries.SetFilter("FA Posting Type", '%1|%2', FALedgerEntries."FA Posting Type"::"Acquisition Cost", FALedgerEntries."FA Posting Type"::Depreciation);
                FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                FALedgerEntries.SetFilter("Posting Date", StartDateFilter);
                if FALedgerEntries.Find('-') then begin
                    case
                        FALedgerEntries."FA Posting Type" of
                        FALedgerEntries."FA Posting Type"::"Acquisition Cost":
                            begin
                                FALedgerEntries.CalcSums(Amount);
                                BalanceBF := FALedgerEntries.Amount;
                            end;

                        FALedgerEntries."FA Posting Type"::Depreciation:
                            begin
                                FALedgerEntries.CalcSums(Amount);
                                ChargeForTheYearBeforeStartDate := FALedgerEntries.Amount;
                            end;
                    end;
                    //Asset Balance & Depreciation Brought Forward
                end;

                FALedgerEntries.Reset();
                FALedgerEntries.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                FALedgerEntries.SetFilter("FA Posting Type", '%1|%2', FALedgerEntries."FA Posting Type"::"Acquisition Cost", FALedgerEntries."FA Posting Type"::Depreciation);
                FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                IF FALedgerEntries.Find('-') THEN BEGIN
                    CASE FALedgerEntries."FA Posting Type" OF
                        FALedgerEntries."FA Posting Type"::"Acquisition Cost":
                            begin
                                FALedgerEntries.CalcSums(Amount);
                                AssetAdditions := FALedgerEntries.Amount;
                            end;

                        FALedgerEntries."FA Posting Type"::Depreciation:
                            begin
                                FALedgerEntries.CalcSums(Amount);
                                ChargeForTheYearWithinTheYear := FALedgerEntries.Amount;
                            end;

                    END;
                    //Asset Additions & Depreciation Between Period
                END;

                FALedgerEntries.Reset();
                FALedgerEntries.SetFilter("FA Posting Date", '%1..%2', StartDate, EndDate);
                FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::Disposal);
                FALedgerEntries.SetFilter("FA Posting Type", '%1|%2', FALedgerEntries."FA Posting Type"::"Acquisition Cost", FALedgerEntries."FA Posting Type"::Depreciation);
                FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                if FALedgerEntries.Find('-') then begin
                    case
                        FALedgerEntries."FA Posting Type" of
                        FALedgerEntries."FA Posting Type"::"Acquisition Cost":
                            begin
                                FALedgerEntries.CalcSums(Amount);
                                Disposals := FALedgerEntries.Amount;
                            end;
                        FALedgerEntries."FA Posting Type"::Depreciation:
                            begin
                                FALedgerEntries.CalcSums(Amount);
                                AccumulatedDepreciationforDisposal := FALedgerEntries.Amount;
                            end;
                    end;
                    //Disposals & Accumulated Depreciation for Disposal Detween Period
                end;



                // FALedgerEntries.Reset();
                // FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::"Acquisition Cost");
                // FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                // FALedgerEntries.SetFilter("Posting Date", EndDateFilter);
                // if FALedgerEntries.Find('-') then begin
                //     FALedgerEntries.CalcSums(Amount);
                //     BalanceAsAtEndDate += FALedgerEntries.Amount;
                //     //Balance As At End Date Filter
                // end;

                //AssetAdditions := BalanceAsAtEndDate - BalanceBF;
                //Asstes additions Between Period

                //Totals
                //1 Acquisition Costs

                FALedgerEntries.Reset();
                FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                FALedgerEntries.SetFilter("FA Posting Type", '%1|%2', FALedgerEntries."FA Posting Type"::"Acquisition Cost", FALedgerEntries."FA Posting Type"::Depreciation);
                FALedgerEntries.SetFilter("Posting Date", StartDateFilter);
                if FALedgerEntries.Find('-') then begin
                    case
                        FALedgerEntries."FA Posting Type" of
                        FALedgerEntries."FA Posting Type"::"Acquisition Cost":
                            begin
                                FALedgerEntries.CalcSums(Amount);
                                BalanceBFTotals := FALedgerEntries.Amount;
                            end;
                        FALedgerEntries."FA Posting Type"::Depreciation:
                            begin
                                FALedgerEntries.CalcSums(Amount);
                                TotalDepreciationsBF := FALedgerEntries.Amount;
                            end;
                    end;
                end;

                // FALedgerEntries.Reset();
                // FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::"Acquisition Cost");
                // FALedgerEntries.SetFilter("Posting Date", StartDateFilter);
                // if FALedgerEntries.Find('-') then begin
                //     FALedgerEntries.CalcSums(Amount);
                //     BalanceBFTotals += FALedgerEntries.Amount;
                //     //Asset Balance Brought Forward Totals
                // end;

                // FALedgerEntries.Reset();
                // FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::"Acquisition Cost");
                // FALedgerEntries.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                // if FALedgerEntries.Find('-') then begin
                //     FALedgerEntries.CalcSums(Amount);
                //     AdditionsTotals += FALedgerEntries.Amount;
                //     //Asset Balance Brought Forward
                // end;

                FALedgerEntries.Reset();
                FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                FALedgerEntries.SetFilter("FA Posting Type", '%1|%2', FALedgerEntries."FA Posting Type"::"Acquisition Cost", FALedgerEntries."FA Posting Type"::Depreciation);
                FALedgerEntries.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                if FALedgerEntries.Find('-') then begin
                    case
                        FALedgerEntries."FA Posting Type" of
                        FALedgerEntries."FA Posting Type"::"Acquisition Cost":
                            begin
                                FALedgerEntries.CalcSums(Amount);
                                AdditionsTotals += FALedgerEntries.Amount;
                            end;
                        FALedgerEntries."FA Posting Type"::Depreciation:
                            begin
                                FALedgerEntries.CalcSums(Amount);
                                ChargeWithinTheYearTotals += FALedgerEntries.Amount;
                            end;

                    end;
                end;

                FALedgerEntries.Reset();
                FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                FALedgerEntries.SetFilter("FA Posting Type", '%1|%2', FALedgerEntries."FA Posting Type"::"Acquisition Cost", FALedgerEntries."FA Posting Type"::Depreciation);
                FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::Disposal);
                FALedgerEntries.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                if FALedgerEntries.Find('-') then begin
                    case
                        FALedgerEntries."FA Posting Type" of
                        FALedgerEntries."FA Posting Type"::"Acquisition Cost":
                            begin
                                FALedgerEntries.CalcSums(Amount);
                                DisposalaAcquisitionCosts += FALedgerEntries.Amount;
                            end;
                        FALedgerEntries."FA Posting Type"::Depreciation:
                            begin
                                FALedgerEntries.CalcSums(Amount);
                                DepreciationForDisposalTotal += FALedgerEntries.Amount;
                            end;
                    end;
                end;


                // FALedgerEntries.Reset();
                // FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::"Acquisition Cost");
                // FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::Disposal);
                // FALedgerEntries.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                // if FALedgerEntries.Find('-') then begin
                //     FALedgerEntries.CalcSums(Amount);
                //     DisposalaAcquisitionCosts += FALedgerEntries.Amount;
                //     //Asset Balance Brought Forward
                // end;
                TotalBalAstEndDate := BalanceBFTotals + AdditionsTotals - DisposalaAcquisitionCosts;

                //2 Depreciation
                // FALedgerEntries.Reset();
                // FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
                // FALedgerEntries.SetFilter("Posting Date", StartDateFilter);
                // FALedgerEntries.SetLoadFields(Amount);
                // if FALedgerEntries.FIND('-') THEN BEGIN
                //     FALedgerEntries.CalcSums(Amount);
                //     TotalDepreciationsBF += FALedgerEntries.Amount;
                // END;

                // FALedgerEntries.Reset();
                // FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
                // FALedgerEntries.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                // FALedgerEntries.SetLoadFields(Amount);
                // if FALedgerEntries.FIND('-') THEN BEGIN
                //     FALedgerEntries.CalcSums(Amount);
                //     ChargeWithinTheYearTotals += FALedgerEntries.Amount;
                // END;

                // FALedgerEntries.Reset();
                // FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::Disposal);
                // FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
                // FALedgerEntries.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                // FALedgerEntries.SetLoadFields(Amount);
                // if FALedgerEntries.FIND('-') THEN BEGIN
                //     FALedgerEntries.CalcSums(Amount);
                //     DepreciationForDisposalTotal += FALedgerEntries.Amount;
                // END;

                AccDepAsAtEndDateTotal := TotalDepreciationsBF + ChargeWithinTheYearTotals - DepreciationForDisposalTotal;
                //End of Totals


                // FALedgerEntries.Reset();
                // FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::Disposal);
                // FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::"Acquisition Cost");
                // FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                // FALedgerEntries.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                // FALedgerEntries.SetLoadFields(Amount);
                // if FALedgerEntries.Find('-') then begin
                //     if FALedgerEntries.Find('-') then begin
                //         FALedgerEntries.CalcSums(Amount);
                //         Disposals := FALedgerEntries.Amount;
                //         //Acquisition Cost for disposed assets between the period
                //     end;
                // end;
                //Totals

                AssetAdditionsPlusBalanceBF := BalanceBF + AssetAdditions + Disposals;
                //Bal BF + (Additions - Disposals)
                //CostBalAsAtEndDate := BalanceBF + MarkedforDisposalAcquisition +  Disposals + MarkedforDisposalAcquisition ;


                // FALedgerEntries.RESET();
                // FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::Disposal);
                // FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
                // FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                // //FALedgerEntries.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                // FALedgerEntries.SetLoadFields(Amount);
                // if FALedgerEntries.Find('-') then begin
                //     if FALedgerEntries."Posting Date" < StartDate then begin
                //         FALedgerEntries.CalcSums(Amount);
                //         AccDepreciation := FALedgerEntries.Amount;
                //         //Accumulated depreciation between period
                //     end;
                // end;

                BalAsAtEndDateCost := BalanceBF + AssetAdditions + Disposals;
                //Bal BF + (Additions - Disposals)
                BalAsAtEndDateAccumDep := AccDepreciation + Disposals + ChargeForTheYearWithinTheYear;
                //Openung Bal. - (Disposal + Charge For The Year)

                // FALedgerEntries.Reset();
                // FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
                // FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                // FALedgerEntries.SetFilter("Posting Date", StartDateFilter);
                // FALedgerEntries.SetLoadFields(Amount);
                // if FALedgerEntries.Find('-') then begin
                //     FALedgerEntries.CalcSums(Amount);
                //     ChargeForTheYearBeforeStartDate := FALedgerEntries.Amount;
                //     //Depreciation Brought Forward
                // end;

                // FALedgerEntries.Reset();
                // FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
                // FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                // FALedgerEntries.SetFilter("Posting Date", EndDateFilter);
                // FALedgerEntries.SetLoadFields(Amount);
                // if FALedgerEntries.Find('-') then begin
                //     FALedgerEntries.CalcSums(Amount);
                //     ChargeForTheYearBeforeEndDate := FALedgerEntries.Amount;
                //     //Depreciation as at end date
                // end;

                ChargeForTheYearWithinTheYear := ChargeForTheYearBeforeEndDate - ChargeForTheYearBeforeStartDate;

                // FALedgerEntries.Reset();
                // FALedgerEntries.SetRange("FA Class Code", "Fixed Asset"."FA Class Code");
                // FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::Depreciation);
                // FALedgerEntries.SetRange("FA Posting Category", FALedgerEntries."FA Posting Category"::Disposal);
                // FALedgerEntries.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                // FALedgerEntries.SetLoadFields(Amount);
                // if FALedgerEntries.Find('-') then begin
                //     FALedgerEntries.CalcSums(Amount);
                //     AccumulatedDepreciationforDisposal := FALedgerEntries.Amount;
                //     //Accumulated Depreciation for Disposal
                // end;

                // FALedgerEntries.Reset();
                // FALedgerEntries.SetRange("FA Posting Type", FALedgerEntries."FA Posting Type"::"Acquisition Cost");
                // FALedgerEntries.SetRange("FA Class Code", FALedgerEntries."FA Class Code");
                // FALedgerEntries.SetFilter("Posting Date", EndDateFilter);
                // FALedgerEntries.SetLoadFields(Amount);
                // if FALedgerEntries.FIND('-') THEN BEGIN
                //     FALedgerEntries.CalcSums(Amount);
                //     Cost := FALedgerEntries.Amount;
                // END;




                //Cost - Total Accumulated Depr.
                // NBVAsAtEndDate := Cost - TotalDepreciations;
                NBVAsAtEndDate := BalAsAtEndDateCost + BalAsAtEndDateAccumDep;

                //Accumulated Depreciation End Date
                //AccumulatedDepreciationAsAtEndDate := AccDepreciation + AccumulatedDepreciationforDisposal + MarkedforDisposalDepreciation + ChargeForTheYearWithinTheYear;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                FALedgerEntries.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
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
    procedure GetAllMovementValues(Var FAledgerEntries: Record "FA Ledger Entry"; StartDate: Date; EndDate: Date)
    begin

    end;

    var
        StartDate: Date;
        EndDate: Date;
        BalanceBF: Decimal;
        AssetAdditions: Decimal;
        Depreciation: Decimal;
        Disposals: Decimal;
        AccDepreciation: Decimal;
        MarkedforDisposalDepreciation: Decimal;
        AccumulatedDepreciationforDisposal: Decimal;
        MarkedforDisposalAcquisition: Decimal;
        BalAsAtEndDateCost: Decimal;
        BalAsAtEndDateAccumDep: Decimal;
        ChargeForTheYearWithinTheYear: Decimal;
        ChargeForTheYearBeforeStartDate: Decimal;
        ChargeForTheYearBeforeEndDate: Decimal;
        TotalDepreciations: Decimal;
        NBVAsAtEndDate: Decimal;
        FALedgerEntries: Record "FA Ledger Entry";
        Straight_Line__: Decimal;
        StartDateFilter: Text;
        EndDateFilter: Text;
        BalanceAsAtEndDate: Decimal;
        AssetAdditionsPlusBalanceBF: Decimal;
        Cost: Decimal;
        CostBalAsAtEndDate: Decimal;
        AccumulatedDepreciationAsAtEndDate: Decimal;
        BalanceBFTotals: Decimal;
        DepreciationForDisposalTotal: Decimal;
        ChargeWithinTheYearTotals: Decimal;
        TotalDepreciationsBF: Decimal;
        DisposalaAcquisitionCosts: Decimal;
        AdditionsTotals: Decimal;
        TotalBalAstEndDate: Decimal;
        AccDepAsAtEndDateTotal: Decimal;
}
