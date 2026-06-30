// table 52185494 "Sky Automated Savings"
// {
//     LookupPageID = "Savings Account Registration";

//     fields
//     {
//         field(2; "Product Type"; Code[10])
//         {
//             Description = 'LookUp to Product Factory';
//             TableRelation = "Product Factory" WHERE("Product Class Type" = CONST(Savings),
//                                                      Status = CONST(Active),
//                                                      "Product Category" = FILTER(<> "Fixed Deposit"));

//             trigger OnValidate()
//             begin
//                 if ProductFactory.Get("Product Type") then
//                     "Product Name" := ProductFactory."Product Description";
//                 // "Monthly Contribution":=ProductFactory."Minimum Contribution";
//                 "Product Category" := ProductFactory."Product Category";

//                 // ProductDocuments.RESET;
//                 // ProductDocuments.SETRANGE("Product ID","Product Type");
//                 // IF ProductDocuments.FIND('-') THEN BEGIN
//                 //  REPEAT
//                 //   ApplicationDocuments.RESET;
//                 //    IF ApplicationDocuments.FIND('-') THEN
//                 //      EntryNo:=ApplicationDocuments."Entry No."+1
//                 //    ELSE
//                 //      EntryNo:=1;
//                 //
//                 // ApplicationDocuments.RESET;
//                 // ApplicationDocuments.SETRANGE("Document No.",ProductDocuments."Document No.");
//                 // ApplicationDocuments.SETRANGE("Reference No.","No.");
//                 // IF NOT ApplicationDocuments.FIND('-') THEN BEGIN
//                 //
//                 // ApplicationDocuments.INIT;
//                 // ApplicationDocuments."Entry No.":=EntryNo;
//                 // ApplicationDocuments."Product ID":=ProductDocuments."Product ID";
//                 // ApplicationDocuments.Description:=ProductDocuments.Description;
//                 // ApplicationDocuments."Reference No.":="No.";
//                 // ApplicationDocuments."Document No.":=ProductDocuments."Document No.";
//                 // ApplicationDocuments."Product Name":=ProductFactory."Product Description";
//                 // ApplicationDocuments.INSERT;
//                 // END;
//                 // UNTIL ProductDocuments.NEXT=0;
//                 //
//                 // END;
//             end;
//         }
//         field(3; "Product Name"; Text[100])
//         {
//         }
//         field(4; "Monthly Contribution"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 ProductFactory.Get("Product Type");
//                 if "Monthly Contribution" < ProductFactory."Minimum Contribution" then
//                     Error('The minimum contribution should not be less than %1', ProductFactory."Minimum Contribution");
//             end;
//         }
//         field(5; "Product Category"; Enum "Product Categories")
//         {
//         }
//     }

//     keys
//     {
//         key(Key1; "Product Type")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         ProductFactory: Record "Product Factory";
//         ProductDocuments: Record "Product Documents";
//         ApplicationDocuments: Record "Application Documents";
//         EntryNo: Integer;
// }

