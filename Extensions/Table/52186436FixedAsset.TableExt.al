#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186436 tableextension52186436 extends "Fixed Asset"
{
    fields
    {
        field(50000; "Asset Model"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Asset Tag"; Text[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Rec."Asset Tag" <> '' then
                    Rec."Asset Tag" := UpperCase(Rec."Asset Tag");
            end;


        }
        field(50002; "Old Asset Tag"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(50003; "Acquisition Type"; Option)
        {
            OptionMembers = " ",Purchased,Constructed,Leased;
            OptionCaption = ' ,Purchased,Constructed,Leased';
        }
        field(50010; "Budget Controlled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(50012; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50013; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50014; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(50015; "Budget Name"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "G/L Budget Name";
        }

        field(50017; No2; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; Donated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Asset Location"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Asset Status"; Option)
        {
            OptionMembers = " ","Good working condition","Obsolete",Broken;
            OptionCaption = ' ,Good working condition,Obsolete,Broken';
            DataClassification = ToBeClassified;
        }

        field(50021; "Lease Commence Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Acquisition Type" <> "Acquisition Type"::Leased then
                    Error('Lease details is only applicable to leased assets.');
            end;
        }
        field(50022; "Lease End Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Acquisition Type" <> "Acquisition Type"::Leased then
                    Error('Lease details is only applicable to leased assets.');
            end;
        }
        field(50051; "WIP No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;
        }
        field(39003930; "Unit Of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(39003931; "Vendor Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(39003932; "LPO No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where(Status = const(Released));

            trigger OnValidate()
            begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."No.", Rec."LPO No.");
                if Vendor.Find('-') then
                    Rec."Vendor Name" := Vendor.Name;
            end;
        }
        field(39003933; "Brand Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(39003934; "REG No."; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(39003935; "Chasis No"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(39003936; "Engine No"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(39003937; "Asset Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Vehicles,"Other Assets";
        }
        field(111; "Vehicle Registration No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(112; "Vehicle Engine No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(113; "Registration No."; Code[20])
        {
        }
        field(115; Capacity; Integer)
        {
        }
        field(116; "Asset No."; Code[20])
        {
            TableRelation = "Fixed Asset"."No.";
            trigger OnValidate()
            begin
                // FA.Reset;
                // if FA.Get("Asset No.") then
                //     Description := FA.Description;
                // "Purchase Vendor/Company" := FA."Vendor No.";

                // FADepBook.RESET;
                // FADepBook.SETRANGE("FA No.", FA."No.");
                // if FADepBook.FindSet() then begin
                //     "Purchase Date" := FADepBook."Acquisition Date";
                //     "Purchase Price" := FADepBook."Acquisition Cost";
                // end;
            end;
        }
        field(117; "Vehicle Type"; CODE[30])
        {
            TableRelation = "Vehicle Types".Code WHERE(Type = CONST("Type of Vehicle"));
        }
        field(118; "Year of Manufacture"; Date)
        {
        }
        field(119; "Color"; Text[30])
        {
        }
        field(120; "Load Limit"; Decimal)
        {
        }
        field(121; "Logbook No."; Code[20])
        {
        }
        field(122; "Engine No."; Code[20])
        {
        }
        field(123; "Vehicle Frame Number"; Code[20])
        {
        }
        field(124; "Purchase Date"; Date)
        {
            // TableRelation = "FA Depreciation Book";
            // trigger OnValidate()
            // begin
            //     FADepBook.RESET;
            //     FADepBook.SETRANGE("FA No.", FA."No.");
            //     if FADepBook.FindSet() then
            //         "Purchase Date" := FADepBook."Acquisition Date";
            //     "Purchase Price" := FADepBook."Acquisition Cost";
            // end;
        }
        field(125; "Purchase Vendor/Company"; Text[100])
        {
            // TableRelation = "Fixed Asset"."No.";
            // trigger OnValidate();
            // begin
            //     FA.Reset;
            //     if FA.Get("Asset No.") then
            //         if FA.Get("Purchase Vendor/Company") then
            //             "Purchase Vendor/Company" := FA."Vendor Name";
            // end;
        }
        field(126; "Vendor Contact Details"; code[20])
        {
        }
        field(127; "Purchase Price"; Decimal)
        {
        }
        field(128; "Insurance Company"; Text[20])
        {
            TableRelation = Vendor;
            trigger OnValidate()
            begin
                Vendor.RESET;
                if Vendor.GET("No.") then
                    "Insurance Company" := Vendor."Name";
                "Company Name" := Vendor."Name";
            end;
        }
        field(129; "Company Name"; Text[100])
        {

        }
        field(130; "Insurance Policy No."; Code[20])
        {
        }
        field(131; "Insurance Expiry Date"; Date)
        {
        }
        field(132; "Date of last insurace"; Date)
        {
        }
        // field(133; "Global Dimension 1 Code"; Code[20])
        // {
        //     CaptionClass = '1,1,1';
        //     Caption = 'Global Dimension 1 Code';
        //     TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        // }
        // field(134; "Global Dimension 2 Code"; Code[20])
        // {
        //     CaptionClass = '1,1,2';
        //     Caption = 'Global Dimension 2 Code';
        //     TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        // }
        field(135; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(136; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(137; "Type of Vehicle"; Option)
        {
            Caption = 'Type of Vehicle';
            OptionMembers = " ","Bus","Van","Motorbike";
        }
        field(138; "Vehicle Status"; Option)
        {
            Caption = 'Vehicle Status';
            OptionMembers = "Inactive","Active";
        }
        field(139; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Approved,"Pending Approval",Deffered,Cancelled,Rejected,Closed,Disposed;
        }
        field(144; "Marked for Disposal"; Boolean)
        {

        }
        field(141; "Created at"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
            ;
        }
        field(142; "Vehicle Make"; Option)
        {
            Caption = 'Vehicle Make';
            OptionMembers = "Toyota","Nissan","Mitsubishi","Isuzu","Mercedes Benz","BMW","Volkswagen","Ford","Mazda","Honda","Suzuki","Hyundai","Land Rover","Range Rover","Peugeot","Audi","Volvo","Subaru","Lexus","Chevrolet","Tata","Other";
        }
        modify("Responsible Employee")
        {
            tableRelation = "HR Employees"."No.";
        }
        field(143; "Employee Responsible"; code[50])
        {
            tableRelation = "HR Employees"."No.";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CalcFields("Responsible Employee Name");
            end;

        }
        field(145; "Responsible Employee Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HR Employees"."Full Name" where("No." = field("Employee Responsible")));
            trigger OnLookup()
            var
                myInt: Integer;
            begin

            end;
        }
        field(146; "Acquisition Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("FA Ledger Entry"."Posting Date" where("FA No." = field("No."), "FA Posting Type" = const("Acquisition Cost")));
        }
        field(147; Disposed; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("FA Ledger Entry" where("FA No." = field("No."), "FA Posting Type" = const("Proceeds on Disposal")));
        }
        field(148; "Disposal Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("FA Ledger Entry"."Document Date" where("FA No." = field("No."), "FA Posting Type" = const("Proceeds on Disposal")));
        }
        field(149; "Expected Useful Life"; Decimal)
        {
            MinValue = 0.1;
            MaxValue = 100;
        }
        modify("FA Class Code")
        {
            trigger Onaftervalidate()
            begin
                FAClasses.RESET;
                if FAClasses.get("FA Class Code") then begin
                    if FAClasses."Depreciation Book Code" <> '' then begin
                        DepreciationBook.SetRange("FA No.", Rec."No.");
                        if DepreciationBook.FindSet() then
                            DepreciationBook.DELETEALL;

                        DepreciationBook.reset;
                        DepreciationBook.init;
                        DepreciationBook."FA No." := Rec."No.";
                        DepreciationBook."Depreciation Book Code" := FAClasses."Depreciation Book Code";
                        DepreciationBook.validate("Depreciation Method", FAClasses."Depreciation Method");
                        DepreciationBook."Straight-Line %" := FAClasses."Straight-Line %";
                        DepreciationBook.INSERT(true);

                        FACard.UpdateDepreciationBook(rec."No.");
                        FACard.Update();

                    end;

                end;
                rec.Validate("Description");
            end;
        }
    }

    var
        Vendor: Record Vendor;
        DepreciationBook: Record "FA Depreciation Book";
        FAClasses: Record "FA Class";
        FACard: page "Fixed Asset Card";
}
