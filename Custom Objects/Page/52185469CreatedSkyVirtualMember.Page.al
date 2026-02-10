page 52185469 "Created Sky Virtual Member"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sky Virtual Member";
    SourceTableView = WHERE(Validated = CONST(true),
                            "Sent To Application" = CONST(true),
                            "Source Application" = CONST(USSD),
                            Status = CONST(Approved));
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
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Name on IPRS"; Rec."Name on IPRS")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Citizenship; Rec.Citizenship)
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
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payroll Number"; Rec."Payroll Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Validated; Rec.Validated)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sent To Application"; Rec."Sent To Application")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Referer Member No"; Rec."Referer Member No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
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

