#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186404 tableextension52186404 extends Vendor
{
    fields
    {
        field(50000; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(50145; "Vendor Credit Limit(LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50146; "Requisition Default Vendor"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50147; "Vendor Retention Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." where(Retention = const(true));
        }
        field(50148; Retention; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50149; "Vendor Type"; Enum "Vendor Type")
        {
            DataClassification = ToBeClassified;

        }
        field(50150; Trainers; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50151; "KRA Pin No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Vend: Record Vendor;
                Characters: Text[100];
                MemberApplication: Record "Member Application";
            begin
                if Rec."KRA Pin No." = '' then exit;
                Vend.Reset;
                Vend.SetFilter("No.", '<>%1', Rec."No.");
                Vend.SetRange("KRA Pin No.", Rec."KRA Pin No.");
                if Vend.FindSet then Error('PIN No. already used by vendor %1', Vend.Name);

                if StrLen(rec."KRA Pin No.") <> 11 then Error('P.I.N Number length must be 11 characters');

                Characters := '1234567890!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
                if not MemberApplication.ValidateShouldNotHaves(CopyStr(rec."KRA Pin No.", 11, 1), Characters) then Error('Last character must be a letter');
                Characters := '1234567890';
                if MemberApplication.ValidateShouldNotHaves(CopyStr("KRA Pin No.", 2, 8), Characters) then Error('Pin number must be alphanumeric');
            end;
        }
        field(50152; "P.O.Box Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50153; "Physical Address."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(500153; "Escalation Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(500154; "Escalation Frequency"; DateFormula)
        {
        }
        field(500156; "Created By"; Code[100])
        {
        }
        field(500157; "Created At"; DateTime)
        {
            
        }
        field(500158;Comments;Text[200])
        {
            
        }
        field(500159;"Vendor Categories";Code[250])
        {
            TableRelation="Vendor Categories";
        }
        field(500160;Archived;Boolean)
        {
            
        }
        
    }

    trigger OnInsert()
    begin
        "Created At" := CurrentDateTime;
        "Created By" := UserId;
    end;
}
