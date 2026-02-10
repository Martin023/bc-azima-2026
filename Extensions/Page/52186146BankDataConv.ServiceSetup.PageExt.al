// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186146 pageextension52186146 extends "Bank Data Conv. Service Setup" 
// {
//     layout
//     {
//         modify("User Name")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Password)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Sign-up URL")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Sign-up URL"(Control 3)".


//             //Unsupported feature: Property Modification (Name) on ""Sign-up URL"(Control 3)".

//         }
//         modify("Service URL")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Support URL")
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""User Name"(Control 5)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Password(Control 6)".

//         modify(Servcie)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Sign-up URL"(Control 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Service URL"(Control 4)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Support URL"(Control 7)".

//         modify("Namespace API Version")
//         {
//             Visible = false;
//         }
//     }
//     actions
//     {
//         modify(SetURLsToDefault)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(BankList)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(EncryptionManagement)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "SetURLsToDefault(Action 9)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "BankList(Action 10)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "EncryptionManagement(Action 12)".

//     }
//     var
//         BankDataConvServiceSetup: Record "Bank Data Conv. Service Setup";


//     //Unsupported feature: Code Insertion on "OnClosePage".

//     //trigger OnClosePage()
//     //begin
//         /*
//         IF Password <> '' THEN
//           CheckEncryption;
//         */
//     //end;


//     //Unsupported feature: Code Insertion (VariableCollection) on "OnOpenPage".

//     //trigger (Variable: BankDataConvServiceSetup)()
//     //Parameters and return type have not been exported.
//     //begin
//         /*
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         CheckedEncryption := FALSE;
//         IF NOT GET THEN BEGIN
//           INIT;
//           INSERT(TRUE);
//         END;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         CheckedEncryption := FALSE;
//         IF NOT BankDataConvServiceSetup.GET THEN BEGIN
//           BankDataConvServiceSetup.INIT;
//           BankDataConvServiceSetup.INSERT;
//           BankDataConvServiceSetup.SetURLsToDefault;
//         END;
//         */
//     //end;

//     //Unsupported feature: Property Deletion (ApplicationArea).


//     //Unsupported feature: Property Deletion (UsageCategory).


//     //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

// }
