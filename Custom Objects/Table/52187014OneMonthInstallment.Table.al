table 52187014 "One Month Installment"
{
    LookupPageId = "One Month Installments";
    DrillDownPageId = "One Month Installments";

    fields
    {
        field(1; "Record No."; Code[20])
        {
            Editable = false;
        }

        field(2; "Member No."; Code[50])
        {
            Editable = false;
        }

        field(3; "Principal Amount"; Decimal)
        {
            Editable = false;
        }

        field(4; "Interest Amount"; Decimal)
        {
            Editable = false;
        }

        field(5; Total; Decimal)
        {
            Editable = false;
        }

        field(6; "Funds Status"; Option)
        {
            OptionMembers = " ",WithHeld,Released;
            Editable = false;

        }

        field(7; "Entry Date"; DateTime)
        {
            Editable = false;
        }

        field(8; "Created By"; Code[50])
        {
            Editable = false;
        }

        field(9; "Released By"; Code[50])
        {
            Editable = false;
        }

        field(10; "Time Released"; DateTime)
        {
            Editable = false;
        }

        field(11; Status; enum "Workflow Status Main Flags")
        {
            //Editable = false;
            trigger OnValidate()
            begin
                // if Rec.Status = Rec.Status::Approved then begin
                //     Rec."Funds Status" := Rec."Funds Status"::Released;
                //     Rec."Released By" := USERID;
                //     Rec."Time Released" := CURRENTDATETIME;
                //     Rec.Modify;
                // end;
            end;
        }

        field(12; "Type"; Enum "Funds Witheld Types")
        {

        }
        field(13; "Account No."; Code[30])
        {
            TableRelation = "Savings Accounts";
        }
        field(14; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Responsibility CenterBR"."Global Dimension 1 Code";

        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Responsibility CenterBR"."Global Dimension 2 Code";
        }
        field(18; "Released To"; Option)
        {
            OptionMembers = " ","Savings","Loan";
        }
        field(1112; "Held Funds Comments"; text[30])
        {

        }


    }



    keys
    {
        key(Key1; "Record No.", "Member No.")
        {
            Clustered = true;
        }
        key(Key2; "Member No.", "Account No.", "Funds Status")
        {
            SumIndexFields = Total;
        }
    }

    trigger OnInsert()
    var
        UserSetUp: Record "User Setup";
    begin
        UserSetUp.Reset();
        UserSetUp.SetRange("User ID", UserId);
        if UserSetUp.FindFirst() then begin
            "Global Dimension 1 Code" := UserSetUp."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetUp."Global Dimension 2 Code";
            "Entry Date" := CurrentDateTime;
            "Created By" := UserId;
        end;
    end;
}

