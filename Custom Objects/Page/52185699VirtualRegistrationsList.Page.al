page 52185699 "Virtual Registrations List"
{
    CardPageID = "Virtual Registrations Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Virtual Registrations";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'General';
                field("ID/Passport"; Rec."ID/Passport")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Msisdn; Rec.Msisdn)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Full Names"; Rec."Full Names")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mpesa Names"; Rec."Mpesa Names")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("IPRS Date Of Birth"; Rec."IPRS Date Of Birth")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(IsVirtual; Rec.IsVirtual)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec.IsVirtual = true then
            Error('Processed Record Can not Be Deleted!');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Rec.IsVirtual = true then
            Error('This Record Can not Be Modified!');
    end;

    var
    // ByteOne: DotNet Array;
    // ByteTwo: DotNet Array;
    // ByteThree: DotNet Array;
    // Convert: DotNet Convert;
    // MemoryStreamOne: DotNet MemoryStream;
    // MemoryStreamTwo: DotNet MemoryStream;
    // MemoryStreamThree: DotNet MemoryStream;
}

