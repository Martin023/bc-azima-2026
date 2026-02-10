#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186422 tableextension52186422 extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50001; "Statement Difference"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50150; "MPESA Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53021; "Document Ref. No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(53022; "Source Account Staff No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39004241; "Bank Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Normal,Cash,"Fixed Deposit",SMPA,"Chq Collection",Cashier,Treasury;
        }
        field(39004242; "Value Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
}
