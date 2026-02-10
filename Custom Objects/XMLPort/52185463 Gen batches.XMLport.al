#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185463 Genbatches
{
    Format = VariableText;

    schema
    {
        textelement(NME)
        {
            tableelement("Gen. Journal Batch";"Gen. Journal Batch")
            {
                MinOccurs = Zero;
                XmlName = 'batch';
                fieldelement(a; "Gen. Journal Batch"."Journal Template Name")
                {
                }
                fieldelement(b;"Gen. Journal Batch".Name)
                {
                }
                fieldelement(c;"Gen. Journal Batch".Description)
                {
                    FieldValidate = No;
                } 
                fieldelement(d;"Gen. Journal Batch"."Bal. Account Type")
                {
                    FieldValidate = No;
                } 
            }
            
        }
    }
    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Processing completed successfully');
    end;
    
    
}
