table 52186205 "HR Training Feedback Form"
{
    // DrillDownPageID = "Asset Transfer List Effected";
    // LookupPageID = "Asset Transfer List Effected";

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Editable = true;

            trigger OnValidate()
            begin
                HRSetup.Get;
                NoSeriesMgt.TestManual(HRSetup."Back To Office Nos");
                "No. Series" := '';
            end;
        }
        field(2; "Course Title"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Training App Header"."Application No" WHERE(Status = FILTER(Approved));

            trigger OnValidate()
            begin
                HRTrainApp.reset();
                HRTrainApp.SetRange("Application No", rec."Course Title");
                if HRTrainApp.FindSet() then begin
                    HRTrainingNeeds.reset();
                    HRTrainingNeeds.SetRange(code, HRTrainApp."Course Title");
                    if HRTrainingNeeds.FindSet() then begin

                        // 

                        Description := HRTrainingNeeds.Description;
                        "From Date" := HRTrainingNeeds."Start Date";
                        "To Date" := HRTrainingNeeds."End Date";
                        //Duration:=HRTrainApp."Actual Duration";
                        "Cost Of Training" := HRTrainingNeeds."Total Costs";
                        Location := HRTrainingNeeds.Location;
                        Provider := HRTrainingNeeds.Provider;
                        "Provider Name" := HRTrainingNeeds."Provider Name";
                        "Program Name":=HRTrainingNeeds.Description;
                        //if HRTrainApp.Get("Course Title") then 
                            "Training Status" := HRTrainApp."Training Status";
                        //"Employee No.":=HRTrainApp."Employee No.";
                        //"Employee Name":=HRTrainApp."Employee Names";
                           Department := HRTrainApp."Global Dimension 1 Code";


                    end;
                end;
            end;
        }
        field(3; "From Date"; Date)
        {
            Editable = true;
            TableRelation = "HR Training App Header"."Start Date";
        }
        field(4; "To Date"; Date)
        {
            Editable = true;
            TableRelation = "HR Training App Header"."End Date";
        }
        field(5; "Duration Units"; Option)
        {
            Editable = true;
            OptionMembers = Hours,Days,Weeks,Months,Years;
        }
        field(6; Duration; Decimal)
        {
            Editable = true;

            trigger OnValidate()
            begin

                begin
                    if (Duration <> 0) and ("From Date" <> 0D) then
                        //"To Date" :=HRTrainApp.DetermineLeaveReturnDate("From Date",Duration);
                        Modify;
                end;
            end;
        }
        field(7; "Cost Of Training"; Decimal)
        {
            // DecimalPlaces = 0 : 0;
            Editable = true;
        }
        field(8; Location; Text[30])
        {
            Editable = true;
            TableRelation = "HR Training App Header"."Training Venue";
        }
        field(12; Description; Text[250])
        {
            Editable = true;
        }
        field(28; "Training Evaluation Results"; Option)
        {
            OptionMembers = "Not Evaluated",Passed,Failed;

            trigger OnValidate()
            begin
                if "Training Status" <> "Training Status"::"Completed Successfully" then
                    Error(mcontent4);
            end;
        }
        field(30; Provider; Code[10])
        {
            Editable = true;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                Vend.Reset;
                Vend.SetRange(Vend."No.", Provider);
                if Vend.Find('-') then begin
                    "Provider Name" := Vend.Name;
                end;
            end;
        }
        field(31; "Purpose of Training"; Text[100])
        {
        }
        field(32; Status; Option)
        {
            Editable = true;
            OptionCaption = 'New,Pending Approval,Approved,Rejected.';
            OptionMembers = New,"Pending Approval",Approved,"Rejected.";
        }
        field(33; "Employee No."; Code[10])
        {
            NotBlank = false;
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                if "Training category" <> "Training category"::Group then begin
                    HREmp.Get("Employee No.");
                    Directorate := HREmp."Department Name";
                    "Employee Name" := HREmp."Full Name";
                end;
            end;
        }
        field(36; "No. Series"; Code[10])
        {
        }
        field(40; "User ID"; Code[50])
        {
        }
        field(41; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center B".Code;
        }
        field(42; Directorate; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, Directorate);
                if Dimn.Find('-') then begin
                    "Directorate Name" := Dimn.Name;
                end;
            end;
        }
        field(43; "Employee Name"; Text[50])
        {
        }
        field(44; "Provider Name"; Text[50])
        {
        }
        field(45; "Training category"; Option)
        {
            OptionCaption = 'Individual,Group';
            OptionMembers = Individual,Group;
        }
        field(46; "Table ID"; Integer)
        {
        }
        field(47; Supervisor; Code[50])
        {
        }
        field(48; "Supervisor Name"; Text[100])
        {
        }
        field(50000; Department; Code[30])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, Department);
                if Dimn.Find('-') then begin
                    "Department Name" := Dimn.Name;
                end;

                /*
                HREmp.RESET;
                HREmp.SETRANGE(HREmp."No.","Employee No.");
                HREmp.SETRANGE(HREmp."Department Code",Directorate);
                HREmp.SETRANGE(HREmp.County,Department);
                IF HREmp.FIND() THEN BEGIN
                IF TranPart.GET("Document No")THEN BEGIN
                 TranPart.INIT;
                 TranPart."Employee Code":=HREmp."No.";
                 TranPart."Employee name":=HREmp."First Name"+'-'+HREmp."Middle Name"+'-'+HREmp."Last Name";
                 TranPart.INSERT;
                END;
                END;
                */

            end;
        }
        field(50002; Station; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, Station);
                if Dimn.Find('-') then begin
                    "Station Name" := Dimn.Name;
                end;
            end;
        }
        field(50003; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50005; "Training Status"; Option)
        {
            OptionCaption = ' ,Suspended,Deferred,Cancelled,Completed Successfully';
            OptionMembers = " ",Suspended,Deferred,Cancelled,"Completed Successfully";

            trigger OnValidate()
            begin
                if Status <> Status::Approved then
                    Error(mcontent5);
            end;
        }
        field(50006; "Text 1"; Text[200])
        {
        }
        field(50007; "Text 2"; Text[200])
        {
        }
        field(50008; "Text 3"; Text[200])
        {
        }
        field(50009; "Text 4"; Text[200])
        {
        }
        field(50010; "Text 5"; Text[200])
        {
        }
        field(50011; "Text 6"; Text[200])
        {
        }
        field(50012; "Text 9"; Text[200])
        {
        }
        field(50013; "Text 10"; Text[200])
        {
        }
        field(50014; "Department Name"; Text[50])
        {
        }
        field(50015; "Station Name"; Text[50])
        {
        }
        field(50016; "Directorate Name"; Text[50])
        {
        }
        field(50017; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50018; "Training Application No"; Code[20])
        {
            Editable = true;

            trigger OnValidate()
            begin
                if "Employee No." <> xRec."Employee No." then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Training Application Nos.");
                    "No. Series" := '';
                end;
            end;
        }
         field(50019; "Program Name";Text[50])
        {
           
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*IF Status <> Status::New THEN
        ERROR(mcontent);
        */

    end;

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Back To Office Nos");
            NoSeriesMgt.InitSeries(HRSetup."Back To Office Nos", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        "User ID" := UserId;


        "Table ID" := DATABASE::"HR Employees";
        "User ID" := UserId;

        if "Training category" <> "Training category"::Group then begin
            //TESTFIELD("Employee No.");
            HREmp.Reset;
            //HREmp.SETRANGE(HREmp."User ID",USERID);
            /*
            IF HREmp.FIND('-') THEN BEGIN
            "Employee No.":=HREmp."No.";
            HREmp.GET(HREmp."No.");
            "Employee Name":=HREmp."Full Name";

            "User ID":=USERID;
            END ELSE BEGIN
            ERROR('User Must be Setup as an employee first. Consult the HR Officer so as to be setup as an employee')
            END;
            */

        end;

        UserSetup.Reset;
        if UserSetup.Get(UserId) then begin
            Supervisor := UserSetup."Approver ID";
            UserSetup.Reset;
            if UserSetup.Get(Supervisor) then
                "Supervisor Name" := UserSetup."E-Mail";
        end;

    end;

    trigger OnModify()
    begin
        HREmp.reset();
        HREmp.SetRange("No.", rec."Employee No.");
        if HREmp.Find() then begin
            Qualification.reset();
            Qualification.SetRange("Employee No.", rec."Employee No.");
            if Qualification.find() then begin
                Description := rec."Text 5";
                Qualification.Modify();
            end;
        end;
        //CALCFIELDS("Occupied Positions");
        //IF "Occupied Positions">0 THEN
        //ERROR('Cannot modify job if it has occupants');
        //IF Status <> Status::New THEN
        //ERROR(mcontent2);
    end;


    var
        HRTrainingNeeds: Record "HR Training Needs";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        mcontent: Label 'Status must be new on Training Application No.';
        mcontent2: Label 'You cannot modify approved request, Please cancel the approval request and try again';
        HREmp: Record "HR Employees";
        Qualification: Record "HR Employee Qualifications";
        Vend: Record Vendor;
        UserSetup: Record "User Setup";
        mcontent3: Label 'Training category must be ''Group'' to allow for training application';
        HRTrainApp: Record "HR Training App Header";
        mcontent4: Label 'You cannot evaluate a training which is not successfully completed.';
        mcontent5: Label 'You cannot change training status if the status is not approved';
        Dimn: Record "Dimension Value";
}

