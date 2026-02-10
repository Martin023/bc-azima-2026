page 52186440 "CRB Data"
{
    Editable = false;
    PageType = List;
    SourceTable = "CRB Data";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Forename 1"; Rec."Forename 1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Surname';
                }
                field("Forename 2"; Rec."Forename 2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Forename 1';
                }
                field("Forename 3"; Rec."Forename 3")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Forename 2';
                }
                field("Name 3"; Rec."Name 3")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Forename 3';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Client Number';
                }
                field("Account Number"; Rec."Account Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Primary Identification code"; Rec."Primary Identification code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Primary Identification Document Type';
                }
                field("Primary Identification Number"; Rec."Primary Identification Number")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Primary Identification Doc Number';
                }
                field("Other Identification Type"; Rec."Other Identification Type")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Secondary Identification Document Type';
                }
                field("Secondary Identification"; Rec."Secondary Identification")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Secondary Identification Document Number';
                }
                field("Secondary Identification code"; Rec."Secondary Identification code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Other Identification Document Type';
                }
                field("Other Identification Number"; Rec."Other Identification Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mobile Telephone Number';
                }
                field("Home Telephone"; Rec."Home Telephone")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Work Telephone"; Rec."Work Telephone")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Postal Address 1"; Rec."Postal Address 1")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Postal Address 2"; Rec."Postal Address 2")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Postal Location Town"; Rec."Postal Location Town")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Postal Location Country"; Rec."Postal Location Country")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Physical Address 1"; Rec."Physical Address 1")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Physical Address 2"; Rec."Physical Address 2")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Plot Number"; Rec."Plot Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Location Town"; Rec."Location Town")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Location Country"; Rec."Location Country")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date of Physical Address"; Rec."Date of Physical Address")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Type of Residency';
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Customer Work Email"; Rec."Customer Work Email")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Consumer E-Mail';
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Industry Type"; Rec."Employer Industry Type")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Occupational Industry Type';
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Income Amount"; Rec."Income Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Lenders Registered Name"; Rec."Lenders Registered Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Lenders Trading Name"; Rec."Lenders Trading Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Lenders Branch Name"; Rec."Lenders Branch Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Lenders Branch Code"; Rec."Lenders Branch Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Joint/Single Indicator';
                }
                field("Account Product Type"; Rec."Account Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Account Opened"; Rec."Date Account Opened")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Installment Due Date"; Rec."Installment Due Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Currency of Facility"; Rec."Currency of Facility")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount in Kenya shillings"; Rec."Amount in Kenya shillings")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Current Balance in Kenya Shillings';
                }
                field("Current Balance"; Rec."Current Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Overdue Balance"; Rec."Overdue Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Overdue Date"; Rec."Overdue Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No of Days in Arreas"; Rec."No of Days in Arreas")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No of Installment In"; Rec."No of Installment In")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Performing / NPL Indicator"; Rec."Performing / NPL Indicator")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Prudential Risk Classification';
                }
                field("Account Status"; Rec."Account Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Status Date"; Rec."Account Status Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Closure Reason"; Rec."Account Closure Reason")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Repayment Period"; Rec."Repayment Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Deferred Payment Date"; Rec."Deferred Payment Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Deferred Payment"; Rec."Deferred Payment")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deferred Payment Amount';
                }
                field("Payment Frequency"; Rec."Payment Frequency")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Disbursement Date"; Rec."Disbursement Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Insallment Amount"; Rec."Insallment Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Next Installment Amount';
                }
                field("Date of Latest Payment"; Rec."Date of Latest Payment")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Payment Amount"; Rec."Last Payment Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Type of Security"; Rec."Type of Security")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Group ID';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Outbal; Rec.Outbal)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate Data")
            {
                ApplicationArea = Basic, Suite;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                RunObject = Report "Generate CRB Data";

            }
            action("Export CRB")
            {
                ApplicationArea = Basic, Suite;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = XMLport "Loans CRB";
            }
        }
    }
}

