page 52187099 "DMU Case Forwarding Lines"
{
    ApplicationArea = All;
    Caption = 'DMU Case Forwarding Lines';
    PageType = ListPart;
    SourceTable = "DMU Case Forwarding Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Loan Number"; Rec."Loan Number")
                {
                    ToolTip = 'Specifies the value of the Loan Number field.';
                }
                field("Member Number"; Rec."Member Number")
                {
                    ToolTip = 'Specifies the value of the Member Number field.';
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                }
                field("Principle Balance"; Rec."Principle Balance")
                {
                    ToolTip = 'Specifies the value of the Activity Code field.';
                    Editable = false;
                }
                field("Interest Balance"; Rec."Interest Balance")
                {
                    ToolTip = 'Specifies the value of the Branch Code field.';
                    Editable = false;
                }
                field("Total Balance"; Rec."Total Balance")
                {
                    Editable = false;
                }
                field("Installments FallOff"; Rec."Installments FallOff")
                {
                    Editable = false;
                }
                field("Days In Arrears"; Rec."Days In Arrears")
                {
                    Editable = false;
                }
                field("Loans Category-SASRA"; Rec."Loans Category-SASRA")
                {
                    Editable = false;
                }
                field("System Generated";Rec."System Generated")
                {

                }
                field(Period;Rec.Period)
                {
                    Editable = false;
                }
                field("Period Name";Rec."Period Name")
                {
                    Editable = false;
                }
                field("Ignore This Loan";Rec."Ignore This Loan")
                {
                    
                }
            }
        }
    }
}
