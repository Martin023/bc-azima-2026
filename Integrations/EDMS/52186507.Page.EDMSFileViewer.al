page 52186507 "EDMS File Viewer"
{
    ApplicationArea = All;
    Caption = 'EDMS File Viewer';
    AboutTitle = 'EDMS File Viewer';
    PageType = Card;
    SourceTable = "EDMS Files";

    PromotedActionCategories = ',,,EDMS Actions';

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            // field("Document Link"; Rec."EDMS Document Link")
            // {
            //     ApplicationArea = All;
            //     Caption = 'EDMS Document Link';
            //     Editable = False;
            //     ExtendedDatatype = URL;
            // }
            field("Origination No."; Rec."Application No.")
            {
                ApplicationArea = All;
                Caption = 'Origination No.';
                Editable = False;
                // ExtendedDatatype = URL;
            }
            group(General)
            {
                ShowCaption = False;
                Visible = IsPDF;
                usercontrol(PDFViewer; "PDFV2 PDF Viewer")
                {
                    ApplicationArea = All;
                    trigger ControlAddinReady()
                    begin
                        CurrPage.PDFViewer.LoadPDF(FileData, false);
                    end;
                }
            }
            group(General2)
            {
                ShowCaption = False;
                Visible = IsImage;
                usercontrol(ImageViewer; "Image Viewer")
                {
                    ApplicationArea = All;
                    trigger ControlAddinReady()
                    begin
                        CurrPage.ImageViewer.LoadImage(FileData);
                    end;
                }
            }
            group(General3)
            {
                ShowCaption = False;
                Visible = IsTIFF;
                usercontrol(TIFViewer; "TIF Viewer")
                {
                    ApplicationArea = All;
                    trigger ControlAddinReady()
                    begin
                        CurrPage.TIFViewer.LoadTIF(FileData);
                    end;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {

            action("EDMS Annotation")
            {
                ApplicationArea = all;
                Image = DocumentEdit;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category4;
                RunObject = Page "EDMS File Annotation";
                Caption = 'EDMS Annotation';
                RunPageLink = "Entry No." = field("Entry No.");
                Visible = CanAnnotate;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        EDMSFunctions: Codeunit "EDMS Functions";
    begin
        IsImage := false;
        IsPDF := false;
        IsTIFF := false;

        case Rec."EDMS File Type" of
            Rec."EDMS File Type"::PDF:
                IsPDF := true;
            Rec."EDMS File Type"::TIF, Rec."EDMS File Type"::TIFF:
                IsTIFF := true;
            else
                IsImage := true;
        end;

        FileData := '';

        if Rec."EDMS Document ID" <> '' then begin
            FileData := EDMSFunctions.EDMSFileView(Rec."EDMS Document ID");
        end;

        if Rec."EDMS Data Class Name" = Rec."EDMS Data Class Name"::" " then begin
            CanAnnotate := false;
        end else begin
            CanAnnotate := true;
        end;
    end;

    var
        FileData: Text;
        IsImage: Boolean;
        IsPDF: Boolean;
        IsTIFF: Boolean;
        CanAnnotate: Boolean;
}
