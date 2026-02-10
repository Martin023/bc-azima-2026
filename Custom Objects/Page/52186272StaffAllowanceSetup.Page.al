page 52186272 "Staff Allowance Setup"
{
    PageType = List;
    Permissions = TableData "Staff Allowance Setup" = rimd;
    SourceTable = "Staff Allowance Setup";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
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
                field("Exempt Amount"; Rec."Exempt Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Allowance Amount"; Rec."Allowance Amount")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        UserSetup.GetDefaultSalesAmountApprovalLimit();
    end;

    var
        UserSetup: Record "User Setup";
}

