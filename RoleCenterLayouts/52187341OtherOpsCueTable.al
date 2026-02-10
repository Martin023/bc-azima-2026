table 52187341 "Other Operations Cue Table"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; NewContracts; Integer)
        {
            Caption = 'Open Contracts';
            CalcFormula = count(Contracts where(Status = filter(New)));
            FieldClass = FlowField;
        }

        field(4; "Open Legal Cases"; Integer)
        {
            //FieldClass = FlowField;
            Caption = 'Open Legal Cases';
            CalcFormula = count(Legal where(Status = CONST (Open)));
            FieldClass = FlowField;
        }
        field(5; "Contract Purchase invoices"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Open Legal Cases';
            CalcFormula = count("Purchase Header" where("Document Type" = CONST(Invoice)));
        }
        field(6; "Closed Cases"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Closed Cases';
            CalcFormula = count(Legal where("Case Status" = CONST(Closed)));
        }
        // field(8; "Upcoming Matters"; Integer)
        // {
            
        //     Caption = 'Upcoming Matters';
        //     CalcFormula = COUNT("Legal Upcoming Matters" where("Shceduled Date" = const(TODAY)));
        //     FieldClass = FlowField;
        //     // trigger OnValidate()
        //     // var                         
        //     // MyNotification: Notification;  
        //     // UpcomingMatters: Record "Legal Upcoming Matters";    

        //     // begin 
        //     //     UpcomingMatters.SETRANGE("Matter Status", UpcomingMatters."Matter Status"::Upcoming);
        //     //     UpcomingMatters.FINDSET;
        //     //     if UpcomingMatters.COUNT > 0 then
        //     //         //MyNotification.MESSAGE('There are ' + FORMAT(UpcomingMatters.COUNT) + ' upcoming matters', 'Upcoming Matters', MyNotification::Type::Information);
        //     //         //MyNotification.Message('Upcoming Matter' + UpcomingMatters."Record ID" + UpcomingMatters.Matter + 'requires attention before' + FORMAT(UpcomingMatters."Shceduled Date"), 'Upcoming Matters', MyNotification.Type::Information);
        //     // end;                
        // }
        field(9; "Pending Nominee Form Requests"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Pending Nominee Form Requests';
            CalcFormula = count("Nominee Form Request" where(Status = filter(Pending)));
        }
        // field(2; "Open Vehicle Requests"; Integer)
        // {
        //     Caption = 'Open Vehicle Requests';
        //     CalcFormula = COUNT("Motor Vehicle Request" WHERE(Status = CONST(Open)));
        //     FieldClass = Flowfield;
        // }
        field(10; "Pending Contract Requests"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Pending Contract Requests';
            CalcFormula = count("Contract Request" where(Status = filter(Pending)));
        }
        field(11; "Ongoing Matters"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Ongoing Matters';
            CalcFormula = count(Legal where("Case Status" = CONST(Ongoing)));
        }
        field(12; "ADR Cases"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'ADR Cases';
            CalcFormula = count(Legal where("Case Status" = CONST(ADR), "ADR" = CONST(True)));
        }
        field(13; "Open Appeals"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Open Appeals';
            CalcFormula = count("Appeals Table" where(Status = CONST(New)));
        }
        field(14; "Ongoing Appeals"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Ongoing Appeals';
            CalcFormula = count("Appeals Table" where("Case Status" = CONST(Ongoing)));
        }
        field(15; "Open Surety Applications"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Open Surety Applications';
            CalcFormula = count("Surety Management" where(Status = filter(Open)));
        }
        field(18; "Invoicing of Parking"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Invoicing of Parking';
            CalcFormula = Count("Parking Space" where (Status = filter(Approved), "Client" = filter(External),"Booking Status" = filter(Assigned)));
        }
        field(19; "Expired Leases"; Integer)
        {
            Caption = 'Expired Leases';
            CalcFormula = COUNT ("Lease" where ("Lease Status" = CONST(Expired)));
            FieldClass = FlowField;
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
