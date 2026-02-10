#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
//If arrears are less than the deposits dont list
Report 52186791 "CRB Monthly Report"
{
    DefaultLayout = RDLC;
    ApplicationArea = Basic, suite;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/CRB Mothly Report.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Member No.", "Employer Code", "Source Unit", "Loans Category-SASRA", "Days In Arrears", "Total Loan Balance", "Application Date", "Disbursement Date", "Loan Product Type", "Actively Attached", "Actively Attached II";
            DataItemTableView = where(Posted = const(true), "Disbursement Date" = filter(<> ''), "Total Loan Balance" = filter(> 0));
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(Surname; Surname)
            {
                //1
            }
            column(Forename1; Forename1)
            {
                //2
            }
            column(Forename2; Forename2)
            {
                //3
            }
            column(Forename3; Forename3)
            {
                //4
            }
            column(TradingAs; TradingAs)
            {
                //5
            }
            column(DateofBirth; DateofBirth)
            {
                //6
            }
            column(ClientNo; ClientNo)
            {
                //7
            }
            column(AccountNo; AccountNo)
            {
                //8
            }
            column(OldAccountNo; OldAccountNo)
            {
                //9
            }
            column(Gender; Gender)
            {
                //10
            }
            column(Nationality; Nationality)
            {
                //11
            }
            column(MaritalStatus; MaritalStatus)
            {
                //12
            }
            column(PrimaryIdentificationDocumentType; PrimaryIdentificationDocumentType)
            {
                //13
            }
            column(PrimaryIdentificationDocumentNumber; PrimaryIdentificationDocumentNumber)
            {
                //14
            }
            column(SecondaryIdentificationDocumentType; SecondaryIdentificationDocumentType)
            {
                //15
            }
            column(SecondaryIdentificationDocumentNumber; SecondaryIdentificationDocumentNumber)
            {
                //16
            }
            column(OtherIdentificationDocumentType; OtherIdentificationDocumentType)
            {
                //17
            }
            column(OtherIdentificationDocumentNumber; OtherIdentificationDocumentNumber)
            {
                //18
            }
            column(PassportCountryCode; PassportCountryCode)
            {
                //19
            }
            column(MobileTelephoneNumber; MobileTelephoneNumber)
            {
                //20
            }
            column(HomeTelephoneNumber; HomeTelephoneNumber)
            {
                //21
            }
            column(WorkTelephoneNumber; WorkTelephoneNumber)
            {
                //22
            }
            column(PostalAdress1; PostalAdress1)
            {
                //23
            }
            column(PostalAdress2; PostalAdress2)
            {
                //24
            }
            column(PostalLocationTown; PostalLocationTown)
            {
                //25
            }
            column(PostalLocationCountry; PostalLocationCountry)
            {
                //26
            }
            column(PostCode; PostCode)
            {
                //27
            }
            column(PhysicalAdress1; PhysicalAdress1)
            {
                //28
            }
            column(PhysicalAdress2; PhysicalAdress2)
            {
                //29
            }
            column(PlotNumber; PlotNumber)
            {
                //30
            }
            column(LocationTown; LocationTown)
            {
                //31
            }
            column(LocationCoutry; LocationCoutry)
            {
                //32
            }
            column(TypeOfResidency; TypeOfResidency)
            {
                //33
            }
            column(PinNumber; PinNumber)
            {
                //34
            }
            column(ConsumerEmail; ConsumerEmail)
            {
                //35
            }
            column(EmployerName; EmployerName)
            {
                //36
            }
            column(OccupationalIndustryType; OccupationalIndustryType)
            {
                //37
            }
            column(EmploymentDate; EmploymentDate)
            {
                //38
            }
            column(EmploymentType; EmploymentType)
            {
                //39
            }
            column(IncomeAmount; IncomeAmount)
            {
                //40
            }
            column(LendersRegisteredName; LendersRegisteredName)
            {
                //41
            }
            column(LendersTradingName; LendersTradingName)
            {
                //42
            }
            column(LendersBrachName; LendersBrachName)
            {
                //43
            }
            column(LendersBrachCode; LendersBrachCode)
            {
                //44
            }
            column(AccountJointSingleIndicator; AccountJointSingleIndicator)
            {
                //45
            }
            column(AccountProductType; AccountProductType)
            {
                //46
            }
            column(DateAccountOpened; DateAccountOpened)
            {
                //47
            }
            column(InstallmentDueDate; InstallmentDueDate)
            {
                //48
            }
            column(OriginalAmount; OriginalAmount)
            {
                //49
            }
            column(CurrencyOfFacility; CurrencyOfFacility)
            {
                //50
            }
            column(CurrentBalInKes; CurrentBalInKes)
            {
                //51  
            }
            column(CurrentBal; CurrentBal)
            {
                //52
            }
            column(OverdueBalance; OverdueBalance)
            {
                //53
            }
            column(OverdueDate; OverdueDate)
            {
                //54
            }
            column(NumberOfDaysInArrears; NumberOfDaysInArrears)
            {
                //55
            }
            column(NumberOfInstallmentsInArrears; NumberOfInstallmentsInArrears)
            {
                //56
            }
            column(PrudentialRiskClassification; PrudentialRiskClassification)
            {
                //57
            }
            column(AccountStatus; AccountStatus)
            {
                //58
            }
            column(AccountStatusDate; AccountStatusDate)
            {
                //59
            }
            column(AccountClossureReason; AccountClossureReason)
            {
                //60
            }
            column(RepaymentPeriod; RepaymentPeriod)
            {
                //61
            }
            column(DefferedPaymentDate; DefferedPaymentDate)
            {
                //62
            }
            column(DefferedPaymentAmount; DefferedPaymentAmount)
            {
                //63
            }
            column(PaymentFrequency; PaymentFrequency)
            {
                //64
            }
            column(DisbursementDate; DisbursementDate)
            {
                //65
            }
            column(NextInstallmentAmount; NextInstallmentAmount)
            {
                //66
            }
            column(DateOfLatestPayment; DateOfLatestPayment)
            {
                //67
            }
            column(LastPaymentAmount; LastPaymentAmount)
            {
                //68
            }
            column(TypeOfSecurity; TypeOfSecurity)
            {
                //69
            }
            column(GroupID; GroupID)
            {
                //70
            }
            trigger OnAfterGetRecord()
            begin
                DaysInArreas := 0;
                Loans.CalcFields("Actively Attached", "Actively Attached II", "Days In Arrears", "Amount In Arreas SACCO", "Amount In Arreas SASRA", "Outstanding Balance", "Outstanding Interest", "Last Repayment Date");
                DaysInArreas := Loans."Days In Arrears";
                intProgressI += 1;
                if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                end;


                OutInt := 0;
                OutBal := 0;
                TotalBal := 0;

                //Columns
                Surname := '';
                Forename1 := '';
                Forename2 := '';
                Forename3 := '';
                TradingAs := '';
                DateofBirth := '';
                ClientNo := '';
                AccountNo := '';
                OldAccountNo := '';
                Gender := '';
                Nationality := '';
                MaritalStatus := '';
                PrimaryIdentificationDocumentType := '';
                PrimaryIdentificationDocumentNumber := '';
                SecondaryIdentificationDocumentType := '';
                SecondaryIdentificationDocumentNumber := '';
                OtherIdentificationDocumentType := '';
                OtherIdentificationDocumentNumber := '';
                PassportCountryCode := '';
                MobileTelephoneNumber := '';
                HomeTelephoneNumber := '';
                WorkTelephoneNumber := '';
                PostalAdress1 := '';
                PostalAdress2 := '';
                PostalLocationTown := '';
                PostalLocationCountry := '';
                PostCode := '';
                PhysicalAdress1 := '';
                PhysicalAdress2 := '';
                PlotNumber := '';
                LocationTown := '';
                LocationCoutry := '';
                TypeOfResidency := '';
                PinNumber := '';
                ConsumerEmail := '';
                EmployerName := '';
                OccupationalIndustryType := '';
                EmploymentDate := '';
                EmploymentType := '';
                IncomeAmount := 0;
                LendersRegisteredName := '';
                LendersTradingName := '';
                LendersBrachName := '';
                LendersBrachCode := '';
                AccountJointSingleIndicator := '';
                AccountProductType := '';
                DateAccountOpened := '';
                InstallmentDueDate := '';
                OriginalAmount := 0;
                CurrencyOfFacility := '';
                CurrentBalInKes := 0;
                CurrentBal := 0;
                OverdueBalance := 0;
                OverdueDate := '';
                NumberOfDaysInArrears := 0;
                NumberOfInstallmentsInArrears := 0;
                PrudentialRiskClassification := '';
                AccountStatus := '';
                AccountStatusDate := '';
                AccountClossureReason := '';
                RepaymentPeriod := 0;
                DefferedPaymentDate := '';
                DefferedPaymentAmount := 0;
                PaymentFrequency := '';
                DisbursementDate := '';
                NextInstallmentAmount := 0;
                DateOfLatestPayment := '';
                LastPaymentAmount := 0;
                TypeOfSecurity := '';
                GroupID := '';

                CurrentlyAttached := false;


                RecoveryHeader.GetLoanBalances(Loans."Loan No.", OutInt, OutBal, TotalBal);
                if (Loans."Actively Attached" > 0) or (Loans."Actively Attached II" > 0) then begin
                    CurrentlyAttached := true;
                    OutInt := 0;
                    OutBal := 0;
                    TotalBal := 0;
                    ActualLoanSchedule.GetAttachedLoanBalance(Loans, OutInt, OutBal);
                    TotalBal := OutInt + OutBal;
                    TotalBal := GlobalFunctions.FormatCRBAmounts(TotalBal);
                end;

                TotalBal := Loans."Outstanding Balance" + Loans."Outstanding Interest";

                if TotalBal <= 0 then
                    CurrReport.Skip();

                //FROM MEMBERS TABLE
                if Members.Get("Member No.") then begin
                    Surname := Members."Other Names";
                    IF Surname = '' then Surname := Members."Middle Name";
                    IF Surname = '' then Surname := Members."First Name";
                    ForeName1 := Members."First Name";
                    ForeName2 := Members."Middle Name";
                    //ForeName3 := Members."Other Names";

                    ClientNo := Members."No.";
                    LocationTown := 'NAIROBI';
                    if Customer.Get(Members."Employer Code") then
                        EmployerName := Customer.Name;

                    if Members."Date of Birth" <> 0D then
                        DateofBirth := GlobalFunctions.DateFormatCRB(Members."Date of Birth");
                    if Members.Gender = Members.Gender::Male then
                        Gender := 'M';
                    if Members.Gender = Members.Gender::Female then
                        Gender := 'F';

                    PrimaryIdentificationDocumentNumber := Members."Primary Identification";
                end;

                LastPaymentAmount := 0;
                CreditLedgerEntry.Reset();
                CreditLedgerEntry.SetRange("Loan No", Loans."Loan No.");
                CreditLedgerEntry.SetFilter("Transaction Type", '%1|%2', CreditLedgerEntry."Transaction Type"::"Interest Paid", CreditLedgerEntry."Transaction Type"::Repayment);
                CreditLedgerEntry.SetRange(Reversed, false);
                if CreditLedgerEntry.Find('-') then begin
                    // l := GlobalFunctions.DateFormatCRB(CreditLedgerEntry."Posting Date");
                    CreditLedgerEntry.CalcSums("Credit Amount");
                    LastPaymentAmount := GlobalFunctions.FormatCRBAmounts(CreditLedgerEntry."Credit Amount");
                end;

                if Loans."Last Repayment Date" <> 0D then
                    DateOfLatestPayment := GlobalFunctions.DateFormatCRB(Loans."Last Repayment Date");

                //FROM LOANS TABLE
                Loans.CalcFields("Days In Arrears", "Last Repayment Date");
                AccountNo := Loans."Loan No.";
                if Loans."Application Date" <> 0D then
                    DateAccountOpened := GlobalFunctions.DateFormatCRB(Loans."Disbursement Date");


                if Loans."Days In Arrears" > 0 then begin
                    InstallmentDueDate := GlobalFunctions.DateFormatCRB(CalcDate('-' + Format(DaysInArreas, 0, '<Integer>') + 'D', Today));

                    NextExpectedRepaymentDate := CalcDate('-' + Format(DaysInArreas, 0, '<Integer>') + 'D', Today);
                    if NextExpectedRepaymentDate < Loans."Disbursement Date" then begin
                        NextExpectedRepaymentDate := CalcDate('1M+CM', Loans."Disbursement Date");
                        InstallmentDueDate := GlobalFunctions.DateFormatCRB(NextExpectedRepaymentDate);
                    end;
                end else begin
                    InstallmentDueDate := GlobalFunctions.DateFormatCRB(CalcDate('CM', Today));
                end;

                OriginalAmntDec := Loans."Approved Amount";
                if OriginalAmntDec = 0 then
                    OriginalAmntDec := Loans."Requested Amount";

                if OriginalAmntDec <> 0 then
                    OriginalAmount := GlobalFunctions.FormatCRBAmounts(OriginalAmntDec);

                if (Loans."Actively Attached" > 0) or (Loans."Actively Attached II" > 0) then
                    CurrentBalInKes := TotalBal
                else
                    CurrentBalInKes := GlobalFunctions.FormatCRBAmounts(Loans."Outstanding Interest" + Loans."Outstanding Balance");

                CurrentBal := CurrentBalInKes;

                NumberOfDaysInArrears := Loans."Days In Arrears";

                if Loans."Days In Arrears" > 0 then begin
                    NumberOfDaysInArrears := Loans."Days In Arrears";
                    OverdueBalance := GlobalFunctions.FormatCRBAmounts(Loans."Amount In Arreas SACCO");

                    OverDueDateDate := CalcDate('-' + Format(NumberOfDaysInArrears, 0, '<Integer>') + 'D', Today);

                    if Loans."Disbursement Date" <> 0D then begin
                        if OverDueDateDate < Loans."Disbursement Date" then begin
                            OverDueDateDate := CalcDate('1M+CM', Loans."Disbursement Date");
                            NumberOfDaysInArrears := Today - OverDueDateDate;
                        end;
                    end;

                    OverdueDate := GlobalFunctions.DateFormatCRB(OverdueDateDate);

                    NextExpectedRepaymentDate := CalcDate('-' + Format(NumberOfDaysInArrears, 0, '<Integer>') + 'D', Today);
                    if NextExpectedRepaymentDate < Loans."Disbursement Date" then begin
                        NextExpectedRepaymentDate := CalcDate('1M+CM', Loans."Disbursement Date");
                        OverdueDate := GlobalFunctions.DateFormatCRB(NextExpectedRepaymentDate);
                    end;
                end;


                if NumberOfDaysInArrears > 90 then
                    if Loans."Approved Amount" <= 1000 then
                        NumberOfDaysInArrears := 90;

                NumberOfInstallmentsInArrears := Round(NumberOfDaysInArrears / 30, 1, '>');

                if (NumberOfDaysInArrears >= 0) and (NumberOfDaysInArrears <= 30) then
                    PrudentialRiskClassification := 'A';
                if (NumberOfDaysInArrears > 30) and (NumberOfDaysInArrears <= 90) then
                    PrudentialRiskClassification := 'B';
                if (NumberOfDaysInArrears > 90) and (NumberOfDaysInArrears <= 180) then
                    PrudentialRiskClassification := 'C';
                if (NumberOfDaysInArrears > 180) and (NumberOfDaysInArrears <= 360) then
                    PrudentialRiskClassification := 'D';
                if NumberOfDaysInArrears > 360 then
                    PrudentialRiskClassification := 'E';

                AccountStatus := 'F';
                if loans."Loan Rescheduled" then
                    AccountStatus := 'G';
                if Members.Status = Members.Status::Deceased then
                    AccountStatus := 'L';

                AccountStatusDate := GlobalFunctions.DateFormatCRB(Today);
                RepaymentPeriod := Loans.Installments;

                if Loans."Disbursement Date" <> 0D then
                    DisbursementDate := GlobalFunctions.DateFormatCRB(Loans."Disbursement Date");

                NextInstallmentAmount := GlobalFunctions.FormatCRBAmounts(Loans.Repayment);
                TypeOfSecurity := 'U'; //To be confirmed

                Nationality := 'KE';

                if Members."Primary Identification Type" = Members."Primary Identification Type"::"ID Number" then begin
                    PrimaryIdentificationDocumentType := '001';
                    PrimaryIdentificationDocumentNumber := Members."Primary Identification";

                    if StrLen(PrimaryIdentificationDocumentNumber) = 4 then
                        PrimaryIdentificationDocumentNumber := '0' + PrimaryIdentificationDocumentNumber;
                end;

                if Members."Primary Identification Type" = Members."Primary Identification Type"::"Passport No" then begin
                    PrimaryIdentificationDocumentType := '002';
                    PrimaryIdentificationDocumentNumber := Members."Primary Identification";
                end;

                LocationCoutry := 'KE';
                OccupationalIndustryType := '011';
                IncomeAmount := 12000000;
                LendersRegisteredName := 'Kenpipe DT SACCO LTD';
                LendersTradingName := 'Kenpipe DT SACCO LTD';
                LendersBrachName := 'Kenpipe DT SACCO LTD';
                LendersBrachCode := 'N084001';

                if CopyStr(Loans."Loan Product Type", 1, 1) = 'D' then
                    AccountJointSingleIndicator := 'J'
                else
                    AccountJointSingleIndicator := 'S';

                if ProductFactory.Get(Loans."Loan Product Type") then
                    AccountProductType := ProductFactory."CRB Product Type";
                if AccountProductType = '' then
                    AccountProductType := 'H';

                CurrencyOfFacility := 'KES';
                PaymentFrequency := 'M';
            end;

            trigger OnPostDataItem()
            begin
                diaProgress.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                intProgressTotal := COUNT;

                intProgressI := 0;
                TimeProgress := TIME;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
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
        // if CompanyInformation.Get then
        //     CompanyInformation.CalcFields(CompanyInformation.Picture);
        // CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        // CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        // CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";

    end;

    var
        //Request Page
        RunLoansAttachedToDepositsOnly: Boolean;

        //Other Variables
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Members: Record "Members";
        GlobalFunctions: Codeunit "Global Functions";
        RecoveryHeader: Record "Loan Recovery Header";
        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;

        //Columns
        Surname: Text;//Mandatory
        Forename1: Text;//Mandatory
        Forename2: Text;
        Forename3: Text;
        TradingAs: Text;
        DateofBirth: Text;//Mandatory
        ClientNo: Code[50];
        AccountNo: Code[50];//Mandatory
        OldAccountNo: Text;
        Gender: Text;//Mandatory
        Nationality: Text;//Mandatory
        MaritalStatus: Text;
        PrimaryIdentificationDocumentType: Code[50];//Mandatory
        PrimaryIdentificationDocumentNumber: Code[50];//Mandatory
        SecondaryIdentificationDocumentType: Code[50];
        SecondaryIdentificationDocumentNumber: Code[50];
        OtherIdentificationDocumentType: Code[50];
        OtherIdentificationDocumentNumber: Code[50];
        PassportCountryCode: Code[50];
        MobileTelephoneNumber: Text;
        HomeTelephoneNumber: Text;
        WorkTelephoneNumber: Text;
        PostalAdress1: Text;
        PostalAdress2: Text;
        PostalLocationTown: Text;
        PostalLocationCountry: Text;
        PostCode: Code[50];
        PhysicalAdress1: Code[100];
        PhysicalAdress2: Code[100];
        PlotNumber: Text;
        LocationTown: Text;
        LocationCoutry: Text;
        TypeOfResidency: Text;
        PinNumber: Text;
        ConsumerEmail: Text;
        EmployerName: Text;
        OccupationalIndustryType: Text;//Mandatory
        EmploymentDate: Text;
        EmploymentType: Text;
        IncomeAmount: Decimal;//Mandatory
        LendersRegisteredName: Text;//Mandatory
        LendersTradingName: Text;//Mandatory
        LendersBrachName: Code[50];//Mandatory
        LendersBrachCode: Code[50];//Mandatory
        AccountJointSingleIndicator: Text;//Mandatory
        AccountProductType: Text;//Mandatory
        DateAccountOpened: Text;//Mandatory
        InstallmentDueDate: Text;//Mandatory
        OriginalAmount: Decimal;//Mandatory
        CurrencyOfFacility: Code[10];//Mandatory
        CurrentBalInKes: Decimal;//Mandatory
        CurrentBal: Decimal;//Mandatory
        OverdueBalance: Decimal;//Mandatory
        OverdueDate: Text;
        NumberOfDaysInArrears: Integer;//Mandatory
        NumberOfInstallmentsInArrears: Integer;//Mandatory
        PrudentialRiskClassification: Text;//Mandatory
        AccountStatus: Text;//Mandatory
        AccountStatusDate: Text;//Mandatory
        AccountClossureReason: Text;
        RepaymentPeriod: Integer;//Mandatory
        DefferedPaymentDate: Text;
        DefferedPaymentAmount: Decimal;
        PaymentFrequency: Text;//Mandatory
        DisbursementDate: Text;//Mandatory
        NextInstallmentAmount: Decimal;//Mandatory
        DateOfLatestPayment: Text;
        LastPaymentAmount: Decimal;
        TypeOfSecurity: Text;//Mandatory
        GroupID: Text;

        OverDueDateDate: Date;


        //Progress Variables
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Task Progress ...';
        diaProgress: Dialog;
        intProgress: Integer;

        //Other Variable
        Customer: Record Customer;
        Schedule: Record "Ideal Repayment Schedule";
        OriginalAmntDec: Decimal;
        ActualLoanSchedule: Codeunit ActualLoanSchedule;
        CurrentlyAttached: Boolean;
        DaysInArreas: Decimal;
        ProductFactory: Record "Product Factory";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        NextExpectedRepaymentDate: Date;
}
