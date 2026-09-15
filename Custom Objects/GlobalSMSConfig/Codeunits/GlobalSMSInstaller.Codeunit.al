codeunit 52185465 "Global SMS Installer"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        InstallDefaultTokens();
        InstallDefaultTemplates();
    end;

    procedure InstallDefaultTokens()
    begin
        // MEMBER INFO TOKENS
        CreateToken('[MEMBER_NAME]', 'Member first or full name', "SMS Token Category"::"Member Info", 0, 'John Doe', true);
        CreateToken('[MEMBER_NO]', 'Member account number', "SMS Token Category"::"Member Info", 0, 'M-001234', true);
        CreateToken('[MEMBER_PHONE]', 'Member phone number', "SMS Token Category"::"Member Info", 0, '0712345678', true);
        CreateToken('[MEMBER_ID]', 'Member ID number', "SMS Token Category"::"Member Info", 0, '12345678', true);

        // ACCOUNT INFO TOKENS
        CreateToken('[ACCOUNT_NO]', 'Account number', "SMS Token Category"::"Account Info", 0, '001-12345', true);
        CreateToken('[PRODUCT_NAME]', 'Account product name', "SMS Token Category"::"Account Info", 0, 'Savings Account', true);
        CreateToken('[BALANCE]', 'Current account balance', "SMS Token Category"::"Account Info", 1, '15000.00', true);
        CreateToken('[AVAILABLE_BALANCE]', 'Available balance', "SMS Token Category"::"Account Info", 1, '14500.00', true);

        // TRANSACTION INFO TOKENS
        CreateToken('[AMOUNT]', 'Transaction amount', "SMS Token Category"::"Transaction Info", 1, '5000.00', true);
        CreateToken('[TRANSACTION_TYPE]', 'Type of transaction', "SMS Token Category"::"Transaction Info", 0, 'Cash Withdrawal', true);
        CreateToken('[TRANSACTION_NO]', 'Transaction reference number', "SMS Token Category"::"Transaction Info", 0, 'TXN-001234', true);
        CreateToken('[CHEQUE_NO]', 'Cheque number', "SMS Token Category"::"Transaction Info", 0, 'CHQ-001', true);
        CreateToken('[REFERENCE_NO]', 'Reference number', "SMS Token Category"::"Transaction Info", 0, 'REF-001234', true);
        CreateToken('[DEPOSITOR]', 'Who deposited (You or name)', "SMS Token Category"::"Transaction Info", 0, 'John Doe', true);
        CreateToken('[CREDITED_ACCOUNT]', 'Account credited', "SMS Token Category"::"Transaction Info", 0, 'Member Deposits', true);
        CreateToken('[PAYEE]', 'Payee name', "SMS Token Category"::"Transaction Info", 0, 'ABC Company Ltd', true);
        CreateToken('[PAYER]', 'Payer name', "SMS Token Category"::"Transaction Info", 0, 'XYZ Enterprises', true);
        CreateToken('[TRANSACTION_BREAKDOWN]', 'Multi-line transaction breakdown', "SMS Token Category"::"Transaction Info", 0, 'KES 1,000 to Member Deposits, KES 500 to Share Capital', true);

        // LOAN INFO TOKENS
        CreateToken('[LOAN_NO]', 'Loan account number', "SMS Token Category"::"Loan Info", 0, 'LN-001234', true);
        CreateToken('[LOAN_PRODUCT]', 'Loan product name', "SMS Token Category"::"Loan Info", 0, 'Development Loan', true);
        CreateToken('[LOAN_AMOUNT]', 'Loan amount', "SMS Token Category"::"Loan Info", 1, '50000.00', true);
        CreateToken('[INSTALLMENT]', 'Loan installment amount', "SMS Token Category"::"Loan Info", 1, '5000.00', true);
        CreateToken('[OUTSTANDING_BALANCE]', 'Outstanding loan balance', "SMS Token Category"::"Loan Info", 1, '45000.00', true);

        // HR INFO TOKENS
        CreateToken('[EMPLOYEE_NO]', 'Employee number', "SMS Token Category"::"HR Info", 0, 'EMP-001234', true);
        CreateToken('[EMPLOYEE_NAME]', 'Employee name', "SMS Token Category"::"HR Info", 0, 'Jane Doe', true);
        CreateToken('[LEAVE_TYPE]', 'Leave type', "SMS Token Category"::"HR Info", 0, 'Annual Leave', true);
        CreateToken('[LEAVE_DAYS]', 'Number of leave days', "SMS Token Category"::"HR Info", 1, '10', true);
        CreateToken('[START_DATE]', 'Leave start date', "SMS Token Category"::"HR Info", 2, '01-Feb-2026', true);
        CreateToken('[END_DATE]', 'Leave end date', "SMS Token Category"::"HR Info", 2, '10-Feb-2026', true);

        // SYSTEM INFO TOKENS
        CreateToken('[DATE]', 'Current date', "SMS Token Category"::"System Info", 2, '23-Jan-2026', true);
        CreateToken('[TIME]', 'Current time', "SMS Token Category"::"System Info", 0, '10:30 AM', true);
        CreateToken('[COMPANY_NAME]', 'Company name', "SMS Token Category"::"System Info", 0, 'AZIMA SACCO', true);
        CreateToken('[BRANCH_NAME]', 'Branch name', "SMS Token Category"::"System Info", 0, 'Nairobi Branch', true);

        Message('Default tokens installed successfully.');
    end;

    procedure InstallDefaultTemplates()
    begin
        CreateTemplate(
            'CASH_WITHDRAWAL',
            'Cash Withdrawal Transaction',
            'Dear [MEMBER_NAME], You have withdrawn KES [AMOUNT] from [PRODUCT_NAME] on [DATE] at [TIME].',
            "SMS Source"::CASH_WITHDRAWAL_CONFIRM,
            "SMS Module"::CBS,
            true
        );

        CreateTemplate(
            'CASH_DEPOSIT',
            'Cash Deposit Transaction',
            'Dear [MEMBER_NAME], You have deposited KES [AMOUNT] to [PRODUCT_NAME] on [DATE] at [TIME].',
            "SMS Source"::DEPOSIT_CONFIRMATION,
            "SMS Module"::CBS,
            true
        );

        CreateTemplate(
            'CREDIT_RECEIPT',
            'Credit Receipt Transaction',
            'Dear [MEMBER_NAME], [DEPOSITOR] have credited [TRANSACTION_BREAKDOWN] on [DATE] at [TIME].',
            "SMS Source"::DEPOSIT_CONFIRMATION,
            "SMS Module"::CBS,
            true
        );

        CreateTemplate(
            'BANKERS_CHEQUE',
            'Bankers Cheque Issuance',
            'Dear [MEMBER_NAME], Bankers Cheque [CHEQUE_NO] of KES [AMOUNT] issued to [PAYEE] on [DATE] at [TIME].',
            "SMS Source"::BANKERS_CHEQUE_ISSUED,
            "SMS Module"::Teller,
            true
        );

        CreateTemplate(
            'CHEQUE_DEPOSIT',
            'Cheque Deposit Transaction',
            'Dear [MEMBER_NAME], Cheque [CHEQUE_NO] of KES [AMOUNT] from [PAYER] have been deposited to [PRODUCT_NAME] on [DATE] at [TIME].',
            "SMS Source"::TELLER_CHEQUE_DEPOSIT,
            "SMS Module"::Teller,
            true
        );

        CreateTemplate(
            'CHEQUE_CLEARED',
            'Cheque Clearance Notification',
            'Dear [MEMBER_NAME], Cheque [CHEQUE_NO] of KES [AMOUNT] cleared to [PRODUCT_NAME].',
            "SMS Source"::CHEQUE_CLEARANCE,
            "SMS Module"::Teller,
            true
        );

        Message('Default templates installed successfully.');
    end;

    local procedure CreateToken(TokenCode: Code[50]; TokenDesc: Text[100]; TokenCategory: Enum "SMS Token Category"; DataType: Option; SampleVal: Text[100]; SystemDefined: Boolean)
    var
        TokenRegistry: Record "Global SMS Token Registry";
    begin
        if TokenRegistry.Get(TokenCode) then
            exit;

        TokenRegistry.Init();
        TokenRegistry.Token := TokenCode;
        TokenRegistry.Description := TokenDesc;
        TokenRegistry.Category := TokenCategory;
        TokenRegistry."Data Type" := DataType;
        TokenRegistry."Sample Value" := SampleVal;
        TokenRegistry."System Defined" := SystemDefined;
        TokenRegistry.Insert(true);
    end;

    local procedure CreateTemplate(EventCode: Code[50]; EventDesc: Text[100]; MessageBody: Text[500]; SMSSource: Enum "SMS Source"; Module: Enum "SMS Module"; IsEnabled: Boolean)
    var
        Template: Record "Global SMS Template";
    begin
        if Template.Get(EventCode) then
            exit;

        Template.Init();
        Template."Event Code" := EventCode;
        Template."Event Description" := EventDesc;
        Template."Message Body" := MessageBody;
        Template."SMS Source" := SMSSource;
        Template.Module := Module;
        Template.Enabled := IsEnabled;
        Template.Insert(true);
    end;
}
