// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52187070 pageextension52187070 extends "Allowed Companies" 
// {
//     layout
//     {
//         modify(CompanyDisplayName)
//         {

//             //Unsupported feature: Property Modification (Name) on "CompanyDisplayName(Control 3)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "CompanyDisplayName(Control 3)".

//         }

//         //Unsupported feature: Property Deletion (CaptionML) on "CompanyDisplayName(Control 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "CompanyDisplayName(Control 3)".


//         //Unsupported feature: Property Deletion (StyleExpr) on "CompanyDisplayName(Control 3)".

//         modify("Evaluation Company")
//         {
//             Visible = false;
//         }
//         modify(SetupStatus)
//         {
//             Visible = false;
//         }
//     }
//     actions
//     {
//         modify(ActionContainer4)
//         {
//             Visible = false;
//         }
//         modify("Create New Company")
//         {
//             Visible = false;
//         }
//     }

//     //Unsupported feature: Variable Insertion (Variable: Company) (VariableCollection) on "Initialize(PROCEDURE 1)".


//     //Unsupported feature: Variable Insertion (Variable: Language) (VariableCollection) on "Initialize(PROCEDURE 1)".


//     //Unsupported feature: Property Deletion (Attributes) on "Initialize(PROCEDURE 1)".


//     //Unsupported feature: Code Modification on "Initialize(PROCEDURE 1)".

//     //procedure Initialize();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         AssistedCompanySetup.GetAllowedCompaniesForCurrnetUser(Rec);
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         Language.INIT;

//         IF Company.FINDSET THEN
//           REPEAT
//             // Use a table that all users has access to and check if the user has permissions to open the company.
//             IF Language.CHANGECOMPANY(Company.Name) THEN BEGIN
//               Rec := Company;
//               INSERT;
//             END;
//           UNTIL Company.NEXT = 0;
//         */
//     //end;

//     //Unsupported feature: Deletion (VariableCollection) on "Initialize(PROCEDURE 1).AssistedCompanySetup(Variable 1000)".

// }
