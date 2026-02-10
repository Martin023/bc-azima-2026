#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186088 "Tenant Statement"
{
    DefaultLayout = RDLC;
    ApplicationArea = Basic, suite;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Tenant Statement.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(KRA_PIN; "KRA PIN")
            {

            }
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

            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                CalcFields = "Debit Amount", "Credit Amount";
                RequestFilterFields = "Customer No.", "Posting Date";
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = sorting("Posting Date") order(ascending);
                column(Posting_Date; "Posting Date")
                {
                }
                column(Customer_No_; "Customer No.")
                {
                }
                column(Customer_Name; "Customer Name")
                {
                }
                column(Document_No_; "Document No.")
                {
                }
                column(Document_Type; "Document Type")
                {
                }
                column(Description; Description)
                {
                }
                column(Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                column(Global_Dimension_2_Code; "Global Dimension 2 Code")
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
                column(RunningBalance; CalcRunningAccBalance.GetCustAccBalance("Cust. Ledger Entry"))// TODO
                {
                }

                column(User_ID; "User ID")
                {
                }
                column(Document_Date; "Document Date")
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
                column(DocNo; DocNo)
                {

                }
                column(OpenBal; OpenBal)
                {
                }
                column(Applies_to_Doc__No_; "Applies-to Doc. No.") { }
                trigger OnAfterGetRecord()
                begin
                    Building := '';
                    Floor := '';
                    Unit := '';
                    KRAPin := '';

                    "Cust. Ledger Entry".CalcFields("Debit Amount", "Credit Amount");
                    Lease.Reset();
                    Lease.SetRange("Tenant No.", "Customer No.");
                    if Lease.FindFirst() then begin
                        Building := Lease."Property Name";
                        Floor := Lease."Floor Name";
                        Unit := Lease."Unit Code";
                    end;

                    SalesInv.Reset();
                    SalesInv.SetRange("No.", "Cust. Ledger Entry"."Document No.");
                    if SalesInv.FindFirst() then begin
                        DocNo := SalesInv."Pre-Assigned No.";
                    end;

                    if StartDate <> 0D then begin
                        CustLedgerEntry.Reset();
                        CustLedgerEntry.SetRange("Customer No.", Customer."No.");
                        CustLedgerEntry.SetFilter("Posting Date", '<=%1', StartDate);
                        if CustLedgerEntry.FindLast() then
                            // "Cust. Ledger Entry".CalcFields("Running Balance");
                            OpenBal := CalcRunningAccBalance.GetCustAccBalance(CustLedgerEntry);
                    end
                    else
                        OpenBal := 0;
                end;

                trigger OnPreDataItem()
                begin
                    if EndDate = 0D then
                        EndDate := TODAY;
                    if StartDate = 0D then
                        "Cust. Ledger Entry".SetFilter("Date Filter", '..%2', EndDate)
                    else
                        "Cust. Ledger Entry".SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                end;
            }
            // trigger OnAfterGetRecord()
            // begin
            //     if StartDate <> 0D then begin
            //         Customer.SetFilter("Date Filter", '..%2', StartDate);
            //         Customer.CalcFields("Balance (LCY)");
            //         OpenBal := Customer."Balance (LCY)";
            //     end
            //     else
            //         OpenBal := 0;
            // end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group("Date Filter")
                {
                    field("Start Date:"; StartDate)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = True;
                    }
                    field("End Date:"; EndDate)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
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
        CalcRunningAccBalance: Codeunit "Customer Running balalnce";
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        // Customer: Record Customer;
        Lease: Record Lease;
        Building: Text[100];
        Floor: Text[100];
        Unit: Code[20];
        KRAPin: Code[20];
        StartDate: Date;
        EndDate: Date;
        OpenBal: Decimal;
        Runninbalance: Decimal;
        DocNo: Code[50];
        SalesInv: Record "Sales Invoice Header";
        CustLedgerEntry: Record "Cust. Ledger Entry";
}
