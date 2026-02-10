table 52185925 "FA Budget Entry"
{
    Caption = 'FA Budget Entry';
    DrillDownPageID = "FA Budget Entries";
    LookupPageID = "FA Budget Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Analysis Area"; Option)
        {
            Caption = 'Analysis Area';
            NotBlank = true;
            OptionCaption = 'Sales,Purchase';
            OptionMembers = Sales,Purchase;
        }
        field(3; "Budget Name"; Code[10])
        {
            Caption = 'Budget Name';
            TableRelation = "G/L Budget Name".Name;
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            ClosingDates = true;
        }
        field(5; "FA No."; Code[20])
        {
            TableRelation = "Fixed Asset";

            trigger OnValidate()
            begin
                FABudget.Reset;
                FABudget.SetRange(FABudget."FA No.", "FA No.");
                if FABudget.FindSet then
                    if not Confirm('Budget entries already exist for this asset, do you want to continue?', false) then
                        Error('Process aborted');
            end;
        }
        field(6; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor,Item';
            OptionMembers = " ",Customer,Vendor,Item;

            trigger OnValidate()
            begin
                if "Source Type" <> xRec."Source Type" then
                    Validate("Source No.", '');
            end;
        }
        field(7; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = IF ("Source Type" = CONST(Customer)) Customer
            ELSE
            IF ("Source Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Source Type" = CONST(Item)) Item;
        }
        field(8; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(9; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(10; "Cost Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount';
        }
        field(11; "Sales Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales Amount';
        }
        field(13; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                // UserMgt.LookupUserID("User ID");
            end;
        }
        field(14; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(15; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                if "Global Dimension 1 Code" = '' then
                    exit;
                // //GetGLSetup;
                ValidateDimValue(GLSetup."Global Dimension 1 Code", "Global Dimension 1 Code");
            end;
        }
        field(16; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                if "Global Dimension 2 Code" = '' then
                    exit;
                // //GetGLSetup;
                ValidateDimValue(GLSetup."Global Dimension 2 Code", "Global Dimension 2 Code");
            end;
        }
        field(17; "Budget Dimension 1 Code"; Code[20])
        {
            // CaptionClass = GetCaptionClass(1);
            Caption = 'Budget Dimension 1 Code';

            trigger OnLookup()
            begin
                // "Budget Dimension 1 Code" := OnLookupDimCode(2, "Budget Dimension 1 Code");
            end;

            trigger OnValidate()
            begin
                if "Budget Dimension 1 Code" = '' then
                    exit;
                if GLBudgetName.Name <> "Budget Name" then
                    GLBudgetName.Get("Budget Name");
                ValidateDimValue(GLBudgetName."Budget Dimension 1 Code", "Budget Dimension 1 Code");
            end;
        }
        field(18; "Budget Dimension 2 Code"; Code[20])
        {
            // CaptionClass = GetCaptionClass(2);
            Caption = 'Budget Dimension 2 Code';

            trigger OnLookup()
            begin
                // "Budget Dimension 2 Code" := OnLookupDimCode(3, "Budget Dimension 2 Code");
            end;

            trigger OnValidate()
            begin
                if "Budget Dimension 2 Code" = '' then
                    exit;
                if GLBudgetName.Name <> "Budget Name" then
                    GLBudgetName.Get("Budget Name");
                ValidateDimValue(GLBudgetName."Budget Dimension 2 Code", "Budget Dimension 2 Code");
            end;
        }
        field(19; "Budget Dimension 3 Code"; Code[20])
        {
            // CaptionClass = GetCaptionClass(3);
            Caption = 'Budget Dimension 3 Code';

            trigger OnLookup()
            begin
                // "Budget Dimension 3 Code" := OnLookupDimCode(4, "Budget Dimension 3 Code");
            end;

            trigger OnValidate()
            begin
                if "Budget Dimension 3 Code" = '' then
                    exit;
                if GLBudgetName.Name <> "Budget Name" then
                    GLBudgetName.Get("Budget Name");
                ValidateDimValue(GLBudgetName."Budget Dimension 3 Code", "Budget Dimension 3 Code");
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                // ;
            end;
        }
        field(50000; "FA Posting Type"; Option)
        {
            Caption = 'FA Posting Type';
            OptionCaption = ' ,Acquisition Cost,Maintenance';
            OptionMembers = " ","Acquisition Cost",Maintenance;

            trigger OnValidate()
            begin
                if "FA Posting Type" = "FA Posting Type"::" " then
                    "FA Posting Type" := "FA Posting Type"::"Acquisition Cost";
                GetFAPostingGroup;
                /*
                END ELSE BEGIN
                  "Depreciation Book Code" := '';
                  "FA Posting Date" := 0D;
                  "Salvage Value" := 0;
                  "Depr. until FA Posting Date" := FALSE;
                  "Depr. Acquisition Cost" := FALSE;
                  "Maintenance Code" := '';
                  "Insurance No." := '';
                  "Budgeted FA No." := '';
                  "Duplicate in Depreciation Book" := '';
                  "Use Duplication List" := FALSE;
                */

            end;
        }
        field(50001; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";

            trigger OnValidate()
            begin
                GetFAPostingGroup;
            end;
        }
        field(50002; "Transferred to budget"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Analysis Area", "Budget Name", "FA No.", "Source Type", "Source No.", Date, "Location Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Budget Dimension 1 Code", "Budget Dimension 2 Code", "Budget Dimension 3 Code")
        {
            SumIndexFields = "Cost Amount", "Sales Amount", Quantity;
        }
        key(Key3; "Analysis Area", "Budget Name", "Source Type", "Source No.", "FA No.", Date, "Location Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Budget Dimension 1 Code", "Budget Dimension 2 Code", "Budget Dimension 3 Code")
        {
            SumIndexFields = "Cost Amount", "Sales Amount", Quantity;
        }
        key(Key4; "Analysis Area", "Budget Name", "FA No.", Date)
        {
        }
        key(Key5; "Budget Name", "FA No.", Date)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        // CheckIfBlocked;
    end;

    trigger OnInsert()
    var
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
    begin
        // CheckIfBlocked;
        TestField(Date);

        // //GetGLSetup;

        TestField("Budget Name");
        TestField("FA No.");

        GLBudgetName.Get("Budget Name");

        LockTable;
        "User ID" := UserId;
        if "Entry No." = 0 then
            "Entry No." := GetNextEntryNo;

        // //GetGLSetup;
        DimMgt.GetDimensionSet(TempDimSetEntry, "Dimension Set ID");
        UpdateDimSet(TempDimSetEntry, GLSetup."Global Dimension 1 Code", "Global Dimension 1 Code");
        UpdateDimSet(TempDimSetEntry, GLSetup."Global Dimension 2 Code", "Global Dimension 2 Code");
        UpdateDimSet(TempDimSetEntry, GLBudgetName."Budget Dimension 1 Code", "Budget Dimension 1 Code");
        UpdateDimSet(TempDimSetEntry, GLBudgetName."Budget Dimension 2 Code", "Budget Dimension 2 Code");
        UpdateDimSet(TempDimSetEntry, GLBudgetName."Budget Dimension 3 Code", "Budget Dimension 3 Code");
        "Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);

        if Description = '' then begin
            FA.Get("FA No.");
            Description := FA.Description;
        end
    end;

    trigger OnModify()
    var
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
    begin


        DimMgt.GetDimensionSet(TempDimSetEntry, "Dimension Set ID");
        if "Global Dimension 1 Code" <> xRec."Global Dimension 1 Code" then
            UpdateDimSet(TempDimSetEntry, GLSetup."Global Dimension 1 Code", "Global Dimension 1 Code");
        if "Global Dimension 2 Code" <> xRec."Global Dimension 2 Code" then
            UpdateDimSet(TempDimSetEntry, GLSetup."Global Dimension 2 Code", "Global Dimension 2 Code");
        if "Budget Dimension 1 Code" <> xRec."Budget Dimension 1 Code" then
            UpdateDimSet(TempDimSetEntry, GLBudgetName."Budget Dimension 1 Code", "Budget Dimension 1 Code");
        if "Budget Dimension 2 Code" <> xRec."Budget Dimension 2 Code" then
            UpdateDimSet(TempDimSetEntry, GLBudgetName."Budget Dimension 2 Code", "Budget Dimension 2 Code");
        if "Budget Dimension 3 Code" <> xRec."Budget Dimension 3 Code" then
            UpdateDimSet(TempDimSetEntry, GLBudgetName."Budget Dimension 3 Code", "Budget Dimension 3 Code");
        "Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
    end;

    var
        Text000: Label 'The dimension value %1 has not been set up for dimension %2.';
        Text001: Label '1,5,,Budget Dimension 1 Code';
        Text002: Label '1,5,,Budget Dimension 2 Code';
        Text003: Label '1,5,,Budget Dimension 3 Code';
        GLBudgetName: Record "G/L Budget Name";
        GLSetup: Record "General Ledger Setup";
        InventorySetup: Record "Inventory Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        DimVal: Record "Dimension Value";
        DimMgt: Codeunit DimensionManagement;
        GLSetupRetrieved: Boolean;
        InventorySetupRetrieved: Boolean;
        SalesSetupRetrieved: Boolean;
        FA: Record "Fixed Asset";
        FABudget: Record "FA Budget Entry";

    // [Scope('OnPrem')]
    procedure CheckIfBlocked()
    begin
        if "Budget Name" = GLBudgetName.Name then
            exit;
        if GLBudgetName.Name <> "Budget Name" then
            GLBudgetName.Get("Budget Name");
        GLBudgetName.TestField(Blocked, false);
    end;

    local procedure ValidateDimValue(DimCode: Code[20]; var DimValueCode: Code[20]): Boolean
    var
        DimValue: Record "Dimension Value";
    begin
        DimValue."Dimension Code" := DimCode;
        DimValue.Code := DimValueCode;
        DimValue.Find('=><');
        if DimValueCode <> CopyStr(DimValue.Code, 1, StrLen(DimValueCode)) then
            Error(Text000, DimValueCode, DimCode);
        DimValueCode := DimValue.Code;
    end;

    // [Scope('OnPrem')]
    procedure GetGLSetup()
    begin
        if not GLSetupRetrieved then begin
            GLSetup.Get;
            GLSetupRetrieved := true;
        end;
    end;

    // [Scope('OnPrem')]
    procedure GetInventorySetup()
    begin
        if not InventorySetupRetrieved then begin
            InventorySetup.Get;
            InventorySetupRetrieved := true;
        end;
    end;

    // [Scope('OnPrem')]
    procedure GetSalesSetup()
    begin
        if not SalesSetupRetrieved then begin
            SalesSetup.Get;
            SalesSetupRetrieved := true;
        end;
    end;

    // [Scope('OnPrem')]
    procedure OnLookupDimCode(DimOption: Option "Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4"; DefaultValue: Code[20]): Code[20]
    var
        DimValue: Record "Dimension Value";
        DimValueList: Page "Dimension Value List";
    begin
        if DimOption in [DimOption::"Global Dimension 1", DimOption::"Global Dimension 2"] then
            Message('kelo')
        else
            if GLBudgetName.Name <> "Budget Name" then
                GLBudgetName.Get("Budget Name");
        case DimOption of
            DimOption::"Global Dimension 1":
                DimValue."Dimension Code" := GLSetup."Global Dimension 1 Code";
            DimOption::"Global Dimension 2":
                DimValue."Dimension Code" := GLSetup."Global Dimension 2 Code";
            DimOption::"Budget Dimension 1":
                DimValue."Dimension Code" := GLBudgetName."Budget Dimension 1 Code";
            DimOption::"Budget Dimension 2":
                DimValue."Dimension Code" := GLBudgetName."Budget Dimension 2 Code";
            DimOption::"Budget Dimension 3":
                DimValue."Dimension Code" := GLBudgetName."Budget Dimension 3 Code";
        end;
        DimValue.SetRange("Dimension Code", DimValue."Dimension Code");
        if DimValue.Get(DimValue."Dimension Code", DefaultValue) then;
        DimValueList.SetTableView(DimValue);
        DimValueList.SetRecord(DimValue);
        DimValueList.LookupMode := true;
        if DimValueList.RunModal = ACTION::LookupOK then begin
            DimValueList.GetRecord(DimValue);
            exit(DimValue.Code);
        end;
        exit(DefaultValue);
    end;

    local procedure GetNextEntryNo(): Integer
    var
        faBudgetEntry: Record "FA Budget Entry";
    begin
        faBudgetEntry.SetCurrentKey("Entry No.");
        if faBudgetEntry.FindLast then
            exit(faBudgetEntry."Entry No." + 1);

        exit(1);
    end;

    // [Scope('OnPrem')]
    procedure GetCaptionClass(BudgetDimType: Integer): Text[250]
    begin
        if (GLBudgetName.Name <> "Budget Name")
        then
            if not GLBudgetName.Get("Budget Name") then
                exit('');
        case BudgetDimType of
            1:
                begin
                    if GLBudgetName."Budget Dimension 1 Code" <> '' then
                        exit('1,5,' + GLBudgetName."Budget Dimension 1 Code");
                    exit(Text001);
                end;
            2:
                begin
                    if GLBudgetName."Budget Dimension 2 Code" <> '' then
                        exit('1,5,' + GLBudgetName."Budget Dimension 2 Code");
                    exit(Text002);
                end;
            3:
                begin
                    if GLBudgetName."Budget Dimension 3 Code" <> '' then
                        exit('1,5,' + GLBudgetName."Budget Dimension 3 Code");
                    exit(Text003);
                end;
        end;
    end;

    // [Scope('OnPrem')]
    procedure CheckGroupDimFilled(GroupDimCode: Code[20]): Boolean
    begin
        if GroupDimCode <> '' then
            case GroupDimCode of
                GLSetup."Global Dimension 1 Code":
                    exit("Global Dimension 1 Code" <> '');
                GLSetup."Global Dimension 2 Code":
                    exit("Global Dimension 2 Code" <> '');
                GLBudgetName."Budget Dimension 1 Code":
                    exit("Budget Dimension 1 Code" <> '');
                GLBudgetName."Budget Dimension 2 Code":
                    exit("Budget Dimension 1 Code" <> '');
                GLBudgetName."Budget Dimension 3 Code":
                    exit("Budget Dimension 1 Code" <> '');
            end;
    end;

    // [Scope('OnPrem')]
    procedure GetCaption(): Text[1024]
    var
        GLSetup: Record "General Ledger Setup";
        ItemBudgetName: Record "Item Budget Name";
        Cust: Record Customer;
        Vend: Record Vendor;
        Item: Record Item;
        Dimension: Record Dimension;
        DimValue: Record "Dimension Value";
        SourceTableCaption: Text[250];
        SourceFilter: Text[250];
        Description: Text[250];
    begin
        case true of
            GetFilter("Source No.") <> '':
                case "Source Type" of
                    "Source Type"::Customer:
                        begin
                            SourceTableCaption := Cust.TableCaption;
                            SourceFilter := GetFilter("Source No.");
                            if MaxStrLen(Cust."No.") >= StrLen(SourceFilter) then
                                if Cust.Get(SourceFilter) then
                                    Description := Cust.Name;
                        end;
                    "Source Type"::Vendor:
                        begin
                            SourceTableCaption := Vend.TableCaption;
                            SourceFilter := GetFilter("Source No.");
                            if MaxStrLen(Vend."No.") >= StrLen(SourceFilter) then
                                if Vend.Get(SourceFilter) then
                                    Description := Vend.Name;
                        end;
                end;
            GetFilter("FA No.") <> '':
                begin
                    SourceTableCaption := FA.TableCaption;
                    SourceFilter := GetFilter("FA No.");
                    if MaxStrLen(FA."No.") >= StrLen(SourceFilter) then
                        if FA.Get(SourceFilter) then
                            Description := FA.Description;
                end;
            GetFilter("Global Dimension 1 Code") <> '':
                begin
                    GLSetup.Get;
                    Dimension.Code := GLSetup."Global Dimension 1 Code";
                    SourceFilter := GetFilter("Global Dimension 1 Code");
                    SourceTableCaption := Dimension.GetMLName(GlobalLanguage);
                    if MaxStrLen(DimValue.Code) >= StrLen(SourceFilter) then
                        if DimValue.Get(GLSetup."Global Dimension 1 Code", SourceFilter) then
                            Description := DimValue.Name;
                end;
            GetFilter("Global Dimension 2 Code") <> '':
                begin
                    GLSetup.Get;
                    Dimension.Code := GLSetup."Global Dimension 2 Code";
                    SourceFilter := GetFilter("Global Dimension 2 Code");
                    SourceTableCaption := Dimension.GetMLName(GlobalLanguage);
                    if MaxStrLen(DimValue.Code) >= StrLen(SourceFilter) then
                        if DimValue.Get(GLSetup."Global Dimension 2 Code", SourceFilter) then
                            Description := DimValue.Name;
                end;
            GetFilter("Budget Dimension 1 Code") <> '':
                if GLBudgetName.Get("Budget Name") then begin
                    Dimension.Code := GLBudgetName."Budget Dimension 1 Code";
                    SourceFilter := GetFilter("Budget Dimension 1 Code");
                    SourceTableCaption := Dimension.GetMLName(GlobalLanguage);
                    if MaxStrLen(DimValue.Code) >= StrLen(SourceFilter) then
                        if DimValue.Get(GLBudgetName."Budget Dimension 1 Code", SourceFilter) then
                            Description := DimValue.Name;
                end;
            GetFilter("Budget Dimension 2 Code") <> '':
                if GLBudgetName.Get("Analysis Area", "Budget Name") then begin
                    Dimension.Code := GLBudgetName."Budget Dimension 2 Code";
                    SourceFilter := GetFilter("Budget Dimension 2 Code");
                    SourceTableCaption := Dimension.GetMLName(GlobalLanguage);
                    if MaxStrLen(DimValue.Code) >= StrLen(SourceFilter) then
                        if DimValue.Get(GLBudgetName."Budget Dimension 2 Code", SourceFilter) then
                            Description := DimValue.Name;
                end;
            GetFilter("Budget Dimension 3 Code") <> '':
                if GLBudgetName.Get("Budget Name") then begin
                    Dimension.Code := GLBudgetName."Budget Dimension 3 Code";
                    SourceFilter := GetFilter("Budget Dimension 3 Code");
                    SourceTableCaption := Dimension.GetMLName(GlobalLanguage);
                    if MaxStrLen(DimValue.Code) >= StrLen(SourceFilter) then
                        if DimValue.Get(GLBudgetName."Budget Dimension 3 Code", SourceFilter) then
                            Description := DimValue.Name;
                end;
        end;

        exit(
          DelChr(
            StrSubstNo('%1 %2 %3 %4', SourceTableCaption, SourceFilter, Description, "Budget Name"),
            '>'));
    end;

    // [Scope('OnPrem')]
    procedure ShowDimensions()
    var
        DimSetEntry: Record "Dimension Set Entry";
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 %3', "Budget Name", "FA No.", Date));

        if OldDimSetID = "Dimension Set ID" then
            exit;

        ////GetGLSetup;
        GLBudgetName.Get("Budget Name");

        "Global Dimension 1 Code" := '';
        "Global Dimension 2 Code" := '';
        "Budget Dimension 1 Code" := '';
        "Budget Dimension 2 Code" := '';
        "Budget Dimension 3 Code" := '';

        if DimSetEntry.Get("Dimension Set ID", GLSetup."Global Dimension 1 Code") then
            "Global Dimension 1 Code" := DimSetEntry."Dimension Value Code";
        if DimSetEntry.Get("Dimension Set ID", GLSetup."Global Dimension 2 Code") then
            "Global Dimension 2 Code" := DimSetEntry."Dimension Value Code";
        if DimSetEntry.Get("Dimension Set ID", GLBudgetName."Budget Dimension 1 Code") then
            "Budget Dimension 1 Code" := DimSetEntry."Dimension Value Code";
        if DimSetEntry.Get("Dimension Set ID", GLBudgetName."Budget Dimension 2 Code") then
            "Budget Dimension 2 Code" := DimSetEntry."Dimension Value Code";
        if DimSetEntry.Get("Dimension Set ID", GLBudgetName."Budget Dimension 3 Code") then
            "Budget Dimension 3 Code" := DimSetEntry."Dimension Value Code";
    end;

    local procedure UpdateDimSet(var TempDimSetEntry: Record "Dimension Set Entry" temporary; DimCode: Code[20]; DimValueCode: Code[20])
    begin
        if DimCode = '' then
            exit;
        if TempDimSetEntry.Get("Dimension Set ID", DimCode) then
            TempDimSetEntry.Delete;
        if DimValueCode <> '' then begin
            DimVal.Get(DimCode, DimValueCode);
            TempDimSetEntry.Init;
            TempDimSetEntry."Dimension Set ID" := "Dimension Set ID";
            TempDimSetEntry."Dimension Code" := DimCode;
            TempDimSetEntry."Dimension Value Code" := DimValueCode;
            TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
            TempDimSetEntry.Insert;
        end;
    end;

    local procedure GetFAPostingGroup()
    var
        LocalGLAcc: Record "G/L Account";
        FAPostingGr: Record "FA Posting Group";
        FASetup: Record "FA Setup";
        FADeprBook: Record "FA Depreciation Book";
    begin
        if ("FA No." = '') then
            exit;
        if "Depreciation Book Code" = '' then begin
            FASetup.Get;
            "Depreciation Book Code" := FASetup."Default Depr. Book";
            if not FADeprBook.Get("FA No.", "Depreciation Book Code") then
                "Depreciation Book Code" := '';
            if "Depreciation Book Code" = '' then
                exit;
        end;
        if "FA Posting Type" = "FA Posting Type"::" " then
            "FA Posting Type" := "FA Posting Type"::"Acquisition Cost";
        FADeprBook.Get("FA No.", "Depreciation Book Code");
        FADeprBook.TestField("FA Posting Group");
        FAPostingGr.Get(FADeprBook."FA Posting Group");
        if "FA Posting Type" = "FA Posting Type"::"Acquisition Cost" then begin
            FAPostingGr.TestField("Acquisition Cost Account");
            LocalGLAcc.Get(FAPostingGr."Acquisition Cost Account");
        end else begin
            FAPostingGr.TestField("Maintenance Expense Account");
            LocalGLAcc.Get(FAPostingGr."Maintenance Expense Account");
        end;
        LocalGLAcc.CheckGLAcc;
        //LocalGLAcc.TESTFIELD("Gen. Prod. Posting Group");
        //"Posting Group" := FADeprBook."FA Posting Group";
        //"Gen. Prod. Posting Group" := LocalGLAcc."Gen. Prod. Posting Group";
        //"Tax Group Code" := LocalGLAcc."Tax Group Code";
        //VALIDATE("VAT Prod. Posting Group",LocalGLAcc."VAT Prod. Posting Group");
    end;

    // [Scope('OnPrem')]
    procedure CheckIfTransferred()
    begin
        if "Transferred to budget" = true then
            Error('Can not modify records already tranferred to a budget line, please create another entry');
    end;
}

