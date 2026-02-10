page 52186579 "EDMS Scanned Apps. API"
{
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'edmsScannedAppsAPI';
    DelayedInsert = true;
    EntityName = 'scannedApp';
    EntitySetName = 'scannedApps';
    PageType = API;
    SourceTable = "EDMS Scanned Apps. Log";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(applicationNo; Rec."Application No.")
                {
                    Caption = 'Application No.';
                }
                field(createdBy; Rec."Created By")
                {
                    Caption = 'Created By';
                }
                field(creationDate; Rec."Creation Date")
                {
                    Caption = 'Creation Date';
                }
                field(memberNo; Rec."Member No.")
                {
                    Caption = 'Member No.';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(originatingBranch; Rec."Originating Branch")
                {
                    Caption = 'Originating Branch';
                }
                field(scanned; Rec.Scanned)
                {
                    Caption = 'Scanned';
                }
                field(typeOfApplication; Rec."Type of Application")
                {
                    Caption = 'Type of Application';
                }
                field(status; theStatus)
                {
                    Caption = 'Status';
                }
                field(statusComment; '')
                {
                    Caption = '';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        theMApp: Record "Member Application";
        theCRMEdit: record "CRM Member Edit";
        theMWApp: record "Member withdrawal Notice";
        theBBFApp: record "SinkFund Report Information";
        theLnApp: record Loans;
        theLnGuarantSub: record "Guarantors Substitution";
        theVariation: record "Product Variations";
        theShareTrans: Record "Share Capital Transfer Buffer";
        theMBWApp: Record "M-Banking Whitelist App";
    begin

        case Rec."Type of Application" of
            Rec."Type of Application"::"Member Application", Rec."Type of Application"::"Member Readmission":
                begin
                    if theMApp.Get(Rec."Application No.") then begin
                        theStatus := theMApp.Status;
                    end;
                end;
            Rec."Type of Application"::"Member Edit":
                begin
                    if theCRMEdit.Get(Rec."Application No.") then begin
                        theStatus := theCRMEdit.Status;
                    end;
                end;
            Rec."Type of Application"::"Loan Application", Rec."Type of Application"::"Business Loans Application":
                begin
                    if theLnApp.Get(Rec."Application No.") then begin
                        theStatus := theLnApp.Status;
                    end;
                end;
            Rec."Type of Application"::"Loan Guarantor Substitution":
                begin
                    if theLnGuarantSub.Get(Rec."Application No.") then begin
                        theStatus := theLnGuarantSub.Status;
                    end;
                end;
            Rec."Type of Application"::"Member Withdrawal",
            Rec."Type of Application"::"Member Withdrawal - 1st Partial",
            Rec."Type of Application"::"Member Withdrawal - 2nd Partial":
                begin
                    if theMWApp.Get(Rec."Application No.") then begin
                        theStatus := theMWApp.Status;
                    end;
                end;
            Rec."Type of Application"::"BBF Claim",
            Rec."Type of Application"::"BBF Claim - Dependant",
            Rec."Type of Application"::"BBF Claim - Insurance",
            Rec."Type of Application"::"BBF Claim - Principle",
            Rec."Type of Application"::"BBF Claim - Risk":
                begin
                    if theBBFApp.Get(Rec."Application No.") then begin
                        theStatus := theBBFApp.Status;
                    end;
                end;
            Rec."Type of Application"::"Loan Variation":
                begin
                    if theVariation.Get(Rec."Application No.") then begin
                        theStatus := theVariation.Status;
                    end;
                end;
            Rec."Type of Application"::"Deposit Variation":
                begin
                    if theVariation.Get(Rec."Application No.") then begin
                        theStatus := theVariation.Status;
                    end;
                end;
            Rec."Type of Application"::"Share Transfer":
                begin
                    if theShareTrans.Get(Rec."Application No.") then begin
                        theStatus := theShareTrans.Status;
                    end;
                end;
            Rec."Type of Application"::"M-Hela Whitelist Application":
                begin
                    if theMBWApp.Get(Rec."Application No.") then begin
                        theStatus := theMBWApp.Status;
                    end;
                end;
            else
        end;

    end;

    var
        theStatus: enum "Workflow Status Main Flags";
}
