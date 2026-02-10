table 52185949 "Contract Expectation Details"
{

    fields
    {
        field(1; "Contract No"; Code[10])
        {
            TableRelation = Contracts."Contract No";
            trigger OnValidate()
            begin
                Contracts.RESET;
                Contracts.SETRANGE("Contract No", "Contract No");
                if Contracts.find('-') then begin
                    Rec."Contractor No" := Contracts."Contractor No";
                    Rec."Contractor Name" := Contracts."Contractor Name";
                end;
            end;

        }
        field(2; "Cycle Code"; Code[10])
        {
        }
        field(3; "Cycle Stage"; Integer)
        {
        }
        field(4; Description; Text[30])
        {
        }
        field(5; "Expectation Code"; Code[10])
        {
            TableRelation = "Segment/County/Dividend/Signat"."Code" where (Type = CONST("Contract Expectation"));
            trigger OnValidate()
            begin
                ContractExpectations.RESET;
                ContractExpectations.SETRANGE(ContractExpectations.Code, "Expectation Code");
                if ContractExpectations.find('-') then begin
                    Rec.Description := ContractExpectations.Description;
                end;
            end;
        }
        field(6; "Staff User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //if UserSetup.GET("User ID") then
                UserSetup.Reset();
                UserSetup.SETRANGE("User ID", "Staff User ID");
                if UserSetup.find('-') then 
                begin
                    Rec."Person Responsible" := UserSetup."Full Name";
                end;
            end;
        }
        field(7; "Person Responsible"; Text[30])
        {
        }
        field(8; "Due Date"; Date)
        {
        }
        field(9; Done; Boolean)
        {
        }
        field(10; "Date Done"; Date)
        {
        }
        field(11; "Done By"; Text[30])
        {
        }
        field(12; "%age Paid"; Decimal)
        {
        }
        field(13; Type; Option)
        {
            OptionCaption = ' ,Vendor,Customer';
            OptionMembers = " ",Vendor,Customer;
        }
        field(14; "Contractor No"; Code[10])
        {
        }
        field(15; "Contractor Name"; Text[30])
        {
        }
        field(16; "Invoice No"; Code[10])
        {
        }
        field(17; "User ID"; Code[20])
        {
        }
        field(18; "Global Dimension 1 Code"; Code[20])
        {
        }
        field(19; "Global Dimension 2 Code"; Code[20])
        {
        }
        field(20; "Captured By"; Code[20])
        {
        }
        field(21; "Date Captured"; DateTime)
        {
        }
        field(22; "Responsibility Center"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Contract No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
       trigger OnInsert()
    begin
        Rec."Date Captured" := CURRENTDATETIME;
        Rec."Captured By" := UserId;
        "User ID" := UserId;
        "Captured By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;
    
    end;

    var
    Contracts : Record "Contracts";
    ContractExpectations : Record "Segment/County/Dividend/Signat";
    UserSetup: Record "User Setup";
}

