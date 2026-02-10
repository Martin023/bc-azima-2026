page 52185882 "Interest Due Periods"
{
    // DeleteAllowed = false;
    // InsertAllowed = false;
    PageType = List;
    SourceTable = "Interest Due Period";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Interest Due Date"; Rec."Interest Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("New Fiscal Year"; Rec."New Fiscal Year")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Locked"; Rec."Date Locked")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Closed by User"; Rec."Closed by User")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Closing Date Time"; Rec."Closing Date Time")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Period End Date"; Rec."Period End Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("No of Days"; Rec."No of Days")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            separator(Action15)
            {
            }
            action("Create Period")
            {
                ApplicationArea = Basic, Suite;
                Image = AccountingPeriods;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    REPORT.Run(Report::"Interest Due Period");
                    CreateInterestDuePeriod.CreateItDuePeriods(Rec);
                end;
            }
        }
    }

    var
        InvtPeriod: Record "Inventory Period";
        date: DateFormula;
        InterestPeriod: Record "Interest Due Period";
        CreateInterestDuePeriod: Codeunit "Periodic Activities";
}

