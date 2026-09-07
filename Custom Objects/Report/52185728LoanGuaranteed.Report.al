#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185728 "Loan Guaranteed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Guaranteed.rdl';
    Caption = 'Loans Guaranteed Report';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Members; "Members")
        {
            RequestFilterFields = "No.", "Payroll/Staff No.";
            
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyAddress) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CompanyEmail; CompanyEmail) { }
            column(PrintDateTime; Format(CurrentDateTime, 0, '<Day,2>/<Month,2>/<Year4> <Hours24,2>:<Minutes,2>')) { }

            column(ReportForNavId_1; 1) { }
            column(CompPic; Company.Picture) { }
            column(No_Member; Members."No.") { }
            column(Name_Member; Members.Name) { }
            column(EmployerCode_Members; Members."Employer Code") { }
            column(EmployerName_Members; Members."Employer Name") { }

            dataitem("Loan Guarantors and Security"; "Loan Guarantors and Security")
            {
                DataItemLink = "Member No" = field("No.");
                RequestFilterFields = "Total Loan Balance";
                DataItemTableView = where("Outstanding Balance" = filter(> 0), Substituted = const(false));
                
                column(ReportForNavId_4; 4) 
                { 
                    
                }
                column(LoanNo_LoanGuarantors; "Loan Guarantors and Security"."Loan No") 
                { 

                }
                column(SACCOAccountNo_LoanGuarantors; "Loan Guarantors and Security"."Savings Account No./Member No.") 
                { 

                }
                column(Name_LoanGuarantors; "Loan Guarantors and Security".Name) 
                { 

                }
                column(LoanBalance_LoanGuarantors; "Loan Guarantors and Security"."Loan Balance") 
                { 

                }
                column(Shares_LoanGuarantors; "Loan Guarantors and Security"."Deposits/Shares") 
                { 

                }
                column(NoOfLoansGuaranteed_LoanGuarantors; "Loan Guarantors and Security"."No Of Loans Guaranteed") 
                {

                 }
                column(Substituted_LoanGuarantors; "Loan Guarantors and Security".Substituted) 
                { 

                }
                column(Date_LoanGuarantors; "Loan Guarantors and Security".Date) 
                { 

                }
                column(SharesRecovery_LoanGuarantors; "Loan Guarantors and Security"."Shares Recovery") 
                {

                 }
                column(NewUpload_LoanGuarantors; "Loan Guarantors and Security"."New Upload") 
                {

                 }
                column(AmountGuaranteed_LoanGuarantors; "Loan Guarantors and Security"."Amount Guaranteed") { }
                column(StaffPayrollNo_LoanGuarantors; "Loan Guarantors and Security"."Staff/Payroll No.") { }
                column(AccountNo_LoanGuarantors; "Loan Guarantors and Security"."Account No.") { }
                column(SelfGuarantee_LoanGuarantors; "Loan Guarantors and Security"."Self Guarantee") { }
                column(IDNo_LoanGuarantors; "Loan Guarantors and Security"."ID No.") { }
                column(OutstandingBalance_LoanGuarantors; "Loan Guarantors and Security"."Outstanding Balance") { }
                column(MemberGuaranteed_LoanGuarantors; "Loan Guarantors and Security"."Member Guaranteed") { }
                column(PercentageGuaranteed_LoanGuarantors; "Loan Guarantors and Security".PercentageGur) { }
                column(TotalGuaranteed_LoanGuarantors; "Loan Guarantors and Security"."Total Guaranteed") { }
                column(AvailableShares_LoanGuarantors; "Loan Guarantors and Security"."Available Shares") { }
                column(MemberNo_LoanGuarantors; "Loan Guarantors and Security"."Member No") { }
                column(LoanType_LoanGuarantors; "Loan Guarantors and Security"."Loan Type") { }
                column(LoaneeName_LoanGuarantors; "Loan Guarantors and Security"."Loanee Name") { }
                
                column(lNAME; LOANEE) { }
                column(MemberNo; MemberNo) { }
                column(StaffNo; StaffNo) { }
                column(LoanPrdtName; LoanPrdtName) { }
                column(Rno; Rno) { }
                column(Status; Status) { }
                column(EmpName; EmpName) { }
                column(EmpCode; EmpCode) { }

                trigger OnAfterGetRecord()
                begin
                    Rno := Rno + 1;

                    "Deposits/Shares" := 0;
                    if Loanss.Get("Loan No") then begin
                        Loanss.CalcFields(Loanss."Outstanding Balance");
                    end;
                    
                    if Loanss.Get("Loan Guarantors and Security"."Loan No") then begin
                        LOANEE := Loanss."Member Name";
                        MemberNo := Loanss."Member No.";
                        StaffNo := Loanss."Staff No";
                        LoanPrdtName := Loanss."Loan Product Type Name";
                        
                        if Guarantors.Get(Loanss."Member No.") then begin
                            EmpCode := Guarantors."Employer Code";
                            EmpName := Guarantors."Employer Name";
                        end;
                        
                        if Loanss.Posted = false then CurrReport.Skip;
                    end;
                    
                    if "Loan Guarantors and Security"."Outstanding Balance" > 0 then
                        Status := 'Active' 
                    else
                        Status := 'Released';
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;
        layout { }
        actions { }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        CompanyAddress := 'P.O BOX ' + CompanyInfo."Post Code" + ', ' + CompanyInfo.City;
        CompanyTelephone := 'TEL: ' + CompanyInfo."Phone No." + ', ' + CompanyInfo."Phone No. 2";
        CompanyEmail := CompanyInfo."E-Mail";

        Company.Get;
        Company.CalcFields(Company.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        Loanss: Record Loans;
        Cust: Record "Members";
        Shares: Decimal;
        Cust2: Record Customer;
        LoanGaurantors: Record "Loan Guarantors and Security";
        LCount: Integer;
        A: Decimal;
        T: Decimal;
        LoanApps: Record Loans;
        Lamount: Decimal;
        LGBalance: Decimal;
        "Account No": Code[10];
        LOANEE: Text[80];
        MemberNo: Code[20];
        StaffNo: Code[20];
        LoanPrdtName: Text;
        PrdtFactory: Record "Product Factory";
        Rno: Integer;
        Company: Record "Company Information";
        Status: Text;
        EmpCode: Code[30];
        EmpName: Text[50];
        Guarantors: Record "Members";
        "Total Oustanding >0": Boolean;
}
