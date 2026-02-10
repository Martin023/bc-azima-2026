page 52186150 "Rejected Salary Agreement List"
{
    //CardPageID = "Salary Agreement Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Salary Agreement";
    SourceTableView = WHERE(Status = FILTER(Rejected));
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
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Ministry; Rec.Ministry)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fosa Account No"; Rec."Fosa Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("With Effect From"; Rec."With Effect From")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        UserSetup.Reset;
        UserSetup.SetRange("User ID", Rec.User);
        if UserSetup.FindFirst then
            BranchCode := UserSetup."Global Dimension 2 Code";
    end;

    var
        BranchCode: Code[30];
        UserSetup: Record "User Setup";
}

