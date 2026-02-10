#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185492 "Workplan Indent"
{

    trigger OnRun()
    begin

        if not
           Confirm(
             Text000 +
             Text001 +
             Text002 +
             Text003, true)
        then
            exit;

        Indent;
    end;

    var
        GLAcc: Record "Workplan Activities";
        Window: Dialog;
        AccNo: array[10] of Code[20];
        i: Integer;
        Text000: label 'This function updates the indentation of all the Workplan Items in the Workplan card. ';
        Text001: label 'All accounts between a Begin-Total and the matching End-Total are indented one level. ';
        Text002: label 'The Totaling for each End-total is also updated.';
        Text003: label '\\Do you want to indent the Workplan List?';
        Text004: label 'Indenting the Workplan#1##########';
        Text005: label 'End-Total %1 is missing a matching Begin-Total.';


    procedure Indent()
    begin
        Window.Open(Text004);

        // if GLAcc.Find('-') then
        //     repeat
        //         Window.Update(1, "Activity Code");

        //         if "Account Type" = "account type"::"End-Total" then begin
        //             if i < 1 then
        //                 Error(
        //                   Text005,
        //                   "Activity Code");
        //             Totaling := AccNo[i] + '..' + "Activity Code";
        //             i := i - 1;
        //         end;

        //         Indentation := i;
        //         GLAcc.Modify;

        //         if "Account Type" = "account type"::"Begin-Total" then begin
        //             i := i + 1;
        //             AccNo[i] := "Activity Code";
        //         end;
        //     until GLAcc.Next = 0;

        Window.Close;
    end;
}
