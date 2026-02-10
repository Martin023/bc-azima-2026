#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185754 "Loan Attachment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Attachment.rdl';

    dataset
    {
        dataitem("Loan Recovery Header"; "Loan Recovery Header")
        {
            RequestFilterFields = "Recovery Type", Action, "Header Reversed", "Disbursement Date";
            DataItemTableView = where("Recovery Type" = const("Recovery and attachment"), Action = const(Recovered));

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
            column(No_; "No.")
            {

            }
            column(HeaderMemberNo; "Member No.")
            {

            }
            column(HeaderName; Name)
            {

            }
            column(HeaderIdentifier; HeaderIdentifier)
            {

            }
            column(HeaderStaffNo; HeaderStaffNo)
            {

            }

            column(HeaderPostingDate; HeaderPostingDate)
            {

            }
            column(HeaderPrincipleAttached; HeaderPrincipleAttached)
            {

            }
            column(HeaderInterestAttached; HeaderInterestAttached)
            {

            }
            column(HeaderLoanNo; "Loan No.")
            {

            }
            column(HeaderCatSASRA; HeaderCatSASRA)
            {

            }
            column(HeaderTotalLoanBalance; "Total Balance")
            {

            }
            column(HeaderDepositsRecovered; HeaderDepositsRecovered)
            {

            }
            column(HeaderLoanType; HeaderLoanType)
            {

            }
            column(HeaderReversed; HeaderReversed)
            {

            }
            column(HeaderInterestCalculationMethod; HeaderInterestCalculationMethod)
            {

            }
            column(HeaderPercentage; HeaderPercentage)
            {

            }
            column(HeaderGender; HeaderGender)
            {

            }
            column(HeaderDOB; HeaderDOB)
            {

            }
            column(HeaderAge; HeaderAge)
            {

            }
            column(HeaderInstallments; HeaderInstallments)
            {

            }
            column(HeaderRepayment; HeaderRepayment)
            {

            }
            column(HeaderLoanDescription; HeaderLoanDescription)
            {

            }
            column(HeaderAttachedBy; HeaderAttachedBy)
            {

            }
            dataitem("Loan Recovery Lines"; "Loan Recovery Lines")
            {
                DataItemLink = "Header No." = field("No.");
                DataItemTableView = where("Recovery Type" = const("Guarantor Attachment"));
                column(Header_No_; "Header No.")
                {

                }
                column(LinesMemberNo; "Member No.")
                {

                }
                column(LinesMemberName; "Member Name")
                {

                }
                column(LinesIdentifier; LinesIdentifier)
                {

                }
                column(LinesStaffNo; LinesStaffNo)
                {

                }
                column(LinesTotalAttached; "Recovery Amount")
                {

                }
                column(LinesPrincipleAmount; "Principle Amount")
                {

                }
                column(LinesInterestAmount; "Interest Amount")
                {

                }
                column(LinesLoanNo; "Loan No.")
                {

                }
                column(LinesPercentage; LinesPercentage)
                {

                }
                column(LinesPercentageOnly; LinesPercentageOnly)
                {

                }
                column(LinesGender; LinesGender)
                {

                }
                column(LinesDOB; LinesDOB)
                {

                }
                column(LinesAge; LinesAge)
                {

                }
                column(LinesOLB; LinesOLB)
                {

                }
                column(LinesInstallments; LinesInstallments)
                {

                }
                column(LinesRepayment; LinesRepayment)
                {

                }
                column(LinesLoanDescription; LinesLoanDescription)
                {

                }
                column(LinesOutstandingInstallments; LinesOutstandingInstallments)
                {

                }
                column(LinesCatSASRA; "Attached Loan Category")
                {

                }
                column(LinesLoanType; LinesLoanType)
                {

                }
                column(LinesIntCalcMethod; LinesIntCalcMethod)
                {

                }


                trigger OnAfterGetRecord()
                var
                    GuarantorMember: Record Members;
                    GuarantorLoan: Record Loans;
                begin
                    LinesIdentifier := '';
                    LinesPercentage := 0;
                    LinesGender := '';
                    LinesDOB := '';
                    LinesOLB := 0;
                    LinesInstallments := 0;
                    LinesLoanDescription := '';
                    LinesOutstandingInstallments := 0;


                    if Members.Get("Loan Recovery Lines"."Member No.") then begin
                        LinesIdentifier := Members."Primary Identification";
                        if LinesIdentifier = '' then
                            LinesIdentifier := Members."Secondary Identification";
                        LinesPercentage := Round(("Loan Recovery Lines"."Recovery Amount" / "Loan Recovery Header"."Total Balance") * 100, 0.01, '=');
                        LinesPercentageOnly := Round(("Loan Recovery Lines"."Recovery Amount" / ("Loan Recovery Header"."Total Balance" - "Loan Recovery Header"."Amount To Use")) * 100, 0.01, '=');
                        LinesGender := Format(Members.Gender);
                        if Members."Date of Birth" <> 0D then begin
                            LinesDOB := GlobalFunctions.FormatDate(Members."Date of Birth");
                            LinesAge := Round(((Today - Members."Date of Birth") / 360), 1);
                        end;
                        LinesStaffNo := Members."Payroll/Staff No.";
                        "Loan Recovery Header".GetLoanBalances("Loan Recovery Lines"."Loan No.", OutInt, OutBal, TotalBal);
                        LinesOLB := TotalBal;
                        if Loans.Get("Loan Recovery Lines"."Loan No.") then begin
                            LinesLoanType := Loans."Loan Product Type";
                            LinesInstallments := Loans.Installments;
                            ProductFactory.Get(Loans."Loan Product Type");
                            LinesLoanDescription := ProductFactory."Product Description";
                            LinesOutstandingInstallments := LinesInstallments;
                            LinesIntCalcMethod := Format(Loans."Interest Calculation Method");

                            RepaymentSchedule.Reset();
                            RepaymentSchedule.SetRange("Loan No.", Loans."Loan No.");
                            RepaymentSchedule.SetFilter("Repayment Date", '>=%1', Today);
                            if RepaymentSchedule.Find('-') then
                                LinesOutstandingInstallments := RepaymentSchedule.Count;
                        end;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                HeaderIdentifier := '';
                HeaderPrincipleAttached := 0;
                HeaderDepositsRecovered := 0;
                HeaderLoanType := '';
                HeaderReversed := '';
                HeaderInterestCalculationMethod := '';
                HeaderPercentage := 0;
                HeaderGender := '';
                HeaderDOB := ' ';
                HeaderInstallments := 0;
                HeaderLoanDescription := '';
                HeaderAttachedBy := '';

                RecoveryLines.Reset();
                RecoveryLines.SetRange("Header No.", "Loan Recovery Header"."No.");
                RecoveryLines.SetRange("Recovery Type", RecoveryLines."Recovery Type"::"Deposits Recovery");
                if RecoveryLines.FindFirst() then begin
                    HeaderDepositsRecovered := RecoveryLines."Recovery Amount";
                    HeaderPrincipleAttached := RecoveryLines."Principle Amount";
                    HeaderInterestAttached := RecoveryLines."Interest Amount";
                    HeaderPercentage := Round((HeaderDepositsRecovered / "Loan Recovery Header"."Total Balance") * 100, 0.01, '=');
                end;

                RepaymentSchedule.Reset();
                RepaymentSchedule.SetRange("Loan No.", "Loan Recovery Header"."Loan No.");
                RepaymentSchedule.SetFilter("Repayment Date", '>=%', "Loan Recovery Header"."Posting Date");
                if RepaymentSchedule.Find('-') then
                    HeaderInstallments := RepaymentSchedule.Count;

                HeaderLoanBalance := "Loan Recovery Header"."Total Balance";

                HeaderReversed := Format("Loan Recovery Header"."Header Reversed");
                HeaderPostingDate := GlobalFunctions.FormatDate("Loan Recovery Header"."Posting Date");

                if Members.Get("Loan Recovery Header"."Member No.") then begin
                    HeaderIdentifier := Members."Primary Identification";
                    if HeaderIdentifier = '' then
                        HeaderIdentifier := Members."Secondary Identification";
                    HeaderGender := Format(Members.Gender);
                    if Members."Date of Birth" <> 0D then begin
                        HeaderDOB := GlobalFunctions.FormatDate(Members."Date of Birth");
                        HeaderAge := Round(((Today - Members."Date of Birth") / 360), 1);
                    end;
                    HeaderStaffNo := Members."Payroll/Staff No.";

                    if Loans.Get("Loan Recovery Header"."Loan No.") then begin
                        Loans.CalcFields("Loans Category-SASRA");
                        HeaderCatSASRA := Format(Loans."Loans Category-SASRA");
                        HeaderLoanType := Loans."Loan Product Type";
                        HeaderInterestCalculationMethod := Format(Loans."Interest Calculation Method");
                        HeaderInstallments := Loans.Installments;
                        HeaderLoanDescription := Loans."Loan Product Type Name";
                        HeaderAttachedBy := GlobalFunctions.FormatUserName("Loan Recovery Header"."Posted By");
                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        //Header
        HeaderIdentifier: Code[50];
        HeaderStaffNo: Code[50];
        HeaderPrincipleAttached: Decimal;
        HeaderInterestAttached: Decimal;
        HeaderDepositsRecovered: Decimal;
        HeaderLoanType: Code[20];
        HeaderReversed: Text;
        HeaderInterestCalculationMethod: Text;
        HeaderPercentage: Decimal;
        HeaderGender: Text;
        HeaderDOB: Text;
        HeaderAge: Integer;
        HeaderInstallments: Integer;
        HeaderRepayment: Decimal;
        HeaderLoanDescription: Text;
        HeaderAttachedBy: Code[50];
        HeaderLoanBalance: Decimal;
        HeaderCatSASRA: Text;
        HeaderPostingDate: Text;


        //Lines
        LinesIdentifier: Code[50];
        LinesStaffNo: Code[50];
        LinesPercentage: Decimal;
        LinesPercentageOnly: Decimal;
        LinesGender: Text;
        LinesDOB: Text;
        LinesAge: Integer;
        LinesOLB: Decimal;
        LinesInstallments: Integer;
        LinesRepayment: Decimal;
        LinesLoanDescription: Text;
        LinesOutstandingInstallments: Integer;
        LinesLoanType: Code[50];
        LinesIntCalcMethod: Text;

        //Other Variables
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Members: Record Members;
        GlobalFunctions: Codeunit "Global Functions";
        Loans: Record Loans;
        LoanNo: Code[30];
        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;
        ProductFactory: Record "Product Factory";
        RecoveryLines: Record "Loan Recovery Lines";
        RepaymentSchedule: Record "Ideal Repayment Schedule";

}
