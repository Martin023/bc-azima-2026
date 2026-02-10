namespace MNS.MNS;

page 52186618 "Asset Movement Schedule List"
{
    ApplicationArea = All;
    Caption = 'Asset Movement Schedule List';
    PageType = List;
    SourceTable = "Asset Movement Schedule Table";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Fixed Asset No."; Rec."Fixed Asset No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fixed Asset No. field.', Comment = '%';
                }
                field("Acquisition Cost Balance BF"; Rec."Acquisition Cost Balance BF")
                {

                }
                field("Acquisition Disposed Assets"; Rec."Acquisition Disposed Assets")
                {

                }
                field("Asset Additions"; Rec."Asset Additions")
                {

                }
                field("Depreciation Bal BF"; Rec."Depreciation Bal BF")
                {

                }
                
                field("Depreciation Within The Period"; rec. "Depreciation Within The Period")
                {

                }
                field("Depreciation Disposed Assets"; rec."Depreciation Disposed Assets")
                {

                }
                field("Start Date Filter";Rec."Start Date Filter")
                {

                }
                field("End Date Filter";Rec."End Date Filter")
                {

                }
                field("Period Between Filter";Rec."Period Between Filter")
                {
                    
                }

            }
        }
    }
}
