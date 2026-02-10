#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 52187110 "CRM Coupling Unit of Measure"
{
    Caption = 'Microsoft Dynamics CRM Unit Group Coupling';
    PageType = StandardDialog;
    SourceTable = "Unit of Measure";

    layout
    {
        area(content)
        {
            group(Coupling)
            {
                Caption = 'Coupling';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                group("Dynamics NAV")
                {
                    Caption = 'Dynamics NAV';
                    field("Code"; Rec.Code)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Unit of Measure';
                        Editable = false;
                    }
                    field(SynchActionControl; SynchAction)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Synchronize After Coupling';
                        Editable = not CreateNewInCRM;
                        Enabled = not CreateNewInCRM;
                        OptionCaption = 'No,Yes - Use the Dynamics NAV data';

                        trigger OnValidate()
                        begin
                            SetPushActionCheckboxes;
                        end;
                    }
                }
                group("Dynamics CRM")
                {
                    Caption = 'Dynamics CRM';
                    field("CRM Uomschedule Name"; CRMUomschedule.Name)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Unit Group';
                        Enabled = not CreateNewInCRM;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            PreviouslySelectedCRMUomschedule: Record "CRM Uomschedule";
                            CRMUnitGroupList: Page "CRM UnitGroup List";
                        begin
                            CRMUnitGroupList.SetRecord(CRMUomschedule);
                            CRMUnitGroupList.SetCurrentlyCoupledCRMUomschedule(OriginalCRMUomschedule);
                            CRMUnitGroupList.LookupMode(true);
                            PreviouslySelectedCRMUomschedule := CRMUomschedule;

                            if CRMUnitGroupList.RunModal = Action::LookupOK then begin
                                CRMUnitGroupList.GetRecord(CRMUomschedule);
                                if PreviouslySelectedCRMUomschedule.UoMScheduleId <> CRMUomschedule.UoMScheduleId then
                                    HandleNewCRMUomschedule;
                            end;
                        end;

                        trigger OnValidate()
                        var
                            ManualCRMUomschedule: Record "CRM Uomschedule";
                            PreviouslySelectedCRMUomschedule: Record "CRM Uomschedule";
                            CRMUomscheduleFound: Boolean;
                        begin
                            PreviouslySelectedCRMUomschedule := CRMUomschedule;
                            ManualCRMUomschedule.SetRange(Name, CRMUomschedule.Name);

                            if ManualCRMUomschedule.FindFirst then
                                CRMUomscheduleFound := true
                            else begin
                                ManualCRMUomschedule.SetCurrentkey(Name);
                                ManualCRMUomschedule.SetFilter(Name, '%1', CRMUomschedule.Name + '*');
                                if ManualCRMUomschedule.FindFirst then
                                    CRMUomscheduleFound := true;
                            end;

                            if CRMUomscheduleFound then begin
                                CRMUomschedule := ManualCRMUomschedule;
                                if PreviouslySelectedCRMUomschedule.UoMScheduleId <> CRMUomschedule.UoMScheduleId then
                                    HandleNewCRMUomschedule;
                            end else
                                Error(StrSubstNo(NoSuchCRMRecordErr, CRMUomschedule.Name));
                        end;
                    }
                    field(CreateNewControl; CreateNewInCRM)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Create New Unit Group';

                        trigger OnValidate()
                        begin
                            if CreateNewInCRM then begin
                                SavedCRMUomschedule := CRMUomschedule;
                                SavedSynchAction := SynchAction;
                                SynchAction := Synchaction::PushToCRM;
                                CRMUomschedule.Init;
                            end else begin
                                CRMUomschedule := SavedCRMUomschedule;
                                SynchAction := SavedSynchAction;
                            end;

                            SetPushActionCheckboxes;
                        end;
                    }
                }
            }
            group("Coupled Records")
            {
                Caption = 'Coupled Records';
                Editable = false;
                fixed(Control10)
                {
                    group("Dynamics NAV Unit of Measure")
                    {
                        Caption = 'Dynamics NAV Unit of Measure';
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Columns;
                        field(Code2; Rec.Code)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Code';
                        }
                        field(Description; Rec.Description)
                        {
                            ApplicationArea = Basic;
                        }
                        field("International Standard Code"; Rec."International Standard Code")
                        {
                            ApplicationArea = Basic;
                        }
                        field(PushToCRMControl; PushToCRM)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Use for Synchronization';
                        }
                    }
                    group("Dynamics CRM Unit Group")
                    {
                        Caption = 'Dynamics CRM Unit Group';
                        field("CRMUomschedule.Name"; CRMUomschedule.Name)
                        {
                            ApplicationArea = Basic;
                        }
                        field("CRMUomschedule.BaseUoMName"; CRMUomschedule.BaseUoMName)
                        {
                            ApplicationArea = Basic;
                        }
                        field("CRMUomschedule.StateCode"; CRMUomschedule.StateCode)
                        {
                            ApplicationArea = Basic;
                        }
                        field("CRMUomschedule.StatusCode"; CRMUomschedule.StatusCode)
                        {
                            ApplicationArea = Basic;
                        }
                        field(PushToNAVControl; PushToNAV)
                        {
                            ApplicationArea = Basic;
                        }
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        CRMIntegrationRecord: Record "CRM Integration Record";
        CRMID: Guid;
    begin
        if CRMIntegrationRecord.FindIDFromRecordID(Rec.RecordId, CRMID) then begin
            CRMUomschedule.Get(CRMID);
            OriginalCRMUomschedule := CRMUomschedule;
            SynchAction := Synchaction::DoNotSynch;
            SetPushActionCheckboxes;
        end;
    end;

    trigger OnInit()
    begin
        SynchAction := Synchaction::PushToCRM;
        SetPushActionCheckboxes;
    end;

    var
        CRMUomschedule: Record "CRM Uomschedule";
        OriginalCRMUomschedule: Record "CRM Uomschedule";
        IntegrationTableMapping: Record "Integration Table Mapping";
        SavedCRMUomschedule: Record "CRM Uomschedule";
        CreateNewInCRM: Boolean;
        PushToCRM: Boolean;
        PushToNAV: Boolean;
        InitialSynchDisabledErr: label 'No initial synchronization direction was specified because initial synchronization was disabled.';
        NoSuchCRMRecordErr: label 'Unit Group with name %1 does not exist in Microsoft Dynamics CRM.', Comment = '%1 = The Unit Group name entered by the user';
        SynchAction: Option DoNotSynch,PushToCRM;
        SavedSynchAction: Integer;

    local procedure SetPushActionCheckboxes()
    begin
        if SynchAction = Synchaction::DoNotSynch then begin
            PushToCRM := false;
            PushToNAV := false;
        end else begin
            PushToCRM := SynchAction = Synchaction::PushToCRM;
            PushToNAV := not PushToCRM;
        end
    end;

    local procedure HandleNewCRMUomschedule()
    var
        CRMIntegrationRecord: Record "CRM Integration Record";
    begin
        if OriginalCRMUomschedule.UoMScheduleId <> CRMUomschedule.UoMScheduleId then
            CRMIntegrationRecord.AssertRecordIDCanBeCoupled(Rec.RecordId, CRMUomschedule.UoMScheduleId);
    end;


    procedure GetCRMID(): Guid
    begin
        exit(CRMUomschedule.UoMScheduleId);
    end;


    procedure GetCreateNewInCRM(): Boolean
    begin
        exit(CreateNewInCRM);
    end;


    procedure GetPerformInitialSynchronization(): Boolean
    begin
        exit(SynchAction <> Synchaction::DoNotSynch);
    end;


    procedure GetInitialSynchronizationDirection(): Integer
    begin
        if SynchAction = Synchaction::DoNotSynch then
            Error(InitialSynchDisabledErr);

        exit(IntegrationTableMapping.Direction::ToIntegrationTable);
    end;
}
