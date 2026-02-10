page 52186034 "Contract Expectation Details-L"
{
    PageType = List;
    SourceTable = "Contract Expectation Details";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract No"; Rec."Contract No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contractor No"; Rec."Contractor No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Contractor Name"; Rec."Contractor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("Cycle Code"; Rec."Cycle Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Cycle Stage"; Rec."Cycle Stage")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Expectation Code"; Rec."Expectation Code")
                {
                    Caption = 'Milestone Code';
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Staff User ID"; Rec."Staff User ID")
                {
                    Caption = 'Staff User ID';
                    ApplicationArea = Basic, Suite;
                }
                field("Person Responsible Name"; Rec."Person Responsible")
                {
                    Caption = 'Staff Responsible Name';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Done; Rec.Done)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Done"; Rec."Date Done")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Done By"; Rec."Done By")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("%age Paid"; Rec."%age Paid")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field(Type; Rec.Type)
                // {
                //     ApplicationArea = Basic, Suite;
                // }

                // field("Invoice No"; Rec."Invoice No")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Branch Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                Field("Activity Code"; Rec."Global Dimension 2 Code")
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
}

