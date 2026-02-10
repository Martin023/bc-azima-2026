namespace Mwanga.Mwanga;

page 52185437 "Loan Listing Report List"
{
    ApplicationArea = All;
    Caption = 'Loan Listing Report List';
    PageType = List;
    SourceTable = "Loan Listing Report List";

    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = All;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    ApplicationArea = All;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = All;
                }
                field("Loan Interest Rate"; Rec."Loan Interest Rate")
                {
                    ApplicationArea = All;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Paid Prorata"; Rec."Paid Prorata")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Disbursement Date"; Rec."Disbursement Date")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = All;
                }
                field("Total Loan Balance"; Rec."Total Loan Balance")
                {
                    ApplicationArea = All;
                }
                field("Principle Plus Future Interest"; Rec."Principle Plus Future Interest")
                {
                    ApplicationArea = All;
                }
                field("Loan Amortization Type"; Rec."Loan Amortization Type")
                {
                    ApplicationArea = All;
                }
                field("Loan Frequency"; Rec."Loan Frequency")
                {
                    ApplicationArea = All;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = All;
                }
                field("Principle Arrears"; Rec."Principle Arrears")
                {
                    ApplicationArea = All;
                }
                field("Interest Arrears"; Rec."Interest Arrears")
                {
                    ApplicationArea = All;
                }
                field("Amount In Arrears"; Rec."Amount In Arrears")
                {
                    ApplicationArea = All;
                }
                field("Months In Arrears"; Rec."Months In Arrears")
                {
                    ApplicationArea = All;
                }
                field("Days In Arrears"; Rec."Days In Arrears")
                {
                    ApplicationArea = All;
                }
                field("SASRA Caategorization"; Rec."SASRA Caategorization")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Installments"; Rec."Outstanding Installments")
                {
                    ApplicationArea = All;
                }
                field("Total Expected Interest"; Rec."Total Expected Interest")
                {
                    ApplicationArea = All;
                }
                field("Total Expected Principle"; Rec."Total Expected Principle")
                {
                    ApplicationArea = All;
                }
                field("Interest Topped"; Rec."Interest Topped")
                {
                    ApplicationArea = All;
                }
                field("Principle Toppped"; Rec."Principle Toppped")
                {
                    ApplicationArea = All;
                }
                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                    ApplicationArea = All;
                }
                field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
                {
                    ApplicationArea = All;
                }
                field("Repayment"; Rec.Repayment)
                {
                    ApplicationArea = All;
                }
                field("Relation Officer"; Rec."Relation Officer")
                {
                    ApplicationArea = All;
                }
                field("CRM Application No"; Rec."CRM Application No")
                {
                    ApplicationArea = All;
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Date Of Completion"; Rec."Expected Date Of Completion")
                {
                    ApplicationArea = All;
                }
                field("FOSA Balance"; Rec."FOSA Balance")
                {
                    ApplicationArea = All;
                }
                field("Last Interest Repayment"; Rec."Last Interest Repayment")
                {
                    ApplicationArea = All;
                }
                field("Last Principle Repayment"; Rec."Last Principle Repayment")
                {
                    ApplicationArea = All;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = All;
                }
                field("Last Payment Date"; Rec."Last Payment Date")
                {
                    ApplicationArea = All;
                }
                field("Intallments"; Rec.Intallments)
                {
                    ApplicationArea = All;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = All;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                }
                field("Share Boosted Amount"; Rec."Share Boosted Amount")
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
                field("Loan Appraised By"; Rec."Loan Appraised By")
                {
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                }
                field("Member Age"; Rec."Member Age")
                {
                    ApplicationArea = All;
                }
                field("Prorata Amount"; Rec."Prorata Amount")
                {
                    ApplicationArea = All;
                }
                field("Main Sector Code"; Rec."Main Sector Code")
                {
                    ApplicationArea = All;
                }
                field("Main Sector Name"; Rec."Main Sector Name")
                {
                    ApplicationArea = All;
                }
                field("Sub Sector1 Code"; Rec."Sub Sector1 Code")
                {
                    ApplicationArea = All;
                }
                field("Sub Sector1 Name"; Rec."Sub Sector1 Name")
                {
                    ApplicationArea = All;
                }
                field("Sub Sector2 Code"; Rec."Sub Sector2 Code")
                {
                    ApplicationArea = All;
                }
                field("Sub Sector2 Name"; Rec."Sub Sector2 Name")
                {
                    ApplicationArea = All;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    ApplicationArea = All;
                }
                field("Business Loan Deposits"; Rec."Business Loan Deposits")
                {
                    ApplicationArea = All;
                }
                field("Source Unit"; Rec."Source Unit")
                {
                    ApplicationArea = All;
                }
                field("Amount On"; Rec."Amount On")
                {
                    ApplicationArea = All;
                }
                field("Amount Off"; Rec."Amount Off")
                {
                    ApplicationArea = All;
                }
                field("Member Status"; Rec."Member Status")
                {
                    ApplicationArea = All;
                }
                field("Member Sub-Status"; Rec."Member Sub-Status")
                {
                    ApplicationArea = All;
                }
                field("Activity Code"; Rec."Activity Code")
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Type Of Security"; Rec."Type Of Security")
                {
                    ApplicationArea = All;
                }
                field("Future Interest"; Rec."Future Interest")
                {
                    ApplicationArea = All;
                }
                field("Position Of Lonee"; Rec."Position Of Lonee")
                {
                    ApplicationArea = All;
                }



            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Queue Loan Listing Process")
            {
                ApplicationArea = All, Basic, Suite;
                Caption = 'Start Loan Listing Process';
                Image = Action;
                Promoted = true;
                Enabled=false;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    theLoans: Record Loans;
                begin
                    theLoans.Reset();

                    Codeunit.Run(Codeunit::"Loan Listing Job Queue Manager", theLoans);

                    // if Codeunit.Run(Codeunit::"Loan Listing Job Queue Manager", theLoans) then begin
                    //     Message('Loan Listing Process initiated successfully. It will run in the background');
                    // end else begin
                    //     Error('Unable to initiate Loan Listing Process at the moment!');
                    // end;
                end;
            }
        }
    }
}
