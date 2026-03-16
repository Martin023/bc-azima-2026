table 52187032 "Clearance Form"// 52185815
{
    Caption = 'Clearance Form';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Clearance No"; Code[50])
        {
            Caption = 'Clearance No';
            Editable = false;
        }

        field(2; status; enum "Workflow Status Main Flags")
        {
            Editable = false;
            trigger OnValidate()
            begin
                if (Rec.Status = Status::Rejected) then
                    GlobalFunctions.CommentsManagement(Rec."Clearance No");
            end;


        }
        field(3; "Fosa Net Liability"; decimal)
        {

        }
        field(4; "Business Loans Liabilities"; decimal)
        {

        }
        field(5; "BOSA Liabilities"; decimal)
        {


        }
        field(6; "Office Property"; text[200])
        {

        }
        field(7; "Finance Liabilities"; code[200])
        {

        }
        field(8; "HR Liabilities"; text[200])
        {

        }
        field(9; "Employee No."; code[50])
        {
            TableRelation = "HR Employees"."No.";


        }
        field(10; "Employee Name"; code[200])
        {

        }
        field(11; "Fosa Approver"; code[100])
        {

        }
        field(12; "Procurement Approver"; code[100])
        {

        }
        field(13; "Business Loans Approver"; code[100])
        {

        }
        field(14; "BOSA Approver"; code[100])
        {

        }
        field(15; "Finance Approver"; code[100])
        {

        }
        field(16; "Hr Approver"; code[100])
        {

        }
        field(17; "Security"; code[100])
        {

        }
        field(18; "Security Approver"; code[100])
        {

        }
        field(19; "Staff Welfare"; code[100])
        {

        }
        field(20; "Staff Welfare Approver"; code[100])
        {

        }
        field(21; "Deactivation"; text[100])
        {

        }
        field(22; "Job Title"; code[200])
        {

        }
        field(23; "Fosa Designation"; code[200])
        {

        }
        field(24; "Date"; Date)
        {

        }
        field(25; "Date1"; Date)
        {

        }
        field(26; "Date2"; Date)
        {

        }
        field(27; "Date3"; Date)
        {

        }
        field(28; "Date4"; Date)
        {

        }
        field(29; "Date5"; Date)
        {

        }
        field(30; "Date6"; Date)
        {

        }
        field(31; "Date7"; Date)
        {

        }
        field(32; "Security Designation"; code[100])
        {

        }
        field(33; "Human Resource Designation"; code[100])
        {

        }
        field(34; "Finance Designation"; code[100])
        {

        }
        field(35; "BOSA Designation"; code[100])
        {

        }
        field(36; "Procurement Designation"; code[100])
        {

        }
        field(37; "Business Loans Designation"; code[100])
        {

        }
        field(38; "Staff Welfare Designation"; code[100])
        {

        }
        field(39; "No Series"; code[40])
        { }
        FIELD(40; "IT Equipment"; text[200])
        {

        }
        field(41; "IT Approver"; code[40])
        {

        }
        field(42; "IT Designation"; code[100])
        {

        }
        field(43; "Applicant User ID"; code[100])
        {

        }
        field(44; "Global Dimension 1 Code"; CODE[100])
        {

        }
        Field(45; "Global Dimension 2 Code"; code[100])
        {

        }
        field(46; "Responsibility Center"; code[100])
        {

        }

    }
    keys
    {
        key(PK; "Clearance No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin

        if "Clearance No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Clearance No");
            "Clearance No" := NoSeriesMgt.GetNextNo(HRSetup."Clearance No");
            
            // NoSeriesMgt.InitSeries(HRSetup."Clearance No", xRec."No Series", 0D, "Clearance No", "No Series");



            HREmp.Reset;
            HREmp.SetRange(HREmp."User ID", UserId);
            if HREmp.Find('-') then begin
                UserSetUp.Get(UserId);
                rec."Employee No." := HREmp."No.";
                rec."Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";

                rec.Date := Today;
                rec."Applicant User ID" := UserId;
                rec."Job Title" := HREmp."Job Title";

                rec."Global Dimension 1 Code" := HREmp."Global Dimension 1 Code";
                rec."Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
                rec."Responsibility Center" := UserSetUp."Responsibility Centre";

                Members.reset();
                Members.SetRange("Payroll/Staff No.", rec."Employee No.");
                if Members.FindFirst() then
                    MemberNo := Members."No.";
            end else
                ERROR('UserID' + ' ' + '[' + USERID + ']' + ' has not been assigned to any employee. Please consult the HR officer for assistance')

        end;

        ResponsibilityCentre.reset();

        if ResponsibilityCentre.FindSet() then begin

            Repeat
                Clear(ClearanceLines);
                ClearanceLines.init;
                ClearanceLines."Header No" := rec."Clearance No";
                ClearanceLines."Responsibility Centre" := ResponsibilityCentre.Code;

                if ClearanceLines."Responsibility Centre" = 'BOSA' then
                    ClearanceLines.Liabilities := LoansProcess.CalculateMemberArrearsPerSourceUnit(MemberNo, Today, 2);
                if ClearanceLines."Responsibility Centre" = 'BUSINESS LOANS' then
                    ClearanceLines.Liabilities := LoansProcess.CalculateMemberArrearsPerSourceUnit(MemberNo, Today, 3);
                if ClearanceLines."Responsibility Centre" = 'HR' then
                    ClearanceLines.Liabilities := LoansProcess.CalculateMemberArrearsPerSourceUnit(MemberNo, Today, 4);
                if ClearanceLines."Responsibility Centre" = 'FOSA' then
                    ClearanceLines.Liabilities := LoansProcess.CalculateMemberArrearsPerSourceUnit(MemberNo, Today, 1);


                ClearanceLines.insert(true);
            until ResponsibilityCentre.next = 0;
        end;
    end;










    var
        HrSetup: record "HR Setup";
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: record "User Setup";
        HrEmp: record "HR Employees";
        Characters: code[100];
        GlobalFunctions: Codeunit "Global Functions";
        ResponsibilityCentre: record "Responsibility CenterBR";
        ClearanceLines: record "Clearance Lines";
        LoansProcess: Codeunit "Loans Process";
        Members: Record Members;
        MemberNo: Code[50];

}

