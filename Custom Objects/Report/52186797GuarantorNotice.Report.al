#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186797 "Guarantor Notice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Guarantor Notice.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("SMS Alerts Lines"; "SMS Alerts Lines")
        {
            // RequestFilterFields = "Global Dimension 1 Code", "Code", "Electoral Zone";
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyName; CompanyName)
            {

            }
            column(BuldingName; BuldingName)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CompanyEmail; CompanyEmail)
            {
            }
            column(PrintingDate; PrintingDate)
            {

            }
            column(PrintingTime; PrintingTime)
            {

            }
            column(PrintedBy; PrintedBy)
            {

            }
            column(RecepientName; RecepientName)
            {

            }
            column(DefMemberNo; DefMemberNo)
            {

            }
            column(DefPayrollNo; DefPayrollNo)
            {

            }
            column(DefPhoneNumber; DefPhoneNumber)
            {

            }
            column(DefName; DefName)
            {

            }
            column(DefIDNo; DefIDNo)
            {

            }
            column(DefAddress; DefAddress)
            {

            }
            column(DefLoanNumber; DefLoanNumber)
            {

            }
            column(DefIssueDate; DefIssueDate)
            {

            }
            column(DefApprovedAmount; DefApprovedAmount)
            {

            }
            column(DefOutInt; DefOutInt)
            {

            }
            column(DefTotalBal; DefTotalBal)
            {

            }
            column(AmountInArrears; AmountInArrears)
            {

            }
            dataitem("Loan Guarantors and Security"; "Loan Guarantors and Security")
            {
                DataItemLink = "Loan No" = field("Loan No");
                // DataItemTableView = where("Self Guarantee" = const(false));
                column(GuarMemberNo; GuarMemberNo)
                {

                }
                column(GuarName; GuarName)
                {

                }
                column(GuarAddress; GuarAddress)
                {

                }
                column(GuarPostCode; GuarPostCode)
                {

                }
                column(GuarCity; GuarCity)
                {

                }
                column(GuarTel; GuarTel)
                {

                }
                column(GuarSharesGuaranteed; GuarSharesGuaranteed)
                {

                }


                trigger OnAfterGetRecord()
                begin
                    // if "Loan Guarantors and Security"."Member No" = "SMS Alerts Lines"."Member No" then
                    //     CurrReport.Skip();
                    GuarMemberNo := '';
                    GuarName := '';
                    GuarAddress := '';
                    GuarPostCode := '';
                    GuarCity := '';
                    GuarTel := '';
                    GuarSharesGuaranteed := 0;

                    GuarMemberNo := "Loan Guarantors and Security"."Member No";
                    if GuarMembers.Get(GuarMemberNo) then begin
                        GuarName := GuarMembers.Name;
                        GuarAddress := GuarMembers."Current Address";
                        if GuarAddress = '' then
                            GuarAddress := GuarMembers."Home Address";
                        GuarPostCode := GuarMembers."Post Code";
                        if GuarPostCode = '' then
                            GuarPostCode := GuarMembers."Permanent Post Code";
                        GuarCity := GuarMembers.City;
                        if GuarCity = '' then GuarCity := GuarMembers."Permanent City";
                        GuarTel := GuarMembers."Phone No.";
                        if GuarTel = '' then GuarTel := GuarMembers."Transactional Mobile Number";
                        if GuarTel = '' then GuarTel := GuarMembers."Office Telephone No.";
                        GuarSharesGuaranteed := "Loan Guarantors and Security"."Amount Guaranteed";
                    end;
                    DefLoanNumber := "SMS Alerts Lines"."Loan No";
                    if Loans.Get(DefLoanNumber) then begin
                        DefApprovedAmount := Loans."Approved Amount";
                        DefIssueDate := GlobalFunctions.FormatDate(Loans."Disbursement Date");
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if RecepientMembers.Get("SMS Alerts Lines"."Member No") then begin
                    RecepientName := RecepientMembers.Name;
                end;

                if Loans.Get("SMS Alerts Lines"."Loan No") then begin
                    Loans.CalcFields("Amount In Arreas SACCO");
                    AmountInArrears := Loans."Amount In Arreas SACCO";
                    RecoveryHeader.GetLoanBalances(Loans."Loan No.", DefOutInt, OutBal, DefTotalBal);
                    if DefMember.Get(Loans."Member No.") then begin
                        DefMemberNo := DefMember."No.";
                        DefPayrollNo := DefMember."Payroll/Staff No.";
                        DefPhoneNumber := DefMember."Phone No.";
                        if DefPhoneNumber = '' then
                            DefPhoneNumber := DefMember."Transactional Mobile Number";
                        DefName := DefMember.Name;
                        DefIDNo := DefMember."Primary Identification";
                        DefAddress := DefMember."Current Address";
                        if DefAddress = '' then
                            DefAddress := DefMember."Home Address";

                    end;
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {

            }
        }

        actions
        {
        }
    }

    labels
    {
    }
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyName := CompanyInformation.Name;
        BuldingName := CompanyInformation."Building Name";
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2";
        CompanyEmail := CompanyInformation."E-Mail";
        PrintingDate := GlobalFunctions.DMUDateFormatDate(Today);
        PrintingTime := Format(Time);
        PrintedBy := GlobalFunctions.FormatUserName(UserId);
    end;

    var
        //General Columns
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Code[50];

        //Colums Recepient Details
        RecepientName: Text;

        //Columns Defaulter Details
        DefMemberNo: Code[50];
        DefPayrollNo: Code[50];
        DefPhoneNumber: Text;
        DefName: Text;
        DefIDNo: Code[50];
        DefAddress: Text;
        AmountInArrears: Decimal;

        //Columns Defaulter Loan Details
        DefLoanNumber: Text;
        DefIssueDate: Text;
        DefApprovedAmount: Decimal;
        DefOutInt: Decimal;
        DefTotalBal: Decimal;

        //Columns Guarantor Details
        GuarMemberNo: Code[50];
        GuarName: Text;
        GuarAddress: Text;
        GuarPostCode: Text;
        GuarCity: Text;
        GuarTel: Text;
        GuarSharesGuaranteed: Decimal;


        //Other Variable
        RecepientMembers: Record Members;
        DefMember: Record Members;
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
        RecoveryHeader: Record "Loan Recovery Header";
        Loans: Record Loans;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        GuarMembers: Record Members;
        OutBal: Decimal;

}
