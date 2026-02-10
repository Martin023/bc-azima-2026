// table 52185815 "Delegate Members Retirement"
// {
//     DrillDownPageID = "Delegate Members";
//     LookupPageID = "Delegate Members";

//     fields
//     {
//         field(1; "Code"; Code[50])
//         {
//             Description = 'Lookup to Delegate groups';
//             Editable = false;
//             TableRelation = "Delegate Groups".Code;
//         }
//         field(2; "Delegate MNO."; Code[50])
//         {
//             Description = 'Lookup to Member table';
//             Editable = false;
//             TableRelation = Members."No.";

//             trigger OnValidate()
//             begin
//                 Validate(Position);
//                 if Members.Get("Delegate MNO.") then begin
//                     "Delegate Name" := Members.Name;
//                 end;
//             end;
//         }
//         field(3; "Delegate Name"; Text[100])
//         {
//             Editable = false;
//         }
//         field(4; Position; Code[50])
//         {
//             Description = 'Lookup 39004358 filter type tittle';
//             Editable = false;
//             TableRelation = "Salutation Tittles".Code WHERE(Type = CONST(Position));

//             trigger OnValidate()
//             begin
//                 DelegateMembers.Reset;
//                 DelegateMembers.SetRange(Code, Code);
//                 DelegateMembers.SetRange(Position, Position);
//                 if DelegateMembers.Find('-') then begin
//                     if Position <> '' then
//                         Error(ErrPosition, Position);
//                 end;
//             end;
//         }
//         field(5; "Job Tittle"; Code[50])
//         {
//             Description = '39004358';
//             Editable = false;
//             TableRelation = "Salutation Tittles".Code WHERE(Type = CONST(Tittle));
//         }
//         field(6; Retired; Boolean)
//         {
//         }
//         field(7; Status; Option)
//         {
//             Editable = false;
//             OptionCaption = 'Open,Pending,Approved';
//             OptionMembers = Open,Pending,Approved;
//         }
//         field(8; "Appointment Date"; Date)
//         {
//         }
//     }

//     keys
//     {
//         key(Key1; "Code", "Delegate MNO.")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         Members: Record Members;
//         DelegateMembers: Record "Delegate Members";
//         ErrPosition: Label 'You cannot have the same position of %1 within the same group';
// }

