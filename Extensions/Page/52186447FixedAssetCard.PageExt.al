// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186447 pageextension52186447 extends "Fixed Asset Card"
{
    PromotedActionCategories = ',,,,EDMS';

    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
            Editable = false;
            Visible = true;
        }
        modify("FA Location Code")
        {
            ApplicationArea = Basic;
            //Editable = False;
        }
        modify("Responsible Employee")
        {
            ApplicationArea = All;
            visible = false;
            // Do not use this field
        }
        modify(Description)
        {
            ApplicationArea = Basic;
            //Editable = false;
        }


        addafter("Serial No.")
        {

            field("Asset Tag"; Rec."Asset Tag")
            {
                ApplicationArea = Basic;
                ShowMandatory = true;
                //CharAllowed = 'AZ';
            }

            field("Old Asset Tag"; Rec."Old Asset Tag")
            {
                ApplicationArea = Basic;
            }
            field("Asset Location"; Rec."Asset Location")
            {
                ApplicationArea = Basic;
            }
            field("Asset Status"; Rec."Asset Status")
            { ApplicationArea = Basic; }
            field("Marked for Disposal"; Rec."Marked for Disposal")
            { ApplicationArea = Basic; }

            field("Acquisition Type"; Rec."Acquisition Type")
            {
                ApplicationArea = Basic;
            }
            field("Acquisition Date"; Rec."Acquisition Date")
            {
                ApplicationArea = Basic;
            }
            field("Lease Commence Date"; Rec."Lease Commence Date")
            {
                ApplicationArea = Basic;
            }
            field("Lease End Date"; Rec."Lease End Date")
            {
                ApplicationArea = Basic;
            }
            field("Employee Responsible"; Rec."Employee Responsible")
            {
                ApplicationArea = Basic;
                Caption = 'Responsible Employee';
                //Staff PF No.
            }
            field("Responsible Employee Name"; Rec."Responsible Employee Name")
            {
                Editable = false;
                //Staff Name
            }
            field("Branch"; Rec."Global Dimension 1 Code")
            {
                ToolTip = 'Specifies the value of the Branch field.';
            }
            field("Department"; Rec."Global Dimension 2 Code")
            {
                ToolTip = 'Specifies the value of the Department field.';
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
            }
            field("Created At"; Rec."Created at")
            {
                ToolTip = 'Specifies the value of the SystemCreatedAt field.';
            }
            field("Created By"; Rec."Created By")
            {
                ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                Editable = False;
            }
            field(Status; Rec.Status)
            {
                Editable = false;
            }
        }
        addafter(DepreciationMethod)
        {
            field("Straight Line %"; FADepreciationBook."Straight-Line %") { ApplicationArea = basic; }
        }
        modify("FA Class Code")
        {
            ApplicationArea = Basic;
            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;
        }

    }

    actions
    {
        // modify("Insurance")
        // {
        //     //ApplicationArea = Basic;
        // }
        // addafter("Insurance")
        // {
        //     group("EDMS Integration")
        //     {
        //         action("Import")
        //         {
        //             ApplicationArea = All;
        //             Caption = 'Import File';
        //             Promoted = true;
        //             PromotedCategory = Category5;
        //             PromotedIsBig = true;
        //             Image = Import;

        //             trigger OnAction()
        //             var
        //                 Base64Convert: Codeunit "Base64 Convert";
        //                 TempBlob: Codeunit "Temp Blob";
        //                 InStr: InStream;

        //                 EDMSFunctions: Codeunit "EDMS Functions";
        //                 FileName: Text;
        //                 FileContentsB64: Text;

        //                 IDNumber: Text;
        //                 ApplicationType: Label 'MA'; // Member Application
        //                 PFNumber: Text;
        //             begin
        //                 if Rec."No." <> '' then begin
        //                     FileName := EDMSFunctions.PickEDMSFile(TempBlob);

        //                     TempBlob.CreateInStream(InStr);
        //                     FileContentsB64 := Base64Convert.ToBase64(InStr);

        //                     if FileContentsB64 <> '' then begin
        //                         // UploadToEDMS(Rec, FileName, FileContentsB64);
        //                     end;
        //                 end else begin
        //                     Error('Application No. is required for EDMS document upload');
        //                 end;
        //             end;
        //         }
        //         action("EDMS File List")
        //         {
        //             ApplicationArea = Basic, Suite;
        //             Image = Documents;
        //             Promoted = true;
        //             PromotedCategory = Category5;
        //             PromotedIsBig = true;

        //             RunObject = page "EDMS Files List";
        //             RunPageLink = "Application No." = field("No.");
        //             // RunPageMode = Create;
        //         }
        //     }
        // }
    }
    procedure FnRestrictAccess()
    var
        StatusPermission: Record 52185687;
        ErrorOnRestrictViewTxt: label 'You do Not have Permission on View,Read,Modify on this Page. Contact system administrator for assistance. %1-%2';
    begin
        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", UserId);
        StatusPermission.SetRange("Edit Fixed Asset", true);
        if not StatusPermission.Find('-') then begin
            CurrPage.Editable := false;
        end else begin
            CurrPage.Editable := true;
        end;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        FnRestrictAccess();
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        FnRestrictAccess();
    end;

    // trigger OnClosePage()
    // var
    //     myInt: Integer;
    // begin
    //     Rec.TestField("Asset Tag");
    // end;
}
// {

//     //Unsupported feature: Property Modification (PageType) on ""Fixed Asset Card"(Page 5600)".

//     layout
//     {
//         modify("No.")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Importance) on ""No."(Control 2)".

//         }
// modify(Description)
// {
//     ApplicationArea = Basic;
// }
//         modify("FA Class Code")
//         {

//             //Unsupported feature: Property Modification (Level) on ""FA Class Code"(Control 43)".

//             ApplicationArea = Basic;
//         }
//         modify("FA Subclass Code")
//         {

//             //Unsupported feature: Property Modification (Level) on ""FA Subclass Code"(Control 45)".

//             ApplicationArea = Basic;
//         }
//         modify("FA Location Code")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Importance) on ""FA Location Code"(Control 52)".

//         }
//         modify("Budgeted Asset")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Importance) on ""Budgeted Asset"(Control 16)".

//         }
//         modify("Serial No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Main Asset/Component")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (Visible) on ""Main Asset/Component"(Control 22)".

//         }
//         modify("Component of Main Asset")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (Visible) on ""Component of Main Asset"(Control 20)".

//         }
//         // modify("Search Description")
//         // {
//         //     ApplicationArea = Basic;
//         // }
//         modify("Responsible Employee")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Inactive)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Blocked)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Last Date Modified")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (Visible) on ""Last Date Modified"(Control 32)".

//         }
//         // modify("Depreciation Book")
//         // {
//         //        ApplicationArea = Basic;
//         // }

//             //Unsupported feature: Property Modification (Level) on ""Depreciation Book"(Control 27)".


//             //Unsupported feature: Property Modification (ControlType) on ""Depreciation Book"(Control 27)".


//             //Unsupported feature: Property Modification (Name) on ""Depreciation Book"(Control 27)".


//             //Unsupported feature: Property Insertion (SourceExpr) on ""Depreciation Book"(Control 27)".


//         modify(DepreciationBookCode)
//         {

//             //Unsupported feature: Property Modification (Name) on "DepreciationBookCode(Control 25)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "DepreciationBookCode(Control 25)".

//         }
//         modify(DepreciationMethod)
//         {

//             //Unsupported feature: Property Modification (Name) on "DepreciationMethod(Control 23)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "DepreciationMethod(Control 23)".

//         }
//         modify(DepreciationStartingDate)
//         {

//             //Unsupported feature: Property Modification (Level) on "DepreciationStartingDate(Control 21)".


//             //Unsupported feature: Property Modification (Name) on "DepreciationStartingDate(Control 21)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "DepreciationStartingDate(Control 21)".

//         }
//         modify(NumberOfDepreciationYears)
//         {

//             //Unsupported feature: Property Modification (Level) on "NumberOfDepreciationYears(Control 19)".


//             //Unsupported feature: Property Modification (Name) on "NumberOfDepreciationYears(Control 19)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "NumberOfDepreciationYears(Control 19)".

//         }
//         modify(DepreciationEndingDate)
//         {

//             //Unsupported feature: Property Modification (Level) on "DepreciationEndingDate(Control 17)".


//             //Unsupported feature: Property Modification (Name) on "DepreciationEndingDate(Control 17)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "DepreciationEndingDate(Control 17)".


//             //Unsupported feature: Property Insertion (Visible) on "DepreciationEndingDate(Control 17)".

//         }
//         modify(AddMoreDeprBooks)
//         {

//             //Unsupported feature: Property Modification (Level) on "AddMoreDeprBooks(Control 15)".


//             //Unsupported feature: Property Modification (Name) on "AddMoreDeprBooks(Control 15)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "AddMoreDeprBooks(Control 15)".


//             //Unsupported feature: Property Insertion (Visible) on "AddMoreDeprBooks(Control 15)".

//         }
//         modify("Vendor No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Maintenance Vendor No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Under Maintenance")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Next Service Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Warranty Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Insured)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Insertion (Visible) on "Control1905767507(Control 1905767507)".

//         // modify("No.")
//         // {
//         //     Visible = false;
//         // }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


//         //Unsupported feature: Property Deletion (Visible) on ""No."(Control 2)".

// modify(Description)
// {
//     Editable = false;
// }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


//         //Unsupported feature: Property Deletion (ShowMandatory) on "Description(Control 4)".

//         modify(Control34)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""FA Class Code"(Control 43)".

//         // modify("FA Subclass Code")
//         // {
//         //     Visible = false;
//         // }
//         // modify("FA Subclass Code")
//         // {
//         //     Visible = false;
//         // }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""FA Subclass Code"(Control 45)".


//         //Unsupported feature: Property Deletion (ShowMandatory) on ""FA Subclass Code"(Control 45)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""FA Location Code"(Control 52)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Budgeted Asset"(Control 16)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 26)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Main Asset/Component"(Control 22)".


//         //Unsupported feature: Property Deletion (Importance) on ""Main Asset/Component"(Control 22)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Component of Main Asset"(Control 20)".


//         //Unsupported feature: Property Deletion (Importance) on ""Component of Main Asset"(Control 20)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Search Description"(Control 18)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Responsible Employee"(Control 63)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Inactive(Control 65)".


//         //Unsupported feature: Property Deletion (Importance) on "Inactive(Control 65)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Blocked(Control 30)".


//         //Unsupported feature: Property Deletion (Importance) on "Blocked(Control 30)".

//         modify(Acquired)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date Modified"(Control 32)".


//         //Unsupported feature: Property Deletion (Importance) on ""Last Date Modified"(Control 32)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Depreciation Book"(Control 27)".


//         //Unsupported feature: Property Deletion (Visible) on ""Depreciation Book"(Control 27)".


//         //Unsupported feature: Property Deletion (GroupType) on ""Depreciation Book"(Control 27)".

//         // modify(DepreciationBookCode)
//         // {
//         //     Visible = false;
//         // }

//         //Unsupported feature: Property Deletion (CaptionML) on "DepreciationBookCode(Control 25)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "DepreciationBookCode(Control 25)".


//         //Unsupported feature: Property Deletion (TableRelation) on "DepreciationBookCode(Control 25)".


//         //Unsupported feature: Property Deletion (Importance) on "DepreciationBookCode(Control 25)".

//         modify(FAPostingGroup)
//         {
//             Visible = false;
//         }
//         // modify(DepreciationMethod)
//         // {
//         //     Visible = false;
//         // }

//         //Unsupported feature: Property Deletion (CaptionML) on "DepreciationMethod(Control 23)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "DepreciationMethod(Control 23)".

//         modify(Control33)
//         {
//             Visible = false;
//         }
//         // modify(DepreciationStartingDate)
//         // {
//         //     Visible = false;
//         // }

//         //Unsupported feature: Property Deletion (CaptionML) on "DepreciationStartingDate(Control 21)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "DepreciationStartingDate(Control 21)".


//         //Unsupported feature: Property Deletion (ShowMandatory) on "DepreciationStartingDate(Control 21)".

//         // modify(NumberOfDepreciationYears)
//         // {
//         //     Visible = false;
//         // }

//         //Unsupported feature: Property Deletion (CaptionML) on "NumberOfDepreciationYears(Control 19)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "NumberOfDepreciationYears(Control 19)".

//         // modify(DepreciationEndingDate)
//         // {
//         //     Visible = false;
//         // }

//         //Unsupported feature: Property Deletion (CaptionML) on "DepreciationEndingDate(Control 17)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "DepreciationEndingDate(Control 17)".


//         //Unsupported feature: Property Deletion (ShowMandatory) on "DepreciationEndingDate(Control 17)".

//         modify(BookValue)
//         {
//             Visible = false;
//         }
//         modify(DepreciationTableCode)
//         {
//             Visible = false;
//         }
//         modify(UseHalfYearConvention)
//         {
//             Visible = false;
//         }
//         modify(Control38)
//         {
//             Visible = false;
//         }
//         // modify(AddMoreDeprBooks)
//         // {
//         //     Visible = false;
//         // }

//         //Unsupported feature: Property Deletion (DrillDown) on "AddMoreDeprBooks(Control 15)".


//         //Unsupported feature: Property Deletion (Editable) on "AddMoreDeprBooks(Control 15)".


//         //Unsupported feature: Property Deletion (Style) on "AddMoreDeprBooks(Control 15)".


//         //Unsupported feature: Property Deletion (StyleExpr) on "AddMoreDeprBooks(Control 15)".


//         //Unsupported feature: Property Deletion (ShowCaption) on "AddMoreDeprBooks(Control 15)".


//         //Unsupported feature: Property Deletion (CaptionML) on "DepreciationBook(Control 6)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "DepreciationBook(Control 6)".


//         //Unsupported feature: Property Deletion (Visible) on "DepreciationBook(Control 6)".


//         //Unsupported feature: Property Deletion (PartType) on "DepreciationBook(Control 6)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor No."(Control 10)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Maintenance Vendor No."(Control 12)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Under Maintenance"(Control 14)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Next Service Date"(Control 24)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Date"(Control 37)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Insured(Control 28)".

//         modify(FixedAssetPicture)
//         {
//             Visible = false;
//         }
//         modify("Attached Documents")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

//         addafter("Last Date Modified")
//         {
//             field("Unit Of Measure";rec."Unit Of Measure")
//             {
//                 ApplicationArea = Basic;
//             }
//         }
//         addafter(DepreciationBook)
//         {
//             group(Posting)
//             {
//                 Caption = 'Posting';
//             }
//         }
//         // moveafter(Description;"Depreciation Book")
//         // moveafter("Asset Type";"Serial No.")
//         // moveafter("Responsible Employee";NumberOfDepreciationYears)
//         // moveafter("Brand Name";DepreciationStartingDate)
//         // moveafter("REG No.";DepreciationMethod)
//         // moveafter("Chasis No";DepreciationBookCode)
//         // moveafter("Engine No";Inactive)
//         // moveafter("Last Date Modified";DepreciationEndingDate)
//     }
//     actions
//     {
//         modify("Depreciation &Books")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (Promoted) on ""Depreciation &Books"(Action 51)".


//             //Unsupported feature: Property Insertion (PromotedCategory) on ""Depreciation &Books"(Action 51)".

//         }
//         modify(Statistics)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Dimensions)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Maintenance &Registration")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("FA Posting Types Overview")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Co&mments")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("M&ain Asset Components")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (Promoted) on ""M&ain Asset Components"(Action 29)".


//             //Unsupported feature: Property Insertion (PromotedCategory) on ""M&ain Asset Components"(Action 29)".

//         }
//         modify("Ma&in Asset Statistics")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Total Value Ins&ured")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Ledger E&ntries")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (RunPageView) on ""Ledger E&ntries"(Action 7)".


//             //Unsupported feature: Property Insertion (Promoted) on ""Ledger E&ntries"(Action 7)".


//             //Unsupported feature: Property Insertion (PromotedCategory) on ""Ledger E&ntries"(Action 7)".

//         }
//         modify("Error Ledger Entries")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (RunPageView) on ""Error Ledger Entries"(Action 8)".

//         }
//         modify("Main&tenance Ledger Entries")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (Promoted) on ""Main&tenance Ledger Entries"(Action 9)".


//             //Unsupported feature: Property Insertion (PromotedCategory) on ""Main&tenance Ledger Entries"(Action 9)".

//         }
//         modify("C&opy Fixed Asset")
//         {

//             //Unsupported feature: Property Modification (Level) on ""C&opy Fixed Asset"(Action 57)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (Promoted) on ""C&opy Fixed Asset"(Action 57)".


//             //Unsupported feature: Property Insertion (PromotedCategory) on ""C&opy Fixed Asset"(Action 57)".

//         }
//         modify(Details)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("FA Book Value")
//         {
//             Caption = 'Book Value 01';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Name) on ""FA Book Value"(Action 1905598506)".


//             //Unsupported feature: Property Insertion (Promoted) on ""FA Book Value"(Action 1905598506)".


//             //Unsupported feature: Property Insertion (PromotedCategory) on ""FA Book Value"(Action 1905598506)".

//         }
//         modify("FA Book Val. - Appr. & Write-D")
//         {
//             Caption = 'Book Value 02';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Name) on ""FA Book Val. - Appr. & Write-D"(Action 1905598606)".


//             //Unsupported feature: Property Insertion (Promoted) on ""FA Book Val. - Appr. & Write-D"(Action 1905598606)".


//             //Unsupported feature: Property Insertion (PromotedCategory) on ""FA Book Val. - Appr. & Write-D"(Action 1905598606)".

//         }
//         modify(Analysis)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Projected Value")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("G/L Analysis")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (Promoted) on ""G/L Analysis"(Action 1903345906)".


//             //Unsupported feature: Property Insertion (PromotedCategory) on ""G/L Analysis"(Action 1903345906)".

//         }
//         modify(Register)
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (Promoted) on "Register(Action 1903807106)".


//             //Unsupported feature: Property Insertion (PromotedCategory) on "Register(Action 1903807106)".

//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Depreciation &Books"(Action 51)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 40)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 84)".


//         //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 84)".


//         //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 84)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Maintenance &Registration"(Action 35)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""FA Posting Types Overview"(Action 42)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 50)".

//         modify(Attachments)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""M&ain Asset Components"(Action 29)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Ma&in Asset Statistics"(Action 41)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Total Value Ins&ured"(Action 68)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 7)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Error Ledger Entries"(Action 8)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Main&tenance Ledger Entries"(Action 9)".

//         modify(Acquire)
//         {
//             Visible = false;
//         }



//         addafter("Maintenance &Registration")
//         {
//             action(Picture)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Picture';
//                 Image = Picture;
//                 RunObject = Page "Fixed Asset Picture";
//                 RunPageLink = "No."=field("No.");
//             }
//         }
//         addfirst(Processing)
//         {
//             action(CalculateDepreciation)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Calculate Depreciation';
//                 Image = CalculateDepreciation;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     FixedAsset: Record "Fixed Asset";
//                 begin
//                     FixedAsset.SetRange("No.",Rec."No.");
//                     Report.RunModal(Report::"Calculate Depreciation",true,false,FixedAsset);
//                 end;
//             }
//         }
//         addfirst(Reporting)
//         {
//             action("Fixed Assets List")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Fixed Assets List';
//                 Image = "Report";
//                 Promoted = true;
//                 PromotedCategory = "Report";
//                 RunObject = Report "Fixed Asset - List";
//             }
//             action("Acquisition List")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Acquisition List';
//                 Image = "Report";
//                 Promoted = false;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = "Report";
//                 RunObject = Report "Fixed Asset - Acquisition List";
//             }
//         }
//         moveafter("Maintenance &Registration";"C&opy Fixed Asset")
//     }

//     //Unsupported feature: Property Deletion (Permissions).

// }
