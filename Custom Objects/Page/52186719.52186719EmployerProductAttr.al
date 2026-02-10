page 52186719 "52186719 Employer Product Attr"
{
    ApplicationArea = All;
    Caption = '52186719 Employer Product Attributes';
    PageType = List;
    SourceTable = "52187008 Employer Product Attr";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employer Code"; Rec."Employer Code")
                {
                    ToolTip = 'Specifies the value of the Employer Code field.';
                }
                field("Min service Year"; Rec."Min service Year")
                {
                    ApplicationArea = all;
                }
                field("Max Service year"; Rec."Max Service year")
                {
                    ApplicationArea = all;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ToolTip = 'specifies the value of the employer name';
                    Editable = false;
                }
                field(Installments; Rec.Installments)
                {
                    ToolTip = 'Specifies the value of the Installments field.';
                }
                field(Interest; Rec.Interest)
                {
                    ToolTip = 'Specifies the value of the Interest field.';
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = all;
                }
                field("Max Amount"; Rec."Max Amount")
                {
                    ToolTip = 'Specifies the value of the Max Amount field.';
                }
                field("Grace Period"; Rec."Grace Period")
                {
                    ToolTip = 'Specifies the value of the Grace Period field.';
                }
                field("Recovery Mode"; Rec."Recovery Mode")
                {
                    ToolTip = 'Specifies the value of the Recovery Mode field.';
                }
            }
        }
    }
}
