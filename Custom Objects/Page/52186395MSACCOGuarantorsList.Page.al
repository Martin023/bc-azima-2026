page 52186395 "MBanking Guarantors List"
{
    Editable = false;
    PageType = List;
    SourceTable = "M-SACCO Guarantors";
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
                field("Msacco Loans Entry No"; Rec."Msacco Loans Entry No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Guarontor Telephone No"; Rec."Guarontor Telephone No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Guarontor Account No"; Rec."Guarontor Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Guarontor Name"; Rec."Guarontor Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Applicant Telephone No"; Rec."Applicant Telephone No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Received"; Rec."Date Received")
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

