#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187238 pageextension52187238 extends "Code Coverage Setup"
{
    layout
    {
        modify("<TimeInterval>")
        {
            ApplicationArea = Basic;
        }
        modify("<BackupPath>")
        {
            ApplicationArea = Basic;
        }
        modify("<SummaryPath>")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""<TimeInterval>"(Control 1001)".


        //Unsupported feature: Code Insertion on ""<BackupPath>"(Control 1002)".

        //trigger OnAssistEdit()
        //begin
        /*
        BackupPath := GetFolder;
        IF BackupPath = '' THEN
          ERROR(BackupPathErr);

        CodeCoverageMgt.UpdateAutomaticBackupSettings(TimeInterval,BackupPath,SummaryPath);
        MESSAGE(AppliedSettingsSuccesfullyMsg);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""<BackupPath>"(Control 1002)".



        //Unsupported feature: Code Insertion on ""<SummaryPath>"(Control 1)".

        //trigger OnAssistEdit()
        //begin
        /*
        SummaryPath := GetFolder;
        IF SummaryPath = '' THEN
          ERROR(SummaryPathErr);

        CodeCoverageMgt.UpdateAutomaticBackupSettings(TimeInterval,BackupPath,SummaryPath);
        MESSAGE(AppliedSettingsSuccesfullyMsg);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""<SummaryPath>"(Control 1)".

    }


    //Unsupported feature: Property Modification (TextConstString) on "TimeIntervalErr(Variable 1004)".

    //var
    //>>>> ORIGINAL VALUE:
    //TimeIntervalErr : ENU=The time interval must be greater than or equal to 10.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TimeIntervalErr : ENU=Time Interval must have a value greater than or equal to 10.;
    //Variable type has not been exported.

    //Unsupported feature: Property Deletion (Attributes) on "SetDefaultValues(PROCEDURE 2)".


    procedure GetFolder(): Text[1024]
    var
    //[RunOnClient]
    //FolderBrowserDialog: dotnet FolderBrowserDialog;
    begin
        // FolderBrowserDialog := FolderBrowserDialog.FolderBrowserDialog;
        // FolderBrowserDialog.ShowNewFolderButton(true);
        // FolderBrowserDialog.Description('Select Folder');
        // FolderBrowserDialog.ShowDialog;
        // if FolderBrowserDialog.SelectedPath <> '' then
        //   exit(FolderBrowserDialog.SelectedPath + '\')
    end;
}
