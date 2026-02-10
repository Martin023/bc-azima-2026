#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 52187105 "CRM Coupling Resource"
{
    Caption = 'Microsoft Dynamics CRM Product Coupling';
    PageType = StandardDialog;
    SourceTable = Resource;

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
                    field("No."; Rec."No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Resource';
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
                    field("CRM Product ProductNumber"; CRMProduct.ProductNumber)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Product';
                        Enabled = not CreateNewInCRM;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            PreviouslySelectedCRMProduct: Record "CRM Product";
                            CRMProductList: Page "CRM Product List";
                        begin
                            CRMProductList.SetRecord(CRMProduct);
                            CRMProductList.LookupMode(true);
                            PreviouslySelectedCRMProduct := CRMProduct;

                            if CRMProductList.RunModal = Action::LookupOK then begin
                                CRMProductList.GetRecord(CRMProduct);
                                if PreviouslySelectedCRMProduct.ProductId <> CRMProduct.ProductId then
                                    HandleNewCRMProduct;
                            end;
                        end;

                        trigger OnValidate()
                        var
                            ManualCRMProduct: Record "CRM Product";
                            PreviouslySelectedCRMProduct: Record "CRM Product";
                            CRMProductFound: Boolean;
                        begin
                            PreviouslySelectedCRMProduct := CRMProduct;
                            ManualCRMProduct.SetRange(ProductNumber, CRMProduct.ProductNumber);

                            if ManualCRMProduct.FindFirst then
                                CRMProductFound := true
                            else begin
                                ManualCRMProduct.SetCurrentkey(ProductNumber);
                                ManualCRMProduct.SetFilter(ProductNumber, '%1', CRMProduct.ProductNumber + '*');
                                if ManualCRMProduct.FindFirst then
                                    CRMProductFound := true;
                            end;

                            if CRMProductFound then begin
                                CRMProduct := ManualCRMProduct;
                                if PreviouslySelectedCRMProduct.ProductId <> CRMProduct.ProductId then
                                    HandleNewCRMProduct;
                            end else
                                Error(StrSubstNo(NoSuchCRMRecordErr, CRMProduct.ProductNumber));
                        end;
                    }
                    field(CreateNewControl; CreateNewInCRM)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Create New Product';

                        trigger OnValidate()
                        begin
                            if CreateNewInCRM then begin
                                SavedCRMProduct := CRMProduct;
                                SavedSynchAction := SynchAction;
                                SynchAction := Synchaction::PushToCRM;
                                CRMProduct.Init;
                            end else begin
                                CRMProduct := SavedCRMProduct;
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
                    group("Dynamics NAV Resource")
                    {
                        Caption = 'Dynamics NAV Resource';
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Columns;
                        field("No.2"; Rec."No.")
                        {
                            ApplicationArea = Basic;
                            Caption = 'No.';
                        }
                        field(Name2; Rec.Name)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Name';
                        }
                        field("Unit Price"; Rec."Unit Price")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Unit Cost"; Rec."Unit Cost")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Direct Unit Cost"; Rec."Direct Unit Cost")
                        {
                            ApplicationArea = Basic;
                        }
                        field(PushToCRMControl; PushToCRM)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Use for Synchronization';
                        }
                    }
                    group("Dynamics CRM Product")
                    {
                        Caption = 'Dynamics CRM Product';
                        field("CRMProduct.ProductNumber"; CRMProduct.ProductNumber)
                        {
                            ApplicationArea = Basic;
                        }
                        field("CRMProduct.Name"; CRMProduct.Name)
                        {
                            ApplicationArea = Basic;
                        }
                        field("CRMProduct.Price"; CRMProduct.Price)
                        {
                            ApplicationArea = Basic;
                        }
                        field("CRMProduct.StandardCost"; CRMProduct.StandardCost)
                        {
                            ApplicationArea = Basic;
                        }
                        field("CRMProduct.CurrentCost"; CRMProduct.CurrentCost)
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
            CRMProduct.Get(CRMID);
            OriginalCRMProduct := CRMProduct;
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
        CRMProduct: Record "CRM Product";
        OriginalCRMProduct: Record "CRM Product";
        IntegrationTableMapping: Record "Integration Table Mapping";
        SavedCRMProduct: Record "CRM Product";
        CreateNewInCRM: Boolean;
        PushToCRM: Boolean;
        PushToNAV: Boolean;
        InitialSynchDisabledErr: label 'No initial synchronization direction was specified because initial synchronization was disabled.';
        NoSuchCRMRecordErr: label 'Product with ID %1 does not exist in Microsoft Dynamics CRM.', Comment = '%1 = The Product ID entered by the user';
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

    local procedure HandleNewCRMProduct()
    var
        CRMIntegrationRecord: Record "CRM Integration Record";
    begin
        if OriginalCRMProduct.ProductId <> CRMProduct.ProductId then
            CRMIntegrationRecord.AssertRecordIDCanBeCoupled(Rec.RecordId, CRMProduct.ProductId);
    end;


    procedure GetCRMID(): Guid
    begin
        exit(CRMProduct.ProductId);
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
