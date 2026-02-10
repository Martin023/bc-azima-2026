page 52185429 "Loan Fall Off List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Loan FallOff";
    Caption = 'Loan Fall Off';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Batch No"; Rec."Batch No")
                {
                    ApplicationArea = All;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                }
                field("Payroll Number"; Rec."Payroll Number")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = All;
                }

                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = All;
                }
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = All;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = All;
                }
                field("Product ID"; Rec."Product ID")
                {
                    ApplicationArea = All;
                }
                field("Product Description"; Rec."Product Description")
                {

                }
                field("Disbursed Amount"; Rec."Disbursed Amount")
                {
                    ApplicationArea = All;
                }
                field("Disbursement Date"; Rec."Disbursement Date")
                {

                }
                field("Monthly Expected Principle"; Rec."Monthly Expected Principle")
                {

                }
                field("Monthly Expected Interest"; Rec."Monthly Expected Interest")
                {

                }
                field("Total Monthly Expected"; Rec."Total Monthly Expected")
                {

                }
                field("Last Paid Date"; Rec."Last Paid Date")
                {
                    ApplicationArea = All;
                }
                field("Last Paid Amount"; Rec."Last Paid Amount")
                {
                    ApplicationArea = All;
                }
                field("Principle Balance"; Rec."Principle Balance")
                {
                    ApplicationArea = All;
                }
                field("Total Outstanding Interest"; Rec."Total Outstanding Interest")
                {
                    ApplicationArea = All;
                }
                field("Total Outstanding Loan Balance"; Rec."Total Outstanding Loan Balance")
                {
                    ApplicationArea = All;
                }
                field("Loan Department"; Rec."Loan Department")
                {
                    ApplicationArea = All;
                }
                field("Member Status"; Rec."Member Status")
                {
                    ApplicationArea = All;
                }
                field("Member Sub Status"; Rec."Member Sub Status")
                {
                    ApplicationArea = All;
                }
                field("Total Capital AmountPaid"; Rec."Total Capital AmountPaid")
                {
                    ApplicationArea = All;
                }
                field("Total Interest Amount Paid"; Rec."Total Interest Amount Paid")
                {
                    ApplicationArea = All;
                }

                field("Remaining Installments"; Rec."Remaining Installments")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {

                }
                field("Day Last Paid"; Rec."Day Last Paid")
                {

                }
                field("Branch Code";Rec."Branch Code")
                {
                    
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Queue Loan Fall Off Process")
            {
                ApplicationArea = All, Basic, Suite;
                Caption = 'Start Loan Fall Off Process';
                Image = Action;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    theLoans: Record Loans;
                begin
                    theLoans.Reset();

                    Codeunit.Run(Codeunit::"Loan FallOff Job Queue Manager", theLoans);

                    // if Codeunit.Run(Codeunit::"Loan FallOff Job Queue Manager", theLoans) then begin
                    //     Message('Loan Fall Off Process initiated successfully. It will run in the background');
                    // end else begin
                    //     Error('Unable to initiate Loan Fall Off Process at the moment!');
                    // end;
                end;
            }

            action("Process Fall Off")
            {
                ApplicationArea = All, Basic, Suite;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = report "Process FallOff";
            }
        }
    }
}
