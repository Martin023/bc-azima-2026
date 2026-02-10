#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185653 pageextension52185653 extends Companies 
{
    layout
    {
       
        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 2)".

        modify("Display Name")
        {
            Visible = false;
        }
        modify("Evaluation Company")
        {
            Visible = false;
        }
        modify(EnableAssistedCompanySetup)
        {
            Visible = false;
        }
        modify(SetupStatus)
        {
            Visible = false;
        }
        modify(CompanyCreatedDateTime)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(CopyCompany)
        {
            ApplicationArea = Basic;
        }
        modify("Create New Company")
        {
            Visible = false;
        }

        //Unsupported feature: Code Modification on "CopyCompany(Action 4).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF NOT PermissionManager.IsSuper(USERSECURITYID) THEN
              ERROR(OnlySuperCanCreateNewCompanyErr);

            Company.SETRANGE(Name,Name);
            CopyCompany.SETTABLEVIEW(Company);
            CopyCompany.RUNMODAL;

            IF GET(CopyCompany.GetCompanyName) THEN
              AssistedCompanySetupStatus.CopySaaSCompanySetupStatus(Name,CopyCompany.GetCompanyName);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #4..7
            IF GET(CopyCompany.GetCompanyName) THEN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CopyCompany(Action 4)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "CopyCompany(Action 4)".

    }


    //Unsupported feature: Code Modification on "OnDeleteRecord".

    //trigger OnDeleteRecord(): Boolean
    //>>>> ORIGINAL CODE:
    //begin
        /*
        OnBeforeDeleteRecord(Rec);
        IF SoftwareAsAService AND (COUNT = 1) THEN BEGIN
          MESSAGE(DeleteLastCompanyMsg);
          ERROR('');
        END;

        IF NOT ConfirmManagement.ConfirmProcess(DeleteCompanyQst,FALSE) THEN
          EXIT(FALSE);

        EXIT(TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        EXIT(CONFIRM(DeleteCompanyQst,FALSE));
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (RefreshOnActivate).

}
