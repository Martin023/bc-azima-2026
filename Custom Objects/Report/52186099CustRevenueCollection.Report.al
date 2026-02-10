#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186099 "Revenue Collection Report"
{
    DefaultLayout = RDLC;
    Caption = 'Revenue Collection Report';
    RDLCLayout = './bc-azima-2026/Layout/Revenue Collection Report.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Account Type" = filter(Employer));
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
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(ChqReceipt; ChqReceipt)
            {

            }
            column(ProcessingFee; ProcessingFee)
            {

            }
            column(ByProduct; ByProduct)
            {

            }
            column(LoansCheckOff; LoansCheckOff)
            {

            }
            column(SavingsCheckOff; SavingsCheckOff)
            {

            }
            column(Variance; Variance)
            {

            }

            trigger OnAfterGetRecord()
            begin

                ChqReceipt := 0;
                ProcessingFee := 0;
                ByProduct := 0;
                LoansCheckOff := 0;
                SavingsCheckOff := 0;
                Variance := 0;

                RevCollection.Reset();
                RevCollection.SetRange("Employer Code", Customer."No.");
                RevCollection.SetRange("Posting Period", PostingPeriod);
                RevCollection.SetRange(Status, Status::Approved);
                if RevCollection.FindFirst() then begin
                    repeat
                        ChqReceipt += RevCollection."Amount Collected";
                        ProcessingFee += RevCollection."Processing Fee";
                    until RevCollection.Next() = 0;
                end;

                CheckoffHeader.Reset();
                CheckoffHeader.SetRange("Account No.", Customer."No.");
                CheckoffHeader.SetRange("CheckOff Type", CheckoffHeader."CheckOff Type"::Loans);
                CheckoffHeader.SetRange("Posting Period", PostingPeriod);
                CheckoffHeader.SetRange(Posted, true);
                if CheckoffHeader.FindFirst() then begin
                    repeat
                        CheckoffHeader.CalcFields("Scheduled Amount");
                        LoansCheckOff += CheckoffHeader."Scheduled Amount";
                    until CheckoffHeader.Next() = 0;
                end;

                CheckoffHeader.Reset();
                CheckoffHeader.SetRange("Account No.", Customer."No.");
                CheckoffHeader.SetRange("CheckOff Type", CheckoffHeader."CheckOff Type"::Savings);
                CheckoffHeader.SetRange("Posting Period", PostingPeriod);
                CheckoffHeader.SetRange(Posted, true);
                if CheckoffHeader.FindFirst() then begin
                    repeat
                        CheckoffHeader.CalcFields("Scheduled Amount");
                        SavingsCheckOff += CheckoffHeader."Scheduled Amount";
                    until CheckoffHeader.Next() = 0;
                end;

                ByProduct := LoansCheckOff + SavingsCheckOff;
                Variance := ByProduct - ChqReceipt;


            end;
        }
    }

    requestpage
    {
        // SaveValues = true;

        layout
        {
            area(Content)
            {
                field("Posting Period"; PostingPeriod)
                {
                    ApplicationArea = basic, suite;
                    TableRelation = "Interest Due Period"."Interest Due Date";
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

    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        "SNo.": Integer;
        SavAcc: Record "Savings Accounts";
        ProductName: Text[50];
        RevCollection: Record "Revenue Collection";
        CheckoffHeader: Record "Checkoff Header";
        ChqReceipt: Decimal;
        ProcessingFee: Decimal;
        Variance: Decimal;
        ByProduct: Decimal;
        SavingsCheckOff: Decimal;
        LoansCheckOff: Decimal;
        PostingPeriod: Date;
}
