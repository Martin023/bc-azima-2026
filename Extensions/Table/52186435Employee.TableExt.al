#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186435 tableextension52186435 extends Employee
{
    fields
    {
        field(1102; Grade; Code[30])
        {
        }
    }
    trigger OnInsert()
    begin
        Error('Depreciated Table for employees.');
    end;
}
