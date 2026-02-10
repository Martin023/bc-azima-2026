#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186412 tableextension52186412 extends "User Setup"
{
    fields
    {
        field(50000; "Unlimited PV Amount Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "PV Amount Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Unlimited PettyAmount Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Petty C Amount Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Unlimited Imprest Amt Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Imprest Amount Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Unlimited Store RqAmt Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Store Req. Amt Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50009; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50010; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50011; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(50012; "Unlimited ImprestSurr Amt Appr"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "ImprestSurr Amt Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Unlimited Interbank Amt Appr"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Interbank Amt Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Imprest Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Travel Advance';
            TableRelation = Customer."No." where("Account Type" = const("Staff Imprest"));
        }
        field(50017; "Post JVs"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Post Bank Rec"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Unlimited Receipt Amt Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Receipt Amt Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Unlimited Claim Amt Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Claim Amt Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Unlimited Advance Amt Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Advance Amt Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Unlimited AdvSurr Amt Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "AdvSurr Amt Approval Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Other Advance Staff Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Other Advances';
            TableRelation = Customer."No." where("Account Type" = const("Travel Advance"));
        }
        field(50028; "Employee No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees";
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                if "User Type" = "User Type"::"Service Account" then
                    error('This is only valid to staff accounts.')
            end;
        }
        field(50029; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members."No.";


        }
        field(50030; "Office/Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(50031; "Responsibility Centre"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'LookUp to Responsibility Center BR';
            TableRelation = "Responsibility CenterBR";
        }
        field(50032; "Extended Posting Date"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Self Posting Gn Jnl"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Credit FOSA Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "User Type"; Option)
        {
            OptionMembers = "Staff","Service Account";
            DataClassification = ToBeClassified;
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                "Employee No." := '';
            end;
        }
        field(39004041; "Allow Posting From [Time]"; Time)
        {
            Caption = 'Allow Posting From [Time]';
            DataClassification = ToBeClassified;
        }
        field(39004042; "Allow Posting To [Time]"; Time)
        {
            Caption = 'Allow Posting To [Time]';
            DataClassification = ToBeClassified;
        }
        field(39004043; "Show Hidden"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39004044; "Full Name"; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(39004045; "Double Login"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(39004046; "Post Reversals"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39004047; "Restricted Posting Date"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39004048; "Show Hidden Balance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39004049; Admin; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39004050; "Post Dividend"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39004051; "Allow Overdrawal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39004052; "Guarantor Release"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39004053; "Delegate Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39004054; "Update Loan Instalments"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39004055; "Run Sasra Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39004056; "Portal Onboarding"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39004057; "Member Change Permission"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39004058; "Edit Sal Through FOSA"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39004059; "Allow Self Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39004060; "No. Active Session"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(39004061; "Employee Extension No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }

    }
}
