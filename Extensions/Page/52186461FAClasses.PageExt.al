#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186461 pageextension52186461 extends "FA Classes" 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }

       addafter("Name")
        {
            field("Depreciation Book Code"; Rec."Depreciation Book Code")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Depreciation Book Code';
                ToolTip = 'Specifies the depreciation book that is used for the fixed asset class.';

                trigger OnValidate()
                begin

                end;
            }
            field("Depreciation Method"; Rec."Depreciation Method")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Depreciation Method';
                ToolTip = 'Specifies how depreciation is calculated for the depreciation book.';

                trigger OnValidate()
                begin

                end;
            }
            field("Straight line %"; Rec."Straight-Line %")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Straight line %';
                ToolTip = 'Specifies the percentage of the acquisition cost that is depreciated each year.';

                trigger OnValidate()
                begin

                end;
            }
        }
    }
    var
        FADepreciationBook: Record "FA Depreciation Book";
}