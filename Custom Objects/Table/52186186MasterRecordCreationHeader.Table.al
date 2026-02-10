table 52186186 "Master Record Creation Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    GenLedgerSetup.Get();
                    //NoSeriesMgt.TestManual(GenLedgerSetup."Master Record Form Nos");
                    "No." := '';
                end;
            end;
        }
        field(2; "Requestor ID"; Code[50])
        {
        }
        field(3; Date; Date)
        {
        }
        field(4; Status; Option)
        {
            Editable = false;
            OptionCaption = ' ,Open,Pending Approval,Approved';
            OptionMembers = " ",Open,"Pending Approval",Approved;
        }
        field(5; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center B";
        }
        field(6; "Dimension 1"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal.Code, "Dimension 1");
                if DimVal.Find('-') then
                    "Dimension 1 Description" := DimVal.Name;
                Visible := true;
            end;
        }
        field(7; "Dimension 1 Description"; Text[50])
        {
        }
        field(8; "Dimension 2"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal.Code, "Dimension 2");
                if DimVal.Find('-') then
                    "Dimension 2 Description" := DimVal.Name;
            end;
        }
        field(9; "Dimension 2 Description"; Text[50])
        {
        }
        field(10; Comments; Text[250])
        {
        }
        field(11; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(12; Created; Boolean)
        {
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
            GenLedgerSetup.Get;
            //GenLedgerSetup.TESTFIELD(GenLedgerSetup."Master Record Form Nos");
            //NoSeriesMgt.InitSeries(GenLedgerSetup."Master Record Form Nos",xRec."No. Series",0D,"No.","No. Series");
        end;

        "Requestor ID" := UserId;
        Date := Today;
        Status := Status::Open;
    end;

    var
        GenLedgerSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimVal: Record "Dimension Value";
        Visible: Boolean;
}

