#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186421 tableextension52186421 extends "Bank Account"
{
    fields
    {
        field(39005975; "Bank Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Normal,Cash,Fixed Deposit,SMPA,Chq Collection,Cashier,Treasury,Control,Mobile Money, ';
            OptionMembers = Normal,Cash,"Fixed Deposit",SMPA,"Chq Collection",Cashier,Treasury,Control,"Mobile Money"," ";
            InitValue = " ";

            trigger OnValidate()
            begin
                //Rec.TestNoEntriesExist(Rec.FieldCaption(Rec."Bank Type"));
            end;
        }
        field(39005976; "Pending Voucher Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39005977; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility CenterBR";

            trigger OnValidate()
            begin
                // if not UserMgt.CheckRespCenter(1,Rec."Responsibility Center") then
                //   Error(
                //     Text005,
                //     RespCenter.TableCaption,UserMgt.GetPurchasesFilter);
            end;
        }
        field(39005978; "Bank Branch Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(39005979; "Bank No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Code Structure".Code;
        }
        field(39005980; "Previous Statement No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(39005981; "Reconciliation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Auto,Manual;
        }
        field(39005982; "Cashier ID"; Code[80])
        {
            CalcFormula = lookup("Banking User Template".UserID where("Default  Bank" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39005983; "Max. Witholding Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39005984; "Replenishment Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    procedure TestNoEntriesExist(CurrentFieldName: Text[100])
    var
        ItemLedgEntry: Record "Bank Account Ledger Entry";
    begin

        //To prevent change of field
        ItemLedgEntry.SetCurrentkey(ItemLedgEntry."Bank Account No.");
        ItemLedgEntry.SetRange("Bank Account No.", Rec."No.");
        if ItemLedgEntry.Find('-') then
            Error(
              Text006,
              CurrentFieldName);
    end;

    var
        Text006: label 'You cannot change %1 because there are one or more ledger entries for this bank account.';
        UserMgt: Codeunit "User Setup Management BR";
        Text005: label 'Your identification is set up to process from %1 %2 only.';
        RespCenter: Record "Responsibility CenterBR";
}
