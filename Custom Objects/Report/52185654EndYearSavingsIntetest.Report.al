#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185654 "End Year Savings Intetest"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/End Year Savings Intetest.rdl';

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            RequestFilterFields = "No.", "Global Dimension 1 Code", "Balance (LCY)", "Product Type", "Savings Interest Earned";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                RecBuffer.Reset;
                RecBuffer.SetRange(RecBuffer."No.", "Document No.");
                if RecBuffer.Find('-') then begin
                    if "Document No." <> RecBuffer."No." then
                        Error(Text001);
                    if RecBuffer.Status <> RecBuffer.Status::Open then
                        Error('You canot generate entries since the document is already %1', RecBuffer.Status);
                    if ProductFactory.Get("Product Type") then begin
                        "Savings Accounts".CalcFields("Savings Accounts"."Savings Interest Earned");
                        /*
                                SavingsInterestBuffer.SETCURRENTKEY(SavingsInterestBuffer."Account No",SavingsInterestBuffer."Interest Date");
                                SavingsInterestBuffer.SETRANGE(SavingsInterestBuffer."Account No",SavingsAccounts."No.");
                                SavingsInterestBuffer.SETRANGE(SavingsInterestBuffer."Interest Date",RecBuffer."Start Date",RecBuffer."End Date");
                                SavingsInterestBuffer.CALCSUMS(SavingsInterestBuffer."Interest Amount");
                                IntEarned:=SavingsInterestBuffer."Interest Amount";
                                */
                        //IF IntEarned<>0 THEN
                        // MESSAGE('here %1',IntEarned);
                        InterestBuffer.Init;
                        InterestBuffer."Account No" := "No.";
                        InterestBuffer."Account Type" := InterestBuffer."account type"::Savings;
                        "Savings Accounts".CalcFields("Balance (LCY)");
                        InterestBuffer."Account Balance" := "Balance (LCY)";
                        InterestBuffer."Bal. Account Type" := InterestBuffer."bal. account type"::"G/L Account";
                        InterestBuffer.Blocked := Blocked;
                        InterestBuffer.Description := RecBuffer.Description;
                        InterestBuffer."Interest Amount" := "Savings Accounts"."Savings Interest Earned";//IntEarned;
                        InterestBuffer."Interest Date" := RecBuffer."End Date";
                        InterestBuffer.Name := Name;
                        InterestBuffer.No := RecBuffer."No.";

                        InterestBuffer."Payable Account" := ProductFactory."Interest Payable Account";//PayableAccount;
                        InterestBuffer."Product Factory Code" := "Product Type";
                        if Members.Get("Member No.") then begin
                            InterestBuffer."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                            InterestBuffer."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                        end;
                        InterestBuffer."User ID" := UserId;
                        if InterestBuffer."Interest Amount" <> 0 then
                            InterestBuffer.Insert(true);
                        // END;
                        //UNTIL SavingsAccounts.NEXT=0;
                        // END;
                    end;
                    //  END;
                end;

            end;

            trigger OnPostDataItem()
            begin
                Message(MSGEntriesGenerated);
            end;

            trigger OnPreDataItem()
            begin
                if "Document No." = '' then
                    Error('Document No. Must have a Value');
                InterestBuffer2.Reset;
                InterestBuffer2.SetRange(InterestBuffer2.No, "Document No.");
                if InterestBuffer2.Find('-') then
                    if InterestBuffer2.Posted = false then
                        InterestBuffer2.DeleteAll else
                        Error(ErrPosted);
                RecBuffer.Reset;
                RecBuffer.SetRange(RecBuffer."No.", "Document No.");
                if RecBuffer.Find('-') then begin
                    if not Confirm(MSGConfirmation, true, RecBuffer."Start Date", RecBuffer."End Date") then
                        exit;// ELSE
                             //BEGIN
                end;
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
                field("Document No."; "Document No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'No.';
                }
                field(PDate; PDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Savings: Record "Savings Accounts";
        RecBuffer: Record "End Year Transfer Header";
        InterestBuffer: Record "End Year Interest Buffer";
        InterestBuffer2: Record "End Year Interest Buffer";
        //DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        PeriodicActivities: Codeunit "Periodic Activities";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        //VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        SavingsAccounts: Record "Savings Accounts";
        FromDateS: Text[100];
        ToDateS: Text[100];
        DateFilter: Text[100];
        ProductFactory: Record "Product Factory";
        ProductFactoryCode: Code[20];
        InterestRate: Decimal;
        PayableAccount: Code[20];
        ExpenseAccount: Code[20];
        BankingUserTemplate: Record "Banking User Template";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        JTemp: Code[20];
        JBatch: Code[20];
        PageEditable: Boolean;
        Members: Record "Members";
        SavingsInterestBuffer: Record "Savings Interest Buffer";
        IntEarned: Decimal;
        ErrNotApproved: label 'This document has not been approved';
        ErrNoEntries: label 'This Document has no Lines to post';
        MSGEntriesGenerated: label 'Entries Generated Successfully';
        MSGConfirmation: label 'Confirm interest Generation for period starting %1 and Ending %2';
        ErrPosted: label 'This document has already been posted';
        DocNo: Code[20];
        PDate: Date;
        "Document No.": Code[20];
        Text001: label 'Document No. Must be equal to No.';
}
