// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52187178 pageextension52187178 extends "Debugger Code Viewer" 
// {
//     layout
//     {
//         modify(CodeViewer)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "CodeViewer(Control 2)".

//     }

//     //Unsupported feature: Property Modification (ExternalDataType) on "OnAfterGetRecord.BreakpointCollection(Variable 1006)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //OnAfterGetRecord.BreakpointCollection : 'Microsoft.Dynamics.Nav.Client.CodeViewerTypes, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.CodeViewerTypes.BreakpointCollection;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //OnAfterGetRecord.BreakpointCollection : 'Microsoft.Dynamics.Nav.Client.CodeViewerTypes, Version=9.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.CodeViewerTypes.BreakpointCollection;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (ExternalDataType) on "OnFindRecord.BreakpointCollection(Variable 1002)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //OnFindRecord.BreakpointCollection : 'Microsoft.Dynamics.Nav.Client.CodeViewerTypes, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.CodeViewerTypes.BreakpointCollection;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //OnFindRecord.BreakpointCollection : 'Microsoft.Dynamics.Nav.Client.CodeViewerTypes, Version=9.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.CodeViewerTypes.BreakpointCollection;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (ExternalDataType) on "CurrBreakpointCollection(Variable 1004)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //CurrBreakpointCollection : 'Microsoft.Dynamics.Nav.Client.CodeViewerTypes, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.CodeViewerTypes.BreakpointCollection;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //CurrBreakpointCollection : 'Microsoft.Dynamics.Nav.Client.CodeViewerTypes, Version=9.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.CodeViewerTypes.BreakpointCollection;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (ExternalDataType) on "Variables(Variable 1006)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //Variables : 'Microsoft.Dynamics.Nav.Client.CodeViewerTypes, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.CodeViewerTypes.VariableCollection;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //Variables : 'Microsoft.Dynamics.Nav.Client.CodeViewerTypes, Version=9.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.CodeViewerTypes.VariableCollection;
//         //Variable type has not been exported.


//     //Unsupported feature: Code Modification on "OnAfterGetRecord".

//     //trigger OnAfterGetRecord()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         NewObjectType := "Object Type";
//         NewObjectId := "Object ID";
//         NewCallstackId := ID;
//         NewLineNo := "Line No.";

//         IF DebuggerManagement.IsBreakAfterCodeTrackingAction THEN BEGIN
//           DebuggerManagement.ResetActionState;
//           BreakpointCollection := CurrBreakpointCollection;
//         END ELSE
//           GetBreakpointCollection(NewObjectType,NewObjectId,BreakpointCollection);

//         IsBreakAfterRunningCodeAction := DebuggerManagement.IsBreakAfterRunningCodeAction;

//         IF (ObjType <> NewObjectType) OR
//            (ObjectId <> NewObjectId) OR (CallstackId <> NewCallstackId) OR IsBreakAfterRunningCodeAction
//         THEN BEGIN
//           CallstackId := NewCallstackId;

//           IF (ObjType <> NewObjectType) OR (ObjectId <> NewObjectId) OR IsBreakAfterRunningCodeAction THEN BEGIN
//             ObjType := NewObjectType;
//             ObjectId := NewObjectId;

//             ObjectMetadata.INIT;
//             NAVAppObjectMetadata.INIT;

//             IF AllObj.GET(ObjType,ObjectId) AND NOT ISNULLGUID(AllObj."App Package ID") THEN BEGIN
//               IF NAVAppObjectMetadata.GET(AllObj."App Package ID",ObjType,ObjectId) THEN
//                 IF NAVApp.GET(AllObj."App Package ID") THEN
//                   IF NAVApp."Show My Code" THEN BEGIN
//                     NAVAppObjectMetadata.CALCFIELDS("User AL Code");
//                     NAVAppObjectMetadata."User AL Code".CREATEINSTREAM(CodeStream,TEXTENCODING::UTF8);
//                     Code.READ(CodeStream);

//                     LineNo := NewLineNo;
//                     CurrBreakpointCollection := BreakpointCollection;
//                     CurrPage.CodeViewer.LoadCode(Code,NewLineNo,BreakpointCollection,(NewCallstackId = 1));
//                   END ELSE BEGIN
//                     NewLineNo := 0;
//                     LineNo := NewLineNo;
//                     CurrBreakpointCollection := BreakpointCollection;
//                     CurrPage.CodeViewer.LoadCode('',NewLineNo,BreakpointCollection,(NewCallstackId = 1));
//                   END
//             END ELSE
//               IF ObjectMetadata.GET(ObjType,ObjectId) THEN BEGIN
//                 ObjectMetadata.CALCFIELDS("User AL Code");
//                 ObjectMetadata."User AL Code".CREATEINSTREAM(CodeStream,TEXTENCODING::UTF8);
//                 Code.READ(CodeStream);

//                 LineNo := NewLineNo;
//                 CurrBreakpointCollection := BreakpointCollection;
//                 CurrPage.CodeViewer.LoadCode(Code,NewLineNo,BreakpointCollection,(NewCallstackId = 1));
//               END;

//             IF IsBreakAfterRunningCodeAction THEN
//               DebuggerManagement.ResetActionState;

//             // Refresh to update data caption on debugger page

//             DebuggerManagement.RefreshDebuggerTaskPage;

//             EXIT;
//           END;
//         END;

//         IF NewLineNo <> LineNo THEN BEGIN
//           LineNo := NewLineNo;
//           IF ISNULL(BreakpointCollection) THEN
//             IF ISNULL(CurrBreakpointCollection) THEN
//               CurrPage.CodeViewer.UpdateLine(NewLineNo,(NewCallstackId = 1))
//             ELSE
//               CurrPage.CodeViewer.Update(NewLineNo,BreakpointCollection,(NewCallstackId = 1))
//           ELSE
//             IF NOT BreakpointCollection.Equals(CurrBreakpointCollection) THEN
//               CurrPage.CodeViewer.Update(NewLineNo,BreakpointCollection,(NewCallstackId = 1))
//             ELSE
//               CurrPage.CodeViewer.UpdateLine(NewLineNo,(NewCallstackId = 1))
//         END ELSE
//           PaintBreakpoints(BreakpointCollection);

//         CurrBreakpointCollection := BreakpointCollection;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..26
//               IF NAVAppObjectMetadata.GET(AllObj."App Package ID",ObjType,ObjectId) THEN BEGIN
//                 NAVAppObjectMetadata.CALCFIELDS("User AL Code");
//                 NAVAppObjectMetadata."User AL Code".CREATEINSTREAM(CodeStream,TEXTENCODING::UTF8);
//         #47..51
//               END
//         #43..80
//         */
//     //end;

//     //Unsupported feature: Property Modification (ExternalDataType) on "GetBreakpointCollection(PROCEDURE 1).BreakpointCollection(Parameter 1002)".


//     //Unsupported feature: Property Modification (ExternalDataType) on "GetVariables(PROCEDURE 6).Variables(Parameter 1004)".


//     //Unsupported feature: Property Modification (ExternalDataType) on "PaintBreakpoints(PROCEDURE 14).BreakpointCollection(Parameter 1000)".

// }
