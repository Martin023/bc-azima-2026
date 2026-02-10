table 52187422 "Admin Cue Table"
{
    Caption = 'Admin Cue Table';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "No"; Code[20] )
        {
            Caption = '';
        }
        field(2; "Open Vehicle Requests"; Integer)
        {
            Caption = 'Open Vehicle Requests';
            CalcFormula = COUNT("Motor Vehicle Request" WHERE(Status = CONST(Open)));
            FieldClass = Flowfield;
        }
        field(9; "Vehicle Requests Pending Appr"; Integer)
        {
            Caption = 'Open Vehicle Requests';
            CalcFormula = COUNT("Motor Vehicle Request" WHERE(Status = CONST(Pending)));
            FieldClass = Flowfield;
        }
        field(3; "Open Motor Vehicle Movt"; Integer)
        {
            Caption = 'Open Motor Vehicle Movement';
            CalcFormula = count("Vehicle Movement" WHERE (Status = CONST(Open)));
            FieldClass = FlowField;
        }
        field(4; "Conference Hall & Meeting Room"; Integer)
        {
            Caption = 'Open Conf & Meeting Room Requests';
            CalcFormula = COUNT("Conference & Meeting Rooms-T" WHERE (Status = CONST(Open)));
            FieldClass = FlowField;
        }
        field(5; "Open Parking Requests"; Integer)
        {
            Caption = 'Open Parking Requests';
            CalcFormula = COUNT ("Parking Space" WHERE (Status = CONST(Open)));
            FieldClass = FlowField;
        }
        field(6; "Key Requests"; Integer)
        {
            Caption = 'Key Requests';
            CalcFormula = COUNT ("Key Request Table" WHERE ("Key Status" = const(Requested)));
            FieldClass = FlowField;
        }
        field(7; "Dispatched Keys"; Integer)
        {
            Caption = 'Dispatched Keys';
            CalcFormula = COUNT ("Key Request Table" where ("Key Status" = CONST(Dispatched)));
            FieldClass = Flowfield;
        }
        field(8; "Returned Keys"; Integer)
        {
            Caption = 'Returned Keys';
            CalcFormula = COUNT ("Key Request Table" where ("Key Status" = CONST (Returned)));
            FieldClass = FlowField;
        }
        field(10; "Expired Leases"; Integer)
        {
            Caption = 'Expired Leases';
            CalcFormula = COUNT ("Lease" where ("Lease Status" = CONST(Expired)));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(PK; "No")
        {
            Clustered = true;
        }
    }
}
