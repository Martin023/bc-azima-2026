page 52186522 "CRB Monthly ICE File Subm Card"
{
    ApplicationArea = All;
    Caption = 'CRB Monthly Individual Consumer, Employer and Account File Submission Card';
    PageType = Card;
    SourceTable = "CRB Monthly ICE File Subm.";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of the Loan No. field.', Comment = '%';
                }
                field("Log Date Time"; Rec."Log Date Time")
                {
                    ToolTip = 'Specifies the value of the Log Date Time field.', Comment = '%';
                }
                field("CRB Institution"; Rec."CRB Institution")
                {
                    ToolTip = 'Specifies the value of the CRB Institution field.', Comment = '%';
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ToolTip = 'Specifies the value of the Batch No. field.', Comment = '%';
                }
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the value of the Surname field.', Comment = '%';
                }
                field("Forename 1"; Rec."Forename 1")
                {
                    ToolTip = 'Specifies the value of the First Name field.', Comment = '%';
                }
                field("Forename 2"; Rec."Forename 2")
                {
                    ToolTip = 'Specifies the value of the Given Name field.', Comment = '%';
                }
                field("Forename 3"; Rec."Forename 3")
                {
                    ToolTip = 'Specifies the value of the Other Names field.', Comment = '%';
                }
                field("Trading As"; Rec."Trading As")
                {
                    ToolTip = 'Specifies the value of the Trading As field.', Comment = '%';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ToolTip = 'Specifies the value of the Snapshot Date field.', Comment = '%';
                }
                field("Client Number"; Rec."Client Number")
                {
                    ToolTip = 'Specifies the value of the Snapshot Date field.', Comment = '%';
                }
                field("Account Number"; Rec."Account Number")
                {
                    ToolTip = 'Specifies the value of the Loan Number field.', Comment = '%';
                }
                field("Old Account Number"; Rec."Old Account Number")
                {
                    ToolTip = 'Specifies the value of the Old Loan Number field.', Comment = '%';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.', Comment = '%';
                }
                field(Nationality; Rec.Nationality)
                {
                    ToolTip = 'Specifies the value of the Nationality field.', Comment = '%';
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ToolTip = 'Specifies the value of the Marital Status field.', Comment = '%';
                }
                field("Primary Id Doc Type"; Rec."Primary Id Doc Type")
                {
                    ToolTip = 'Specifies the value of the Primary Identification Document Type field.', Comment = '%';
                }
                field("Primary Id Doc No."; Rec."Primary Id Doc No.")
                {
                    ToolTip = 'Specifies the value of the Primary Identification Document Number field.', Comment = '%';
                }
                field("Secondary Id Doc Type"; Rec."Secondary Id Doc Type")
                {
                    ToolTip = 'Specifies the value of the Secondary Identification Document Type field.', Comment = '%';
                }
                field("Secondary Id Doc No."; Rec."Secondary Id Doc No.")
                {
                    ToolTip = 'Specifies the value of the Secondary Identification Document Number field.', Comment = '%';
                }
                field("Other Id Doc Type"; Rec."Other Id Doc Type")
                {
                    ToolTip = 'Specifies the value of the Other Identification Document Type field.', Comment = '%';
                }
                field("Other Id Doc No."; Rec."Other Id Doc No.")
                {
                    ToolTip = 'Specifies the value of the Other Identification Document Number field.', Comment = '%';
                }
                field("Passport Country Code"; Rec."Passport Country Code")
                {
                    ToolTip = 'Specifies the value of the Passport Country Code field.', Comment = '%';
                }
                field("Mobile Telephone No."; Rec."Mobile Telephone No.")
                {
                    ToolTip = 'Specifies the value of the Mobile Telephone Number field.', Comment = '%';
                }
                field("Home Telephone No."; Rec."Home Telephone No.")
                {
                    ToolTip = 'Specifies the value of the Home Telephone Number field.', Comment = '%';
                }
                field("Work Telephone No."; Rec."Work Telephone No.")
                {
                    ToolTip = 'Specifies the value of the Work Telephone Number field.', Comment = '%';
                }
                field("Postal Address 1"; Rec."Postal Address 1")
                {
                    ToolTip = 'Specifies the value of the Postal Address 1 field.', Comment = '%';
                }
                field("Postal Address 2"; Rec."Postal Address 2")
                {
                    ToolTip = 'Specifies the value of the Postal Address 2 field.', Comment = '%';
                }
                field("Postal Location Town"; Rec."Postal Location Town")
                {
                    ToolTip = 'Specifies the value of the Postal Location Town field.', Comment = '%';
                }
                field("Postal Location Country"; Rec."Postal Location Country")
                {
                    ToolTip = 'Specifies the value of the Postal Location Country field.', Comment = '%';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field.', Comment = '%';
                }
                field("Physical Address 1"; Rec."Physical Address 1")
                {
                    ToolTip = 'Specifies the value of the Physical Address 1 field.', Comment = '%';
                }
                field("Physical Address 2"; Rec."Physical Address 2")
                {
                    ToolTip = 'Specifies the value of the Physical Address 2 field.', Comment = '%';
                }
                field("Plot Number"; Rec."Plot Number")
                {
                    ToolTip = 'Specifies the value of the Plot Number field.', Comment = '%';
                }
                field("Location Town"; Rec."Location Town")
                {
                    ToolTip = 'Specifies the value of the Location Town field.', Comment = '%';
                }
                field("Location Country"; Rec."Location Country")
                {
                    ToolTip = 'Specifies the value of the Location Country field.', Comment = '%';
                }
                field("Type of Residency"; Rec."Type of Residency")
                {
                    ToolTip = 'Specifies the value of the Type of Residency field.', Comment = '%';
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    ToolTip = 'Specifies the value of the PIN Number field.', Comment = '%';
                }
                field("Consumer E-Mail"; Rec."Consumer E-Mail")
                {
                    ToolTip = 'Specifies the value of the Consumer E-Mail field.', Comment = '%';
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ToolTip = 'Specifies the value of the Employer Name field.', Comment = '%';
                }
                field("Occupational Industry Type"; Rec."Occupational Industry Type")
                {
                    ToolTip = 'Specifies the value of the Occupational Industry Type field.', Comment = '%';
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ToolTip = 'Specifies the value of the Employment Date field.', Comment = '%';
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    ToolTip = 'Specifies the value of the Employment Type field.', Comment = '%';
                }
                field("Income Amount"; Rec."Income Amount")
                {
                    ToolTip = 'Specifies the value of the Income Amount field.', Comment = '%';
                }
                field("Lenders Registered Name"; Rec."Lenders Registered Name")
                {
                    ToolTip = 'Specifies the value of the Lenders Registered Name field.', Comment = '%';
                }
                field("Lenders Trading Name"; Rec."Lenders Trading Name")
                {
                    ToolTip = 'Specifies the value of the Lenders Trading Name field.', Comment = '%';
                }
                field("Lenders Branch Name"; Rec."Lenders Branch Name")
                {
                    ToolTip = 'Specifies the value of the Lenders Branch Name field.', Comment = '%';
                }
                field("Lenders Branch Code"; Rec."Lenders Branch Code")
                {
                    ToolTip = 'Specifies the value of the Lenders Branch Code field.', Comment = '%';
                }
                field("Account Joint/Single Indicator"; Rec."Account Joint/Single Indicator")
                {
                    ToolTip = 'Specifies the value of the Account Joint/Single Indicator field.', Comment = '%';
                }
                field("Account Product Type"; Rec."Account Product Type")
                {
                    ToolTip = 'Specifies the value of the Account Product Type field.', Comment = '%';
                }
                field("Date Account Opened"; Rec."Date Account Opened")
                {
                    ToolTip = 'Specifies the value of the Date Account Opened field.', Comment = '%';
                }
                field("Instalment Due Date"; Rec."Instalment Due Date")
                {
                    ToolTip = 'Specifies the value of the Instalment Due Date field.', Comment = '%';
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ToolTip = 'Specifies the value of the Original Amount field.', Comment = '%';
                }
                field("Currency of Facility"; Rec."Currency of Facility")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.', Comment = '%';
                }
                field("Current Balance in KES"; Rec."Current Balance in KES")
                {
                    ToolTip = 'Specifies the value of the Current Balance in Kenya shillings field.', Comment = '%';
                }
                field("Current Balance"; Rec."Current Balance")
                {
                    ToolTip = 'Specifies the value of the Current Balance field.', Comment = '%';
                }
                field("Overdue Balance"; Rec."Overdue Balance")
                {
                    ToolTip = 'Specifies the value of the Overdue Balance field.', Comment = '%';
                }
                field("Overdue Date"; Rec."Overdue Date")
                {
                    ToolTip = 'Specifies the value of the Overdue Date field.', Comment = '%';
                }
                field("Number of Days in Arrears"; Rec."Number of Days in Arrears")
                {
                    ToolTip = 'Specifies the value of the Number of Days in Arrears field.', Comment = '%';
                }
                field("No. of Installments in Arrears"; Rec."No. of Installments in Arrears")
                {
                    ToolTip = 'Specifies the value of the Number of Instalments in Arrears field.', Comment = '%';
                }
                field("Prudential Risk Classification"; Rec."Prudential Risk Classification")
                {
                    ToolTip = 'Specifies the value of the Prudential Risk Classification field.', Comment = '%';
                }
                field("Account Status"; Rec."Account Status")
                {
                    ToolTip = 'Specifies the value of the Account Status field.', Comment = '%';
                }
                field("Account Status Date"; Rec."Account Status Date")
                {
                    ToolTip = 'Specifies the value of the Account Status Date field.', Comment = '%';
                }
                field("Account Closure Reason"; Rec."Account Closure Reason")
                {
                    ToolTip = 'Specifies the value of the Account Closure Reason field.', Comment = '%';
                }
                field("Repayment Period"; Rec."Repayment Period")
                {
                    ToolTip = 'Specifies the value of the Repayment Period field.', Comment = '%';
                }
                field("Deferred Payment Date"; Rec."Deferred Payment Date")
                {
                    ToolTip = 'Specifies the value of the Deferred Payment Date field.', Comment = '%';
                }
                field("Deferred Payment Amount"; Rec."Deferred Payment Amount")
                {
                    ToolTip = 'Specifies the value of the Deferred Payment Amount field.', Comment = '%';
                }
                field("Payment Frequency"; Rec."Payment Frequency")
                {
                    ToolTip = 'Specifies the value of the Payment Frequency field.', Comment = '%';
                }
                field("Disbursement Date"; Rec."Disbursement Date")
                {
                    ToolTip = 'Specifies the value of the Disbursement Date field.', Comment = '%';
                }
                field("Next Instalment Amount"; Rec."Next Instalment Amount")
                {
                    ToolTip = 'Specifies the value of the Next Instalment Amount field.', Comment = '%';
                }
                field("Date of Latest Payment"; Rec."Date of Latest Payment")
                {
                    ToolTip = 'Specifies the value of the Date of Latest Payment field.', Comment = '%';
                }
                field("Last Payment Amount"; Rec."Last Payment Amount")
                {
                    ToolTip = 'Specifies the value of the Last Payment Amount field.', Comment = '%';
                }
                field("Type of Security"; Rec."Type of Security")
                {
                    ToolTip = 'Specifies the value of the Type of Security field.', Comment = '%';
                }
                field("Group ID"; Rec."Group ID")
                {
                    ToolTip = 'Specifies the value of the Group ID field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
            }

            group(API)
            {
                Caption = 'API Information';

                field("API Status"; Rec."API Status")
                {
                    ToolTip = 'Specifies the value of the API Status field.', Comment = '%';
                }
                field("API Description"; Rec."API Response")
                {
                    ToolTip = 'Specifies the value of the API Response field.', Comment = '%';
                    MultiLine = True;
                }
            }
        }
    }
}
