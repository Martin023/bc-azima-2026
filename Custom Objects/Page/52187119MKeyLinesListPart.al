page 52187119 "MKey Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "MKey Lines";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Member No. "; Rec."Member No. ")
                {
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                }
                field("Old Employer Code"; Rec."Old Employer Code")
                {
                    Editable = false;
                }
                field("Old Employer Name"; Rec."Old Employer Name")
                {
                    Editable = false;
                }
                field("Old Payroll Number"; Rec."Old Payroll Number")
                {
                    Editable = false;
                }
                field("New Employer Code"; Rec."New Employer Code")
                {

                }
                field("New Employer Name"; Rec."New Employer Name")
                {
                    Editable = false;
                }

                field("New Payroll Number"; Rec."New Payroll Number")
                {

                }
            }
        }
    }


}
