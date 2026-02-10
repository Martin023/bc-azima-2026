page 52186380 "E-Mail Notification"
{
    PageType = List;
    SourceTable = "E-Mail Notification";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Path To Save Report"; Rec."Path To Save Report")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sender Name"; Rec."Sender Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sender E-Mail"; Rec."Sender E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Send To CC"; Rec."Send To CC")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Send To BCC"; Rec."Send To BCC")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control10; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control11; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control12; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }
}

