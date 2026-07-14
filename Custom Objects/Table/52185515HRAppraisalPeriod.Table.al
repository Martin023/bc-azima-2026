table 52185515 "HR Appraisal Period"
{

    fields
    {
        field(1; "Appraisal Period"; Date)
        {
        }
        field(2; "Appraisal Period Description"; Text[100])
        {
        }
        field(3; "Appraisal Cycle Stage"; Option)
        {
            OptionCaption = 'Target Setting,Evaluation Review,Year-End Review';
            OptionMembers = "Target Setting","Evaluation Review","Year-End Review";
        }
        field(4; Closed; Boolean)
        {
            editable = false;
        }
        field(5; "Date Opened"; Date)
        {
        }
        field(6; "Date Closed"; Date)
        {
        }
        field(7; "Appraisal Year"; Integer)
        {
        }
        field(8; "Review Sequence No"; Integer)
        {
        }
        field(9; "Period Start Date"; Date)
        {
        }
        field(10; "Period End Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Appraisal Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    var
        IndivTargetHeader: Record "HR Individual Targets Header";
    begin
        // CASCADE CYCLE STAGE CHANGES TO INDIVIDUAL APPRAISALS
        if (xRec."Appraisal Cycle Stage" <> "Appraisal Cycle Stage") or 
           (xRec."Period Start Date" <> "Period Start Date") or 
           (xRec."Period End Date" <> "Period End Date") then begin
            
            IndivTargetHeader.Reset;
            IndivTargetHeader.SetRange("Appraisal Year", "Appraisal Year");
            IndivTargetHeader.SetRange("Review Sequence No", "Review Sequence No");
            IndivTargetHeader.SetFilter(Status, '<>%1', IndivTargetHeader.Status::Posted);
            if IndivTargetHeader.FindSet(true) then begin
                repeat
                    IndivTargetHeader."Appraisal Cycle Stage" := "Appraisal Cycle Stage";
                    IndivTargetHeader."Period Start Date" := "Period Start Date";
                    IndivTargetHeader."Period End Date" := "Period End Date";
                    IndivTargetHeader."Appraisal Period" := "Appraisal Period Description";
                    IndivTargetHeader.Modify;
                until IndivTargetHeader.Next = 0;
            end;
        end;
    end;
}

