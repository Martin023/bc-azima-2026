table 52185611 "HR Interns"
{
    DataCaptionFields = "No.", "Full Name", Sex, "Posting Status";
    // DrillDownPageID = "HR Interns List";
    // LookupPageID = "HR Interns List";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Full Name"; Text[50])
        {

            trigger OnValidate()
            begin
                "Full Name" := UpperCase("Full Name");
            end;
        }
        field(3; Sex; Option)
        {
            OptionMembers = " ",Male,Female;
        }
        field(4; Institution; Text[100])
        {
            Caption = 'Institution (College / University)';
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST(Institution));
        }
        field(5; "Course Undertaken"; Text[50])
        {
        }
        field(6; Specialization; Text[50])
        {
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(9; "Period Start"; Text[30])
        {
            Editable = false;
        }
        field(10; "Period End"; Text[30])
        {
            Editable = false;
        }
        field(11; "Monthly Stipend"; Decimal)
        {
        }
        field(12; Ethnicity; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST(Tribe));
        }
        field(13; "Posting Status"; Option)
        {
            OptionMembers = Open,"Pending Approval",Approved,Closed;
        }
        field(14; "Posted Quarter"; Option)
        {
            OptionMembers = " ","Quarter 1","Quarter 2","Quarter 3","Quarter 4";

            trigger OnValidate()
            begin
                case "Posted Quarter" of
                    //Default:
                    "Posted Quarter"::" ":
                        begin
                            Clear("Period Start");
                            Clear("Period End");
                        end;

                    //Quarter 1
                    "Posted Quarter"::"Quarter 1":
                        begin
                            "Period Start" := 'July';
                            "Period End" := 'August';
                        end;

                    //Quarter 2
                    "Posted Quarter"::"Quarter 2":
                        begin
                            "Period Start" := 'September';
                            "Period End" := 'November';
                        end;

                    //Quarter 3
                    "Posted Quarter"::"Quarter 3":
                        begin
                            "Period Start" := 'January';
                            "Period End" := 'March';
                        end;

                    //Quarter 4
                    "Posted Quarter"::"Quarter 4":
                        begin
                            "Period Start" := 'April';
                            "Period End" := 'June';
                        end;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Full Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Full Name")
        {
        }
    }
}

