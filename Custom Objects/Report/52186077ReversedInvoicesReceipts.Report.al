#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186077 "Reversed Invoices & Receipts"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Reversed Invoices & Receipts.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Account Type" = filter(Tenant));
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
                DataItemTableView = where(Reversed = filter(true));
                DataItemLink = "Customer No." = field("No.");

                column(SCount; SNo)
                {
                }
                column(Posting_Date; "Posting Date")
                {

                }
                column(Document_Type; "Document Type")
                {
                }
                column(Customer_No_; "Customer No.")
                {
                }
                column(Customer_Name; "Customer Name")
                {
                }
                column(Description; Description)
                {
                }
                column(Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                column(Amount__LCY_; "Amount (LCY)")
                {
                }
                column(User_ID; "User ID")
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
                column(LeaseStatus; LeaseStatus)
                {

                }
                column(SqFt; SqFt)
                {

                }

                trigger OnAfterGetRecord()
                begin
                    SNo += 1;

                    Building := '';
                    Floor := '';
                    Unit := '';
                    KRAPin := '';

                    Lease.Reset();
                    Lease.SetRange("Tenant No.", "Cust. Ledger Entry"."Customer No.");
                    if Lease.FindFirst() then begin
                        Building := Lease."Property Name";
                        Floor := Lease."Floor Name";
                        Unit := Lease."Unit Code";
                        LeaseStatus := Lease."Lease Status";
                        SqFt := Lease."Area square ft";
                    end;

                    SalesInv.Reset();
                    SalesInv.SetRange("No.", "Cust. Ledger Entry"."Document No.");
                    if SalesInv.FindFirst() then begin
                        DocNo := SalesInv."Pre-Assigned No.";
                    end;
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
                    field("End Date:/AsAt"; EndDate)
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
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SNo: Integer;
        ShowTotoDetail: Boolean;
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
        LeaseStatus: Option;
        SqFt: Decimal;
}
