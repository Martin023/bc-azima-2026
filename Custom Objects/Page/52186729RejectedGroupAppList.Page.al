page 52186729 "Rejected Group App List"
{
    CardPageID = "Member Application Group";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Member Application";
    SourceTableView = WHERE(Status = CONST(Rejected), "Account Type" = filter(<> "Single Member Account"), "Account Type" = filter("Group Account"));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control13)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("P.I.N Number"; Rec."P.I.N Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Created By", '=%1', UserId);
    end;
}

