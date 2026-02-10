page 52186634 "prBoard Earning"
{
    PageType = List;
    SourceTable = "prBoard Earnings";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Journal Entry"; Rec."Journal Entry")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Board"; Rec."Total Board")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is PV Item"; Rec."Is PV Item")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Other Relief"; Rec."Is Other Relief")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Leave Allowance"; Rec."Is Leave Allowance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(IsMandatory; Rec.IsMandatory)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Pension Relief"; Rec."Is Pension Relief")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Insurance Relief"; Rec."Is Insurance Relief")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is HouseAll/NonPensionable"; Rec."Is HouseAll/NonPensionable")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Rounding; Rec.Rounding)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Insurance Relief"; Rec."Insurance Relief")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Pay Type"; Rec."Pay Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Calculation Method"; Rec."Calculation Method")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Flat Amount"; Rec."Flat Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Taxable; Rec.Taxable)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Deduction"; Rec."Is Deduction")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    var
                        myInt: Integer;

                    begin
                        if Rec."Is Deduction" = true then
                            Rec.TestField(Rec."G/L Account");

                    end;
                }
                field("Reduces Tax"; Rec."Reduces Tax")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Non-Cash Benefit"; Rec."Non-Cash Benefit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Months; Rec.Months)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Quarters; Rec.Quarters)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Overtime Factor"; Rec."Overtime Factor")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Telephone Allowance"; Rec."Is Telephone Allowance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Limit"; Rec."Minimum Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maximum Limit"; Rec."Maximum Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Salary Advance"; Rec."Is Salary Advance")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

