// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186145 pageextension52186145 extends "Bank Name - Data Conv. List" 
// {
//     layout
//     {
//         modify(Bank)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Bank Name")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Country/Region Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Last Update Date")
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Bank(Control 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Name"(Control 4)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 5)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Last Update Date"(Control 8)".

//     }
//     actions
//     {
//         modify(UpdateBankList)
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (RunPageMode) on "UpdateBankList(Action 6)".

//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "UpdateBankList(Action 6)".

//     }
//     var
//         BankDataConvBank: Record "Bank Data Conv. Bank";


//     //Unsupported feature: Code Insertion (VariableCollection) on "OnOpenPage".

//     //trigger (Variable: BankDataConvBank)()
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
//         CountryRegionCode := IdentifyCountryRegionCode(Rec,GETFILTER("Country/Region Code"));

//         IF ISEMPTY THEN BEGIN
//           ImpBankListExtDataHndl.GetBankListFromConversionService(HideErrors,CountryRegionCode,ShortTimeout);
//           EXIT;
//         END;

//         RefreshBankNamesOlderThanToday(CountryRegionCode,HideErrors,ShortTimeout);
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         CountryRegionCode := IdentifyCountryRegionCode(Rec,GETFILTER("Country/Region Code"));

//         IF BankDataConvBank.ISEMPTY THEN BEGIN
//         #4..8
//         */
//     //end;
// }
