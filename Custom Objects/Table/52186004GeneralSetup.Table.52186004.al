table 52186004 "General Setup"
{
    DrillDownPageID = "General Setup";
    LookupPageID = "General Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(4; "Property Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(5; "Lease Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(6; "Landlord Dues G/L"; Code[20])
        {
            TableRelation = "G/L Account"."No.";

            trigger OnLookup()
            begin
                //Prevent Changing once entries exist
                // TestNoEntriesExist(FieldCaption("Landlord Dues G/L"));
            end;

            trigger OnValidate()
            begin
                /*
              GL.RESET;
              GL.GET("Commission GL");
              GL.TESTFIELD(GL."Income/Balance",GL."Income/Balance"::"Income Statement");
              GL.TESTFIELD(GL."Direct Posting",TRUE);
              GL.TESTFIELD(GL.Blocked,FALSE);

               */

            end;
        }
        field(7; "Commission Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template".Name WHERE(Type = CONST(General));

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                // TestNoEntriesExist(FieldCaption("Commission Template"));
            end;
        }
        field(8; "Commission Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Commission Template"),
                                                             "Template Type" = CONST(General));

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                // TestNoEntriesExist(FieldCaption("Commission Batch"));
            end;
        }
        field(9; "Charge Code"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(10; "Water billing No."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(11; "Management Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                // TestNoEntriesExist(FieldCaption("Management Account"));
            end;
        }
        field(12; "B/Hole W/B Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(13; NairobiInv; Integer)
        {
        }
        field(14; BHoleInv; Integer)
        {
        }
        field(15; "Prepayment Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(16; "Bill Batch No."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(17; "Landlord Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(18; "Tenant Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(19; "Min. Member Age"; Date)
        {
        }
        field(20; "Max. Age Non-Common Bond"; Date)
        {
        }
        field(21; "VAT Rate %"; Decimal)
        {
        }
        field(22; "Deadline Notification"; DateFormula)
        {
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        GL: Record "G/L Account";
        Text000: Label 'You cannot change %1 because there are one or more ledger entries associated with this account.';

    [Scope('OnPrem')]
    procedure TestNoEntriesExist(CurrentFieldName: Text[100])
    var
        GLLedgEntry: Record "G/L Entry";
    begin
        //To prevent change of field
        GLLedgEntry.SetCurrentKey(GLLedgEntry."G/L Account No.");
        GLLedgEntry.SetRange("G/L Account No.", "Management Account");
        if GLLedgEntry.Find('-') then
            Error(
              Text000,
              CurrentFieldName);
    end;
}

