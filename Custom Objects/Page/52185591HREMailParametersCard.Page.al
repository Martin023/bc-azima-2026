page 52185591 "HR E-Mail Parameters Card"
{
    PageType = Card;
    SourceTable = "HR E-Mail Parameters";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Associate With"; Rec."Associate With")
                {
                    ApplicationArea = Basic;
                }
                field("Sender Name"; Rec."Sender Name")
                {
                    ApplicationArea = Basic;
                }
                field("Sender Address"; Rec."Sender Address")
                {
                    ApplicationArea = Basic;
                }
                field(Recipients; Rec.Recipients)
                {
                    ApplicationArea = Basic;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = Basic;
                }
                field(Body; Rec.Body)
                {
                    ApplicationArea = Basic;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = Basic;
                }
                field("Template Path"; Rec."Template Path")
                {
                    ApplicationArea = Basic;
                }
                field("Payslip Message"; Rec."Payslip Message")
                {
                    ApplicationArea = Basic;
                }
                field("ICT mail"; Rec."ICT mail")
                {
                    ApplicationArea = Basic;
                }
                field("HR Email"; Rec."HR Email")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

