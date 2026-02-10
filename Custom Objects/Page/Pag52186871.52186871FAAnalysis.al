namespace MNSProjectMwanga.MNSProjectMwanga;

using Microsoft.FixedAssets.Depreciation;

page 52186871 "52186871FA Analysis"
{
    ApplicationArea = All;
    Caption = 'Fixed Asset Analysis';
    PageType = List;
    SourceTable = "FA Depreciation Book";
    UsageCategory = Lists;
    editable = false;
    insertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("FA No."; Rec."FA No.")
                {
                    ToolTip = 'Specifies the number of the related fixed asset. ';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value in the Description field on the fixed asset card.';
                }
                field("Acquisition Cost"; Rec."Acquisition Cost")
                {
                    ToolTip = 'Specifies the total acquisition cost for the fixed asset.';
                }
                field("Acquisition Date"; Rec."Acquisition Date")
                {
                    ToolTip = 'Specifies the FA posting date of the first posted acquisition cost.';
                }
                field("Accum. Depr. % (Custom 1)"; Rec."Accum. Depr. % (Custom 1)")
                {
                    ToolTip = 'Specifies the total percentage for depreciation of custom 1 entries.';
                }
                field(Appreciation; Rec.Appreciation)
                {
                    ToolTip = 'Specifies the total appreciation for the fixed asset.';
                }
                field(Depreciation; Rec.Depreciation)
                {
                    ToolTip = 'Specifies the total depreciation for the fixed asset.';
                }
                field("Book Value"; Rec."Book Value")
                {
                    ToolTip = 'Specifies the book value for the fixed asset.';
                }
            }
        }
    }
}
