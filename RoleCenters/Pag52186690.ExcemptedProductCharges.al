namespace MNSProjectMwanga.MNSProjectMwanga;

page 52186690 "Excempted Product Charges"
{
    ApplicationArea = All;
    Caption = 'Excempted Product Charges';
    PageType = List;
    SourceTable = "Excempted Product Charges";
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Charge Code"; Rec."Charge Code") { editable = false; }
                field("Charge Description"; Rec."Charge Description") { editable = false; }
                field("Charge Method"; Rec."Charge Method") { editable = false; }
                field("Charge Amount"; Rec."Charge Amount") { editable = false; }
                field(Excempt; Rec.Excempt) { }
                field("Excempt By"; Rec."Excempt By") { editable = false; }
                field("Excempt Date"; Rec."Excempt Date") { editable = false; }
                field("Excempt Date Time"; Rec."Excempt Date Time") { editable = false; }


            }
        }
    }
}
