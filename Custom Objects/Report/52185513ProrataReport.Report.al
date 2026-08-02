// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185513 "Prorata Report"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Prorata Report.rdl';

//     dataset
//     {
//         dataitem("Savings Accounts"; "Savings Accounts")
//         {
//             DataItemTableView = where("Member Status" = filter(<> Deceased), "Member Sub Status" = filter(<> Withdrawal), "Product Type" = filter('1'));

//             RequestFilterFields = "Member No.", "Product Type", "Employer Code";

//             column(CompanyInformation_Picture; CompanyInformation.Picture)
//             {
//             }
//             column(CompanyName; CompanyName)
//             {

//             }
//             column(BuldingName; BuldingName)
//             {
//             }
//             column(CompanyAddress; CompanyAddress)
//             {
//             }
//             column(CompanyTelephone; CompanyTelephone)
//             {
//             }
//             column(CompanyEmail; CompanyEmail)
//             {
//             }
//             column(PrintingDate; PrintingDate)
//             {

//             }
//             column(PrintingTime; PrintingTime)
//             {

//             }
//             column(PrintedBy; PrintedBy)
//             {

//             }
//             column(No_; "No.")
//             {

//             }
//             column(Product_Type; "Product Type")
//             {

//             }
//             column(Product_Name; "Product Name")
//             {

//             }
//             column(Name; Name)
//             {

//             }
//             column(Employer_Code; "Employer Code")
//             {

//             }
//             column(Payroll_Staff_No_; "Payroll/Staff No.")
//             {

//             }
//             column(ID_No_; "ID No.")
//             {

//             }
//             column(Prorata; Prorata)
//             {

//             }
//             column(Actual; Actual)
//             {

//             }
//             column(Variance; Variance)
//             {

//             }
//             COLUMN(Member_No_; "Member No.")
//             {

//             }
//             column(Member_Status; "Member Status")
//             {

//             }
//             column(Member_Sub_Status; "Member Sub Status")
//             {

//             }
//             column(EmployerName; EmployerName)
//             {

//             }

//             trigger OnPreDataItem()
//             begin
//                 if (StartDate = 0D) or (EndDate = 0D) then Error('Start date and enddate must have a value');
//                 //intProgressTotal := COUNT;

//                 // intProgressI := 0;
//                 // TimeProgress := TIME;
//                 // NoOfRecsProgress := intProgressTotal DIV 100;
//                 // NoOfProgressed := 0;

//                 // diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
//             end;

//             trigger OnAfterGetRecord()
//             var
//                 Customer: record Customer;
//             begin

//                 // intProgressI += 1;
//                 // if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
//                 //     NoOfProgressed := NoOfProgressed + intProgressI;
//                 //     diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
//                 //     intProgressI := 0;
//                 //     TimeProgress := TIME;
//                 // end;

//                 Actual := 0;
//                 Prorata := CustomCuesCodeunit.Prorata("Savings Accounts"."Member No.", "Savings Accounts"."Product Type");
//                 if Prorata = 0 then
//                     Prorata := "Monthly Contribution";

//                 "Savings Accounts".SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
//                 "Savings Accounts".CalcFields(Balance);
//                 Actual := "Savings Accounts".Balance;

//                 Variance := Prorata - Actual;
//                 if Customer.get("Savings Accounts"."Employer Code") then EmployerName := Customer.Name;
//                 // Actual := 

//             end;

//             // trigger OnPostDataItem()
//             // begin
//             //     diaProgress.CLOSE;
//             // end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//             area(Content)
//             {
//                 field(StartDate; StartDate)
//                 {

//                 }
//                 field(EndDate; EndDate)
//                 {

//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnPreReport()
//     begin
//         if CompanyInformation.Get then
//             CompanyInformation.CalcFields(CompanyInformation.Picture);
//         CompanyName := CompanyInformation.Name;
//         BuldingName := CompanyInformation."Building Name";
//         CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
//         CompanyTelephone := CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2";
//         CompanyEmail := CompanyInformation."E-Mail";
//         PrintingDate := GlobalFunctions.DMUDateFormatDate(Today);
//         PrintingTime := Format(Time);
//         PrintedBy := GlobalFunctions.FormatUserName(UserId);
//     end;

//     var
//         //Colums
//         CompanyName: Text;
//         BuldingName: Text;
//         CompanyAddress: Text;
//         CompanyTelephone: Text;
//         CompanyEmail: Text;
//         PrintingDate: Text;
//         PrintingTime: Text;
//         PrintedBy: Code[50];
//         Actual: Decimal;
//         Variance: Decimal;

//         //Other Variable
//         Members: Record Members;
//         CompanyInformation: Record "Company Information";
//         GlobalFunctions: Codeunit "Global Functions";
//         CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
//         StartDate: Date;
//         EndDate: Date;

//         //Request Page
//         Period: Date;

//         //progress
//         //intProgressTotal: Integer;
//         //intProgressI: Integer;
//         //TimeProgress: TIME;
//         //NoOfRecsProgress: Decimal;
//         //NoOfProgressed: Integer;
//         //Generating: Label 'Task Progress ...';
//         //diaProgress: Dialog;
//         //intProgress: Integer;
//         EmployerName: text;


// }
