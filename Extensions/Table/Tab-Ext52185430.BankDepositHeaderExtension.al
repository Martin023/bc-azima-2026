namespace MNS.MNS;

using Microsoft.Bank.Deposit;

tableextension 52185430 "Bank Deposit Header Extension" extends "Bank Deposit Header"
{
    fields
    {
        field(1009; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}
