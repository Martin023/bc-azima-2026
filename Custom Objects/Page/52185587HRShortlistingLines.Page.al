page 52185587 "HR Shortlisting Lines"
{
    Caption = 'Shorlisted Candidates';
    //Editable = false;
    PageType = ListPart;
    SourceTable = "HR Shortlisted Applicants";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualified';

                    trigger OnValidate()
                    begin
                        JobApplications.reset();
                        JobApplications.SetRange("Job Application No.", rec."Job Application No");
                        if JobApplications.FindSet() then begin
                            JobApplications.Qualified := false;
                            if rec.Qualified then
                                JobApplications.Qualified := true;
                            JobApplications.modify;
                        end;

                    end;
                }
                field("Job Application No"; Rec."Job Application No")
                {
                    ApplicationArea = Basic;
                    editable = false;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = Basic;
                    editable = false;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                    editable = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        JobApplications: record "HR Job Applications";
        MyCount: Integer;

    //[Scope('OnPrem')]
    procedure GetApplicantNo() AppicantNo: Code[20]
    begin
        //AppicantNo:=Applicant;
    end;
}

