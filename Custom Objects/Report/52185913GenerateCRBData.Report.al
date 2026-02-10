#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185913 "Generate CRB Data"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Generate CRB Data.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Outstanding Balance" = filter(> 0), "Approved Amount" = filter(> 0), Installments = filter(> 0));
            RequestFilterFields = "Loan No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin

                NoDays := 0;
                Loans.CalcFields(Loans."Outstanding Balance", "Total Loan Balance");//,"Last Pay Date");


                if Loans."Outstanding Balance" > 0 then begin

                    CreditLedgerEntry.Reset;
                    CreditLedgerEntry.SetRange("Loan No", Loans."Loan No.");
                    if CreditLedgerEntry.Find('+') then
                        LastPayDate := CreditLedgerEntry."Posting Date";




                    Cust.Reset;
                    Cust.SetRange(Cust."No.", Loans."Member No.");
                    if Cust.Find('-') then begin

                        CRBA.Init;
                        CRBA.No := NoLine + CRBA.No;
                        if EMPLOYER.Get(Cust."Employer Code") then
                            CRBA."Employer Name" := EMPLOYER.Name;

                        MyString := Cust.Name;


                        String1 := Token(MyString, ' ');
                        String2 := Token(MyString, ' ');
                        String3 := Token(MyString, ' ');
                        String4 := Token(MyString, ' ');
                        String5 := Token(MyString, ' ');
                        if Cust."First Name" <> '' then begin
                            CRBA."Forename 1" := Cust."Other Names";
                            CRBA."Forename 2" := Cust."First Name";
                            CRBA."Forename 3" := Cust."Middle Name";
                        end else begin
                            CRBA."Forename 1" := String4;
                            CRBA."Forename 2" := String2;
                            CRBA."Forename 3" := String3;
                        end;
                        DateFor := '0';
                        if Cust."Date of Birth" <> 0D then begin
                            Day := Date2dmy(Cust."Date of Birth", 1);
                            Month := Date2dmy(Cust."Date of Birth", 2);
                            Year := Date2dmy(Cust."Date of Birth", 3);

                            if Month < 10 then
                                m := '0'
                            else
                                m := '';

                            if Day < 10 then
                                d := '0'
                            else
                                d := '';

                            DateFor := Format(Year) + m + Format(Month) + d + Format(Day);

                            CRBA."Date of Birth" := DateFor;
                            DateFor := '0';
                        end;

                        CRBA."Client Code" := Cust."No.";
                        CRBA."Account Number" := Loans."Loan No.";
                        if Cust.Gender = Cust.Gender::Male then begin
                            CRBA.Gender := 'M';
                        end else begin
                            CRBA.Gender := 'F';
                        end;

                        CRBA.Nationality := 'KE';
                        if Cust."Marital Status" = Cust."marital status"::Married then
                            CRBA."Marital Status" := 'M' else
                            if
Cust."Marital Status" = Cust."marital status"::Single then
                                CRBA."Marital Status" := 'S' else
                                CRBA."Marital Status" := Format(Cust."Marital Status");
                        CRBA."Primary Identification Number" := Cust."Primary Identification";
                        CRBA."Primary Identification code" := '001';
                        CRBA."Secondary Identification code" := '';
                        CRBA."Secondary Identification" := Cust."Secondary Identification";
                        CRBA."Mobile No" := '';//Cust."Phone No.";
                        CRBA."Work Telephone" := Cust."Office Telephone No.";
                        CRBA."Postal Address 1" := '';//Cust."Current Address";
                        CRBA."Postal Address 2" := '';//Cust."Current Address";
                        CRBA."Postal Location Town" := Cust.City;
                        CRBA."Postal Location Country" := 'KE';
                        CRBA."Post Code" := Cust."Post Code";
                        // CRBA."Physical Address 1" := Cust."Current Residence";
                        CRBA."Location Town" := 'NAIROBI';//Cust.Location;
                        CRBA."Location Country" := 'KE';
                        CRBA."Postal Location Town" := Cust."Delegates Zone";
                        CRBA."Date of Physical Address" := '';
                        CRBA."Customer Work Email" := Cust."E-Mail";
                        if EMPLOYER.Get(Cust."Employer Code") then
                            CRBA."Employer Name" := '';//EMPLOYER.Name;
                        CRBA."Employment Type" := '';
                        CRBA."Account Type" := 'S';
                        CRBA."Account Product Type" := 'H';
                        CRBA."Employer Industry Type" := '011';


                        //Salary Details
                        SalaryDetails.Reset;
                        SalaryDetails.SetRange(SalaryDetails."Loan No", Loans."Loan No.");
                        SalaryDetails.SetFilter(SalaryDetails.Type, '%1', SalaryDetails.Type::"Gross Pay");
                        if SalaryDetails.FindFirst then begin

                            CRBA."Income Amount" := DelChr(Format(ROUND(SalaryDetails.Amount, 1, '=')) + '00', '=', ',');

                            //SalaryDetails.AmountSalaryDetails.Amount=(SalaryDetails.Amount);

                        end;


                        if CalcDate('1M', LastPayDate) <> 0D then begin
                            Day := Date2dmy(LastPayDate, 1);
                            Month := Date2dmy(LastPayDate, 2);
                            Year := Date2dmy(LastPayDate, 3);
                            if Month < 10 then
                                m := '0'
                            else
                                m := '';

                            if Day < 10 then
                                d := '0'
                            else
                                d := '';

                            DateFor := Format(Year) + m + Format(Month) + d + Format(Day);

                        end
                        else
                            DateFor := '0';

                        CRBA."Installment Due Date" := DateFor;

                        CRBA."No of Days in Arreas" := ROUND((AsatDate - LastPayDate), 1.0, '>');
                        CRBA."No of Installment In" := ROUND(((CRBA."No of Days in Arreas") / 30), 1, '=');


                        //Added to trim the 2 last decimal places of amounts
                        ApprAmt2DecPlaces := Format(ROUND(Loans."Approved Amount", 0.01, '='));
                        OutBal2DecPlaces := Format(ROUND(Loans."Outstanding Balance", 0.01, '='));
                        Last2DecPlacesApprAmt := CopyStr(ApprAmt2DecPlaces, StrLen(ApprAmt2DecPlaces) - 1);
                        Last2DecPlacesOutBal := CopyStr(OutBal2DecPlaces, StrLen(OutBal2DecPlaces) - 1);



                        CRBA."Overdue Balance" := DelChr(Format(ROUND(Loans."Total Loan Balance", 1, '=')) + '00', '=', ',');
                        CRBA."Overdue Date" := DateFor;

                        CRBA."Account Product Type" := 'H';

                        if Cust."Registration Date" <> 0D then begin

                            Day := Date2dmy(Loans."Disbursement Date", 1);
                            Month := Date2dmy(Loans."Disbursement Date", 2);
                            Year := Date2dmy(Loans."Disbursement Date", 3);
                            if Month < 10 then
                                m := '0'
                            else
                                m := '';

                            if Day < 10 then
                                d := '0'
                            else
                                d := '';

                            DateFor := Format(Year) + m + Format(Month) + d + Format(Day);
                        end
                        else
                            DateFor := '0';



                        CRBA."Date Account Opened" := DateFor;
                        CRBA."Original Amount" := DelChr(Format(ROUND(Loans."Approved Amount", 1, '=')) + Last2DecPlacesApprAmt, '=', ',');
                        CRBA."Currency of Facility" := 'KES';
                        CRBA."Amount in Kenya shillings" := DelChr(Format(ROUND(Loans."Total Loan Balance", 1, '=')) + Last2DecPlacesApprAmt, '=', ',');
                        CRBA."Current Balance" := DelChr(Format(ROUND(Loans."Total Loan Balance", 1, '=')) + '00', '=', ',');
                        CRBA."Lenders Registered Name" := 'HARAMBEE SACCO';
                        CRBA."Lenders Trading Name" := 'HARAMBEE SACCO';
                        CRBA."Lenders Branch Name" := Loans."Global Dimension 2 Code";
                        CRBA."Lenders Branch Name" := 'HQ';
                        CRBA."Lenders Branch Code" := Loans."Global Dimension 2 Code";
                        CRBA."Lenders Branch Code" := 'N049001';
                        //CRBA."Income Amount":=SalaryDetails.Amount;

                        /*
                        IF (Loans."Loans Category-SASRA"=Loans."Loans Category-SASRA"::Perfoming) OR
                          (Loans."Loans Category-SASRA"=Loans."Loans Category-SASRA"::Watch) THEN
                        CRBA."Performing / NPL Indicator":='A'
                        ELSE
                        CRBA."Performing / NPL Indicator":='B';

                        IF (Loans."Loans Category-SASRA"=Loans."Loans Category-SASRA"::Perfoming) OR
                          (Loans."Loans Category-SASRA"=Loans."Loans Category-SASRA"::Watch) THEN

                        CRBA."Account Status":='F'
                        ELSE
                        CRBA."Account Status":='B';
                        */

                        //Based on New Requirement
                        Loans.CalcFields("Loans Category-SASRA");
                        if (Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Perfoming) then
                            CRBA."Performing / NPL Indicator" := 'A';

                        if (Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Watch) then
                            CRBA."Performing / NPL Indicator" := 'B';

                        if (Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Doubtful) then
                            CRBA."Performing / NPL Indicator" := 'D';

                        if (Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Substandard) then
                            CRBA."Performing / NPL Indicator" := 'C';

                        if (Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Loss) then
                            CRBA."Performing / NPL Indicator" := 'E';

                        CRBA."Account Status" := 'F';
                        //End New Requirement


                        if LastPayDate <> 0D then begin
                            Day := Date2dmy(LastPayDate, 1);
                            Month := Date2dmy(LastPayDate, 2);
                            Year := Date2dmy(LastPayDate, 3);
                            if Month < 10 then
                                m := '0'
                            else
                                m := '';

                            if Day < 10 then
                                d := '0'
                            else
                                d := '';

                            DateFor := Format(Year) + m + Format(Month) + d + Format(Day);

                        end
                        else
                            DateFor := '0';
                        CRBA."Account Status Date" := DateFor;
                        CRBA."Repayment Period" := Loans.Installments;
                        CRBA."Payment Frequency" := 'M';

                        if Loans."Disbursement Date" <> 0D then begin

                            Day := Date2dmy(Loans."Disbursement Date", 1);
                            Month := Date2dmy(Loans."Disbursement Date", 2);
                            Year := Date2dmy(Loans."Disbursement Date", 3);

                            if Month < 10 then
                                m := '0'
                            else
                                m := '';

                            if Day < 10 then
                                d := '0'
                            else
                                d := '';

                            DateFor := Format(Year) + m + Format(Month) + d + Format(Day);

                        end
                        else
                            DateFor := '0';

                        CRBA."Disbursement Date" := DateFor;
                        /*CRBA."Insallment Amount":=DELCHR(FORMAT(ROUND(Loans.Repayment,1,'='))+'00','=',',');*/
                        CRBA."Insallment Amount" := DelChr(Format(ROUND(Loans."Approved Amount" / Loans.Installments, 1, '=')) + '00', '=', ',');
                        if LastPayDate <> 0D then begin
                            Day := Date2dmy(LastPayDate, 1);
                            Month := Date2dmy(LastPayDate, 2);
                            Year := Date2dmy(LastPayDate, 3);
                            if Month < 10 then
                                m := '0'
                            else
                                m := '';

                            if Day < 10 then
                                d := '0'
                            else
                                d := '';

                            DateFor := Format(Year) + m + Format(Month) + d + Format(Day);

                        end
                        else
                            DateFor := '0';
                        //CALCFIELDS(LastPayDate);
                        Evaluate(ToDate, Format(LastPayDate));
                        DateFilter := ToDate;
                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan No.", Loans."Loan No.");
                        LoansR.SetFilter(LoansR."Date Filter", DateFilter);
                        if LoansR.Find('-') then begin

                        end;

                        CRBA."Date of Latest Payment" := DateFor;
                        CRBA."Last Payment Amount" := DelChr(Format(ROUND(LoansR.Repayment, 1, '=')) + '00', '=', ',');
                        CRBA."Type of Security" := 'U';
                        CRBA."Loan No." := "Loan No.";
                        CRBA.Outbal := Loans."Total Loan Balance";
                        CRBA.Insert(true);
                    end;
                end;

            end;

            trigger OnPreDataItem()
            begin

                CRBA.DeleteAll;

                if AsatDate = 0D then
                    AsatDate := Today;






                NoLine := NoLine + 1;
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
                field(AsatDate; AsatDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'As at Date';
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
        Cust: Record "Members";
        CRBA: Record "CRB Data";
        NoDays: Integer;
        AsatDate: Date;
        NoLine: Integer;
        TxtKeep: Text[250];
        DateInput: Date;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        DateFor: Text[250];
        MyString: Text[250];
        String1: Text[250];
        String2: Text[250];
        String3: Text[250];
        TempString: Text[250];
        String4: Text[250];
        String5: Text[250];
        Pos: Integer;
        LoanSche: Record "Ideal Repayment Schedule";
        EMPLOYER: Record Customer;
        DateFilter: Text[100];
        ToDate: Text[100];
        LoansR: Record Loans;
        d: Text[30];
        m: Text[30];
        AmountForm: Text[30];
        VEND: Record Vendor;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        LastPayDate: Date;
        SalaryDetails: Record "Appraisal Salary Details";
        ApprAmt2DecPlaces: Text;
        OutBal2DecPlaces: Text;
        Last2DecPlacesApprAmt: Text;
        Last2DecPlacesOutBal: Text;


    procedure Token(var Text: Text[100]; Separator: Text[1]) Token: Text[100]
    var
        Pos: Integer;
    begin
        Pos := StrPos(Text, Separator);

        if Pos > 0 then begin
            Token := CopyStr(Text, 1, Pos - 1);
            if Pos + 1 <= StrLen(Text) then
                Text := CopyStr(Text, Pos + 1)
            else
                Text := '';
        end else begin
            Token := Text;
            Text := '';
        end;
    end;
}
