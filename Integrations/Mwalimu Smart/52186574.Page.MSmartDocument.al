page 52186574 "M-Smart Document"
{
    ApplicationArea = All;
    Caption = 'M-Smart Document';
    PageType = Card;
    SourceTable = "M-Smart Documents";

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    PromotedActionCategories = 'EDMS,,,Creation';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Landing Department"; Rec."Landing Department")
                {
                    ToolTip = 'Specifies the value of the Landing Department field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    ToolTip = 'Specifies the value of the Responsible Officer field.';
                }

                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ToolTip = 'Specifies the value of the Supervisor ID field.';
                }
                field("Last Updated By"; Rec."Last Updated By")
                {
                    ToolTip = 'Specifies the value of the Last Updated By field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("EDMS Integration")
            {
                action("Import")
                {
                    ApplicationArea = All;
                    Caption = 'Import File';
                    Promoted = true;
                    PromotedCategory = New;
                    Image = Import;

                    trigger OnAction()
                    var
                        Base64Convert: Codeunit "Base64 Convert";
                        TempBlob: Codeunit "Temp Blob";
                        InStr: InStream;

                        EDMSFunctions: Codeunit "EDMS Functions";
                        FileName: Text;
                        FileContentsB64: Text;

                        IDNumber: Text;
                        ApplicationType: Label 'MA'; // Member Application
                        PFNumber: Text;
                    begin
                        if Rec."No." <> '' then begin
                            FileName := EDMSFunctions.PickEDMSFile(TempBlob);

                            TempBlob.CreateInStream(InStr);
                            FileContentsB64 := Base64Convert.ToBase64(InStr);

                            if FileContentsB64 <> '' then begin
                                UploadToEDMS(Rec, FileName, FileContentsB64);
                            end;
                        end else begin
                            Error('Application No. is required for EDMS document upload');
                        end;
                    end;
                }
                action("EDMS File List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = New;

                    RunObject = page "EDMS Files List";
                    RunPageLink = "Application No." = field("No.");
                    // RunPageMode = Create;
                }
            }

            group("Application")
            {
                action("Initiate")
                {
                    ApplicationArea = All;
                    Caption = 'Initiate Document Application';
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Image = NewDocument;

                    Visible = Creatable;
                    Enabled = Creatable;

                    trigger OnAction()
                    var
                        theLoanApplication: Record Loans;
                        theMSmartMemberEdit: Record "M-Smart Member Edit";
                        MembNoSeries: Record "Credit Nos. Series";
                        // NoSeriesMgt: Codeunit NoSeriesManagement;
                        NoSeriesMgt: Codeunit "No. Series";
                    begin

                        case Rec."Document Type" of
                            Rec."Document Type"::"KARIBU LOAN APPLICATION FORM":
                                begin
                                    theLoanApplication.Reset;
                                    theLoanApplication.SetRange("Mwalimu Smart Document", Rec."No.");

                                    if theLoanApplication.FindFirst then begin
                                        Page.Run(Page::"Loan Application Card_FOSA", theLoanApplication);
                                    end else begin
                                        theLoanApplication.Init;

                                        theLoanApplication."Member No." := Rec."Member No.";
                                        theLoanApplication.Validate("Member No."); //

                                        theLoanApplication."Application Date" := DT2Date(Rec.SystemCreatedAt);
                                        theLoanApplication.Validate("Application Date");

                                        theLoanApplication."Mwalimu Smart Document" := Rec."No.";

                                        theLoanApplication."Source Aplication" := theLoanApplication."Source Aplication"::"Mwalimu Smart";
                                        theLoanApplication."Source Unit" := theLoanApplication."Source Unit"::FOSA;
                                        theLoanApplication."Source" := theLoanApplication.Source::CREDIT;
                                        theLoanApplication.Status := theLoanApplication.Status::Open;
                                        theLoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::FOSA);

                                        theLoanApplication."CRM Application No." := '';
                                        theLoanApplication."CRM Created By" := 'MWALIMU SMART';
                                        theLoanApplication."CRM Originating Branch" := 'ONLINE';
                                        theLoanApplication."CRM Notes" := '';
                                        theLoanApplication."Captured By" := 'MWALIMU SMART';

                                        MembNoSeries.Get;
                                        MembNoSeries.TestField(MembNoSeries."FOSA Loan Nos.");
                                        NoSeriesMgt.InitSeries(MembNoSeries."FOSA Loan Nos.", xRec."No. Series", 0D, theLoanApplication."Loan No.", theLoanApplication."No. Series");

                                        theLoanApplication.Insert();

                                        //------------------------------------------------------------------------------------------------------

                                        theLoanApplication.Reset;
                                        theLoanApplication.SetRange("Mwalimu Smart Document", Rec."No.");

                                        if theLoanApplication.FindFirst then begin
                                            Page.Run(Page::"Loan Application Card_FOSA", theLoanApplication);
                                        end
                                    end;
                                end;
                            Rec."Document Type"::"LOAN APPLICATION FORM":
                                begin
                                    theLoanApplication.Reset;
                                    theLoanApplication.SetRange("Mwalimu Smart Document", Rec."No.");

                                    if theLoanApplication.FindFirst then begin
                                        Page.Run(Page::"Loan Application Card_BOSA", theLoanApplication);
                                    end else begin
                                        theLoanApplication.Init;

                                        theLoanApplication."Member No." := Rec."Member No.";
                                        theLoanApplication.Validate("Member No."); //

                                        theLoanApplication."Application Date" := DT2Date(Rec.SystemCreatedAt);
                                        theLoanApplication.Validate("Application Date");

                                        theLoanApplication."Mwalimu Smart Document" := Rec."No.";

                                        theLoanApplication."Source Aplication" := theLoanApplication."Source Aplication"::"Mwalimu Smart";
                                        theLoanApplication."Source Unit" := theLoanApplication."Source Unit"::BOSA;
                                        theLoanApplication."Source" := theLoanApplication.Source::CREDIT;
                                        theLoanApplication.Status := theLoanApplication.Status::Open;
                                        theLoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BOSA);

                                        theLoanApplication."CRM Application No." := '';
                                        theLoanApplication."CRM Created By" := 'MWALIMU SMART';
                                        theLoanApplication."CRM Originating Branch" := 'ONLINE';
                                        theLoanApplication."CRM Notes" := '';
                                        theLoanApplication."Captured By" := 'MWALIMU SMART';

                                        MembNoSeries.Get;
                                        MembNoSeries.TestField(MembNoSeries."Loan Nos.");
                                        NoSeriesMgt.InitSeries(MembNoSeries."Loan Nos.", xRec."No. Series", 0D, theLoanApplication."Loan No.", theLoanApplication."No. Series");

                                        theLoanApplication.Insert();

                                        //------------------------------------------------------------------------------------------------------

                                        theLoanApplication.Reset;
                                        theLoanApplication.SetRange("Mwalimu Smart Document", Rec."No.");

                                        if theLoanApplication.FindFirst then begin
                                            Page.Run(Page::"Loan Application Card_BOSA", theLoanApplication);
                                        end
                                    end;
                                end;
                            Rec."Document Type"::"MEMBER DETAILS UPDATE FORM":
                                begin
                                    theMSmartMemberEdit.Reset;
                                    theMSmartMemberEdit.SetRange("Mwalimu Smart Document", Rec."No.");

                                    if theMSmartMemberEdit.FindFirst then begin
                                        Page.Run(Page::"M-Smart Member Edit", theMSmartMemberEdit);
                                    end else begin
                                        theMSmartMemberEdit.Init;

                                        theMSmartMemberEdit."Member No." := Rec."Member No.";
                                        theMSmartMemberEdit.Validate("Member No.");

                                        theMSmartMemberEdit."Type of Edit" := theMSmartMemberEdit."Type of Edit"::Biodata;
                                        theMSmartMemberEdit."Edit Information" := 'Mwalimu Smart Edit';
                                        theMSmartMemberEdit."Change Complete" := False;

                                        theMSmartMemberEdit.Status := theMSmartMemberEdit.Status::Open;

                                        theMSmartMemberEdit."Responsibility Center" := Format("Responsibility Center Enum"::RECORDS);
                                        theMSmartMemberEdit."Mwalimu Smart Document" := Rec."No.";

                                        theMSmartMemberEdit.Insert(true);

                                        //------------------------------------------------------------------------------------------------------

                                        theMSmartMemberEdit.Reset;
                                        theMSmartMemberEdit.SetRange("Mwalimu Smart Document", Rec."No.");

                                        if theMSmartMemberEdit.FindFirst then begin
                                            Page.Run(Page::"M-Smart Member Edit", theMSmartMemberEdit);
                                        end;
                                    end;
                                end;
                            Rec."Document Type"::"BBF NEXT OF KIN UPDATE FORM":
                                begin
                                    theMSmartMemberEdit.Reset;
                                    theMSmartMemberEdit.SetRange("Mwalimu Smart Document", Rec."No.");

                                    if theMSmartMemberEdit.FindFirst then begin
                                        Page.Run(Page::"M-Smart Member Edit", theMSmartMemberEdit);
                                    end else begin
                                        theMSmartMemberEdit.Init;

                                        theMSmartMemberEdit."Member No." := Rec."Member No.";
                                        theMSmartMemberEdit.Validate("Member No.");

                                        theMSmartMemberEdit."Type of Edit" := theMSmartMemberEdit."Type of Edit"::BBF;
                                        theMSmartMemberEdit."Edit Information" := 'Mwalimu Smart Edit';
                                        theMSmartMemberEdit."Change Complete" := False;

                                        theMSmartMemberEdit.Status := theMSmartMemberEdit.Status::Open;

                                        theMSmartMemberEdit."Responsibility Center" := Format("Responsibility Center Enum"::RECORDS);
                                        theMSmartMemberEdit."Mwalimu Smart Document" := Rec."No.";

                                        theMSmartMemberEdit.Insert(true);

                                        //------------------------------------------------------------------------------------------------------

                                        theMSmartMemberEdit.Reset;
                                        theMSmartMemberEdit.SetRange("Mwalimu Smart Document", Rec."No.");

                                        if theMSmartMemberEdit.FindFirst then begin
                                            Page.Run(Page::"M-Smart Member Edit", theMSmartMemberEdit);
                                        end
                                    end;
                                end;
                            Rec."Document Type"::"NOMINEE DECLARATION FORM":
                                begin
                                    theMSmartMemberEdit.Reset;
                                    theMSmartMemberEdit.SetRange("Mwalimu Smart Document", Rec."No.");

                                    if theMSmartMemberEdit.FindFirst then begin
                                        Page.Run(Page::"M-Smart Member Edit", theMSmartMemberEdit);
                                    end else begin
                                        theMSmartMemberEdit.Init;

                                        theMSmartMemberEdit."Member No." := Rec."Member No.";
                                        theMSmartMemberEdit.Validate("Member No.");

                                        theMSmartMemberEdit."Type of Edit" := theMSmartMemberEdit."Type of Edit"::Nominee;
                                        theMSmartMemberEdit."Edit Information" := 'Mwalimu Smart Edit';
                                        theMSmartMemberEdit."Change Complete" := False;

                                        theMSmartMemberEdit.Status := theMSmartMemberEdit.Status::Open;

                                        theMSmartMemberEdit."Responsibility Center" := Format("Responsibility Center Enum"::RECORDS);
                                        theMSmartMemberEdit."Mwalimu Smart Document" := Rec."No.";

                                        theMSmartMemberEdit.Insert(true);

                                        //------------------------------------------------------------------------------------------------------

                                        theMSmartMemberEdit.Reset;
                                        theMSmartMemberEdit.SetRange("Mwalimu Smart Document", Rec."No.");

                                        if theMSmartMemberEdit.FindFirst then begin
                                            Page.Run(Page::"M-Smart Member Edit", theMSmartMemberEdit);
                                        end
                                    end;
                                end;
                        end;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Creatable := false;

        if Rec.Status = Rec.Status::Open then begin
            Creatable := true;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        Creatable := false;

        if Rec.Status = Rec.Status::Open then begin
            Creatable := true;
        end;
    end;

    procedure UploadToEDMS(Rec: Record "M-Smart Documents"; FileName: Text; FileContentsB64: Text)
    var
        EDMSFunctions: Codeunit "EDMS Functions";

        ApplicantMember: Record Members;

        IDNumber: Text;
        ApplicationType: Label 'MSD'; // Mwalimu Smart Documents
        PFNumber: Text;
    begin
        ApplicantMember.Reset;

        ApplicantMember.SetRange("No.", Rec."Member No.");

        if ApplicantMember.FindFirst then begin
            if ApplicantMember."Primary Identification Type" = ApplicantMember."Primary Identification Type"::"ID Number" then begin
                IDNumber := ApplicantMember."Primary Identification";
            end else
                if ApplicantMember."Secondary Identification Type" = ApplicantMember."Secondary Identification Type"::"ID Number" then begin
                    IDNumber := ApplicantMember."Secondary Identification";
                end else begin
                    IDNumber := ApplicantMember."Primary Identification";
                end;

            if ApplicantMember."Payroll/Staff No." <> '' then begin
                PFNumber := ApplicantMember."Payroll/Staff No.";
            end else begin
                PFNumber := IDNumber;
            end;

            EDMSFunctions.EDMSMemberFileUpload(
                    IDNumber,
                    ApplicantMember.Name,
                    ApplicationType,
                    PfNumber,
                    ApplicantMember."No.",
                    Rec."No.",
                    FileName,
                    FileContentsB64
                );
        end;
    end;

    var
        GlobalFunctions: Codeunit "Global Functions";
        Creatable: Boolean;
}
