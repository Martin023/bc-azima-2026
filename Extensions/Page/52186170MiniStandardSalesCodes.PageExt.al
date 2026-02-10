// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186170 pageextension52186170 extends "Dynamics CRM Admin Credentials" 
// {

//     //Unsupported feature: Property Modification (Name) on ""Dynamics CRM Admin Credentials"(Page 1313)".

//     Caption = 'Recurring Sales Lines';

//     //Unsupported feature: Property Modification (SourceTable) on ""Dynamics CRM Admin Credentials"(Page 1313)".


//     //Unsupported feature: Property Modification (PageType) on ""Dynamics CRM Admin Credentials"(Page 1313)".


//     //Unsupported feature: Property Insertion (CardPageID) on ""Dynamics CRM Admin Credentials"(Page 1313)".

//     layout
//     {

//         //Unsupported feature: Property Modification (Level) on "Control1(Control 1)".


//         //Unsupported feature: Property Modification (ControlType) on "Control1(Control 1)".


//         //Unsupported feature: Property Insertion (GroupType) on "Control1(Control 1)".

//         modify(Password)
//         {

//             //Unsupported feature: Property Modification (Level) on "Password(Control 4)".


//             //Unsupported feature: Property Modification (Name) on "Password(Control 4)".

//             ToolTip = 'Specifies a description of the standard sales code.';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "Password(Control 4)".

//         }
//         modify(InvalidUserMessage)
//         {

//             //Unsupported feature: Property Modification (Level) on "InvalidUserMessage(Control 2)".


//             //Unsupported feature: Property Modification (Name) on "InvalidUserMessage(Control 2)".

//             ApplicationArea = Basic;
//             ToolTip = 'Specifies a code which identifies this standard sales code.';

//             //Unsupported feature: Property Insertion (SourceExpr) on "InvalidUserMessage(Control 2)".

//         }

//         //Unsupported feature: Property Deletion (ContainerType) on "Control1(Control 1)".

//         modify("Specify the account that must be used to import the solution.")
//         {
//             Visible = false;
//         }
//         modify(Email)
//         {
//             Visible = false;
//         }
//         modify(Password)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ExtendedDatatype) on "Password(Control 4)".


//         //Unsupported feature: Property Deletion (CaptionML) on "InvalidUserMessage(Control 2)".

//         addfirst(content)
//         {
//         }
//         addfirst(Password)
//         {
//             field("Currency Code";"Currency Code")
//             {
//                 ApplicationArea = Basic;
//                 ToolTip = 'Specifies the code for the currency of the amounts on the standard sales lines.';
//                 Visible = false;
//             }
//         }
//         moveafter(Control1;InvalidUserMessage)
//     }

//     //Unsupported feature: Property Deletion (Permissions).


//     //Unsupported feature: Property Deletion (SourceTableTemporary).

// }
