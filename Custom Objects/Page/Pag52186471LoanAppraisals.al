page 52186471 "Loan Appraisals"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loan Appraisal";

    layout
    {
        area(Content)
        {
            group("General Information")
            {
                Editable = false;
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;

                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = all;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = all;
                }
                field("No. of Gurantors"; Rec."No. of Gurantors")
                {
                    ApplicationArea = all;
                }


            }
            group("Deposits and Loan Analysis")
            {
                Editable = false;
                field("Current Contribution"; Rec."Current Contribution")
                {

                }
                field("Possible Deposit Boost"; Rec."Possible Deposit Boost")
                {
                    ApplicationArea = all;
                }
                field("Deposit *5"; Rec."Deposit *5")
                {

                }

            }
            group("Total Deductions")
            {
                Editable = false;
                field("Deposit Boosting"; Rec."Deposit Boosting")
                {
                    ApplicationArea = all;
                }
                field("Loan Outstanding"; Rec."Loan Outstanding")
                {
                    ApplicationArea = all;
                }
                field("Top Up Loan Amount"; Rec."Top Up Loan Amount")
                {
                    ApplicationArea = all;

                }
                field("Maximum Credit"; Rec."Maximum Credit")
                {
                    ApplicationArea = all;
                }
                field("TopUp Commission"; Rec."TopUp Commission")
                {
                    ApplicationArea = all;
                }
                field("Other Clearence"; Rec."Other Clearence")
                {
                    ApplicationArea = all;
                }
                field("Other Clearence Duty"; Rec."Other Clearence Duty")
                {
                    ApplicationArea = all;
                }
                field("Total excise Duty"; Rec."Total excise Duty")
                {
                    ApplicationArea = all;
                }

            }
            group("Salary Details")
            {
                Editable = false;
                field("Basic Income"; Rec."Basic Income")
                {
                    ApplicationArea = all;
                }
                field(Earnings; Rec.Earnings)
                {
                    ApplicationArea = all;
                }
                field(Allowances; Rec.Allowances)
                {
                    ApplicationArea = all;

                }
                field("Gross Pay"; Rec."Gross Pay")
                {
                    ApplicationArea = all;
                }
                field(Deductions; Rec.Deductions)
                {
                    ApplicationArea = all;
                }
                field("1/3 of Basic"; rec."1/3 of Basic")
                {
                    ApplicationArea = all;
                }
                field("Net Salary"; Rec."Net Salary")
                {
                    ApplicationArea = all;
                }
                field("Amt to Loan"; Rec."Amt to Loan")
                {
                    ApplicationArea = all;

                }
                field("External Effects"; Rec."External Effects")
                {
                    ApplicationArea = all;
                }
                field("New Net Salary"; Rec."New Net Salary")
                {
                    ApplicationArea = all;
                }
            }
            group("Other Details")
            {
                Editable = false;
                field("Cleared Loans Installment"; Rec."Cleared Loans Installment")
                {
                    ApplicationArea = all;
                }
                field("Adjusted Net"; Rec."Adjusted Net")
                {
                    ApplicationArea = all;
                }
                field("New Repayment"; Rec."New Repayment")
                {
                    ApplicationArea = all;

                }
                field("Average Interest"; Rec."Average Interest")
                {
                    ApplicationArea = all;
                }
                field("Qualification on Salary"; Rec."Qualification on Salary")
                {
                    ApplicationArea = all;
                }
                field("Qualification on Guarantors"; Rec."Qualification on Guarantors")
                {
                    ApplicationArea = all;
                }
                field("Qualification on Deposits"; Rec."Qualification on Deposits")
                {
                    ApplicationArea = all;
                }
                field("Recommended Amount"; Rec."Recommended Amount")
                {
                    ApplicationArea = all;
                }
                field("Take Home Amount"; Rec."Take Home Amount")
                {
                    ApplicationArea = all;
                }
            }
            group("Guarantors List")
            {
                part("Loan Guarantors"; "Loan Guarantors and Security")
                {
                    SubPageLink = "Loan No" = field("Loan No.");
                    ApplicationArea = all;
                    Caption = 'Guarantors List';
                    Editable = false;
                }
            }
            group("loans Topped up")
            {


                part("loans Topped"; "Loan Top Up")
                {
                    Caption = 'loans Topped';
                    SubPageLink = "Loan No." = field("Loan No.");
                    ApplicationArea = all;
                    Editable = false;
                }
            }


        }
    }


    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}