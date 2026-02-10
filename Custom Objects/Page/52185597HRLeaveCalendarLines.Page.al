page 52185597 "HR Leave Calendar Lines"
{
    PageType = ListPart;
    SourceTable = "HR Leave Calendar Lines";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = true;
                ShowCaption = false;
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = Basic;
                }
                field("Non Working"; Rec."Non Working")
                {
                    ApplicationArea = Basic;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Unworking Days")
            {
                ApplicationArea = Basic;
                Caption = 'Update Unworking Days';
                Image = ClosePeriod;
               

                trigger OnAction()
                var
                    HRNonWorkingDays: Record "HR Non Working Days & Dates";
                    HRLeaveLedger: Record "HR Leave Ledger Entries";
                    HRCalendarList: Record "HR Leave Calendar Lines";
                begin

                    fn_DetermineNonWorking(Rec);
                end;
            }
        }
    }

    trigger OnClosePage()
    begin
        fn_DetermineNonWorking(Rec);
    end;

    trigger OnOpenPage()
    begin
        fn_DetermineNonWorking(Rec);
    end;

    local procedure fn_DetermineNonWorking(HRCalendarList: Record "HR Leave Calendar Lines")
    var
        HRNonWorkingDays: Record "HR Non Working Days & Dates";
        HRLeaveLedger: Record "HR Leave Ledger Entries";
    begin
        HRNonWorkingDays.Reset;
        HRNonWorkingDays.SetRange(Date, HRCalendarList.Date);
        //IF HRNonWorkingDays.GET(currDate) THEN
        if HRNonWorkingDays.Find('-') then begin
            repeat
                HRCalendarList."Non Working" := true;
                HRCalendarList.Reason := HRNonWorkingDays.Reason;
                HRCalendarList.Modify;
            until HRNonWorkingDays.Next = 0;
        end;
        //UNTIL HRNonWorkingDays.NEXT=0;
    end;
}

