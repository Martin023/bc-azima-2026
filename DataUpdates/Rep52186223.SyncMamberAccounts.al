namespace KenpipeCBS.KenpipeCBS;

report 52186223 "Sync Member & Accounts"
{
    ApplicationArea = All;
    Caption = 'Sync Mamber & Accounts';
    UsageCategory = Lists;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Members; Members)
        {
            column(No; "No.")
            {

            }
            trigger OnAfterGetRecord()
            begin
                if Members."Employer Code" <> '' then
                    Members.validate("Employer Code");
                members.validate("First Name");
                Members.modify;
            end;
        }
    }
}
