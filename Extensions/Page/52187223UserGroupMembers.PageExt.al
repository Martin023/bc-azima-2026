// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52187223 pageextension52187223 extends "User Group Members"
// {
//     layout
//     {
//         modify(SelectedCompany)
//         {
//             ApplicationArea = Basic;
//         }
//         // modify(UserName)
//         // {

//         //     //Unsupported feature: Property Modification (Name) on "UserName(Control 3)".

//         //     ApplicationArea = Basic;

//         //     //Unsupported feature: Property Modification (SourceExpr) on "UserName(Control 3)".


//         //     //Unsupported feature: Property Modification (TableRelation) on "UserName(Control 3)".

//         // }
//         modify("User Full Name")
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Code Modification on "SelectedCompany(Control 5).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         UpdateCompany;
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         Company.Name := SelectedCompany;
//         IF SelectedCompany <> '' THEN BEGIN
//           Company.FIND('=<>');
//           SelectedCompany := Company.Name;
//         END;
//         SETRANGE("Company Name",Company.Name);
//         CurrPage.UPDATE(FALSE);
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "SelectedCompany(Control 5)".

//         modify(UserName)
//         {
//             Visible = false;
//         }


//         //Unsupported feature: Property Deletion (Lookup) on "UserName(Control 3)".


//         //Unsupported feature: Property Deletion (CaptionML) on "UserName(Control 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "UserName(Control 3)".


//         //Unsupported feature: Property Deletion (LookupPageID) on "UserName(Control 3)".


//         //Unsupported feature: Property Deletion (ShowMandatory) on "UserName(Control 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""User Full Name"(Control 4)".

//         modify("User Group Code")
//         {
//             Visible = false;
//         }
//         modify("Company Name")
//         {
//             Visible = false;
//         }
//     }
//     actions
//     {
//         modify(AddUsers)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "AddUsers(Action 10)".


//         //Unsupported feature: Property Deletion (PromotedCategory) on "AddUsers(Action 10)".


//         //Unsupported feature: Property Deletion (PromotedOnly) on "AddUsers(Action 10)".

//     }


//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//     /*
//     SelectedCompany := COMPANYNAME;
//     UpdateCompany;
//     */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//     /*
//     SETRANGE("Company Name",Company.Name);
//     */
//     //end;

//     //Unsupported feature: Property Deletion (InsertAllowed).


//     //Unsupported feature: Property Deletion (DelayedInsert).

// }
