#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185507 "System Editss"
{
    trigger OnRun()
    begin
    end;

    procedure Setfilters(TableID: Integer; RecordID: Code[30]; CheckTableExists: Boolean; FilterValue: Text) Responce: Text
    var
        RecRef: RecordRef;
        ListOfIDs: List of [Integer];
    begin

        case TableID of
            database::"Investment Header":
                ListOfIDs.Add(1);

            database::Members:
                ListOfIDs.Add(1);

            database::"HR Jobs":
                ListOfIDs.Add(1);

            database::"HR Job Applications":
                ListOfIDs.Add(1);

            database::"HR Employees":
                ListOfIDs.Add(1);

            database::"HR Appraisal Header":
                ListOfIDs.Add(1);


            database::"Product Factory":
                ListOfIDs.Add(1);

            database::"Savings Accounts":
                ListOfIDs.Add(1);

            database::"Image Data":
                ListOfIDs.Add(4);

            database::"Present Users":
                ListOfIDs.Add(1);

            database::"User Tasks":
                ListOfIDs.Add(6);

            database::"Credit Accounts":
                ListOfIDs.Add(1);

            database::"Digit Custodian Setup":
                ListOfIDs.Add(1);

            database::Loans:
                ListOfIDs.Add(1);
            Database::"HR Setup":
                ListOfIDs.Add(1);

            Database::"Next of KIN":
                begin
                    ListOfIDs.Add(2);
                    ListOfIDs.Add(11);
                end;
            Database::"Securities Register":
                ListOfIDs.Add(1);
            Database::"Parking Space":
                ListOfIDs.Add(1);
            Database::Lease:
                ListOfIDs.Add(1);
            else
                if CheckTableExists then
                    Error('That object has not been set for edits\Please contact system your administrator')
                else
                    Responce := 'That object has not been set for edits\Please contact system your administrator';

        end;
        if not CheckTableExists then
            if ListOfIDs.Count > 0 then
                Responce := InsertFilters(TableID, RecordID, ListOfIDs, FilterValue);
    end;

    procedure SetFilterFields(TableID: Integer; RecordID: Code[30]; Action: Option Setfilter,PostChanges,AssignRecRef; var RecRef: RecordRef; NewRecordReference: RecordRef): Text
    var
        SystemEditsFilters: Record "System Edits Filters";
        FilterValues: List of [Text];
        IntegerFilter: Integer;
    begin
        SystemEditsFilters.Reset();
        SystemEditsFilters.SetRange("Record ID", RecordID);
        if SystemEditsFilters.FindFirst() then
            repeat
                FilterValues.Add(SystemEditsFilters.Filter);
            until SystemEditsFilters.Next() = 0;
        Clear(RecRef);

        case TableID of
            database::"Investment Header":
                begin
                    InvestHeader.Reset();
                    InvestHeader.SetRange("Investment No", FilterValues.Get(1));
                    if InvestHeader.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(InvestHeader);
                    end else
                        exit('Records not found\Try another filter value');
                end;
            database::Members:
                begin
                    Members.Reset();
                    Members.SetRange("No.", FilterValues.Get(1));
                    if Members.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(Members);
                    end else
                        exit('Records not found\Try another filter value');
                end;
            database::"HR Jobs":
                begin
                    HrJobs.Reset();
                    HrJobs.SetRange("Job ID", FilterValues.Get(1));
                    if HrJobs.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(HrJobs);
                    end else
                        exit('Records not found\Try another filter value');
                end;
            database::"Digit Custodian Setup":
                begin
                    Evaluate(IntegerFilter, FilterValues.Get(1));
                    DigitCustodian.Reset();
                    DigitCustodian.SetRange("Entry No.", IntegerFilter);
                    if DigitCustodian.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(DigitCustodian);
                    end else
                        exit('Records not found\Try another filter value');
                end;
            database::"HR Job Applications":
                begin
                    HrJobApplications.Reset();
                    HrJobApplications.SetRange("Job Application No.", FilterValues.Get(1));
                    if HrJobApplications.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(HrJobApplications);
                    end else
                        exit('Records not found\Try another filter value');
                end;
            database::"HR Employees":
                begin
                    HrEmployees.Reset();
                    HrEmployees.SetRange("No.", FilterValues.Get(1));
                    if HrEmployees.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(HrEmployees);
                    end else
                        exit('Records not found\Try another filter value');
                end;
            database::"HR Setup":
                begin
                    if HrSetup.get then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(HrSetup);
                    end else
                        exit('Records not found\Try another filter value');
                end;
            database::"HR Appraisal Header":
                begin
                    HrAppraisalHeader.Reset();
                    HrAppraisalHeader.SetRange("Appraisal No", FilterValues.Get(1));
                    if HrAppraisalHeader.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(HrAppraisalHeader);
                    end else
                        exit('Records not found\Try another filter value');
                end;

            database::"Savings Accounts":
                begin
                    SavingsAccounts.Reset();
                    SavingsAccounts.SetRange("No.", FilterValues.Get(1));
                    if SavingsAccounts.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(SavingsAccounts);
                    end else
                        exit('Records not found\Try another filter value');
                end;
            database::"Product Factory":
                begin
                    ProductFactory.Reset();
                    ProductFactory.SetRange("Product ID", FilterValues.Get(1));
                    if ProductFactory.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(ProductFactory);
                    end else
                        exit('Records not found\Try another filter value');
                end;
            database::Loans:
                begin
                    Loans.Reset();
                    Loans.SetRange("Loan No.", FilterValues.Get(1));
                    if Loans.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(Loans);
                    end else
                        exit('Records not found\Try another filter value');
                end;
            database::"Credit Accounts":
                begin
                    CreditAccounts.Reset();
                    CreditAccounts.SetRange(CreditAccounts."No.", FilterValues.Get(1));
                    if CreditAccounts.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(CreditAccounts);
                    end else
                        exit('Records not found\Try another filter value');
                end;
            database::"Image Data":
                begin
                    ImageData.Reset();
                    ImageData.SetRange("Member No", FilterValues.Get(1));
                    if ImageData.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(ImageData);
                    end else
                        exit('Records not found\Try another filter value');
                end;
            database::"User Tasks":
                begin
                    UserTasks.Reset();
                    UserTasks.SetRange(UserTasks."Record ID", FilterValues.Get(1));
                    if UserTasks.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(UserTasks);
                    end else
                        exit('Records not found\Try another filter value');
                end;
            database::"Present Users":
                begin

                    Evaluate(IntegerFilter, FilterValues.Get(1));
                    PresentUsers.Reset();
                    PresentUsers.SetRange("No.", IntegerFilter);
                    if PresentUsers.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(PresentUsers);
                    end else
                        exit('Records not found\Try another filter value');
                end;
            Database::"Securities Register":
                begin
                    SecuritiesRegister.Reset();
                    SecuritiesRegister.SetRange("No.", FilterValues.Get(1));
                    if SecuritiesRegister.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(SecuritiesRegister);
                    end else
                        exit('Records not found\Try another filter value');
                end;
            Database::"Parking Space":
                begin
                    ParkingSpace.Reset();
                    ParkingSpace.SetRange("No.", FilterValues.Get(1));
                    if ParkingSpace.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(ParkingSpace);
                    end else
                        exit('Records not found\Try another filter value');
                end;
            Database::Lease:
                begin
                    Lease.Reset();
                    Lease.SetRange("No.", FilterValues.Get(1));
                    if Lease.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(Lease);
                    end
                    else
                        exit('Records not found\Try another filter value');
                end;
            Database::"Motor Vehicle Request":
                begin
                    MotorVehicleRequest.Reset();
                    MotorVehicleRequest.SetRange("No.", FilterValues.Get(1));
                    if MotorVehicleRequest.FindFirst() then begin
                        RecRef.Open(TableID);
                        RecRef.Copy(MotorVehicleRequest);
                    end
                    else
                        exit('Records not found\Try another filter value');
                end;
            Database::"Next of KIN":
                begin
                    NextOfKin.Reset();
                    NextOfKin.SetRange("Record ID", FilterValues.Get(1));
                    NextOfKin.SetRange(Identification, FilterValues.Get(2));
                    if NextOfKin.FindFirst() then
                        RecRef.Copy(NextOfKin)
                    else
                        exit('Records not found\Try another filter value');
                end else
                        exit('That object has not been set for edits\Please contact system your administrator');
        end;

        if Action = Action::Setfilter then begin
            InsertFilterFields(RecRef, RecordID, NewRecordReference);
            exit('Table fields and data values have been fetched and set successfully');
        end;
        if Action = Action::PostChanges then begin
            PostChanges(RecRef, RecordID);
            exit('Changes have been effected sucessfully');
        end;
        if Action = Action::AssignRecRef then begin
            PostChangesLite(RecRef, RecordID);
            exit('Changes have been effected sucessfully');
        end;
    end;

    procedure AssignFieldRefValue(TableID: Integer; RecordID: Code[30]; FieldID: Integer): FieldRef
    var
        SystemEditsFilters: Record "System Edits Fields";
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
        RecRef.Open(TableID);
        FieldRef := RecRef.Field(FieldID);
        exit(FieldRef)
    end;

    local procedure InsertFilterFields(MyRecordRefrence: RecordRef; RecordID: Code[30]; NewRecordReference: RecordRef)
    var
        SystemFilterFields: Record "System Edits Fields";
        MyRecordFieldCount: Integer;
        i: Integer;
    begin
        SystemFilterFields.Reset();
        SystemFilterFields.SetRange("Record ID", RecordID);
        if SystemFilterFields.FindSet() then SystemFilterFields.DeleteAll();

        // MyRecordFieldCount := MyRecordRefrence.FieldCount;
        MyRecordFieldCount := 50000000;

        for i := 1 to MyRecordFieldCount do
            if MyRecordRefrence.FieldExist(i) then begin
                if (Format(MyRecordRefrence.Field(i).Type) <> 'BLOB') and (Format(MyRecordRefrence.Field(i).Type) <> 'GUID') then begin
                    SystemFilterFields.Init();
                    SystemFilterFields."Record ID" := RecordID;
                    SystemFilterFields."Field ID" := i;
                    SystemFilterFields."Field Name" := MyRecordRefrence.Field(i).Name;
                    SystemFilterFields."Field Type" := Format(MyRecordRefrence.Field(i).Type);
                    SystemFilterFields."Old Value" := MyRecordRefrence.Field(i).Value;
                    SystemFilterFields."New Value" := MyRecordRefrence.Field(i).Value;

                    IF NewRecordReference.FieldExist(i) then begin
                        // 0, 0 -> 0n
                        // 0, 1 -> 1n
                        // 1, 0 -> 1o
                        // 1, 1 -> 1n
                        IF not (Format(MyRecordRefrence.Field(i).Value).Trim() = '') then begin
                            IF not (Format(NewRecordReference.Field(i).Value).Trim() = '') then begin
                                SystemFilterFields."New Value" := NewRecordReference.Field(i).Value;
                                // SystemFilterFields.Validate("New Value");
                            end else begin
                                SystemFilterFields."New Value" := MyRecordRefrence.Field(i).Value;
                            end;
                        end else begin
                            SystemFilterFields."New Value" := NewRecordReference.Field(i).Value;
                            // SystemFilterFields.Validate("New Value");
                        end;

                        if (SystemFilterFields."Old Value" = '') and (SystemFilterFields."New Value" <> '') then begin
                            SystemFilterFields.Inserted := true;
                            SystemFilterFields.Modified := true;
                            SystemFilterFields."Generally Edited" := true;
                            SystemFilterFields.Deleted := false;
                        end;
                        if (SystemFilterFields."Old Value" <> '') and (SystemFilterFields."New Value" = '') then begin
                            SystemFilterFields.Inserted := false;
                            SystemFilterFields.Modified := true;
                            SystemFilterFields."Generally Edited" := true;
                            SystemFilterFields.Deleted := true;
                        end;
                        if (SystemFilterFields."Old Value" <> '') and (SystemFilterFields."New Value" <> '') and (SystemFilterFields."Old Value" <> SystemFilterFields."New Value") then begin
                            SystemFilterFields.Inserted := false;
                            SystemFilterFields.Modified := true;
                            SystemFilterFields."Generally Edited" := true;
                            SystemFilterFields.Deleted := false;
                        end;
                    end else begin
                        SystemFilterFields."New Value" := MyRecordRefrence.Field(i).Value;
                    end;

                    SystemFilterFields.Insert();
                end;

                if (Format(MyRecordRefrence.Field(i).Type) = 'BLOB') then begin
                    MyRecordRefrence.Field(i).CalcField();
                    // NewRecordReference.Field(i).CalcField();

                    SystemFilterFields.Init();
                    SystemFilterFields."Record ID" := RecordID;
                    SystemFilterFields."Field ID" := i;
                    SystemFilterFields."Field Name" := MyRecordRefrence.Field(i).Name;
                    SystemFilterFields."Field Type" := Format(MyRecordRefrence.Field(i).Type);
                    SystemFilterFields."Old Picture" := MyRecordRefrence.Field(i).Value;
                    SystemFilterFields."New Picture" := NewRecordReference.Field(i).Value;

                    if SystemFilterFields."New Picture".Length = 0 then begin
                        SystemFilterFields."New Picture" := SystemFilterFields."Old Picture";
                    end;

                    if (SystemFilterFields."Old Picture".Length = 0) and (SystemFilterFields."New Picture".Length <> 0) then begin
                        SystemFilterFields.Inserted := true;
                        SystemFilterFields.Modified := true;
                        SystemFilterFields."Generally Edited" := true;
                        SystemFilterFields.Deleted := false;
                    end;
                    if (SystemFilterFields."Old Picture".Length <> 0) and (SystemFilterFields."New Picture".Length = 0) then begin
                        SystemFilterFields.Inserted := false;
                        SystemFilterFields.Modified := true;
                        SystemFilterFields."Generally Edited" := true;
                        SystemFilterFields.Deleted := true;
                    end;
                    if (SystemFilterFields."Old Picture".Length <> 0) and (SystemFilterFields."New Picture".Length <> 0) and (SystemFilterFields."Old Picture".Length <> SystemFilterFields."New Picture".Length) then begin
                        SystemFilterFields.Inserted := false;
                        SystemFilterFields.Modified := true;
                        SystemFilterFields."Generally Edited" := true;
                        SystemFilterFields.Deleted := false;
                    end;

                    SystemFilterFields.Insert();
                end;
            end;

    end;

    local procedure PostChanges(MyRecordRefrence: RecordRef; RecordID: Code[30])
    Var
        SystemFilterFields: Record "System Edits Fields";
        MyRecordFieldCount: Integer;
        FieldID: Integer;
        FieldRef: FieldRef;
        SystemEditsFilter: Record "System Edits Filters";
        FilterValue: Text;
    begin
        SystemEditsFilters.Reset();
        SystemEditsFilters.SetRange("Record ID", RecordID);
        if SystemEditsFilters.FindFirst() then
            FilterValue := SystemEditsFilters.Filter;

        FieldID := 0;
        SystemEditsTable.Get(RecordID);
        SystemFilterFields.Reset();
        SystemFilterFields.SetRange("Record ID", RecordID);
        SystemFilterFields.SetRange("Generally Edited", true);
        SystemFilterFields.SetFilter("Field Type", '<>BLOB');
        if SystemFilterFields.FindFirst() then begin
            repeat
                FieldID := SystemFilterFields."Field ID";

                FieldRef := AssignFieldRefValue(SystemEditsTable."Table ID", RecordID, FieldID);
                ConfigValidateMgt.EvaluateTextToFieldRef(SystemFilterFields."New Value", FieldRef, false);

                OnBeforeSystemEditsPosting(SystemEditsTable."Table ID", FilterValue, FieldID, FieldRef);

                MyRecordRefrence.Field(FieldID).Value := FieldRef.Value;

            until SystemFilterFields.Next() = 0;
            MyRecordRefrence.Modify(true);
        end;
        SystemFilterFields.Reset();
        SystemFilterFields.SetRange("Record ID", RecordID);
        SystemFilterFields.SetRange("Field Type", 'BLOB');
        if SystemFilterFields.FindFirst() then begin
            repeat
                FieldID := SystemFilterFields."Field ID";

                SystemFilterFields.CalcFields("New Picture");
                MyRecordRefrence.Field(FieldID).Value := SystemFilterFields."New Picture";

            until SystemFilterFields.Next() = 0;
            MyRecordRefrence.Modify(true);
        end;
    end;


    local procedure PostChangesLite(MyRecordRefrence: RecordRef; RecordID: Code[30])
    Var
        SystemFilterFields: Record "System Edits Fields";
        MyRecordFieldCount: Integer;
        FieldID: Integer;
        FieldRef: FieldRef;
    begin
        FieldID := 0;
        SystemEditsTable.Get(RecordID);
        SystemFilterFields.Reset();
        SystemFilterFields.SetRange("Record ID", RecordID);
        SystemFilterFields.SetRange("Generally Edited", true);
        SystemFilterFields.SetFilter("Field Type", '<>BLOB');
        if SystemFilterFields.FindFirst() then begin
            repeat
                FieldID := SystemFilterFields."Field ID";

                FieldRef := AssignFieldRefValue(SystemEditsTable."Table ID", RecordID, FieldID);
                ConfigValidateMgt.EvaluateTextToFieldRef(SystemFilterFields."New Value", FieldRef, false);
                MyRecordRefrence.Field(FieldID).Value := FieldRef.Value;
            until SystemFilterFields.Next() = 0;
            // MyRecordRefrence.Modify(true);
        end;
        SystemFilterFields.Reset();
        SystemFilterFields.SetRange("Record ID", RecordID);
        SystemFilterFields.SetRange("Field Type", 'BLOB');
        if SystemFilterFields.FindFirst() then begin
            repeat
                FieldID := SystemFilterFields."Field ID";

                SystemFilterFields.CalcFields("New Picture");
                MyRecordRefrence.Field(FieldID).Value := SystemFilterFields."New Picture";

            until SystemFilterFields.Next() = 0;
            // MyRecordRefrence.Modify(true);
        end;
    end;



    local procedure InsertFilters(TableID: Integer; RecordID: Code[30]; ListOfIDs: List of [Integer]; FilterValue: Text): text
    var
        RecRef: RecordRef;
        i: Integer;
        EntryNo: Integer;
    begin

        SystemEditsFilters.Reset();
        SystemEditsFilters.SetRange("Record ID", RecordID);
        if SystemEditsFilters.FindSet() then SystemEditsFilters.DeleteAll();
        RecRef.Open(TableID);
        for i := 1 to ListOfIDs.Count do begin
            SystemEditsFilters.Init();
            SystemEditsFilters."Record ID" := RecordID;
            SystemEditsFilters."Field ID" := ListOfIDs.Get(i);
            SystemEditsFilters."Field Name" := RecRef.Field(ListOfIDs.Get(i)).Name;
            SystemEditsFilters.Filter := FilterValue;
            SystemEditsFilters.Insert();
        end;
        exit('Filters have successfully been set');
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeSystemEditsPosting(TableID: Integer; FilterValue: Text; FieldID: Integer; NewFieldRef: FieldRef)
    begin

    end;



    var
        Members: Record Members;
        NextOfKin: Record "Next of KIN";
        SystemEditsFilters: Record "System Edits Filters";
        SystemEditsFields: Record "System Edits Fields";
        SystemEditsTable: Record "System Edits";
        ConfigValidateMgt: Codeunit "Config. Validate Management";
        ProductFactory: Record "Product Factory";
        SavingsAccounts: Record "Savings Accounts";
        ImageData: Record "Image Data";
        PresentUsers: Record "Present Users";
        Loans: Record Loans;
        CreditAccounts: Record "Credit Accounts";
        InvestHeader: Record "Investment Header";
        HrJobs: record "HR Jobs";
        HrEmployees: Record "HR Employees";
        HrJobApplications: record "HR Job Applications";
        HrAppraisalHeader: record "HR Appraisal Header";
        FixedAssets: record "Fixed Asset";
        SecuritiesRegister: record "Securities Register";
        ParkingSpace: record "Parking Space";
        MotorVehicleRequest: record "Motor Vehicle Request";
        HrSetup: record "HR Setup";
        UserTasks: Record "User Tasks";
        Lease: Record Lease;
        DigitCustodian: Record "Digit Custodian Setup";

}
