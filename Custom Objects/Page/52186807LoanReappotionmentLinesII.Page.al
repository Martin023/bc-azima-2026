page 52186807 "Loan Reappotionment Lines II"
{
    ApplicationArea = All;
    Caption = 'Loan Reappotionment Lines II';
    PageType = ListPart;
    SourceTable = "Loan Reapotionment Lines II";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Defaulter Loan No."; Rec."Defaulter Loan No.")
                {
                    ToolTip = 'Specifies the value of the Defaulter Loan No. field.';
                }
                field("Guarantor Loan No."; Rec."Guarantor Loan No.")
                {
                    ToolTip = 'Specifies the value of the Guarantor Loan No. field.';
                }
                field("Guarantor Member No."; Rec."Guarantor Member No.")
                {
                    ToolTip = 'Specifies the value of the Guarantor Member No. field.';
                }
                field("Guarantor Name"; Rec."Guarantor Name")
                {
                    ToolTip = 'Specifies the value of the Guarantor Name field.';
                }
                 field("Innitial Attachment Amount"; Rec."Innitial Attachment Amount")
                {
                    Editable = false;
                }
                field("Loan Balance"; Rec."Loan Balance")
                {
                    Editable = false;
                }
                
                field("Interest Portion"; Rec."Interest Portion")
                {
                    Editable = false;
                }
                field("Principle Portion"; Rec."Principle Portion")
                {
                    Editable = false;
                }
                field("Appotionment Amount"; Rec."Appotionment Amount")
                {
                    ToolTip = 'Specifies the value of the Appotionment Amount field.';
                }
               
                field("Money To FOSA"; Rec."Money To FOSA")
                {
                    Editable = false;
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
            }
        }
    }
}
