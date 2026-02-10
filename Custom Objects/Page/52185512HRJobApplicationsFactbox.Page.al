page 52185512 "HR Job Applications Factbox"
{
    PageType = ListPart;
    SourceTable = "HR Job Applications";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            // field(GeneralInfo; Rec.GeneralInfo)
            // {
            //     Style = Strong;
            //     StyleExpr = TRUE;
            // }
            field("Job Application No."; Rec."Job Application No.")
            {
                ApplicationArea = Basic;
            }
            field("Date Applied"; Rec."Date Applied")
            {
                ApplicationArea = Basic;
            }
            field("First Name"; Rec."First Name")
            {
                ApplicationArea = Basic;
            }
            field("Middle Name"; Rec."Middle Name")
            {
                ApplicationArea = Basic;
            }
            field("Last Name"; Rec."Last Name")
            {
                ApplicationArea = Basic;
            }
            field(Qualified; Rec.Qualified)
            {
                ApplicationArea = Basic;
            }
            field("Interview Invitation Sent"; Rec."Interview Invitation Sent")
            {
                ApplicationArea = Basic;
            }
            field("ID Number"; Rec."ID Number")
            {
                ApplicationArea = Basic;
            }
            // field(PersonalInfo; Rec.PersonalInfo)
            // {
            //     Style = Strong;
            //     StyleExpr = TRUE;
            // }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
            }
            field(Age; Rec.Age)
            {
                ApplicationArea = Basic;
            }
            field("Marital Status"; Rec."Marital Status")
            {
                ApplicationArea = Basic;
            }
            // field(CommunicationInfo; Rec.CommunicationInfo)
            // {
            //     Style = Strong;
            //     StyleExpr = TRUE;
            // }
            // field("Cell Phone Number"; Rec."Cell Phone Number")
            // {
            //     ExtendedDatatype = PhoneNo;
            // }
            // field("E-Mail"; Rec."E-Mail")
            // {
            //     ExtendedDatatype = EMail;
            // }
            // field("Work Phone Number"; Rec."Work Phone Number")
            // {
            //     ExtendedDatatype = PhoneNo;
            // }
        }
    }

    actions
    {
    }

    var
        GeneralInfo: Label 'General Applicant Information';
        PersonalInfo: Label 'Personal Infomation';
        CommunicationInfo: Label 'Communication Information';
}

