namespace MNS.MNS;
using Microsoft.Foundation.Company;
using Microsoft.Bank.Check;

report 52186095 "Loan Offer Letter Buss Loans"
{
    ApplicationArea = All;
    Caption = 'Loan Offer Letter Buss Loans';
    DefaultLayout = Word;
    WordLayout = './bc-azima-2026/Layout/Loan Offer Letter Buss Loans.docx';
    //UsageCategory = Documents;
    dataset
    {
        dataitem(Loans; Loans)
        {
            //DataItemTableView = where(Status = filter(Approved));
            column(PrintingDate; PrintingDate) { }
            column(CompanyInformation_Name; CompanyInformation.Name) { }
            column(CompanyInformation_Picture; CompanyInformation.Picture) { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CommunicationOnline; CommunicationOnline) { }
            column(CompanyEmail; CompanyEmail) { }
            column(PrimaryIDType; PrimaryIDType) { }
            column(PrimaryIDNo; PrimaryIDNo) { }
            column(MemberPhoneNo; MemberPhoneNo) { }
            column(Member_No_; "Member No.") { }
            column(Member_Name; "Member Name") { }
            column(Loan_Product_Type; "Loan Product Type Name") { }
            column(LoanPurpose; LPurpose) { }
            column(Approved_Amount; "Approved Amount") { }
            column(ApprovedAmountText; ApprovedAmountText[1]) { }
            column(LoanAmountInFiguresAndWords; LoanAmountInFiguresAndWords) { }
            column(Interest; Interest) { }
            column(Installments; Installments) { }
            column(Repayment; Repayment) { }
            column(LoanSecurities; LoanSecurities) { }
            column(LoanTermsAndConditions; LoanTermsAndConditions) { }
            column(BusinesLoansOfficer; BusinesLoansOfficer) { }


            trigger OnAfterGetRecord();
            var
                CompanyInformation: Record "Company Information";
            begin
                PrintingDate := ' ';
                PrintingDate := GlobalFunctions.FormatDateFullMonth(Today);



                if CompanyInformation.GET() then begin
                    CompanyAddress := CompanyInformation.Address;
                    CompanyTelephone := CompanyInformation."Phone No.";
                    CompanyEmail := CompanyInformation."E-Mail";
                    BusinesLoansOfficer := CompanyInformation."Business Loans Officer";
                end;
                //end;

                //IF CustMemb.GET("Customer No.") THEN
                // IF Customer.GET(Loans."Member No.") THEN
                //     CustAddress := Customer."Address";

                //CustPhone := Customer."Phone No.";

                if Member.GET(Loans."Member No.") then begin
                    MemberPhoneNo := Member."Phone No.";
                    PrimaryIDType := FORMAT(Member."Primary Identification Type");
                    PrimaryIDNo := Member."Primary Identification";
                end;
                if LoanPurpose.Get(Loans."Purpose of Loan") then
                    LPurpose := LoanPurpose.Description;

                if LoanGuarantorsandSecurity.GET("Loan No.") then begin
                    IF LoanGuarantorsandSecurity."Guarantor Type" = LoanGuarantorsandSecurity."Guarantor Type"::Collateral THEN begin
                        repeat
                            LoanCollateral += 'Joint Registration over ' + LoanGuarantorsandSecurity."Name" + ' ' + LoanGuarantorsandSecurity."Collateral Reg. No." + ' and ' + CompanyInformation.Name + 'Worth KES. ' + FORMAT(LoanGuarantorsandSecurity."Collateral Value") + '.00.';
                        until LoanGuarantorsandSecurity.NEXT = 0;
                    end;
                    IF LoanGuarantorsandSecurity."Guarantor Type" = LoanGuarantorsandSecurity."Guarantor Type"::Guarantor THEN begin
                        repeat
                            LoanGuarantor += 'Loan Guarantor ' + LoanGuarantorsandSecurity.Name + ' ' + FORMAT(loanGuarantorsandSecurity."Amount Guaranteed") + '.00.';
                        until LoanGuarantorsandSecurity.NEXT = 0;
                    end;

                    if LoanGuarantorsandSecurity."Guarantor Type" = LoanGuarantorsandSecurity."Guarantor Type"::Lien then begin
                        repeat
                            LoanLien += 'SACCO Deposits worth ' + Format(LoanGuarantorsandSecurity."Amount Guaranteed") + '.00.';
                        until LoanGuarantorsandSecurity.NEXT = 0;
                    end;

                    LoanSecurities := LoanCollateral + LoanGuarantor + LoanLien;
                end;

                CheckReport.InitTextVariable();

                CheckReport.FormatNoText(ApprovedAmountText, "Approved Amount", '');

                //LoanAmountInFiguresAndWords := 'Ksh.' + FORMAT(Loans."Approved Amount") + '/-' +  ApprovedAmountText + 'Only.';

                TermsAndConditions.RESET;
                TermsAndConditions.SetRange("Loan No.", Loans."Loan No.");
                if TermsAndConditions.fIND('-') then begin
                    repeat
                        LoanTermsAndConditions += TermsAndConditions.Comment + ' ';
                    until TermsAndConditions.NEXT = 0;
                end;

                // Clear(List);
                // LoanGuarantors.Reset();
                // LoanGuarantors.SetRange("Loan No", Loans."Loan No.");
                // LoanGuarantors.SetRange(Substituted, false);
                // if LoanGuarantors.Find('-') then begin
                //     repeat
                //         if not List.Contains(Format(LoanGuarantors."Guarantor Type")) then
                //             List.Add(Format(LoanGuarantors."Guarantor Type"));
                //     until LoanGuarantors.Next() = 0;

                //     for i := 1 to List.COUNT do begin
                //         LoanSecurities += List.GET(i);
                //         if i < List.COUNT then
                //             NewLoanSecurities += ',';
                //     end;
                // end else
                //     NewLoanSecurities := 'None';


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

                // ProductChargesLoans.RESET;
                // //ProductChargesLoans.SETRANGE("Loan No",Loans."Loan No.");
                // //ProductChargesLoans.SETRANGE("Charge Code",'0001');
                // //ProductChargesLoans.SETRANGE(Applicable,TRUE);
                // IF ProductChargesLoans.FIND('-') THEN
                //     ProcessingFee := ProductChargesLoans.Percentage;


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
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        GlobalFunctions: Codeunit "Global Functions";
        LoanGuarantors: Record "Loan Guarantors and Security";
        LoanSecurities: Text;
        NewLoanSecurities: Text;
        i: Integer;
        List: list of [Text];
        LoanGuarantorsandSecurity: Record "Loan Guarantors and Security";
        LoanCollateral: Text;
        LoanGuarantor: Text;
        LoanLien: Text;
        PrimaryIDType: Text;
        PrimaryIDNo: Text;
        ApprovedAmountText: array[2] of Text[680];
        CheckReport: Report Check;
        TermsAndConditions: Record "Loan Terms And Conditions";
        LoanTermsAndConditions: Text;
        BusinesLoansOfficer: Text;
        LoanAmountInFiguresAndWords: Code[250];







        CompletionDate: Date;
        Acc: Record "Savings Accounts";
        AccDeposits: Decimal;
        LRepayment: Decimal;
        LoanPurpose: Record "Loan Purpose";
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
        //CheckReport: Report Check;
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

