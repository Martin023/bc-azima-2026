#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186430 tableextension52186430 extends "Dimension Value"
{
    fields
    {
        field(50001; "Percentage %"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Dimension.Get(Rec."Dimension Code") then begin
                    DimensionValue.Reset;
                    DimensionValue.SetRange("Dimension Code", Dimension.Code);
                    if DimensionValue.Find('-') then begin

                        DimensionValue.CalcSums("Percentage %");
                        if (DimensionValue."Percentage %") > 100 then
                            Error('Percentage cannot be graeter than 100');
                    end;
                end;
            end;
        }
        field(50002; "Phone No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        Dimension: Record Dimension;
        DimensionValue: Record "Dimension Value";
}
