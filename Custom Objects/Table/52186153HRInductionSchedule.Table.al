table 52186153 "HR Induction Schedule"
{

    fields
    {
        field(1; "Induction Code"; Code[10])
        {

            trigger OnValidate()
            begin
                if "Induction Code" <> xRec."Induction Code" then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Induction Nos");
                    "No series" := '';
                end;
            end;
        }
        field(2; "Staff Code"; Code[20])
        {
            TableRelation = "HR Interns"."No.";
        }
        field(3; "Staff Names"; Text[100])
        {
            Editable = false;
        }
        field(4; "Staff Department"; Text[100])
        {
        }
        field(5; "Date of Join"; Date)
        {
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                "Global Dimension 1 Name" := '';
                DimValue.Reset;
                DimValue.SetRange(DimValue.Code, "Global Dimension 1 Code");
                if DimValue.Find('-') then begin
                    "Global Dimension 1 Name" := DimValue.Name;
                end;
            end;
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                "Global Dimension 2 Name" := '';
                DimValue.Reset;
                DimValue.SetRange(DimValue.Code, "Global Dimension 2 Code");
                if DimValue.Find('-') then begin
                    "Global Dimension 2 Name" := DimValue.Name;
                end;
            end;
        }
        field(8; "Induction Duration"; DateFormula)
        {

            trigger OnValidate()
            begin
                "Induction End Date" := 0D;
                "Induction End Date" := CalcDate("Induction Duration", "Induction Start Date");
            end;
        }
        field(9; "Induction Start Date"; Date)
        {

            trigger OnValidate()
            begin
                Validate("Induction Duration");
            end;
        }
        field(10; "Induction End Date"; Date)
        {
            Editable = false;
        }
        field(11; Comments; Text[100])
        {
        }
        field(12; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(13; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Payment Voucher,Petty Cash,Imprest,Requisition,ImprestSurrender,Interbank,Receipt,Staff Claim,Staff Advance,AdvanceSurrender,Budget Transfer,Employee Requisition,Leave Application,Transport Requisition,Training Requisition,Job Approval,Induction Approval';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Budget Transfer","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval";
        }
        field(14; "Global Dimension 1 Name"; Text[100])
        {
            Editable = false;
        }
        field(15; "Global Dimension 2 Name"; Text[100])
        {
            Editable = false;
        }
        field(40; "Created By"; Code[50])
        {
        }
        field(41; Selected; Boolean)
        {
        }
        field(42; "No series"; Code[10])
        {
        }
        field(44; "Date Created"; Date)
        {
            Editable = false;
        }
        field(46; "HOD Notified?"; Option)
        {
            Description = 'HOD Notified for Induction';
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;
        }
        field(47; "No. of Participants"; Integer)
        {
            CalcFormula = Count("HR Staff  Induction" WHERE("Participant Code" = FILTER(<> '')));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Induction Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Induction Code" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Induction Nos");
            "Induction Code" := NoSeriesMgt.GetNextNo(HRSetup."Induction Nos");
            // NoSeriesMgt.InitSeries(HRSetup."Induction Nos", xRec."No series", 0D, "Induction Code", xRec."No series");
        end;

        "Created By" := UserId;
        "Date Created" := Today;
    end;

    var
        Induction: Record "HR Induction Schedule";
        HRSetup: Record "HR Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        HREmp: Record "HR Employees";
        Txt001: Label 'The User ID %1 is not assigned to any employee';
        DimValue: Record "Dimension Value";
        HRCodeunit: Codeunit "HR Codeunit2";
}

