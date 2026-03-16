table 52186405 "Stock Keeping"
{
    Caption = 'Stock Keeping';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[40])
        {
            Caption = 'No';
            Editable = false;

        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(3; "User Id"; code[100])
        {
            Caption = 'User Id';
            Editable=false;
            
        }
        field(4; "TotalItems"; Integer)
        {
            Caption = 'Total Items';
            CalcFormula = Count("Stock Keeping Lines" WHERE("Header No" = FIELD("No")));
            FieldClass = FlowField;
            Editable = false; 

        }
        field(5; "No. Series"; Code[20])
        {
        }
        field(6; Status; enum "Workflow Status Main Flags")
        {
            Editable = false;

        }
        field(7; Types; option)
        {
            OptionMembers = Stock,Disposal;

        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "No" = '' then begin
            if Types = Types::Stock then begin
                InventorySetup.Get;
                InventorySetup.TestField(InventorySetup."Stock Keeping Nos.");
                "No" := NoSeriesMgt.GetNextNo(InventorySetup."Stock Keeping Nos.");
                // NoSeriesMgt.InitSeries(InventorySetup."Stock Keeping Nos.", xRec."No. Series", 0D, "No", "No. Series");
            end else if Types = Types::Disposal then begin
                InventorySetup.Get;
                InventorySetup.TestField(InventorySetup."Disposal Nos.");
                "No" := NoSeriesMgt.GetNextNo(InventorySetup."Disposal Nos.");
                // NoSeriesMgt.InitSeries(InventorySetup."Disposal Nos.", xRec."No. Series", 0D, "No", "No. Series");

            end;
        end;

        "Date" := Today;
        "User ID" := 'Created by ' + UserId + ' on ' + Format(CreateDateTime(Today, Time));
    end;

    var
        InventorySetup: record "Inventory Setup";
        NoSeriesMgt: Codeunit "No. Series";
}
