#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186434 tableextension52186434 extends "Job Task"
{
    fields
    {
        field(50004; "Task Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Task End Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Reason For Delay"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Authorized By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(50008; "Originated By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(50009; "Offsite Job"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Maintenance Reason Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        // field(50011;"Amount Posted to FA";Decimal)
        // {
        //     CalcFormula = sum("FA Ledger Entry".Amount where (Field50001=field("Job No."),
        //                                                       Field50002=field("Job Task No.")));
        //     FieldClass = FlowField;
        // }
        field(50012; "WIP Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50013; "Offsite Location"; Text[30])
        {
            Caption = 'Office Location';
            DataClassification = ToBeClassified;
        }
        // field(50016; "Bill-to Customer No."; Code[20])
        // {
        //     Caption = 'Bill-to Customer No.';
        //     DataClassification = ToBeClassified;
        //     Editable = false;
        //     TableRelation = Customer;
        // }
        field(50017; "No. Of Resource"; Integer)
        {
            CalcFormula = count("Job Planning Line" where("Job No." = field("Job No."),
                                                           Type = const(Resource)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50018; "Total Labour Cost"; Decimal)
        {
            CalcFormula = sum("Job Planning Line"."Line Amount (LCY)" where("Job No." = field("Job No."),
                                                                             Type = const(Resource)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50019; "Actual Completion Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Planned Starting Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Rec.CheckDateConsistency;
            end;
        }
        field(50041; "Planned Ending Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Rec.CheckDateConsistency;
            end;
        }
        field(50042; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Rec.CheckDateConsistency;
            end;
        }
        field(50043; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Rec.CheckDateConsistency;
            end;
        }
        field(50044; "Job Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'To Limit the User View of Job Dbase';
            Editable = false;
            TableRelation = Location;
        }
    }

    procedure CheckDateConsistency()
    begin
        case CurrFieldNo of
            Rec.FieldNo(Rec."Planned Starting Date"):
                begin
                    if (Rec."Planned Starting Date" > Rec."Planned Ending Date") and (Rec."Planned Ending Date" <> 0D) then
                        Error(Text103, Rec.FieldCaption(Rec."Planned Starting Date"), Rec.FieldCaption(Rec."Planned Ending Date"));
                    if (Rec."Planned Starting Date" < Rec."Starting Date") and (Rec."Starting Date" <> 0D) then
                        Error(Text103, Rec.FieldCaption(Rec."Starting Date"), Rec.FieldCaption(Rec."Planned Starting Date"));
                    if (Rec."Planned Starting Date" > Rec."Ending Date") and (Rec."Ending Date" <> 0D) then
                        Error(Text103, Rec.FieldCaption(Rec."Planned Starting Date"), Rec.FieldCaption(Rec."Ending Date"));
                end;
            Rec.FieldNo(Rec."Starting Date"):
                begin
                    if (Rec."Starting Date" > Rec."Ending Date") and (Rec."Ending Date" <> 0D) then
                        Error(Text103, Rec.FieldCaption(Rec."Starting Date"), Rec.FieldCaption(Rec."Ending Date"));
                    if (Rec."Starting Date" < Rec."Ending Date") and (Rec."Ending Date" <> 0D) then
                        Error(Text103, Rec.FieldCaption(Rec."Ending Date"), Rec.FieldCaption(Rec."Starting Date"));
                    if (Rec."Starting Date" < Rec."Planned Starting Date") and (Rec."Planned Starting Date" <> 0D) and (Rec."Starting Date" <> 0D) then
                        Error(Text103, Rec.FieldCaption(Rec."Starting Date"), Rec.FieldCaption(Rec."Planned Starting Date"));
                end;
            Rec.FieldNo(Rec."Ending Date"):
                begin
                    Rec.TestField(Rec."Starting Date");
                    if (Rec."Ending Date" < Rec."Starting Date") and (Rec."Ending Date" <> 0D) then
                        Error(Text103, Rec.FieldCaption(Rec."Starting Date"), Rec.FieldCaption(Rec."Ending Date"));
                    if (Rec."Ending Date" < Rec."Planned Starting Date") and (Rec."Planned Starting Date" <> 0D) and (Rec."Ending Date" <> 0D) then
                        Error(Text103, Rec.FieldCaption(Rec."Ending Date"), Rec.FieldCaption(Rec."Planned Starting Date"));
                end;
            Rec.FieldNo(Rec."Planned Ending Date"):
                begin
                    Rec.TestField(Rec."Planned Starting Date");
                    if (Rec."Planned Ending Date" < Rec."Planned Starting Date") and (Rec."Planned Ending Date" <> 0D) then
                        Error(Text103, Rec.FieldCaption(Rec."Planned Starting Date"), Rec.FieldCaption(Rec."Planned Ending Date"));
                    if (Rec."Planned Ending Date" > Rec."Ending Date") and (Rec."Ending Date" <> 0D) then
                        Error(Text103, Rec.FieldCaption(Rec."Ending Date"), Rec.FieldCaption(Rec."Planned Ending Date"));
                    if (Rec."Planned Ending Date" < Rec."Starting Date") and (Rec."Starting Date" <> 0D) then
                        Error(Text103, Rec.FieldCaption(Rec."Starting Date"), Rec.FieldCaption(Rec."Planned Ending Date"));
                end;
        end;
    end;

    var
        Text000: label 'You cannot delete %1 because one or more entries are associated.';
        Text001: label 'You cannot change %1 because one or more entries are associated with this %2.';
        Text004: label 'The %1 cannot be modified because the job has associated job WIP entries.';
        Text103: label '%1 cannot be after %2';
}
