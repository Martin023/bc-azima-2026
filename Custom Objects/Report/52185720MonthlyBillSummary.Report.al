#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185720 "Monthly Bill Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Monthly Bill Summary.rdl';

    dataset
    {
        //dataitem(52185859;52185859)
        dataitem("Loans Interest"; "Loans Interest")
        {
            RequestFilterFields = "Interest Date", No;
            column(ReportForNavId_1; 1)
            {
            }
            column(RepaymentBill_LoansInterest; "Loans Interest"."Repayment Bill")
            {
            }
            column(InterestBill_LoansInterest; "Loans Interest"."Interest Bill")
            {
            }
            column(InterestDate_LoansInterest; "Loans Interest"."Interest Date")
            {
            }
            column(Picture; Company.Picture)
            {
            }
            column(Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Month; M)
            {
            }
            column(MN; MN)
            {
            }
            column(OutstandingInterest; "Loans Interest"."Outstanding Interest")
            {
            }
            column(OutstandingBalance; "Loans Interest"."Outstanding Balance")
            {
            }
            column(Year; Year)
            {
            }

            trigger OnAfterGetRecord()
            begin
                MNTH := Format(Date2dmy("Loans Interest"."Interest Date", 2));
                if MNTH = '1' then begin
                    M := 'January';
                    MN := 1;
                end;
                if MNTH = '2' then begin
                    M := 'February';
                    MN := 2;
                end;
                if MNTH = '3' then begin
                    M := 'March';
                    MN := 3;
                end;
                if MNTH = '4' then begin
                    M := 'April';
                    MN := 4;
                end;
                if MNTH = '5' then begin
                    M := 'May';
                    MN := 5;
                end;
                if MNTH = '6' then begin
                    M := 'June';
                    MN := 6;
                end;
                if MNTH = '7' then begin
                    M := 'July';
                    MN := 7;
                end;
                if MNTH = '8' then begin
                    M := 'August';
                    MN := 8;
                end;
                if MNTH = '9' then begin
                    M := 'September';
                    MN := 9;
                end;
                if MNTH = '10' then begin
                    M := 'October';
                    MN := 10;
                end;
                if MNTH = '11' then begin
                    M := 'November';
                    MN := 11;
                end;
                if MNTH = '12' then begin
                    M := 'December';
                    MN := 12;
                end;
                Year := Format(Date2dmy("Loans Interest"."Interest Date", 3));
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if Company.Get() then
            Company.CalcFields(Company.Picture);
    end;

    var
        MNTH: Text[30];
        M: Text[30];
        Year: Text;
        MN: Integer;
        Company: Record "Company Information";
}
