page 52187108 "Next Of Kin List"
{
    ApplicationArea = All;
    Caption = 'Next Of Kin List';
    PageType = List;
    SourceTable = "Next of KIN";
    UsageCategory = Lists;

    layout
    {

        area(content)
        {
            repeater(General)
            {
                field("Record ID"; Rec."Record ID")
                {
                    Caption = 'Member No';
                    ToolTip = 'Specifies the value of the Record ID field.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Mobile No. field.';
                }
                field("Identification Type"; Rec."Identification Type")
                {
                    ToolTip = 'Specifies the value of the Identification Type field.';
                }
                field(Identification; Rec.Identification)
                {
                    ToolTip = 'Specifies the value of the Identification field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Relationship; Rec.Relationship)
                {
                    ToolTip = 'Specifies the value of the Relationship field.';
                }

                field(Telephone; Rec.Telephone)
                {
                    ToolTip = 'Specifies the value of the Mobile No. field.';
                }

                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field(Allocation; Rec.Allocation)
                {
                    ToolTip = 'Specifies the value of the Allocation field.';
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ToolTip = 'Specifies the value of the Date Captured field.';
                }
                field("Date Modified"; Rec."Date Modified")
                {
                    ToolTip = 'Specifies the value of the Date Modified field.';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ToolTip = 'Specifies the value of the Date of Birth field.';
                }
                field(Deceased; Rec.Deceased)
                {
                    ToolTip = 'Specifies the value of the Deceased field.';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.';
                }

                field("Is Contact Person"; Rec."Is Contact Person")
                {
                    ToolTip = 'Specifies the value of the Is Contact Person field.';
                }
                field("Is Next of Kin"; Rec."Is Next of Kin")
                {
                    ToolTip = 'Specifies the value of the Is Next of Kin field.';
                }
                field("Is Nominee"; Rec."Is Nominee")
                {
                    ToolTip = 'Specifies the value of the Is Nominee field.';
                }
                field("Is a Beneficiary"; Rec."Is a Beneficiary")
                {
                    ToolTip = 'Specifies the value of the Is a Beneficiary field.';
                }
            }
        }
    }
}
