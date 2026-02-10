codeunit 52186421 "Credit and Savings Navigation"
{
    TableNo = "G/L Register";
    trigger OnRun()
    begin

    end;

    procedure GetSavingsLedgEntry(var GlRegister: Record "G/L Register")

    begin
        CustLedgEntry.SetRange("Entry No.", GlRegister."From Entry No.", GlRegister."To Entry No.");
        PAGE.Run(PAGE::"Savings Ledger Entries", CustLedgEntry);
    end;

    procedure GetCreditLedgEntry(var GlRegister: Record "G/L Register")

    begin
        CreditLedgEntry.SetRange("Entry No.", GlRegister."From Entry No.", GlRegister."To Entry No.");
        PAGE.Run(PAGE::"Credit Ledger Entries", CreditLedgEntry);
    end;

    var
        CustLedgEntry: Record "Savings Ledger Entry";
        CreditLedgEntry: Record "Credit Ledger Entry";
}

