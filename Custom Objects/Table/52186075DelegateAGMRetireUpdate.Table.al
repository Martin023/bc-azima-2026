table 52186075 "Delegate AGM Retire Update"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Code"; Code[50])
        {
            Description = 'Lookup to Delegate groups';
            Editable = false;
            TableRelation = "Delegate Region".Code;
        }
        field(3; "Delegate MNO."; Code[50])
        {
            Description = 'Lookup to Member table';
            TableRelation = "Delegate Members"."Delegate MNO.";

            trigger OnValidate()
            begin

                DelegateMembers.Reset;
                DelegateMembers.SetRange("Delegate MNO.", "Delegate MNO.");
                DelegateMembers.SetRange(Retired, false);
                if DelegateMembers.Find('-') then begin
                    Code := DelegateMembers.Code;
                    "Delegate Name" := DelegateMembers."Delegate Name";
                    Position := DelegateMembers.Position;
                    "Job Tittle" := DelegateMembers."Job Tittle";
                    Retired := true;

                    Members.Reset;
                    Members.SetRange("No.", DelegateMembers."Delegate MNO.");
                    if Members.Find('-') then
                        "ID No." := Members."Primary Identification";
                end;
            end;
        }
        field(4; "Delegate Name"; Text[100])
        {
            Editable = false;
        }
        field(5; Position; Code[50])
        {
            Description = 'Lookup 39004358 filter type tittle';
            TableRelation = "Salutation Tittles".Code WHERE(Type = CONST(Position));

            trigger OnValidate()
            begin
                // DelegateMembers.RESET;
                // DelegateMembers.SETRANGE(Code,Code);
                // DelegateMembers.SETRANGE(Position,Position);
                // IF DelegateMembers.FIND('-') THEN
                //  BEGIN
                //   IF Position<>'' THEN
                //    ERROR(ErrPosition,Position);
                //  END;
            end;
        }
        field(6; "Job Tittle"; Code[50])
        {
            Description = '39004358';
            TableRelation = "Salutation Tittles".Code WHERE(Type = CONST(Tittle));

            trigger OnValidate()
            begin
                Retired := true;
            end;
        }
        field(7; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved;
        }
        field(8; Retired; Boolean)
        {
            Editable = true;
        }
        field(9; "Retire Date"; Date)
        {
            Editable = true;

            trigger OnValidate()
            begin
                Retired := true;
                if "Retire Date" > Today then
                    "Retire Date" := Today;
            end;
        }
        field(10; "Retired By"; Code[50])
        {
            Editable = false;
        }
        field(11; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(12; "Reason for retirement"; Option)
        {
            OptionCaption = ',Death,Transfer,Resignation,Election,Impeachment';
            OptionMembers = ,Death,Transfer,Resignation,Election,Impeachment;
        }
        field(14; "ID No."; Code[20])
        {
        }
        field(15; Type; Option)
        {
            OptionCaption = 'Normal,ADM';
            OptionMembers = Normal,ADM;
        }
        field(16; "Delegate Code"; Code[20])
        {
        }
        field(17; "Region Names"; Text[100])
        {
            CalcFormula = Lookup("Delegate Region"."Delegate Region Description" WHERE(Code = FIELD(Code)));
            FieldClass = FlowField;
        }
        field(18; "Update Type"; Option)
        {
            OptionCaption = ' ,Retire,Appoint';
            OptionMembers = " ",Retire,Appoint;
        }
        field(19; "Retirement Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Delegate MNO.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DelegateMembers: Record "Delegate Members";
        ErrPosition: Label 'You cannot have the same position of %1 within the same group';
        ErrMemb: Label 'This member has not met minimum membership period of %1';
        Members: Record Members;
        Header: Record "Delegate AGM Update Header";

    // [Scope('OnPrem')]
    procedure Tracker(DelegateMemberss: Record "Delegate Members")
    var
        DelegateRetireUpdate: Record "Delegate AGM Retire Update";
    begin
        DelegateRetireUpdate.Reset;
        DelegateRetireUpdate.SetRange(DelegateRetireUpdate."No.", "No.");
        if DelegateRetireUpdate.Find('-') then begin
            repeat
                DelegateMemberss.Reset;
                DelegateMemberss.SetRange(DelegateMemberss.Code, DelegateRetireUpdate.Code);
                DelegateMemberss.SetRange(DelegateMemberss."Delegate MNO.", DelegateRetireUpdate."Delegate MNO.");
                if DelegateMemberss.Find('-') then begin
                    if xRec.Retired <> Retired then
                        DelegateMemberss.Validate(DelegateMemberss.Retired, Retired);
                    if xRec."Retirement Date" <> "Retire Date" then
                        DelegateMemberss.Validate(DelegateMemberss."Retirement Date", "Retire Date");
                    DelegateMemberss."Retired By" := "Retired By";
                    if xRec."Reason for retirement" <> "Reason for retirement" then
                        DelegateMemberss.Validate(DelegateMemberss."Reason for retirement", "Reason for retirement");

                    DelegateMemberss.Modify;
                end;
                DelegateRetireUpdate."Retired By" := UserId;
                DelegateRetireUpdate.Modify;
            until DelegateRetireUpdate.Next = 0;

            Header.Reset;
            Header.SetRange("No.", DelegateRetireUpdate."No.");
            if Header.Find('-') then
                Header.Updated := true;
            Header.Modify;


        end;
    end;
}

