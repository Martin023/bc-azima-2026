namespace MNS.MNS;

using Microsoft.Foundation.Attachment;

codeunit 52185426 "Document Attachment Events Sub"
{
    TableNo = "Document Attachment";

    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Page, Page::"Doc. Attachment List Factbox", OnBeforeDocumentAttachmentDetailsRunModal, '', false, false)]
    local procedure SepcifyCustomTableOnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        SuretyTable: Record "Surety Management";
        SecuritiesTable: Record "Securities Register";
        ContractsTable: Record "Contracts";
        FileRequests: Record "File Requests";
        FileTracker: Record "File Tracker";
        SecurityPerfection: Record "Security Perfection";
        AccidentsTable: Record "HR OSAccident";
        SecuritiesCollectionRegister: Record "Securities Collection Register";


    begin
        case
            DocumentAttachment."Table ID" of
            DATABASE::"Surety Management":
                begin
                    RecRef.Open(Database::"Surety Management");
                    if SuretyTable.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(SuretyTable);
                end;

            Database::"Securities Register":
                begin
                    RecRef.Open(Database::"Securities Register");
                    if SecuritiesTable.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(SecuritiesTable);
                end;
            Database::Contracts:
                begin
                    RecRef.Open(Database::Contracts);
                    if ContractsTable.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(ContractsTable);
                end;

            Database::"File Requests":
                begin
                    RecRef.Open(Database::"File Requests");
                    if FileRequests.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(FileRequests);
                end;

            Database::"File Tracker":
                begin
                    RecRef.Open(Database::"File Tracker");
                    if FileTracker.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(FileTracker);
                end;

            Database::"Security Perfection":
                begin
                    RecRef.Open(Database::"Security Perfection");
                    if SecurityPerfection.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(SecurityPerfection);
                end;
            Database::"HR OSAccident":
                begin
                    RecRef.Open(Database::"HR OSAccident");
                    if AccidentsTable.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(AccidentsTable);
                end;
            Database::"Securities Collection Register":
                begin
                    RecRef.Open(Database::"Securities Collection Register");
                    if SecuritiesCollectionRegister.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(SecuritiesCollectionRegister);
                end;
        end;

    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure SpecifyTheFieldAssociatedOnAfterOpenRecordForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        Fref: FieldRef;
        RecNo: Code[50];

    begin
        case
            RecRef.Number of
            Database::"Surety Management":
                begin
                    Fref := RecRef.Field(1);
                    RecNo := Fref.Value;
                    DocumentAttachment."Document Type" := DocumentAttachment."Document Type"::Surety;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;

            Database::"Securities Register":
                begin
                    Fref := RecRef.Field(1);
                    RecNo := Fref.Value;
                    DocumentAttachment."Document Type" := DocumentAttachment."Document Type"::Securities;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;

            Database::Contracts:
                begin
                    Fref := RecRef.Field(1);
                    RecNo := Fref.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment."Document Type" := DocumentAttachment."Document Type"::Contract;
                end;

            Database::"File Requests":
                begin
                    Fref := RecRef.Field(1);
                    RecNo := Fref.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment."Document Type" := DocumentAttachment."Document Type"::"File Document";
                end;

            Database::"File Tracker":
                begin
                    Fref := RecRef.Field(1);
                    RecNo := Fref.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment."Document Type" := DocumentAttachment."Document Type"::"File Tracking";
                end;

            Database::"Security Perfection":
                begin
                    Fref := RecRef.Field(1);
                    RecNo := Fref.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment."Document Type" := DocumentAttachment."Document Type"::Securities;
                end;
            Database::"HR OSAccident":
                begin
                    Fref := RecRef.Field(1);
                    RecNo := Fref.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment."Document Type" := DocumentAttachment."Document Type"::Accident;
                end;
            Database::"Securities Collection Register":
                BEGIN
                    Fref := RecRef.Field(1);
                    RecNo := Fref.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment."Document Type" := DocumentAttachment."Document Type"::Securities;
                END;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure UpdatePrimaryKeyOnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        Fref: FieldRef;
        RecNo: Code[50];

    begin
        if RecRef.Number = Database::"Surety Management" then begin
            Fref := RecRef.Field(1);
            RecNo := Fref.Value;
            DocumentAttachment.Validate("No.", RecNo);
        end;

        if RecRef.Number = Database::"Securities Register" then begin
            Fref := RecRef.Field(1);
            RecNo := Fref.Value;
            DocumentAttachment.Validate("No.", RecNo);
        end;

        if RecRef.Number = Database::Contracts then begin
            Fref := RecRef.Field(1);
            RecNo := Fref.Value;
            DocumentAttachment.Validate("No.", RecNo);
        end;

        if RecRef.Number = Database::"File Requests" then begin
            Fref := RecRef.Field(1);
            RecNo := Fref.Value;
            DocumentAttachment.Validate("No.", RecNo);
        end;

        if RecRef.Number = Database::"File Tracker" then begin
            Fref := RecRef.Field(1);
            RecNo := Fref.Value;
            DocumentAttachment.Validate("No.", RecNo);
        end;

        if RecRef.Number = Database::"Security Perfection" then begin
            Fref := RecRef.Field(1);
            RecNo := Fref.Value;
            DocumentAttachment.Validate("No.", RecNo);
        end;
        if RecRef.Number = Database::"HR OSAccident" then begin
            Fref := RecRef.Field(1);
            RecNo := Fref.Value;
            DocumentAttachment.Validate("No.", RecNo);
        end;
        if RecRef.Number = Database::"Securities Collection Register" then begin
            Fref := RecRef.Field(1);
            RecNo := Fref.Value;
            DocumentAttachment.Validate("No.", RecNo);
        end;
    end;
}
