// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// XmlPort 52185800 "Refund & Account Transfer"
// {
//     Format = VariableText;

//     schema
//     {
//         textelement(root)
//         {
//             tableelement("R"; "Account Transfer Header")
//             {
                
//                 fieldelement(No; R."Member No")
//                 {
//                 }
//                 tableelement(S;"Account Transfer Source")
//                 {
//                 fieldelement(Source; S."Source Account No.")
//                 {
//                 }
//                 fieldelement(Amount; S."Source Amount")
//                 {
//                 }
//                 tableelement(D;"Account Transfer Destination")
//                 {
//                 fieldelement(Destination; D."Destination Account No.")
//                 {
//                 }
//                  fieldelement(Amount; D."Destination Amount")
//                 {
//                 }
                
            
//                 }

//                 trigger OnAfterInitRecord()
//                 begin
//                     //"Checkoff Buffer"."User Id" := UserId;
                    
//                 end;
//             }
//         }
//     }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     trigger OnPostXmlPort()
//     begin
//         Message(Text01);
//     end;

//     trigger OnPreXmlPort()
//     var
//         OptionStrings: text;

//     begin
//         OptionStrings := ' ,&Member No,&Account No';
//         Response := StrMenu(OptionStrings, 1);
//         if Response = 1 then
//             Error(Error001)
//         ELSE
//             IF (Response = 2) or (response = 3) or (response = 4) then begin

//             end;
//                R."Upload Response" := Response;

//     end;

//     var
//         // [RunOnClient]
//         // Window: dotnet Interaction;
//         MyComment: Text;
//         Response: Integer;
//         Error001: label 'Invalid option, please respond with 2,3 OR 4.';
//         Text01: label 'Upload done successfully';
//         window: Dialog;
// }