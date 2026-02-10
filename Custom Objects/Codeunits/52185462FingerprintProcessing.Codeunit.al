#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185462 "Fingerprint Processing"
{

    trigger OnRun()
    begin
    end;


    procedure GetAuthentication(MemberNo: Code[20]; GuidValue: Guid; AuthStatus: Integer)
    var
        FingerPrintAuthentication: Record "FingerPrint Authentication";
    begin
        FingerPrintAuthentication.Init;
        FingerPrintAuthentication."Member No." := MemberNo;
        FingerPrintAuthentication.Guid := GuidValue;
        FingerPrintAuthentication."Authentication Status" := AuthStatus;
        FingerPrintAuthentication.Insert(true);
    end;
}
