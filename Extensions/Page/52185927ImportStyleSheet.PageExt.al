// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52185927 pageextension52185927 extends "Import Style Sheet" 
// {
//     layout
//     {
//         modify(FileName)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Description)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(ApplicationName)
//         {
//             ApplicationArea = Basic;
//         }
//     }

//     //Unsupported feature: Property Deletion (Attributes) on "SetObjectID(PROCEDURE 2)".


//     //Unsupported feature: Property Deletion (Attributes) on "GetStyleSheet(PROCEDURE 1)".


//     //Unsupported feature: Code Modification on "FindApplication(PROCEDURE 6)".

//     //procedure FindApplication();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         SendToProgram.RESET;
//         IF ApplicationName = '' THEN BEGIN
//           SendToProgram.FINDFIRST;
//         #4..8
//           ApplicationName := SendToProgram.Name;
//           EXIT;
//         END;
//         SendToProgram.SETFILTER(Name,'@*' + ApplicationName + '*');
//         IF SendToProgram.FINDFIRST THEN BEGIN
//           ApplicationName := SendToProgram.Name;
//           EXIT;
//         END;
//         ERROR(Text001,SendToProgram.TABLECAPTION);
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..11
//         SendToProgram.SETFILTER(Name,'*@' + ApplicationName + '*');
//         #13..17
//         */
//     //end;


//     //Unsupported feature: Code Modification on "LookupStyleSheet(PROCEDURE 8)".

//     //procedure LookupStyleSheet();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         FileName := FileMgt.BLOBImport(TempBlob,'*.xsl*');

//         IF FileName = '' THEN BEGIN
//           CLEAR(StyleSheet."Style Sheet");
//           CLEAR(Description);
//           EXIT;
//         END;
//         PathLength := STRLEN(FileMgt.GetDirectoryName(FileName));
//         // If there is a path in the filename, we should cut away the path.
//         IF PathLength <> 0 THEN
//           Description := COPYSTR(FileName,PathLength + 2)
//         ELSE
//           Description := COPYSTR(FileName,1);
//         StyleSheet.Name := Description;
//         StyleSheet."Style Sheet" := TempBlob.Blob;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..8
//         Description := COPYSTR(FileName,PathLength + 2);
//         StyleSheet.Name := Description;
//         StyleSheet."Style Sheet" := TempBlob.Blob;
//         */
//     //end;
// }
