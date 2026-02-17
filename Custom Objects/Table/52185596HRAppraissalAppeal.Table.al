table 52185596 "HR Appraissal Appeal"
{

    fields
    {
        field(1; "No."; Code[30])
        {
        }
        field(2; "Employee No."; Code[30])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnLookup()
            begin
                HREmployees.Reset;
                SetRange("Employee No.", HREmployees."No.");
                if HREmployees.FindFirst then begin
                    "Employee Name" := HREmployees."First Name";
                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            editable=false;
        }
        field(4; "Appraisser No."; Code[30])
        {
            editable=false;
        }
        field(5; "Appraiser Name"; Text[100])
        {
            editable=false;
        }
        field(6; "Appraissal Period"; Code[30])
        {
            editable=false;
        }
        field(7; Reason; Text[250])
        {
        }
        field(8; Region; Code[30])
        {
            editable=false;
        }
        field(9; Department; Code[30])
        {
            editable=false;
        }
        field(10; "Responsibility Center"; Code[30])
        {
            editable=false;
        }
        field(11; Status; Option)
        {
            OptionMembers = New,"Pending Approval",Approved;
            editable=false;
        }
        field(12; "No Series"; Code[30])
        {
        }
        field(13; "User ID"; Code[30])
        {
        }
        field(14;"Comments";Text[250])
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
    var
    hrappraisalheader:record "HR Appraisal Header";
    begin
        //No. Series
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Appraisal Appeal Nos");
            "No." := NoSeriesMgt.GetNextNo(HRSetup."Appraisal Appeal Nos");
            // NoSeriesMgt.InitSeries(HRSetup."Appraisal Appeal Nos", xRec."No Series", 0D, "No.", "No Series");
        end;

        HREmployees.Reset;
        HREmployees.SetRange(HREmployees."User ID", UserId);
        if HREmployees.Find('-') then begin
            "Employee Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
            "Employee No." := HREmployees."No.";
            "User ID" := HREmployees."User ID";
            Region := HREmployees."Global Dimension 1 Code";
            Department := HREmployees."Global Dimension 2 Code";
            "Responsibility Center" := HREmployees."Responsibility Center";
        end;
        hrappraisalheader.reset();
        hrappraisalheader.setrange("Employee No",rec."Employee No.");
        if hrappraisalheader.findset()then begin
          "Appraiser Name":=hrappraisalheader."Supervisor Name";
          "Appraisser No.":=hrappraisalheader."Supervisor Employee No";
          "Appraissal Period":=hrappraisalheader."Appraisal Period";
        end;
        
    end;

    var
        HREmployees: Record "HR Employees";
        HRSetup: Record "HR Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
}

