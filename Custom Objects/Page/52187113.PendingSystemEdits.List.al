page 52187113 "Pending System Edits"
{
    ApplicationArea = All;
    Caption = 'System Edits List';
    PageType = List;
    SourceTable = "System Edits";
    InsertAllowed = true;
    Editable = false;
    DeleteAllowed = false;
    CardPageId = "System Edits Card";
    SourceTableView = where(Status = filter(<>open), Posted = const(FALSE));
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
                field("CRM No"; Rec."CRM No")
                {

                }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    Editable = false;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    Editable = false;
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

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SetFilter("Responsible Officer",UserId);
    end;
}
