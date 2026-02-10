table 52185764 "Welfare Advance"
{
    Caption = 'Welfare Advance';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; code[40])
        {
            Caption = 'No';
            Editable = false;
        }
        field(2; "Applicant Code"; Code[40])
        {
            Caption = 'Applicant Code';
            TableRelation = "HR Employees"."No." WHERE(Status = filter(Active));

            Editable = false;
        }
        field(3; "Applicant Name"; Text[200])
        {
            Caption = 'Applicant Name';
            Editable = false;
        }
        field(4; "ID No"; code[40])
        {
            Caption = 'ID No';
            Editable = false;
        }
        field(5; Gender; Option)
        {
            OptionMembers = Female,Male;
            Caption = 'Gender';
            Editable = false;

        }
        field(6; "Date"; Date)
        {
            Caption = 'Date';
            Editable = false;
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(8; "User Id"; Code[30])
        {
            Caption = 'User Id';
            Editable = false;
        }
        field(9; "Last Modified By"; Code[30])
        {
            Caption = 'Last Modified By';
            Editable = false;
        }
        field(10; Status; enum "Workflow Status Main Flags")
        {

            Editable = false;
        }
        field(11; "No. Series"; code[40])
        {

        }
        field(12; "Global Dimension 1 Code"; code[30])
        {

            Editable = false;
        }
        field(13; "Global Dimension 2 Code"; code[30])
        {

            Editable = false;
        }
        field(14; "Job Title"; code[40])
        {

            Editable = false;
        }
        field(15; "Responsibility Center"; code[40])
        {

            Editable = false;
        }
        field(16; "Product"; code[50])
        {
            TableRelation = "Product Factory"."Product ID" WHERE("Product Class Type" = CONST(Loan),
                                                                  Status = CONST(Active));
         trigger Onvalidate()
         var
            myInt: Integer;
         begin
            IF ProdFac.GET(Product) then begin
            //   LoanApp.Reset;
            //             LoanApp.SetRange("Member No.", "Member No.");
            //             LoanApp.SetRange(Posted, true);
            //             LoanApp.SetRange("Loan Product Type", "Loan Product Type");
            //             LoanApp.SetRange("Dummy Appraisal", false);
            //             LoanApp.SetFilter("Outstanding Balance", '>0');
            //             if LoanApp.Find('-') then begin
            //                 repeat
            //                     if ProdFac.Get("Loan Product Type") then begin
            //                         if ProdFac."Allow Multiple Running Loans" = false then
            //                             Message('Member already has an existing Loan %1 of same product which needs bridging', LoanApp."Loan No.")
            //                         else
            //                             Message('Member already has an existing Loan %1 of same product', LoanApp."Loan No.");
            //                     end;
            //                 until LoanApp.Next = 0;
            //             end;
             "Product Name" := ProdFac."Product Description";
               
              
            end;
         end;

        }
        field(17; "Product Name"; code[30])
        {

        }

    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if No = '' then begin
            HrSetup.Get();
            HrSetup.TestField(HrSetup."Welfare Advance No.");
            NoSeriesMgt.InitSeries(HrSetup."Welfare Advance No.", xRec."No. Series", 0D, No, "No. Series");
        end;

        "User ID" := UpperCase(UserId);
        Date := Today;
        Employee.Reset;
        Employee.SetRange(Employee."User ID", UserId);
        if Employee.Find('-') then begin
            //Populate fields
            UserSetUp.Get(UserId);
            "Applicant Code" := Employee."No.";
            "Applicant Name" := Employee.FullName;
            "ID No" := Employee."Primary Identification";
            Gender := Employee.Gender;
            "User ID" := UserId;
            "Job Title" := Employee."Job Title";
            "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
            "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
            "Responsibility Center" := UserSetUp."Responsibility Centre";


        end;
    end;

    var
        HrSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employee: record "HR Employees";
        UserSetUp: record "User Setup";
        ProdFac:record "Product Factory";
}
