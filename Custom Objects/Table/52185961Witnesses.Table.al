table 52185961 Witnesses
{
    DrillDownPageID = "Witness Line";
    LookupPageID = "Witness Line";

    fields
    {
        field(1; No; Code[20])
        {
            trigger OnValidate()
            begin
                if No <> xRec.NO then begin
                    MembNoSeries.Get;
                    NoSeriesMgt.TestManual(MembNoSeries."Witness Nos.");
                    "No. Series" := ' ';
                    
                end;
            end;
        }
        field(2; Name; Text[100])
        {
            Editable = false;
        }
        field(3; "Witness No"; Code[20])
        {
            TableRelation = IF ("Witness Type" = CONST(Member)) Members."No."
            ELSE
            IF ("Witness Type" = CONST(Supplier)) Vendor."No."
            ELSE
            IF ("Witness Type" = CONST(Tenant)) Customer."No."
            ELSE
            IF ("Witness Type" = CONST(Staff)) "HR Employees"."No.";

            trigger OnValidate()
            begin
                Emp.Reset;
                Emp.SetRange(Emp."No.", "Witness No");
                if Emp.Find('-') then
                    Name := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";

                Cust.Reset;
                Cust.SetRange(Cust."No.", "Witness No");
                if Cust.Find('-') then
                    Name := Cust.Name;


                Vend.Reset;
                Vend.SetRange(Vend."No.", "Witness No");
                if Vend.Find('-') then
                    Name := Vend.Name;


                Memb.Reset;
                Memb.SetRange(Memb."No.", "Witness No");
                if Memb.Find('-') then
                    Name := Memb.Name;
            end;
        }
        field(4; "Witness Type"; Option)
        {
            OptionCaption = ' ,Member,Supplier,Tenant,Staff';
            OptionMembers = " ",Member,Supplier,Tenant,Staff;
        }
        field(50000; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50001; "Case No"; Code[20])
        {
            TableRelation = Legal."Case Number";
        }
        field(50002; "Line No"; Integer)
        {
        }
        field(7; "Captured By"; Code[50])
        {
        }
        field(8; "Captured On"; DateTime)
        {
        }
        
  
    }

    keys
    {
        key(Key1; No, "Case No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
            MembNoSeries.Get;
            NoSeriesMgt.InitSeries(MembNoSeries."Witness Nos.", xRec."No. Series", 0D, No, "No. Series");
            
            // GLSetup.Get;
            // GLSetup.TestField(GLSetup."Witness Nos.");
            // NoSeriesMgt.InitSeries(GLSetup."Witness Nos.", xRec."No. Series", 0D, No, "No. Series");
    
        end;
        Rec."Captured On" := CURRENTDATETIME;
        Rec."Captured By" := UserId;
    end;

    var
        Emp: Record "HR Employees";
        GenLedgerSetup: Record "Cash Office Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Vend: Record Vendor;
        Cust: Record Customer;
        Memb: Record Members;
        Witn: Record Witnesses;
        HRCommittees: Record "HR Committees";
        DimMgt: Codeunit DimensionManagement;
        GLSetup: Record "General Ledger Setup";
        MembNoSeries: Record "Credit Nos. Series";
}


