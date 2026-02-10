table 52185451 "Perfection File Action"
{
    Caption = 'Perfection File Action';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            AutoIncrement = true;
        }
        field(2; "Perfection No."; Code[20])
        {
            Caption = 'Perfection No.';
        }
        field(3; "Action On File"; Enum "Perfection Stages")
        {
            Caption = 'Action On File';
        }
        field(4; "Comments"; Text[2000])
        {
        }
        field(5; Date; Date)
        {
            Caption = 'Date';
            // trigger OnValidate()
            // begin
            //     if Rec.Date > TODAY THEN
            //     Error('Date Cannot be in the future!');
            // end;

            trigger OnValidate()
            begin
                Rec.TAT := '';
                //Rec.TAT := 0;

                if (Rec."Date" <> 0D) then
                    Duration := HRCodeunit.DetermineAge(Rec."Date", Rec."End Date");
                //Rec.TAT := HRCodeunit.DetermineAge(Rec."Date", Rec."End Date");
            end;
        }
        field(6; "Captured By"; Code[50])
        {
            Caption = 'Captured By';
        }
        field(7; "Captured On"; DateTime)
        {
            Caption = 'Created By';
        }
        field(8; "End Date"; Date)
        {
            trigger OnValidate()
            begin
                if Rec."End Date" > TODAY THEN
                    Error('Date Cannot be in the future!');

                if Rec."End Date" < Rec."Date" THEN
                    Error('End Date Cannot be less than Start Date!');
            end;
        }
        field(9; TAT; Code[100])
        {
            Caption = 'TAT';
        }
        field(10; "TAT Sent"; Boolean)
        {
            Caption = 'TAT Sent';
        }
    }
    keys
    {
        key(PK; "No.","Perfection No.")
        {
            Clustered = true;
        }
        // key(PK; "Perfection No.")
        // {
        //     Clustered = true;
        // }

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
        HRCodeunit: Codeunit "HR Codeunit";
        Duration: Text[100];
}
