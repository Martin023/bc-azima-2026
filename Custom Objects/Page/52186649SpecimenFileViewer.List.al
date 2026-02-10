page 52186649 "Specimen File Viewer"
{
    ApplicationArea = All;
    Caption = 'Specimen File Viewer';
    AboutTitle = 'Specimen File Viewer';
    PageType = Card;
    SourceTable = Customer;

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
            // field("Origination No."; Rec."Application No.")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Origination No.';
            //     Editable = False;
            //     // ExtendedDatatype = URL;
            // }
            group(General)
            {
                ShowCaption = False;
                usercontrol(PDFViewer; "PDFV2 PDF Viewer")
                {
                    ApplicationArea = All;
                    trigger ControlAddinReady()
                    begin
                        CurrPage.PDFViewer.LoadPDF(FileData, false);
                    end;
                }
            }


        }
    }

    trigger OnAfterGetCurrRecord()
    var
    begin
        FileData := RetrieveImage();
    end;

    procedure RetrieveImage(): Text
    var
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
    begin
        Rec.CalcFields("Signatory Specimen");
        TempBlob.FromRecord(Rec, Rec.FieldNo("Signatory Specimen"));
        TempBlob.CreateInStream(InStr);

        exit(Base64Convert.ToBase64(InStr));
    end;


    var
        FileData: Text;

}
