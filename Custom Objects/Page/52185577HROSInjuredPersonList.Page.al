// page 52185577 "HR OSInjured Person List"
// {
//     PageType = ListPart;
//     SourceTable = "HR OSInjured Person";

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field(Type; Rec.Type)
//                 {

//                     trigger OnValidate()
//                     begin
//                         if (Rec.Type = Rec.Type::"Non-Employee") then begin
//                             NonEmployee := true;
//                         end else
//                             NonEmployee := false;
//                     end;
//                 }
//                 field("Employee No"; Rec."Employee No")
//                 {
//                     Editable = true;
//                 }
//                 field("Injured Person"; Rec."Injured Person")
//                 {
//                     Editable = NonEmployee;
//                 }
//                 field(Address; Rec.Address)
//                 {
//                     Editable = NonEmployee;
//                 }
//                 field("Phone No"; Rec."Phone No")
//                 {
//                     Editable = NonEmployee;
//                 }
//                 field("ID No"; Rec."ID No")
//                 {
//                     Editable = NonEmployee;
//                 }
//                 field("Date Of Birth"; Rec."Date Of Birth")
//                 {
//                     Editable = NonEmployee;
//                 }
//                 field(Email; Rec.Email)
//                 {
//                     Editable = NonEmployee;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnInit()
//     begin
//         NonEmployee := false;
//     end;

//     var
//         NonEmployee: Boolean;
// }

