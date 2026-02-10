// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// XmlPort 52185507 "Export Checkoff Lines"
// {
//     Direction = Export;
//     Format = VariableText;

//     schema
//     {
//         textelement(Root)
//         {
//             tableelement("Checkoff Lines";"Checkoff Lines")
//             {
//                 // RequestFilterFields = Field15,Field2;
//                 // XmlName = 'CashierTrans';
//                 // SourceTableView = where(Field13=const(Yes));
//                 fieldelement(a;"Checkoff Lines"."Checkoff Header")
//                 {
//                 }
//                 fieldelement(b;"Checkoff Lines"."Member No.")
//                 {
//                 }
//                 fieldelement(c;"Checkoff Lines"."Account No.")
//                 {
//                 }
//                 fieldelement(d;"Checkoff Lines".Amount)
//                 {
//                 }
//                 fieldelement(e;"Checkoff Lines"."Loan No.")
//                 {
//                 }
//                 fieldelement(f;"Checkoff Lines".Name)
//                 {
//                 }
//                 fieldelement(g;"Checkoff Lines".Posted)
//                 {
//                 }
//                 fieldelement(h;"Checkoff Lines".Type)
//                 {
//                 }
//                 fieldelement(i;"Checkoff Lines"."Employer Code")
//                 {
//                 }
//                 textelement(employername)
//                 {
//                     XmlName = 'j';
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     // if CheckoffHeader.Get("Checkoff Lines"."Checkoff Header") then
//                     //   begin
//                     //     EmployerName:=CheckoffHeader."Employer Name";
//                     //     end;
//                 end;
//             }
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     var
//         Customer: Record Customer;
//         // CheckoffHeader: Record UnknownRecord52185819;
// }
