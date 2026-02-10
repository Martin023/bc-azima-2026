page 52185544 "HR E-Mail Parameters List"
{
    CardPageID = "HR E-Mail Parameters Card";
    PageType = List;
    SourceTable = "HR E-Mail Parameters";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(General)
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
            }
        }
    }

    actions
    {
    }
}

