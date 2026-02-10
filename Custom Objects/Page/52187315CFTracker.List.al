page 52187315 "CF Tracker List"
{
    Editable = false;
    PageType = List;
    SourceTable = "CF Tracker";

    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("At Department"; Rec."At Department")
                {
                    Editable = false;
                }
                field("Current Department"; Rec."Current Department")
                {
                    Editable = false;

                }
                field("Previous Departmant"; Rec."Previous Departmant")
                {
                    Editable = false;

                }
                field("Checked By"; Rec."Checked By")
                {
                    Caption = 'Checked By-At Previous';
                    Editable = false;
                }
                field("Forwarded By"; Rec."Forwarded By")
                {
                    Editable = false;

                }
                field("Time Forwarded"; Rec."Time Forwarded")
                {
                    Editable = false;

                }
                field("Viewed By Recepient"; Rec."Viewed By Recepient")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

    end;

    trigger OnAfterGetRecord()
    begin
    end;



}

