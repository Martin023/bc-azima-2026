// xmlport 52187161 "Mbanking Whitelist App."
// {
//     Caption = 'Mbanking Whitelist App.';
//     Format = VariableText;
//     FormatEvaluate = Legacy;
//     Direction = Both;

//     schema
//     {
//         textelement(RootNodeName)
//         {
//             tableelement(MBankingWhitelistApp; "M-Banking Whitelist App")
//             {
//                 fieldelement(No; MBankingWhitelistApp."No.")
//                 {
//                     MinOccurs = Once;
//                     MaxOccurs = Once;
//                 }
//                 fieldelement(FullNames; MBankingWhitelistApp."Full Names")
//                 {
//                     MinOccurs = Once;
//                 }
//                 fieldelement(PrimaryIdentificationType; MBankingWhitelistApp."Primary Identification Type")
//                 {
//                     MinOccurs = Once;
//                 }
//                 fieldelement(PrimaryIdentification; MBankingWhitelistApp."Primary Identification")
//                 {
//                     MinOccurs = Once;
//                 }
//                 fieldelement(TransactionalMobileNo; MBankingWhitelistApp."Transactional Mobile No.")
//                 {
//                     MinOccurs = Once;
//                     MaxOccurs = Once;
//                 }
//                 fieldelement(WhitelistReferenceID; MBankingWhitelistApp."Whitelist Reference ID")
//                 {
//                     MinOccurs = Once;
//                     MaxOccurs = Once;
//                 }

//                 trigger OnBeforeModifyRecord()
//                 begin
//                     MBankingWhitelistApp.TestField(Status, MBankingWhitelistApp.Status::Approved);
//                     MBankingWhitelistApp.TestField("Is Whitelisted", false);
//                 end;

//                 trigger OnAfterModifyRecord()
//                 begin
//                     MBankingWhitelistApp."Is Whitelisted" := true;
//                 end;
//             }
//         }
//     }

//     trigger OnPostXmlPort()
//     begin
//         Message('Bulk update of approved and whitelisted applications is complete');
//     end;
// }
