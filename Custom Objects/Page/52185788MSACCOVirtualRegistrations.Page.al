page 52185788 "MBanking Virtual Registrations"
{
    PageType = List;
    SourceTable = "M-SACCO Virtual Registrations";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Id No"; Rec."Id No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mpesa Names"; Rec."Mpesa Names")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("IPRS Names"; Rec."IPRS Names")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Place Birth"; Rec."Place Birth")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(IDisValid; Rec.IDisValid)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reg Office"; Rec."Reg Office")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entry Date"; Rec."Entry Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entry Time"; Rec."Entry Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reffered By"; Rec."Reffered By")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

