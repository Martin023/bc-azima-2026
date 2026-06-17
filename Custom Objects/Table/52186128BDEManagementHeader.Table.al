// table 52186128 "BDE Management Header"
// {
    
//     fields
//     {
//         field(1; "No."; Code[20])
//         {
//             Editable = false;
//         }
//         field(2; "Entered Date"; Date)
//         {
//             Editable = false;
//         }
//         field(3; "Captured By"; Code[50])
//         {
//             Editable = false;
//         }
//         field(4; "Last Date Modified"; Date)
//         {
//             Editable = false;
//         }
//         field(5; "Employee No"; Code[20])
//         {
//             TableRelation = "HR Employees"."No.";

//             trigger OnValidate()
//             begin
//                 BDEManagementHeader.Reset;
//                 BDEManagementHeader.SetRange("Employee No", BDEManagementHeader."Employee No");
//                 if BDEManagementHeader.Find('-') then
//                     Error(Err00, BDEManagementHeader."No.");
//                 if HREmployees.Get("Employee No") then
//                     "Employee Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name"
//                 else
//                     "Employee Name" := '';
//             end;
//         }
//         field(6; Status; Option)
//         {
//             OptionCaption = 'Open,Pending,Approved,Rejected';
//             OptionMembers = Open,Pending,Approved,Rejected;
//         }
//         field(7; "Employee Name"; Text[50])
//         {
//             Editable = false;
//         }
//         field(8; "No. Series"; Code[20])
//         {
//         }
//     }

//     keys
//     {
//         key(Key1; "No.")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnInsert()
//     begin
//         if "No." = '' then begin
//             SeriesSetup.Get;
//             SeriesSetup.TestField(SeriesSetup."BDE Application");
//             "No." := NoSeriesMgt.GetNextNo(SeriesSetup."BDE Application");
//             // NoSeriesMgt.InitSeries(SeriesSetup."BDE Application", xRec."No. Series", 0D, "No.", "No. Series");
//         end;
//         "Captured By" := UserId;
//         "Entered Date" := Today;
//     end;

//     trigger OnModify()
//     begin
//         "Last Date Modified" := Today;
//     end;

//     var
//         HREmployees: Record "HR Employees";
//         SeriesSetup: Record "Credit Nos. Series";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         NoSeriesMgt: Codeunit "No. Series";
//         UserSetup: Record "User Setup";
//         BDEManagementHeader: Record "BDE Management Header";
//         Err00: Label 'Employee application already exist No. %1';
// }

