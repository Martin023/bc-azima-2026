page 52186777 "HR Salary Grade Lines"
{
    Caption = 'Salary Grade Lines';
    //Editable = false;
    PageType = ListPart;
    SourceTable = "Salary Grade Lines";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {

                }
                field("Transaction Description"; Rec."Transaction Description")
                {

                }
                field(Amount; Rec.Amount)
                {

                }
                field(Frequency; Rec.Frequency)
                {

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

