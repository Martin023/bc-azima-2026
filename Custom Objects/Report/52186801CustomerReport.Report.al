#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186801 "Customer Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Customer Report.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields =;
            column(No_; "No.")
            {
            }
            column(Name; Name)
            {

            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyAddress2; CompanyAddress2)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(PrintedAt; PrintedAt)
            {

            }
            column(PrintedBy; PrintedBy)
            {

            }
            column(Credits; Credits)
            {

            }
            column(Debits; Debits)
            {

            }
            column(OPeningBal; OPeningBal)
            {

            }
            column(ClosingBal; ClosingBal)
            {

            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = SORTING("Posting Date", "Entry No.") ORDER(Ascending) where("Posting Date" = filter(<> 0D), Reversed = filter(false));

                column(Document_No_; "Document No.")
                {

                }
                column(Amount; Amount)
                {

                }
                column(Debit_Amount; "Debit Amount")
                {

                }
                column(Credit_Amount; "Credit Amount")
                {

                }
                column(Description; Description)
                {

                }
                column(Balance; Balance)
                {

                }
                column(PostingDate; PostingDate)
                {

                }

                trigger OnAfterGetRecord()
                begin
                    Balance := 0;
                    PostingDate := '';
                    PostingDate := GlobalFunctions.DMUDateFormatDate("Cust. Ledger Entry"."Posting Date");
                    "Cust. Ledger Entry".CalcFields(Amount, "Credit Amount", "Debit Amount");
                    Balance := BalanceBF + "Cust. Ledger Entry".Amount;
                    BalanceBF := Balance;
                    ClosingBal := Balance;

                    if "Credit Amount" > 0 then
                        Credits += "Credit Amount";

                    if "Debit Amount" > 0 then
                        Debits += "Debit Amount";
                end;
            }
            trigger OnAfterGetRecord()
            begin

            end;

            trigger OnPostDataItem()
            begin

            end;

            trigger OnPreDataItem()
            begin


                if CompanyInformation.Get then
                    CompanyInformation.CalcFields(CompanyInformation.Picture);
                CompanyAddress := CompanyInformation.Address;
                CompanyAddress2 := CompanyInformation."Post Code" + ' ' + CompanyInformation.City + ' ' + CompanyInformation."Country/Region Code";

                CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
                CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '.';
                Website := ' ' + CompanyInformation."Home Page";

                if StartDate = 0D then StartDate := 19900101D;
                if EndDate = 0D then EndDate := Today;

                PrintedBy := GlobalFunctions.FormatUserName(UserId);
                PrintedAt := GlobalFunctions.DMUDateFormatDateTime(CurrentDateTime);

                CustomerAccount.Reset();
                CustomerAccount.SetRange("No.", Customer."No.");
                CustomerAccount.SETRANGE("Date Filter", 0D, CALCDATE('-1D', StartDate));
                CustomerAccount.CALCFIELDS(CustomerAccount."Balance (LCY)");
                BalanceBF := CustomerAccount."Balance (LCY)";
                OPeningBal := BalanceBF;

                if StartDate = 0D then BalanceBF := 0;

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
                field(StartDate; StartDate)
                {

                }
                field(EndDate; EndDate)
                {

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

        //Columns
        CompanyAddress: Text;
        CompanyAddress2: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Website: Text;
        Balance: Decimal;
        PostingDate: Text;
        PrintedBy: Text;
        PrintedAt: Text;
        OPeningBal: decimal;
        ClosingBal: Decimal;
        Credits: Decimal;
        Debits: Decimal;



        //Request Page
        StartDate: Date;
        EndDate: Date;

        CompanyInformation: Record "Company Information";
        CustomerAccount: Record Customer;
        BalanceBF: Decimal;
        GlobalFunctions: Codeunit "Global Functions";

    
}
