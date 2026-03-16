table 52185976 "HR Drivers"
{
    LookupPageID = "Drivers List";
    DrillDownPageId = "Drivers List";
    Caption = 'Drivers Table';

    fields
    {
        field(24; "No."; Code[20])
        {
            Caption = 'Driver No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    MembNoSeries.Get;
                    NoSeriesMgt.TestManual(MembNoSeries."Driver No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(1; "Code"; Code[10])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.Get(Code);
                "Driver Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                "Driver ID No." := HREmp."ID Number";
                "Driver Phone No." := HREmp."Home Phone Number";
            end;
        }
        field(21; "Staff Number"; Code[20])
        {
        }
        field(23; "Driver Phone No.";code[20])
        {
            // trigger OnValidate()
            // begin
            //     if STRLEN(Rec."Driver Phone No.") <> 10 then begin
            //         ERROR('Driver Phone No. must be 10 digits');
            //     end;
            // end;
        }

        field(2; "Driver Name"; Text[80])
        {
        }
        field(22; "Driver ID No."; Integer)
        {
        }
        field(3; "Driver License Number"; Code[20])
        {
        }
        field(4; "Last License Renewal"; Date)
        {
            trigger OnValidate()
            begin
                if Rec."Last License Renewal" > TODAY then begin
                    Error('Last License Renewal Date cannot be greater than today');
                end;
            end;
        }
        field(5; "Renewal Interval"; DateFormula)
        {
            //OptionMembers = " ",Days,Weeks,Months,Quarterly,"3Years";
        }
        field(6; "Renewal Interval Value"; Integer)
        {
            trigger OnValidate()
            begin
                /*StrValue:='D';
                
                IF "Renewal Interval"="Renewal Interval"::Days THEN
                  BEGIN
                    StrValue:='D';
                  END
                ELSE IF "Renewal Interval"="Renewal Interval"::Weeks THEN
                  BEGIN
                    StrValue:='W';
                  END
                ELSE IF "Renewal Interval"="Renewal Interval"::Months THEN
                  BEGIN
                    StrValue:='M';
                  END
                ELSE IF "Renewal Interval"="Renewal Interval"::Quarterly THEN
                  BEGIN
                    StrValue:='Q';
                  END
                ELSE IF "Renewal Interval"="Renewal Interval"::Years THEN
                  BEGIN
                    StrValue:='Y';
                  END;
                
                "Next License Renewal":= CALCDATE(FORMAT("Renewal Interval Value") + StrValue , "Last License Renewal");
                */

            end;
        }
        field(7; "Next License Renewal"; Date)
        {

            trigger OnValidate()
            begin
                if Rec."Next License Renewal" < TODAY then 
                //begin
                    Error('Next License Renewal Date cannot be less than today');
                //end
                //else
                    //"Next License Renewal" := "Last License Renewal" + "Renewal Interval Value";
            end;
        }
        field(8; "Year Of Experience"; Decimal)
        {
        }
        field(9; Class; Code[20])
        {
        }
        field(10; Active; Boolean)
        {
        }
        field(11; "Created By"; Code[50])
        {
        }
        field(12; "Created at"; DateTime)
        {
        }
        field(13; "Driver Availability"; Option)
        {
            OptionMembers = Available,Unavailable;
        }
        field(14; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
        }
        field(15; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
        field(16; Status; Option)
        {
            OptionMembers =  Open,Pending,Approved,Rejected;
        }
        field(17; Created; Boolean)
        {
        }
        field(18; "No. Series"; Code[10])
        {
            TableRelation = "Credit Nos. Series"."No.";
        }
        field(19; "No of Trips"; Integer)
        {
            trigger OnValidate()
            begin
                Rec."No of Trips" :=+ 1;
            end;
        }
        field(20; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(31; "User ID"; Code[50])
        {
        }

    }
    

    keys
    {
        // key(Keys; "Code", "No.")
        // {
        //     Clustered = true;
        // }
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Dropdown; "Driver Name","Code", "Staff Number", "Active")
        {
        }
    }
    
    trigger OnInsert()

    Var
        UserSetup: Record "User Setup";
        SeriesSetup: Record "Credit Nos. Series";
    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Driver No.");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Driver No.");
            // NoSeriesMgt.InitSeries(SeriesSetup."Driver No.", xRec."No. Series", 0D, "No.", "No. Series");

        end;
        "Created By" := userID;
        "Created at" := CurrentDateTime;
        "No Of Trips" := 0;

        "User ID" := UserId;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;
    end;
  

    var
        HREmp: Record "HR Employees";
        MembNoSeries: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
}

