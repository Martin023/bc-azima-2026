namespace MNSProjectMwanga.MNSProjectMwanga;

page 52186490 "loans Daily Interest"
{
    ApplicationArea = All;
    Caption = 'loans Daily Interest';
    PageType = List;
    SourceTable = "Loans Daily Interest";
    //UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Date Posted"; Rec."Date Posted")
                {
                    ToolTip = 'Specifies the value of the Date Posted field.', Comment = '%';
                }
                field("Entered By"; Rec."Entered By")
                {
                    ToolTip = 'Specifies the value of the Entered By field.', Comment = '%';
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    ToolTip = 'Specifies the value of the Interest Amount field.', Comment = '%';
                }
                field("Interest Date"; Rec."Interest Date")
                {
                    ToolTip = 'Specifies the value of the Interest Date field.', Comment = '%';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of the Loan No. field.', Comment = '%';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
            }
        }
    }

    var

        ProductName: Text;
        ProducFac: Record Loans;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        ProductName := '';
        if ProducFac.Get(Rec."Loan No.") then begin
            ProductName := ProducFac."Loan Product Type Name";
        end;
    end;
}
