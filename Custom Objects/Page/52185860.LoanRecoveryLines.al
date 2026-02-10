page 52185860 "Loan Recovery Lines"
{
    ApplicationArea = All;
    Caption = 'Loan Recovery Lines';
    PageType = ListPart;
    SourceTable = "Loan Recovery Lines";
    SourceTableView = sorting ("Recovery Type") order(descending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Member No."; Rec."Member No.")
                {

                }
                field("Member Name"; Rec."Member Name")
                {

                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("Recovery Type"; Rec."Recovery Type")
                {
                    ToolTip = 'Specifies the value of the Recovery Type field.';
                }
                field("Recovery Amount"; Rec."Recovery Amount")
                {
                    ToolTip = 'Specifies the value of the Recovery Amount field.';
                }
                field("Interest Amount";Rec."Interest Amount")
                {
                    Editable = false;
                }
                field("Principle Amount";Rec."Principle Amount")
                {
                    Editable = false;
                }
                field("Loan No."; Rec."Loan No.")
                {

                }
                field("Attached Loan Number"; Rec."Attached Loan Number")
                {
                    Editable = false;
                    Description = 'This is the loan that the guarantor was attached but they are not paying well';
                }
                field("Attached Loan Balance"; Rec."Attached Loan Balance")
                {
                    Editable = false;
                    Description = 'This is balance of the loan that the guarantor was attached but they are not paying well';

                }
                field("Attached Loan Category"; Rec."Attached Loan Category")
                {
                    Editable = false;
                }


            }
        }
    }
}
