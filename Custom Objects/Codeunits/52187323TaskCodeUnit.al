// codeunit 52187323 TaskCodeunit
// {
//     trigger OnRun()
//     var
//         i: Integer;
//     begin
//         for i := 1 to 50000 do begin
//             Sleep(1000);
//         end;
//     end;
// }