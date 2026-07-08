page 52186154 "Employee Selection List"
{
    Caption = 'Select Employees';
    PageType = List;
    SourceTable = "HR Employees";
    ApplicationArea = Basic;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Mark; Rec.Mark)
                {
                    ApplicationArea = Basic;
                    Caption = 'Select';
                    Editable = true;

                    trigger OnValidate()
                    begin
                        Rec.Mark(Rec.Mark);
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = Basic;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Select All")
            {
                ApplicationArea = Basic;
                Caption = 'Select All';
                // Image = selectall;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.FindSet then
                        repeat
                            Rec.Mark := true;
                            Rec.Mark(true);
                        until Rec.Next = 0;
                    CurrPage.Update(false);
                end;
            }
            action("Clear Selection")
            {
                ApplicationArea = Basic;
                Caption = 'Clear Selection';
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.ClearMarks;
                    if Rec.FindSet then
                        repeat
                            Rec.Mark := false;
                        until Rec.Next = 0;
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
