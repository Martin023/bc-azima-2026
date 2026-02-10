// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52187081 pageextension52187081 extends "Delete User Personalization" 
// {
//     layout
//     {
//         modify("User SID")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("User ID")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Page ID")
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""User SID"(Control 1106000001)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 1106000003)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Page ID"(Control 1106000005)".

//         modify(Description)
//         {
//             Visible = false;
//         }
//         modify("Legacy Personalization")
//         {
//             Visible = false;
//         }
//         modify(Date)
//         {
//             Visible = false;
//         }
//         modify(Time)
//         {
//             Visible = false;
//         }
//         addafter("Page ID")
//         {
//             field(Description;Description)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Description';
//             }
//             field(Date;Date)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Date';
//             }
//             field(Time;Time)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Time';
//             }
//         }
//     }

//     //Unsupported feature: Property Deletion (ApplicationArea).


//     //Unsupported feature: Property Deletion (UsageCategory).


//     //Unsupported feature: Property Deletion (SourceTableTemporary).

// }
