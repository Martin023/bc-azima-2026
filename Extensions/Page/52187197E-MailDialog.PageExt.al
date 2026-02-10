// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52187197 pageextension52187197 extends "Email Dialog" 
// {

//     //Unsupported feature: Property Modification (Name) on ""Email Dialog"(Page 9700)".

//     Caption = 'Send E-Mail';

//     //Unsupported feature: Property Insertion (SaveValues) on ""Email Dialog"(Page 9700)".

//     layout
//     {
//         modify(FromAddress)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(SendTo)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(CcText)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(BccText)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Subject)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Attachment Name")
//         {
//             ApplicationArea = Basic;
//             Editable = false;
//         }
//         modify(OutlookEdit)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ExtendedDatatype) on "FromAddress(Control 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "FromAddress(Control 3)".


//         //Unsupported feature: Property Deletion (Visible) on "FromAddress(Control 3)".


//         //Unsupported feature: Property Deletion (ExtendedDatatype) on "SendTo(Control 10)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "SendTo(Control 10)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "CcText(Control 4)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "BccText(Control 7)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Subject(Control 11)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Attachment Name"(Control 2)".


//         //Unsupported feature: Property Deletion (Enabled) on ""Attachment Name"(Control 2)".

//         modify(MessageContents)
//         {
//             Visible = false;
//         }
//         modify(Control14)
//         {
//             Visible = false;
//         }
//         modify(Control12)
//         {
//             Visible = false;
//         }
//         modify(BodyHTMLMessage)
//         {
//             Visible = false;
//         }
//         modify(Control13)
//         {
//             Visible = false;
//         }
//         modify(BodyText)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "OutlookEdit(Control 9)".

//         addafter("Attachment Name")
//         {
//             field(BodyText;BodyText)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Message';
//                 MultiLine = true;

//                 trigger OnValidate()
//                 begin
//                     EmailItem.SetBodyText(BodyText);
//                 end;
//             }
//         }
//     }


//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         OriginalFromEmail := OrigEmailItem."From Address";

//         IF NOT IsEditEnabled THEN
//           LocalEdit := FALSE;
//         IF ForceOutlook THEN
//           LocalEdit := TRUE;
//         IF NOT LocalEdit THEN
//           ShownFromEmail := OriginalFromEmail
//         ELSE
//           ShownFromEmail := '';

//         EmailItem.Subject := OrigEmailItem.Subject;
//         EmailItem."Attachment Name" := OrigEmailItem."Attachment Name";

//         InitBccCcText;
//         SendToText := OrigEmailItem."Send to";
//         IF OrigEmailItem."Send CC" <> '' THEN
//           CcText := OrigEmailItem."Send CC"
//         ELSE
//           EmailItem."Send CC" := CcText;
//         IF OrigEmailItem."Send BCC" <> '' THEN
//           BccText := OrigEmailItem."Send BCC"
//         ELSE
//           EmailItem."Send BCC" := BccText;

//         BodyText := '';

//         IF EmailItem."Plaintext Formatted" THEN
//           EmailItem."Message Type" := EmailItem."Message Type"::"Custom Message"
//         ELSE BEGIN
//           EmailItem."Body File Path" := OrigEmailItem."Body File Path";
//           FileManagement.BLOBImportFromServerFile(TempBlob,EmailItem."Body File Path");
//           EmailItem.Body := TempBlob.Blob;
//           EmailItem."Message Type" := EmailItem."Message Type"::"From Email Body Template";
//         END;

//         OrigMailBodyText := EmailItem.GetBodyText;
//         IF OrigMailBodyText <> '' THEN
//           BodyText := OrigMailBodyText
//         ELSE
//           EmailItem.SetBodyText(BodyText);

//         UpdatePlainTextVisible;
//         IsOfficeAddin := OfficeMgt.IsAvailable;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..10
//         WITH EmailItem DO BEGIN
//           Subject := OrigEmailItem.Subject;
//           SendToText := OrigEmailItem."Send to";
//           IF OrigEmailItem."Send CC" <> '' THEN
//             CcText := OrigEmailItem."Send CC"
//           ELSE
//             "Send CC" := CcText;
//           IF OrigEmailItem."Send BCC" <> '' THEN
//             BccText := OrigEmailItem."Send BCC"
//           ELSE
//             "Send BCC" := BccText;
//           "Attachment Name" := OrigEmailItem."Attachment Name";
//         END;
//         #37..41
//         EmailItem."Plaintext Formatted" := TRUE;
//         */
//     //end;

//     //Unsupported feature: Property Deletion (Attributes) on "SetValues(PROCEDURE 1)".



//     //Unsupported feature: Code Modification on "SetValues(PROCEDURE 1)".

//     //procedure SetValues();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         EmailItem := ParmEmailItem;
//         OrigEmailItem.COPY(ParmEmailItem);

//         ForceOutlook := ParmOutlookSupported AND NOT ParmSmtpSupported;
//         IsEditEnabled := ParmOutlookSupported AND (ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Windows);
//         IF NOT IsEditEnabled THEN
//           LocalEdit := FALSE
//         ELSE
//           LocalEdit := TRUE;

//         IF EmailItem."Attachment File Path" <> '' THEN
//           HasAttachment := TRUE;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..4
//         IsEditEnabled := ParmOutlookSupported AND (CURRENTCLIENTTYPE = CLIENTTYPE::Windows);
//         #6..12
//         */
//     //end;

//     //Unsupported feature: Property Deletion (Attributes) on "GetDoEdit(PROCEDURE 6)".


//     local procedure GetBodyText(): Text
//     begin
//         exit(BodyText);
//     end;
// }
