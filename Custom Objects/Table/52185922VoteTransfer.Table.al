table 52185922 "Vote Transfer"
{
    DrillDownPageID = "Vote Transfer List.";
    LookupPageID = "Vote Transfer List.";

    fields
    {
        field(1; No; Code[20])
        {
            Editable = false;
        }
        field(2; Date; Date)
        {
        }
        field(3; "Source Vote"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(4; "Destination Vote"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(5; "Budget Name"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(6; Amount; Decimal)
        {
            trigger OnValidate()
            begin
                if Amount <= 0 then
                    Error('Amount must be greater than zero');
            end;
        }
        field(7; "Source Dimension 1"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(8; "Destination Dimension 1"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(12; Remarks; Text[200])
        {
        }
        field(13; "Raised By"; Code[20])
        {
        }
        field(14; "Raised Date"; Date)
        {
        }
        field(15; "Approved By"; Code[20])
        {
        }
        field(16; "Approved Date"; Date)
        {
        }
        field(17; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(18; Posted; Boolean)
        {
        }
        field(19; "Posted Date"; Date)
        {
        }
        field(20; "Posted By"; Code[20])
        {
        }
        field(21; "Source Dimension 2"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(22; "Destination Dimension 2"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(23; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Cancelled';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Cancelled;
        }
        field(24; "Amount Available"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
            GenLedgerSetup.Get;
            GenLedgerSetup.TestField(GenLedgerSetup."Vote Transfer Nos.");
            No := NoSeriesMgt.GetNextNo(GenLedgerSetup."Vote Transfer Nos.");
            // NoSeriesMgt.InitSeries(GenLedgerSetup."Vote Transfer Nos.", xRec."No. Series", 0D, No, "No. Series");

        end;
    end;

    var
        GenLedgerSetup: Record "General Ledger Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
}

