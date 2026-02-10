namespace Mwanga.Mwanga;
using Microsoft.Finance.GeneralLedger.Journal;

report 52186200 "Activate BOSA Accounts"
{
    ApplicationArea = All;
    Caption = 'Activate BOSA Accounts';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    //RDLCLayout = './bc-azima-2026/Layout/AccountActivation.rdl';
    dataset
    {
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            RequestFilterFields = "Source Unit", "Member No.", "Account Category", Status;
            CalcFields = Balance;
            DataItemTableView = where("Product Category" = const("BOSA Deposits"), Status = filter(New | " "), Balance = filter(> 0));
            trigger OnAfterGetRecord()
            var
                OtherBosaAccounts: Record "Savings Accounts";
                AllSavingsAccounts: Record "Savings Accounts";
                RegistrationFee: Record "Savings Accounts";
                ProductFactory: Record "Product Factory";
                DepositAccount: Record "Savings Accounts";
                Members: Record Members;

                RegFeeDeficit: Decimal;

                DepFeeBalance: Decimal;
            begin
                SavingsAccounts.CalcFields(Balance);

                //Update product Category
                AllSavingsAccounts.Reset();
                AllSavingsAccounts.SetRange("Member No.", SavingsAccounts."Member No.");
                AllSavingsAccounts.SetLoadFields("Product Category", "Product Type");
                if AllSavingsAccounts.Find('-') then begin
                    repeat
                        if AllSavingsAccounts."Product Category" = AllSavingsAccounts."Product Category"::" " then begin
                            ProductFactory.Reset();
                            ProductFactory.SetRange("Product ID", AllSavingsAccounts."Product Type");
                            ProductFactory.SetLoadFields("Product Category", "Source Unit");
                            if ProductFactory.FindFirst() then begin
                                AllSavingsAccounts."Product Category" := ProductFactory."Product Category";
                                AllSavingsAccounts."Source Unit" := ProductFactory."Source Unit";
                                AllSavingsAccounts.Modify();
                            end;
                        end;
                    until AllSavingsAccounts.Next() = 0;
                end;

                //Pay Registration Fee
                RegistrationFee.Reset();
                RegistrationFee.SetRange("Member No.", SavingsAccounts."Member No.");
                RegistrationFee.SetRange("Product Category", "Product Category"::"Entrance Fee");
                RegistrationFee.SetLoadFields(Status, Balance, "Monthly Contribution");
                RegistrationFee.SetAutoCalcFields(Balance);
                if RegistrationFee.FindFirst() then begin
                    if RegistrationFee."Monthly Contribution" = 0 then
                        if memberclass.Get((RegistrationFee."Member No.")) then
                            if memberclass."Entrance Fee" <> 0 then
                                RegistrationFee."Monthly Contribution" := memberclass."Entrance Fee";

                    if RegistrationFee."Monthly Contribution" = 0 then
                        RegistrationFee."Monthly Contribution" := ProductFactory."Minimum Contribution";

                    RegFeeDeficit := RegistrationFee."Monthly Contribution" - RegistrationFee.Balance;
                    if RegFeeDeficit <= 0 then
                        RegFeeDeficit := 0;

                    DepFeeBalance := SavingsAccounts.Balance - (SavingsAccounts."Monthly Contribution" + RegFeeDeficit);

                    if DepFeeBalance >= 0 then begin
                        OtherBosaAccounts.Reset();
                        OtherBosaAccounts.SetRange("Member No.", SavingsAccounts."Member No.");
                        OtherBosaAccounts.CalcFields("Source Unit");
                        //OtherBosaAccounts.SetRange("Source Unit", OtherBosaAccounts."Source Unit"::BOSA);
                        OtherBosaAccounts.SetLoadFields(Balance, Status, "Product Category");
                        if OtherBosaAccounts.Find('-') then begin
                            repeat
                                if OtherBosaAccounts."Product Category" = OtherBosaAccounts."Product Category"::"Entrance Fee" then begin
                                    Jtemplate := 'GENERAL';
                                    JBatch := 'ACTIVATE';
                                    DocNo := 'ACTIVATION';
                                    PDate := Today;
                                    AcctType := AcctType::Savings;
                                    Desc := 'Account Activation - ' + SavingsAccounts."Member No.";
                                    BalAcctType := BalAcctType::"G/L Account";
                                    Amt := RegFeeDeficit;
                                    TransType := TransType::" ";
                                    Dim1 := SavingsAccounts."Global Dimension 1 Code";
                                    Dim2 := "Global Dimension 2 Code";

                                    SaccoTrans.InitJournal(Jtemplate, JBatch);

                                    AcctNo := SavingsAccounts."No.";
                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType, AcctNo, Desc, BalAcctType,
                                        '', Amt, '', '', TransType, Dim1, Dim2, SystemCreated);

                                    AcctNo := RegistrationFee."No.";
                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType, AcctNo, Desc, BalAcctType,
                                        '', -Amt, '', '', TransType, Dim1, Dim2, SystemCreated);

                                    SaccoTrans.PostJournal(Jtemplate, JBatch, false);
                                end;

                                OtherBosaAccounts.Status := OtherBosaAccounts.Status::Active;
                                OtherBosaAccounts.Modify();

                                Members.Reset();
                                Members.SetRange("No.", SavingsAccounts."Member No.");
                                Members.SetLoadFields(Status);
                                if Members.FindFirst() then begin
                                    Members.Status := Members.Status::Active;
                                    Members.Modify();
                                end;
                            until OtherBosaAccounts.Next() = 0;
                        end;
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        SaccoTrans: Codeunit "Sacco Transactions";
        Jtemplate: Code[20];
        JBatch: Code[20];
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        AcctNo: Code[20];
        Desc: Text[150];
        BalAcctType: Enum "Gen. Journal Account Type";
        BalAcctNo: Code[20];
        Amt: Decimal;
        ExtDocNo: Code[20];
        Loan: Code[20];
        TransType: enum "Transaction Types";
        Dim1: Code[20];
        Dim2: Code[20];
        SystemCreated: Boolean;
        memberclass: record "Member Classes";
        Bankingsetup: record "Banking User Template";
}
