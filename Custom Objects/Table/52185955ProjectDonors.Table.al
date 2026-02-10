table 52185955 "Project Donors"
{

    fields
    {
        field(1; "Shortcut Dimension 1 Code"; Code[20])
        {
            NotBlank = true;

            // trigger OnValidate()
            // begin
            //     // DimVal.Reset;
            //     // DimVal.SetRange(DimVal."Global Dimension No.", 1);
            //     // //DimVal.SETRANGE(DimVal.Code,"Shortcut Dimension 1 Code");
            //     // if DimVal.Find('-') then
            //     //     //"Donor Name":=DimVal.Name;
            // end;
        }
        field(2; "Donor Name"; Text[100])
        {
        }
        field(3; "Expected Donation"; Decimal)
        {
        }
        field(4; "Grant No"; Code[50])
        {
            NotBlank = true;
        }
        field(5; "Reporting Date"; Date)
        {
            Enabled = false;
        }
        field(6; "Donated Amount"; Decimal)
        {
            CalcFormula = Sum("Receipt Line"."Total Amount" WHERE("Grant No" = FIELD("Grant No"),
                                                                   Posted = CONST(true),
                                                                   "Shortcut Dimension 2 Code" = FIELD("Grant No")));
            FieldClass = FlowField;
        }
        field(7; Balance; Decimal)
        {
        }
        field(8; "Indirect Cost"; Boolean)
        {
        }
        field(9; Percentage; Decimal)
        {

            trigger OnValidate()
            begin
                //IF "Indirect Cost"=TRUE THEN BEGIN
                //"Allowed Indirect Cost":=Percentage/100*"Expected Donation";
                //END;
            end;
        }
        field(10; "Allowed Indirect Cost"; Decimal)
        {
        }
        field(11; "Charge Type"; Option)
        {
            OptionCaption = ' ,Accrual,Cash';
            OptionMembers = " ",Accrual,Cash;
        }
        field(12; "Contact Person"; Text[50])
        {
        }
        field(13; Address; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Shortcut Dimension 1 Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DimVal: Record "Dimension Value";
        objJobs: Record Jobs;
}

