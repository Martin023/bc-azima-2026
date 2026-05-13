table 52185467 "User Access Request Lines"
{
    Caption = 'User Access Request Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Request ID"; Code[20])
        {
            Caption = 'Request ID';
            TableRelation = "User Creation Requests"."Request ID";
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }

        field(3; "System Type"; Code[20])
        {
            Caption = 'System Type';
            TableRelation = "IT System Setup"."System Code" where(Active = const(true));

            trigger OnValidate()
            var
                ITSystemSetup: Record "IT System Setup";
            begin
                case ITSystemSetup.Get("System Type") of
                    true:
                        begin
                            "Requires ICT Approval" := ITSystemSetup."Requires ICT Approval";
                            "Requires Admin Approval" := ITSystemSetup."Requires Admin Approval";
                        end;
                    false:
                        begin
                            "Requires ICT Approval" := false;
                            "Requires Admin Approval" := false;
                        end;
                end;
            end;
        }

        field(4; "System Name"; Text[100])
        {
            Caption = 'System Name';
        }

        field(5; Environment; Option)
        {
            Caption = 'Environment';
            OptionMembers = Live,UAT,Test,DR;
            OptionCaption = 'Live,UAT,Test,DR';
        }

        field(6; "Access Type"; Option)
        {
            Caption = 'Access Type';
            OptionMembers = Create,Modify,Remove;
            OptionCaption = 'Create,Modify,Remove';
        }

        field(7; Role; Code[100])
        {
            Caption = 'Role';
        }

        field(8; "Permission Set"; Code[20])
        {
            Caption = 'Permission Set';
            TableRelation = "Permission Set"."Role ID";
        }

        field(9; "Department Role"; Text[100])
        {
            Caption = 'Department Role';
        }

        field(10; "Business Justification"; Text[250])
        {
            Caption = 'Business Justification';
        }

        field(11; "Risk Level"; Option)
        {
            Caption = 'Risk Level';
            OptionMembers = Low,Medium,High;
            OptionCaption = 'Low,Medium,High';
        }

        field(12; "SoD Conflict"; Boolean)
        {
            Caption = 'SoD Conflict';
            Editable = false;
        }

        field(13; "Requires ICT Approval"; Boolean)
        {
            Caption = 'Requires ICT Approval';
        }

        field(14; "Requires Admin Approval"; Boolean)
        {
            Caption = 'Requires Admin Approval';
        }

        field(15; Provisioned; Boolean)
        {
            Caption = 'Provisioned';
        }

        field(16; "Provisioned By"; Code[50])
        {
            Caption = 'Provisioned By';
            Editable = false;
        }

        field(17; "Provisioning Date"; DateTime)
        {
            Caption = 'Provisioning Date';
            Editable = false;
        }

        field(18; Remarks; Text[250])
        {
            Caption = 'Remarks';
        }
    }

    keys
    {
        key(PK; "Request ID", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        case "Line No." = 0 of
            true:
                "Line No." := GetNextLineNo();
        end;
    end;

    local procedure GetNextLineNo(): Integer
    var
        UserAccessLines: Record "User Access Request Lines";
    begin
        UserAccessLines.SetRange("Request ID", "Request ID");

        case UserAccessLines.FindLast() of
            true:
                exit(UserAccessLines."Line No." + 10000);
            false:
                exit(10000);
        end;
    end;
}