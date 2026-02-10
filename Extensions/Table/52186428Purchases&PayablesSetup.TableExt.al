#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186428 tableextension52186428 extends "Purchases & Payables Setup"
{
    fields
    {
        field(50001; "Requisition No"; Code[10])
        {
            Caption = 'Requisition No';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50002; "Quotation Request No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50003; "Stores Requisition No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50004; "Max. Purchase Requisition"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Tender Request No"; Code[10])
        {
            Caption = 'Tender Request No';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50006; "Stores Issue No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50007; "Requisition Default Vendor"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                Vendor.Reset;
                if Vendor.Get(xRec."Requisition Default Vendor") then begin
                    Vendor."Requisition Default Vendor" := false;
                    Vendor.Modify;
                end;

                Vendor.Reset;
                if Vendor.Get(Rec."Requisition Default Vendor") then begin
                    Vendor."Requisition Default Vendor" := true;
                    Vendor.Modify;
                end;
            end;
        }
        field(50008; "Use Procurement Limits"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Start Order from Requisition"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Item Reorder Notific Email"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Allow Invoice on PO"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Contract No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

    }
}
