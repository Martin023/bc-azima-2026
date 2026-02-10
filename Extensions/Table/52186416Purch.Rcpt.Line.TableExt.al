#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186416 tableextension52186416 extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50001; "Quatity on Order"; Decimal)
        {
            CalcFormula = lookup("Purchase Line".Quantity where("Document No." = field("Order No."),
                                                                 "No." = field("No.")));
            FieldClass = FlowField;
        }
    }
}
