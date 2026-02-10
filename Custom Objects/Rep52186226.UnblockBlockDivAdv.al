namespace KenpipeCBS.KenpipeCBS;

report 52186226 "Unblock / Block Div Adv"
{
    ApplicationArea = All;
    Caption = 'Unblock / Block Div Adv';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(members; members)
        {
            trigger OnAfterGetRecord()
            begin
                if Block then
                    Members."Block Div Advance" := true;
                if Unblock then
                    members."Block Div Advance" := false;
                Members.modify;
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
                    field(Block; Block)
                    {

                    }
                    field(Unblock; Unblock)
                    {

                    }
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
    var
        Block: Boolean;
        Unblock: Boolean;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        Message('Process Complete');
    end;

    trigger OnPreReport()
    begin
        if Block and Unblock then Error('You must pick only one entry');
    end;
}
