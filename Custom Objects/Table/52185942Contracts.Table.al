table 52185942 Contracts
{
    // DrillDownPageId = "Contract List";
    // LookupPageId = "Contract List";
    DrillDownPageId = "Contracts list";
    LookupPageId = "Contracts list";


    fields
    {
        field(1; "Contract No"; Code[30])
        {
            //Description = 'iko';
            Editable = false;

            trigger OnValidate()
            begin
                if "Contract No" <> xRec."Contract No" then begin
                    NoseriesSetup.Get;
                    NoSeriesMgt.TestManual(NoseriesSetup."Contract No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Contractor Type"; Option)
        {
            Description = 'Description';
            OptionCaption = ' ,Vendor,Customer';
            OptionMembers = " ",Vendor,Customer;

            trigger OnValidate()
            begin
                "Contractor No" := '';
                "Contractor Name" := '';
                Address := '';
                "Tel No." := '';
            end;
        }

        field(3; "Contractor No"; Code[60])
        {
            Description = 'Description';
            TableRelation = IF ("Contractor Type" = CONST(Vendor)) Vendor."No."
            ELSE
            IF ("Contractor Type" = CONST(Customer)) Customer."No.";

            trigger OnValidate()
            begin

                "Contractor Name" := '';

                if "Contractor Type" in ["Contractor Type"::Customer, "Contractor Type"::Vendor]
                then
                    case "Contractor Type" of
                        "Contractor Type"::Customer:
                            begin
                                Cust.Get("Contractor No");
                                "Contractor Name" := Cust.Name;
                                Address := Cust.Address;
                                "Tel No." := Cust."Phone No.";
                                "Physical Address" := Cust."Physical Address";
                                "Contractor Description" := Cust."Company Profile";
                                "Area Sqft" := Cust."Size in Sq. Ft.";
                                "Escalation For Leases" := Cust."Escalation For Leases";

                                Lease.Reset();
                                Lease.SetRange("Tenant No.", "Contractor No");
                                if Lease.Find('-') then begin
                                    "Floor Code" := Lease."Floor Name";
                                    "Unit Code" := Lease."Unit Code";
                                    "L.R No." := Lease."L.R. No.";
                                    "Billing Frequency" := Lease."Billing Frequency";
                                    "Lease Start Date" := Lease."Lease Commence Date";
                                    "Lease End Date" := Lease."Expiry Date";
                                    "Lease Period" := Lease."Duration Value";

                                    LeaseLines.Reset();
                                    LeaseLines.SetRange("Lease No.", Lease."No.");
                                    if LeaseLines.Find('-') then begin
                                        "Lease Amount Inc VAT" := LeaseLines."Amount Exclusive VAT";
                                        "Lease Amount Exc VAT" := LeaseLines."Amount Exclusive VAT";
                                        "Escalation Start Date" := LeaseLines."Review Start Date";
                                    end;
                                end;

                            end;
                        "Contractor Type"::Vendor:
                            begin
                                Vend.Get("Contractor No");
                                "Contractor Name" := Vend.Name;
                                Address := Vend.Address;
                                "Tel No." := Vend."Phone No.";
                                "Physical Address" := Vend.City;
                                // "Contact Person":=Vend.Contact;
                            end;
                    end;
            end;
        }
        field(4; "Contractor Name"; Text[60])
        {
            Description = 'Description';
        }
        field(49; "Contract Type"; Option)
        {
            Description = 'Description';
            OptionCaption = ' ,Service agreement, Lease, Annual maintenance, Non Disclosure Agreement, Data Protection Agreement, Other';
            OptionMembers = " ","service agreement",lease,"annual maintenance","Non Disclosure Agreement","Data Protection Agreement", Other;
            // trigger OnValidate()
            // begin
            //    "Type Of Service" := 0;
            //    "Contract Description" := '';
            //    "L.R No." := '';
            //    "Date of Request" := 0D;
            //    "Start Date" := 0D;
            //    "End Date" := 0D;
            //    "Contract Period" := '';
            //    "Contract Type" := 0;
            //    "Party to the Contract" := '';
            //    "Contractor No" := '';
            //     "Contractor Name" := '';
            //     "Contract Description" := '';
            //     Address := '';
            //     "Tel No." := '';
            //     "Advocate Name" := '';
            //     "Payment Terms" := 0;
            //     "User Department" := '';
            //     "Contract Sum" := 0;
            //     Balance := 0;
            //     "Total Balance" := 0;
            //     "Termination Clause" := '';
            //     "Termination Reason" := '';
            //     "Escalation For Leases" := 0;
            //     Remarks := '';
            // end;
        }
        field(5; Address; Code[30])
        {
            Description = 'Description';
        }
        field(6; "Tel No."; Code[30])
        {
            Description = 'iko';
        }
        field(8; "Start Date"; Date)
        {
            Description = 'iko';

            // trigger OnValidate()
            // begin
            //     "Remaining Days":="End Date"-"Start Date";
            // end;
        }
        field(9; "End Date"; Date)
        {
            Description = 'iko';

            // trigger OnValidate()
            // begin
            //     "Remaining Days":="End Date"-"Start Date";
            // end;
        }
        field(10; "Contract Description"; Text[2048])
        {
        }
        field(14; "Contract Sum"; Decimal)
        {

            trigger OnValidate()
            begin
                "Total Balance" := "Contract Sum" - Balance;
            end;
        }
        field(15; Balance; Decimal)
        {
            CalcFormula = Sum("Payment Line"."Net Amount" WHERE("Contract No" = FIELD("Contract No")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "Total Balance" := "Contract Sum" - Balance;
            end;
        }
        field(17; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(23; "Payment Terms"; Option)
        {
            OptionCaption = ' ,Monthly,Quarterly,Bi-Annually,Annually,As Per Need';
            OptionMembers = " ",Monthly,Quarterly,"Bi-Annually",Annually,"As Per Need";
        }
        field(24; "Responsible Employee"; Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(25; "Amount Paid"; Decimal)
        {
        }
        field(26; "Responsible Employee Name"; Text[100])
        {
            CalcFormula = Lookup("HR Employees"."Full Name" WHERE("No." = FIELD("Responsible Employee")));
            FieldClass = FlowField;
        }
        field(31; "Renewal Clause"; TEXT[500])
        {
            //OptionMembers = " ",Daily,Weekly,Monthly,Quaterly,BiAnnually,Anually;
        }
        field(32; "Type Of Service"; Option)
        {
            OptionMembers = " ",Goods,Services;

            trigger OnValidate()
            begin
                "Nature Of Service" := '';
                "Start Date" := 0D;
                "End Date" := 0D;
            end;
        }
        field(33; "Advocate Name"; Text[30])
        {
        }
        field(34; "Nature Of Service"; Code[30])
        {
            TableRelation = "Nature Of Sevices";
        }
        field(35; Comment; Boolean)
        {
        }
        field(36; "Board Approval Date"; Date)
        {
        }
        field(37; "User Department"; Code[50])
        {
            //TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('ACTIVITY'));
            TableRelation = "Responsibility CenterBR";
        }
        field(50; "Shortcut Dimension 2 Code"; Code[20])
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
        field(38; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(39; "Remaining Days"; Integer)
        {

            trigger OnValidate()
            begin
                "Remaining Days" := "End Date" - "Start Date";
            end;
        }
        field(40; "Defect Liability Period"; DateFormula)
        {
        }
        field(41; "Support Period"; DateFormula)
        {
        }
        field(42; "Warranty Period"; DateFormula)
        {
        }
        field(43; Remarks; Text[150])
        {
        }
        field(44; "Total Balance"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                "Total Balance" := "Contract Sum" - Balance;
            end;
        }
        field(39003904; Terminated; Boolean)
        {
            Editable = false;
        }
        field(46; "Termination Reason"; Text[2000])
        {
        }
        field(45; "Termination Clause"; Text[2048])
        {
        }
        field(47; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
            trigger OnValidate()
            begin
                if (xRec.Status = Status::New) and (Rec.Status = Status::Approved) then 
                Rec."Contract Status" := "Contract Status"::Ongoing;
            end;
        }
        field(48; UserID; Code[50])
        {
        }
        field(150; "L.R No."; Code[50])
        {
        }
        field(160; "User ID"; Code[50])
        {
        }
        field(161; "Created By"; Code[50])
        {
        }
        field(162; "Responsibility Center"; Code[50])
        {
        }
        field(163; "Global Dimension 1 Code"; Code[50])
        {
        }
        field(164; "Global Dimension 2 Code"; Code[50])
        {
        }
        field(165; "Escalation For Leases"; Decimal)
        {

        }
        field(166; "Date of Request"; Date)
        {

        }
        field(167; "Date of Excecution"; Date)
        {

        }
        field(168; "Contract Period"; Text[100])
        {

        }
        field(169; "Party to the Contract"; Text[2000])
        {

        }
        field(170; "Contractor Description"; Text[2000])
        {

        }
        field(171; "Physical Address"; CODE[100])
        {
        }
        field(175; "Area Sqft"; Decimal)
        {
        }
        field(176; "Escalation Start Date"; Date)
        {
        }
        field(177; "Unit Code"; Code[20])
        {
        }
        field(178; "Floor Code"; Text[100])
        {
        }
        field(179; "Lease Start Date"; Date)
        {
        }
        field(180; "Lease End Date"; Date)
        {
        }
        field(181; "Lease Period"; Integer)
        {
        }
        field(182; "Lease Amount Inc VAT"; Decimal)
        {
        }
        field(183; "Billing Frequency"; Option)
        {
            OptionCaption = 'Monthly,Quarterly,Annually,Semi Annually';
            OptionMembers = Monthly,Quarterly,Annually,"Semi Annually";
        }
        field(184; "Lease Amount Exc VAT"; Decimal)
        {
        }
        field(185; "Company Number"; Code[50])
        {
        }
        field(186; "Place of Business"; Text[200])
        {
        }
        field(187; "Send/Forward to"; Code[50])
        {
            TableRelation = "Responsibility CenterBR";
        }

        field(188; "Originating Department"; Code[50])
        {
            Editable = false;
        }
        field(189; "Current Department"; Code[50])
        {
            Editable = false;
        }
        field(190; "Contract Status"; Option)
        {
            Caption = 'Contract Status';
            OptionMembers = New, "Ongoing", Terminated, Expired;
        }
        field(191; Expired; Boolean)
        {
            Editable = false;
        }
        field(192; "Other Contract Type Descr."; Text[2048])
        {

        }

    }

    keys
    {
        key(Key1; "Contract No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Dropdown; "Contract No", "Contract Description", "Contract Type", "Contractor No", "Contractor Description", "Contractor Name")
        {
        }
    }

    trigger OnInsert()
    begin
        UserID := DATABASE.UserId;
        if "Contract No" = '' then begin
            NoseriesSetup.Get;
            NoseriesSetup.TestField(NoseriesSetup."Contract No");
            NoSeriesMgt.InitSeries(NoseriesSetup."Contract No", xRec."No. Series", 0D, "Contract No", "No. Series");
        end;

        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserID);
        if UserSetup.Find('-') then
            // "Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            // "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";

            "User ID" := UserId;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
            UserSetup.TestField("Responsibility Centre");
            "Originating Department" := UserSetup."Responsibility Centre";
            "Current Department" := UserSetup."Responsibility Centre";
            CFPage.InsertTracker("Contract No", "Originating Department", true, UserId, CurrentDateTime);
        end;
    end;

    var
        Cust: Record Customer;
        Vend: Record Vendor;
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Hrempl: Record "HR Employees";
        ContractLineType: Record "Contract Lines Types";
        UserSetup: Record "User Setup";

        NoseriesSetup: Record "Credit Nos. Series";
        Lease: Record Lease;
        LeaseLines: Record "Lease Line";
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
}

