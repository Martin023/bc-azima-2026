namespace AZIMA.AZIMA;
using System.Text;

page 52186585 "Loan Appraisal form viewer"
{
    ApplicationArea = All;
    Caption = 'Loan Appraisal form viewer';
    PageType = Card;
    SourceTable = "Loan Appraisal History";
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
            field("Origination No."; Rec."Loan No")
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

            // action("EDMS Annotation")
            // {
            //     ApplicationArea = all;
            //     Image = DocumentEdit;
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     PromotedCategory = Category4;
            //     RunObject = Page "EDMS File Annotation";
            //     Caption = 'EDMS Annotation';
            //     RunPageLink = "Entry No." = field("Entry No.");
            //     Visible = CanAnnotate;
            // }
        }
    }

    trigger OnOpenPage()
    var
        InStr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        IsPDF := true;
        rec.calcfields("Appraisal form");
        if Rec."Appraisal form".HasValue then begin
            Message('Has value');
            Rec."Appraisal form".CreateInStream(InStr);
            FileData := Base64Convert.ToBase64(InStr); // proper binary → Base64
        end else
            FileData := '';
    end;


    trigger OnAfterGetCurrRecord()
    var
        InStr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        IsPDF := true;
        rec.calcfields("Appraisal form");
        if Rec."Appraisal form".HasValue then begin
            Message('Has value');
            Rec."Appraisal form".CreateInStream(InStr);
            FileData := Base64Convert.ToBase64(InStr); // proper binary → Base64
        end else
            FileData := '';
    end;

    var
        FileData: Text;
        IsImage: Boolean;
        IsPDF: Boolean;
        IsTIFF: Boolean;
        CanAnnotate: Boolean;
}

