page 52186694 "M-PESA Manual Upload"
{
    PageType = List;
    SourceTable = "M-PESA Manual Upload";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry Code"; Rec."Entry Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction ID"; Rec."Transaction ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Transaction; Rec.Transaction)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Validate; Rec.Validate)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Post; Rec.Post)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Request Application"; Rec."Request Application")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Request Correlation ID"; Rec."Request Correlation ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Source Application"; Rec."Source Application")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Destination Acc"; Rec."Destination Acc")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Destination Name"; Rec."Destination Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Destination Org"; Rec."Destination Org")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Client Phone Number"; Rec."Client Phone Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Import Entries")
            {
                ApplicationArea = Basic, Suite;
                Image = Import;
                Promoted = true;
                ////RunObject = XMLport "M-PESA Manul Upload";
            }
            action("Validate Accounts")
            {
                ApplicationArea = Basic, Suite;
                Image = ValidateEmailLoggingSetup;
                Promoted = true;

                trigger OnAction()
                var
                    SkyUSSDAuth: Record "Sky USSD Auth";
                    MPESAManualUpload: Record "M-PESA Manual Upload";
                begin
                    MPESAManualUpload.Reset;
                    MPESAManualUpload.SetRange(Post, false);
                    MPESAManualUpload.SetRange(Validate, false);
                    if MPESAManualUpload.FindSet then begin
                        repeat
                            SkyUSSDAuth.Reset;
                            SkyUSSDAuth.SetRange("Mobile No.", '+' + MPESAManualUpload."Phone No");
                            if SkyUSSDAuth.FindFirst then begin
                                MPESAManualUpload.Validate := true;
                                MPESAManualUpload.Modify;
                            end;
                        until MPESAManualUpload.Next = 0;
                    end;
                    Message('Validation successfull');
                end;
            }
            action(PostEntries)
            {
                ApplicationArea = Basic, Suite;
                Image = Post;
                Promoted = true;

                trigger OnAction()
                var
                    MPESAManualUpload: Record "M-PESA Manual Upload";
                begin
                    MPESAManualUpload.Reset;
                    MPESAManualUpload.SetRange(Post, false);
                    MPESAManualUpload.SetRange(Validate, true);
                    if MPESAManualUpload.FindSet then begin
                        repeat
                            InsertMpesaTransaction(MPESAManualUpload."Entry Code", MPESAManualUpload."Transaction ID", MPESAManualUpload."Transaction Date",
                            MPESAManualUpload.Transaction, MPESAManualUpload.Description, MPESAManualUpload."Account No", MPESAManualUpload.Amount,
                            MPESAManualUpload."Phone No", '', MPESAManualUpload."Request Application", MPESAManualUpload."Request Correlation ID",
                            MPESAManualUpload."Source Application", MPESAManualUpload."Destination Acc", MPESAManualUpload."Destination Name",
                            MPESAManualUpload."Destination Org", MPESAManualUpload."Client Phone Number", MPESAManualUpload."Customer Name");

                            MPESAManualUpload.Post := true;
                            MPESAManualUpload.Modify;
                        until MPESAManualUpload.Next = 0;
                    end;
                    Message('Posted Successfully');
                end;
            }
        }
    }

    //[Scope('OnPrem')]
    procedure InsertMpesaTransaction(EntryCode: Code[20]; TransactionID: Code[20]; TransactionDate: DateTime; Transaction: Text; Description: Text[100]; AccountNo: Code[20]; Amount: Decimal; PhoneNo: Code[20]; PIN: Text; RequestApplication: Text; RequestCorrelationID: Text; SourceApplication: Text; DestinationAcc: Text; DestinationName: Text; DestinationOrg: Text; ClientPhoneNumber: Code[13]; CustomerName: Text) Response: Text[1024]
    var
        SaccoFee: Decimal;
        VendorCommission: Decimal;
        TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Pesalink Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Bank Transfer";
        TotalCharge: Decimal;
        SavAcc: Record "Savings Accounts";
        MpesaTrans: Record "Sky Transactions";
        Continue: Boolean;
        MobileWithdrawalsBuffer: Record "ATM Transactions";
        AccBal: Decimal;
        SafcomCharges: Record "Sky Safcom Corporate Charges";
        SafcomAcc: Code[20];
        SafcomFee: Decimal;
        MemberID: Code[20];
        PrePaymentGL: Code[20];
        Loans: Record Loans;
        LoanNo: Code[20];
        MemberNo: Code[20];
        Type: Option Daily,Weekly,Monthly;
        Limit: Decimal;
        msg: Text;
        SacAcc: Code[20];
        EmpRestrict: Code[20];
        LengthWithin: Boolean;
        ProductFactory: Record "Product Factory";
        TelNo: Code[20];
        BusinessAccount: Record "Savings Accounts";
        CoopSetup: Record "Sky Mobile Setup";
        // SkyMbanking: Codeunit "Sky Mbanking";
    begin
        MpesaTrans.LockTable(true);
        BusinessAccount.Reset;
        BusinessAccount.SetRange("Business Account Code", UpperCase(AccountNo));
        if BusinessAccount.FindFirst then AccountNo := BusinessAccount."No.";


        PhoneNo := '+' + PhoneNo;

        // /

        //IF (TransactionType = TransactionType::Paybill) OR (TransactionType = TransactionType::"Mpesa Withdrawal") OR (TransactionType = TransactionType::"Utility Payment") THEN BEGIN

        MpesaTrans.Reset;
        MpesaTrans.LockTable(true);
        MpesaTrans.SetRange("Transaction ID", TransactionID);
        if MpesaTrans.FindFirst then begin
            Response := '<Response>';
            Response += '<Status>TRANSACTION_EXISTS</Status>';
            Response += '<StatusDescription>Transaction Already Exists</StatusDescription>';
            Response += '<Reference>' + Format(TransactionID) + '</Reference>';
            Response += '</Response>';
            exit;
        end;

        //END;



        if AccountNo = '' then begin
            SavAcc.Reset;
            SavAcc.SetRange("Transactional Mobile No", PhoneNo);
            SavAcc.SetRange("Product Type", '505');
            if SavAcc.FindFirst then begin
                AccountNo := SavAcc."No.";
                MemberNo := SavAcc."Member No.";
            end;
        end;

        //TransactionDate:=CURRENTDATETIME;

        Response := 'ERROR';

        if CopyStr(AccountNo, 1, 4) = 'LOAN' then begin
            Transaction := 'Loan Repayment';
            Description := 'Loan Repayment';
        end;

        if Loans.Get(AccountNo) then begin
            Transaction := 'Loan Repayment';
            Description := 'Loan Repayment';
        end;


        if Transaction = 'Balance Enquiry' then
            TransactionType := TransactionType::"Balance Enquiry";

        if Transaction = 'Loan Repayment' then
            TransactionType := TransactionType::"Loan Repayment";


        if Transaction = 'Mini-Statement' then
            TransactionType := TransactionType::"Mini-Statement";

        if Transaction = 'Mpesa Deposit' then
            TransactionType := TransactionType::"Mpesa Deposit";

        if Transaction = 'Bank Deposit' then
            TransactionType := TransactionType::"Bank Deposit";

        if Transaction = 'Bank Agent Deposit' then
            TransactionType := TransactionType::"Bank Agent Deposit";

        if Transaction = 'Mpesa Withdrawal' then
            TransactionType := TransactionType::"Mpesa Withdrawal";


        if Transaction = 'Airtime Request' then
            TransactionType := TransactionType::Airtime;

        if Transaction = 'Airtime Purchase' then
            TransactionType := TransactionType::Airtime;


        if Transaction = 'Utility Request' then
            TransactionType := TransactionType::"Utility Payment";

        if Transaction = 'Utility Payment' then
            TransactionType := TransactionType::"Utility Payment";

        if Transaction = 'Withdrawal Request' then
            TransactionType := TransactionType::"Mpesa Withdrawal";

        if Transaction = 'Paybill' then
            TransactionType := TransactionType::Paybill;


        if Transaction = 'Bank Transfer' then
            TransactionType := TransactionType::"Bank Transfer";


        if Transaction = 'Bank Transfer Request' then
            TransactionType := TransactionType::"Bank Transfer";


        if Transaction = 'Pesalink Transfer' then
            TransactionType := TransactionType::"Pesalink Transfer";


        if Transaction = 'Pesalink Transfer Request' then
            TransactionType := TransactionType::"Pesalink Transfer";





        // Get Excise duty G/L
        //ExciseDutyGL := GetExciseDutyGL();
        //ExciseDutyRate := GetExciseRate();
        //ExciseDuty:=0;


        if (Transaction = 'Mpesa Withdrawal') or (Transaction = 'Utility Payment') or (Transaction = 'Pesalink Transfer') or (Transaction = 'Bank Transfer') or (Transaction = 'Airtime Purchase') then begin

            MobileWithdrawalsBuffer.Reset;
            MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Trace ID", EntryCode);
            MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer.Source, MobileWithdrawalsBuffer.Source::"M-PESA");
            if MobileWithdrawalsBuffer.Find('-') then begin
                AccountNo := MobileWithdrawalsBuffer."Account No";
                Amount := MobileWithdrawalsBuffer.Amount;
                if Description = '' then
                    Description := MobileWithdrawalsBuffer.Description;
            end;
        end;

        if TransactionType = TransactionType::"Loan Repayment" then begin
            LoanNo := CopyStr(AccountNo, 5, StrLen(AccountNo) - 3);
            if Loans.Get(LoanNo) then begin
                SavAcc.Reset;
                SavAcc.SetRange("Member No.", Loans."Member No.");
                SavAcc.SetRange("Product Type", '505');
                if SavAcc.FindFirst then begin
                    AccountNo := SavAcc."No.";
                    LoanNo := Loans."Loan No.";
                end;
            end;
            if Loans.Get(AccountNo) then begin
                SavAcc.Reset;
                SavAcc.SetRange("Member No.", Loans."Member No.");
                SavAcc.SetRange("Product Type", '505');
                if SavAcc.FindFirst then begin
                    AccountNo := SavAcc."No.";
                    LoanNo := Loans."Loan No.";
                end;
            end;
        end;



        MemberID := '';





        if (TransactionType = TransactionType::Paybill) or (TransactionType = TransactionType::"Bank Agent Deposit") or (TransactionType = TransactionType::"Bank Deposit") then begin




            SavAcc.Reset;
            SavAcc.SetRange("Product Type", '505');
            SavAcc.SetRange("Transactional Mobile No", AccountNo);
            if (SavAcc.FindFirst) then begin
                MemberID := SavAcc."ID No.";
                AccountNo := SavAcc."No.";
            end
            else begin

                SavAcc.Reset;
                SavAcc.SetRange("No.", AccountNo);
                if (SavAcc.FindFirst) then begin
                    MemberID := SavAcc."ID No.";
                    AccountNo := SavAcc."No.";
                end
                else begin

                    SavAcc.Reset;
                    SavAcc.SetRange("Product Type", '505');
                    SavAcc.SetRange("Transactional Mobile No", PhoneNo);
                    if (StrLen(PhoneNo) = 13) and (SavAcc.FindFirst) then begin

                        MemberID := SavAcc."ID No.";
                        AccountNo := SavAcc."No.";
                    end
                    else begin

                        MpesaTrans.Init;
                        MpesaTrans."Entry No." := EntryCode;//from ATM
                        MpesaTrans."Transaction ID" := TransactionID;
                        MpesaTrans."Session ID" := TransactionID;
                        MpesaTrans."Transaction Type" := TransactionType;
                        MpesaTrans."Transaction Name" := Transaction;
                        MpesaTrans.Description := CopyStr(Description, 1, 50);
                        ;
                        MpesaTrans."Transaction Date" := DT2Date(TransactionDate);
                        MpesaTrans."Transaction Time" := DT2Time(TransactionDate);
                        MpesaTrans."Member Account" := AccountNo;
                        MpesaTrans.Amount := Amount;
                        MpesaTrans."Loan No." := LoanNo;
                        MpesaTrans."Mobile No." := PhoneNo;
                        MpesaTrans."Vendor Commission" := VendorCommission;
                        MpesaTrans."Sacco Fee" := SaccoFee;
                        MpesaTrans."Paybill Member ID" := MemberID;
                        MpesaTrans."Destination Account" := DestinationAcc;
                        MpesaTrans."Destination Name" := DestinationName;
                        MpesaTrans.Organization := DestinationOrg;
                        //For business account
                        MpesaTrans."Client Phone Number" := ClientPhoneNumber;
                        MpesaTrans."Customer Name" := CustomerName;
                        MpesaTrans.Insert;

                        Response := '<Response>';
                        Response += '<Status>SUCCESS</Status>';
                        Response += '<StatusDescription>Success</StatusDescription>';
                        Response += '<Reference>' + Format(EntryCode) + '</Reference>';
                        Response += '</Response>';
                        //PostMpesaTransaction(TransactionID);
                        exit;
                    end;
                end
            end;
        end;

        if SavAcc.Get(AccountNo) then begin
            TelNo := SavAcc."Transactional Mobile No";

            if (Transaction = 'Withdrawal Request') or (Transaction = 'Utility Request') or (Transaction = 'Pesalink Transfer Request') or (Transaction = 'Bank Transfer Request') or (Transaction = 'Airtime Request') then begin

            end else begin

                MpesaTrans.Init;
                MpesaTrans."Entry No." := EntryCode;
                MpesaTrans."Transaction ID" := TransactionID;
                MpesaTrans."Session ID" := TransactionID;
                MpesaTrans."Transaction Type" := TransactionType;
                MpesaTrans."Transaction Name" := Transaction;
                MpesaTrans.Description := CopyStr(Description, 1, 50);
                ;
                MpesaTrans."Transaction Date" := DT2Date(TransactionDate);
                MpesaTrans."Transaction Time" := DT2Time(TransactionDate);
                MpesaTrans."Member Account" := AccountNo;
                MpesaTrans.Amount := Amount;
                MpesaTrans."Loan No." := LoanNo;
                MpesaTrans."Mobile No." := TelNo;
                MpesaTrans."Vendor Commission" := VendorCommission;
                MpesaTrans."Sacco Fee" := SaccoFee;
                MpesaTrans."Paybill Member ID" := MemberID;
                MpesaTrans."Destination Account" := DestinationAcc;
                MpesaTrans."Destination Name" := DestinationName;
                MpesaTrans.Organization := DestinationOrg;
                //For business account
                MpesaTrans."Client Phone Number" := ClientPhoneNumber;
                MpesaTrans."Customer Name" := CustomerName;
                MpesaTrans.Insert;

                Response := 'SUCCESS';

                Response := '<Response>';
                Response += '<Status>SUCCESS</Status>';
                Response += '<StatusDescription>Success</StatusDescription>';
                Response += '<Reference>' + Format(EntryCode) + '</Reference>';
                Response += '</Response>';
            end;

        end
        else begin
            if (TransactionType = TransactionType::"Bank Deposit")
                or (TransactionType = TransactionType::"Bank Agent Deposit")
                or (TransactionType = TransactionType::Paybill)
                or (TransactionType = TransactionType::"Loan Repayment") then begin

                MpesaTrans.Init;
                MpesaTrans."Entry No." := EntryCode;
                MpesaTrans."Transaction ID" := TransactionID;
                MpesaTrans."Session ID" := TransactionID;
                MpesaTrans."Transaction Type" := TransactionType;
                MpesaTrans."Transaction Name" := Transaction;
                MpesaTrans.Description := CopyStr(Description, 1, 50);
                ;
                MpesaTrans."Transaction Date" := DT2Date(TransactionDate);
                MpesaTrans."Transaction Time" := DT2Time(TransactionDate);
                MpesaTrans."Member Account" := AccountNo;
                MpesaTrans.Amount := Amount;
                MpesaTrans."Loan No." := LoanNo;
                MpesaTrans."Mobile No." := PhoneNo;
                MpesaTrans."Vendor Commission" := VendorCommission;
                MpesaTrans."Sacco Fee" := SaccoFee;
                MpesaTrans."Needs Change" := true;
                MpesaTrans."Paybill Member ID" := MemberID;
                //For business account
                MpesaTrans."Client Phone Number" := ClientPhoneNumber;
                MpesaTrans."Customer Name" := CustomerName;
                MpesaTrans.Insert;

                Response := 'SUCCESS';

                Response := '<Response>';
                Response += '<Status>SUCCESS</Status>';
                Response += '<StatusDescription>Success</StatusDescription>';
                Response += '<Reference>' + Format(EntryCode) + '</Reference>';
                Response += '</Response>';

            end
            else
                Error('Account Not Found');

        end;
    end;
}

