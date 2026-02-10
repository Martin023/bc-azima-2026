table 52186081 "File Location"
{

    fields
    {
        field(1; "Member No."; Code[20])
        {
            TableRelation = Members."No.";
        }
        field(2; "Approval Type"; Option)
        {
            OptionCaption = ' ,Loans,Special Loans,Personal Loans,Refunds,Funeral Expenses,Withdrawals - Resignation,Withdrawals - Death,Branch Loans';
            OptionMembers = " ",Loans,"Special Loans","Personal Loans",Refunds,"Funeral Expenses","Withdrawals - Resignation","Withdrawals - Death","Branch Loans";
        }
        field(3; "Section Code"; Code[20])
        {
        }
        field(4; Remarks; Text[50])
        {
        }
        field(5; Status; Option)
        {
            OptionCaption = 'Being Processed,Processed,Forwarded';
            OptionMembers = "Being Processed",Processed,Forwarded;
        }
        field(6; "Current Location"; Boolean)
        {
            Editable = true;
        }
        field(7; "Date/Time In"; DateTime)
        {
            Editable = true;
        }
        field(8; "Date/Time Out"; DateTime)
        {
        }
        field(9; "USER ID"; Code[60])
        {
            Editable = false;
        }
        field(10; "Entry No."; Integer)
        {
            Editable = false;
        }
        field(11; "Station Name"; Text[50])
        {
        }
        field(12; Station; Code[50])
        {
        }
        field(13; Narration; Text[200])
        {
        }
        field(14; Folio; Code[60])
        {
            Caption = 'Volume No.';
        }
        field(15; "Issued To"; Text[50])
        {
        }
        field(16; "Responsibility Centre"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";

        }

    }

    keys
    {
        key(Key1; "Member No.", "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // IF "Request Number" = '' THEN BEGIN
        //  MembNoSeries.GET;
        //  MembNoSeries.TESTFIELD(MembNoSeries."Delegate Application Nos.");
        //  NoSeriesMgt.InitSeries(MembNoSeries."Delegate Application Nos.",xRec."File MVT Date",0D,"Request Number","File MVT Date");
        // "File MVT Time":=USERID;
        // "Current File Location":=TODAY;
        // END;
    end;

    var
        ElectrolZonesAreaSvrCenter: Record "Electrol Zones/Area Svr Center";
        MembNoSeries: Record "Banking No Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SegmentCountyDividendSignat: Record "Segment/County/Dividend/Signat";
}

