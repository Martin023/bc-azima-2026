#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185463 "Fingerprint Processing Fn"
{

    trigger OnRun()
    begin
    end;

    var
        RunMyExecutable: code[100];//dotnet Process;


    procedure RunInputFingerPrints(MemberNumber: Code[50]; MemberName: Text; IdentificationNumber: Code[20])
    begin
        if MemberNumber = '' then Error('Please provide the Member Number');
        if MemberName = '' then Error('Please provide the Member Name');
        if IdentificationNumber = '' then Error('Please provide the ID Number');
        // RunMyExecutable := RunMyExecutable.Process;
        // RunMyExecutable.StartInfo.UseShellExecute := false;
        // RunMyExecutable.StartInfo.FileName := 'cmd.exe';
        // RunMyExecutable.StartInfo.Arguments :='/c start %CoretecBio%\CT.GUI.exe MemberName:' + TrimName(MemberName) + ' MemberNumber:' + MemberNumber + ' IdentificationNumber:' + IdentificationNumber + ' AuthenticationType:' + 'REG';
        // RunMyExecutable.StartInfo.CreateNoWindow := true;
        // RunMyExecutable.Start();
        // Clear(RunMyExecutable);
    end;


    procedure VerifyFingerPrints(MemberNumber: Code[50]; MemberName: Text; IdentificationNumber: Code[20]; MyGuid: Guid): Boolean
    begin
        if MemberNumber = '' then Error('Please provide the Member Number');
        if MemberName = '' then Error('Please provide the Member Name');
        if IdentificationNumber = '' then Error('Please provide the ID Number');
        if IsNullGuid(MyGuid) then Error('GUID can not be blank');
        // RunMyExecutable := RunMyExecutable.Process;
        // RunMyExecutable.StartInfo.UseShellExecute := false;
        // RunMyExecutable.StartInfo.FileName := 'cmd.exe';
        // RunMyExecutable.StartInfo.Arguments :=
        // '/c start %CoretecBio%\CT.GUI.exe MemberName:' + TrimName(MemberName) + ' MemberNumber:' + MemberNumber + ' IdentificationNumber:' + IdentificationNumber + ' AuthenticationType:' + 'VER' + ' Guid:' + Format(MyGuid);
        // RunMyExecutable.StartInfo.CreateNoWindow := true;
        // RunMyExecutable.Start();
        Clear(RunMyExecutable);
    end;

    local procedure TrimName(MemberName: Text): Text
    begin
        MemberName := ConvertStr(MemberName, ' ', '_');
        MemberName := ConvertStr(MemberName, '.', '_');
        exit(MemberName);
    end;

    // trigger Runmyexecutable::OutputDataReceived(sender: Variant; e: dotnet DataReceivedEventArgs)
    // begin
    // end;

    // trigger Runmyexecutable::ErrorDataReceived(sender: Variant; e: dotnet DataReceivedEventArgs)
    // begin
    // end;

    // trigger Runmyexecutable::Exited(sender: Variant; e: dotnet EventArgs)
    // begin
    // end;

    // trigger Runmyexecutable::Disposed(sender: Variant; e: dotnet EventArgs)
    // begin
    // end;
}
