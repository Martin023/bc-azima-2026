#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186347 pageextension52186347 extends "Profile Questn. Line Subform" 
{
    layout
    {
        modify(Set)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Set(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 2)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetProfileQnLine(PROCEDURE 1)".


    //Unsupported feature: Code Modification on "ClearSettings(PROCEDURE 2)".

    //procedure ClearSettings();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF TempProfileQuestionnaireLine.FINDFIRST THEN
          TempProfileQuestionnaireLine.DELETEALL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF TempProfileQuestionnaireLine.FIND('-') THEN
          TempProfileQuestionnaireLine.DELETEALL;
        */
    //end;

    local procedure GetParameters(var GetProfileQuestionnaireLine: Record "Profile Questionnaire Line")
    var
        ProfileQuestionnaireLine2: Record "Profile Questionnaire Line";
        FirstPQLine: Integer;
        LastPQLine: Integer;
        SelectionFilter: Code[250];
        PQLineCount: Integer;
        More: Boolean;
    begin
        // ProfileQuestionnaireLine2.SetRange("Profile Questionnaire Code",Rec."Profile Questionnaire Code");
        // if TempProfileQuestionnaireLine.Find('-') then
        //   repeat
        //     if ProfileQuestionnaireLine2.Get(
        //          TempProfileQuestionnaireLine."Profile Questionnaire Code",TempProfileQuestionnaireLine."Line No.")
        //     then
        //       ProfileQuestionnaireLine2.Mark(true);
        //   until TempProfileQuestionnaireLine.Next = 0;

        ProfileQuestionnaireLine2.MarkedOnly(true);
        PQLineCount := ProfileQuestionnaireLine2.Count;
        if PQLineCount > 0 then begin
          ProfileQuestionnaireLine2.Find('-');
          while PQLineCount > 0 do begin
            PQLineCount := PQLineCount - 1;
            ProfileQuestionnaireLine2.MarkedOnly(false);
            FirstPQLine := ProfileQuestionnaireLine2."Line No.";
            LastPQLine := FirstPQLine;
            More := (PQLineCount > 0);
            while More do
              if ProfileQuestionnaireLine2.Next = 0 then
                More := false
              else
                if not ProfileQuestionnaireLine2.Mark then
                  More := false
                else begin
                  LastPQLine := ProfileQuestionnaireLine2."Line No.";
                  PQLineCount := PQLineCount - 1;
                  if PQLineCount = 0 then
                    More := false;
                end;
            if SelectionFilter <> '' then
              SelectionFilter := SelectionFilter + '|';
            if FirstPQLine = LastPQLine then
              SelectionFilter := SelectionFilter + Format(FirstPQLine)
            else
              SelectionFilter := SelectionFilter + Format(FirstPQLine) + '..' + Format(LastPQLine);
            if PQLineCount > 0 then begin
              ProfileQuestionnaireLine2.MarkedOnly(true);
              ProfileQuestionnaireLine2.Next;
            end;
          end;
        end;
        GetProfileQuestionnaireLine.SetFilter("Line No.",SelectionFilter);
    end;

    local procedure GetProfileQnLine(var ToProfileQuestionnaireLine: Record "Profile Questionnaire Line")
    begin
        begin
          // ToProfileQuestionnaireLine.DeleteAll;
          // if TempProfileQuestionnaireLine.Find('-') then
          //   repeat
          //     ToProfileQuestionnaireLine := TempProfileQuestionnaireLine;
          //     ToProfileQuestionnaireLine.Insert;
          //   until TempProfileQuestionnaireLine.Next = 0;
        end;
    end;
}
