namespace AzimaCBS.AzimaCBS;

page 52185455 "Loan Guarantors ListPart"
{
    ApplicationArea = All;
    Caption = 'Loan Guarantors ListPart"';
    PageType = ListPart;
    SourceTable = "Loan Guarantors and Security";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = all;
                    Editable = false;
                    //Visible = false;
                }
                field("Guarantor Type"; Rec."Guarantor Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Savings Account No./Member No."; Rec."Savings Account No./Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Collateral Reg. No."; Rec."Collateral Reg. No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Guarantor Status"; Rec."Guarantor Status")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Self Guarantee"; Rec."Self Guarantee")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staff/Payroll No."; Rec."Staff/Payroll No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("Guarantor ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Amount Guaranteed"; Rec."Amount Guaranteed")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("User Specified"; Rec."User Specified")
                {
                    ApplicationArea = Basic, Suite;
                }

                // field("Proportion Guaranteed"; Rec."Proportion Guaranteed")
                // {
                //     ApplicationArea = all;
                // }
                field("Deposits/Shares"; Rec."Deposits/Shares")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No Of Loans Guaranteed"; Rec."No Of Loans Guaranteed")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Guaranteed"; Rec."Total Guaranteed")
                {
                    ApplicationArea = Basic, Suite;
                }

                field(Substituted; Rec.Substituted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Substituted"; Rec."Member Substituted")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(PercentageGur; Rec.PercentageGur)
                {
                    ApplicationArea = all;
                    Caption = '% Guaranteed';
                    Editable = false;
                }
                
                field("Loan Group"; Rec."Loan Groups")
                {
                    Editable = false;
                }
                field("Group Account No"; Rec."Group Account Nos")
                {
                    Editable = false;
                }
                field(Verified; Rec.Verified)
                {
                    ApplicationArea = Basic, Suite;
                }

            }
        }
    }
}
