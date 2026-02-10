#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186134 "Sales Invoice Printout"
{
    DefaultLayout = RDLC;
    ApplicationArea = Basic, suite;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Sales Invoice Printout.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(No_; "No.")
            {

            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {

            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {

            }
            column(Document_Date; "Document Date") { }
            column(Posting_Date; "Posting Date") { }
            column(Pre_Assigned_No_; "Pre-Assigned No.") { }
            column(Due_Date; "Due Date") { }
            column(AmountHeader; Amount) { }
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
            column(Building; Building)
            {

            }
            column(Floor; Floor)
            {

            }
            column(Unit; Unit)
            {

            }
            column(KRAPin; KRAPin)
            {

            }


            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Type; Type)
                {
                }
                column(No_Line; "No.")
                {

                }
                column(Document_No_; "Document No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(VATAmt; "Sales Invoice Line"."Amount Including VAT" - "Sales Invoice Line".Amount)
                {
                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(Amount_Including_VAT; "Amount Including VAT")
                {

                }
                column(Amount; Amount)
                {

                }

                trigger OnAfterGetRecord()
                begin

                end;

            }


            trigger OnAfterGetRecord()
            begin
                Building := '';
                Floor := '';
                Unit := '';
                KRAPin := '';

                Lease.Reset();
                Lease.SetRange("Tenant No.", "Sales Invoice Header"."Sell-to Customer No.");
                if Lease.FindFirst() then begin
                    Building := Lease."Property Name";
                    Floor := Lease."Floor Name";
                    Unit := Lease."Unit Code";
                end;

                Customer.Reset();
                Customer.SetRange("No.", "Sales Invoice Header"."Sell-to Customer No.");
                if Customer.FindFirst() then begin
                    KRAPin := Customer."KRA PIN";
                end;


            end;

            trigger OnPreDataItem()
            begin
                // "Sales Invoice Header".SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
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
                // group("Date Filter")
                // {
                // field("Start Date:"; StartDate)
                // {
                //     ApplicationArea = Basic;
                //     ShowMandatory = True;
                // }
                // field("End Date:"; EndDate)
                // {
                //     ApplicationArea = Basic;
                //     ShowMandatory = true;
                // }
                // }
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
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail";// + '- Website: ' + CompanyInformation."Home Page";
    end;


    var
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Lease: Record Lease;
        Customer: Record Customer;
        Building: Text[100];
        Floor: Text[100];
        Unit: Code[20];
        KRAPin: Code[20];
        StartDate: Date;
        EndDate: Date;
        VATAmt: Decimal;
        Bank: Code[50];
        Name: Text[200];
        Branch: Text[200];
        AccNo: Code[50];
}
