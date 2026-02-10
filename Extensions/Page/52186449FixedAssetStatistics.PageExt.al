// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186449 pageextension52186449 extends "Fixed Asset Statistics" 
// {
//     layout
//     {
//         modify("Acquisition Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("G/L Acquisition Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Disposed)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Disposal Date")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Visible) on ""Disposal Date"(Control 61)".

//         }
//         modify("Proceeds on Disposal")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Visible) on ""Proceeds on Disposal"(Control 57)".

//         }
//         modify("Gain/Loss")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Visible) on ""Gain/Loss"(Control 58)".

//         }
//         modify(DisposalValue)
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "DisposalValue(Control 4)".

//         }
//         modify("Last Acquisition Cost Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Last Depreciation Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Last Write-Down Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Last Appreciation Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Last Custom 1 Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Last Salvage Value Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Last Custom 2 Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Acquisition Cost")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Depreciation)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Write-Down")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Appreciation)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Custom 1")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Salvage Value")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Custom 2")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Control2)
//         {

//             //Unsupported feature: Property Modification (Level) on "Control2(Control 2)".


//             //Unsupported feature: Property Modification (ControlType) on "Control2(Control 2)".


//             //Unsupported feature: Property Modification (Name) on "Control2(Control 2)".

//             Caption = 'Book Value';

//             //Unsupported feature: Property Insertion (SourceExpr) on "Control2(Control 2)".


//             //Unsupported feature: Property Insertion (Visible) on "Control2(Control 2)".

//             ApplicationArea = Basic;
//         }
//         modify("Book Value")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Name) on ""Book Value"(Control 34)".

//         }
//         modify("Depreciable Basis")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Name) on ""Depreciable Basis"(Control 38)".

//         }
//         modify(Maintenance)
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Name) on "Maintenance(Control 43)".

//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Acquisition Date"(Control 59)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Acquisition Date"(Control 60)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Disposed(Control 62)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Disposal Date"(Control 61)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Proceeds on Disposal"(Control 57)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Gain/Loss"(Control 58)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "DisposalValue(Control 4)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Last Acquisition Cost Date"(Control 17)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Last Depreciation Date"(Control 19)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Last Write-Down Date"(Control 20)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Last Appreciation Date"(Control 21)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Last Custom 1 Date"(Control 22)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Last Salvage Value Date"(Control 40)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Last Custom 2 Date"(Control 45)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Acquisition Cost"(Control 24)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Depreciation(Control 26)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Write-Down"(Control 28)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Appreciation(Control 30)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Custom 1"(Control 32)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Salvage Value"(Control 36)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Custom 2"(Control 41)".


//         //Unsupported feature: Property Deletion (GroupType) on "Control2(Control 2)".

//         modify(Control3)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Book Value"(Control 34)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Depreciable Basis"(Control 38)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Maintenance(Control 43)".

//         addafter("Acquisition Date")
//         {
//             field(Text000;Text000)
//             {
//                 ApplicationArea = Basic;
//                 Visible = false;
//             }
//         }
//         addafter("G/L Acquisition Date")
//         {
//             field(Control9;Text000)
//             {
//                 ApplicationArea = Basic;
//                 Visible = false;
//             }
//             field(Control10;Text000)
//             {
//                 ApplicationArea = Basic;
//                 Visible = false;
//             }
//         }
//         addafter("Disposal Date")
//         {
//             field(Control11;Text000)
//             {
//                 ApplicationArea = Basic;
//                 Visible = false;
//             }
//         }
//         addafter("Proceeds on Disposal")
//         {
//             field(Control12;Text000)
//             {
//                 ApplicationArea = Basic;
//                 Visible = false;
//             }
//         }
//         addafter("Gain/Loss")
//         {
//             field(Control13;Text000)
//             {
//                 ApplicationArea = Basic;
//                 Visible = false;
//             }
//         }
//         addafter(DisposalValue)
//         {
//             field(Control14;Text000)
//             {
//                 ApplicationArea = Basic;
//                 Visible = false;
//             }
//         }
//         addfirst("Last Salvage Value Date")
//         {
//             field("Depreciable Basis";Text000)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Depreciable Basis';
//                 Visible = false;
//             }
//         }
//         addafter("Last Custom 2 Date")
//         {
//             field(Maintenance;Text000)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Maintenance';
//                 Visible = false;
//             }
//         }
//         moveafter("Last Custom 1 Date";Control2)
//         moveafter("Custom 1";"Book Value")
//         moveafter("Salvage Value";"Depreciable Basis")
//     }

//     var
//         BookValueAfterDisposal: Decimal;
//         Text000: label 'Placeholder';

//     var
//         
//         "Proceeds on DisposalVisible": Boolean;
//         
//         "Gain/LossVisible": Boolean;
//         
//         "Disposal DateVisible": Boolean;


//     //Unsupported feature: Code Modification on "OnAfterGetRecord".

//     //trigger OnAfterGetRecord()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         Disposed := "Disposal Date" > 0D;
//         DisposalValueVisible := Disposed;
//         ProceedsOnDisposalVisible := Disposed;
//         GainLossVisible := Disposed;
//         DisposalDateVisible := Disposed;
//         CalcBookValue;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         Disposed := "Disposal Date" > 0D;
//         DisposalValueVisible := Disposed;
//         "Proceeds on DisposalVisible" := Disposed;
//         "Gain/LossVisible" := Disposed;
//         "Disposal DateVisible" := Disposed;
//         CalcBookValue;
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnInit".

//     //trigger OnInit()
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         DisposalDateVisible := TRUE;
//         GainLossVisible := TRUE;
//         ProceedsOnDisposalVisible := TRUE;
//         DisposalValueVisible := TRUE;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         "Disposal DateVisible" := TRUE;
//         "Gain/LossVisible" := TRUE;
//         "Proceeds on DisposalVisible" := TRUE;
//         DisposalValueVisible := TRUE;
//         */
//     //end;
// }
