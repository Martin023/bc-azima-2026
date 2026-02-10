page 52187251 "Channel Application Document"
{
    ApplicationArea = All;
    Caption = 'Channel Application Document Card';
    PageType = Card;
    SourceTable = "Channel Application Documents";

    layout
    {
        area(Content)
        {
            field("Application No."; Rec."Application No.")
            {
                ApplicationArea = All;
                Caption = 'Application No.';
                Editable = False;
                ToolTip = 'Specifies the value of the Application No. field.', Comment = '%';
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

    trigger OnAfterGetCurrRecord()
    begin
        IsImage := false;
        IsPDF := false;
        IsTIFF := false;

        case Rec."Document Extension" of
            Rec."Document Extension"::PDF:
                IsPDF := true;
            Rec."Document Extension"::TIF, Rec."Document Extension"::TIFF:
                IsTIFF := true;
            else
                IsImage := true;
        end;

        FileData := '';

        Rec.CalcFields(Document);
        Rec.TestField(Document);

        TempBlob.FromRecord(Rec, Rec.FieldNo(Document));
        TempBlob.CreateInStream(InStr);

        FileData := Base64Convert.ToBase64(InStr);
    end;

    var
        FileData: Text;
        IsImage: Boolean;
        IsPDF: Boolean;
        IsTIFF: Boolean;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
}
