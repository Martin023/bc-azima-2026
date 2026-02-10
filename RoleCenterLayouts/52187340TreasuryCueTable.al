table 52187340 "Treasury Cue Table"
{
    Caption = 'Treasury Cue Table';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';

        }
        field(2; "Branch Treasury"; Decimal)
        {
            Caption = 'Branch Treasury ';
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            Editable = false;
        }
        field(3; "Main Treasury"; Decimal)
        {
            Caption = 'Main Treasury';
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            Editable = false;
        }
        field(4; "Cashier Transactions Today"; Decimal)
        {
            FieldClass = Normal;
            Caption = 'Cashier Transactions Today';
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            Editable = false;
        }
        field(5; "TC Transactions"; Decimal)
        {
            FieldClass = Normal;
            Caption = 'Teasury Cashier Transactions this month';
            AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            Editable = false;
        }
        field(6; "Investments and Money Market"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Active Investments';
            Calcformula = count("Investment Header" where(Status = filter(Fulfilled)));

        }
        field(7; "Petty Cash Payments"; Integer)
        {
            Caption = 'Approved Petty cash payments';
            FieldClass = FlowField;
            CalcFormula = Count("Payments Header" where("payment type" = filter("Petty Cash")));


        }
        field(8; "Cash Flow Forecasts"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Cash Flow Forecasts';
            CalcFormula = Count("Cash Flow Forecast");


        }
        // field(9; "Chart of Cash Flow A/C"; Decimal)
        // {
        //     Caption = 'Chart of Cash Flow A/C';
        //     CalcFormula = Count ("Chart of Cash Flow Account" WHERE (Status = filter ("Pending Approval")));
        //     FieldClass = FlowField;

        // }
        field(11; "Cash Flow Manual Revenue"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Cash Flow Manual Expenses';
            CalcFormula = Count("Cash Flow Manual Revenue");

        }
        field(12; "Tenants List"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Tenants List';
            CalcFormula = Count(Customer);

        }
        field(13; "Sales Invoice"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Sales Invoice';
            CalcFormula = Count("Sales Invoice Header");

        }
        field(14; "Receipt"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Tenants Receipts';
            CalcFormula = Count("Receipts Header");

        }
        field(15; "Matured Investments"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Matured Investments';
            Calcformula = count("Investment Header" where(Status = filter(Matured)));

        }
        field(16; "Invoicing of Tenants"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Invoicing of Tenants';
            CalcFormula = Count(Customer where("Account Type" = filter("Tenant"), Status = filter(Approved)));
        }
        field(17; "External Conf. Hall Clients"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Invoicing for External Conference Hall Clients';
            CalcFormula = Count("Conference & Meeting Rooms-T" where("Type of Meeting/Function" = filter(External), Status = filter(Approved), "Status of the Booking" = filter(Accepted)));
        }
        field(18; "Invoicing of Parking"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Invoicing of Parking';
            CalcFormula = Count("Parking Space" where(Status = filter(Approved), "Client" = filter(External), "Booking Status" = filter(Assigned)));
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
