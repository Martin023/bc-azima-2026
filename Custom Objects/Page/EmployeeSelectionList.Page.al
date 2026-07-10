page 52186154 "Employee Selection List"
{
    Caption = 'Select Employees';
    PageType = List;
    SourceTable = "HR Employees";
    ApplicationArea = Basic;
    Editable = false;
    MultipleNewLines = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field("Responsibility Center"; Rec."Responsibility Center")
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
                Image = SelectMore;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.FindSet then
                        repeat
                            Rec.Mark(true);
                        until Rec.Next = 0;
                    Message('%1 employee(s) selected. Click OK to continue.', Rec.Count);
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
                    Message('All selections cleared.');
                end;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        TempEmp: Record "HR Employees" temporary;
    begin
        if CloseAction = ACTION::LookupOK then begin
            CurrPage.SetSelectionFilter(Rec);
            if Rec.FindSet then begin
                repeat
                    Rec.Mark(true);
                until Rec.Next = 0;
            end;
        end;
        exit(true);
    end;

    procedure GetSelectedEmployees(var TempEmployee: Record "HR Employees" temporary)
    begin
        TempEmployee.DeleteAll;
        Rec.MarkedOnly(true);
        if Rec.FindSet then
            repeat
                TempEmployee := Rec;
                TempEmployee.Insert;
            until Rec.Next = 0;
        Rec.MarkedOnly(false);
    end;
}
