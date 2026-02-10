table 52185677 "prSalary Card Casual"
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(2; "Basic Pay"; Decimal)
        {
            Editable = true;
            Enabled = true;

            trigger OnValidate()
            begin
                if Employee.Get("Employee Code") then begin
                    "Location/Division" := Employee."Location/Division Code";
                    Department := Employee."Department Code";
                    "Cost Centre" := Employee."Cost Center Code";
                    "Salary Grade" := Employee."Salary Grade";
                    "Salary Notch" := Employee."Salary Notch/Step";
                    "Employee Classification" := Employee."Employee Classification";
                    State := Employee."Post Code";
                end;
            end;
        }
        field(3; "Payment Mode"; Option)
        {
            Description = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,FOSA;
        }
        field(4; Currency; Code[10])
        {
        }
        field(5; "Pays NSSF"; Boolean)
        {
        }
        field(6; "Pays NHIF"; Boolean)
        {
        }
        field(7; "Pays PAYE"; Boolean)
        {
        }
        field(8; "Payslip Message"; Text[100])
        {
        }
        field(9; "Cumm BasicPay"; Decimal)
        {
            CalcFormula = Sum("PR Employee P9 Info"."Basic Pay" WHERE("Employee Code" = FIELD("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Cumm GrossPay"; Decimal)
        {
            CalcFormula = Sum("PR Employee P9 Info"."Gross Pay" WHERE("Employee Code" = FIELD("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Cumm NetPay"; Decimal)
        {
            CalcFormula = Sum("PR Employee P9 Info"."Net Pay" WHERE("Employee Code" = FIELD("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Cumm Allowances"; Decimal)
        {
            CalcFormula = Sum("PR Period Transactions".Amount WHERE("Group Order" = FILTER(3),
                                                                     "Employee Code" = FIELD("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Cumm Deductions"; Decimal)
        {
            CalcFormula = Sum("PR Period Transactions".Amount WHERE("Group Order" = FILTER(8),
                                                                     "Sub Group Order" = FILTER(0 | 1),
                                                                     "Employee Code" = FIELD("Employee Code"),
                                                                     "Transaction Code" = FILTER(<> 'Total Deductions')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Suspend Pay"; Boolean)
        {
        }
        field(15; "Suspension Date"; Date)
        {
        }
        field(16; "Suspension Reasons"; Text[200])
        {
        }
        field(17; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "PR Payroll Periods"."Date Opened";
        }
        field(18; Exists; Boolean)
        {
        }
        field(19; "Cumm PAYE"; Decimal)
        {
            CalcFormula = Sum("PR Period Transactions".Amount WHERE("Transaction Code" = FILTER('PAYE'),
                                                                     "Employee Code" = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(20; "Cumm NSSF"; Decimal)
        {
            CalcFormula = Sum("PR Period Transactions".Amount WHERE("Transaction Code" = FILTER('NSSF'),
                                                                     "Employee Code" = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(21; "Cumm Pension"; Decimal)
        {
            CalcFormula = Sum("PR Period Transactions".Amount WHERE("Transaction Code" = FILTER('0007'),
                                                                     "Employee Code" = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(22; "Cumm HELB"; Decimal)
        {
            CalcFormula = Sum("PR Period Transactions".Amount WHERE("Employee Code" = FIELD("Employee Code"),
                                                                     "Transaction Code" = FILTER('320')));
            FieldClass = FlowField;
        }
        field(23; "Cumm NHIF"; Decimal)
        {
            CalcFormula = Sum("PR Period Transactions".Amount WHERE("Employee Code" = FIELD("Employee Code"),
                                                                     "Transaction Code" = FILTER('NHIF')));
            FieldClass = FlowField;
        }
        field(24; "Bank Account Number"; Code[50])
        {
        }
        field(25; "Bank Branch"; Code[50])
        {
        }
        field(26; "Employee's Bank"; Code[50])
        {
        }
        field(27; "Posting Group"; Code[20])
        {
            NotBlank = false;
            TableRelation = "prEmployee Posting Group";
        }
        field(28; "Cumm Employer Pension"; Decimal)
        {
            CalcFormula = Sum("prEmployer Deductions".Amount WHERE("Employee Code" = FIELD("Employee Code"),
                                                                    "Transaction Code" = CONST('0007')));
            FieldClass = FlowField;
        }
        field(29; "Location/Division"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(30; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(31; "Cost Centre"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(32; "Salary Grade"; Code[20])
        {
            TableRelation = "prInstitutional Membership"."Group No";
        }
        field(33; "Salary Notch"; Code[20])
        {
        }
        field(34; "Pension House Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "prInstitutional Membership"."Institution No" WHERE("Group No" = CONST('PENSION'));
        }
        field(35; "Days Absent"; Decimal)
        {
        }
        field(323; "Payroll Type"; Option)
        {
            CalcFormula = Lookup(prTimeSheets.Test WHERE("Schedule Code" = FIELD("Employee Code")));
            FieldClass = FlowField;
            OptionCaption = 'General,Directors';
            OptionMembers = General,Directors;
        }
        field(324; "Hourly Rate"; Decimal)
        {
        }
        field(325; "Employee Classification"; Code[20])
        {
        }
        field(326; State; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(327; "Non Taxable"; Decimal)
        {
        }
        field(328; "Selected Period"; Date)
        {
        }
        field(329; "Hours Worked"; Decimal)
        {
        }
        field(330; "Overtime Hours"; Decimal)
        {
        }
        field(331; "Public Holidays&Weekend Hours"; Decimal)
        {
        }
        field(332; "Insurance Ceritifacte?"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code")
        {
            Clustered = true;
            SumIndexFields = "Basic Pay";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error('Delete not allowed');
    end;

    var
        Employee: Record "HR Employees";
}

