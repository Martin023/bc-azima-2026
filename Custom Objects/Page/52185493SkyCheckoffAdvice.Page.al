page 52185493 "Sky Checkoff Advice"
{
    PageType = List;
    SourceTable = "Checkoff Advice Line";
    SourceTableView = WHERE("Captured  By" = CONST('HARAMBEESACCO\WEBPORTAL'));
    ApplicationArea = Basic;
    //UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Advice Header No."; Rec."Advice Header No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = Basic;
                }
                field("Amount On"; Rec."Amount On")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Off"; Rec."Amount Off")
                {
                    ApplicationArea = Basic;
                }
                field("Balance On"; Rec."Balance On")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Off"; Rec."Balance Off")
                {
                    ApplicationArea = Basic;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Advice Date"; Rec."Advice Date")
                {
                    ApplicationArea = Basic;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field("DOD Options"; Rec."DOD Options")
                {
                    ApplicationArea = Basic;
                }
                field("Advice Type"; Rec."Advice Type")
                {
                    ApplicationArea = Basic;
                }
                field(Manual; Rec.Manual)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Account No."; Rec."Employer Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured  By"; Rec."Captured  By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Export New Loans")
            {
                ApplicationArea = Basic;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = XMLport "Monthly Advice New Loans";
                Visible = false;
            }
            action("Export Stoppages")
            {
                ApplicationArea = Basic;
                //Image = stop;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = XMLport "Monthly Advice New Loans";
                Visible = false;
            }
            action("Export Adjustments")
            {
                ApplicationArea = Basic;
                Image = AlternativeAddress;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = XMLport "Monthly Advice New Loans";
                Visible = false;
            }
            action("Generate Advice")
            {
                ApplicationArea = Basic;
                Image = CreateLinesFromJob;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    //    PeriodicActivities.MonthlyCheckoffAdvice();
                end;
            }
        }
    }

    var
        PeriodicActivities: Codeunit "Periodic Activities";
}

