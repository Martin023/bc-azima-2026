table 52185809 "Investment Lines"
{

    fields
    {
        field(1; "Investment No"; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(3; Institution; Code[10])
        {
            TableRelation = Vendor WHERE("Vendor Type" = CONST(Institution));
        }
        field(4; "Institution Description"; Text[100])
        {
        }
        field(5; "Investment Amount"; Decimal)
        {

            trigger OnValidate()
            begin

                if Invheader.Get("Investment No") then begin

                    if "Investment Amount" > Invheader."Available Amount" then
                        Message('The investment amount is more than the Available Amount %1,do you want to exceed.', Invheader."Available Amount");

                    // "Face Value" := "Invested Amount";
                    "Investment Amount (LCY)" := "Investment Amount";
                    "Total Amount (LCY)" := "Investment Amount (LCY)";
                    "Premium/Discount" := "Investment Amount" - "Face Value";


                end;
            end;
        }
        field(6; "Sector Compliance"; Boolean)
        {
        }
        field(7; "Share in Issue Compliance"; Boolean)
        {
        }
        field(8; "Aggregate Compliance"; Boolean)
        {
        }
        field(9; "Entity Compliance"; Boolean)
        {
        }
        field(10; "Complinace Checked"; Boolean)
        {
        }
        field(11; "Investment Amount (LCY)"; Decimal)
        {
        }
        field(12; "Face Value"; Decimal)
        {
            // trigger OnValidate()
            // var
            //     NoOfDays: Integer;
            //     InvInterest: Record "Investment Interest Header";

            //     IntEarned: Decimal;
            // begin
            //     if "Face Value" > 0 then begin

            //         NoOfDays := Abs(Invheader."Investment Date" - InvInterest."End Date");
            //         Invheader.Reset();
            //         Invheader.SetRange("Investment No", rec."Investment No");
            //         if Invheader.FindFirst() then begin
            //             IntEarned := ((Rec."Face Value") * (Invheader."Interest Rate" / 100) * (NoOfDays)) / 365;
            //             rec."Interest Amount" := IntEarned;
            //             Rec."Wht Tax Amount" := (TarrifCodes.Percentage / 100) * "Interest Amount";
            //             Rec."Net Interest Amount" := "Interest Amount" - "Wht Tax Amount";
            //         end;
            //     end;
            // end;

            trigger OnValidate()
            var
                NoOfDays: Integer;
                IntEarned: Decimal;

            begin
                Invheader.get(Rec."Investment No");
                if Invheader."Deposit Type" <> Invheader."Deposit Type"::Shares then begin
                    if Invheader.Get("Investment No") then begin
                        // if Invheader."Interest Mode" = Invheader."Interest Mode"::Arrears then begin
                        if Invheader."Period Type" = Invheader."Period Type"::Days then
                            Rec."Interest Amount" := (Invheader."Interest Rate" / 100) * "Face Value" * (Invheader."Frequency Period" / 365);
                        if Invheader."Period Type" = Invheader."Period Type"::Weeks then
                            Rec."Interest Amount" := (Invheader."Interest Rate" / 100) * "Face Value" * (Invheader."Frequency Period" / 52);
                        if Invheader."Period Type" = Invheader."Period Type"::Months then
                            Rec."Interest Amount" := (Invheader."Interest Rate" / 100) * "Face Value" * (Invheader."Frequency Period" / 12);
                        if Invheader."Period Type" = Invheader."Period Type"::Quaters then
                            Rec."Interest Amount" := (Invheader."Interest Rate" / 100) * "Face Value" * (Invheader."Frequency Period" / 4);
                        Rec."Investment Amount" := "Face Value";
                        NoOfDays := Abs(Invheader."Investment Date" - Invheader."Maturity Date") + 1;
                        IntEarned := ((Rec."Face Value") * (Invheader."Interest Rate" / 100) * (NoOfDays)) / 365;
                        rec."Interest Amount" := IntEarned;
                        TarrifCodes.Reset;
                        TarrifCodes.SetRange(Code, Invheader."Withholding Tax Code");
                        if TarrifCodes.Find('-') then begin
                            "Wht Tax Amount" := (TarrifCodes.Percentage / 100) * "Interest Amount";
                        end;
                        "Net Interest Amount" := "Interest Amount" - "Wht Tax Amount";
                    end;

                end else
                    if Invheader."Deposit Type" = Invheader."Deposit Type"::Shares then begin
                        rec."Interest Amount" := 0;
                        Rec."Investment Amount" := Rec."Face Value";
                    end;
                Validate("Investment Amount")
            end;
        }
        field(13; "Premium/Discount"; Decimal)
        {
            Editable = false;
        }
        field(14; "Interest Amount"; Decimal)
        {
            Editable = false;

        }
        field(15; "Net Interest Amount"; Decimal)
        {
            Editable = false;
        }
        field(16; "Wht Tax Amount"; Decimal)
        {
        }
        field(17; "Effective Exchange Rate"; Decimal)
        {
        }
        field(18; "Total Amount (LCY)"; Decimal)
        {
        }
        field(19; "Invested Amount"; Decimal)
        {
            FieldClass = Normal;
        }
        field(20; "Investment Amount (FCY)"; Decimal)
        {
        }
        field(21; "Fund Compliance"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Investment No", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        InstitutionRec: Record Vendor;
        // NoseriesMgt: Codeunit NoSeriesManagement;
        NoseriesMgt: Codeunit "No. Series";
        Invheader: Record "Investment Header";
        TarrifCodes: Record "Tariff Code s";
        NoofDays: Integer;
}

