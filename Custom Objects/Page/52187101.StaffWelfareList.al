page 52187101 "Staff Welfare List"
{
    CardPageId ="Staff Welfare ";
    ApplicationArea = All;
    Caption = 'Staff Welfare List';
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Staff Welfare";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No;Rec.No)
                {

                }
              field("Payroll No";Rec."Payroll No")
              {
                
              }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(Beneficiary; Rec.Beneficiary)
                {
                    ToolTip = 'Specifies the value of the Beneficiary field.';
                }
                field(Relationship; Rec.Relationship)
                {
                    ToolTip = 'Specifies the value of the Relationship field.';
                }
                field("Claim Amount";Rec."Claim Amount")
                {

                }
            }
         
        }
          
    }
     
}
