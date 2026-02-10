#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186162 "Loan Offer Letter"
{
    //WordLayout = './Layouts/LoanOfferLetter.docx'; DefaultLayout = Word;
    DefaultLayout = RDLC;
    ApplicationArea = Basic, suite;
    //UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan Offer Letter.rdl';
    dataset
    {
        dataitem(Loans; Loans)
        {
            //DataItemTableView = where(Status = filter(Approved));
            RequestFilterFields = "Loan No.";
            column("Loan_No"; Loans."Loan No.") { }
            column(Application_Date; "Application Date") { }
            column("Loan_Product_Type"; Loans."Loan Product Type") { }
            column(Member_No_; "Member No.") { }
            column(Requested_Amount; "Requested Amount") { }
            column(Approved_Amount; "Approved Amount") { }
            column(Interest; Interest) { }
            column(Member_Name; "Member Name") { }
            column(Approval_Date; "Approval Date") { }
            column(Installments; Installments) { }
            column(Disbursement_Date; "Disbursement Date") { }
            column(Mode_of_Disbursement; "Mode of Disbursement") { }
            // column(Grace_Period; "Grace Period") { }
            // column(Installment_Period; "Installment Period") { }
            column(Repayment; "Repayment") { }
            column(Loan_Product_Type_Name; "Loan Product Type Name") { }
            //column(Posted; Posted) { }
            column(Amount_To_Disburse; "Amount To Disburse") { }
            column(Fully_Disbursed; "Fully Disbursed") { }
            column(New_Interest_Rate; "New Interest Rate") { }
            column(New_No__of_Installment; "New No. of Installment") { }
            column(New_Grace_Period; "New Grace Period") { }
            column(New_Installment_Period; "New Installment Period") { }
            column(Loan_Balance_at_Rescheduling; "Loan Balance at Rescheduling") { }
            // column(Loan_Rescheduled; "Loan Rescheduled") { }
            // column(Date_Rescheduled; "Date Rescheduled") { }
            // column(Rescheduled_By; "Reschedule By") { }
            column(Interest_Calculation_Method; "Interest Calculation Method") { }
            column(Date_Filter; "Date Filter") { }
            column(Max__Installments; "Max. Installments") { }
            column(Max__Loan_Amount; "Max. Loan Amount") { }
            column(Loan_Cycle; "Loan Cycle") { }
            column(Total_Disbursed; "Total Disbursed") { }
            column(Repayment_Start_Date; "Repayment Start Date") { }
            column(Disbursement_Account_No; "Disbursement Account No") { }
            // column(Staff_No; "Staff No") { }
            // column(Source; Source) { }
            // column(Remarks; Remarks) { }
            // column(Advice; Advice) { }
            // column(Defaulted; Defaulted) { }
            // column(Captured_By; "Captured By") { }
            // column(Last_Advice_Date; "Last Advice Date") { }
            // column(Advice_Type; "Advice Type") { }
            column(Loans_Category_SASRA; "Loans Category-SASRA") { }
            column(Currency_Code; "Currency Code") { }
            //column(CustAddress; "CustAddress") { }
            // column(Currency_Filter; "Currency Filter") { }
            // column(Appln_between_Currencies; "Appln. between Currencies") { }
            column(Expected_Date_of_Completion; "Expected Date of Completion") { }
            column(Recovery_Mode; "Recovery Mode") { }
            column(Repayment_Frequency; "Repayment Frequency") { }
            column(Status; Status) { }
            column(Loan_Rejection_Reason; "Loan Rejection Reason") { }
            column(Recommended_Amount; "Recommended Amount") { }
            column(Responsibility_Center; "Responsibility Center") { }
            column(Loan_Account; "Loan Account") { }
            //column(Loan_Span; "Loan Span") { }
            column(No__Series; "No. Series") { }
            // column(Outstanding_Balance; "Outstanding Balance") { }
            // column(Outstanding_Interest; "Outstanding Interest") { }
            // column(Outstanding_Bills; "Outstanding Bills") { }
            // column(All_Posting_through_Savings_Ac; "All Posting through Savings Ac") { }
            // column(Loan_Principle_Repayment; "Loan Principle Repayment") { }
            // Column(Loan_Interest_Repayment; "Loan Interest Repayment") { }
            //column(Employer_Code; "Employer Code") { }
            //column(EmployerName;"Employer Name") { }
            // column(Compute_Interest_Due_on_Postin; "Compute Interest Due on Postin") { }
            // column(Discounted_Loan_No_; "Discounted Loan No.") { }
            // column(Discounted_Amount; "Discounted Amount") { }
            // column(Share_Boosted_Amount; "Share Boosted Amount") { }
            // column(Global_Dimension_1_Code; "Global Dimension 1 Code") { }
            // column(Global_Dimension_2_Code; "Global Dimension 2 Code") { }
            // column(Disbursement_Destination; "Disbursement Destination") { }
            // column(Already_Suggested; "Already Suggested") { }
            // column(Responsibility_Centre; "Responsibility Centre") { }
            // column(Recovered_Loan; "Recovered Loan") { }
            column(Batch_No_; "Batch No.") { }
            column(Self_Guarantee; "Self Guarantee") { }
            column(Appraisal_Fee; "Appraisal Fee") { }
            column(Recovery_Priority; "Recovery Priority") { }
            column(Member_Deposits; "Member Deposits") { }
            //column(Cost_Value_of_House; "Cost Value of House") { }
            //column(Retirement_Expiry_Date; "Retirement/Expiry Date") { }
            //column(Employer_Introduction_Letter; "Employer Introduction Letter") { }
            //column(Six_Months_Bank_Statement; "Six Months Bank Statement") { }
            //column(National_ID; "National ID") { }
            column(ID_No; "ID No.") { }
            //column(Title_Lease_Provided; "Title/Lease Provided") { }
            //column(Injury_Benefit_Insurance; "Injury Benefit Insurance") { }
            //column(KRA_PIN;"KRA PIN SL")
            // column(Appraisal_Parameter_Type; "Appraisal Parameter Type") { }
            // column(Employer_Loan_No_; "Employer Loan No.") { }
            // column(Client_Bank_Code; "Client Bank Code") { }
            // column(Client_Bank_Name; "Client Bank Name") { }
            // column(Client_Account_No; "Client Account No") { }
            // column(Member_Category; "Member Category") { }
            // column(Last_Repayment_Date; "Last Repayment Date") { }
            // column(Maximum_Limit; "Maximum Limit") { }
            // column(Bank_Transfer_Mode; "Bank Transfer Mode") { }
            // column(Sales_Agent; "Sales Agent") { }
            column(Loan_Linking_No_; "Loan Linking No.") { }
            column(CRB_Rating; "CRB Rating") { }
            column(Loan_Appraised_By; "Loan Appraised By") { }
            //column(Loan Recovery Officer;"Loan Recovery Officer") { }
            // column(Loan_Recovery_No_; "Loan Recovery No.") { }
            // column(SMS_Sent; "SMS Sent") { }
            // column(Available_Credit_Limit; "Available Credit Limit") { }
            // column(CRM_Captured_by; "CRM Captured by") { }
            // column(CRM_Created; "CRM Created") { }
            // column(Total_Charges_and_Commissions; "Total Charges and Commissions") { }
            // column(Loan_BDE; "Relation Officer") { }
            column(Net_Amount; "Net Amount") { }
            column(Purpose; LPurpose) { }
            // column(Picked_Mobile_Loan; "Picked Mobile Loan") { }
            // column(Repayment_Alert; "Repayment Alert") { }
            // column(Non_Performance_Alert; "Non Performance Alert") { }
            // column(Penalty_Charge; "Penalty Charge") { }
            // column(Employer_Balance; "Employer Balance") { }
            // column(Total_Balance; "Total Balance") { }
            // column(Total_TopUp; "Total TopUp") { }
            // column(Demand_Letter_Date; "Demand Letter Date") { }
            // // column(Demand_Letter_Status; "Demand Letter Status") { }
            // column(Total_Loan_Balance; "Total Loan Balance") { }
            // column(Loan_Amount; "Loan Amount") { }
            // column(Interest_Paid; "Interest Paid") { }
            // column(Principle_Paid; "Principle Paid") { }
            // column(Approved_By; "Approved By") { }
            //column(CompletionDate;"Completion Date") { }
            //column(Source;Source) { }
            column(Loan_Amount_in_Words; "Loan Amount in Words") { }
            column(SaccoAddress; SaccoAddress) { }
            column(SaccoName; SaccoName) { }
            column(SaccoPhysicalAddress; SaccoPhysicalAddress) { }
            column(TotalLoansEndofPeriodWords; TotalLoansEndofPeriodWords) { }
            column(TotalLoansEndofPeriod; TotalLoansEndofPeriod) { }
            column(SaccoEmail; SaccoEmail) { }
            column(SaccoWebsite; SaccoWebsite) { }
            column(SaccoPicture; CompanyInformation.Picture) { }
            column(CEONAME; CompanyInformation."CEO") { }
            column(BankName; CompanyInformation."Bank Name") { }
            column(BankBranch; CompanyInformation."Bank Branch") { }
            column(BankAccountNo; CompanyInformation."Bank Account No.") { }
            column(Bank_Name_2; CompanyInformation."Bank 2") { }
            column(BankBranch2; CompanyInformation."Bank Branch 2") { }
            column(BankAccountNo2; CompanyInformation."Bank A/C No. 2") { }
            column(AmountinWords; AmmountinWords) { }
            column(Bussiness_Loans_Officer; CompanyInformation."Business Loans Officer") { }
            column(MemberPhoneNo; Member."Phone No.") { }
            column(Loan_GuaType; LoanGua."Guarantor Type") { }
            column(Loan_Security_Name; LoanGua."Name") { }
            column(Loan_Gua_Deposit; LoanGua."Deposits/Shares") { }
            column(Colateral_Reg_No; LoanGua."Collateral Reg. No.") { }
            column(Amount_Guaranteed; LoanGua."Amount Guaranteed") { }
            column(Purpose_of_loan; Purpose_of_loan) { }
            column(Interest_pa; Interest_pa) { }
            column(CustPhone; CustPhone) { }
            trigger OnAfterGetRecord();
            var
                CompanyInformation: Record "Company Information";
                Customer: Record Customer;
                MemberLoan: Record Customer;
                Acc: Record "Savings Accounts";
                EmployerName: Text;
                CustAddress: Text;
                Insurance: Integer;
                ProcessingFee: Decimal;
                Installments: Integer;
                PrincipleLoan: Decimal;
                Interest: Decimal;
                rate: Decimal;
                MonthlLoanRepay: Decimal;
                AccDeposits: Decimal;
                LRepayment: Decimal;
                CompletionDate: Date;
                ProductChargesLoans: Record "Loan Product Charges";
                Member: Record Members;
                LoanApp: Record Loans;
                CheckReport: Report Check;
                TotalCharges: Decimal;
                Filename: Text;
                NumberText: Text;
                NumberText1: Text;
                LoanPuporse: Record "Loan Purpose";


            begin
                CompanyInformation.GET();

                IF Customer.GET(Loans."Employer Code") THEN
                    //EmployerName := Customer.Name;
                    //CustAddress := '';
                    //Insurance := 0;
                    ProcessingFee := 0;
                Installments := 0;
                PrincipleLoan := 0;
                Interest := 0;
                rate := 0;
                MonthlLoanRepay := 0;
                TotalLoansEndofPeriod := 0;
                AccDeposits := 0;
                LRepayment := 0;
                Interest_pa := 0;
                MemberPhoneNo := '';
                ID_No := '';
                Member_Deposits := 0;

                //IF CustMemb.GET("Customer No.") THEN
                IF Customer.GET(Loans."Member No.") THEN
                    CustAddress := Customer."Address";

                //CustPhone := Customer."Phone No.";

                if Member.GET(Loans."Member No.") then begin
                    MemberPhoneNo := Member."Phone No.";
                    ID_No := Member."Primary Identification";
                end;
                if LoanPuporse.Get(Loans."Purpose of Loan") then
                    LPurpose := LoanPuporse.Description;



                if Loans.GET(Loans."Member No.") then
                    Member_Deposits := Loans."Member Deposits";


                Acc.RESET;
                //Acc.SETRANGE("Customer No.","Customer No.");
                Acc.SETRANGE("Product Category", Acc."Product Category"::"BOSA Deposits");
                IF Acc.FIND('-') THEN
                    Acc.CALCFIELDS("Balance (LCY)");
                AccDeposits := Acc."Balance (LCY)";
                LRepayment := Loans.Repayment;
                IF Loans."New No. of Installment" > 0 THEN
                    Installments := Loans."New No. of Installment"
                ELSE
                    Installments := Loans.Installments;

                CompletionDate := CALCDATE(FORMAT(Installments) + 'M', "Repayment Start Date");
                TotalLoansEndofPeriod := Loans."Approved Amount" + (Loans."Approved Amount" * Loans.Interest * Loans.Installments * 0.01);

                // CheckReport.InitTextVariable();
                // CheckReport.FormatNoText(TotalLoansEndofPeriodWords,TotalLoansEndofPeriod,'');
                // CheckReport.InitTextVariable();
                // CheckReport.FormatNoText(NumberText,Loans."Approved Amount",'');

                // CheckReport.InitTextVariable();
                // CheckReport.FormatNoText(AmmountinWords,"Approved Amount",'');
                // CheckReport.InitTextVariable();
                // CheckReport.FormatNoText(NumberText,Loans."Approved Amount",'');

                Loans.RESET;
                if "Loan No." <> '' then
                    Loans.SETRANGE("Loan No.", "Member No.", "Loan Product Type");
                if Loans.Interest > 0 then begin
                    Interest_pa := Loans.Interest;
                end;

                ProductChargesLoans.RESET;
                //ProductChargesLoans.SETRANGE("Loan No",Loans."Loan No.");
                //ProductChargesLoans.SETRANGE("Charge Code",'0001');
                //ProductChargesLoans.SETRANGE(Applicable,TRUE);
                IF ProductChargesLoans.FIND('-') THEN
                    ProcessingFee := ProductChargesLoans.Percentage;


                // LoanGua.GET;
                IF LoanGua.GET("Loan No.") THEN BEGIN
                    IF LoanGua."Guarantor Type" = LoanGua."Guarantor Type"::"Guarantor" THEN BEGIN
                        LoanGua.GET(LoanGua."Name");
                        IF LoanGua.GET(LoanGua."Name") THEN BEGIN
                            IF LoanGua."Guarantor Type" = LoanGua."Guarantor Type"::"Guarantor" THEN BEGIN
                                IF LoanGua."Deposits/Shares" > 0 THEN
                                    Amount_Guaranteed := LoanGua."Deposits/Shares";
                                IF LoanGua."Collateral Reg. No." <> '' THEN
                                    Colateral_Reg_No := LoanGua."Collateral Reg. No.";
                            END;
                        END;
                    END;
                END;


                /*IF Loans.Posted=FALSE THEN BEGIN
				  IF CONFIRM('Are you sure you want to send sms to member to come sign loan agreement letter?') THEN BEGIN
				  //sms
				  CompanyInformation.GET();
					   IF Mem.GET("Member No.") THEN BEGIN
						SendSMS.SendSms(SourceType::"Loan Appraisal",Mem."Mobile Phone No",'Your '+"Loan Product Type Name"+' of KES'+FORMAT("Approved Amount")+' '+'is ready for payment. Please come and sign the loan agreement form at '+
						CompanyInformation.Name+'. Thank you.',
						 "Loan No.","Disbursement Account No",FALSE);
						 END;
				  END;
				  END;*/


                // Send Email;
                // LoanApp.RESET;
                // LoanApp.SETRANGE("Loan No.",Loans."Loan No.");
                // IF Loans.Posted=FALSE THEN BEGIN
                // //IF LoanApp.FINDFIRST THEN BEGIN
                // IF NOT CONFIRM('Are you sure you want to send email notification?') THEN EXIT;
                // Member.RESET;
                // Member.SETRANGE("No.","Member No.");
                // IF Member.FIND('-') THEN BEGIN
                //  IF Member."E-Mail"<>'' THEN BEGIN
                // Filename:= 'C:\Member Statement\'+Loans."Loan No."+'LoanAgreement.pdf';

                // IF EXISTS(Filename) THEN
                // ERASE(Filename);

                // SMTPSetup.GET;
                // Filename:= 'C:\Member Statement\'+Loans."Loan No."+'LoanAgreement.pdf';
                // REPORT.SAVEASPDF(REPORT::"Loan Repayment Agreement",Filename,Loans);

                // //REPORT.RUN(39006000,TRUE,FALSE,MemberwithdrawalNotice);
                //  REPORT.SAVEASPDF(REPORT::"Loan Repayment Agreement",Filename,Loans);

                // END;

                // SMTPMail.CreateMessage(SMTPSetup."Email Sender Name",SMTPSetup."Email Sender Address",Member."E-Mail",'Loan Agreement','',TRUE);
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody('Dear '+Member.Name);
                // SMTPMail.AppendBody('<br><br>');
                // //  SMTPMail.AppendBody('K'+CompanyInformation.Name+'.');
                // //SMTPMail.AppendBody('<br>');
                // SMTPMail.AppendBody('Your '+"Loan Product Type Name"+' of KES'+FORMAT("Approved Amount")+' '+'is ready for payment. Please come and sign the loan agreement form at '+
                // 'our offices.Alternatively you can sign and send back a copy of the attached loan agrrement slip');
                // SMTPMail.AppendBody('<br>');
                // SMTPMail.AppendBody('<br><br>');
                //  SMTPMail.AppendBody('Thank You'+'.');
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody('Kind Regards');
                // SMTPMail.AppendBody(CompanyInformation.Name);
                // SMTPMail.AppendBody('*****************************.');
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
                // SMTPMail.AppendBody('<br><br>');
                // SMTPMail.AppendBody('<HR>');
                // SMTPMail.AppendBody('This is a system generated mail.For any complains/ compliments call '+CompanyInformation."Phone No."+'.');
                // SMTPMail.AddAttachment('C:\Member Statement\'+"Loan No."+'LoanAgreement.pdf',Filename);

                // SMTPMail.Send;

                // IF EXISTS(Filename) THEN
                // ERASE(Filename);
                // END;
                // END;

            end;

        }
    }
    requestpage
    {
        SaveValues = true;
    }

    trigger OnPreReport()
    begin
        CompanyInformation.GET();
        CompanyInformation.CALCFIELDS(Picture);
        SaccoAddress := CompanyInformation.Address;
        SaccoName := CompanyInformation.Name;
        SaccoPhysicalAddress := CompanyInformation."Address 2";
        SaccoEmail := CompanyInformation."E-Mail";
        SaccoWebsite := CompanyInformation."Home Page";

    end;


    var
        CompanyInformation: Record "Company Information";
        loanPurpose: Record "Loan Purpose";
        LPurpose: Text;
        TotalFor: label 'Total for ';
        Intallments__Months_CaptionLbl: label 'Intallments (Months)';
        Disbursment_DateCaptionLbl: label 'Disbursment Date';
        Current_InterestCaptionLbl: label 'Current Interest';
        Loan_AmountCaptionLbl: label 'Loan Amount';
        Loan_ProductCaptionLbl: label 'Loan Product';
        Loan_No_CaptionLbl: label 'Loan No.';
        Account_No_CaptionLbl: label 'Account No.';
        Monthly_RepaymentCaptionLbl: label 'Monthly Repayment';
        InterestCaptionLbl: label 'Interest';
        Principal_RepaymentCaptionLbl: label 'Principal Repayment';
        Due_DateCaptionLbl: label 'Due Date';
        Loan_BalanceCaptionLbl: label 'Loan Balance';
        Loan_RepaymentCaptionLbl: label 'Loan Repayment';
        TotalCaptionLbl: label 'Total';
        ReportForNavTotalsCausedBy: Integer;
        ReportForNavInitialized: Boolean;
        ReportForNavShowOutput: Boolean;
        "Loan Amount in Words": Text;
        SaccoAddress: Text;
        SaccoName: Text;
        SaccoPhysicalAddress: Text;
        TotalLoansEndofPeriodWords: Text;
        TotalLoansEndofPeriod: Decimal;
        SaccoEmail: Text;
        SaccoWebsite: Text;
        CEONAME: Text;
        BankName: Text;
        BankBranch: Text;
        BankAccountNo: code[20];
        Bank_Name_2: Text;
        BankBranch2: Text;
        BankAccountNo2: Text;
        AmmountinWords: Text;
        CheckReport: Report Check;
        Bussiness_Loans_Officer: Text;
        MemberPhoneNo: Code[20];
        Member: Record Members;
        Amount_Guaranteed: Decimal;
        Colateral_Reg_No: Code[20];
        Loan_Gua_Deposit: Decimal;
        Loan_Security_Name: Text;
        Loan_GuaType: Text;
        Purpose_of_loan: Text;
        Interest_pa: Decimal;
        CustPhone: Code[20];
        ID_No: Code[20];
        Member_Deposits: Decimal;
        LoanGua: Record "Loan Guarantors and Security";
    //LoanGua2: Record "Loan Guarantors and Security2";
}

