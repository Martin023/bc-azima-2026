// table 52185665 "prPAYE Angola"
// {

//     fields
//     {
//         field(1; "Tier Code"; Integer)
//         {
//         }
//         field(2; "Min. Amount"; Decimal)
//         {
//         }
//         field(3; "Max. Amount"; Decimal)
//         {
//         }
//         field(4; "Excess Amount"; Decimal)
//         {
//         }
//         field(5; Rate; Decimal)
//         {
//         }
//         field(6; "Fixed Amount"; Decimal)
//         {
//         }
//         field(7; "Tax Code"; Code[20])
//         {
//             TableRelation = "prTax Law".Code WHERE(Blocked = FILTER(false));
//         }
//     }

//     keys
//     {
//         key(Key1; "Tier Code")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }
// }

