// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186184 pageextension52186184 extends "Posted Return Receipt - Update" 
// {

//     //Unsupported feature: Property Modification (Name) on ""Posted Return Receipt - Update"(Page 1353)".

//     Caption = 'Fixed Assets Setup';

//     //Unsupported feature: Property Modification (SourceTable) on ""Posted Return Receipt - Update"(Page 1353)".


//     //Unsupported feature: Property Insertion (PromotedActionCategoriesML) on ""Posted Return Receipt - Update"(Page 1353)".

//     layout
//     {
//         modify(Control1)
//         {

//             //Unsupported feature: Property Modification (Level) on "Control1(Control 1)".


//             //Unsupported feature: Property Modification (ControlType) on "Control1(Control 1)".


//             //Unsupported feature: Property Modification (Name) on "Control1(Control 1)".

//             Caption = 'General';
//         }
//         modify(General)
//         {

//             //Unsupported feature: Property Modification (Level) on "General(Control 2)".


//             //Unsupported feature: Property Modification (ControlType) on "General(Control 2)".


//             //Unsupported feature: Property Modification (Name) on "General(Control 2)".


//             //Unsupported feature: Property Insertion (SourceExpr) on "General(Control 2)".

//             ApplicationArea = Basic;
//         }
//         modify("Sell-to Customer Name")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Sell-to Customer Name"(Control 4)".


//             //Unsupported feature: Property Modification (Name) on ""Sell-to Customer Name"(Control 4)".

//         }
//         modify("Bill-to County")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Bill-to County"(Control 6)".


//             //Unsupported feature: Property Modification (Name) on ""Bill-to County"(Control 6)".

//         }
//         modify("Shipping Agent Code")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Shipping Agent Code"(Control 8)".


//             //Unsupported feature: Property Modification (Name) on ""Shipping Agent Code"(Control 8)".

//         }

//         //Unsupported feature: Property Deletion (ContainerType) on "Control1(Control 1)".


//         //Unsupported feature: Property Deletion (GroupType) on "General(Control 2)".

//         modify("No.")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on ""Sell-to Customer Name"(Control 4)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Customer Name"(Control 4)".


//         //Unsupported feature: Property Deletion (Editable) on ""Sell-to Customer Name"(Control 4)".

//         modify("Posting Date")
//         {
//             Visible = false;
//         }
//         modify(Invoicing)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (Editable) on ""Bill-to County"(Control 6)".

//         modify("Bill-to Country/Region Code")
//         {
//             Visible = false;
//         }
//         modify(Shipping)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on ""Shipping Agent Code"(Control 8)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Code"(Control 8)".


//         //Unsupported feature: Property Deletion (Editable) on ""Shipping Agent Code"(Control 8)".

//         modify("Package Tracking No.")
//         {
//             Visible = false;
//         }
//         addfirst(content)
//         {
//         }
//         addafter(General)
//         {
//             group(Numbering)
//             {
//                 Caption = 'Numbering';
//                 field("Fixed Asset Nos.";"Fixed Asset Nos.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
// Page "Depreciation Book List";
//                 ToolTip = 'Set up depreciation books for various depreciation purposes, such as tax and financial statements.';
// Page "Depreciation Table List";
//                 ToolTip = 'Set up the different depreciation methods that you will use to depreciate fixed assets.';
// Page "FA Classes";
//                 ToolTip = 'Set up different asset classes, such as Tangible Assets and Intangible Assets, to group your fixed assets by categories.';
// Page "FA Subclasses";
//                 ToolTip = 'Set up different asset subclasses, such as Plant and Property and Machinery and Equipment, that you can assign to fixed assets and insurance policies.';
// Page "FA Locations";
//                 ToolTip = 'Set up different locations, such as a warehouse or a location within a warehouse, that you can assign to fixed assets.';
// Page "FA Posting Type Setup";
//                     ToolTip = 'Define how to handle the Write-Down, Appreciation, Custom 1, and Custom 2 posting types that you use when posting to fixed assets.';
// Page "FA Posting Groups";
//                     ToolTip = 'Set up the accounts to which transactions are posted for fixed assets for each posting group, so that you can assign them to the relevant fixed assets.';
// Page "FA Journal Templates";
//                     ToolTip = 'Set up number series and reason codes in the journals that you use for fixed asset posting. By using different templates you can design windows with different layouts and you can assign trace codes, number series, and reports to each template.';
// Page "FA Reclass. Journal Templates";
//                     ""
