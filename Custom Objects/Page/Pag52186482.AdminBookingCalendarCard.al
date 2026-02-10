namespace MNS.MNS;
using System.Utilities;

page 52186482 "Admin Booking Calendar Card"
{
    Caption = 'Admin Booking Calendar Card';
    PageType = Card;
    SourceTable = "Admin Booking Calendar";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                // field("Period"; Rec."Period")
                // {
                // }
                field("Calendar Code"; Rec."Calendar Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Current Leave Calendar"; Rec."Current Calendar")
                {
                    ApplicationArea = Basic;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Modified"; Rec."Date Modified")
                {
                    ApplicationArea = Basic;
                }
            }
            // part(Control10; "HR Non Working Days & Dates")
            // {
            //     ApplicationArea = Basic;
            // }
            part(Control1102755000; "HR Leave Calendar Lines")
            {
                ApplicationArea = Basic;
                SubPageLink = Code = FIELD("Calendar Code");

            }
        }
    }

    actions
    {
        area(creation)
        {
            action(CreateCalendar)
            {
                ApplicationArea = Basic;
                Caption = 'Create Calendar';
                Image = CalculateCalendar;
                Promoted = true;
                PromotedCategory = Category6;

                trigger OnAction()
                var
                    Text8000: Text;
                    TEXT0025: Label 'Saturday';
                    TEXT0026: Label 'Sunday';
                begin
                    Rec.TestField("Calendar Code");
                    Rec.TestField("Start Date");
                    Rec.TestField("End Date");

                    if Confirm('Generate Calendar [%1]', false, Rec."Calendar Code") = true then begin
                        Date.Reset;
                        Date.SetRange(Date."Period Type", Date."Period Type"::Date);
                        Date.SetRange(Date."Period Start", Rec."Start Date", Rec."End Date");
                        if Date.Find('-') then begin
                            HRCalendarList.Reset;
                            HRCalendarList.DeleteAll;

                            repeat
                                HRCalendarList.Init;

                                HRCalendarList.Code := Rec."Calendar Code";
                                HRCalendarList.Date := Date."Period Start";
                                ;      // e.g 01-01-15
                                HRCalendarList.Day := Date."Period Name";         // e.g Thursday
                                HRCalendarList."Non Working" := fn_DetermineNonWorking(Date."Period Start");
                                /*
                                //Saturday
                                IF  (Date."Period Name" = TEXT0025) AND NOT (HRCalendarList."Non Working") THEN
                                BEGIN
                                    HRCalendarList."Non Working":=TRUE;
                                    HRCalendarList.Reason:=TEXT0025;
                                END;
                                */
                                //Sunday
                                if (Date."Period Name" = TEXT0026) and not (HRCalendarList."Non Working") then begin
                                    HRCalendarList."Non Working" := true;
                                    HRCalendarList.Reason := TEXT0026;
                                end;

                                HRCalendarList.Insert;
                            until Date.Next = 0;
                            Message('Process complete');
                        end else begin
                            Error('Invalid Date format');
                        end;
                    end else begin
                        //Creation aborted
                        exit;
                    end;

                end;
            }
        }
    }

    var
        Day: Date;
        Date: Record Date;
        HRCalendarList: Record "HR Leave Calendar Lines";

    local procedure fn_DetermineNonWorking(currDate: Date) isNonWorking: Boolean
    var
        HRNonWorkingDays: Record "HR Non Working Days & Dates";
    begin
        isNonWorking := false;
        HRCalendarList.Reason := '';

        HRNonWorkingDays.Reset;
        if HRNonWorkingDays.Get(currDate) then begin
            isNonWorking := true;
            HRCalendarList.Reason := HRNonWorkingDays.Reason;
        end;
    end;
}

