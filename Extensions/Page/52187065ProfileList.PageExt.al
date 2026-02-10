#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187065 pageextension52187065 extends "Profile List"
{
    Caption = 'Profile List';

    //Unsupported feature: Property Modification (SourceTable) on ""Profile List"(Page 9171)".

    layout
    {
        // modify("Profile ID")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(Description)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Role Center ID")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Default Role Center")
        // {
        //     ApplicationArea = Basic;
        //     Editable = false;
        // }
        // modify("Disable Personalization")
        // {
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Profile ID"(Control 2)".


        //Unsupported feature: Property Deletion (NotBlank) on ""Profile ID"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 8)".

        // modify(Scope)
        // {
        //     Visible = false;
        // }
        // modify("App Name")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Role Center ID"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Default Role Center"(Control 1102601000)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Disable Personalization"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Disable Personalization"(Control 3)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Use Record Notes"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Use Record Notes"(Control 5)".


        //Unsupported feature: Property Deletion (Visible) on ""Use Record Notes"(Control 5)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Record Notebook"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Record Notebook"(Control 7)".


        //Unsupported feature: Property Deletion (Visible) on ""Record Notebook"(Control 7)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Use Page Notes"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Use Page Notes"(Control 9)".


        //Unsupported feature: Property Deletion (Visible) on ""Use Page Notes"(Control 9)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Page Notebook"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Page Notebook"(Control 10)".


        //Unsupported feature: Property Deletion (Visible) on ""Page Notebook"(Control 10)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        // modify("Copy Profile")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Import Profile")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Import Translated Profile Resources From Folder")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Visible) on ""Import Translated Profile Resources From Folder"(Action 6)".

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
        // modify(SetDefaultRoleCenter)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Code Modification on ""Copy Profile"(Action 1102601008).OnAction".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy Profile"(Action 1102601008)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Copy Profile"(Action 1102601008)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Import Profile"(Action 4)".


        //Unsupported feature: Property Deletion (Visible) on ""Import Profile"(Action 4)".


        //Unsupported feature: Property Deletion (Enabled) on ""Import Profile"(Action 4)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Import Profile"(Action 4)".

        modify(ExportProfiles)
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on ""Import Translated Profile Resources From Folder"(Action 6).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        AlertIfTenantProfileSelected;
        CurrPage.SETSELECTIONFILTER(ProfileRec);
        ConfPersonalizationMgt.ImportTranslatedResourcesWithFolderSelection(ProfileRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(ProfileRec);
        ConfPersonalizationMgt.ImportTranslatedResourcesWithFolderSelection(ProfileRec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Import Translated Profile Resources From Folder"(Action 6)".


        //Unsupported feature: Property Deletion (Enabled) on ""Import Translated Profile Resources From Folder"(Action 6)".



        //Unsupported feature: Code Modification on ""Import Translated Profile Resources From Zip File"(Action 13).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        AlertIfTenantProfileSelected;
        CurrPage.SETSELECTIONFILTER(ProfileRec);
        ConfPersonalizationMgt.ImportTranslatedResources(ProfileRec,'',TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(ProfileRec);
        ConfPersonalizationMgt.ImportTranslatedResources(ProfileRec,'',TRUE);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Import Translated Profile Resources From Zip File"(Action 13)".


        //Unsupported feature: Property Deletion (Visible) on ""Import Translated Profile Resources From Zip File"(Action 13)".


        //Unsupported feature: Property Deletion (Enabled) on ""Import Translated Profile Resources From Zip File"(Action 13)".



        //Unsupported feature: Code Modification on ""Export Translated Profile Resources"(Action 11).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        AlertIfTenantProfileSelected;
        CurrPage.SETSELECTIONFILTER(ProfileRec);
        ProfileRec.SETRANGE(Scope,ProfileRec.Scope::System);
        ConfPersonalizationMgt.ExportTranslatedResourcesWithFolderSelection(ProfileRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(ProfileRec);
        ConfPersonalizationMgt.ExportTranslatedResourcesWithFolderSelection(ProfileRec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Export Translated Profile Resources"(Action 11)".


        //Unsupported feature: Property Deletion (Visible) on ""Export Translated Profile Resources"(Action 11)".


        //Unsupported feature: Property Deletion (Enabled) on ""Export Translated Profile Resources"(Action 11)".



        //Unsupported feature: Code Modification on ""Remove Translated Profile Resources"(Action 12).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        AlertIfTenantProfileSelected;
        CurrPage.SETSELECTIONFILTER(ProfileRec);
        ProfileRec.SETRANGE(Scope,ProfileRec.Scope::System);
        ConfPersonalizationMgt.RemoveTranslatedResourcesWithLanguageSelection(ProfileRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(ProfileRec);
        ConfPersonalizationMgt.RemoveTranslatedResourcesWithLanguageSelection(ProfileRec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Remove Translated Profile Resources"(Action 12)".


        //Unsupported feature: Property Deletion (Visible) on ""Remove Translated Profile Resources"(Action 12)".


        //Unsupported feature: Property Deletion (Enabled) on ""Remove Translated Profile Resources"(Action 12)".

    }


    //Unsupported feature: Property Modification (Subtype) on ""Copy Profile"(Action 1102601008).OnAction.Profile(Variable 1035)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Copy Profile" : "All Profile";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Copy Profile" : Profile;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Subtype) on ""Import Translated Profile Resources From Folder"(Action 6).OnAction.ProfileRec(Variable 1002)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Import Translated Profile Resources From Folder" : "All Profile";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Import Translated Profile Resources From Folder" : Profile;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Subtype) on ""Import Translated Profile Resources From Zip File"(Action 13).OnAction.ProfileRec(Variable 1002)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Import Translated Profile Resources From Zip File" : "All Profile";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Import Translated Profile Resources From Zip File" : Profile;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Subtype) on ""Export Translated Profile Resources"(Action 11).OnAction.ProfileRec(Variable 1002)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Export Translated Profile Resources" : "All Profile";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Export Translated Profile Resources" : Profile;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Subtype) on ""Remove Translated Profile Resources"(Action 12).OnAction.ProfileRec(Variable 1002)".

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
      END;
      }
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CanRunDotNetOnClient := FileManagement.CanRunDotNetOnClient;
    RoleCenterSubtype := RoleCenterTxt;
    IsSaaS := PermissionManager.SoftwareAsAService;
    IsWindowsClient := ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Windows;
    ConfPersonalizationMgt.HideSandboxProfiles(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CanRunDotNetOnClient := FileManagement.CanRunDotNetOnClient;

    //UserSetup.GET(USERID);


    UserSetup.RESET;
    UserSetup.SETRANGE("User ID",DATABASE.USERID);
    IF UserSetup.FINDFIRST THEN BEGIN
      IF UserSetup.Admin=FALSE THEN
        ERROR('You do not have permission');
      END;
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (RefreshOnActivate).

}
