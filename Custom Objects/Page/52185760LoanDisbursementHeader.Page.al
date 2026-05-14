page 52185760 "Loan Disbursement Header"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval Requests,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Other Approvals,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Loan Disbursement Header";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                Editable = ApprovedEdit;
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Subsequent Disbursements"; Rec."Subsequent Disbursements")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        if Rec."Subsequent Disbursements" = Rec."Subsequent Disbursements"::Yes then
                            SubseqDisb := true
                        else
                            SubseqDisb := false;

                        SetControlAppearance;
                        StatusControl;
                    end;
                }
                field("Disbursement Destination"; Rec."Disbursement Destination")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Disburse Accounts"; Rec."Disburse Accounts")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Special Processing Commission"; Rec."Special Processing Commission")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Prepared By"; Rec."Prepared By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                group("Partial Disbursements")
                {
                    Visible = SubseqDisb;
                    field("Issued Date From"; Rec."Issued Date From")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = SubseqDisb;
                        Visible = SubseqDisb;
                    }
                    field("Issued Date To"; Rec."Issued Date To")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = SubseqDisb;
                        Visible = SubseqDisb;
                    }
                    field("Member No"; Rec."Member No")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            part(PVLines; "Loan Disbursement Lines")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = No = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    BatchLines: record "Loan Disbursement Lines";
                    Loanz: record Loans;
                begin
                    Rec.TestField(Posted, false);
                    Rec.TestField(Status, Rec.Status::Approved);
                    if Rec."Disbursement Destination" <> Rec."Disbursement Destination"::Normal then
                        Rec.TestField("Disburse Accounts");
                    if Rec."Subsequent Disbursements" = Rec."Subsequent Disbursements"::No then begin
                        //Posting.PostLoan(Rec."No.")
                        BatchLines.Reset;
                        BatchLines.SetRange(BatchLines.No, rec."No.");
                        BatchLines.SetRange(BatchLines.Posted, false);
                        if BatchLines.Find('-') then begin
                            repeat
                                if Loanz.Get(BatchLines."Loan No.") then begin
                                    Posting.PostLoanNormal(Loans."Loan No.");
                                    BatchLines.Posted := true;
                                    BatchLines."Posted By" := UserId();
                                    BatchLines."Date Posted" := Today();
                                    BatchLines."Time Posted" := Time;
                                    BatchLines.Modify;
                                end;
                            until BatchLines.Next() = 0;
                        end
                        else
                            Posting."PostLoan Subsequent Disbursements"(Rec."No.");

                        // //Send SMS when Topup
                        // DSLines.Reset;
                        // DSLines.SetRange(No, Rec."No.");
                        // if DSLines.FindFirst then begin
                        //     repeat
                        //         LoansTopUp.Reset;
                        //         LoansTopUp.SetRange("Loan No.", DSLines."Loan No.");
                        //         if LoansTopUp.FindFirst then begin
                        //             repeat
                        //                 LoanGuar.Reset;
                        //                 LoanGuar.SetRange("Loan No", LoansTopUp."Loan Top Up");
                        //                 LoanGuar.SetRange("Self Guarantee", false);
                        //                 if LoanGuar.FindFirst then begin
                        //                     if Loans2.Get(LoanGuar."Loan No") then begin
                        //                         ProductType := Loans2."Loan Product Type Name";
                        //                         AppAmount := Loans2."Approved Amount";
                        //                     end;
                        //                     repeat
                        //                         if Members.Get(LoanGuar."Member No") then
                        //                             CompInfo.Get;
                        //                     //TICKET:#608 STOP SMS TO GUARANTORS ON CLEARED LOANS
                        //                     // msg := 'Dear ' + LoanGuar.Name + ', The ' + ProductType + ' of Ksh. ' + Format(AppAmount) + ', you had guaranteed ' + LoanGuar."Loanee Name" + ' is now fully repaid.';

                        //                     // SendSMS.SendSms(Source::LOAN_GUARANTORS, Members."Phone No.", msg, Format(Loans2."Disbursement Account No"), '', true, 0, false, 'CBS', Loans2."Disbursement Account No", 'CBS');

                        //                     until LoanGuar.Next = 0;
                        //                 end;
                        //             until LoansTopUp.Next = 0;
                        //         end;
                        //     until DSLines.Next = 0;
                        // end;


                        // //Set FOSA Savings Account to Frozen
                        // DSLines.Reset;
                        // DSLines.SetRange(No, Rec."No.");
                        // if DSLines.FindFirst then begin
                        //     repeat
                        //         LoanGuar.Reset;
                        //         LoanGuar.SetRange("Loan No", DSLines."Loan No.");
                        //         LoanGuar.SetFilter("Guarantor Type", '%1', LoanGuar."Guarantor Type"::Collateral);
                        //         if LoanGuar.FindFirst then
                        //             SavingsAccounts.Reset;
                        //         SavingsAccounts.SetRange("Member No.", LoanGuar."Savings Account No./Member No.");
                        //         SavingsAccounts.SetRange("Loan Disbursement Account", true);
                        //         if SavingsAccounts.FindFirst then begin
                        //             SavingsAccounts.Status := SavingsAccounts.Status::Frozen;
                        //             SavingsAccounts."Status Change Reason" := 'FROZEN: Refer to Investment Manager';
                        //             SavingsAccounts.Modify;
                        //         end;
                        //     until DSLines.Next = 0;
                        // end;
                        Message('Loan Disbursement Posted Successfully.');
                    end;
                end;
            }
            separator(Action12)
            {
            }
            action("Suggest Disbursements")
            {
                ApplicationArea = Basic, Suite;
                Image = SuggestCustomerBill;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //Validations
                    if Rec."Subsequent Disbursements" <> Rec."Subsequent Disbursements"::Yes then begin
                        DisbLines.Reset;
                        DisbLines.SetRange(DisbLines.No, Rec."No.");
                        DisbLines.SetRange(Posted, false);
                        if DisbLines.Find('-') then begin
                            if Confirm('The lines will be deleted and recreated. Are you sure you want to proceed?', false) = true then
                                DisbLines.DeleteAll
                            else begin
                                Message('Proceed and process. The lines will not be regenerated');
                                exit;
                            end;
                        end;



                        Loans.Reset;
                        Loans.SetRange(Loans.Status, Loans.Status::Approved);
                        Loans.SetRange(Loans.Posted, false);
                        Loans.SetRange(Loans."Batch No.", Rec."No.");
                        if Loans.Find('-') then begin
                            repeat
                                if (Loans.Status <> Loans.Status::Approved) and (Loans.Status <> Loans.Status::Rejected) then
                                    Error(LoanNotApproved, Loans."Loan No.");
                                EntryNo := EntryNo + 1000;
                                DisbLines.Init;
                                DisbLines."Line No." := EntryNo;
                                DisbLines."Loan No." := Loans."Loan No.";
                                DisbLines.Validate(DisbLines."Loan No.");
                                DisbLines."Global Dimension 1 Code" := Loans."Global Dimension 1 Code";
                                DisbLines."Global Dimension 2 Code" := Loans."Global Dimension 2 Code";
                                DisbLines.No := Rec."No.";
                                DisbLines.Insert;
                            //Tag that it has been suggested
                            //Loans."Already Suggested":=TRUE;
                            //Loans.MODIFY;
                            until Loans.Next = 0;
                        end else
                            Message("MissingLoans:");

                    end;


                    /*
                    IF "Subsequent Disbursements"="Subsequent Disbursements"::Yes THEN
                      ERROR(Text003);
                    
                    GetIfNothingSelected;
                    
                    IF ("Issued Date From"<>0D ) AND ("Issued Date To"=0D) THEN
                      ERROR("LoanDateErr:");
                    
                    IF ("Issued Date From"=0D ) AND ("Issued Date To"<>0D) THEN
                      ERROR("LoanDateErr:");
                    
                    IF "Issued Date From">"Issued Date To" THEN
                      ERROR("LoanDateErr:");
                    
                    
                    //Date only placed--1
                    IF ("Loan Product Type"='') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"<>0D) AND ("Issued Date To"<>0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    //"Loan Product Type" only placed--2
                    
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"=0D) AND ("Issued Date To"=0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Loan Product Type","Loan Product Type");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Dim one only--3
                    IF ("Loan Product Type"='') AND ("Global Dimension 1 Code"<>'') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"=0D) AND ("Issued Date To"=0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Dim 2 only--4
                    
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"<>'') AND ("Issued Date From"=0D) AND ("Issued Date To"=0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Dates and Loan type placed--5
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"<>0D) AND ("Issued Date To"<>0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Loan Product Type","Loan Product Type");
                    Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //"Loan Product Type" and Dim1 placed--6
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"<>'') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"=0D) AND ("Issued Date To"=0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Loan Product Type","Loan Product Type");
                    Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //"Loan Product Type" AND dim2--7
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"<>'') AND ("Issued Date From"=0D) AND ("Issued Date To"=0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Loan Product Type","Loan Product Type");
                    Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Dim 1 and dates-8
                    
                    IF ("Loan Product Type"='') AND ("Global Dimension 1 Code"<>'') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"<>0D) AND ("Issued Date To"<>0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Dim1 and dim 2--9
                    
                    IF ("Loan Product Type"='') AND ("Global Dimension 1 Code"<>'') AND ("Global Dimension 2 Code"<>'') AND ("Issued Date From"=0D) AND ("Issued Date To"=0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Dim 2 and datess--10
                    IF ("Loan Product Type"='') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"<>'') AND ("Issued Date From"<>0D) AND ("Issued Date To"<>0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //All present--11
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"<>'') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"<>0D) AND ("Issued Date To"<>0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Loan Product Type","Loan Product Type");
                    Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Ltype Dim1 and dim2--12
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"<>'') AND ("Global Dimension 2 Code"<>'') AND ("Issued Date From"=0D) AND ("Issued Date To"=0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    //Ltype Dim1 and dates--13
                    
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"<>'') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"<>0D) AND ("Issued Date To"<>0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Loan Product Type","Loan Product Type");
                    Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    //Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Ltype Dim2 and dates--14
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"<>'') AND ("Issued Date From"<>0D) AND ("Issued Date To"<>0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Loan Product Type","Loan Product Type");
                    //Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Dim1 Dim2 and dates--15
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"<>'') AND ("Issued Date From"<>0D) AND ("Issued Date To"<>0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                    
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    IF ("Loan Product Type"='') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"=0D) AND ("Issued Date To"=0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    //Loans.SETRANGE(Loans."Loan Product Type","Loan product Type");
                    //Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    //Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    //Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                     */

                end;
            }
            separator(Action13)
            {
            }
            action("Suggest Partial Disbursements Due")
            {
                ApplicationArea = Basic, Suite;
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //ERROR('Invalid action....');

                    if Rec."Subsequent Disbursements" = Rec."Subsequent Disbursements"::No then
                        Error(Text003);

                    GetIfNothingSelected;

                    DisbLines.Reset();
                    DisbLines.SetRange(DisbLines.No, Rec."No.");
                    DisbLines.SetRange(Posted, false);

                    if DisbLines.Find('-') then begin
                        if not Confirm('The lines will be deleted and recreated. Are you sure you want to proceed?', false) then begin
                            Message('Proceed and process. The lines will not be regenerated');
                            exit;
                        end;
                        DisbLines.DeleteAll();
                    end;

                    if (Rec."Issued Date From" = 0D) or (Rec."Issued Date To" = 0D) then
                        Error(Text005);
                    if Rec."Member No" = '' then
                        Error(ErrorMember);
                    if Rec."Issued Date To" < Rec."Issued Date From" then
                        Error("LoanDateErr:");

                    ValidateAndProcessLoans();
                end;



            }
            separator(Action21)
            {
            }
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                begin
                    //   SugestDisb;
                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                var
                    //// //ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action("Cancel Document")
            {
                ApplicationArea = Basic, Suite;
                Image = StopPayment;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Approved then begin
                        if Confirm('Do you want to can cancel the documnet?', false) = true then begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                            Message('Batch canceled successfully');
                        end;
                    end;
                end;
            }
            separator(Action5)
            {
            }
            action("Loan Disbursement Schedule")
            {
                ApplicationArea = Basic, Suite;
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Batches.Reset;
                    Batches.SetRange(Batches."No.", Rec."No.");
                    if Batches.Find('-') then begin
                        //REPORT.Run(52185715, true, false, Batches);
                    end;
                end;
            }
            action(Approves)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify;
                end;
            }
            action("Clear Suggested Loans ")
            {
                ApplicationArea = Basic, Suite;
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //Validations
                    DisbLines.Reset;
                    DisbLines.SetRange(DisbLines.No, Rec."No.");
                    DisbLines.SetRange(Posted, false);
                    if DisbLines.Find('-') then begin
                        if Confirm('The lines will be deleted . Are you sure you want to proceed?', false) = true then
                            DisbLines.DeleteAll
                        else begin
                            Message('Proceed and process. The lines will not be regenerated');
                            exit;
                        end;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Subsequent Disbursements" = Rec."Subsequent Disbursements"::Yes then
            SubseqDisb := true
        else
            SubseqDisb := false;
        StatusControl;
    end;

    trigger OnAfterGetRecord()
    begin
        if Rec."Subsequent Disbursements" = Rec."Subsequent Disbursements"::Yes then
            SubseqDisb := true
        else
            SubseqDisb := false;
        SetControlAppearance;
        StatusControl;
    end;

    trigger OnOpenPage()
    begin
        if Rec."Subsequent Disbursements" = Rec."Subsequent Disbursements"::Yes then
            SubseqDisb := true
        else
            SubseqDisb := false;
        StatusControl;
        SetControlAppearance;
        if UserSetup.Get(Rec."Prepared By") then begin
            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
            Rec.Modify;
        end;
    end;

    var
        Text001: Label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        Text000: Label 'Do you want to Void Check No %1';
        Text002: Label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';
        Posting: Codeunit "Loans Process";
        Batches: Record "Loan Disbursement Header";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        GetScore: Codeunit "DCS Integration Base";
        "LoanDateErr:": Label 'Dates are inconsistent';
        EntryNo: Integer;
        Loans: Record Loans;
        DisbLines: Record "Loan Disbursement Lines";
        "MissingLoans:": Label 'There are missing loans within the filter';
        PartDisb: Record "Partial Disbursement Schedule";
        Text003: Label 'This option is meant for subsequent disbursements - Partial';
        Text004: Label 'This option is first time disbursements';
        Text005: Label 'Dates cannot be blank';
        LoanApp: Record Loans;
        LoanNotApproved: Label 'Loan No. %1 in the current batch is not approved. Remove from batch or approve first';
        SubseqDisb: Boolean;
        ApprovedEdit: Boolean;
        UserSetup: Record "User Setup";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        LoansTopUp: Record "Loans Top up";
        DSLines: Record "Loan Disbursement Lines";
        LoanGuar: Record "Loan Guarantors and Security";
        Members: Record Members;
        SendSms: Codeunit SendSms;
        CompInfo: Record "Company Information";
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";
        Loans2: Record Loans;
        ProductType: Text;
        AppAmount: Decimal;
        Message: Text;
        SavingsAccounts: Record "Savings Accounts";
        ErrorMember: Label 'Kindly select the Member No';
        Source: Enum "SMS Source";
        msg: Text;

    local procedure GetIfNothingSelected()
    begin
    end;

    //[Scope('OnPrem')]
    procedure StatusControl()
    begin
        ApprovedEdit := true;
        case Rec.Status of
            Rec.Status::Pending, Rec.Status::Approved, Rec.Status::Rejected:
                begin
                    ApprovedEdit := false;
                end;
            Rec.Status::Open:
                begin
                    ApprovedEdit := true;
                end;
        end;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    local procedure SugestDisb()
    begin
        //Validations
        DisbLines.Reset;
        DisbLines.SetRange(DisbLines.No, Rec."No.");
        DisbLines.SetRange(Posted, false);
        if DisbLines.Find('-') then begin
            if Confirm('The lines will be deleted and recreated. Are you sure you want to proceed?', false) = true then
                DisbLines.DeleteAll
            else begin
                Message('Proceed and process. The lines will not be regenerated');
                exit;
            end;
        end;
        Loans.Reset;
        //Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
        Loans.SetRange(Loans.Posted, false);
        Loans.SetRange(Loans."Batch No.", Rec."No.");
        if Loans.Find('-') then begin
            repeat
                if Loans.Status <> Loans.Status::Approved then
                    Error(LoanNotApproved, Loans."Loan No.");
                EntryNo := EntryNo + 1000;
                DisbLines.Init;
                DisbLines."Line No." := EntryNo;
                DisbLines."Loan No." := Loans."Loan No.";
                DisbLines.Validate(DisbLines."Loan No.");
                DisbLines."Global Dimension 1 Code" := Loans."Global Dimension 1 Code";
                DisbLines."Global Dimension 2 Code" := Loans."Global Dimension 2 Code";
                DisbLines.No := Rec."No.";
                DisbLines.Insert;
            //Tag that it has been suggested
            //Loans."Already Suggested":=TRUE;
            //Loans.MODIFY;
            until Loans.Next = 0;
        end else
            Message("MissingLoans:");
    end;

    local procedure ValidateAndProcessLoans()
    var
        EntryNo: Integer;
    begin
        EntryNo := 0;
        Loans.Reset();
        Loans.SetRange(Loans.Posted, true);
        Loans.SetRange(Loans."Mode of Disbursement", Loans."Mode of Disbursement"::"Partial Disbursement");
        if (Rec."Member No" <> '') then
            Loans.SetRange(Loans."Member No.", Rec."Member No");

        if (Rec."Loan Product Type" <> '') then
            Loans.SetRange(Loans."Loan Product Type", Rec."Loan Product Type");
        if (Rec."Global Dimension 1 Code" <> '') then
            Loans.SetRange(Loans."Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        if (Rec."Global Dimension 2 Code" <> '') then
            Loans.SetRange(Loans."Global Dimension 2 Code", Rec."Global Dimension 2 Code");

        if Loans.Find('-') then begin
            repeat
                ProcessPartDisb(EntryNo, Loans."Loan No.");
            until Loans.Next() = 0;
        end else
            Error("MissingLoans:");
    end;

    local procedure ProcessPartDisb(var EntryNo: Integer; LoanNo: Code[20])
    begin
        PartDisb.Reset();
        PartDisb.SetRange(PartDisb."Loan No.", LoanNo);
        PartDisb.SetRange(PartDisb.Posted, false);
        PartDisb.SetRange(PartDisb."Scheduled Disbursement Date", 0D, Rec."Issued Date To");

        if PartDisb.Find('-') then begin
            repeat
                EntryNo := EntryNo + 1000;
                DisbLines.Init();
                DisbLines."Line No." := EntryNo;
                DisbLines."Loan No." := PartDisb."Loan No.";
                DisbLines."Disbursement Amount" := PartDisb.Amount;
                DisbLines.Date := Today;
                DisbLines."Account No." := Loans."Loan Account";
                DisbLines."Approved Amount" := Loans."Approved Amount";
                DisbLines."Account Name" := Loans."Member Name";
                DisbLines."Global Dimension 1 Code" := Loans."Global Dimension 1 Code";
                DisbLines."Global Dimension 2 Code" := Loans."Global Dimension 2 Code";
                DisbLines."Disbursement Serial - PD" := PartDisb."Entry No";
                DisbLines.No := Rec."No.";
                DisbLines.Insert();

                PartDisb."Suggested for Disbursement" := true;
                PartDisb.Modify();
            until PartDisb.Next() = 0;
        end;
    end;
}

