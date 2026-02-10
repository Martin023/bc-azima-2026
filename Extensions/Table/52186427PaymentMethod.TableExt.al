#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186427 tableextension52186427 extends "Payment Method"
{
    fields
    {
        field(8001; "Payment Processor"; Option)
        {
            Caption = 'Payment Processor';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Dynamics Online';
            OptionMembers = " ","Dynamics Online";

            trigger OnValidate()
            begin
                if Rec."Payment Processor" = Rec."payment processor"::"Dynamics Online" then
                    Rec.TestField(Rec."Bal. Account Type", Rec."bal. account type"::"Bank Account");
            end;
        }
    }
}
