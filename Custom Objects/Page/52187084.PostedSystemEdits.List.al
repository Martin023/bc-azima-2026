page 52187084 "Posted System Edits List"
{
    ApplicationArea = All;
    Caption = 'Posted System Edits List';
    PageType = List;
    SourceTable = "System Edits";
    InsertAllowed = true;
    Editable = false;
    DeleteAllowed = false;
    CardPageId = "System Edits Card";
    SourceTableView = where(Posted = const(true));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                }
                field("Table ID"; Rec."Table ID")
                {

                }
                field("Table Name"; Rec."Table Name")
                {

                }
                field("Edits Reason"; Rec."Edits Reason")
                {

                }
                field("Application Date"; Rec."Application Date")
                {

                }
                field("Innitiating Officer";Rec."Innitiating Officer")
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {

                }
                field(Status; Rec.Status)
                {

                }
                field(Posted; Rec.Posted)
                {

                }
            }
        }
    }
}
