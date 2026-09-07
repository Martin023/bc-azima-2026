namespace AZIMA.AZIMA;
using System.Text;

page 52186590 "Defaulter Notice Letters Card"
{
    ApplicationArea = All;
    Caption = 'Defaulter Notice Letters Card';
    PageType = Card;
    SourceTable = "Guarantor Notice Letters";
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
            field("Loan No"; Rec."Loan No")
            {
                ApplicationArea = All;
                Caption = 'Loan No.';
                Editable = False;
            }
            field("Recipient Member No"; Rec."Recipient Member No")
            {
                ApplicationArea = All;
                Caption = 'Recipient Member No.';
                Editable = False;
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

    }

    trigger OnOpenPage()
    var
        InStr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        IsPDF := true;
        rec.calcfields(Letter);
        if Rec.Letter.HasValue then begin
            //Message('Has value');
            Rec.Letter.CreateInStream(InStr);
            FileData := Base64Convert.ToBase64(InStr); // proper binary → Base64
        end else begin
            FileData := '';
            Message('The letter was not saved.')
        end;

    end;


    trigger OnAfterGetCurrRecord()
    var
        InStr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        IsPDF := true;
        rec.calcfields(Letter);
        if Rec.Letter.HasValue then begin
            //Message('Has value');
            Rec.Letter.CreateInStream(InStr);
            FileData := Base64Convert.ToBase64(InStr); // proper binary → Base64
        end else begin
            FileData := '';
            Message('The letter was not saved.')
        end;
    end;

    var
        FileData: Text;
        IsImage: Boolean;
        IsPDF: Boolean;
        IsTIFF: Boolean;
        CanAnnotate: Boolean;
}

