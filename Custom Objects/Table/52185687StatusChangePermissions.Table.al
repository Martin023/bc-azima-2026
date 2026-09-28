table 52185687 "Status Change Permissions."
{

    DrillDownPageId = "Status Change Permssion.";

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID.';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if Temp.Get("User ID") then begin
                    Temp.TestField("Full Name");
                    Temp.TestField("Responsibility Centre");
                    Temp.TestField("Global Dimension 1 Code");
                    Temp.TestField("Global Dimension 2 Code");
                    "Full Name" := Temp."Full Name";
                    "Responsibility Centre" := Temp."Responsibility Centre";
                    "Shortcut Dimension 1 Code" := Temp."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := Temp."Global Dimension 2 Code";
                end;
            end;
        }
        field(2; "Function"; Option)
        {
            NotBlank = false;
            OptionCaption = ',View Payroll,View Employee Record,Operation User';
            OptionMembers = ,"View Payroll","View Employee Record","Operation User";
        }
        field(3; "User ID No."; Code[80])
        {
        }
        field(4; "Edit Banking User Setup"; Boolean)
        {
        }
        field(5; "View Payroll"; Boolean)
        {
        }
        field(6; "Edit Payroll"; Boolean)
        {
        }
        field(7; "View Setup"; Boolean)
        {
        }
        field(8; "Edit Setup"; Boolean)
        {
        }
        field(9; "View G/L Account"; Boolean)
        {
        }
        field(10; "Edit  G/L Account"; Boolean)
        {
        }
        field(11; "Edit Member Changes"; Boolean)
        {
        }
        field(12; "View Employee Record"; Boolean)
        {
        }
        field(13; "Edit Employee Record"; Boolean)
        {
        }
        field(14; "Block account"; Boolean)
        {
        }
        field(15; "Unblock Account"; Boolean)
        {
        }
        field(16; "Cheque Writting"; Boolean)
        {
        }
        field(17; "Edit Bank Card"; Boolean)
        {
        }
        field(18; "View Staff Acc"; Boolean)
        {
        }
        field(19; "Full Name"; Text[30])
        {
            Editable = false;
        }
        field(20; "Email Address"; Code[20])
        {
            Editable = false;
        }
        field(50; "Product Setup"; Boolean)
        {
            Editable = true;
        }
        field(21; "Responsibility Centre"; Code[10])
        {
            Editable = true;
            TableRelation = "Responsibility CenterBR".Code;
        }
        field(22; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(23; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(24; "Post Dividends"; Boolean)
        {
        }
        field(25; "View Next of Kin"; Boolean)
        {
        }
        field(26; "Edit Next of Kin"; Boolean)
        {
        }
        field(27; "Upload Old Loans"; Boolean)
        {
        }
        field(28; "Edit Vendor"; Boolean)
        {
        }
        field(29; "View Edit"; Boolean)
        {
        }
        field(30; "Edit Customer"; Boolean)
        {
        }
        field(31; "View Customer"; Boolean)
        {
        }
        field(32; "Edit Journal"; Boolean)
        {
        }
        field(33; "Update Rejoining Member"; Boolean)
        {
        }
        field(34; "Edit HR"; Boolean)
        {
        }
        field(35; "View HR"; Boolean)
        {
        }
        field(36; "Function Extended"; Option)
        {
            NotBlank = false;
            OptionCaption = ' ,View Payroll,View Employee Record,Account Status,Standing Order,Discounting Cheque,Inter Teller Approval,Discounting Loan,Fosa Loan Appraisal,Discounting Shares,Discounting Dividends,Loan External EFT,Overide Defaulters,BOSA Account Status,Fosa Loan Approval,PV Approval,PV Verify,PV Cancel,ATM Approval,Petty Cash Approval,Bosa Loan Approval,Bosa Loan Appraisal,Atm card ready,Audit Approval,Finance Approval,Journal Approval,Journal Posting,Cheque Writing,Cheque Schedule,Mark Defaulter,Data Sheet,Record Reconciled,M-SACCO Approval,Msacco Applications,Finalize Mpesa Changes FOSA,Send Bulk SMS,Sharia,Edit Client Code,FOSA Access,Archive FOSA Account,Change Log,Loan Data,Clear Defaulter,Finalize Mpesa Changes BOSA,Cheque Approval,Auto Recovery,Edit Bank Card,Edit HR Setups,Post Dividends,Generate Dividends,Administrator,Operation User,View Fund Mangement Setup,Ict Group,Appraisal Setup';
            OptionMembers = " ","View Payroll","View Employee Record","Account Status","Standing Order","Discounting Cheque","Inter Teller Approval","Discounting Loan","Fosa Loan Appraisal","Discounting Shares","Discounting Dividends","Loan External EFT","Overide Defaulters","BOSA Account Status","Fosa Loan Approval","PV Approval","PV Verify","PV Cancel","ATM Approval","Petty Cash Approval","Bosa Loan Approval","Bosa Loan Appraisal","Atm card ready","Audit Approval","Finance Approval","Journal Approval","Journal Posting","Cheque Writing","Cheque Schedule","Mark Defaulter","Data Sheet","Record Reconciled","M-SACCO Approval","Msacco Applications","Finalize Mpesa Changes FOSA","Send Bulk SMS",Sharia,"Edit Client Code","FOSA Access","Archive FOSA Account","Change Log","Loan Data","Clear Defaulter","Finalize Mpesa Changes BOSA","Cheque Approval","Auto Recovery","Edit Bank Card","Edit HR Setups","Post Dividends","Generate Dividends",Administrator,"Operation User","View Fund Mangement Setup","Ict Group","Appraisal Setup";
        }
        field(37; "Reset Notice Date"; Boolean)
        {
        }
        field(38; "Block Mobile Loan"; Boolean)
        {
        }
        field(39; "Register ADM Attendance"; Boolean)
        {
        }
        field(40; "View Funds Management Setup"; Boolean)
        {
        }
        field(41; "Appraisal Setup"; boolean)
        {

        }
        field(42; "Process Risk Claims"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Edit Fixed Asset"; Boolean)
        {
        }
        field(51; "Mbanking - View"; Boolean)
        {
        }
        field(52; "Mbanking - Edit"; Boolean)
        {
        }
        field(53; "ATM - View"; Boolean)
        {
        }
        field(54; "Edit Div Advance"; Boolean)
        {

        }
        field(55; "Recover Share & Entrance Fee"; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "Function", "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        UserMgt: Codeunit "User Setup Management";
        Temp: Record "User Setup";
}

