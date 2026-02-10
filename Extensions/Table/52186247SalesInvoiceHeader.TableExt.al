TableExtension 52186247 tableextension52186247 extends "Sales Invoice Header"
{
    fields
    {
        field(10001; "Invoice Start Date"; Date)
        {

            DataClassification = ToBeClassified;
        }
        field(10002; "Invoice End Date"; Date)
        {

            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10003; "Period Type"; Option)
        {
            OptionCaption = ' ,Days,Weeks,Months,Quaters,Years';
            OptionMembers = " ",Days,Weeks,Months,Quaters,Years;
        }
        field(10004; Tenor; DateFormula)
        {

            trigger OnValidate()
            begin
                "Invoice End Date" := CalcDate(Tenor, "Invoice Start Date") - 1;
                CompInfo.Get;
                if NonWorkingDay = true then
                    Message('Invoice date is falling on a non working day');
            end;
        }
        field(10005; "Frequency Period"; Integer)
        {

            trigger OnValidate()
            var
                Datefom: DateFormula;
            begin

                if "Period Type" = "Period Type"::Days then
                    Evaluate(Datefom, Format("Frequency Period") + 'D');
                if "Period Type" = "Period Type"::Weeks then
                    Evaluate(Datefom, Format("Frequency Period") + 'W');
                if "Period Type" = "Period Type"::Months then
                    Evaluate(Datefom, Format("Frequency Period") + 'M');
                if "Period Type" = "Period Type"::Quaters then
                    Evaluate(Datefom, Format("Frequency Period") + 'Q');
                if "Period Type" = "Period Type"::Years then
                    Evaluate(Datefom, Format("Frequency Period") + 'Y');

                Tenor := Datefom;
                Validate(Tenor);
            end;
        }
        field(10006; Waived; Boolean)
        {

        }
        field(10007; Invoiced; Boolean)
        {

        }
    }

    var
        NonWorkingDay: Boolean;
        CompInfo: Record "Company Information";
}