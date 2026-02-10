#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52187215 pageextension52187215 extends "Std. Password Dialog" 
// {
//     layout
//     {
//         modify(SetPassword)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(ConfirmPassword)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "SetPassword(Control 2)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "ConfirmPassword(Control 3)".

//     }

//     //Unsupported feature: Property Modification (TextConstString) on "ConfirmBlankPasswordQst(Variable 1008)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //ConfirmBlankPasswordQst : ENU=Do you want to exit without entering a password?;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //ConfirmBlankPasswordQst : ENU=Do you want to exit the dialog box with an empty password?;
//         //Variable type has not been exported.


//     //Unsupported feature: Code Modification on "OnQueryClosePage".

//     //trigger OnQueryClosePage(CloseAction: Action): Boolean
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         ValidPassword := FALSE;
//         IF CloseAction = ACTION::OK THEN BEGIN
//           IF RequiresPasswordConfirmation AND (SetPassword <> ConfirmPassword) THEN
//             ERROR(PasswordMismatchErr);
//           IF EnableBlankPasswordState AND (SetPassword = '') THEN BEGIN
//             IF NOT CONFIRM(ConfirmBlankPasswordQst) THEN
//               ERROR(PasswordTooSimpleErr);
//           END ELSE BEGIN
//             IF SetPassword = '' THEN
//               ERROR(PasswordBlankIsNotAllowedErr);
//             IF ValidatePassword AND NOT IdentityManagement.ValidatePasswordStrength(SetPassword) THEN
//               ERROR(PasswordTooSimpleErr);
//           END;
//           ValidPassword := TRUE;
//         END
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..8
//         #11..15
//         */
//     //end;

//     //Unsupported feature: Property Deletion (Attributes) on "GetPasswordValue(PROCEDURE 1)".


//     //Unsupported feature: Property Deletion (Attributes) on "EnableBlankPassword(PROCEDURE 2)".


//     //Unsupported feature: Property Deletion (Attributes) on "EnableGetPasswordMode(PROCEDURE 3)".


//     //Unsupported feature: Property Deletion (Attributes) on "DisablePasswordConfirmation(PROCEDURE 5)".

// }
