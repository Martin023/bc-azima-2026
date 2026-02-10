#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185497 "DCS Integration Base"
{

    trigger OnRun()
    begin
        summarizeMembTrans();
        //summarizeLoanData();
        //PostLoan('LF147287');
    end;

    var
        DCSMAnager: Codeunit "DCS Management";
        VBManager: Codeunit "VB Management";


    procedure PostLoan(LoanNo: Code[20])
    var
        LoanRec: Record Loans;
    begin
        if LoanRec.Get(LoanNo) then
            if LoanRec.Posted = false then
                if VBManager.PostLoan(LoanRec) then begin
                    LoanRec.Posted := true;
                    LoanRec.Modify;
                end;
    end;


    procedure updateLoanNo()
    begin
    end;


    procedure summarizeLoanData()
    var
        Loans: Record Loans;
        loanNo: Text[40];
    begin
        DCSMAnager.UpdateLoanData;
    end;


    procedure summarizeMembTrans()
    begin
        DCSMAnager.UpdateMemberData;
    end;


    procedure createLoan(AccountNo: Code[20]; Amount: Code[20]; ProductType: Code[20]; ExistingLoanAmount: Decimal; Ln: Text[20]; ApprovedAmount: Decimal) LoanNo: Code[20]
    var
        LoanRec: Record Loans;
        LoanType: Record "Product Factory";
        VendorRec: Record Vendor;
        AmountDecimal: Decimal;
    begin
        /*   VendorRec.RESET;
          VendorRec.SETRANGE(VendorRec."BOSA Account No",AccountNo);
          IF VendorRec.FIND('-') THEN BEGIN
             EVALUATE(AmountDecimal,Amount);
             LoanType.GET(ProductType);

               //   ERROR(ProductType);

        LoanRec.RESET;
        LoanRec.SETRANGE(LoanRec."Account No",AccountNo);
        LoanRec.SETRANGE(LoanRec."Loan Product Type",ProductType);
        //LoanRec.SETRANGE(LoanRec.Posted,FALSE);
        IF LoanRec.FIND('-') THEN BEGIN
         ERROR('error');
        END ELSE BEGIN


          Loans.RESET;
          Loans.SETRANGE(Loans."Client Code",AccountNo);
          Loans.SETRANGE(Loans."Loan Product Type",ProductType);
          Loans.SETRANGE(Loans.Posted,TRUE);
          IF Loans.FIND('-') THEN BEGIN
              REPEAT
                 Loans.CALCFIELDS(Loans."Outstanding Balance",Loans."Oustanding Interest");
                 IF((Loans."Outstanding Balance" + Loans."Oustanding Interest") > 0) THEN BEGIN
                   ExistingLoanAmount:=ExistingLoanAmount+(Loans."Outstanding Balance") + (Loans."Oustanding Interest");
                   ApprovedAmount:=Loans."Approved Amount";
                   Ln:=Loans."Loan No." ;
                 END;
              UNTIL Loans.NEXT=0;
          END;

       ERROR('ERROR');

          IF ExistingLoanAmount>0 THEN BEGIN

           SendSms('Msacco Loan',VendorRec."MPESA Mobile No",' Your application for icash has been rejected, reason:'+
                              'You have an outstanding iCash');

           END ELSE BEGIN

            LoanRec.INIT;
            LoanRec."Application Date":=TODAY;
            LoanRec."Loan Product Type":=ProductType;
            LoanRec."Client Code":= VendorRec."No.";
            LoanRec."Account No":=VendorRec."No.";
            LoanRec."Client Name":=VendorRec.Name;
            LoanRec."Requested Amount":=AmountDecimal;
            LoanRec."Approved Amount":=AmountDecimal;
            LoanRec."Loan Status":=LoanRec."Loan Status"::Issued;
            LoanRec.Source:=LoanRec.Source::FOSA;
            LoanRec.Interest:=LoanType."Interest rate";
            LoanRec."Repayment Start Date":=TODAY;
            LoanRec."BOSA No":=VendorRec."No.";
            LoanRec.Installments:=LoanType."No of Installment";
            LoanRec."Mode of Disbursement":=LoanRec."Mode of Disbursement"::"FOSA Loans";
            LoanRec."Global Dimension 1 Code":='FOSA';
            LoanRec.Repayment:=(ROUND((AmountDecimal * (LoanType."Interest rate" / 100)),1)) + (ROUND((AmountDecimal/1),1));
            LoanRec."Interest to be paid":=ROUND((AmountDecimal * (LoanType."Interest rate" / 100)),1);
            LoanRec.Interest:=ROUND((AmountDecimal * (LoanType."Interest rate" / 100)),1);
            LoanRec."Interest Due":=ROUND((AmountDecimal * (LoanType."Interest rate" / 100)),1);
            LoanRec."Loan Principle Repayment":=ROUND((AmountDecimal/1),1) ;
            LoanRec."Recovery Mode":=LoanRec."Recovery Mode"::Salary;
            LoanRec."Employer Code":= VendorRec."Employer P/F" ;
            LoanRec."Staff No":=VendorRec."Staff No" ;
            LoanRec."Loan Interest Repayment":= ROUND((AmountDecimal * (LoanType."Interest rate" / 100)),1);
            LoanRec.Posted:=FALSE;
            LoanRec."Issued Date":=TODAY;
            LoanRec."Mobile Loan":=TRUE;
           // LoanRec.INSERT(TRUE);
            END;
            END;
          END;
          */

    end;


    
}
