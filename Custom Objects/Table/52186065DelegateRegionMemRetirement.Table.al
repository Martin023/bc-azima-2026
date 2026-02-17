table 52186065 "Delegate Region Mem Retirement"
{
    DrillDownPageID = "Delegate Group Retire Lists";
    LookupPageID = "Delegate Group Retire Lists";

    fields
    {
        field(1; "Code"; Code[50])
        {
            Editable = false;
        }
        field(2; "Delegate Region Description"; Text[100])
        {
            Editable = false;
        }
        field(3; "Electoral Zone"; Code[50])
        {
            Description = 'lookup Electrol Zones/Area Svr Center (52018626) (Type=FILTER(Electral Zone))';
            Editable = false;
            TableRelation = "Electrol Zones/Area Svr Center".Code WHERE(Type = FILTER("Electral Zone"));

            trigger OnValidate()
            begin
                ElectrolZonesAreaSvrCenter.Reset;
                ElectrolZonesAreaSvrCenter.SetRange(Code, "Electoral Zone");
                ElectrolZonesAreaSvrCenter.SetRange(Type, ElectrolZonesAreaSvrCenter.Type::"Electral Zone");
                if ElectrolZonesAreaSvrCenter.Find('-') then begin
                    "Electoral Zone Name" := ElectrolZonesAreaSvrCenter.Description;
                end;
            end;
        }
        field(4; "Electoral Zone Name"; Text[100])
        {
            Editable = false;
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(7; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(8; "Creation Date"; Date)
        {
            Editable = false;
        }
        field(9; "No. Series"; Code[20])
        {
        }
        field(10; County; Code[50])
        {
            Editable = false;
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST(County));

            trigger OnValidate()
            begin
                SegmentCountyDividendSignat.Reset;
                SegmentCountyDividendSignat.SetRange(Code, County);
                SegmentCountyDividendSignat.SetRange(Type, SegmentCountyDividendSignat.Type::County);
                if SegmentCountyDividendSignat.Find('-') then begin
                    "County Name" := SegmentCountyDividendSignat.Description;
                    ;
                end;
            end;
        }
        field(11; "Sub-County"; Code[50])
        {
            Editable = false;
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST("Sub-County"));

            trigger OnValidate()
            begin
                SegmentCountyDividendSignat.Reset;
                SegmentCountyDividendSignat.SetRange(Code, "Sub-County");
                SegmentCountyDividendSignat.SetRange(Type, SegmentCountyDividendSignat.Type::"Sub-County");
                if SegmentCountyDividendSignat.Find('-') then begin
                    "Sub-County Name" := SegmentCountyDividendSignat.Description;
                    ;
                end;
            end;
        }
        field(12; "County Name"; Text[100])
        {
            Editable = false;
        }
        field(13; "Sub-County Name"; Text[100])
        {
            Editable = false;
        }
        field(14; "Delegate Region"; Code[50])
        {
            Description = '//Lookup to Delegate Groupss';
            TableRelation = "Delegate Region".Code;

            trigger OnValidate()
            begin
                DelegateGroups.Reset;
                DelegateGroups.SetRange(Code, "Delegate Region");
                if DelegateGroups.Find('-') then begin
                    "Delegate Region Description" := DelegateGroups."Delegate Region Description";
                    "Electoral Zone" := DelegateGroups."Electoral Zone";
                    "Electoral Zone Name" := DelegateGroups."Electoral Zone Name";
                    "Global Dimension 1 Code" := DelegateGroups."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := DelegateGroups."Global Dimension 2 Code";
                    County := DelegateGroups.County;
                    "Sub-County" := DelegateGroups."Sub-County";
                    "County Name" := DelegateGroups."County Name";
                    "Sub-County Name" := DelegateGroups."Sub-County Name";
                    DelegateMemberss.Reset;
                    DelegateMemberss.SetRange(Code, "Delegate Region");
                    if DelegateMemberss.Find('-') then begin
                        DelegateMemberss.DeleteAll;
                    end;
                    //Get Delegate members
                    DelegateMembers.Reset;
                    DelegateMembers.SetRange(Code, "Delegate Region");
                    DelegateMembers.SetRange(DelegateMembers.Retired, false);
                    if DelegateMembers.Find('-') then begin
                        //DelegateMembers.DELETEALL;
                        repeat
                            DelegateMembersRetirement.Init;
                            DelegateMembersRetirement.Code := "Delegate Region";
                            DelegateMembersRetirement."Delegate MNO." := DelegateMembers."Delegate MNO.";
                            DelegateMembersRetirement."Delegate Name" := DelegateMembers."Delegate Name";
                            DelegateMembersRetirement."Job Tittle" := DelegateMembers."Job Tittle";
                            DelegateMembersRetirement.Position := DelegateMembers.Position;
                            DelegateMembersRetirement.Retired := DelegateMembers.Retired;
                            DelegateMembersRetirement.Status := DelegateMembers.Status;
                            DelegateMembersRetirement."Service Period" := DelegateMembers."Service Period";
                            DelegateMembersRetirement.Insert;
                        until DelegateMembers.Next = 0;

                    end;
                end;
            end;
        }
        field(15; Effected; Boolean)
        {
            Editable = false;
        }
        field(16; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(17; "Delegates Retired"; Boolean)
        {
            Editable = false;
        }
        field(18; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(19; "Reason for retirement"; Option)
        {
            OptionCaption = ',Death,Transfer,Resignation,Election,Impeachment,Suspension, Dismissed, Retired';
            OptionMembers = ,Death,Transfer,Resignation,Election,Impeachment,Suspension," Dismissed"," Retired";
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
    }

    trigger OnInsert()
    begin
        if Code = '' then begin
            MembNoSeries.Get;
            MembNoSeries.TestField(MembNoSeries."Delegate Sub Nos.");
            Code := NoSeriesMgt.GetNextNo(MembNoSeries."Delegate Sub Nos.");
            // NoSeriesMgt.InitSeries(MembNoSeries."Delegate Sub Nos.", xRec."No. Series", 0D, Code, "No. Series");
            "Created By" := UserId;
            "Creation Date" := Today;
        end;
    end;

    var
        ElectrolZonesAreaSvrCenter: Record "Electrol Zones/Area Svr Center";
        MembNoSeries: Record "Banking No Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        SegmentCountyDividendSignat: Record "Segment/County/Dividend/Signat";
        DelegateGroups: Record "Delegate Region";
        DelegateMembers: Record "Delegate Members";
        DelegateMembersRetirement: Record "Delegate Members Retirementss";
        DelegateMemberss: Record "Delegate Members Retirementss";
}

