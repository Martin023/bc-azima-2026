#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185744 "Calculate Fixed Interest"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Fixed Deposit Contract"; "Fixed Deposit Contract")
        {
            DataItemTableView = where("Fixed Deposit Status" = filter(Active));
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Account';
            column(ReportForNavId_1102755000; 1102755000)
            {
            }

            trigger OnAfterGetRecord()
            begin

                IntRate := 0;
                AccruedInt := 0;
                MidMonthFactor := 1;
                MinBal := false;
                RIntDays := IntDays;
                AsAt := PostStart;
                //Account.:=FALSE;
                //Account.MODIFY;


                //**IF "Fixed Deposit Contract"."FD Maturity Date"=PDate THEN BEGIN



                if ProductFactory.Get("Fixed Deposit Contract"."Product Type") then begin
                    FXDCODE := ProductFactory."Product ID";
                    //MESSAGE('THE FXD CODE IS %1',AccountType.Code);
                    if ProductFactory."Earns Interest" = true then begin
                        Account.Reset;
                        Account.SetRange(Account."No.", "Fixed Deposit Contract"."No.");
                        Account.SetFilter(Account."Date Filter", DFilter);
                        if Account.Find('-') then begin
                            // IF Account.can=TRUE THEN BEGIN
                            // Account.CALCFIELDS(Account."Balance (LCY)");
                            // Bal:=Account."Balance (LCY)";
                            // DBALANCE:=ROUND(((3/1200)*Bal)*1,0.05,'=');
                            //
                            // END;

                            FixedDtype.Reset;
                            FixedDtype.SetRange(FixedDtype.Code, "Fixed Deposit Contract"."Fixed Deposit Type");
                            if FixedDtype.Find('-') then begin
                                repeat
                                    FXDCODE := FixedDtype.Code;


                                    FDInterestCalc.Reset;
                                    FDInterestCalc.SetRange(FDInterestCalc.Code, "Fixed Deposit Contract"."Fixed Deposit Type");
                                    if FDInterestCalc.Find('-') then begin
                                        repeat
                                            if (Bal >= FDInterestCalc."Minimum Amount") and (Bal <= FDInterestCalc."Maximum Amount") then begin
                                                if "Fixed Deposit Contract"."Neg. Interest Rate" = 0 then
                                                    Rate := FDInterestCalc."Interest Rate"
                                                else
                                                    Rate := "Fixed Deposit Contract"."Neg. Interest Rate";
                                                //MESSAGE('the rate is %1',Rate);
                                                DURATION := FixedDtype."No. of Months";
                                                FXDINterest := Bal * Power((1 + (Rate / 1200)), DURATION);
                                                FXDINterest := ROUND(FXDINterest - Bal, 2);
                                                //MESSAGE('the comp interest is %1',FXDINterest);
                                            end;


                                        until FDInterestCalc.Next = 0;


                                    end;
                                until FixedDtype.Next = 0;
                            end;







                            AccruedInt := FXDINterest;
                            //MESSAGE('%1',AccruedInt);
                            //Check Interest Buffer

                            IntBuffer.Reset;
                            //IntBuffer.SETRANGE(IntBuffer."Member No.","Fixed Deposit Contract"."No.");
                            //IntBuffer.SETRANGE(IntBuffer."Loan Category","Fixed Deposit Contract"."Product Type");
                            //IntBuffer.SETRANGE(IntBuffer."Interest Date",TODAY);
                            if IntBuffer.Find('-') then begin
                                //**AccruedInt:=0;
                            end;

                            //End check interest buffer

                            if (AccruedInt > 0) then begin
                                //MESSAGE('%1',AccruedInt);
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'INTCALC';
                                GenJournalLine."Document No." := DocNo;
                                GenJournalLine."External Document No." := "Fixed Deposit Contract"."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No." := ProductFactory."Interest Expense Account";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := PDate;
                                GenJournalLine.Description := "Fixed Deposit Contract".Name;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                //IF AccountType."Fixed Deposit" = TRUE THEN
                                //GenJournalLine.Amount:=AccruedInt
                                //ELSE

                                //AccruedInt:=AccruedInt+ROUND(((IntRate/1200)*Bal)*MidMonthFactor,0.05,'>');
                                GenJournalLine.Amount := AccruedInt;
                                //MESSAGE('THE FXD CODE IS %1',FixedDtype.Code);
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := ProductFactory."Interest Payable Account";
                                GenJournalLine."Shortcut Dimension 1 Code" := "Fixed Deposit Contract"."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code" := "Fixed Deposit Contract"."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                /*
                               //POST WITHHOLDING TAX

                               LineNo:=LineNo+10000;

                               GenJournalLine.INIT;
                               GenJournalLine."Journal Template Name":='PURCHASES';
                               GenJournalLine."Line No.":=LineNo;
                               GenJournalLine."Journal Batch Name":='INTCALC';
                               GenJournalLine."Document No.":=DocNo;
                               GenJournalLine."External Document No.":="Fixed Deposit Contract"."No.";
                               GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                               GenJournalLine."Account No.":=ProductFactory."Interest Expense Account";
                               GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                               GenJournalLine."Posting Date":=PDate;
                               GenJournalLine.Description:='Witholding Tax on Int';
                               GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                               //IF AccountType."Fixed Deposit" = TRUE THEN
                               GenJournalLine.Amount:=AccruedInt*0.15;
                               //ELSE
                               //GenJournalLine.Amount:=ROUND(((IntRate/1200)*"Fixed Deposit Contract"."Balance (LCY)")*MidMonthFactor*0.15,0.05,'>');
                               GenJournalLine.VALIDATE(GenJournalLine.Amount);
                               GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                               GenJournalLine."Bal. Account No.":='21413';
                               //GenJournalLine."Bal. Account No.":=AccountType."Interest Payable Account";
                               GenJournalLine."Shortcut Dimension 1 Code":="Fixed Deposit Contract"."Global Dimension 1 Code";
                               GenJournalLine."Shortcut Dimension 2 Code":="Fixed Deposit Contract"."Global Dimension 2 Code";
                               GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                               GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                               GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                               //IF GenJournalLine.Amount<>0 THEN
                               GenJournalLine.INSERT;



                               //POST FXD TO ACCOUNT

                               LineNo:=LineNo+10000;

                               GenJournalLine.INIT;
                               GenJournalLine."Journal Template Name":='PURCHASES';
                               GenJournalLine."Line No.":=LineNo;
                               GenJournalLine."Journal Batch Name":='INTCALC';
                               GenJournalLine."Document No.":=DocNo;
                               GenJournalLine."External Document No.":="Fixed Deposit Contract"."No.";
                               GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                               IF ProductFactory.GET("Fixed Deposit Contract"."Product Type") THEN BEGIN
                               IF "Fixed Deposit Contract"."FD Maturity Instructions"="Fixed Deposit Contract"."FD Maturity Instructions"::"Transfer to Saving" THEN BEGIN
                               IF ProductFactory."Fixed Deposit" = TRUE THEN
                               GenJournalLine."Account No.":="Fixed Deposit Contract"."Savings Account"
                               //ELSE
                               //GenJournalLine."Account No.":="Fixed Deposit Contract"."No.";
                               END ELSE IF "Fixed Deposit Contract"."FD Maturity Instructions"="Fixed Deposit Contract"."FD Maturity Instructions"::Capitalize THEN

                               GenJournalLine."Account No.":="Fixed Deposit Contract"."No.";
                               END;
                               GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                               GenJournalLine."Posting Date":=PDate;
                               GenJournalLine.Description:='FXD Interest';
                               GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                               GenJournalLine.Amount:=-(AccruedInt-(AccruedInt*0.15));
                               GenJournalLine.VALIDATE(GenJournalLine.Amount);
                               GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                               GenJournalLine."Bal. Account No.":=ProductFactory."Interest Payable Account";
                               GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                               IF GenJournalLine.Amount<>0 THEN
                               GenJournalLine.INSERT;
                               */

                                //SMS MESSAGE
                                // SMSMessage.RESET;
                                // IF SMSMessage.FIND('+') THEN BEGIN
                                // iEntryNo:=SMSMessage."Entry No";
                                // iEntryNo:=iEntryNo+1;
                                // END
                                // ELSE BEGIN
                                // iEntryNo:=1;
                                // END;
                                //
                                // SMSMessage.INIT;
                                // SMSMessage."Entry No":=iEntryNo;
                                // SMSMessage."Batch No":='FIXED';
                                // SMSMessage."Document No":=DocNo;
                                // SMSMessage."Account No" := "Fixed Deposit Contract"."No.";
                                // SMSMessage."Date Entered":=TODAY;
                                // SMSMessage."Time Entered":=TIME;
                                // SMSMessage.Source:='FIXED';
                                // SMSMessage."Entered By":=USERID;
                                // SMSMessage."System Created Entry":=TRUE;
                                // SMSMessage."Sent To Server":=SMSMessage."Sent To Server"::"0";
                                // SMSMessage."SMS Message":= 'Dear member, your fixed deposit has matured. Kindly contact the sacco to roll over'+
                                // ' or withdraw your funds.';
                                // SMSMessage."Telephone No":="Fixed Deposit Contract"."Phone No.";
                                // SMSMessage.INSERT;
                                ///END OF SMS


                                /*
                                //Post Transaction
                                GenJournalLine.RESET;
                                GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name",'PURCHASES');
                                GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name",'INTCALC');
                                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJournalLine);
                                MODIFY;




                                //Post New
                                GenJournalLine.RESET;
                                GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                                GenJournalLine.SETRANGE("Journal Batch Name",'INTCALC');
                                IF GenJournalLine.FIND('-') THEN BEGIN
                                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B",GenJournalLine);
                                END;

                                //Post New
                                */

                                //Post
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange("Journal Batch Name", 'INTCALC');
                                if GenJournalLine.Find('-') then begin
                                    repeat
                                        GLPosting.Run(GenJournalLine);
                                    until GenJournalLine.Next = 0;
                                end;


                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange("Journal Batch Name", 'INTCALC');
                                GenJournalLine.DeleteAll;




                                //INTEREST BUFFER



                                IntBufferNo := IntBufferNo + 1;

                                InterestBuffer.Init;
                                //InterestBuffer."Loan No.":=IntBufferNo;
                                InterestBuffer."Member No." := "Fixed Deposit Contract"."No.";
                                InterestBuffer."Loan Category" := Account."Product Type";
                                //InterestBuffer."Interest Date":=TODAY;
                                //IF AccountType."Fixed Deposit" = TRUE THEN
                                //InterestBuffer."Interest Amount":=AccruedInt;
                                //ELSE
                                //InterestBuffer."Interest Amount":=ROUND(((IntRate/1200)*"Fixed Deposit Contract"."Balance (LCY)")*MidMonthFactor,0.05,'>');
                                //InterestBuffer."User ID":=USERID;
                                //
                                //IF InterestBuffer."Interest Amount" <> 0 THEN
                                //InterestBuffer.INSERT(TRUE);


                            end;

                        end;
                    end;
                end;

                "Fixed Deposit Contract"."Fixed Deposit Status" := "Fixed Deposit Contract"."fixed deposit status"::Matured;
                "Fixed Deposit Contract".Modify;

                //**END;

            end;

            trigger OnPostDataItem()
            begin

                /*GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                GenJournalLine.SETRANGE("Journal Batch Name",'INTCALC');
                IF GenJournalLine.FIND('-') THEN BEGIN
                REPEAT
                GLPosting.RUN(GenJournalLine);
                UNTIL GenJournalLine.NEXT = 0;
                END;
                
                
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                GenJournalLine.SETRANGE("Journal Batch Name",'INTCALC');
                GenJournalLine.DELETEALL; */

            end;

            trigger OnPreDataItem()
            var
                IntBufferNoTxt: Text;
            begin

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                GenJournalLine.SetRange("Journal Batch Name", 'INTCALC');
                GenJournalLine.DeleteAll;

                //IF DocNo = '' THEN
                //ERROR('Please specify the Document No.');

                //IF PDate = 0D THEN
                //ERROR('Please specify the Posting Date.');

                DocNo := 'INT EARNED';
                if PDate = 0D then
                    //PDate := "Fixed Deposit Contract"."FD Maturity Date";//TODAY;

                    InterestBuffer.Reset;
                if InterestBuffer.Find('+') then
                    IntBufferNoTxt := Format(IntBufferNo);
                IntBufferNoTxt := InterestBuffer."Loan No.";

                //StartDate:=CALCDATE('-1M',CALCDATE('1D',TODAY));
                //MESSAGE('start date %1',StartDate);
                //IntDays:=(TODAY-StartDate)+1;
                //IntDays:=(PostEnd-PostStart)+1;
                //MESSAGE('the number of days %1',IntDays);
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
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        LineNo: Integer;
        ChequeType: Record "Cheque Types";
        FDInterestCalc: Record "FD Interest Calculation Rules";
        InterestBuffer: Record "Ideal Repayment Schedule";
        IntRate: Decimal;
        DocNo: Code[10];
        PDate: Date;
        IntBufferNo: Integer;
        MidMonthFactor: Decimal;
        DaysInMonth: Integer;
        StartDate: Date;
        IntDays: Integer;
        AsAt: Date;
        MinBal: Boolean;
        AccruedInt: Decimal;
        RIntDays: Integer;
        Bal: Decimal;
        DFilter: Text[50];
        FixedDtype: Record "Fixed Deposit Type";
        DURATION: Integer;
        Dfilter2: Date;
        Dfilter3: Text[30];
        PostStart: Date;
        PostEnd: Date;
        DBALANCE: Decimal;
        FXDCODE: Code[20];
        Rate: Decimal;
        FXDINterest: Decimal;
        IntBuffer: Record "Interest Header";
        iEntryNo: Integer;
}
