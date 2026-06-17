// table 52186129 "BDE Management Lines"
// {

//     fields
//     {
//         field(1; "Header No"; Code[20])
//         {
//         }
//         field(2; "Product Type"; Code[10])
//         {
//             TableRelation = IF (Type = FILTER(Credit | Savings)) "Product Factory"."Product ID"
//             ELSE
//             IF (Type = FILTER(ATM)) "Product Factory"."Product ID" WHERE("Loan Disbursement Account" = FILTER(true));

//             trigger OnValidate()
//             begin
//                 if ProductFactory.Get("Product Type") then begin
//                     "Pruduct Name" := ProductFactory."Product Description";
//                     "Group Target" := ProductFactory.Target;
//                 end else begin
//                     "Pruduct Name" := '';
//                     "Group Target" := 0;
//                 end;

//                 if BDEManagementHeader.Get("Header No") then begin
//                     "BDE No." := BDEManagementHeader."Employee No";
//                 end;
//             end;
//         }
//         field(3; "Pruduct Name"; Text[50])
//         {
//             Editable = false;
//         }
//         field(4; "Individual Target"; Decimal)
//         {
//         }
//         field(5; "Group Target"; Decimal)
//         {
//             Editable = false;
//         }
//         field(6; "No. Sold"; Integer)
//         {
//             CalcFormula = Count("BDE Management Buffer" WHERE(Type = FIELD(Type),
//                                                                "BDE No." = FIELD("BDE No."),
//                                                                "Product Type" = FIELD("Product Type")));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(7; Disbursed; Decimal)
//         {
//             CalcFormula = Sum("BDE Management Buffer".Amount WHERE(Type = FIELD(Type),
//                                                                     "BDE No." = FIELD("BDE No."),
//                                                                     Transfered = FILTER(true),
//                                                                     "Product Type" = FIELD("Product Type")));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(8; "Pending Sact"; Decimal)
//         {
//             CalcFormula = Sum("BDE Management Buffer".Amount WHERE(Type = FIELD(Type),
//                                                                     "BDE No." = FIELD("BDE No."),
//                                                                     Transfered = FILTER(false),
//                                                                     "Product Type" = FIELD("Product Type")));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(9; "BDE No."; Code[20])
//         {
//         }
//         field(10; Type; Option)
//         {
//             OptionCaption = ' ,Credit,Savings,ATM';
//             OptionMembers = " ",Credit,Savings,ATM;
//         }
//         field(11; "Account No"; Code[20])
//         {
//         }
//     }

//     keys
//     {
//         key(Key1; "Header No", "Product Type", Type)
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         ProductFactory: Record "Product Factory";
//         BDEManagementHeader: Record "BDE Management Header";
// }

