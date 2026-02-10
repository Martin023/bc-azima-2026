// table 52186522 "Salary Header P"
// {
//     DrillDownPageID = "Salary Lists P";
//     LookupPageID = "Salary Lists P";

//     fields
//     {
//         field(1; No; Code[20])
//         {
//             Editable = false;

//             trigger OnValidate()
//             begin
//                 if No <> xRec.No then begin
//                     NoSetup.Get();
//                     NoSeriesMgt.TestManual(NoSetup."Salary Nos.");
//                     "No. Series" := '';
//                 end;
//             end;
//         }
//         field(2; "No. Series"; Code[20])
//         {
//         }
//         field(3; Posted; Boolean)
//         {
//             Editable = false;
//         }
//         field(6; "Posted By"; Code[50])
//         {
//             Editable = false;
//         }
//         field(7; "Date Entered"; Date)
//         {
//         }
//         field(9; "Entered By"; Text[50])
//         {
//         }
//         field(10; Remarks; Text[500])
//         {
//         }
//         field(19; "Date Filter"; Date)
//         {
//             FieldClass = FlowFilter;
//         }
//         field(20; "Time Entered"; Time)
//         {
//         }
//         field(21; "Posting date"; Date)
//         {
//             Editable = false;
//         }
//         field(22; "Account Type"; Enum "Gen. Journal Account Type")
//         {
//             // OptionCaption = 'G/L Account,Customer/Employer,Vendor,Bank Account,Fixed Asset';
//             // OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
//         }
//         field(23; "Account No"; Code[30])
//         {
//             TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
//             ELSE
//             IF ("Account Type" = CONST(Customer)) Customer WHERE("Account Type" = filter(employer))
//             ELSE
//             IF ("Account Type" = CONST(Vendor)) Vendor
//             ELSE
//             IF ("Account Type" = CONST("Bank Account")) "Bank Account"
//             ELSE
//             IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset";

//             trigger OnValidate()
//             begin

//                 if "Account Type" = "Account Type"::Customer then begin
//                     cust.Reset;
//                     cust.SetRange(cust."No.", "Account No");
//                     if cust.Find('-') then begin
//                         "Account Name" := cust.Name;
//                     end;
//                 end;

//                 if "Account Type" = "Account Type"::"G/L Account" then begin
//                     "GL Account".Reset;
//                     "GL Account".SetRange("GL Account"."No.", "Account No");
//                     if "GL Account".Find('-') then begin
//                         "Account Name" := "GL Account".Name;
//                     end;
//                 end;

//                 if "Account Type" = "Account Type"::"Bank Account" then begin
//                     BANKACC.Reset;
//                     BANKACC.SetRange(BANKACC."No.", "Account No");
//                     if BANKACC.Find('-') then begin
//                         "Account Name" := BANKACC.Name;

//                     end;
//                 end;
//             end;
//         }
//         field(24; "Document No"; Code[20])
//         {
//         }
//         field(25; Amount; Decimal)
//         {
//         }
//         field(26; "Scheduled Amount"; Decimal)
//         {
//             CalcFormula = Sum("Salary Lines P".Amount WHERE("Salary Header No." = FIELD(No)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(27; "Total Count"; Integer)
//         {
//             CalcFormula = Count("Salary Lines P" WHERE("Salary Header No." = FIELD(No)));
//             FieldClass = FlowField;
//         }
//         field(37; "Total Posted Count"; Integer)
//         {
//             CalcFormula = Count("Salary Lines P" WHERE("Salary Header No." = FIELD(No), Posted = const(true)));
//             FieldClass = FlowField;
//         }
//         field(28; "Account Name"; Text[50])
//         {
//             Editable = false;
//         }
//         field(29; "Employer Code"; Code[30])
//         {
//             TableRelation = Customer."No.";

//             trigger OnValidate()
//             var
//                 Customer: Record Customer;
//             begin

//                 Customer.Reset;
//                 Customer.SetRange(Customer."No.", "Employer Code");
//                 if Customer.Find('-') then begin
//                     "Employer Name" := Customer.Name;
//                 end;

//             end;
//         }
//         field(30; Status; Option)
//         {
//             Editable = true;
//             OptionCaption = 'Open,Pending,Approved,Rejected';
//             OptionMembers = Open,Pending,Approved,Rejected;

//             trigger OnValidate()
//             var
//                 RegistrationMngt: Codeunit "Registration Process";
//                 GlobalFunctions: Codeunit "Global Functions";
//             begin
//                 if (Rec.Status = Status::Rejected) then
//                     GlobalFunctions.CommentsManagement(Rec.No);
//             end;
//         }
//         field(31; "Income Type"; Enum "Salary Income Types")
//         {
//             Caption = 'Income Type';
//         }
//         field(32; "Transaction Type"; Code[20])
//         {
//             TableRelation = "Transaction Types".Code WHERE(Type = CONST("Salary Processing"));


//             trigger OnValidate()
//             begin
//                 "Document No" := No;
//             end;
//         }
//         field(33; Validated; Boolean)
//         {
//         }
//         field(34; "Mutiple Salaries Checked"; Boolean)
//         {
//         }
//         field(35; "Last Loan Issue Date"; Date)
//         {
//         }
//         field(36; "Donnot Recover"; Boolean)
//         {
//         }
//         field(38; Month; Option)
//         {
//             OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
//             OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
//         }
//         field(39; Year; Option)
//         {
//             OptionCaption = ' ,2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033,2034,2035';
//             OptionMembers = " ","2023","2024","2025","2026","2027","2028","2029","2030","2031","2032","2033","2034","2035";
//         }
//         field(40; "Employer Name"; Text[100])
//         {

//         }
//         field(41; "Start Date"; Date)
//         {
//             trigger OnValidate()
//             begin
//                 "End Date" := CalcDate('<CM>', "Start Date");
//                 rec.Remarks := Format(Rec."Employer Code") + ' ' + Format("End Date", 0, '<Month Text>') + ' - ' + Format(Date2DMY("End Date", 3))
//                                + ' ' + Format(Rec."Income Type");
//             end;
//         }
//         field(42; "End Date"; Date)
//         {
//         }
//         field(69; "Global Dimension 1 Code"; Code[20])
//         {
//             CaptionClass = '1,1,1';
//             Caption = 'Global Dimension 1 Code';
//             Editable = false;
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

//             trigger OnValidate()
//             begin

//             end;
//         }
//         field(70; "Global Dimension 2 Code"; Code[20])
//         {
//             CaptionClass = '1,1,2';
//             Caption = 'Global Dimension 2 Code';
//             Editable = false;
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

//             trigger OnValidate()
//             begin

//             end;
//         }
//         field(73; "Responsibility Centre"; Code[20])
//         {
//             Description = 'LookUp to Responsibility Center BR';
//             TableRelation = "Responsibility Center";
//         }
//     }

//     keys
//     {
//         key(Key1; No)
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnInsert()
//     begin
//         if No = '' then begin
//             NoSetup.Get();
//             NoSetup.TestField(NoSetup."Salary Nos.");
//             NoSeriesMgt.InitSeries(NoSetup."Salary Nos.", xRec."No. Series", 0D, No, "No. Series");
//         end;

//         "Entered By" := UpperCase(UserId);
//         "Date Entered" := Today;
//         "Time Entered" := Time;
//         "Posting date" := Today;
//         if UserSetup.Get(UpperCase(UserId)) then begin
//             "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
//             "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
//             "Responsibility Centre" := UserSetup."Responsibility Centre";
//         end;
//         "Document No" := No;
//     end;

//     var
//         NoSetup: Record "Banking No Setup";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         "GL Account": Record "G/L Account";
//         BANKACC: Record "Bank Account";
//         cust: Record Customer;
//         UserSetup: Record "User Setup";
// }

