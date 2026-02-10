#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187064 pageextension52187064 extends "Profile Card"
{

    //Unsupported feature: Property Modification (SourceTable) on ""Profile Card"(Page 9170)".

    layout
    {
        // modify("Profile ID")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""Profile ID"(Control 2)".

        //     ApplicationArea = Basic;
        // }
        // modify(Description)
        // {

        //     //Unsupported feature: Property Modification (Level) on "Description(Control 8)".

        //     ApplicationArea = Basic;
        // }
        // modify("Role Center ID")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""Role Center ID"(Control 11)".

        //     ApplicationArea = Basic;
        // }
        // modify("Default Role Center")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""Default Role Center"(Control 4)".

        //     ApplicationArea = Basic;
        //     Editable = false;
        // }
        // modify("Disable Personalization")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""Disable Personalization"(Control 5)".

        //     ApplicationArea = Basic;
        // }
        // modify("Use Record Notes")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Record Notebook")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Use Page Notes")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Page Notebook")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (Editable) on "General(Control 1)".

        // modify(Control24)
        // {
        //     Visible = false;
        // }
        // modify(Scope)
        // {
        //     Visible = false;
        // }
        // modify("App Name")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Profile ID"(Control 2)".


        //Unsupported feature: Property Deletion (NotBlank) on ""Profile ID"(Control 2)".


        //Unsupported feature: Property Deletion (CaptionML) on "Description(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Role Center ID"(Control 11)".


        //Unsupported feature: Property Deletion (NotBlank) on ""Role Center ID"(Control 11)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Role Center ID"(Control 11)".


        //Unsupported feature: Code Modification on ""Default Role Center"(Control 4).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Profile ID");
        TESTFIELD("Role Center ID");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Profile ID");
        TESTFIELD("Role Center ID");

        ConfPersonalizationMgt.ChangeDefaultRoleCenter("Profile ID");
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Default Role Center"(Control 4)".


        //Unsupported feature: Property Deletion (Enabled) on ""Default Role Center"(Control 4)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Disable Personalization"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Disable Personalization"(Control 5)".


        //Unsupported feature: Property Deletion (Visible) on "OneNote(Control 3)".


        //Unsupported feature: Property Deletion (Enabled) on "OneNote(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Use Record Notes"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Record Notebook"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Use Page Notes"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Page Notebook"(Control 14)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        // modify(List)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Copy Profile")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("C&lear Configured Pages")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("E&xport Profiles")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Import Translated Profile Resources From Folder")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Visible) on ""Import Translated Profile Resources From Folder"(Action 18)".

        // }
        // modify("Import Translated Profile Resources From Zip File")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Export Translated Profile Resources")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Remove Translated Profile Resources")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "List(Action 17)".



        //Unsupported feature: Code Modification on ""Copy Profile"(Action 33).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Profile.SETRANGE("Profile ID","Profile ID");
        CopyProfile.SETTABLEVIEW(Profile);
        CopyProfile.RUNMODAL;

        IF GET(Profile.Scope,Profile."App ID",CopyProfile.GetProfileID) THEN;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        IF GET(CopyProfile.GetProfileID) THEN;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy Profile"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""C&lear Configured Pages"(Action 23)".


        //Unsupported feature: Property Deletion (Visible) on ""C&lear Configured Pages"(Action 23)".


        //Unsupported feature: Property Deletion (Enabled) on ""C&lear Configured Pages"(Action 23)".



        //Unsupported feature: Code Modification on ""E&xport Profiles"(Action 22).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Profile.SETRANGE("Profile ID","Profile ID");
        REPORT.RUN(REPORT::"Export Profiles",TRUE,FALSE,Profile);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        Profile.SETRANGE("Profile ID","Profile ID");
        ExportProfiles.SETTABLEVIEW(Profile);
        ExportProfiles.RUNMODAL;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xport Profiles"(Action 22)".


        //Unsupported feature: Property Deletion (Visible) on ""E&xport Profiles"(Action 22)".


        //Unsupported feature: Property Deletion (Enabled) on ""E&xport Profiles"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Import Translated Profile Resources From Folder"(Action 18)".


        //Unsupported feature: Property Deletion (Enabled) on ""Import Translated Profile Resources From Folder"(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Import Translated Profile Resources From Zip File"(Action 16)".


        //Unsupported feature: Property Deletion (Visible) on ""Import Translated Profile Resources From Zip File"(Action 16)".


        //Unsupported feature: Property Deletion (Enabled) on ""Import Translated Profile Resources From Zip File"(Action 16)".



        //Unsupported feature: Code Modification on ""Export Translated Profile Resources"(Action 15).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Profile.SETRANGE("Profile ID","Profile ID");
        Profile.SETRANGE(Scope,Profile.Scope::System);
        ConfPersonalizationMgt.ExportTranslatedResourcesWithFolderSelection(Profile);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        Profile.SETRANGE("Profile ID","Profile ID");
        ConfPersonalizationMgt.ExportTranslatedResourcesWithFolderSelection(Profile);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Export Translated Profile Resources"(Action 15)".


        //Unsupported feature: Property Deletion (Visible) on ""Export Translated Profile Resources"(Action 15)".


        //Unsupported feature: Property Deletion (Enabled) on ""Export Translated Profile Resources"(Action 15)".



        //Unsupported feature: Code Modification on ""Remove Translated Profile Resources"(Action 6).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(Profile);
        Profile.SETRANGE(Scope,Profile.Scope::System);
        ConfPersonalizationMgt.RemoveTranslatedResourcesWithLanguageSelection(Profile);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(Profile);
        ConfPersonalizationMgt.RemoveTranslatedResourcesWithLanguageSelection(Profile);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Remove Translated Profile Resources"(Action 6)".


        //Unsupported feature: Property Deletion (Visible) on ""Remove Translated Profile Resources"(Action 6)".


        //Unsupported feature: Property Deletion (Enabled) on ""Remove Translated Profile Resources"(Action 6)".

    }


    //Unsupported feature: Property Modification (Subtype) on ""Copy Profile"(Action 33).OnAction.Profile(Variable 1035)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Copy Profile" : "All Profile";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Copy Profile" : Profile;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Subtype) on ""E&xport Profiles"(Action 22).OnAction.Profile(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //"E&xport Profiles" : "All Profile";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"E&xport Profiles" : Profile;
    //Variable type has not been exported.

    var
        //ExportProfiles: Report 9171;


    //Unsupported feature: Property Modification (Subtype) on ""Import Translated Profile Resources From Folder"(Action 18).OnAction.Profile(Variable 1002)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Import Translated Profile Resources From Folder" : "All Profile";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Import Translated Profile Resources From Folder" : Profile;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Subtype) on ""Import Translated Profile Resources From Zip File"(Action 16).OnAction.Profile(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Import Translated Profile Resources From Zip File" : "All Profile";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Import Translated Profile Resources From Zip File" : Profile;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Subtype) on ""Export Translated Profile Resources"(Action 15).OnAction.Profile(Variable 1002)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Export Translated Profile Resources" : "All Profile";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Export Translated Profile Resources" : Profile;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Subtype) on ""Remove Translated Profile Resources"(Action 6).OnAction.Profile(Variable 1002)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Remove Translated Profile Resources" : "All Profile";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Remove Translated Profile Resources" : Profile;
    //Variable type has not been exported.

    var
        UserSetup: Record "User Setup";


    //Unsupported feature: Code Insertion on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //begin
    /*
    {UserSetup.GET(USERID);
    IF UserSetup.FINDFIRST THEN BEGIN
      IF UserSetup.Admin=FALSE THEN
        ERROR('You do not have permission');
      END;}
    */
    //end;


    //Unsupported feature: Code Modification on "OnDeleteRecord".

    //trigger OnDeleteRecord(): Boolean
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ConfPersonalizationMgt.ValidateDeleteProfile(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ConfPersonalizationMgt.DeleteProfile(Rec);
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RoleCenterSubtype := RoleCenterTxt;
    CanRunDotNetOnClient := FileManagement.CanRunDotNetOnClient;
    IsSaaS := PermissionManager.SoftwareAsAService;
    IsWindowsClient := ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Windows;
    IF "Profile ID" = '' THEN
      IsNewProfile := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RoleCenterSubtype := RoleCenterTxt;
    CanRunDotNetOnClient := FileManagement.CanRunDotNetOnClient;

    UserSetup.RESET;
    UserSetup.SETRANGE("User ID",DATABASE.USERID);
    IF UserSetup.FINDFIRST THEN BEGIN
      IF UserSetup.Admin=FALSE THEN
        ERROR('You do not have permission');
      END;
    */
    //end;
}
