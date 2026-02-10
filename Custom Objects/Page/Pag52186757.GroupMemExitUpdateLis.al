namespace KenpipeBC.KenpipeBC;

page 52186757 "Group Mem Exit & Update List"
{
    ApplicationArea = All;
    Caption = 'Group Mem Exit & Update Lis';
    PageType = List;
    SourceTable = "Group Member Exit & Update";
    UsageCategory = Lists;
    CardPageID = "Group Mem Exit & Update Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Group No."; Rec."Group No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Group No. field.', Comment = '%';
                }
                field("Group Name"; Rec."Group Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Group Name field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field("Created At"; Rec."Created At")

                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
