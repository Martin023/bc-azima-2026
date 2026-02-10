// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Codeunit 52185427 "Sky File Management"
// {

//     trigger OnRun()
//     begin
//     end;

//     var
//         Text001: label 'Default';
//         Text002: label 'You must enter a file path.';
//         Text003: label 'You must enter a file name.';
//         FileDoesNotExistErr: label 'The file %1 does not exist.', Comment = '%1 File Path';
//         Text006: label 'Export';
//         Text007: label 'Import';
//         PathHelper: code[100];//dotnet Path;
//         //[RunOnClient]
//         DirectoryHelper: code[100];//dotnet Directory;
//         //[RunOnClient]
//         ClientFileHelper: code[100];//dotnet File;
//         ServerFileHelper: code[100];//dotnet File;
//         ServerDirectoryHelper: code[100];//dotnet Directory;
//         Text010: label 'The file %1 has not been uploaded.';
//         Text011: label 'You must specify a source file name.';
//         Text012: label 'You must specify a target file name.';
//         Text013: label 'The file name %1 already exists.';
//         DirectoryDoesNotExistErr: label 'Directory %1 does not exist.', Comment = '%1=Directory user is trying to upload does not exist';
//         CreatePathQst: label 'The path %1 does not exist. Do you want to add it now?';
//         AllFilesFilterTxt: label '*.*', Locked = true;
//         AllFilesDescriptionTxt: label 'All Files (*.*)|*.*', Comment = '{Split=r''\|''}{Locked=s''1''}';
//         XMLFileType: label 'XML Files (*.xml)|*.xml', Comment = '{Split=r''\|''}{Locked=s''1''}';
//         WordFileType: label 'Word Files (*.doc)|*.doc', Comment = '{Split=r''\|''}{Locked=s''1''}';
//         Word2007FileType: label 'Word Files (*.docx;*.doc)|*.docx;*.doc', Comment = '{Split=r''\|''}{Locked=s''1''}';
//         ExcelFileType: label 'Excel Files (*.xls)|*.xls', Comment = '{Split=r''\|''}{Locked=s''1''}';
//         Excel2007FileType: label 'Excel Files (*.xlsx;*.xls)|*.xlsx;*.xls', Comment = '{Split=r''\|''}{Locked=s''1''}';
//         XSDFileType: label 'XSD Files (*.xsd)|*.xsd', Comment = '{Split=r''\|''}{Locked=s''1''}';
//         HTMFileType: label 'HTM Files (*.htm)|*.htm', Comment = '{Split=r''\|''}{Locked=s''1''}';
//         XSLTFileType: label 'XSLT Files (*.xslt)|*.xslt', Comment = '{Split=r''\|''}{Locked=s''1''}';
//         TXTFileType: label 'Text Files (*.txt)|*.txt', Comment = '{Split=r''\|''}{Locked=s''1''}';
//         RDLFileTypeTok: label 'SQL Report Builder (*.rdl;*.rdlc)|*.rdl;*.rdlc', Comment = '{Split=r''\|''}{Locked=s''1''}';
//         UnsupportedFileExtErr: label 'Unsupported file extension (.%1). The supported file extensions are (%2).';
//         SingleFilterErr: label 'Specify a file filter and an extension filter when using this function.';
//         InvalidWindowsChrStringTxt: label '"#%&*:<>?\/{|}~', Locked = true;
//         ZipArchive: code[100];//dotnet ZipArchive;
//         ZipArchiveMode: code[100];//dotnet ZipArchiveMode;
//         DownloadImageTxt: label 'Download image';
//         CanNotRunDotNetOnClientErr: label 'Sorry, this action is not available for the web-based versions of the app. You must use the Windows client.';
//         ChooseFileTitleMsg: label 'Choose the file to upload.';
//         NotAllowedPathErr: label 'Files outside of the current user''s folder cannot be accessed. Access is denied to file %1.', Comment = '%1=the full path to a file. ex: C:\Windows\TextFile.txt ';


//     procedure BLOBImport(var BLOBRef: Record SkyTempBlob temporary; Name: Text): Text
//     begin
//         exit(BLOBImportWithFilter(BLOBRef, Text007, Name, AllFilesDescriptionTxt, AllFilesFilterTxt));
//     end;


//     procedure BLOBImportWithFilter(var SkyTempBlob: Record SkyTempBlob; DialogCaption: Text; Name: Text; FileFilter: Text; ExtFilter: Text): Text
//     var
//         NVInStream: InStream;
//         NVOutStream: OutStream;
//         UploadResult: Boolean;
//         ErrorMessage: Text;
//     begin
//         // ExtFilter examples: 'csv,txt' if you only accept *.csv and *.txt or '*.*' if you accept any extensions
//         ClearLastError;

//         if (FileFilter = '') xor (ExtFilter = '') then
//             Error(SingleFilterErr);

//         // There is no way to check if NVInStream is null before using it after calling the
//         // UPLOADINTOSTREAM therefore if result is false this is the only way we can throw the error.
//         UploadResult := UploadIntoStream(DialogCaption, '', FileFilter, Name, NVInStream);
//         if UploadResult then
//             ValidateFileExtension(Name, ExtFilter);
//         if UploadResult then begin
//             SkyTempBlob.Blob.CreateOutstream(NVOutStream);
//             CopyStream(NVOutStream, NVInStream);
//             exit(Name);
//         end;
//         ErrorMessage := GetLastErrorText;
//         if ErrorMessage <> '' then
//             Error(ErrorMessage);

//         exit('');
//     end;

//     local procedure BLOBExportLocal(var InStream: InStream; Name: Text; IsCommonDialog: Boolean): Text
//     var
//         ToFile: Text;
//         Path: Text;
//         IsDownloaded: Boolean;
//     begin
//         if IsCommonDialog then begin
//             if StrPos(Name, '*') = 0 then
//                 ToFile := Name
//             else
//                 ToFile := DelChr(InsStr(Name, Text001, 1), '=', '*');
//             //Path := PathHelper.GetDirectoryName(ToFile);
//             ToFile := GetFileName(ToFile);
//         end else begin
//             ToFile := ClientTempFileName(GetExtension(Name));
//             Path := Magicpath;
//         end;
//         IsDownloaded := DownloadFromStream(InStream, Text006, Path, GetToFilterText('', Name), ToFile);
//         if IsDownloaded then
//             exit(ToFile);
//         exit('');
//     end;


//     procedure BLOBExportWithEncoding(var SkyTempBlob: Record SkyTempBlob temporary; Name: Text; CommonDialog: Boolean; Encoding: TextEncoding): Text
//     var
//         NVInStream: InStream;
//     begin
//         SkyTempBlob.Blob.CreateInstream(NVInStream, Encoding);
//         exit(BLOBExportLocal(NVInStream, Name, CommonDialog));
//     end;


//     procedure BLOBExport(var SkyTempBlob: Record SkyTempBlob temporary; Name: Text; CommonDialog: Boolean): Text
//     var
//         NVInStream: InStream;
//     begin
//         SkyTempBlob.Blob.CreateInstream(NVInStream);
//         exit(BLOBExportLocal(NVInStream, Name, CommonDialog));
//     end;


//     procedure ServerTempFileName(FileExtension: Text) FileName: Text
//     var
//         TempFile: File;
//     begin
//         TempFile.CreateTempfile;
//         FileName := CreateFileNameWithExtension(TempFile.Name, FileExtension);
//         TempFile.Close;
//     end;


//     procedure ClientTempFileName(FileExtension: Text) ClientFileName: Text
//     var
//         TempFile: File;
//         ClientTempPath: Text;
//     begin
//         // Returns the pseudo uniquely generated name of a non existing file in the client temp directory
//         TempFile.CreateTempfile;
//         ClientFileName := CreateFileNameWithExtension(TempFile.Name, FileExtension);
//         TempFile.Close;
//         TempFile.Create(ClientFileName);
//         TempFile.Close;
//         ClientTempPath := GetDirectoryName(DownloadTempFile(ClientFileName));
//         if Erase(ClientFileName) then;
//         ClientFileHelper.Delete(ClientTempPath + '\' + PathHelper.GetFileName(ClientFileName));
//         ClientFileName := CreateFileNameWithExtension(ClientTempPath + '\' + Format(CreateGuid), FileExtension);
//     end;


//     procedure CreateClientTempSubDirectory() ClientDirectory: Text
//     var
//         ServerFile: File;
//         ServerFileName: Text;
//     begin
//         // Creates a new subdirectory in the client's TEMP folder
//         ServerFile.Create(CreateGuid);
//         ServerFileName := ServerFile.Name;
//         ServerFile.Close;
//         ClientDirectory := GetDirectoryName(DownloadTempFile(ServerFileName));
//         if Erase(ServerFileName) then;
//         DeleteClientFile(CombinePath(ClientDirectory, GetFileName(ServerFileName)));
//         ClientDirectory := CombinePath(ClientDirectory, CreateGuid);
//         CreateClientDirectory(ClientDirectory);
//     end;


//     procedure DownloadTempFile(ServerFileName: Text): Text
//     var
//         FileName: Text;
//         Path: Text;
//     begin
//         FileName := ServerFileName;
//         Path := Magicpath;
//         Download(ServerFileName, '', Path, AllFilesDescriptionTxt, FileName);
//         exit(FileName);
//     end;


//     procedure UploadFileSilent(ClientFilePath: Text): Text
//     begin
//         exit(
//           UploadFileSilentToServerPath(ClientFilePath, ''));
//     end;


//     procedure UploadFileSilentToServerPath(ClientFilePath: Text; ServerFilePath: Text): Text
//     var
//         ClientFileAttributes: code[100];//dotnet FileAttributes;
//         ServerFileName: Text;
//         TempClientFile: Text;
//         FileName: Text;
//         FileExtension: Text;
//     begin
//         if not CanRunDotNetOnClient then
//             Error(CanNotRunDotNetOnClientErr);

//         if not ClientFileHelper.Exists(ClientFilePath) then
//             Error(FileDoesNotExistErr, ClientFilePath);
//         FileName := GetFileName(ClientFilePath);
//         FileExtension := GetExtension(FileName);

//         TempClientFile := ClientTempFileName(FileExtension);
//         ClientFileHelper.Copy(ClientFilePath, TempClientFile, true);

//         if ServerFilePath <> '' then
//             ServerFileName := ServerFilePath
//         else
//             ServerFileName := ServerTempFileName(FileExtension);

//         if not Upload('', Magicpath, AllFilesDescriptionTxt, GetFileName(TempClientFile), ServerFileName) then
//             Error(Text010, ClientFilePath);

//         ClientFileHelper.SetAttributes(TempClientFile, ClientFileAttributes.Normal);
//         ClientFileHelper.Delete(TempClientFile);
//         exit(ServerFileName);
//     end;


//     procedure UploadFileToServer(ClientFilePath: Text): Text
//     begin
//         if CanRunDotNetOnClient then
//             exit(UploadFileSilentToServerPath(ClientFilePath, ''));

//         exit(UploadFile(ChooseFileTitleMsg, ''));
//     end;


//     procedure UploadFile(WindowTitle: Text[50]; ClientFileName: Text) ServerFileName: Text
//     var
//         "Filter": Text;
//     begin
//         Filter := GetToFilterText('', ClientFileName);

//         if PathHelper.GetFileNameWithoutExtension(ClientFileName) = '' then
//             ClientFileName := '';

//         ServerFileName := UploadFileWithFilter(WindowTitle, ClientFileName, Filter, AllFilesFilterTxt);
//     end;


//     procedure UploadFileWithFilter(WindowTitle: Text[50]; ClientFileName: Text; FileFilter: Text; ExtFilter: Text) ServerFileName: Text
//     var
//         Uploaded: Boolean;
//     begin
//         ClearLastError;

//         if (FileFilter = '') xor (ExtFilter = '') then
//             Error(SingleFilterErr);

//         Uploaded := Upload(WindowTitle, '', FileFilter, ClientFileName, ServerFileName);
//         if Uploaded then
//             ValidateFileExtension(ClientFileName, ExtFilter);
//         if Uploaded then
//             exit(ServerFileName);

//         if GetLastErrorText <> '' then
//             Error('%1', GetLastErrorText);

//         exit('');
//     end;


//     procedure Magicpath(): Text
//     begin
//         exit('<TEMP>');   // MAGIC PATH makes sure we don't get a prompt
//     end;


//     procedure DownloadHandler(FromFile: Text; DialogTitle: Text; ToFolder: Text; ToFilter: Text; ToFile: Text): Boolean
//     var
//         Downloaded: Boolean;
//     begin
//         OnBeforeDownloadHandler(ToFolder, ToFile);

//         ClearLastError;
//         Downloaded := Download(FromFile, DialogTitle, ToFolder, ToFilter, ToFile);
//         if not Downloaded then
//             if GetLastErrorText <> '' then
//                 Error('%1', GetLastErrorText);
//         exit(Downloaded);
//     end;


//     procedure DownloadToFile(ServerFileName: Text; ClientFileName: Text)
//     var
//         TempClientFileName: Text;
//     begin
//         if CanRunDotNetOnClient then begin
//             ValidateFileNames(ServerFileName, ClientFileName);
//             TempClientFileName := DownloadTempFile(ServerFileName);
//             MoveFile(TempClientFileName, ClientFileName);
//         end else
//             DownloadHandler(ServerFileName, '', '', '', ClientFileName);
//     end;


//     procedure AppendAllTextToClientFile(ServerFileName: Text; ClientFileName: Text)
//     begin
//         ValidateFileNames(ServerFileName, ClientFileName);
//         IsAllowedPath(ServerFileName, false);
//         ClientFileHelper.AppendAllText(ClientFileName, ServerFileHelper.ReadAllText(ServerFileName));
//     end;


//     procedure MoveAndRenameClientFile(OldFilePath: Text; NewFileName: Text; NewSubDirectoryName: Text) NewFilePath: Text
//     var
//         directory: Text;
//     begin
//         if OldFilePath = '' then
//             Error(Text002);

//         if NewFileName = '' then
//             Error(Text003);

//         if not ClientFileHelper.Exists(OldFilePath) then
//             Error(FileDoesNotExistErr, OldFilePath);

//         // Get the directory from the OldFilePath, if directory is empty it will just use the current location.
//         directory := GetDirectoryName(OldFilePath);

//         // create the sub directory name is name is given
//         if NewSubDirectoryName <> '' then begin
//             directory := PathHelper.Combine(directory, NewSubDirectoryName);
//             DirectoryHelper.CreateDirectory(directory);
//         end;

//         NewFilePath := PathHelper.Combine(directory, NewFileName);
//         MoveFile(OldFilePath, NewFilePath);

//         exit(NewFilePath);
//     end;


//     procedure CreateClientFile(FilePathName: Text)
//     var
//         [RunOnClient]
//         StreamWriter: code[100];//dotnet StreamWriter;
//     begin
//         if not ClientFileHelper.Exists(FilePathName) then begin
//             StreamWriter := ClientFileHelper.CreateText(FilePathName);
//             StreamWriter.Close;
//         end;
//     end;


//     procedure DeleteClientFile(FilePath: Text): Boolean
//     begin
//         if not ClientFileHelper.Exists(FilePath) then
//             exit(false);

//         ClientFileHelper.Delete(FilePath);
//         exit(true);
//     end;


//     procedure CopyClientFile(SourceFileName: Text; DestFileName: Text; OverWrite: Boolean)
//     begin
//         ClientFileHelper.Copy(SourceFileName, DestFileName, OverWrite);
//     end;


//     procedure ClientFileExists(FilePath: Text): Boolean
//     begin
//         if not CanRunDotNetOnClient then
//             exit(false);
//         exit(ClientFileHelper.Exists(FilePath));
//     end;


//     procedure ClientDirectoryExists(DirectoryPath: Text): Boolean
//     begin
//         if not CanRunDotNetOnClient then
//             exit(false);
//         exit(DirectoryHelper.Exists(DirectoryPath));
//     end;


//     procedure CreateClientDirectory(DirectoryPath: Text)
//     begin
//         if not ClientDirectoryExists(DirectoryPath) then
//             DirectoryHelper.CreateDirectory(DirectoryPath);
//     end;


//     procedure DeleteClientDirectory(DirectoryPath: Text)
//     begin
//         if ClientDirectoryExists(DirectoryPath) then
//             DirectoryHelper.Delete(DirectoryPath, true);
//     end;


//     procedure UploadClientDirectorySilent(DirectoryPath: Text; FileExtensionFilter: Text; IncludeSubDirectories: Boolean) ServerDirectoryPath: Text
//     var
//         [RunOnClient]
//         SearchOption: code[100];//dotnet SearchOption;
//         [RunOnClient]
//         ArrayHelper: code[100];//dotnet Array;
//         [RunOnClient]
//         ClientFilePath: code[100];//dotnet String;
//         ServerFilePath: Text;
//         RelativeServerPath: Text;
//         i: Integer;
//         ArrayLength: Integer;
//     begin
//         if not ClientDirectoryExists(DirectoryPath) then
//             Error(DirectoryDoesNotExistErr, DirectoryPath);

//         if IncludeSubDirectories then
//             ArrayHelper := DirectoryHelper.GetFiles(DirectoryPath, FileExtensionFilter, SearchOption.AllDirectories)
//         else
//             ArrayHelper := DirectoryHelper.GetFiles(DirectoryPath, FileExtensionFilter, SearchOption.TopDirectoryOnly);

//         ArrayLength := ArrayHelper.GetLength(0);

//         if ArrayLength = 0 then
//             exit;

//         ServerDirectoryPath := ServerCreateTempSubDirectory;

//         for i := 1 to ArrayLength do begin
//             ClientFilePath := ArrayHelper.GetValue(i - 1);
//             RelativeServerPath := ClientFilePath.Replace(DirectoryPath, '');
//             if PathHelper.IsPathRooted(RelativeServerPath) then
//                 RelativeServerPath := DelChr(RelativeServerPath, '<', '\');
//             ServerFilePath := CombinePath(ServerDirectoryPath, RelativeServerPath);
//             ServerCreateDirectory(GetDirectoryName(ServerFilePath));
//             UploadFileSilentToServerPath(ClientFilePath, ServerFilePath);
//         end;
//     end;


//     procedure MoveFile(SourceFileName: Text; TargetFileName: Text)
//     begin
//         // System.IO.File.Move is not used due to a known issue in KB310316
//         if not ClientFileHelper.Exists(SourceFileName) then
//             Error(FileDoesNotExistErr, SourceFileName);

//         if UpperCase(SourceFileName) = UpperCase(TargetFileName) then
//             exit;

//         ValidateClientPath(GetDirectoryName(TargetFileName));

//         DeleteClientFile(TargetFileName);
//         ClientFileHelper.Copy(SourceFileName, TargetFileName);
//         ClientFileHelper.Delete(SourceFileName);
//     end;


//     procedure CopyServerFile(SourceFileName: Text; TargetFileName: Text; Overwrite: Boolean)
//     begin
//         IsAllowedPath(SourceFileName, false);
//         IsAllowedPath(TargetFileName, false);
//         ServerFileHelper.Copy(SourceFileName, TargetFileName, Overwrite);
//     end;


//     procedure ServerFileExists(FilePath: Text): Boolean
//     begin
//         exit(Exists(FilePath));
//     end;


//     procedure DeleteServerFile(FilePath: Text): Boolean
//     begin
//         IsAllowedPath(FilePath, false);
//         if not Exists(FilePath) then
//             exit(false);

//         ServerFileHelper.Delete(FilePath);
//         exit(true);
//     end;


//     procedure ServerDirectoryExists(DirectoryPath: Text): Boolean
//     begin
//         exit(ServerDirectoryHelper.Exists(DirectoryPath));
//     end;


//     procedure ServerCreateDirectory(DirectoryPath: Text)
//     begin
//         if not ServerDirectoryExists(DirectoryPath) then
//             ServerDirectoryHelper.CreateDirectory(DirectoryPath);
//     end;


//     procedure ServerCreateTempSubDirectory() DirectoryPath: Text
//     var
//         ServerTempFile: Text;
//     begin
//         ServerTempFile := ServerTempFileName('tmp');
//         DirectoryPath := CombinePath(GetDirectoryName(ServerTempFile), Format(CreateGuid));
//         ServerCreateDirectory(DirectoryPath);
//         DeleteServerFile(ServerTempFile);
//     end;


//     procedure ServerRemoveDirectory(DirectoryPath: Text; Recursive: Boolean)
//     begin
//         if ServerDirectoryExists(DirectoryPath) then
//             ServerDirectoryHelper.Delete(DirectoryPath, Recursive);
//     end;


//     procedure GetFileName(FilePath: Text): Text
//     begin
//         exit(PathHelper.GetFileName(FilePath));
//     end;


//     procedure GetSafeFileName(FileName: Text): Text
//     var
//         DotNetString: code[100];//dotnet String;
//         Result: Text;
//         Str: Text;
//     begin
//         DotNetString := FileName;
//         foreach Str in DotNetString.Split(PathHelper.GetInvalidFileNameChars) do
//             Result += Str;
//         exit(Result);
//     end;


//     procedure GetFileNameWithoutExtension(FilePath: Text): Text
//     begin
//         exit(PathHelper.GetFileNameWithoutExtension(FilePath));
//     end;


//     procedure HasExtension(FilePath: Text): Boolean
//     begin
//         exit(PathHelper.HasExtension(FilePath));
//     end;


//     procedure GetFileNameMimeType(FileName: Text): Text
//     var
//         MimeMapping: code[100];//dotnet MimeMapping;
//     begin
//         exit(MimeMapping.GetMimeMapping(FileName));
//     end;


//     procedure GetDirectoryName(FileName: Text): Text
//     begin
//         if FileName = '' then
//             exit(FileName);

//         FileName := DelChr(FileName, '<');
//         exit(PathHelper.GetDirectoryName(FileName));
//     end;


//     procedure GetClientDirectoryFilesList(var NameValueBuffer: Record "Name/Value Buffer"; DirectoryPath: Text)
//     var
//         [RunOnClient]
//         ArrayHelper: code[100];//dotnet Array;
//         i: Integer;
//     begin
//         NameValueBuffer.Reset;
//         NameValueBuffer.DeleteAll;

//         ArrayHelper := DirectoryHelper.GetFiles(DirectoryPath);
//         for i := 1 to ArrayHelper.GetLength(0) do begin
//             NameValueBuffer.ID := i;
//             Evaluate(NameValueBuffer.Name, ArrayHelper.GetValue(i - 1));
//             NameValueBuffer.Insert;
//         end;
//     end;


//     procedure GetServerDirectoryFilesList(var NameValueBuffer: Record "Name/Value Buffer"; DirectoryPath: Text)
//     var
//         ArrayHelper: code[100];//dotnet Array;
//         i: Integer;
//     begin
//         NameValueBuffer.Reset;
//         NameValueBuffer.DeleteAll;

//         ArrayHelper := ServerDirectoryHelper.GetFiles(DirectoryPath);
//         for i := 1 to ArrayHelper.GetLength(0) do begin
//             NameValueBuffer.ID := i;
//             Evaluate(NameValueBuffer.Name, ArrayHelper.GetValue(i - 1));
//             NameValueBuffer.Value := CopyStr(GetFileNameWithoutExtension(NameValueBuffer.Name), 1, 250);
//             NameValueBuffer.Insert;
//         end;
//     end;


//     procedure GetServerDirectoryFilesListInclSubDirs(var TempNameValueBuffer: Record "Name/Value Buffer" temporary; DirectoryPath: Text)
//     begin
//         TempNameValueBuffer.Reset;
//         TempNameValueBuffer.DeleteAll;

//         GetServerDirectoryFilesListInclSubDirsInner(TempNameValueBuffer, DirectoryPath);
//     end;

//     local procedure GetServerDirectoryFilesListInclSubDirsInner(var NameValueBuffer: Record "Name/Value Buffer"; DirectoryPath: Text)
//     var
//         ArrayHelper: code[100];//dotnet Array;
//         FileSystemEntry: Text;
//         Index: Integer;
//         LastId: Integer;
//     begin
//         ArrayHelper := ServerDirectoryHelper.GetFileSystemEntries(DirectoryPath);
//         for Index := 1 to ArrayHelper.GetLength(0) do begin
//             if NameValueBuffer.FindLast then
//                 LastId := NameValueBuffer.ID;
//             Evaluate(FileSystemEntry, ArrayHelper.GetValue(Index - 1));
//             if ServerDirectoryExists(FileSystemEntry) then
//                 GetServerDirectoryFilesListInclSubDirsInner(NameValueBuffer, FileSystemEntry)
//             else begin
//                 NameValueBuffer.ID := LastId + 1;
//                 NameValueBuffer.Name := CopyStr(FileSystemEntry, 1, 250);
//                 NameValueBuffer.Value := CopyStr(GetFileNameWithoutExtension(NameValueBuffer.Name), 1, 250);
//                 NameValueBuffer.Insert;
//             end;
//         end;
//     end;

//     [TryFunction]

//     procedure GetClientFileProperties(FullFileName: Text; var ModifyDate: Date; var ModifyTime: Time; var Size: BigInteger)
//     var
//         [RunOnClient]
//         FileInfo: code[100];//dotnet FileInfo;
//         ModifyDateTime: DateTime;
//     begin
//         ModifyDateTime := ClientFileHelper.GetLastWriteTime(FullFileName);
//         ModifyDate := Dt2Date(ModifyDateTime);
//         ModifyTime := Dt2Time(ModifyDateTime);
//         Size := FileInfo.FileInfo(FullFileName).Length;
//     end;

//     [TryFunction]

//     procedure GetServerFileProperties(FullFileName: Text; var ModifyDate: Date; var ModifyTime: Time; var Size: BigInteger)
//     var
//         FileInfo: code[100];//dotnet FileInfo;
//         ModifyDateTime: DateTime;
//     begin
//         ModifyDateTime := ServerDirectoryHelper.GetLastWriteTime(FullFileName);
//         ModifyDate := Dt2Date(ModifyDateTime);
//         ModifyTime := Dt2Time(ModifyDateTime);
//         Size := FileInfo.FileInfo(FullFileName).Length;
//     end;


//     procedure CombinePath(BasePath: Text; Suffix: Text): Text
//     begin
//         exit(PathHelper.Combine(BasePath, Suffix));
//     end;


//     procedure BLOBImportFromServerFile(var SkyTempBlob: Record "Sky SkyTempBlob"; FilePath: Text)
//     var
//         OutStream: OutStream;
//         InStream: InStream;
//         InputFile: File;
//     begin
//         IsAllowedPath(FilePath, false);

//         if not FILE.Exists(FilePath) then
//             Error(FileDoesNotExistErr, FilePath);

//         InputFile.Open(FilePath);
//         InputFile.CreateInstream(InStream);
//         SkyTempBlob.Blob.CreateOutstream(OutStream);
//         CopyStream(OutStream, InStream);
//         InputFile.Close;
//     end;


//     procedure BLOBExportToServerFile(var SkyTempBlob: Record "Sky SkyTempBlob"; FilePath: Text)
//     var
//         OutStream: OutStream;
//         InStream: InStream;
//         OutputFile: File;
//     begin
//         if FILE.Exists(FilePath) then
//             Error(Text013, FilePath);

//         OutputFile.WriteMode(true);
//         OutputFile.Create(FilePath);
//         OutputFile.CreateOutstream(OutStream);
//         SkyTempBlob.Blob.CreateInstream(InStream);
//         CopyStream(OutStream, InStream);
//         OutputFile.Close;
//     end;


//     procedure InstreamExportToServerFile(Instream: InStream; FileExt: Text) FileName: Text
//     var
//         OutStream: OutStream;
//         OutputFile: File;
//     begin
//         FileName := CopyStr(ServerTempFileName(FileExt), 1, 250);
//         OutputFile.WriteMode(true);
//         OutputFile.Create(FileName);
//         OutputFile.CreateOutstream(OutStream);
//         CopyStream(OutStream, Instream);
//         OutputFile.Close;
//     end;


//     procedure CreateAndWriteToServerFile(FileContent: Text; FileExt: Text) FileName: Text
//     var
//         File: File;
//         OutStream: OutStream;
//     begin
//         FileName := CopyStr(ServerTempFileName(FileExt), 1, 250);
//         File.Create(FileName);
//         File.CreateOutstream(OutStream);
//         OutStream.WriteText(FileContent);
//         File.Close;
//     end;


//     procedure GetToFilterText(FilterString: Text; FileName: Text): Text
//     var
//         OutExt: Text;
//     begin
//         if FilterString <> '' then
//             exit(FilterString);

//         case UpperCase(GetExtension(FileName)) of
//             'DOC':
//                 OutExt := WordFileType;
//             'DOCX':
//                 OutExt := Word2007FileType;
//             'XLS':
//                 OutExt := ExcelFileType;
//             'XLSX':
//                 OutExt := Excel2007FileType;
//             'XSLT':
//                 OutExt := XSLTFileType;
//             'XML':
//                 OutExt := XMLFileType;
//             'XSD':
//                 OutExt := XSDFileType;
//             'HTM':
//                 OutExt := HTMFileType;
//             'TXT':
//                 OutExt := TXTFileType;
//             'RDL':
//                 OutExt := RDLFileTypeTok;
//             'RDLC':
//                 OutExt := RDLFileTypeTok;
//         end;

//         OnAfterGetToFilterTextSetOutExt(FileName, OutExt);

//         if OutExt = '' then
//             exit(AllFilesDescriptionTxt);
//         exit(OutExt + '|' + AllFilesDescriptionTxt);  // Also give the option of the general selection
//     end;


//     procedure GetExtension(Name: Text): Text
//     var
//         FileExtension: Text;
//     begin
//         FileExtension := PathHelper.GetExtension(Name);

//         if FileExtension <> '' then
//             FileExtension := DelChr(FileExtension, '<', '.');

//         exit(FileExtension);
//     end;


//     procedure OpenFileDialog(WindowTitle: Text[50]; DefaultFileName: Text; FilterString: Text): Text
//     var
//         [RunOnClient]
//         OpenFileDialog: code[100];//dotnet OpenFileDialog;
//         [RunOnClient]
//         DialogResult: code[100];//dotnet DialogResult;
//     begin
//         if IsWebClient then
//             exit(UploadFile(WindowTitle, DefaultFileName));

//         OpenFileDialog := OpenFileDialog.OpenFileDialog;
//         OpenFileDialog.ShowReadOnly := false;
//         OpenFileDialog.FileName := GetFileName(DefaultFileName);
//         OpenFileDialog.Title := WindowTitle;
//         OpenFileDialog.Filter := GetToFilterText(FilterString, DefaultFileName);
//         OpenFileDialog.InitialDirectory := GetDirectoryName(DefaultFileName);

//         DialogResult := OpenFileDialog.ShowDialog;
//         if DialogResult.CompareTo(DialogResult.OK) = 0 then
//             exit(OpenFileDialog.FileName);
//         exit('');
//     end;


//     procedure SaveFileDialog(WindowTitle: Text[50]; DefaultFileName: Text; FilterString: Text): Text
//     var
//         [RunOnClient]
//         SaveFileDialog: code[100];//dotnet SaveFileDialog;
//         [RunOnClient]
//         DialogResult: code[100];//dotnet DialogResult;
//     begin
//         if IsWebClient then
//             exit('');
//         SaveFileDialog := SaveFileDialog.SaveFileDialog;
//         SaveFileDialog.CheckPathExists := true;
//         SaveFileDialog.OverwritePrompt := true;
//         SaveFileDialog.FileName := GetFileName(DefaultFileName);
//         SaveFileDialog.Title := WindowTitle;
//         SaveFileDialog.Filter := GetToFilterText(FilterString, DefaultFileName);
//         SaveFileDialog.InitialDirectory := GetDirectoryName(DefaultFileName);

//         DialogResult := SaveFileDialog.ShowDialog;
//         if DialogResult.CompareTo(DialogResult.OK) = 0 then
//             exit(SaveFileDialog.FileName);
//         exit('');
//     end;


//     procedure SelectFolderDialog(WindowTitle: Text; var SelectedFolder: Text): Boolean
//     var
//         [RunOnClient]
//         FolderBrowser: code[100];//dotnet FolderBrowserDialog;
//         [RunOnClient]
//         DialogResult: code[100];//dotnet DialogResult;
//     begin
//         FolderBrowser := FolderBrowser.FolderBrowserDialog;
//         FolderBrowser.ShowNewFolderButton := true;
//         FolderBrowser.Description := WindowTitle;

//         DialogResult := FolderBrowser.ShowDialog;
//         if DialogResult = 1 then begin
//             SelectedFolder := FolderBrowser.SelectedPath;
//             exit(true);
//         end;
//     end;


//     procedure CanRunDotNetOnClient(): Boolean
//     var
//         ClientTypeManagement: Codeunit 4;
//     begin
//         exit(ClientTypeManagement.IsWindowsClientType);
//     end;


//     procedure IsWebClient(): Boolean
//     var
//         ClientTypeManagement: Codeunit 4;
//     begin
//         exit(ClientTypeManagement.IsCommonWebClientType);
//     end;


//     procedure IsWindowsClient(): Boolean
//     var
//         ClientTypeManagement: Codeunit 4;
//     begin
//         exit(ClientTypeManagement.IsWindowsClientType);
//     end;


//     procedure IsValidFileName(FileName: Text): Boolean
//     var
//         String: code[100];//dotnet String;
//     begin
//         if FileName = '' then
//             exit(false);

//         String := GetFileName(FileName);
//         if String.IndexOfAny(PathHelper.GetInvalidFileNameChars) <> -1 then
//             exit(false);

//         String := GetDirectoryName(FileName);
//         if String.IndexOfAny(PathHelper.GetInvalidPathChars) <> -1 then
//             exit(false);

//         exit(true);
//     end;

//     local procedure ValidateFileNames(ServerFileName: Text; ClientFileName: Text)
//     begin
//         if not IsValidFileName(ServerFileName) then
//             Error(Text011);

//         if not IsValidFileName(ClientFileName) then
//             Error(Text012);
//     end;


//     procedure ValidateFileExtension(FilePath: Text; ValidExtensions: Text)
//     var
//         FileExt: Text;
//         LowerValidExts: Text;
//     begin
//         if StrPos(ValidExtensions, AllFilesFilterTxt) <> 0 then
//             exit;

//         FileExt := Lowercase(GetExtension(GetFileName(FilePath)));
//         LowerValidExts := Lowercase(ValidExtensions);

//         if StrPos(LowerValidExts, FileExt) = 0 then
//             Error(UnsupportedFileExtErr, FileExt, LowerValidExts);
//     end;

//     local procedure ValidateClientPath(FilePath: Text)
//     begin
//         if FilePath = '' then
//             exit;
//         if DirectoryHelper.Exists(FilePath) then
//             exit;

//         if Confirm(CreatePathQst, true, FilePath) then
//             DirectoryHelper.CreateDirectory(FilePath)
//         else
//             Error('');
//     end;

//     local procedure CreateFileNameWithExtension(FileNameWithoutExtension: Text; Extension: Text) FileName: Text
//     begin
//         FileName := FileNameWithoutExtension;
//         if Extension <> '' then begin
//             if Extension[1] <> '.' then
//                 FileName := FileName + '.';
//             FileName := FileName + Extension;
//         end
//     end;


//     procedure Ansi2SystemEncoding(Destination: OutStream; Source: InStream)
//     var
//         StreamReader: code[100];//dotnet StreamReader;
//         Encoding: code[100];//dotnet Encoding;
//         EncodedTxt: Text;
//     begin
//         StreamReader := StreamReader.StreamReader(Source, Encoding.Default, true);
//         EncodedTxt := StreamReader.ReadToEnd;
//         Destination.WriteText(EncodedTxt);
//     end;


//     procedure Ansi2SystemEncodingTxt(Destination: OutStream; Source: Text)
//     var
//         StreamWriter: code[100];//dotnet StreamWriter;
//         Encoding: code[100];//dotnet Encoding;
//     begin
//         StreamWriter := StreamWriter.StreamWriter(Destination, Encoding.Default);
//         StreamWriter.Write(Source);
//         StreamWriter.Close;
//     end;


//     procedure BrowseForFolderDialog(WindowTitle: Text[50]; DefaultFolderName: Text; ShowNewFolderButton: Boolean): Text
//     var
//         [RunOnClient]
//         FolderBrowserDialog: code[100];//dotnet FolderBrowserDialog;
//         [RunOnClient]
//         DialagResult: code[100];//dotnet DialogResult;
//     begin
//         FolderBrowserDialog := FolderBrowserDialog.FolderBrowserDialog;
//         FolderBrowserDialog.Description := WindowTitle;
//         FolderBrowserDialog.SelectedPath := DefaultFolderName;
//         FolderBrowserDialog.ShowNewFolderButton := ShowNewFolderButton;

//         DialagResult := FolderBrowserDialog.ShowDialog;
//         if DialagResult.CompareTo(DialagResult.OK) = 0 then
//             exit(FolderBrowserDialog.SelectedPath);
//         exit(DefaultFolderName);
//     end;


//     procedure StripNotsupportChrInFileName(InText: Text): Text
//     begin
//         exit(DelChr(InText, '=', InvalidWindowsChrStringTxt));
//     end;


//     procedure CreateZipArchiveObject() FilePath: Text
//     begin
//         FilePath := ServerTempFileName('zip');
//         OpenZipFile(FilePath);
//     end;


//     procedure OpenZipFile(ServerZipFilePath: Text)
//     var
//         Zipfile: code[100];//dotnet ZipFile;
//         ZipAchiveMode: code[100];//dotnet ZipArchiveMode;
//     begin
//         IsAllowedPath(ServerZipFilePath, false);
//         ZipArchive := Zipfile.Open(ServerZipFilePath, ZipAchiveMode.Create);
//     end;


//     procedure AddFileToZipArchive(SourceFileFullPath: Text; PathInZipFile: Text)
//     var
//         Zip: code[100];//dotnet ZipFileExtensions;
//     begin
//         IsAllowedPath(SourceFileFullPath, false);
//         Zip.CreateEntryFromFile(ZipArchive, SourceFileFullPath, PathInZipFile);
//     end;


//     procedure CloseZipArchive()
//     begin
//         if not IsNull(ZipArchive) then
//             ZipArchive.Dispose;
//     end;


//     procedure IsGZip(ServerSideFileName: Text): Boolean
//     var
//         FileStream: code[100];//dotnet FileStream;
//         FileMode: code[100];//dotnet FileMode;
//         ID: array[2] of Integer;
//     begin
//         IsAllowedPath(ServerSideFileName, false);

//         FileStream := FileStream.FileStream(ServerSideFileName, FileMode.Open);
//         ID[1] := FileStream.ReadByte;
//         ID[2] := FileStream.ReadByte;
//         FileStream.Close;

//         // from GZIP file format specification version 4.3
//         // Member header and trailer
//         // ID1 (IDentification 1)
//         // ID2 (IDentification 2)
//         // These have the fixed values ID1 = 31 (0x1f, \037), ID2 = 139 (0x8b, \213), to identify the file as being in gzip format.

//         exit((ID[1] = 31) and (ID[2] = 139));
//     end;

//     [TryFunction]

//     procedure ExtractZipFile(ZipFilePath: Text; DestinationFolder: Text)
//     var
//         Zip: code[100];//dotnet ZipFileExtensions;
//         ZipFile: code[100];//dotnet ZipFile;
//     begin
//         IsAllowedPath(ZipFilePath, false);

//         if not ServerFileHelper.Exists(ZipFilePath) then
//             Error(FileDoesNotExistErr, ZipFilePath);

//         // Create directory if it doesn't exist
//         ServerCreateDirectory(DestinationFolder);

//         ZipArchive := ZipFile.Open(ZipFilePath, ZipArchiveMode.Read);
//         Zip.ExtractToDirectory(ZipArchive, DestinationFolder);
//         CloseZipArchive;
//     end;


//     procedure ExtractZipFileAndGetFileList(ServerZipFilePath: Text; var NameValueBuffer: Record "Name/Value Buffer")
//     var
//         ServerDestinationFolder: Text;
//     begin
//         ServerDestinationFolder := ServerCreateTempSubDirectory;
//         ExtractZipFile(ServerZipFilePath, ServerDestinationFolder);
//         GetServerDirectoryFilesList(NameValueBuffer, ServerDestinationFolder);
//     end;


//     procedure ExportImage(ImagetPath: Text; ToFile: Text)
//     var
//         NameValueBuffer: Record "Name/Value Buffer";
//         TempNameValueBuffer: Record "Name/Value Buffer" temporary;
//         FileManagement: Codeunit "Sky File Management";
//     begin
//         NameValueBuffer.DeleteAll;
//         FileManagement.GetServerDirectoryFilesList(TempNameValueBuffer, TemporaryPath);
//         TempNameValueBuffer.SetFilter(Name, StrSubstNo('%1*', ImagetPath));
//         TempNameValueBuffer.FindFirst;
//         ToFile := StripNotsupportChrInFileName(ToFile);
//         Download(TempNameValueBuffer.Name, DownloadImageTxt, '', '', ToFile);
//         if FileManagement.DeleteServerFile(TempNameValueBuffer.Name) then;
//     end;


//     procedure IsClientDirectoryEmpty(Path: Text): Boolean
//     begin
//         if DirectoryHelper.Exists(Path) then
//             exit(DirectoryHelper.GetFiles(Path).Length = 0);
//         exit(false);
//     end;


//     procedure IsServerDirectoryEmpty(Path: Text): Boolean
//     begin
//         if ServerDirectoryHelper.Exists(Path) then
//             exit(ServerDirectoryHelper.GetFiles(Path).Length = 0);
//         exit(false);
//     end;


//     procedure IsWebOrDeviceClient(): Boolean
//     begin
//         exit(CurrentClientType in [Clienttype::Web, Clienttype::Phone, Clienttype::Tablet, Clienttype::Desktop]);
//     end;


//     procedure GetFileContent(FilePath: Text) Result: Text
//     var
//         FileHandle: File;
//         InStr: InStream;
//     begin
//         if not FILE.Exists(FilePath) then
//             exit;

//         FileHandle.Open(FilePath, Textencoding::UTF8);
//         FileHandle.CreateInstream(InStr);

//         InStr.ReadText(Result);
//     end;


//     procedure AddStreamToZipStream(ZipStream: OutStream; StreamToAdd: InStream; PathInArchive: Text)
//     var
//         ZipArchiveLocal: code[100];//dotnet ZipArchive;
//         ZipArchiveEntry: code[100];//dotnet ZipArchiveEntry;
//         StreamReader: code[100];//dotnet StreamReader;
//         StreamWriter: code[100];//dotnet StreamWriter;
//         Encoding: code[100];//dotnet Encoding;
//     begin
//         ZipArchiveLocal := ZipArchiveLocal.ZipArchive(ZipStream, ZipArchiveMode.Update, true);
//         ZipArchiveEntry := ZipArchiveLocal.CreateEntry(PathInArchive);
//         StreamReader := StreamReader.StreamReader(StreamToAdd, Encoding.Default);
//         StreamWriter := StreamWriter.StreamWriter(ZipArchiveEntry.Open, StreamReader.CurrentEncoding);
//         StreamWriter.Write(StreamReader.ReadToEnd);
//         StreamWriter.Close;
//         StreamReader.Close;
//     end;


//     procedure IsAllowedPath(Path: Text; SkipError: Boolean): Boolean
//     var
//         MembershipEntitlement: Record "Membership Entitlement";
//         WebRequestHelper: Codeunit "Web Request Helper";
//     begin
//         if not MembershipEntitlement.IsEmpty then
//             if not WebRequestHelper.IsHttpUrl(Path) then
//                 exit(true);
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterGetToFilterTextSetOutExt(FileName: Text; var OutExt: Text)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeDownloadHandler(var ToFolder: Text; ToFileName: Text)
//     begin
//     end;

