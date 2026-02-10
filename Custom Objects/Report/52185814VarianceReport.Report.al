// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185814 "Variance Report"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Variance Report.rdl';

//     dataset
//     {
//         dataitem("Company Information"; "Company Information")
//         {
//             DataItemTableView = sorting("Primary Key") order(ascending);
//             column(ReportForNavId_11; 11)
//             {
//             }
//             column(Name_CompanyInformation; "Company Information".Name)
//             {
//             }
//             column(Address_CompanyInformation; "Company Information".Address)
//             {
//             }
//             column(Picture_CompanyInformation; "Company Information".Picture)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 "Company Information".CalcFields("Company Information".Picture);
//             end;
//         }
//         dataitem("G/L Account"; "G/L Account")
//         {
//             RequestFilterFields = "Date Filter", "No.", "Expense Code";
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(No_GLAccount; "G/L Account"."No.")
//             {
//             }
//             column(Name_GLAccount; "G/L Account".Name)
//             {
//             }
//             column(AccountType_GLAccount; "G/L Account"."Account Type")
//             {
//             }
//             dataitem("G/L Entry"; "G/L Entry")
//             {
//                 DataItemLink = "G/L Account No." = field("No."), "Posting Date" = field("Date Filter");
//                 DataItemTableView = sorting("Entry No.");
//                 column(ReportForNavId_3; 3)
//                 {
//                 }
//                 column(Amount_GLEntry; "G/L Entry".Amount)
//                 {
//                 }

//                 trigger OnPreDataItem()
//                 begin
//                     //"G/L Entry".SetRange("G/L Entry"."Dimension Set ID", DimSetID);
//                 end;
//             }
//             dataitem("G/L Budget Entry"; "G/L Budget Entry")
//             {
//                 DataItemLink = "G/L Account No." = field("No."), Date = field("Date Filter");
//                 DataItemTableView = sorting("Entry No.");
//                 column(ReportForNavId_2; 2)
//                 {
//                 }
//                 column(Amount_GLBudgetEntry; "G/L Budget Entry".Amount)
//                 {
//                 }

//                 trigger OnPreDataItem()
//                 begin
//                     // "G/L Budget Entry".SetRange("G/L Budget Entry"."Dimension Set ID", DimSetID);
//                 end;
//             }
//             dataitem(52185867;52185867)
//             {
//                 DataItemLink = "G/L Account No."=field("No."),"Posting Date"=field("Date Filter");
//                 DataItemTableView = sorting("Line No.");
//                 column(ReportForNavId_4; 4)
//                 {
//                 }
//                 column(Amount_Committment;Committment.Amount)
//                 {
//                 }

//                 trigger OnPreDataItem()
//                 begin
//                     UnknownTable52185867.SetRange("Dimension Set ID",DimSetID);
//                 end;
//             }
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 group(Control2)
//                 {
//                     field(Dim1;Dim1)
//                     {
//                         ApplicationArea = Basic;
//                         CaptionClass = '1,2,1';
//                         TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
//                     }
//                     field(Dim2;Dim2)
//                     {
//                         ApplicationArea = Basic;
//                         CaptionClass = '1,2,2';
//                         TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
//                     }
//                     field(Dim3;Dim3)
//                     {
//                         ApplicationArea = Basic;
//                         CaptionClass = '1,2,3';
//                         TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(3));
//                     }
//                     field(Dim4;Dim4)
//                     {
//                         ApplicationArea = Basic;
//                         CaptionClass = '1,2,4';
//                         TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(4));
//                     }
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnPreReport()
//     begin
//         GetDimSetId();
//     end;

//     var
//         Dim1: Code[20];
//         Dim2: Code[20];
//         Dim3: Code[20];
//         Dim4: Code[20];
//         DimSetID: Integer;

//     local procedure GetDimSetId()
//     var
//         DimensionSetEntry: array [8] of Record "Dimension Set Entry";
//         GeneralLedgerSetup: Record "General Ledger Setup";
//         i: Integer;
//         TempDimension: Record "Temp Dimension";
//     begin
//         GeneralLedgerSetup.Get;
//         TempDimension.DeleteAll;
//         TempDimension.Init;
//         TempDimension."Dimension Code" := GeneralLedgerSetup."Shortcut Dimension 1 Code";
//         TempDimension."Dimension Value Code" := Dim1;
//         TempDimension.Insert(true);
//         TempDimension.Init;
//         TempDimension."Dimension Code" := GeneralLedgerSetup."Shortcut Dimension 2 Code";
//         TempDimension."Dimension Value Code" := Dim2;
//         TempDimension.Insert(true);
//         TempDimension.Init;
//         TempDimension."Dimension Code" := GeneralLedgerSetup."Shortcut Dimension 3 Code";
//         TempDimension."Dimension Value Code" := Dim3;
//         TempDimension.Insert(true);
//         TempDimension.Init;
//         TempDimension."Dimension Code" := GeneralLedgerSetup."Shortcut Dimension 4 Code";
//         TempDimension."Dimension Value Code" := Dim4;
//         if TempDimension.Insert(true) then
//           begin
//           end;
//         //FOR i := 1 TO 4 DO
//          begin
//           TempDimension.Reset;
//           if TempDimension.FindSet then
//            //MESSAGE('%1',MyGetDimensionSetID(TempDimension));

//             DimSetID := MyGetDimensionSetID(TempDimension)
//          end;
//     end;

//     local procedure MyGetDimensionSetID(var TempDimension: Record UnknownRecord52185893 temporary): Integer
//     var
//         DimensionManagement: Codeunit DimensionManagement;
//         DimensionSetEntry: Record "Dimension Set Entry" temporary;
//     begin
//         repeat
//           DimensionSetEntry.Init;
//           DimensionSetEntry."Dimension Set ID" := -1;
//           DimensionSetEntry."Dimension Code" := TempDimension."Dimension Code";
//           DimensionSetEntry."Dimension Value Code" := TempDimension."Dimension Value Code";
//           DimensionSetEntry.Insert(true);
//         until TempDimension.Next = 0;
//         exit(DimensionManagement.GetDimensionSetID(DimensionSetEntry));
//     end;
// }
