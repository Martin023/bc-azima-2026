table 52186276 "Group Members Edit"
{
    Caption = 'Group Members Edit';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Group No."; Code[50])
        {
            Caption = 'Group No.';
            TableRelation = Members."No.";
            // where("Account Type" = const("Group Account"));
        }
        field(3; "Member No"; Code[50])
        {
            Caption = 'Member No';
            TableRelation = Members."No." where("Account Type" = Const("Single Member Account"));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                HeaderTable.Reset;
                HeaderTable.SetRange("No.", Rec."Header No.");
                if HeaderTable.Find('-') then begin
                    if HeaderTable.Type = HeaderTable.Type::"Group Edit" then begin
                        Members.Reset();
                        Members.SetRange("No.", Rec."Member No");
                        if Members.FindFirst() then begin
                            Rec."Header No." := HeaderTable."No.";
                            Rec."Group No." := HeaderTable."Group No.";
                            Rec."Member Name" := Members.Name;
                            Rec."ID No." := Members."Primary Identification";
                            Rec."KRA PIN" := Members."P.I.N Number";
                            Rec."Phone No." := Members."Phone No.";
                        end;
                    end;
                end;
            end;
        }
        field(4; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
        }
        field(5; "ID No."; Code[50])
        {
            Caption = 'ID No.';
        }
        field(6; "KRA PIN"; Code[50])
        {
            Caption = 'KRA PIN';
        }
        field(7; "Phone No."; Code[50])
        {
            Caption = 'Phone No.';
        }
        field(8; Designation; Option)
        {
            Caption = 'Designation';
            OptionCaption = 'Member,Chair Person,Secretary,Treasurer,Vice Chair Persion';
            OptionMembers = Member,"Chair Person",Secretary,Treasurer,"Vice Chair Persion";
        }
        field(9; Signatory; Boolean)
        {
            Caption = 'Signatory';
        }
        field(10; "Must Be Present"; Boolean)
        {
            Caption = 'Must Be Present';
        }
        field(11; "Header No."; Code[50])
        {
            Caption = 'Header No.';
        }
        field(12; "Exited"; Boolean)
        {
            Caption = 'Exited';
        }
        field(13; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Member,Non-Member';
            OptionMembers = Member,"Non-Member";
        }
        field(14; Transferred; Boolean)
        {
        }
    }
    keys
    {
        key(pk; "Entry No.", "ID No.", "Member No")
        {
            Clustered = true;
        }
    }
    var
        HeaderTable: Record "Group Member Exit & Update";
        Members: Record Members;
}
