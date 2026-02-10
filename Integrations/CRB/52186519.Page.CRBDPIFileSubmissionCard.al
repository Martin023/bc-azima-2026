page 52186519 "CRB DPI File Submission"
{
    ApplicationArea = All;
    Caption = 'CRB Daily Payment Information File Submission';
    PageType = Card;
    SourceTable = "CRB DPI File Submissions";

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
                field("Is Sent"; Rec."Is Sent")
                {
                    ToolTip = 'Specifies the value of the Is Sent field.', Comment = '%';
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ToolTip = 'Specifies the value of the Is Sent field.', Comment = '%';
                }
                field("Snapshot Date"; Rec."Snapshot Date")
                {
                    ToolTip = 'Specifies the value of the Snapshot Date field.', Comment = '%';
                }
                field("Client Type"; Rec."Client Type")
                {
                    ToolTip = 'Specifies the value of the Client Type field.', Comment = '%';
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
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Specifies the value of the Other Names field.', Comment = '%';
                }
                field("Primary Id Doc Type"; Rec."Primary Id Doc Type")
                {
                    ToolTip = 'Specifies the value of the Primary Identification Document Type field.', Comment = '%';
                }
                field("Primary Id Doc No."; Rec."Primary Id Doc No.")
                {
                    ToolTip = 'Specifies the value of the Primary Identification Document Number field.', Comment = '%';
                }
                field("Account Number"; Rec."Account Number")
                {
                    ToolTip = 'Specifies the value of the Loan Number field.', Comment = '%';
                }
                field("Currency of Facility"; Rec."Currency of Facility")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.', Comment = '%';
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ToolTip = 'Specifies the value of the Approved Loan Amount field.', Comment = '%';
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                    ToolTip = 'Specifies the value of the Paid Loan Amount field.', Comment = '%';
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ToolTip = 'Specifies the value of the Loan Payment Date field.', Comment = '%';
                }
                field("Current Balance"; Rec."Current Balance")
                {
                    ToolTip = 'Specifies the value of the Current Loan Balance field.', Comment = '%';
                }
                field("Installments in Arrears"; Rec."Installments in Arrears")
                {
                    ToolTip = 'Specifies the value of the Installments in Arrears field.', Comment = '%';
                }
                field("Days in Arrears"; Rec."Days in Arrears")
                {
                    ToolTip = 'Specifies the value of the Days in Arrears field.', Comment = '%';
                }
                field("Account Status"; Rec."Account Status")
                {
                    ToolTip = 'Specifies the value of the Account Status field.', Comment = '%';
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
