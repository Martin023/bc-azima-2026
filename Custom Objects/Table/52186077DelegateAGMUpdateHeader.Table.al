table 52186077 "Delegate AGM Update Header"
{

    fields
    {
        field(1; "No."; Code[10])
        {
        }
        field(2; "AGM Year"; Integer)
        {
        }
        field(3; "Update Type"; Option)
        {
            OptionCaption = ' ,Retire,Appoint';
            OptionMembers = " ",Retire,Appoint;
        }
        field(4; "Created By"; Text[40])
        {
        }
        field(5; "Creation Date"; Date)
        {
        }
        field(6; "No. Series"; Code[20])
        {
        }
        field(7; Remarks; Text[50])
        {
        }
        field(8; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved;
        }
        field(9; Updated; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            MembNoSeries.Get;
            MembNoSeries.TestField(MembNoSeries."Delega Change");
            NoSeriesMgt.InitSeries(MembNoSeries."Delega Change", xRec."No. Series", 0D, "No.", "No. Series");
            "Created By" := UserId;
            "Creation Date" := Today;
        end;
    end;

    var
        MembNoSeries: Record "Banking No Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    [Scope('OnPrem')]
    procedure Tracker(DelegateMemberss: Record "Delegate Members")
    var
        DelegateRetireUpdate: Record "Delegate AGM Retire Update";
    begin
        DelegateRetireUpdate.Reset;
        DelegateRetireUpdate.SetRange(DelegateRetireUpdate."No.", "No.");
        if DelegateRetireUpdate.Find('-') then begin
            DelegateMemberss.Reset;
            DelegateMemberss.SetRange(DelegateMemberss.Code, DelegateRetireUpdate.Code);
            if DelegateMemberss.Find('-') then begin


                /* IF xRec."Delegate Region Description"<>"Delegate Region Description" THEN
                   DelegateMemberss.VALIDATE(DelegateMemberss."Delegate Region Description","Delegate Region Description");*/
                DelegateMemberss.Modify;
            end;
        end;

    end;
}

