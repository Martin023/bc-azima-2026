// table 52185444 "Online Loans Applicationsssss"
// {

//     fields
//     {
//         field(1; "Application No"; Integer)
//         {
//         }
//         field(2; "Application Date"; DateTime)
//         {
//         }
//         field(3; "Membership No"; Text[20])
//         {
//         }
//         field(4; "Member Names"; Text[100])
//         {
//         }
//         field(5; "Employment No"; Text[10])
//         {
//         }
//         field(17; Telephone; Text[30])
//         {
//         }
//         field(18; Email; Text[30])
//         {
//         }
//         field(19; "Loan Type Description"; Text[100])
//         {
//         }
//         field(22; "Loan Type"; Text[20])
//         {
//         }
//         field(23; "Loan Amount"; Decimal)
//         {
//         }
//         field(24; "Repayment Period"; Integer)
//         {
//         }
//         field(26; Approved; Boolean)
//         {
//         }
//         field(27; "Basic Pay"; Decimal)
//         {
//         }
//         field(28; "Total Allowances"; Decimal)
//         {
//         }
//         field(29; TotalDeduction; Decimal)
//         {
//         }
//         field(30; "Interest Rate"; Decimal)
//         {
//         }
//         field(35; "Guarantors Approved"; Boolean)
//         {
//         }
//         field(36; Refno; Text[50])
//         {
//         }
//         field(37; topup; Boolean)
//         {
//         }
//         field(38; topupref; Text[30])
//         {
//         }
//         field(39; submitted; Boolean)
//         {
//             InitValue = false;
//         }
//         field(40; MyRecId; RecordID)
//         {
//         }
//         field(41; "BOSA No"; Text[30])
//         {
//         }
//         field(44; "Id No"; Text[30])
//         {
//         }
//         field(45; "Min No Of Guarantors"; Integer)
//         {
//         }
//         field(46; "Posted By"; Code[30])
//         {
//         }
//         field(47; "Posted Date"; DateTime)
//         {
//         }
//         field(48; Posted; Boolean)
//         {
//         }
//         field(49; "Loan No"; Code[100])
//         {
//         }
//     }

//     keys
//     {
//         key(Key1; "Application No")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnInsert()
//     begin
//         MyRecRef.GetTable(Rec);
//         MyRecId := MyRecRef.RecordId;
//     end;

//     var
//         MyRecRef: RecordRef;
// }

