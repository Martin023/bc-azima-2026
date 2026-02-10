tableextension 52186258 vendoraccount extends "vendor bank account"
{
    fields
    {
        modify("Bank Account No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
             
                rec.reset();
                rec.SetRange("Bank Account No.", rec."Bank Account No.");
                if rec.findfirst() then
                    Error('No Already Exists');

            end;
          
        }
    }
}
