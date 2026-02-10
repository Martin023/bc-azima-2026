// page 52186530 "HR Master Record Creation Line"
// {
//     PageType = ListPart;
//     SourceTable = "Master Record Creation Lines";
//     ApplicationArea = Basic;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             group(Control3)
//             {
//                 ShowCaption = false;
//                 field(Type; Rec.Type)
//                 {
//                     ApplicationArea = Basic;
//                     OptionCaption = ',,Dimension,,,,,,Dimension Value';

//                     trigger OnValidate()
//                     begin
//                         UpdateControls;
//                     end;
//                 }
//                 repeater(Group)
//                 {
//                     Caption = 'G/L Account';
//                     Visible = "G/LAccountVisible";
//                     field("Suggested No."; Rec."Suggested No.")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("G/L Account Name"; Rec.Name)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'G/L Account Name';
//                     }
//                     field("Debit/Credit"; Rec."Debit/Credit")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Account Type"; Rec."Account Type")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field(Blocked; Rec.Blocked)
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("General Posting Type"; Rec."General Posting Type")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("VAT. Bus. Posting Group"; Rec."VAT. Bus. Posting Group")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("VAT. Prod. Posting Group"; Rec."VAT. Prod. Posting Group")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Income/Balance Sheet A/C"; Rec."Income/Balance Sheet A/C")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field(Reason; Rec.Reason)
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Created Document No."; Rec."Created Document No.")
//                     {
//                         ApplicationArea = Basic;
//                         Editable = false;
//                     }
//                     field("Created Document Name"; Rec."Created Document Name")
//                     {
//                         ApplicationArea = Basic;
//                         Editable = false;
//                     }
//                 }
//                 repeater(Bank)
//                 {
//                     Caption = 'Bank';
//                     Visible = BankVisible;
//                     field("Bank Name"; Rec.Name)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Name';
//                     }
//                     field("Bank Address"; Rec.Address)
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Bank Post Code"; Rec."Post Code")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Post Code';
//                     }
//                     field("Bank City"; Rec.City)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'City';
//                     }
//                     field("Bank Country/Region Code"; Rec."Country/Region Code")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Country/Region Code';
//                     }
//                     field("BankPhone No."; Rec."Phone No.")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Phone No.';
//                     }
//                     field("Bank Branch No."; Rec."Bank Branch No.")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Bank Type"; Rec."Bank Type")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("BankFax No."; Rec."Fax No.")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Fax No.';
//                     }
//                     field("Bank Email"; Rec.Email)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = ' Email';
//                     }
//                     field("Bank Home Page"; Rec."Home Page")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Home Page';
//                     }
//                     field("Bakn Currency Code"; Rec."Currency Code")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Currency Code';
//                     }
//                     field("Bank Account Posting Groups"; Rec."Bank Account Posting Groups")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Bank Created Document No."; Rec."Created Document No.")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Created Document No.';
//                     }
//                     field("Bank Created Document Name"; Rec."Created Document Name")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Created Document Name';
//                     }
//                 }
//                 repeater("Customer/Vendor")
//                 {
//                     Caption = 'Customer/Vendor';
//                     Visible = "Customer/VendorVisible";
//                     field(Name; Rec.Name)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Name';
//                     }
//                     field(Address; Rec.Address)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Address';
//                     }
//                     field("Post Code"; Rec."Post Code")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field(City; Rec.City)
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Country/Region Code"; Rec."Country/Region Code")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Phone No."; Rec."Phone No.")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field(Email; Rec.Email)
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Fax No."; Rec."Fax No.")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Vendor/Customer Posting Group"; Rec."Vendor/Customer Posting Group")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Cust VAT. Bus. Posting Group"; Rec."VAT. Bus. Posting Group")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'VAT. Bus. Posting Group';
//                     }
//                     field("Cust Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Gen. Bus. Posting Group';
//                     }
//                     field("Home Page"; Rec."Home Page")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Cust Created Document No."; Rec."Created Document No.")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Created Document No.';
//                     }
//                     field("Cust Created Document Name"; Rec."Created Document Name")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Created Document Name';
//                     }
//                 }
//                 repeater(Item)
//                 {
//                     Caption = 'Item';
//                     Visible = ItemVisible;
//                     field("ItemName "; Rec.Name)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Description';
//                     }
//                     field("Base Unit of Measure"; Rec."Base Unit of Measure")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Item G/L Budget Account"; Rec."Item G/L Budget Account")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("<Item VAT. Prod. Posting Group>"; Rec."VAT. Prod. Posting Group")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'VAT. Prod. Posting Group';
//                     }
//                     field("Item Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Gen. Prod. Posting Group';
//                     }
//                     field("Inventory Posting Group"; Rec."Inventory Posting Group")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Item Created Document No."; Rec."Created Document No.")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Created Document No.';
//                     }
//                     field("Item Created Document Name"; Rec."Created Document Name")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Created Document Name';
//                     }
//                 }
//                 repeater("Fixed Asset")
//                 {
//                     Caption = 'Fixed Asset';
//                     Visible = FixedAssetVisible;
//                     field("FA Name"; Rec.Name)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Description';
//                     }
//                     field("Depreciation Book"; Rec."Depreciation Book")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("FA Posting Group"; Rec."FA Posting Group")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Depreciation Method"; Rec."Depreciation Method")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("FA Class Code"; Rec."FA Class Code")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("FA Subclass Code"; Rec."FA Subclass Code")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("FA Location Code"; Rec."FA Location Code")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("<FA Created Document No.>"; Rec."Created Document No.")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Created Document No.';
//                     }
//                     field("<FA Created Document Name>"; Rec."Created Document Name")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Created Document Name';
//                     }
//                 }
//                 repeater("Dimensions Value")
//                 {
//                     Caption = 'Dimensions Value';
//                     Visible = DimensionValueVisible;
//                     field("Dimension Code"; Rec."Dimension Code")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Dimension Name"; Rec."Dimension Name")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Dimension Value Code"; Rec."Dimension Value Code")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Dimension Value Name"; Rec."Dimension Value Name")
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("<DimValCreated Document No.>"; Rec."Created Document No.")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Created Document No.';
//                     }
//                     field("<DimValCreated Document Name>"; Rec."Created Document Name")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Created Document Name';
//                     }
//                 }
//                 repeater(Dimension)
//                 {
//                     Caption = 'Dimension';
//                     Visible = DimensionsVisible;
//                     field("Dimension Code Insert"; Rec."Dimension Code Insert")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Dimension Code';
//                     }
//                     field("Dimension Name Insert"; Rec."Dimension Name Insert")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Dimension Name';
//                     }
//                     field("<Dim Created Document No.>"; Rec."Created Document No.")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Created Document No.';
//                     }
//                     field("<Dim Created Document Name>"; Rec."Created Document Name")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Created Document Name';
//                     }
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnAfterGetRecord()
//     begin
//         UpdateControls;
//     end;

//     trigger OnOpenPage()
//     begin
//         CurrPage.Update;
//         UpdateControls;
//     end;

//     var
//         "G/LAccountVisible": Boolean;
//         BankVisible: Boolean;
//         "Customer/VendorVisible": Boolean;
//         ItemVisible: Boolean;
//         FixedAssetVisible: Boolean;
//         DimensionsVisible: Boolean;
//         DimensionValueVisible: Boolean;

//     local procedure UpdateControls()
//     begin
//         case Rec.Type of
//             Rec.Type::"G/L Account":
//                 begin
//                     "G/LAccountVisible" := true;
//                     BankVisible := false;
//                     "Customer/VendorVisible" := false;
//                     ItemVisible := false;
//                     FixedAssetVisible := false;
//                     DimensionsVisible := false;
//                     DimensionValueVisible := false;
//                 end;
//             Rec.Type::Customer, Rec.Type::Vendor:
//                 begin
//                     "G/LAccountVisible" := false;
//                     BankVisible := false;
//                     "Customer/VendorVisible" := true;
//                     ItemVisible := false;
//                     FixedAssetVisible := false;
//                     DimensionsVisible := false;
//                     DimensionValueVisible := false;
//                 end;
//             Rec.Type::Bank:
//                 begin
//                     "G/LAccountVisible" := false;
//                     BankVisible := true;
//                     "Customer/VendorVisible" := false;
//                     ItemVisible := false;
//                     FixedAssetVisible := false;
//                     DimensionsVisible := false;
//                     DimensionValueVisible := false;
//                 end;
//             Rec.Type::Item:
//                 begin
//                     "G/LAccountVisible" := false;
//                     BankVisible := false;
//                     "Customer/VendorVisible" := false;
//                     ItemVisible := true;
//                     FixedAssetVisible := false;
//                     DimensionsVisible := false;
//                     DimensionValueVisible := false;
//                 end;
//             Rec.Type::"Fixed Asset":
//                 begin
//                     "G/LAccountVisible" := false;
//                     BankVisible := false;
//                     "Customer/VendorVisible" := false;
//                     ItemVisible := false;
//                     FixedAssetVisible := true;
//                     DimensionsVisible := false;
//                     DimensionValueVisible := false;
//                 end;
//             Rec.Type::Dimension:
//                 begin
//                     "G/LAccountVisible" := false;
//                     BankVisible := false;
//                     "Customer/VendorVisible" := false;
//                     ItemVisible := false;
//                     FixedAssetVisible := false;
//                     DimensionsVisible := true;
//                     DimensionValueVisible := false;
//                 end;
//             Rec.Type::"Dimension Value":
//                 begin
//                     "G/LAccountVisible" := false;
//                     BankVisible := false;
//                     "Customer/VendorVisible" := false;
//                     ItemVisible := false;
//                     FixedAssetVisible := false;
//                     DimensionsVisible := false;
//                     DimensionValueVisible := true;
//                 end;


//             Rec.Type::" ":  //This will be the default when the page is opened
//                 begin
//                     "G/LAccountVisible" := false;
//                     BankVisible := false;
//                     "Customer/VendorVisible" := false;
//                     ItemVisible := false;
//                     FixedAssetVisible := false;
//                     DimensionsVisible := true;
//                     DimensionValueVisible := false;
//                 end;






//         end; //end of cases
//     end;
// }

