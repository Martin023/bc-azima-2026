table 52186239 "Electoral Zones"
{
    DataCaptionFields = "Code", "Electoral Zone Name";
    DrillDownPageID = "Approved Electoral List";
    LookupPageID = "Approved Electoral List";

    fields
    {
        field(1; "Code"; Code[50])
        {
            trigger OnValidate()
            begin
                if Code <> xRec.Code then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."ECLT Zones");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Electoral Zone Name"; Text[100])
        {
            Editable = true;

            trigger OnValidate()
            begin
                ElectoralZones.Reset;
                ElectoralZones.SetFilter(Code, '<>%1', Rec.Code);
                ElectoralZones.SetRange("Electoral Zone Name", Rec."Electoral Zone Name");
                if ElectoralZones.FindFirst then
                    Error('The electoral zone %1 already exists', "Electoral Zone Name");
            end;
        }
        field(3; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(4; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(5; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(6; "Creation Date"; Date)
        {
            Editable = false;
        }
        field(7; "No. Series"; Code[20])
        {
        }
        field(8; County; Code[50])
        {
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST(County));

            trigger OnValidate()
            var
            begin
                CalcFields("County Name");
            end;
        }
        field(9; "Sub-County"; Code[50])
        {
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST("Sub-County"), County = field(County));
            trigger OnValidate()
            var
            begin
                CalcFields("Sub County Name");
            end;
        }

        field(11; Status; Enum "Workflow Status Main Flags")
        {
            Editable = false;


            trigger OnValidate()
            begin
                if Status = Status::Approved then begin
                    DelegateOfficials.Reset;
                    DelegateOfficials.SetRange("Electoral Zone", Code);
                    if DelegateOfficials.FindSet then begin
                        repeat
                            DelegateOfficials.Status := DelegateOfficials.Status::Approved;
                            "Creation Date" := Today;
                            DelegateOfficials.Modify;
                        until DelegateOfficials.Next = 0;
                    end;
                end;
                if Status = Status::Pending then begin
                    DelegateOfficials.Reset;
                    DelegateOfficials.SetRange("Electoral Zone", Code);
                    if DelegateOfficials.FindSet then begin
                        repeat
                            DelegateOfficials.Status := DelegateOfficials.Status::Pending;
                            DelegateOfficials.Modify;
                        until DelegateOfficials.Next = 0;
                    end;
                end;

                if Status = Status::Rejected then begin
                    DelegateOfficials.Reset;
                    DelegateOfficials.SetRange("Electoral Zone", Code);
                    if DelegateOfficials.FindSet then begin
                        repeat
                            DelegateOfficials.Status := DelegateOfficials.Status::Rejected;
                            DelegateOfficials.Modify;
                        until DelegateOfficials.Next = 0;
                    end;
                end;
            end;
        }
        field(12; "County Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Segment/County/Dividend/Signat".Description where(Code = field(County)));
            Editable = false;
        }

        field(13; "Sub County Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Segment/County/Dividend/Signat".Description where(Code = field("Sub-County")));
            Editable = false;
        }

        field(15; "Date Entered"; Date)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, "Electoral Zone Name", County, "Sub County Name", Status)
        {

        }
    }

    trigger OnDelete()
    begin
        //ERROR('Delete is not allowed');
    end;

    trigger OnInsert()
    begin

        if Code = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."ECLT Zones");
            Code := NoSeriesMgt.GetNextNo(NoSetup."ECLT Zones");
            // NoSeriesMgt.InitSeries(NoSetup."ECLT Zones", xRec.code, 0D, code, "No. Series");
            "Created By" := UserId;
            "Date Entered" := Today;
        end;
    end;

    var
        ElectrolZonesAreaSvrCenter: Record "Electrol Zones/Area Svr Center";
        MembNoSeries: Record "Banking No Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        SegmentCountyDividendSignat: Record "Segment/County/Dividend/Signat";
        DimensionValue: Record "Dimension Value";
        Members: Record Members;
        DelegateOfficials: Record "Delegate Officials";
        ElectoralZones: Record "Electoral Zones";
        NoSetup: Record "Credit Nos. Series";
}

