// table 52186053 "Online Loans Applications"
// {
//     DrillDownPageId = "Online Loans";
//     LookupPageId = "Online Loans";

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
//         field(50; Rejected; Boolean)
//         {
//         }
//         field(51; "Loan Rejection Reason"; Code[100])
//         {
//             TableRelation = "Exceptions/ Rejection Reason"."Exceptions/ Rejection Reason";
//         }
//         field(52; "Self Guarantee"; Boolean)
//         {
//         }
//         field(53; "CRB Checked"; Boolean)
//         {

//             trigger OnValidate()
//             begin
//                 if "CRB Checked" then
//                     "CRB Checked By" := UserId
//                 else
//                     "CRB Checked By" := '';
//             end;
//         }
//         field(54; "CRB Checked By"; Text[30])
//         {
//         }
//         field(55; "Payslip Verfied"; Boolean)
//         {

//             trigger OnValidate()
//             begin
//                 if "Payslip Verfied" then
//                     "Payslip Verified By" := UserId
//                 else
//                     "Payslip Verified By" := '';
//             end;
//         }
//         field(56; "Payslip Verified By"; Text[30])
//         {
//         }
//         field(58; "Ghris Password"; Text[30])
//         {
//         }
//         field(59; "Loan Purpose"; Text[30])
//         {
//         }
//         field(60; "Branch Code"; Text[30])
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

//     trigger OnModify()
//     begin
//         if (("Loan No" = '') or ("Loan No" = '0')) then begin
//             if not Rejected then begin
//                 Approved := false;
//                 Posted := false;
//                 Clear("Posted By");
//                 Clear("Posted Date");
//             end;
//         end;
//     end;

//     var
//         MyRecRef: RecordRef;
// }

