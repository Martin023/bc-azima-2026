#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186006 "Delegates Correspondence"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Delegates Correspondence.rdl';

    dataset
    {
        //dataitem(52186056; 52186056)
        dataitem("Delegates Minutes Header"; "Delegates Minutes Header")
        {

            column(PrintedBy; PrintedBy)
            {
            }
            column(PrintedAt; PrintedAt)
            {
            }
            column(BookNo; BookNo)
            {
            }
            column(TotalBranchMembers; TotalBranchMembers)
            {
            }
            column(BranchName; BranchName)
            {
            }
            column(MonthText; MonthText)
            {
            }
            column(Date; Date)
            {
            }
            //dataitem(52186057; 52186057)
            dataitem("Delegates Meeting Attendees"; "Delegates Meeting Attendees")
            {
                DataItemLink = "Header No" = field(Code);
                column(ReportForNavId_32; 32)
                {
                }
                column(HeaderNo_DelegatesMeetingAttendees; "Delegates Meeting Attendees"."Header No")
                {
                }
                column(DelegateNo_DelegatesMeetingAttendees; "Delegates Meeting Attendees"."Delegate No.")
                {
                }
                column(DelegateName_DelegatesMeetingAttendees; "Delegates Meeting Attendees"."Delegate Name")
                {
                }
                column(DelegateEmail_DelegatesMeetingAttendees; "Delegates Meeting Attendees"."Delegate Email")
                {
                }
                column(DelegatePhone_DelegatesMeetingAttendees; "Delegates Meeting Attendees"."Delegate Phone")
                {
                }
                column(DelegatePosition_DelegatesMeetingAttendees; "Delegates Meeting Attendees"."Delegate Position")
                {
                }

            }

            //dataitem(52186225;52186225)
            dataitem("Delegates Monthly Returns"; "Delegates Monthly Returns")
            {
                DataItemLink = "Header No" = field(Code);
                // DataItemTableView = where("Caption Type" = filter(<> TOTAL_BRANCH_MEMBERS & <> VARIATION_DOWN & <> MEETING_ATTENDEES));

                column(HeaderNo_DelegatesMonthlyReturns; "Delegates Monthly Returns"."Header No")
                {
                }
                column(Caption_DelegatesMonthlyReturns; "Delegates Monthly Returns".Caption)
                {
                }
                column(CaptionType_DelegatesMonthlyReturns; "Delegates Monthly Returns"."Caption Type")
                {
                }
                column(TotalBranchMembers_DelegatesMonthlyReturns; "Delegates Monthly Returns"."Total Branch Members")
                {
                }
                column(RecordsSubmitted_DelegatesMonthlyReturns; "Delegates Monthly Returns"."Records Submitted")
                {
                }
                column(LinesMemberNumbers; LinesMemberNumbers)
                {
                }
                column(LinesCount; LinesCount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LinesMemberNumbers := '';
                    LinesCount := 0;
                    DelegatesReturnsLines.Reset;
                    DelegatesReturnsLines.SetRange("Header No", "Delegates Monthly Returns"."Header No");
                    DelegatesReturnsLines.SetRange("Caption Type", "Delegates Monthly Returns"."Caption Type");
                    if DelegatesReturnsLines.FindFirst then begin
                        LinesCount := DelegatesReturnsLines.Count;
                        repeat
                            LinesMemberNumbers += DelegatesReturnsLines."ID/Personal/Member Number" + ' ';
                        until DelegatesReturnsLines.Next = 0;
                    end;
                end;
            }
            dataitem("Complain and Remarks"; "Complain and Remarks")
            {
                DataItemLink = "Header No" = field(Code);
                DataItemTableView = where(Type = const("Complains and Remarks"));
                column(ReportForNavId_8; 8)
                {
                }
                column(HeaderNo_ComplainandRemarks; "Complain and Remarks"."Header No")
                {
                }
                column(LineNo_ComplainandRemarks; "Complain and Remarks"."Line No")
                {
                }
                column(Type_ComplainandRemarks; "Complain and Remarks".Type)
                {
                }
                column(Complain_ComplainandRemarks; "Complain and Remarks".Complain)
                {
                }
                column(Suggestion_ComplainandRemarks; "Complain and Remarks".Suggestion)
                {
                }
                column(Remark_ComplainandRemarks; "Complain and Remarks"."Proposed Resolutions")
                {
                }
                column(ComplaintCatagory_ComplainandRemarks; "Complain and Remarks"."Complaint Catagory")
                {
                }
            }
            // dataitem("Other Remarks"; "Other Remarks")
            // {
            //     DataItemLink = "Header No" = field(Code);
            //     DataItemTableView = where(Type = const("Other Remarks"));
            //     column(ReportForNavId_25; 25)
            //     {
            //     }
            //     column(HeaderNo_OtherRemarks; "Other Remarks"."Header No")
            //     {
            //     }
            //     column(LineNo_OtherRemarks; "Other Remarks"."Line No")
            //     {
            //     }
            //     column(Type_OtherRemarks; "Other Remarks".Type)
            //     {
            //     }
            //     column(Complain_OtherRemarks; "Other Remarks".Complain)
            //     {
            //     }
            //     column(Suggestion_OtherRemarks; "Other Remarks".Suggestion)
            //     {
            //     }
            //     column(Remark_OtherRemarks; "Other Remarks"."Proposed Resolutions")
            //     {
            //     }
            // }

            trigger OnAfterGetRecord()
            begin
                //DelegatesMinutesHeader
                DelegatesMonthlyReturns.Reset;
                DelegatesMonthlyReturns.SetRange("Header No", Code);
                DelegatesMonthlyReturns.SetRange("Caption Type", 'TOTAL_BRANCH_MEMBERS');
                if DelegatesMonthlyReturns.FindFirst then
                    TotalBranchMembers := DelegatesMonthlyReturns."Total Branch Members";


            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Company.Get;
        Company.CalcFields(Picture);
        PrintedBy := CopyStr(UserId, StrPos(UserId, '\') + 1, StrLen(UserId));
        // PrintedAt := SkyHarambeePortal.FormatDateTimeReverse(CurrentDatetime);
    end;

    var
        BookNo: Code[10];
        PrintedBy: Code[50];
        PrintedAt: Text;
        // SkyHarambeePortal: Codeunit "Sky Harambee Portal";
        DelegatesReturnsLines: Record "Delegates Returns Lines";
        LinesCount: Integer;
        Company: Record "Company Information";
        LinesMemberNumbers: Text;
        DelegatesMonthlyReturns: Record "Delegates Monthly Returns";
        TotalBranchMembers: Integer;
        BranchName: Text;
        MonthText: Text;
        Date: Text;
        DelegateRegion: Record "Delegate Region";
        DelegatesMinutesHeader: Record "Delegates Minutes Header";
}
