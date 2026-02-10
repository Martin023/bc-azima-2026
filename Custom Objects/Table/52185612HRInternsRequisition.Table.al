table 52185612 "HR Interns Requisition"
{
    // DrillDownPageID = "HR Intern Requisition List";
    // LookupPageID = "HR Intern Requisition List";

    fields
    {
        field(1; "Requisition No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Requisition Date"; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin
                if (Rec."Requisition Date" - Today) < 0 then
                    Message('Days in the past are not allowed');
            end;
        }
        field(3; Priority; Option)
        {
            OptionCaption = ' ,High,Medium,Low';
            OptionMembers = " ",High,Medium,Low;
        }
        field(4; "Requisition For"; Option)
        {
            OptionMembers = " ",Interns,Attachees;
        }
        field(5; "Reason For Request"; Text[100])
        {
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(8; "Available Interns"; Integer)
        {
            CalcFormula = Count("HR Interns" WHERE("Posting Status" = FILTER(Approved)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Due Date"; Date)
        {
        }
        field(10; Status; Option)
        {
            OptionMembers = Open,"Pending Approval",Rejected,Approved;
        }
        field(11; "No. of Interns Required"; Decimal)
        {

            trigger OnValidate()
            begin
                if "No. of Interns Required" > "Available Interns" then begin
                    Error('Interns Required cannot exceed Available Interns');
                end;

                if "No. of Interns Required" <= 0 then begin
                    Error('Interns Required cannot be Less Than or Equal to Zero');
                end;
            end;
        }
        field(12; "User ID"; Code[20])
        {
            Editable = false;
        }
        field(13; "No. Series"; Code[10])
        {
        }
        field(14; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center B".Code;
        }
        field(15; Quarter; Option)
        {
            OptionMembers = " ","Quarter 1","Quarter 2","Quarter 3","Quarter 4";

            trigger OnValidate()
            begin
                /*
                CASE Quarter OF
                  //Default:
                  Quarter::" ":
                  BEGIN
                    CLEAR("Period Start");
                    CLEAR("Period End");
                  END;
                
                  //Quarter 1
                  Quarter::"Quarter 1":
                  BEGIN
                    "Period Start":='July';
                    "Period End":='August';
                  END;
                
                  //Quarter 2
                  Quarter::"Quarter 2":
                  BEGIN
                    "Period Start":='September';
                    "Period End":='November';
                  END;
                
                  //Quarter 3
                  Quarter::"Quarter 3":
                  BEGIN
                    "Period Start":='January';
                    "Period End":='March';
                  END;
                
                  //Quarter 4
                  Quarter::"Quarter 4":
                  BEGIN
                    "Period Start":='April';
                    "Period End":='June';
                  END;
                END;
                */

            end;
        }
    }

    keys
    {
        key(Key1; "Requisition No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Requisition No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Interns Req. Nos");
            NoSeriesMgt.InitSeries(HRSetup."Interns Req. Nos", xRec."No. Series", 0D, "Requisition No.", "No. Series");
        end;

        "Requisition Date" := Today;
        "User ID" := UserId;

        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            "Global Dimension 1 Code" := HREmp."Global Dimension 1 Code";
            "Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
            "Responsibility Center" := HREmp."Responsibility Center";
        end;
    end;

    var
        HREmp: Record "HR Employees";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

