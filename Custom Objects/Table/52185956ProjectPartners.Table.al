// table 52185956 "Project Partners"
// {

//     fields
//     {
//         field(1; PartnerID; Code[20])
//         {
//             NotBlank = true;
//             TableRelation = Vendor WHERE(Blocked = FILTER(" "));

//             trigger OnValidate()
//             begin
//                 //Cust.GET(PartnerID);
//                 //"Partner Name":=Cust.Name;
//             end;
//         }
//         field(2; "Partner Name"; Text[100])
//         {
//         }
//         field(3; "Partner Budget"; Decimal)
//         {
//             CalcFormula = Sum("Job-Planning Line"."Total Cost (LCY)" WHERE(Partner = FIELD(PartnerID),
//                                                                             "Grant No." = FIELD("Grant No")));
//             FieldClass = FlowField;
//         }
//         field(4; "Grant No"; Code[50])
//         {
//             NotBlank = true;
//             TableRelation = Jobs;
//         }
//         field(5; "Reporting Date"; Date)
//         {
//         }
//         field(6; "Disbursed Amount (LCY)"; Decimal)
//         {
//             CalcFormula = Sum("Payment Line"."NetAmount LCY" WHERE("Grant No" = FIELD("Grant No"),
//                                                                     "Account No." = FIELD(PartnerID),
//                                                                     Status = CONST(Posted)));
//             FieldClass = FlowField;
//         }
//         field(7; Balance; Decimal)
//         {
//             Editable = false;
//         }
//         field(8; "Accounted Amount"; Decimal)
//         {
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(9; "Contractor Type"; Option)
//         {
//             OptionCaption = ' ,Sub-Contractor,Prime';
//             OptionMembers = " ","Sub-Contractor",Prime;
//         }
//     }

//     keys
//     {
//         key(Key1; PartnerID)
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         Cust: Record Vendor;
// }

