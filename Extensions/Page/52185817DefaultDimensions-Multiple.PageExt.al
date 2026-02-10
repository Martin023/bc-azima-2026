// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52185817 pageextension52185817 extends "Default Dimensions-Multiple" 
// {
//     layout
//     {
//         modify("Dimension Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Dimension Value Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Value Posting")
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension Code"(Control 2)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension Value Code"(Control 4)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Value Posting"(Control 6)".

//     }

//     //Unsupported feature: Code Modification on "SetCommonDefaultDim(PROCEDURE 2)".

//     //procedure SetCommonDefaultDim();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         SETRANGE(
//           "Multi Selection Action","Multi Selection Action"::Delete);
//         IF FIND('-') THEN
//         #4..21
//                   DefaultDim."Dimension Code" := "Dimension Code";
//                   DefaultDim."Dimension Value Code" := "Dimension Value Code";
//                   DefaultDim."Value Posting" := "Value Posting";
//                   OnBeforeSetCommonDefaultCopyFields(DefaultDim,Rec);
//                   DefaultDim.MODIFY(TRUE);
//                 END ELSE BEGIN
//                   DefaultDim.INIT;
//                   DefaultDim."Table ID" := TempDefaultDim3."Table ID";
//                   DefaultDim."No." := TempDefaultDim3."No.";
//                   DefaultDim."Dimension Code" := "Dimension Code";
//                   DefaultDim."Dimension Value Code" := "Dimension Value Code";
//                   DefaultDim."Value Posting" := "Value Posting";
//                   OnBeforeSetCommonDefaultCopyFields(DefaultDim,Rec);
//                   DefaultDim.INSERT(TRUE);
//                 END;
//               UNTIL TempDefaultDim3.NEXT = 0;
//           UNTIL NEXT = 0;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..24
//         #26..33
//         #35..38
//         */
//     //end;

//     //Unsupported feature: Property Deletion (Attributes) on "CopyDefaultDimToDefaultDim(PROCEDURE 14)".


//     //Unsupported feature: Property Insertion (Local) on "CopyDefaultDimToDefaultDim(PROCEDURE 14)".


//     //Unsupported feature: Property Deletion (Attributes) on "SetMultiEmployee(PROCEDURE 1)".


//     //Unsupported feature: Property Modification (Name) on "SetMultiEmployee(PROCEDURE 1)".



//     //Unsupported feature: Code Modification on "SetMultiEmployee(PROCEDURE 1)".

//     //procedure SetMultiEmployee();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         //DEPRECATED - TO BE REMOVED FOR FALL 19
//         ClearTempDefaultDim;
//         WITH Employee DO
//           IF FIND('-') THEN
//             REPEAT
//               CopyDefaultDimToDefaultDim(DATABASE::Employee,"No.");
//             UNTIL NEXT = 0;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         TempDefaultDim2.DELETEALL;
//         WITH GLAcc DO
//           IF FIND('-') THEN
//             REPEAT
//               CopyDefaultDimToDefaultDim(DATABASE::"G/L Account","No.");
//             UNTIL NEXT = 0;
//         */
//     //end;

//     procedure SetMultiCust(var Cust: Record Customer)
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if Cust.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::Customer,Cust."No.");
//             until Cust.Next = 0;
//     end;

//     procedure SetMultiVendor(var Vend: Record Vendor)
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if Vend.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::Vendor,Vend."No.");
//             until Vend.Next = 0;
//     end;

//     procedure SetMultiItem(var Item: Record Item)
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if Item.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::Item,Item."No.");
//             until Item.Next = 0;
//     end;

//     procedure SetMultiResGr(var ResGr: Record "Resource Group")
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if ResGr.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::"Resource Group",ResGr."No.");
//             until ResGr.Next = 0;
//     end;

//     procedure SetMultiResource(var Res: Record Resource)
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if Res.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::Resource,Res."No.");
//             until Res.Next = 0;
//     end;

//     procedure SetMultiJob(var Job: Record Job)
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if Job.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::Job,Job."No.");
//             until Job.Next = 0;
//     end;

//     procedure SetMultiBankAcc(var BankAcc: Record "Bank Account")
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if BankAcc.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::"Bank Account",BankAcc."No.");
//             until BankAcc.Next = 0;
//     end;

//     procedure SetMultiEmployee(var Employee: Record Employee)
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if Employee.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::Employee,Employee."No.");
//             until Employee.Next = 0;
//     end;

//     procedure SetMultiFA(var FA: Record "Fixed Asset")
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if FA.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::"Fixed Asset",FA."No.");
//             until FA.Next = 0;
//     end;

//     procedure SetMultiInsurance(var Insurance: Record Insurance)
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if Insurance.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::Insurance,Insurance."No.");
//             until Insurance.Next = 0;
//     end;

//     procedure SetMultiRespCenter(var RespCenter: Record "Responsibility Center")
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if RespCenter.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::"Responsibility Center",RespCenter.Code);
//             until RespCenter.Next = 0;
//     end;

//     procedure SetMultiSalesperson(var SalesPurchPerson: Record "Salesperson/Purchaser")
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if SalesPurchPerson.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::"Salesperson/Purchaser",SalesPurchPerson.Code);
//             until SalesPurchPerson.Next = 0;
//     end;

//     procedure SetMultiWorkCenter(var WorkCenter: Record "Work Center")
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if WorkCenter.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::"Work Center",WorkCenter."No.");
//             until WorkCenter.Next = 0;
//     end;

//     procedure SetMultiCampaign(var Campaign: Record Campaign)
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if Campaign.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::Campaign,Campaign."No.");
//             until Campaign.Next = 0;
//     end;

//     procedure SetMultiCustTemplate(var CustTemplate: Record "Customer Template")
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if CustTemplate.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::"Customer Template",CustTemplate.Code);
//             until CustTemplate.Next = 0;
//     end;

//     procedure SetMultiServiceItem(var ServiceItem: Record "Service Item")
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if ServiceItem.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::"Service Item",ServiceItem."No.");
//             until ServiceItem.Next = 0;
//     end;

//     procedure SetMultiServiceItemGroup(var ServiceItemGroup: Record "Service Item Group")
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if ServiceItemGroup.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::"Service Item Group",ServiceItemGroup.Code);
//             until ServiceItemGroup.Next = 0;
//     end;

//     procedure SetMultiServiceOrderType(var ServiceOrderType: Record "Service Order Type")
//     begin
//         TempDefaultDim2.DeleteAll;
//                   if ServiceOrderType.Find('-') then
//             repeat
//               CopyDefaultDimToDefaultDim(Database::"Service Order Type",ServiceOrderType.Code);
//             until ServiceOrderType.Next = 0;
//     end;

//     //Unsupported feature: Property Modification (Name) on "SetMultiEmployee(PROCEDURE 1).Employee(Parameter 1000)".


//     //Unsupported feature: Property Modification (Subtype) on "SetMultiEmployee(PROCEDURE 1).Employee(Parameter 1000)".

// }
