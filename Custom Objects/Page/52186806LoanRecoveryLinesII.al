page 52186806 "Loan Recovery Lines II"
{
    ApplicationArea = All;
    Caption = 'Loan Recovery Lines II';
    PageType = ListPart;
    SourceTable = "Loan Recovery Lines II";

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
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                    Editable = false;
                }
                field("Recovery Type"; Rec."Recovery Type")
                {
                    ToolTip = 'Specifies the value of the Recovery Type field.';
                }
                field("Original Attached Amount"; Rec."Original Attached Amount")
                {

                }
                field("Recovery Amount"; Rec."Recovery Amount")
                {
                    ToolTip = 'Specifies the value of the Recovery Amount field.';
                    Visible = false;
                }
                field("Interest Amount";Rec."Interest Amount")
                {

                }
                field("Principle Amount";Rec."Principle Amount")
                {
                    
                }
                field("Opening Interest Balance";Rec."Opening Interest Balance")
                {
                }
                field("Opening Principle Balance";Rec."Opening Principle Balance")
                {
                }
                field("Opening Loan Balance";Rec."Opening Loan Balance")
                {
                    Editable = false;
                }
                field("Loan No."; Rec."Loan No.")
                {

                }
                field("Attached Loan Number"; Rec."Attached Loan Number")
                {
                    Description = 'This is the loan that the guarantor was attached but they are not paying well';
                }
                field("Attached Loan Balance"; Rec."Attached Loan Balance")
                {
                    Description = 'This is balance of the loan that the guarantor was attached but they are not paying well';
                    Visible = false;

                }
                field("Attached Loan Category"; Rec."Attached Loan Category")
                {
                    Editable = false;
                    Visible = false;
                }

            }
        }
    }
}
