// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52185928 pageextension52185928 extends "Program Selection" 
// {
//     layout
//     {
//         modify(Name)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Executable)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(StylesheetName)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 2)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Executable(Control 4)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "StylesheetName(Control 9)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

//     }

//     //Unsupported feature: Property Deletion (Attributes) on "SetObjectID(PROCEDURE 9)".


//     //Unsupported feature: Property Deletion (Attributes) on "GetSelectedStyleSheetID(PROCEDURE 1)".


//     //Unsupported feature: Code Modification on "LookupStylesheet(PROCEDURE 2)".

//     //procedure LookupStylesheet();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         Stylesheet.SETRANGE("Program ID","Program ID");
//         Stylesheet.SETRANGE("Object Type",ObjType);
//         Stylesheet.SETFILTER("Object ID",'%1|%2',0,ObjectID);
//         #4..6
//             Stylesheets.SETRECORD(Stylesheet);
//           Stylesheet.SETRANGE(Name);
//         END;
//         Stylesheets.SetParams(ObjectID,Name);
//         Stylesheets.LOOKUPMODE := TRUE;
//         Stylesheets.SETTABLEVIEW(Stylesheet);
//         IF Stylesheets.RUNMODAL = ACTION::LookupOK THEN BEGIN
//           Stylesheets.GETRECORD(Stylesheet);
//           SetDefaultStylesheet(Stylesheet);
//         END;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..9
//         Stylesheets.SetParams(ObjType,ObjectID,Name);
//         #11..16
//         */
//     //end;


//     //Unsupported feature: Code Modification on "ValidateStylesheet(PROCEDURE 3)".

//     //procedure ValidateStylesheet();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         Stylesheet.SETRANGE("Program ID","Program ID");
//         Stylesheet.SETRANGE("Object Type",ObjType);
//         Stylesheet.SETFILTER("Object ID",'%1|%2',0,ObjectID);
//         Stylesheet.SETRANGE(Name,StylesheetName);
//         IF NOT Stylesheet.FINDFIRST THEN BEGIN
//           Stylesheet.SETFILTER(Name,'@*' + StylesheetName + '*');
//           Stylesheet.FINDFIRST
//         END;
//         SetDefaultStylesheet(Stylesheet);
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..5
//           Stylesheet.SETFILTER(Name,'*@' + StylesheetName + '*');
//         #7..9
//         */
//     //end;
// }
