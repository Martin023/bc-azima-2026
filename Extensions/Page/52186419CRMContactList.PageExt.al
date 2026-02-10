// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186419 pageextension52186419 extends "CRM Contact List" 
// {
//     Caption = 'Microsoft Dynamics CRM Contacts';
//     layout
//     {
//         modify(FullName)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Address1_Line1")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Address1_Line2")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Address1_PostalCode")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Address1_City")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Address1_Country")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(EMailAddress1)
//         {
//             Caption = 'E-Mail Address';
//             ApplicationArea = Basic;
//         }
//         modify(Fax)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(WebSiteUrl)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(MobilePhone)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Pager)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Telephone1)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Coupled)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "FullName(Control 4)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Address1_Line1"(Control 5)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Address1_Line2"(Control 6)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Address1_PostalCode"(Control 7)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Address1_City"(Control 8)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Address1_Country"(Control 9)".


//         //Unsupported feature: Property Deletion (ExtendedDatatype) on "EMailAddress1(Control 10)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "EMailAddress1(Control 10)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Fax(Control 11)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "WebSiteUrl(Control 12)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "MobilePhone(Control 13)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Pager(Control 14)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Telephone1(Control 15)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Coupled(Control 3)".

//     }
//     actions
//     {
//         modify(CreateFromCRM)
//         {
//             Caption = 'Create Contact in Dynamics NAV';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (Visible) on "CreateFromCRM(Action 21)".

//         }

//         //Unsupported feature: Code Modification on "CreateFromCRM(Action 21).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             CurrPage.SETSELECTIONFILTER(CRMContact);
//             CRMIntegrationManagement.CreateNewRecordsFromCRM(CRMContact);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             CurrPage.SETSELECTIONFILTER(CRMContact);
//             CRMContact.NEXT;

//             IF CRMContact.COUNT = 1 THEN
//               CRMIntegrationManagement.CreateNewRecordFromCRM(CRMContact.ContactId,DATABASE::Contact)
//             ELSE BEGIN
//               CRMContactRecordRef.GETTABLE(CRMContact);
//               CRMIntegrationManagement.CreateNewRecordsFromCRM(CRMContactRecordRef);
//             END
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "CreateFromCRM(Action 21)".

//     }

//     var
//         CRMContactRecordRef: RecordRef;

//     var
//         AllowCreateFromCRM: Boolean;

//     //Unsupported feature: Property Deletion (Attributes) on "SetCurrentlyCoupledCRMContact(PROCEDURE 2)".


//     procedure SetAllowCreateFromCRM(Allow: Boolean)
//     begin
//         AllowCreateFromCRM := Allow;
//     end;

//     //Unsupported feature: Property Deletion (ApplicationArea).


//     //Unsupported feature: Property Deletion (UsageCategory).

// }
