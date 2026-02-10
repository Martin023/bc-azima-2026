page 52187322 "Promise Topay Header"
{
    Editable = false;
    PageType = List;
    SourceTable = "Promise Topay Header";
    CardPageId = "Promise Topay Card";

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
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {

                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    Editable = false;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Created At"; Rec."Created At")
                {
                    Editable = false;
                }
                field("Promise Status"; Rec."Promise Status")
                {
                    Editable = false;
                }
                field("Closed By"; Rec."Closed By")
                {
                    Editable = false;
                }
                field("Closed At"; Rec."Closed At")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Process Promises")
            {
                ApplicationArea = Basic, Suite;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = report "Process Promise Topay";
            }
        }
    }

    trigger OnOpenPage()
    begin

    end;

    trigger OnAfterGetRecord()
    begin
    end;



}

