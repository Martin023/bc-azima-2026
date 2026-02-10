page 52186275 "Staff Allowance Lines"
{
    PageType = List;
    SourceTable = "Staff Allowance Lines";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Header Code"; Rec."Header Code")
                {
                    ApplicationArea = Basic;
                }
                field("Allowance Code"; Rec."Allowance Code")
                {
                    ApplicationArea = Basic;
                }
                field("Allowance Description"; Rec."Allowance Description")
                {
                    ApplicationArea = Basic;
                }
                field("Allowance Amount"; Rec."Allowance Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Exempt Amount"; Rec."Exempt Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Tax %"; Rec."Tax %")
                {
                    ApplicationArea = Basic;
                }
                field("Tax GL"; Rec."Tax GL")
                {
                    ApplicationArea = Basic;
                }
                field("Allowance GL"; Rec."Allowance GL")
                {
                    ApplicationArea = Basic;
                }
                field("Pay to Savings Account"; Rec."Pay to Savings Account")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

