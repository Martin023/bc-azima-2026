// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186183 pageextension52186183 extends "Posted Return Shpt. - Update"
// {

//     //Unsupported feature: Property Modification (Name) on ""Posted Return Shpt. - Update"(Page 1352)".

//     Caption = 'Company Information';

//     //Unsupported feature: Property Modification (SourceTable) on ""Posted Return Shpt. - Update"(Page 1352)".


//     //Unsupported feature: Property Insertion (PromotedActionCategoriesML) on ""Posted Return Shpt. - Update"(Page 1352)".

//     layout
//     {
//         // modify(Control1)
//         // {

//         //     //Unsupported feature: Property Modification (Level) on "Control1(Control 1)".


//         //     //Unsupported feature: Property Modification (ControlType) on "Control1(Control 1)".


//         //     //Unsupported feature: Property Modification (Name) on "Control1(Control 1)".


//         //     //Unsupported feature: Property Insertion (Lookup) on "Control1(Control 1)".

//         //     Caption = 'Bank Account Posting Group';

//         //     //Unsupported feature: Property Insertion (SourceExpr) on "Control1(Control 1)".


//         //     //Unsupported feature: Property Insertion (TableRelation) on "Control1(Control 1)".

//         //     ApplicationArea = Basic;
//         // }
//         // modify(General)
//         // {

//         //     //Unsupported feature: Property Modification (Level) on "General(Control 2)".


//         //     //Unsupported feature: Property Modification (ControlType) on "General(Control 2)".


//         //     //Unsupported feature: Property Modification (Name) on "General(Control 2)".

//         //     //ToolTip = 'Specifies if you are allowed to create a sales invoice without filling the setup fields on this FastTab. If you select this check box, then you will not be warned about missing payment-setup values when you create a sales invoice.';

//         //     //Unsupported feature: Property Insertion (SourceExpr) on "General(Control 2)".

//         //    // ApplicationArea = Basic;
//         // }
//         modify("No.")
//         {
//             ToolTip = 'Contains the international bank account number of your primary bank account.';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""No."(Control 3)".


//             //Unsupported feature: Property Modification (Name) on ""No."(Control 3)".

//             ShowMandatory = BankBranchNoOrAccountNoMissing;
//         }
//         modify("Buy-from Vendor Name")
//         {
//             ToolTip = 'Contains the SWIFT code (international bank identifier code) of your primary bank.';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Buy-from Vendor Name"(Control 4)".


//             //Unsupported feature: Property Modification (Name) on ""Buy-from Vendor Name"(Control 4)".

//         }
//         modify("Posting Date")
//         {
//             ToolTip = 'Specifies the company''s giro number.';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Posting Date"(Control 5)".


//             //Unsupported feature: Property Modification (Name) on ""Posting Date"(Control 5)".

//         }
//         // modify(Shipping)
//         // {

//         //     //Unsupported feature: Property Modification (Level) on "Shipping(Control 8)".


//         //     //Unsupported feature: Property Modification (ControlType) on "Shipping(Control 8)".


//         //     //Unsupported feature: Property Modification (Name) on "Shipping(Control 8)".

//         //     ToolTip = 'Specifies the bank''s branch number.';

//         //     //Unsupported feature: Property Insertion (SourceExpr) on "Shipping(Control 8)".

//         //     //ShowMandatory = IBANMissing;
//         //    // ApplicationArea = Basic;
//         // }
//         modify("Ship-to County")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Ship-to County"(Control 6)".


//             //Unsupported feature: Property Modification (Name) on ""Ship-to County"(Control 6)".

//             ToolTip = 'Specifies the company''s payment routing number.';
//         }
//         modify("Ship-to Country/Region Code")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Ship-to Country/Region Code"(Control 7)".


//             //Unsupported feature: Property Modification (Name) on ""Ship-to Country/Region Code"(Control 7)".

//             ToolTip = 'Specifies the company''s bank account number.';
//             ShowMandatory = IBANMissing;
//         }

//         //Unsupported feature: Property Deletion (ContainerType) on "Control1(Control 1)".


//         //Unsupported feature: Property Deletion (GroupType) on "General(Control 2)".


//         //Unsupported feature: Code Insertion on "IBAN(Control 3)".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //begin
//         /*
//         SetShowMandatoryContitions
//         */
//         //end;

//         //Unsupported feature: Property Deletion (Editable) on ""No."(Control 3)".



//         //Unsupported feature: Code Insertion on ""SWIFT Code"(Control 4)".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //begin
//         /*
//         SetShowMandatoryContitions
//         */
//         //end;

//         //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Vendor Name"(Control 4)".


//         //Unsupported feature: Property Deletion (Editable) on ""Buy-from Vendor Name"(Control 4)".


//         //Unsupported feature: Property Deletion (Editable) on ""Posting Date"(Control 5)".



//         //Unsupported feature: Code Insertion on ""Bank Branch No."(Control 8)".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //begin
//         /*
//         SetShowMandatoryContitions
//         */
//         //end;

//         //Unsupported feature: Property Deletion (CaptionML) on "Shipping(Control 8)".


//         //Unsupported feature: Property Deletion (GroupType) on "Shipping(Control 8)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to County"(Control 6)".


//         //Unsupported feature: Property Deletion (Editable) on ""Ship-to County"(Control 6)".



//         //Unsupported feature: Code Insertion on ""Bank Account No."(Control 7)".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //begin
//         /*
//         SetShowMandatoryContitions
//         */
//         //end;

//         //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Country/Region Code"(Control 7)".


//         //Unsupported feature: Property Deletion (Editable) on ""Ship-to Country/Region Code"(Control 7)".

//         addfirst(content)
//         {
//             group("Contact Details")
//             {
//                 Caption = 'Contact Details';
//             }
//             field(Name; Name)
//             {
//                 ApplicationArea = Basic;
//                 ShowMandatory = true;
//                 ToolTip = 'Specifies the company''s name and corporate form, for example, Inc. or Ltd.';
//             }
//             field(Address; Address)
//             {
//                 ApplicationArea = Basic;
//                 ShowMandatory = true;
//                 ToolTip = 'Specifies the company''s address.';
//             }
//             field("Address 2"; "Address 2")
//             {
//                 ApplicationArea = Basic;
//                 ToolTip = 'Specifies an additional part of the company''s address.';
//             }
//             field("Post Code"; "Post Code")
//             {
//                 ApplicationArea = Basic;
//                 ShowMandatory = true;
//                 ToolTip = 'Contains the company''s post code.';
//             }
//             field(City; City)
//             {
//                 ApplicationArea = Basic;
//                 ShowMandatory = true;
//                 ToolTip = 'Contains the company''s city.';
//             }
//             field("Country/Region Code"; "Country/Region Code")
//             {
//                 ApplicationArea = Basic;
//                 ShowMandatory = true;
//                 ToolTip = 'Specifies the country/region code for your company. To see the country/region codes in the Country/Region table, choose the field.';
//             }
//             field("Phone No."; "Phone No.")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Phone No.';
//                 ToolTip = 'Specifies the company''s telephone number.';
//             }
//             field("VAT Registration No."; "VAT Registration No.")
//             {
//                 ApplicationArea = Basic;
//                 ToolTip = 'Specifies the company''s VAT registration number.';
//             }
//             field(GLN; GLN)
//             {
//                 ApplicationArea = Basic;
//                 ToolTip = 'Identifies your company in connection with electronic document exchange. For example, when sending documents in the PEPPOL file format, the value in this field is used to populate the EndPointID element in the Supplier group. The number is based on the GS1 standard, which is compliant with ISO 6523.';
//             }
//             field("E-Mail"; "E-Mail")
//             {
//                 ApplicationArea = Basic;
//                 ToolTip = 'Specifies the company''s email address. You can enter a maximum of 80 characters, both numbers and letters.';
//             }
//             field("Home Page"; "Home Page")
//             {
//                 ApplicationArea = Basic;
//                 ToolTip = 'Specifies the company''s home page address. You can enter a maximum of 80 characters, both numbers and letters.';
//             }
//             field(Picture; Picture)
//             {
//                 ApplicationArea = Basic;
//                 ToolTip = 'Shows the picture that has been set up for the company; a company logo, for example.';
//             }
//             group("Bank Account Details")
//             {
//                 Caption = 'Bank Account Details';
//             }
//             field("Bank Name"; "Bank Name")
//             {
//                 ApplicationArea = Basic;
//                 ShowMandatory = true;
//                 ToolTip = 'Specifies the name of the bank the company uses.';
//             }
//         }
//         moveafter(; Shipping)
//         moveafter("Bank Branch No."; "Ship-to Country/Region Code")
//         moveafter("Bank Account No."; "Ship-to County")
//         moveafter("Payment Routing No."; "Posting Date")
//         moveafter("Giro No."; "Buy-from Vendor Name")
//         moveafter("SWIFT Code"; "No.")
//         moveafter(Iban; General)
//     }
//     actions
//     {

//         addfirst(navigation)
//         {
//             action(Users)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Users';
//                 Image = Users;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                 RunObject = Page Users;
//                 ToolTip = 'Set up the employees who will work in Microsoft Dynamics NAV.';
//             }
//             action("Permission Sets")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Permission Sets';
//                 Image = Permission;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                 RunObject = Page "Permission Sets";
//                 ToolTip = 'Define which feature objects that users need to access and set up the related permissions in permission sets that you can assign to the users of the database.';
//             }
//             action(Currencies)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Currencies';
//                 Image = Currencies;
//                 Promoted = true;
//                 PromotedCategory = Category5;
//                 PromotedIsBig = true;
//                 RunObject = Page Currencies;
//                 ToolTip = 'Set up the different currencies that you trade in by defining which general ledger accounts the involved transactions are posted to and how the foreign currency amounts are rounded.';
//             }
//             action("No. Series")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'No. Series';
//                 Image = NumberSetup;
//                 Promoted = true;
//                 PromotedCategory = Category6;
//                 PromotedIsBig = true;
//                 RunObject = Page "No. Series";
//                 ToolTip = 'Set up the number series from which a new number is automatically assigned to new cards and documents, such as item cards and sales invoices.';
//             }
//             action("Report Layouts")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Report Layouts';
//                 Image = "Report";
//                 Promoted = true;
//                 PromotedCategory = "Report";
//                 RunObject = Page "Report Layout Selection";
//             }
//             action("SMTP Mail Setup")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'SMTP Mail Setup';
//                 Image = MailSetup;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                 RunObject = Page "SMTP Mail Setup";
//                 ToolTip = 'Set up the integration and security of the mail server at your site that handles email.';
//             }
//             group("Regional Settings")
//             {
//                 Caption = 'Regional Settings';
//                 action("Countries/Regions")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Countries/Regions';
//                     Image = CountryRegion;
//                     Promoted = true;
//                     PromotedCategory = Category7;
//                     PromotedIsBig = true;
//                     RunObject = Page "Countries/Regions";
//                     ToolTip = 'Set up the country/regions where your different business partners are located, so that you can assign Country/Region codes to business partners where special local procedures are required.';
//                 }
//                 action("Post Codes")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Post Codes';
//                     Image = MailSetup;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedIsBig = true;
//                     RunObject = Page "Post Codes";
//                     ToolTip = 'Set up the post codes of cities where your business partners are located.';
//                 }
//                 action("Online Map Setup")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Online Map Setup';
//                     Image = MapSetup;
//                     Promoted = true;
//                     PromotedCategory = Category7;
//                     PromotedIsBig = true;
//                     RunObject = Page "Online Map Setup";
//                     ToolTip = 'Define which map provider to use and how routes and distances are displayed when you choose the Online Map field on business documents.';
//                 }
//                 action(Languages)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Languages';
//                     Image = Language;
//                     Promoted = true;
//                     PromotedCategory = Category7;
//                     PromotedIsBig = true;
//                     RunObject = Page Languages;
//                     ToolTip = 'Set up the languages that are spoken by your different business partners, so that you can print item names or descriptions in the appropriate language.';
//                 }
//             }
//             group(Codes)
//             {
//                 Caption = 'Codes';
//                 action("Source Codes")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Source Codes';
//                     Image = CodesList;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedIsBig = true;
//                     RunObject = Page "Source Codes";
//                     ToolTip = 'Set up codes for your different types of business transactions, so that you can track the source of the transactions in an audit.';
//                 }
//                 action("Reason Codes")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Reason Codes';
//                     Image = CodesList;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedIsBig = true;
//                     RunObject = Page "Reason Codes";
//                     ToolTip = 'Set up codes that specify reasons why entries were created, such as Return, to specify why a purchase credit memo was posted.';
//                 }
//             }
//         }
//     }

//     var
//         MiniCompanyInformationMgt: Codeunit "Company Information Mgt.";
//         BankAcctPostingGroup: Code[10];
//         IBANMissing: Boolean;
//         BankBranchNoOrAccountNoMissing: Boolean;


//     //Unsupported feature: Code Insertion on "OnClosePage".

//     //trigger OnClosePage()
//     //begin
//     /*
//     MiniCompanyInformationMgt.UpdateCompanyBankAccount(Rec,BankAcctPostingGroup);
//     */
//     //end;


//     //Unsupported feature: Code Insertion on "OnInit".

//     //trigger OnInit()
//     //Parameters and return type have not been exported.
//     //begin
//     /*
//     SetShowMandatoryContitions
//     */
//     //end;


//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//     /*
//     xReturnShipmentHeader := Rec;
//     */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//     /*
//     RESET;
//     IF NOT GET THEN BEGIN
//       INIT;
//       INSERT;
//     END ELSE
//       BankAcctPostingGroup := MiniCompanyInformationMgt.GetCompanyBankAccountPostingGroup;
//     */
//     //end;

//     local procedure SetShowMandatoryContitions()
//     begin
//         BankBranchNoOrAccountNoMissing := ("Bank Branch No." = '') or ("Bank Account No." = '');
//         IBANMissing := Iban = ''
//     end;

//     //Unsupported feature: Property Deletion (Editable).


//     //Unsupported feature: Property Deletion (ModifyAllowed).


//     //Unsupported feature: Property Deletion (SourceTableTemporary).


//     //Unsupported feature: Property Deletion (ShowFilter).

// }

