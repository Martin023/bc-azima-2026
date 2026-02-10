report 52186212 "Generate Bulk SMS Lines"
{
    ApplicationArea = All;
    Caption = 'Generate Bulk SMS Lines';
    UsageCategory = ReportsAndAnalysis;
    processingonly = true;
    dataset
    {
        dataitem(BulkSMSHeader; "Bulk SMS Header")
        {
            column(No; No)
            {
            }
            column(Message_; Message_)
            {
            }
            column(Status; Status)
            {
            }
            dataitem(Members; "Members")
            {
                RequestFilterFields = "No.", Status, "Account Category", Name, "Employer Code", "Account Type";
                DataItemTableView = where(Status = filter(<> Dormant & <> Deceased & <> "Closed"));
                column(MemNo; Members."No.")
                {
                }
                column(Name; Name)
                {
                }
                column(PhoneNo; Members."phone No.")
                {
                    
                }
                trigger OnAfterGetRecord()
                begin
                    if (SavingsAccounts.GetFilters <> '') or (Loans.GetFilters <> '') then CurrReport.Skip();
                    BulkSMSLine.INIT;
                    BulkSMSLine.No := BulkSMSHeader.No;
                    BulkSMSLine."Member No" := Members."No.";
                    BulkSMSLine.Description := Members.Name;
                    if StrLen(Members."phone No.") > 20 then
                        BulkSMSLine.Code := CopyStr(Members."phone No.", StrLen(Members."phone No.") - 9, 10)
                    else
                        BulkSMSLine.Code := Members."phone No.";
                    // take phone no instead if member has no mobile phone no field
                    if (Strlen(Members."phone No.") < 9) and (Strlen(Members."Phone No.") > 4) then begin
                        if StrLen(Members."Phone No.") > 20 then
                            BulkSMSLine.Code := CopyStr(Members."Phone No.", StrLen(Members."Phone No.") - 9, 10)
                        else
                            BulkSMSLine.Code := Members."Phone No.";
                    end;
                    BulkSMSLine.Sent := false;
                    BulkSMSLine.INSERT;
                end;
            }
            dataitem(SavingsAccounts; "Savings Accounts")
            {
                RequestFilterFields = "No.", "Balance (LCY)", "Product Category", "Product Type", Status;
                DataItemTableView = where(Status = filter(<> Closed));
                column(SavAccNo; SavingsAccounts."No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if (Loans.GetFilters <> '') or (Members.GetFilters <> '') then CurrReport.Skip();
                    SaccoMembers.RESET;
                    if SaccoMembers.get(SavingsAccounts."Member No.") then begin
                        BulkSMSLine.INIT;
                        BulkSMSLine.No := BulkSMSHeader.No;
                        BulkSMSLine."Member No" := SaccoMembers."No.";
                        BulkSMSLine.Description := SaccoMembers.Name;
                        if StrLen(Members."phone No.") > 20 then
                            BulkSMSLine.Code := CopyStr(Members."phone No.", 1, 10)
                        else
                            BulkSMSLine.Code := Members."phone No.";
                        BulkSMSLine.Sent := false;
                        BulkSMSLine.INSERT;
                    end;
                end;
            }
            dataitem(Loans; "Loans")
            {
                RequestFilterFields = "Loan No.", "Outstanding Balance", "Outstanding Interest", "Loan Product Type", "Loan Product Type Name", "Loans Category-SASRA";
                DataItemTableView = where("Outstanding Balance" = filter(<> 0));
                column(LoanNo; Loans."Loan No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if (SavingsAccounts.GetFilters <> '') or (Members.GetFilters <> '') then CurrReport.Skip();
                    SaccoMembers.RESET;
                    if SaccoMembers.get(Loans."Member No.") then begin
                        BulkSMSLine.INIT;
                        BulkSMSLine.No := BulkSMSHeader.No;
                        BulkSMSLine."Member No" := SaccoMembers."No.";
                        BulkSMSLine.Description := SaccoMembers.Name;
                        if StrLen(Members."phone No.") > 20 then
                            BulkSMSLine.Code := CopyStr(Members."phone No.", StrLen(Members."phone No.") - 9, 10)
                        else
                            BulkSMSLine.Code := Members."phone No.";
                        BulkSMSLine.Sent := false;
                        BulkSMSLine.INSERT;
                    end;
                end;
            }
 
            trigger OnAfterGetRecord()
            begin
                BulkSMSLine.RESET;
                BulkSMSLine.SETRANGE(No, BulkSMSHeader.No);
                BulkSMSLine.DeleteAll();
            end;
        }
    }
    trigger OnPreReport()
    begin
 
    end;
 
    trigger OnPostReport()
    begin
        message('Bulk SMS Lines Generated');
    end;
 
    var
        // BulkSMSHeader: Record "Bulk SMS Header";
        BulkSMSLine: Record "Bulk SMS Lines";
        SaccoMembers: Record "Members";
}
 
 





