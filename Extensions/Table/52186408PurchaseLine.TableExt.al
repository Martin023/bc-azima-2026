#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186408 tableextension52186408 extends "Purchase Line"
{
    fields
    {

        //Unsupported feature: Deletion (FieldCollection) on ""Order No."(Field 65)".

        field(50000; Committed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Expense Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = if (Type = const("G/L Account")) "Expense Code";

            trigger OnValidate()
            begin
                //TestStatusOpen;
                Rec.TestField(Rec.Type, Rec.Type::"G/L Account");
                //Orders lines from Grants cannot be modified
                Rec.TestField(Rec."Grant No", '');
                //Cannot modify Committed Entries
                Rec.TestField(Rec.Committed, false);
            end;
        }
        // field(50006;"Order No.";Code[20])
        // {
        //     DataClassification = ToBeClassified;
        // }
        field(50007; Status; Enum "Approval Status")
        {
            CalcFormula = lookup("Purchase Header".Status where("No." = field("Document No.")));
            Caption = 'Status';
            Editable = true;
            FieldClass = FlowField;
            // OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            // OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(39005600; "Grant No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005601; "Job Contract Entry No."; Integer)
        {
            Caption = 'Job Contract Entry No.';
            DataClassification = ToBeClassified;
            Editable = false;

            // trigger OnValidate()
            // var
            //     JobPlanningLine: Record "Staff Advanc Surrender Details";
            // begin
            //     /*JobPlanningLine.SETCURRENTKEY("Job Contract Entry No.");
            //     JobPlanningLine.SETRANGE("Job Contract Entry No.","Job Contract Entry No.");
            //     JobPlanningLine.FINDFIRST;
            //     CreateDim(
            //       DimMgt.TypeToTableID3(Type),"No.",
            //       DATABASE::Table167,JobPlanningLine."Job No.",
            //         DATABASE::"Responsibility Center","Responsibility Center");
            //     */

            // end;
        }
        field(39005602; "Grant Task Line No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005605; "Requisition No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                //"Manual Requisition No":="Requisition No";
            end;
        }
        field(39005606; "RFQ Remarks"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(39005607; "Requisition Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(39005608; "Qty Ordered"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39005609; "Qty UnOrdered"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39005613; "Contract No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contracts."Contract No" where("Contractor No" = field("Buy-from Vendor No."));
        }
        field(39005614;VATAmount;decimal)
        {
            
        }
        
    }
   
   

   
}
