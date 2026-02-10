#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185449 "HR Appraisal Jnl.-Check Line"
{
    TableNo = "HR Appraisal Journal Line";

    trigger OnRun()
    var
        TempJnlLineDim: Record "Journal Line Dimension" temporary;
    begin
        GLSetup.Get;

        // if "Shortcut Dimension 1 Code" <> '' then begin
        //     TempJnlLineDim."Table ID" := Database::"HR Appraisal Journal Line";
        //     TempJnlLineDim."Journal Template Name" := "Journal Template Name";
        //     TempJnlLineDim."Journal Batch Name" := "Journal Batch Name";
        //     TempJnlLineDim."Journal Line No." := "Line No.";
        //     TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 1 Code";
        //     TempJnlLineDim."Dimension Value Code" := "Shortcut Dimension 1 Code";
        //     TempJnlLineDim.Insert;
        // end;
        // if "Shortcut Dimension 2 Code" <> '' then begin
        //     TempJnlLineDim."Table ID" := Database::"HR Appraisal Journal Line";
        //     TempJnlLineDim."Journal Template Name" := "Journal Template Name";
        //     TempJnlLineDim."Journal Batch Name" := "Journal Batch Name";
        //     TempJnlLineDim."Journal Line No." := "Line No.";
        //     TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 2 Code";
        //     TempJnlLineDim."Dimension Value Code" := "Shortcut Dimension 2 Code";
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
        AppriasalEntries: Record "HR Appraisal Ledger Entries";
        Text004: label 'The Allocation of Leave days has been done for the period';


    procedure ValidatePostingDate(var InsuranceJnlLine: Record "HR Appraisal Journal Line")
    begin
        begin
            //  IF "Leave Entry Type"="Leave Entry Type"::Negative THEN BEGIN
            InsuranceJnlLine.TestField("Appraisal Period");
            //END;
            InsuranceJnlLine.TestField("Document No.");
            InsuranceJnlLine.TestField("Posting Date");
            InsuranceJnlLine.TestField("Staff No.");
            // if ("Posting Date" < "Appraisal Period Start Date") or
            //    ("Posting Date" > "Appraisal Period End Date") then
            // ERROR(FORMAT(Text002));

            FASetup.Get();
            /*
            IF (FASetup."Leave Posting Period[FROM]"<>0D) AND (FASetup."Leave Posting Period[TO]"<>0D) THEN BEGIN
              IF ("Posting Date"<FASetup."Appraisal Posting Period[FROM]") OR
                 ("Posting Date">FASetup."Appraisal Posting Period[TO]")  THEN
                 ERROR(FORMAT(Text003));
            END;*/
        end;

    end;


    procedure RunCheck(var InsuranceJnlLine: Record "HR Appraisal Journal Line"; var JnlLineDim: Record "Journal Line Dimension")
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        begin
            //IF "Appraisal Entry Type"="Appraisal Entry Type"::Negative THEN BEGIN
            InsuranceJnlLine.TestField("Appraisal No.");
            //END;
            InsuranceJnlLine.TestField("Document No.");
            InsuranceJnlLine.TestField("Posting Date");
            InsuranceJnlLine.TestField("Staff No.");
            CallNo := 1;

            /*  IF NOT DimMgt.CheckJnlLineDimComb(JnlLineDim) THEN
                ERROR(
                  Text000,
                  TABLECAPTION,"Journal Template Name","Journal Batch Name","Line No.",
                  DimMgt.GetDimCombErr);*/

            //  TableID[1] := DATABASE::Table39006175;
            TableID[1] := Database::"HR Appraisal Journal Line";
            // No[1] := "Appraisal No.";
            // //IF NOT DimMgt.GetDimensionNo(JnlLineDim,TableID,No) THEN
            // if "Line No." <> 0 then
            //     Error(
            //       Text001,
            //       InsuranceJnlLine.TableCaption, "Journal Template Name", "Journal Batch Name", "Line No.",
            //       DimMgt.GetDimValuePostingErr)
            // else
            //     Error(DimMgt.GetDimValuePostingErr);
        end;
        ValidatePostingDate(InsuranceJnlLine);

    end;
}
