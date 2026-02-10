page 52185596 "HR Non Working Days & Dates"
{
    Caption = 'HR Non Working Dates';
    PageType = ListPart;
    SourceTable = "HR Non Working Days & Dates";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(Date; Rec.Date)
                {
                }
                field(Reason; Rec.Reason)
                {
                }
                field(Recurring; Rec.Recurring)
                {
                }
            
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Employee Leave Card")
            {
                ApplicationArea = Basic;
                Caption = 'Update Employee Card';
                Image = ClosePeriod;


                trigger OnAction()
                var
                    hremp: record "HR Employees";
                    HRNonWorkingDays: Record "HR Non Working Days & Dates";
                    HRLeaveLedger: Record "HR Leave Ledger Entries";
                    HRCalendarList: Record "HR Leave Calendar Lines";
                begin
        //           dAlloc := 0;
        // dEarnd := 0;
        // dTaken := 0;
        // dLeft := 0;
        // cReimbsd := 0;
        // cPerDay := 0;
        // if HREmp.Get(Hremp."No.") then begin
        //     if HREmp."Salary Grade" <> xRec."Salary Grade" then begin
        //         SalGrade.reset();
        //         salgrade.SetRange("Salary Grade", rec."Salary Grade");
        //         salgrade.SetRange("Employee Group", rec."Employee Group");
        //         if SalGrade.Find('-') then begin
        //             HRLeaveCal.Reset;
        //             HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
        //             if not HRLeaveCal.Find('-') then Error('Leave Calendar not setup');
        //             //Filter by Leave Period from HR Setup


        //             HRLeaveLedgerEntries.Reset;
        //             // HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Entry No.");
        //             // HRLeaveLedgerEntries.setrange("Leave Calendar Code", HRLeaveCal."Calendar Code");
        //             if HRLeaveLedgerEntries.Find('+') then cbf := HRLeaveLedgerEntries."Entry No.";

        //             rec.CalcFields("Allocated Leave Days");
        //             if salgrade."Leave Days" <> Rec."Allocated Leave Days" then begin
        //                 dAlloc := 0;
        //                 dEarnd := salgrade."Leave Days" - rec."Allocated Leave Days";

        //                 cbf := cbf + 1;
        //                 HRLeaveLedgerEntries.Init;
        //                 HRLeaveLedgerEntries."Entry No." := cbf;
        //                 HRLeaveLedgerEntries."Staff No." := rec."No.";
        //                 HRLeaveLedgerEntries."Staff Name" := rec.FullName;
        //                 HRLeaveLedgerEntries."Posting Date" := Today;
        //                 HRLeaveLedgerEntries."Leave Entry Type" := HRLeaveLedgerEntries."Leave Entry Type"::Positive;
        //                 HRLeaveLedgerEntries."Leave Approval Date" := Today;
        //                 HRLeaveLedgerEntries."Document No." := rec."No.";
        //                 HRLeaveLedgerEntries."External Document No." := rec."No.";
        //                 HRLeaveLedgerEntries."Job ID" := rec."Job Title";
        //                 HRLeaveLedgerEntries."No. of days" := dEarnd;
        //                 HRLeaveLedgerEntries."Leave Calendar Code" := HRLeaveCal."Calendar Code";
        //                 //HRLeaveLedgerEntries."Leave Start Date" := "Start Date";
        //                 HRLeaveLedgerEntries."Leave Posting Description" := 'Grade Change';
        //                 //HRLeaveLedgerEntries."Leave End Date" := '';
        //                 //HRLeaveLedgerEntries."Leave Return Date" := '';
        //                 HRLeaveLedgerEntries."User ID" := rec."User ID";
        //                 HRLeaveLedgerEntries.Insert(true);
                       
        //          end;
        //               end;
        //         end;
        //     end;
         end;
    


                
            }
        }
    }

    var
        DayOfWeek_Visible: Boolean;
        DateVisible: Boolean;
        HRCalendar: Record "HR Leave Calendar";
        ReasonVisible: Boolean;
        HrNonWorking: record "HR Non Working Days & Dates";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        HRLeaveCal: record "HR Leave Calendar";
         dAlloc: Decimal;
        SystemEdits: record "System Edits";
        dEarnd: Decimal;
        dTaken: Decimal;
        dLeft: Decimal;
        cReimbsd: Decimal;
        cPerDay: Decimal;
        cbf: Integer;
        SendSms: codeunit SendSms;
        Msg: Text[100];
        SMSSource: enum "SMS Source";
}

