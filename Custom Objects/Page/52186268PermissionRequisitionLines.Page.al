page 52186268 "Permission Requisition Lines"
{
    PageType = ListPart;
    SourceTable = "Permission Requisition Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Role';
                }
                // field(Role; Rec.Role)
                // {
                //     ApplicationArea = Basic, Suite;
                //     //Enabled = roleEditable;

                //     trigger OnValidate()
                //     begin
                //         // AggregatePermissionSet.Reset;
                //         // AggregatePermissionSet.SetRange("Role ID", Rec.Role);
                //         // if AggregatePermissionSet.FindFirst then
                //         //     Rec."Reason For Request" := AggregatePermissionSet.Name;
                //     end;
                // }
                field("Reason For Request"; Rec."Reason For Request")
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = false;
                    Width = 20;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Granted; Rec.Granted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Granted\Denied By"; Rec."Granted\Denied By")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    var
        roleEditable: Boolean;
        AggregatePermissionSet: Record "Aggregate Permission Set";
}

