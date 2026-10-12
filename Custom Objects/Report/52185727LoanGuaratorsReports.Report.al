report 52185727 "Loan Guarators Reports"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Guarators Reports.rdl';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Loan Guarantors Report';

    dataset
    {
        dataitem("Credit Accounts"; "Credit Accounts")
        {
            RequestFilterFields = "No.", "Member No.";

            column(CompName; CompanyNam) { }
            column(CommunicationOnline; CommunicationOnline) { }
            column(CompAddress; CompanyAddress) { }
            column(CompPic; Company.Picture) { }
            column(PrintDateTime; Format(CurrentDateTime, 0, '<Day,2>/<Month,2>/<Year4> <Hours24,2>:<Minutes,2>')) { }

            // Member Header Details (Fetched from Members record below)
            column(No_Members; "Member No.") { }
            column(Name_Members; MemberName) { }
            column(PayrollStaffNo_Members; MemberStaffNo) { }
            column(EmployerCode_Members; MemberEmpCode) { }
            column(EmployerName_Members; MemberEmpName) { }

            dataitem(Loans; Loans)
            {
                DataItemLink = "Member No." = field("Member No.");
                
                column(LoanNo_Loans; "Loan No.") { }
                column(LoanProductType_Loans; "Loan Product Type") { }
                column(LoanProductTypeNam; "Loan Product Type Name") { }
                column(Staff_No; "Staff No") { }
                column(OutStanding_Interest; "Outstanding Interest") { }

                dataitem("Loan Guarantors and Security"; "Loan Guarantors and Security")
                {
                    DataItemLink = "Loan No" = field("Loan No.");
                    DataItemTableView = where("Outstanding Balance" = filter(> 0), Substituted = const(false));

                    column(MemberNo_LoanGuarantors; "Member No") { }
                    column(Name_LoanGuarantors; Name) { }
                    column(AmontGuaranteed_LoanGuarantors; "Amount Guaranteed") { }
                    column(StaffPayrollNo_LoanGuarantors; GuarantorStaffNo) { }
                    column(Substituted_LoanGuarantors; Substituted) { }
                    column(OutstandingBalance_LoanGuarantors; "Outstanding Balance") { }
                    column(TLoan; TotalLoan) { }
                    column(MmberDeceased; MmberDeceased) { }
                    column(PercentageGur; PercentageGur) { }

                    trigger OnAfterGetRecord()
                    var
                        MemB: Record Members;
                    begin
                        TotalLoan := 0;
                        MmberDeceased := false;
                        GuarantorStaffNo := '';
                        PercentageGur := 0;

                        GuarantorStaffNo := "Staff/Payroll No.";
                        TotalLoan := "Outstanding Balance" + Loans."Outstanding Interest";

                        if MemB.Get("Member No") then begin
                            if MemB."Payroll/Staff No." <> '' then
                                GuarantorStaffNo := MemB."Payroll/Staff No.";

                            if MemB.Status = MemB.Status::Deceased then
                                MmberDeceased := true;
                        end;

                        if TotaAmtGUR <> 0 then begin
                            PercentageGur := Round((("Amount Guaranteed" / TotaAmtGUR) * 100), 0.01, '=');
                        end;
                    end;
                } // End of Guarantors DataItem

                trigger OnAfterGetRecord()
                var
                    LoanGua: Record "Loan Guarantors and Security";
                begin
                    // Fix 1: Calculate flowfields
                    CalcFields("Outstanding Balance", "Outstanding Interest");

                    // Fix 2: Pre-calculate the total guaranteed amount once per loan
                    TotaAmtGUR := 0;
                    LoanGua.Reset();
                    LoanGua.SetRange("Loan No", "Loan No.");
                    LoanGua.SetRange("Guarantor Type", LoanGua."Guarantor Type"::Guarantor);
                    if LoanGua.FindSet() then begin
                        LoanGua.CalcSums("Amount Guaranteed");
                        TotaAmtGUR := LoanGua."Amount Guaranteed";
                    end;
                end;
            } // End of Loans DataItem

            trigger OnPreDataItem()
            begin
                Clear(ProcessedMembers);
            end;

            trigger OnAfterGetRecord()
            var
                Mem: Record Members;
            begin
                // Fix Duplication: If this Member No. was already processed via another account, skip it!
                if ProcessedMembers.Contains("Member No.") then
                    CurrReport.Skip();
                
                ProcessedMembers.Add("Member No.");

                // Fetch Member details manually to display in the RDLC header
                if Mem.Get("Member No.") then begin
                    MemberName := Mem.Name;
                    MemberStaffNo := Mem."Payroll/Staff No.";
                    MemberEmpCode := Mem."Employer Code";
                    Mem.CalcFields("Employer Name");
                    MemberEmpName := Mem."Employer Name";
                end else begin
                    MemberName := Name; 
                    MemberStaffNo := '';
                    MemberEmpCode := '';
                    MemberEmpName := '';
                end;
            end;
        } // End of Credit Accounts DataItem
    }

    requestpage
    {
        SaveValues = true;
        layout { }
        actions { }
    }

    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Picture);
        CompanyNam := Company.Name;
        CompanyAddress := Company.Address + ' -Post Code: ' + Company."Post Code" + ' -City:' + Company.City + ' Region: ' + Company."Country/Region Code";
        CompanyTelephone := 'Tel: ' + Company."Phone No." + ' -Office Tel: ' + Company."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + Company."E-Mail" + ' - Website: ' + Company."Home Page";
    end;

    var
        Company: Record "Company Information";
        ProcessedMembers: List of [Code[50]];
        MemberName: Text;
        MemberStaffNo: Code[50];
        MemberEmpCode: Code[50];
        MemberEmpName: Text;
        TotalLoan: Decimal;
        PercentageGur: Decimal;
        CompanyNam: Text;
        CompanyTelephone: Text;
        CompanyAddress: Text;
        MmberDeceased: Boolean;
        CommunicationOnline: Text;
        TotaAmtGUR: Decimal;
        GuarantorStaffNo: Code[50];
}