table 52185841 "Loan Securities Set-up"
{
    DrillDownPageID = "Loan Securities Set-Up";
    LookupPageID = "Loan Securities Set-Up";

    fields
    {
        field(1; "Setup Code"; Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                /*IF LoanApplications.GET(Code) THEN
                Category:=LoanApplications."Loan Product Type";    */

            end;
        }
        field(2; Type; Option)
        {
            NotBlank = true;
            OptionCaption = ' ,Real Estate,Plant and Equipment,Natural Reserves,Marketable Securities,Inventory,Motor Vehicle';
            OptionMembers = " ","Real Estate","Plant and Equipment","Natural Reserves","Marketable Securities",Inventory,"Motor Vehicle";
        }
        field(3; "Security Description"; Text[50])
        {
        }
        field(5; Category; Option)
        {
            OptionCaption = ' ,Cash,Government Securities,Corporate Bonds,Equity,Mortgage Securities,Lien,Motor Vehicle,Others';
            OptionMembers = " ",Cash,"Government Securities","Corporate Bonds",Equity,"Mortgage Securities",Lien,"Motor Vehicle",Others;
        }
        field(6; "Collateral Multiplier"; Integer)
        {

            trigger OnValidate()
            begin
                //"Guarantee Value":="Collateral Multiplier"*0.7;
            end;
        }
        field(7; Examples; Text[250])
        {
        }
        field(8; Blocked; Boolean)
        {
        }
        field(9; "Last Date Modified"; Date)
        {
            Editable = false;
        }
        field(10; "Revaluation Frequency"; DateFormula)
        {
        }
        // field(11; "No."; Code[20])
        // {
        //     Editable = false;
        //     trigger OnValidate()
        //     begin
        //         if "No." <> xRec."No." then begin
        //             SeriesSetup.Get;
        //             SeriesMagt.TestManual(SeriesSetup."Loan Security Setup Nos.");
        //             "No. Series" := '';
        //         end;
        //     end;
        // }
        // field(12; "No. Series"; Code[20])
        // {
        //     Editable = false;
        // }

    }

    keys
    {
        key(Key1; "Setup Code")
        {
            Clustered = true;
        }
        // key(Key1; "No.")
        // {
        //     Clustered = true;
        // }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Setup Code", Type, "Collateral Multiplier", "Security Description")
        {
        }
    }
    // trigger OnInsert()
    // begin
    //         if "No." = '' then begin

    //         SeriesSetup.Get;
    //         SeriesSetup.TestField(SeriesSetup."Loan Security Setup Nos.");
    //         SeriesMagt.InitSeries(SeriesSetup."Loan Security Setup Nos.", xRec."No. Series", 0D, "No.", "No. Series");

    //     end;
    // end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;
}

