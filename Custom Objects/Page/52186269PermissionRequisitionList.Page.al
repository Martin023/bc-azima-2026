page 52186269 "Permission Requisition List"
{
    CardPageID = "Permission Requisition Card";
    Caption = 'Permission Requisition List';
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Permission Requisition";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approved By"; Rec."Approved By")
                {

                }
                field("Date Approved"; Rec."Date Approved")
                {

                }
                field("Time Approved"; Rec."Time Approved")
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                { }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                { }
            }
        }
    }

    actions
    {
    }
}

