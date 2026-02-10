namespace KenpipeCBS.KenpipeCBS;

using Microsoft.FixedAssets.Depreciation;

tableextension 52185432 "FA Depreciation Book EXT" extends "FA Depreciation Book"
{
    fields
    {
        modify("Depreciation Method")
        {
            trigger OnBeforeValidate()
            begin
                if rec."Depreciation Method" = rec."Depreciation Method"::"Reducing Bal On NBV" then begin
                    "Straight-Line %" := 0;
                    "No. of Depreciation Years" := 0;
                    "No. of Depreciation Months" := 0;
                    "Fixed Depr. Amount" := 0;
                    "Depreciation Ending Date" := 0D;
                    "Depreciation Table Code" := '';
                    "First User-Defined Depr. Date" := 0D;
                    "Use DB% First Fiscal Year" := false;
                end;
            end;
        }
    }
}
