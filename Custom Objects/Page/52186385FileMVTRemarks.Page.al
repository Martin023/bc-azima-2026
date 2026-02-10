page 52186385 "File MVT Remarks"
{
    CardPageID = "File Mvt Remarks Card";
    PageType = List;
    Caption = 'File Movement List';
    SourceTable = "File Movement Remarks";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

