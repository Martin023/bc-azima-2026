table 52185962 Verdict
{

    fields
    {
        field(1; "Case No"; Code[20])
        {
            TableRelation = Legal. "Case Number";
        }
        field(2; No; Code[20])
        {
        }
        field(3; Description; Text[250])
        {
        }
        field(4; Date; Date)
        {
            trigger OnValidate()
            begin
                if Date > TODAY then
                    ERROR('Date cannot be in the future');
            end;
        }
        field(5; "No. Series"; Code[20])
        {
        }
        field(6; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(7; "Captured By"; Code[50])
        {
        }
        field(8; "Captured On"; DateTime)
        {
        }

    }

    keys
    {
        key(Key1; No, "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*IF No = '' THEN
        BEGIN
          GLSetup.GET;
         // GLSetup.TESTFIELD(GLSetup.Verdict");
          NoSeriesMgt.InitSeries(GLSetup.Verdict,xRec."No. Series",0D,No,"No. Series");
        END;
        */
            Rec."Captured On" := CURRENTDATETIME;
            Rec."Captured By" := UserId;

    end;


    var
        GLSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

