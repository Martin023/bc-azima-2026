table 52185679 "HR Appraisal Learning & Growth"
{
    //               HRAppraisalGoalSettingH.GET("Appraisal No");
    //                 "Employee No":=HRAppraisalGoalSettingH."Employee No";
    //                 HRAppraisalGoalSettingH.TESTFIELD(HRAppraisalGoalSettingH."Appraisal Period");
    //                 "Appraisal Period":=HRAppraisalGoalSettingH."Appraisal Period"


    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Appraisal No"; Code[30])
        {
        }
        field(3; "Appraisal Period"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER("Appraisal Period"),
                                                           Closed = CONST(false));
        }
        field(4; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Employees"."No.";
        }
        field(5; Sections; Option)
        {
            OptionCaption = 'Objectives,Core Responsibilities/Duties,Last year''s goals,Things learnt From Training,Value Added From Training,Attendance&Punctuality,Communication,Cooperation,Internal/External Clients,Initiative,Planning & Organization,Quality,Team Work,Sales Skills,Leadership,Performance Coaching';
            OptionMembers = Objectives,"Core Responsibilities/Duties","Last year's goals","Things learnt From Training","Value Added From Training","Attendance&Punctuality",Communication,Cooperation,"Internal/External Clients",Initiative,"Planning & Organization",Quality,"Team Work","Sales Skills",Leadership,"Performance Coaching";
        }
        field(6; "Perfomance Goals and Targets"; Text[250])
        {
        }
        field(7; "Self Rating"; Decimal)
        {
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                // if "Self Rating" > maxRating then Error('[%1 %2] should have a Maximum Score of [%3]', FieldCaption("Self Rating"), "Self Rating", maxRating);
            end;
        }
        field(8; "Peer Rating"; Decimal)
        {

            trigger OnValidate()
            begin
                // if "Peer Rating" > maxRating then Error('The score %1 should have a max Score of %2', "Peer Rating", maxRating);
            end;
        }
        field(9; "Base Line"; Decimal)
        {

            trigger OnValidate()
            begin
                // if "Supervisor Rating" > maxRating then Error('The score %1 should have a max Score of %2', "Supervisor Rating", maxRating);
            end;
        }
        field(10; Target; Decimal)
        {

            trigger OnValidate()
            begin
                // IF "Sub-ordinates Rating">maxRating THEN  ERROR('The score %1 should have a max Score of %2',"Sub-ordinates Rating",maxRating);
            end;
        }
        field(11; "Outside Agencies Rating"; Decimal)
        {
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                // if "Outside Agencies Rating" > maxRating then Error('The score %1 should have a max Score of %2', "Outside Agencies Rating", maxRating);
            end;
        }
        field(17; Change; Decimal)
        {
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                // if "Agreed Rating" > maxRating then Error('The score %1 should have a max Score of %2', "Agreed Rating", maxRating);
            end;
        }
        field(18; Q1; Decimal)
        {
        }
        field(19; "Additional Comment"; Text[250])
        {
        }
        field(21; Objective; Text[250])
        {
        }
        field(22; "Supervisor Comments"; Text[250])
        {
        }
        field(23; Strategy; Text[200])
        {
        }
        field(25; "Approval Status"; Option)
        {
            OptionMembers = "Pending Approval",Approved;
        }
        field(26; "Categorize As"; Option)
        {
            OptionCaption = ' ,Employee''s Subordinates,Employee''s Peers,External Sources,Job Specific,Self Evaluation,Personal Goals/Objectives';
            OptionMembers = " ","Employee's Subordinates","Employee's Peers","External Sources","Job Specific","Self Evaluation","Personal Goals/Objectives";
        }
        field(27; "Sub Category"; Option)
        {
            OptionCaption = ' ,Objectives,Core Responsibilities / Duties,Attendance & Punctuality,Communication,Cooperation,Planning & Organization,Quality,Team Work,Sales Skills,Leadership,Performance Coaching,Personal Goals';
            OptionMembers = " ",Objectives,"Core Responsibilities / Duties","Attendance & Punctuality",Communication,Cooperation,"Planning & Organization",Quality,"Team Work","Sales Skills",Leadership,"Performance Coaching","Personal Goals";
        }
        field(28; Q2; Decimal)
        {
        }
        field(29; "External Source Comments"; Text[250])
        {
        }
        field(30; Q3; Decimal)
        {

            trigger OnValidate()
            begin
                //IF "Min. Target Score" >maxRating THEN  ERROR('The score %1 should have a max Score of %2',"Min. Target Score",maxRating);
            end;
        }
        field(31; Q4; Decimal)
        {

            trigger OnValidate()
            begin
                //IF "Max Target Score" >maxRating THEN  ERROR('The score %1 should have a max Score of %2',"Max Target Score",maxRating);
            end;
        }
        field(32; Perspective; Code[20])
        {
        }
        field(33; Measures; Code[20])
        {
        }
        field(34; "Supervisor Rating"; Decimal)
        {
        }
        field(35; "Agreed Rating"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Appraisal No", "Appraisal Period", "Employee No")
        {
            Clustered = true;
        }
        key(Key2; Sections)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "HR Employees";
        HRAppraisalGoalSettingH: Record "HR Appraisal Header";
        AppraisalScores: Record "HR Appraisal Lines";
        mycurrStatus: Boolean;
        objHRSetup: Record "HR Setup";
        Vendor: Record Vendor;
        Customer: Record Customer;

    [Scope('OnPrem')]
    procedure maxRating() maxRating: Decimal
    begin
        maxRating := 0;
        objHRSetup.Reset;
        objHRSetup.SetRange(objHRSetup."Primary Key");
        if objHRSetup.Find('-') then
            maxRating := objHRSetup."Max Appraisal Rating";
    end;
}

