#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185443 "HR Leave Jnl.- Check Line"
{
    TableNo = "HR Leave Journal Line";

    trigger OnRun()
    var
        TempJnlLineDim: Record "Journal Line Dimension" temporary;
    begin
        GLSetup.Get;
        // if "Global Dimension 1 Code" <> '' then begin
        //     TempJnlLineDim."Table ID" := Database::"HR Leave Journal Line";
        //     TempJnlLineDim."Journal Template Name" := "Journal Template Name";
        //     TempJnlLineDim."Journal Batch Name" := "Journal Batch Name";
        //     TempJnlLineDim."Journal Line No." := "Line No.";
        //     TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 1 Code";
        //     TempJnlLineDim."Dimension Value Code" := "Global Dimension 1 Code";
        //     TempJnlLineDim.Insert;
        // end;
        // if "Global Dimension 2 Code" <> '' then begin
        //     TempJnlLineDim."Table ID" := Database::"HR Leave Journal Line";
        //     TempJnlLineDim."Journal Template Name" := "Journal Template Name";
        //     TempJnlLineDim."Journal Batch Name" := "Journal Batch Name";
        //     TempJnlLineDim."Journal Line No." := "Line No.";
        //     TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 2 Code";
        //     TempJnlLineDim."Dimension Value Code" := "Global Dimension 2 Code";
        //     TempJnlLineDim.Insert;
        // end;
        RunCheck(Rec, TempJnlLineDim);
    end;

    var
        Text000: label 'The combination of dimensions used in %1 %2, %3, %4 is blocked. %5';
        Text001: label 'A dimension used in %1 %2, %3, %4 has caused an error. %5';
        GLSetup: Record "General Ledger Setup";
        FASetup: Record "HR Setup";
        // DimMgt: Codeunit DimensionManagement;
        CallNo: Integer;
        Text002: label 'The Posting Date Must be within the open leave periods';
        Text003: label 'The Posting Date Must be within the allowed Setup date';
        LeaveEntries: Record "HR Leave Ledger Entries";
        Text004: label 'The Allocation of Leave days has been done for the period';
        HRLeaveCal: Record "HR Leave Calendar";


    procedure RunCheck(var InsuranceJnlLine: Record "HR Leave Journal Line"; var JnlLineDim: Record "Journal Line Dimension")
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        begin
            // if "Leave Entry Type" = "leave entry type"::Negative then begin
            //     InsuranceJnlLine.TestField("Leave Calendar Code");
            // end;

            InsuranceJnlLine.TestField("Document No.");
            InsuranceJnlLine.TestField("Posting Date");
            InsuranceJnlLine.TestField("Staff No.");
            CallNo := 1;

            // if not DimMgt.CheckJnlLineDimComb(JnlLineDim) then
            //     Error(
            //       Text000,
            //       InsuranceJnlLine.TableCaption, "Journal Template Name", "Journal Batch Name", "Line No.",
            //       DimMgt.GetDimCombErr);

            // TableID[1] := Database::Table39005571;
            // No[1] := "Leave Calendar Code";
            //IF NOT DimMgt.GetDimensionNo(JnlLineDim,TableID,No) THEN //commented to allow posting
            // if not DimMgt.CheckJnlLineDimValuePosting(JnlLineDim, TableID, No) then
            //     if "Line No." <> 0 then
            //         Error(
            //           Text001,
            //           InsuranceJnlLine.TableCaption, "Journal Template Name", "Journal Batch Name", "Line No.",
            //           DimMgt.GetDimValuePostingErr)
            //     else
            //         Error(DimMgt.GetDimValuePostingErr);
        end;
        ValidatePostingDate(InsuranceJnlLine);
    end;


    procedure ValidatePostingDate(var InsuranceJnlLine: Record "HR Leave Journal Line")
    begin
        begin
            // if "Leave Entry Type" = "leave entry type"::Negative then begin
            //     InsuranceJnlLine.TestField("Leave Calendar Code");
            // end;
            // InsuranceJnlLine.TestField("Document No.");
            // InsuranceJnlLine.TestField("Posting Date");
            // InsuranceJnlLine.TestField("Staff No.");
            // if ("Posting Date" < "Leave Period Start Date") or
            //    ("Posting Date" > "Leave Period End Date") then
            // ERROR(FORMAT(Text002));



            FASetup.Get();
            //Dann
            fn_HRCalendar;

            // if (HRLeaveCal."Start Date" <> 0D) and (HRLeaveCal."End Date" <> 0D) then begin
            //     if ("Posting Date" < HRLeaveCal."Start Date") or
            //        ("Posting Date" > HRLeaveCal."End Date") then
            //         Error(Format(Text003));
            // end;

            /*         LeaveEntries.RESET;
                LeaveEntries.SETRANGE(LeaveEntries."Leave Type","Leave Type");
               IF LeaveEntries.FIND('-') THEN BEGIN
            IF LeaveEntries."Leave Entry Type"=LeaveEntries."Leave Entry Type"::"Leave Allocation" THEN BEGIN
            IF (LeaveEntries."Posting Date"<"Leave Period Start Date") OR
                (LeaveEntries."Posting Date">"Leave Period End Date")  THEN
                ERROR(FORMAT(Text004));
                        END;
              END;
               */
        end;

    end;

    local procedure fn_HRCalendar()
    begin
        HRLeaveCal.Reset;
        HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
        if not HRLeaveCal.Find('-') then Error('HR Calendar not created');
    end;
}
