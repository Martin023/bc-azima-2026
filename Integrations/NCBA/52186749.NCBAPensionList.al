page 52186749 "NCBA Pension List"
{
    ApplicationArea = basic, suite;
    Caption = 'NCBA Pension List';
    PageType = List;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    CardPageId = "NCBA Pension Card";
    SourceTable = "NCBA Pension Buffer";
    UsageCategory = Lists;
    SourceTableView = sorting("postingDate") Order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Pension Number"; Rec."pensionNumber")
                {
                    ToolTip = 'Specifies the value of the Pension Number field.', Comment = '%';
                }
                field(Company; Rec.Company)
                {
                    ToolTip = 'Specifies the value of the Company field.', Comment = '%';
                }
                field("Reference Number"; Rec."referenceNumber")
                {
                    ToolTip = 'Specifies the value of the Reference Number field.', Comment = '%';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
                field("Needs change"; Rec."Needs change")
                {
                    ToolTip = 'Specifies the value of the Needs change field.', Comment = '%';
                }
                field("Account No"; Rec."accountNo")
                {
                    ToolTip = 'Specifies the value of the Account No field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Date posted"; Rec."postingDate")
                {
                    ToolTip = 'Specifies the value of the Date posted field.', Comment = '%';
                }
                field("Date Entered"; Rec."dateEntered")
                {
                    ToolTip = 'Specifies the value of the Date Entered field.', Comment = '%';
                }
                field(ModifiedAt; Rec.ModifiedAt)
                {
                    ToolTip = 'specifies the value of theModifiedAt', Comment = '%';
                }
                field(ModifiedBy; Rec.ModifiedBy)
                {
                    ToolTip = 'spcifies the value of ModifiedBy', Comment = '%';
                }
            }
        }
    }
}
