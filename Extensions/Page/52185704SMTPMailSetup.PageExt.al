// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52185704 pageextension52185704 extends "SMTP Mail Setup" 
// {
//     layout
//     {
//         modify("SMTP Server")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("SMTP Server Port")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (DecimalPlaces) on ""SMTP Server Port"(Control 14)".


//             //Unsupported feature: Property Insertion (Numeric) on ""SMTP Server Port"(Control 14)".

//         }
//         modify(Authentication)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("User ID")
//         {
//             ApplicationArea = Basic;
//             Editable = "User IDEditable";
//         }
//         modify(Password)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Secure Connection")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Allow Sender Substitution")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Allow Sender Substitution"(Control 7)".


//             //Unsupported feature: Property Modification (Name) on ""Allow Sender Substitution"(Control 7)".

//         }

//         //Unsupported feature: Code Modification on ""SMTP Server"(Control 2).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             SetCanSendTestMail;
//             CurrPage.UPDATE;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             SetCanSendTestMail;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""SMTP Server"(Control 2)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""SMTP Server Port"(Control 14)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Authentication(Control 4)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 6)".

//         modify(Password)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on "Password(Control 8)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Password(Control 8)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Secure Connection"(Control 12)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Allow Sender Substitution"(Control 7)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Sender Substitution"(Control 7)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

//         addafter("Allow Sender Substitution")
//         {
//             field("Email Sender Name";"Email Sender Name")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Path to Save Report";"Path to Save Report")
//             {
//                 ApplicationArea = Basic;
//             }
//         }
//     }
//     actions
//     {
//         modify(ApplyOffice365)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(SendTestMail)
//         {
//             ApplicationArea = Basic;
//         }


//         //Unsupported feature: Code Modification on "ApplyOffice365(Action 9).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             IF CurrPage.EDITABLE THEN BEGIN
//               IF NOT ("SMTP Server" = '') THEN
//                 IF NOT ConfirmManagement.ConfirmProcess(ConfirmApplyO365Qst,TRUE) THEN
//                   EXIT;
//               SMTPMail.ApplyOffice365Smtp(Rec);
//               AuthenticationOnAfterValidate;
//               SetCanSendTestMail;
//               CurrPage.UPDATE;
//             END
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             IF CurrPage.EDITABLE THEN BEGIN
//               IF NOT ("SMTP Server" = '') THEN
//                 IF NOT DIALOG.CONFIRM(ConfirmApplyO365Qst) THEN
//             #4..6
//               CurrPage.UPDATE;
//             END
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "ApplyOffice365(Action 9)".

//     }

//     var
//         
//         "User IDEditable": Boolean;


//     //Unsupported feature: Code Modification on "OnInit".

//     //trigger OnInit()
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         PasswordEditable := TRUE;
//         UserIDEditable := TRUE;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         PasswordEditable := TRUE;
//         "User IDEditable" := TRUE;
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         RESET;
//         IF NOT GET THEN BEGIN
//           INIT;
//           INSERT;
//           SetPassword('');
//         END ELSE
//           Password := '***';
//         UserIDEditable := Authentication = Authentication::Basic;
//         PasswordEditable := Authentication = Authentication::Basic;
//         SetCanSendTestMail;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..4
//         END;
//         "User IDEditable" := Authentication = Authentication::Basic;
//         PasswordEditable := Authentication = Authentication::Basic;
//         SetCanSendTestMail;
//         */
//     //end;


//     //Unsupported feature: Code Modification on "AuthenticationOnAfterValidate(PROCEDURE 19028764)".

//     //procedure AuthenticationOnAfterValidate();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         UserIDEditable := Authentication = Authentication::Basic;
//         PasswordEditable := Authentication = Authentication::Basic;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         "User IDEditable" := Authentication = Authentication::Basic;
//         PasswordEditable := Authentication = Authentication::Basic;
//         */
//     //end;

//     //Unsupported feature: Property Deletion (ApplicationArea).


//     //Unsupported feature: Property Deletion (UsageCategory).

// }
