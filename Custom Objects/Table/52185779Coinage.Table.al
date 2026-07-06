table 52185779 Coinage
{
    DrillDownPageID = Coinage;
    LookupPageID = Coinage;

    fields
    {
        field(1; No; Code[20])
        {
            TableRelation = "Treasury Cashier Transactions".No;
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Denominations;
            trigger OnValidate()
            var 
            Denominations: Record Denominations;
            begin
                if Denominations.Get(Rec.Code) then begin
                    Rec.Description := Denominations.Description;
                    Rec.Type := Denominations.Type;
                    Rec.Value := Denominations.Value;
                end;
            end;
           
            
        }
        field(3; Description; Text[50])
        {
        }
        field(4; Type; Option)
        {
            OptionMembers = Note,Coin;
        }
        field(5; Value; Decimal)
        {
        }
        field(6; Quantity; Integer)
        {

            trigger OnValidate()
            begin

                if Quantity <> 0 then
                    "Total Amount" := Quantity * Rec.Value
                else
                    "Total Amount" := 0;
                UpdateHeaderDifference();
            end;
        }
        field(7; "Total Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; No, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    local procedure UpdateHeaderDifference()
    var
        Header: Record "Treasury Cashier Transactions";
        CoinageRec: Record Coinage;
        TotalCoinage: Decimal;
    begin
        if No = '' then
            exit;

        if not Header.Get(No) then
            exit;

        CoinageRec.SetRange(No, No);
        CoinageRec.SetFilter("Code", '<>%1', Code); // exclude this row - it's not saved yet
        CoinageRec.CalcSums("Total Amount");

        TotalCoinage := CoinageRec."Total Amount" + "Total Amount"; // add current in-memory value

        Header."Coinage Difference" := Header.Amount - TotalCoinage;
        Header.Modify();
    end;

    trigger OnInsert()
    begin
        UpdateHeaderDifference();
    end;

    trigger OnDelete()
    begin
        UpdateHeaderDifference();
    end;
}

