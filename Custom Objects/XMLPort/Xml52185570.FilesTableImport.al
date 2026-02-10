
xmlport 52185570 FilesTableImport
{
    Format = VariableText;
    Caption = 'FilesTableImport';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(FilesTable; "Files Table")
            {
                AutoReplace = false;
                AutoUpdate = true;
                fieldelement(No; FilesTable."No.")
                {
                    FieldValidate=no;
                }
                fieldelement(FileType; FilesTable."File Type")
                {
                    FieldValidate=no;
                }
                fieldelement(FileMemberNo; FilesTable."File/Member No.")
                {
                    FieldValidate=no;
                }
                fieldelement(FileNameDescrption; FilesTable."File Name/Descrption")
                {
                    FieldValidate=no;
                }
                fieldelement(FileCustodian; FilesTable."File Custodian")
                {
                    FieldValidate=no;
                }
                fieldelement(FileStatus; FilesTable."File Status")
                {
                    FieldValidate=no;
                }
                fieldelement(FileVolumeNo; FilesTable."File Volume No.")
                {
                    FieldValidate=no;
                }
                fieldelement(StaffPFNo; FilesTable."Staff PF No.")
                {
                    FieldValidate=no;
                }
                fieldelement(MemberName; FilesTable."Member Name")
                {
                    FieldValidate=no;
                }
            }
        }
    }
     trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Upload completed successfully');
    end;
}
