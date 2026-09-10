#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185558 "Guarantor Substitution Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/GuarantorSubstitutionForm.rdl';
    Caption = 'Guarantor Substitution Form';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            // We removed RequestFilterFields here to hide the messy default tabs
            
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyAddress) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CompanyEmail; CompanyEmail) { }
            column(CompanyWebsite; CompanyInfo."Home Page") { }
            
            column(LoanNo; "Loan No.") { }
            column(LoaneeNo; "Member No.") { }
            column(LoaneeName; "Member Name") { }
            column(LoaneeWNo; LoaneeWNo) { }
            column(OutstandingBal; "Outstanding Balance") { }
            column(ReportDate; Format(Today, 0, '<Day,2>/<Month,2>/<Year4>')) { }

            dataitem(OutgoingGuarantor; "Loan Guarantors and Security")
            {
                DataItemLink = "Loan No" = field("Loan No.");
                // We removed RequestFilterFields here too
                
                column(OutG_No; "Member No") { }
                column(OutG_Name; Name) { }
                column(OutGWNo; OutGWNo) { }

                dataitem(AllGuarantors; "Loan Guarantors and Security")
                {
                    DataItemLink = "Loan No" = field("Loan No");
                    
                    column(GuarantorNo; "Member No") { }
                    column(GuarantorName; Name) { }
                    column(GuarantorStaffNo; GuarantorStaffNo) { }
                    column(AmountGuaranteed; "Amount Guaranteed") { }
                    column(Substituted_LoanGuarantors; Substituted) { }
                    column(OutstandingBalance_LoanGuarantors; "Outstanding Balance") { }
                    column(OutStanding_Interest; Loans."Outstanding Interest") { }
                    column(TLoan; TotalLoan) { }
                    column(MmberDeceased; MmberDeceased) { }
                    column(PercentageGur; PercentageGur) { }
                    column(IsOutgoingInt; IsOutgoingInt) { }

                    trigger OnAfterGetRecord()
                    var
                        MemB: Record Members;
                        LoanGua: Record "Loan Guarantors and Security";
                    begin
                        IsOutgoingInt := 0;
                        if (AllGuarantors."Member No" = OutgoingGuarantor."Member No") then
                            IsOutgoingInt := 1;

                        TotalLoan := 0;
                        MmberDeceased := false;
                        GuarantorStaffNo := "Staff/Payroll No."; 
                        TotalLoan := "Outstanding Balance" + Loans."Outstanding Interest";
                        
                        if MemB.Get("Member No") then begin
                            if MemB."Payroll/Staff No." <> '' then
                                GuarantorStaffNo := MemB."Payroll/Staff No.";
                            if MemB.Status = MemB.Status::Deceased then
                                MmberDeceased := true;
                        end;
                        
                        LoanGua.Reset;
                        LoanGua.SetRange("Loan No", "Loan No");
                        LoanGua.SetRange("Guarantor Type", LoanGua."guarantor type"::Guarantor);
                        if LoanGua.Find('-') then begin
                            LoanGua.CalcSums("Amount Guaranteed");
                            TotaAmtGUR := LoanGua."Amount Guaranteed";
                        end;
                        
                        if TotaAmtGUR <> 0 then begin
                            PercentageGur := Round(((("Amount Guaranteed" / TotaAmtGUR) * 100)), 0.01, '=');
                        end;
                    end;
                }

                trigger OnPreDataItem()
                begin
                    // Apply the custom filter from the request page
                    if OutgoingGuarantorFilter = '' then
                        Error('Please select the Outgoing Guarantor before previewing.');
                    SetRange("Member No", OutgoingGuarantorFilter);
                end;

                trigger OnAfterGetRecord()
                begin
                    OutGWNo := OutgoingGuarantor."Staff/Payroll No.";
                    if OutGWNo = '' then 
                        OutGWNo := OutgoingGuarantor."Member No";
                end;
            }

            trigger OnPreDataItem()
            begin
                // Apply the custom filters from the request page
                if LoaneeNoFilter = '' then
                    Error('Please select the Loanee (Member No.) before previewing.');
                if LoanNoFilter = '' then
                    Error('Please select the Loan before previewing.');

                SetRange("Member No.", LoaneeNoFilter);
                SetRange("Loan No.", LoanNoFilter);
            end;

            trigger OnAfterGetRecord()
            begin
                Loans.CalcFields("Outstanding Balance");
                LoaneeWNo := Loans."Staff No";
                if LoaneeWNo = '' then 
                    LoaneeWNo := Loans."Member No.";
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
                group(Options)
                {
                    Caption = 'Substitution Details';
                    
                    field(LoaneeNoFilter; LoaneeNoFilter)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '1. Select Loanee (Member No.)';
                        TableRelation = Members."No.";
                        ToolTip = 'Select the member whose loan requires a guarantor substitution.';
                        
                        trigger OnValidate()
                        begin
                            // If they change the member, clear the loan and guarantor fields so they don't break the flow
                            LoanNoFilter := '';
                            OutgoingGuarantorFilter := '';
                        end;
                    }
                    
                    field(LoanNoFilter; LoanNoFilter)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '2. Select Loan No.';
                        ToolTip = 'Select the specific loan. This will only show loans belonging to the selected member.';
                        
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            LoanRec: Record Loans;
                        begin
                            if LoaneeNoFilter = '' then
                                Error('Please select the Loanee (Step 1) before picking a loan.');
                                
                            LoanRec.Reset();
                            LoanRec.SetRange("Member No.", LoaneeNoFilter);
                            LoanRec.SetFilter("Outstanding Balance", '>0'); // Only show active loans
                            
                            // Pop open the lookup page. If they pick one, save it to our variable
                            if Page.RunModal(0, LoanRec) = Action::LookupOK then begin
                                LoanNoFilter := LoanRec."Loan No.";
                                OutgoingGuarantorFilter := ''; // Reset guarantor just in case they changed the loan
                            end;
                        end;

                        trigger OnValidate()
                        var
                            LoanRec: Record Loans;
                        begin
                            if LoanNoFilter <> '' then begin
                                if LoaneeNoFilter = '' then Error('Please select the Loanee first.');
                                if LoanRec.Get(LoanNoFilter) then begin
                                    if LoanRec."Member No." <> LoaneeNoFilter then
                                        Error('The selected loan does not belong to the selected member.');
                                end else begin
                                    Error('The specified loan could not be found.');
                                end;
                            end;
                        end;
                    }

                    field(OutgoingGuarantorFilter; OutgoingGuarantorFilter)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '3. Select Outgoing Guarantor';
                        ToolTip = 'Select the guarantor who is withdrawing from this specific loan.';
                        
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            LoanGuaRec: Record "Loan Guarantors and Security";
                        begin
                            if LoanNoFilter = '' then
                                Error('Please select the Loan No. (Step 2) before picking an outgoing guarantor.');
                                
                            LoanGuaRec.Reset();
                            LoanGuaRec.SetRange("Loan No", LoanNoFilter);
                            LoanGuaRec.SetRange("Guarantor Type", LoanGuaRec."guarantor type"::Guarantor);
                            LoanGuaRec.SetRange(Substituted, false); // Only show people who haven't already been substituted
                            
                            // Pop open the lookup page. If they pick one, save it to our variable
                            if Page.RunModal(0, LoanGuaRec) = Action::LookupOK then begin
                                OutgoingGuarantorFilter := LoanGuaRec."Member No";
                            end;
                        end;

                        trigger OnValidate()
                        var
                            LoanGuaRec: Record "Loan Guarantors and Security";
                        begin
                            if OutgoingGuarantorFilter <> '' then begin
                                if LoanNoFilter = '' then Error('Please select the Loan No. first.');
                                LoanGuaRec.Reset();
                                LoanGuaRec.SetRange("Loan No", LoanNoFilter);
                                LoanGuaRec.SetRange("Member No", OutgoingGuarantorFilter);
                                if not LoanGuaRec.FindFirst() then
                                    Error('The selected member is not an active guarantor for this loan.');
                            end;
                        end;
                    }
                }
            }
        }
        actions { }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        CompanyAddress := 'P.O BOX ' + CompanyInfo."Post Code" + ', ' + CompanyInfo.City;
        CompanyTelephone := 'TEL: ' + CompanyInfo."Phone No." + ', ' + CompanyInfo."Phone No. 2";
        CompanyEmail := CompanyInfo."E-Mail";
    end;

    var
        CompanyInfo: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        LoaneeWNo: Code[50];
        OutGWNo: Code[50];
        IsOutgoingInt: Integer;
        GuarantorStaffNo: Code[50];
        TotalLoan: Decimal;
        MmberDeceased: Boolean;
        TotaAmtGUR: Decimal;
        PercentageGur: Decimal;
        
        // Custom Request Page Variables
        LoaneeNoFilter: Code[20];
        LoanNoFilter: Code[20];
        OutgoingGuarantorFilter: Code[20];
}