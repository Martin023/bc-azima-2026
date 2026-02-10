page 52185573 "HR Applicant Referees"
{
    PageType = List;
    SourceTable = "HR Applicant Referees";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                    ShowMandatory=true;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                    ShowMandatory=true;
                }
                field(Institution; Rec.Institution)
                {
                    ApplicationArea = Basic;
                    showmandatory=true;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                    showmandatory=true;
                }
            }
        }
    }

    actions
    {
    }
}

