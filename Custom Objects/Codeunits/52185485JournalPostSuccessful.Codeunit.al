#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185485 "Journal Post Successful"
{

    trigger OnRun()
    begin
    end;


    procedure PostedSuccessfully() Posted: Boolean
    var
        ValPost: Record "Value Posting";
    begin

        Posted := false;
        ValPost.SetRange(ValPost.UserID, UserId);
        ValPost.SetRange(ValPost."Value Posting", 1);
        if ValPost.Find('-') then
            Posted := true;
    end;

    procedure CheckPosted(var DocNo: code[50]): Boolean
    var
        GLEntries: record "G/L Entry";
    begin
        GLEntries.Reset();
        GLEntries.SetRange("Document No.", DocNo);
        if GLEntries.FindFirst() then
            exit(true)
        else
            exit(false);
    end;
}
