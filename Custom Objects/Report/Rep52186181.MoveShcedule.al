namespace MNS.MNS;

using Microsoft.FixedAssets.Depreciation;
using Microsoft.FixedAssets.Ledger;
using Microsoft.FixedAssets.FixedAsset;

report 52186182 MoveShcedule
{
    ApplicationArea = All;
    Caption = 'MoveShcedule';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/MoveShcedule.rdl';
    dataset
    {
        dataitem(FADepreciationBook; "FA Depreciation Book")
        {
            RequestFilterFields = "FA Posting Date Filter";
            CalcFields = "Acquisition Cost", "Depreciation", "Book Value on Disposal";
            column(AssetNo; "FA No.") { }
            column(Straight_Line__; "Straight-Line %") { }
            column(FA_Posting_Date_Filter; "FA Posting Date Filter") { }
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
            dataitem("Fixed Asset"; "Fixed Asset")
            {
                DataItemLinkReference = FADepreciationBook;
                DataItemLink = "No." = field("FA No.");
                column(FA_Class_Code; "FA Class Code") { }

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                BalanceBF := 0;
                AssetAdditions := 0;
                ChargeForTheYearWithinTheYear := 0;
                ChargeForTheYearBeforeStartDate := 0;

                //if FADepreciationBook."Acquisition Date" < StartDate then begin
                FADepreciationBook.SetFilter("FA Posting Date Filter", '..%1', StartDate);
                FADepreciationBook.calcfields("Acquisition Cost");
                BalanceBF := FADepreciationBook."Acquisition Cost";
                //end;

                FADepreciationBook.SetFilter("FA Posting Date Filter", '%1..%2', StartDate, EndDate);
                FADepreciationBook.CalcFields("Acquisition Cost");
                AssetAdditions := FADepreciationBook."Acquisition Cost";


                FADepreciationBook.SetFilter("FA Posting Date Filter", '..%1', StartDate);
                FADepreciationBook.CalcFields("Depreciation");
                ChargeForTheYearBeforeStartDate := FADepreciationBook.Depreciation;


                FADepreciationBook.SetFilter("FA Posting Date Filter", '%1..%2', StartDate, EndDate);
                FADepreciationBook.CalcFields("Depreciation");
                ChargeForTheYearWithinTheYear := FADepreciationBook.Depreciation;


            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
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
                field(StartDate; StartDate)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                    ToolTip = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                    ToolTip = 'End Date';
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
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        if FADepreciationBook."FA Posting Date Filter" < StartDate then begin
            BalanceBF := FADepreciationBook."Acquisition Cost";
            ChargeForTheYearBeforeEndDate := FADepreciationBook."Depreciation";
        end;
        //FADepreciationBook.SetFilter("FA Posting Date Filter", '%1..%2', StartDate, EndDate);

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

