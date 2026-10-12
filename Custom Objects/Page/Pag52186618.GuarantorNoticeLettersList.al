namespace AZIMA.AZIMA;
using System.Utilities;
using System.IO;

page 52186618 "Guarantor Notice Letters List"
{
    ApplicationArea = All;
    Caption = 'Guarantor Notice Letters List';
    PageType = List;
    SourceTable = "Guarantor Notice Letters";
    UsageCategory = Lists;
    cardpageid = "Defaulter Notice Letters Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan No"; Rec."Loan No")
                {
                    ToolTip = 'Specifies the value of the Loan No field.', Comment = '%';
                }
                field("Recipient Member No"; Rec."Recipient Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.', Comment = '%';
                }
                field(Recepient; Rec.Recepient)
                {
                    ToolTip = 'Specifies the value of the Recepient field.', Comment = '%';
                }
                field(Letter; Rec.Letter)
                {
                    ToolTip = 'Specifies the value of the Letter field.', Comment = '%';
                }
                field("Header No"; Rec."Header No")
                {
                    ToolTip = 'Specifies the value of the Header No field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Download)
            {
                ApplicationArea = All;
                Caption = 'Download';
                Image = Download;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Download the selected guarantor notice letter as PDF';

                trigger OnAction()
                var
                    InStr: InStream;
                    FileName: Text;
                begin
                    if not Rec.Letter.HasValue then
                        Error('No letter document found for Member %1, Loan %2.', Rec."Recipient Member No", Rec."Loan No");

                    Rec.CalcFields(Letter);  // Must load Blob data first!

                    FileName := Rec."Recipient Member No" + '-' + Rec."Loan No" + '.pdf';

                    Rec.Letter.CreateInStream(InStr);

                    DownloadFromStream(InStr, 'Download Letter', '', 'PDF Files (*.pdf)|*.pdf', FileName);
                end;
            }

            action(DownloadSelected)
            {
                ApplicationArea = All;
                Caption = 'Download Selected';
                Image = ExportFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Download selected guarantor notice letters as a ZIP file';

                trigger OnAction()
                var
                    SelectedRec: Record "Guarantor Notice Letters";
                    TempBlobFile: Codeunit "Temp Blob";
                    TempBlobZip: Codeunit "Temp Blob";
                    Zip: Codeunit "Data Compression";
                    BlobInS: InStream;
                    FileInS: InStream;
                    FileOutS: OutStream;
                    ZipInS: InStream;
                    ZipOutS: OutStream;
                    FileName: Text;
                    FileNameArchive: Text;
                    RecordCount: Integer;
                begin
                    CurrPage.SetSelectionFilter(SelectedRec);

                    if not SelectedRec.FindSet() then
                        Error('No records selected. Please select one or more records to download.');

                    Zip.CreateZipArchive();

                    repeat
                        if SelectedRec.Letter.HasValue then begin
                            SelectedRec.CalcFields(Letter);  // Must load Blob data first!
                            
                            FileName := SelectedRec."Recipient Member No" + '-' + SelectedRec."Loan No" + '.pdf';
                            
                            // Copy Blob to TempBlob first
                            Clear(TempBlobFile);
                            TempBlobFile.CreateOutStream(FileOutS);
                            SelectedRec.Letter.CreateInStream(BlobInS);
                            CopyStream(FileOutS, BlobInS);

                            // Now read from TempBlob and add to ZIP
                            TempBlobFile.CreateInStream(FileInS);
                            Zip.AddEntry(FileInS, FileName);

                            RecordCount += 1;
                        end;
                    until SelectedRec.Next() = 0;

                    if RecordCount = 0 then
                        Error('No letters found to download. All selected records have empty letter documents.');

                    // Save ZIP archive
                    TempBlobZip.CreateOutStream(ZipOutS);
                    Zip.SaveZipArchive(ZipOutS);
                    Zip.CloseZipArchive();

                    // Download ZIP
                    TempBlobZip.CreateInStream(ZipInS);
                    FileNameArchive := 'GuarantorNoticeLetters.zip';
                    DownloadFromStream(ZipInS, '', '', '', FileNameArchive);

                    Message('%1 letter(s) downloaded successfully in ZIP file.', RecordCount);
                end;
            }

            action(DownloadAll)
            {
                ApplicationArea = All;
                Caption = 'Download All';
                Image = ExportFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Download all guarantor notice letters as a ZIP file';

                trigger OnAction()
                var
                    GuarantorRec: Record "Guarantor Notice Letters";
                    TempBlobFile: Codeunit "Temp Blob";
                    TempBlobZip: Codeunit "Temp Blob";
                    Zip: Codeunit "Data Compression";
                    BlobInS: InStream;
                    FileInS: InStream;
                    FileOutS: OutStream;
                    ZipInS: InStream;
                    ZipOutS: OutStream;
                    FileName: Text;
                    FileNameArchive: Text;
                    RecordCount: Integer;
                begin
                    GuarantorRec.CopyFilters(Rec);  // Copy current page filters!

                    if not GuarantorRec.FindSet() then
                        Error('No records found to download.');

                    if not Confirm('This will download all %1 filtered records. Continue?', false, GuarantorRec.Count()) then
                        exit;

                    Zip.CreateZipArchive();

                    repeat
                        if GuarantorRec.Letter.HasValue then begin
                            GuarantorRec.CalcFields(Letter);  // Must load Blob data first!
                            
                            FileName := GuarantorRec."Recipient Member No" + '-' + GuarantorRec."Loan No" + '.pdf';
                            
                            // Copy Blob to TempBlob first
                            Clear(TempBlobFile);
                            TempBlobFile.CreateOutStream(FileOutS);
                            GuarantorRec.Letter.CreateInStream(BlobInS);
                            CopyStream(FileOutS, BlobInS);

                            // Now read from TempBlob and add to ZIP
                            TempBlobFile.CreateInStream(FileInS);
                            Zip.AddEntry(FileInS, FileName);

                            RecordCount += 1;
                        end;
                    until GuarantorRec.Next() = 0;

                    if RecordCount = 0 then
                        Error('No letters found to download. All records have empty letter documents.');

                    // Save ZIP archive
                    TempBlobZip.CreateOutStream(ZipOutS);
                    Zip.SaveZipArchive(ZipOutS);
                    Zip.CloseZipArchive();

                    // Download ZIP
                    TempBlobZip.CreateInStream(ZipInS);
                    FileNameArchive := 'GuarantorNoticeLetters_All.zip';
                    DownloadFromStream(ZipInS, '', '', '', FileNameArchive);

                    Message('%1 letter(s) downloaded successfully in ZIP file.', RecordCount);
                end;
            }
        }
    }
}
