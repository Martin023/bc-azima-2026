// page 52186345 "Appraisal Salary Details Card."
// {
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = Card;
//     SourceTable = "Appraisal Salary Details";

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1102760000)
//             {
//                 ShowCaption = false;
//                 field("Loan No"; Rec."Loan No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Visible = false;
//                 }
//                 field("Client Code"; Rec."Client Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Visible = false;
//                 }
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Type; Rec.Type)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Amount; Rec.Amount)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnOpenPage()
//     begin


//         //**Prevent modification of approved entries
//         LoanApps.Reset;
//         LoanApps.SetRange(LoanApps."Loan No.", rec."Loan No");
//         if LoanApps.Find('-') then begin
//             if LoanApps.Posted = true then begin
//                 CurrPage.Editable := false;
//             end else
//                 CurrPage.Editable := true;
//         end;
//     end;

//     var
//         LoanApps: Record Loans;
// }

