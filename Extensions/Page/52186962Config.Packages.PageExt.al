#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186962 pageextension52186962 extends "Config. Packages" 
{
    Caption = 'Config. Packages';
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify("Package Name")
        {
            ApplicationArea = Basic;
        }
        modify("Language ID")
        {
            ApplicationArea = Basic;
        }
        modify("Product Version")
        {
            ApplicationArea = Basic;
        }
        modify("Processing Order")
        {
            ApplicationArea = Basic;
        }
        modify("Exclude Config. Tables")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Tables")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Records")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Errors")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Package Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Language ID"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Product Version"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Processing Order"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exclude Config. Tables"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Tables"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Records"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Errors"(Control 27)".

    }
    actions
    {
        modify(ExportPackage)
        {

            //Unsupported feature: Property Modification (Name) on "ExportPackage(Action 22)".

            ApplicationArea = Basic;
        }
        modify(ImportPackage)
        {

            //Unsupported feature: Property Modification (Name) on "ImportPackage(Action 13)".

            ApplicationArea = Basic;
        }
        modify(ExportToExcel)
        {

            //Unsupported feature: Property Modification (Name) on "ExportToExcel(Action 11)".

            ApplicationArea = Basic;
        }
        modify(ImportFromExcel)
        {

            //Unsupported feature: Property Modification (Name) on "ImportFromExcel(Action 15)".

            ApplicationArea = Basic;
        }
        modify(GetTables)
        {

            //Unsupported feature: Property Modification (Name) on "GetTables(Action 19)".

            ApplicationArea = Basic;
        }
        modify(ApplyPackage)
        {

            //Unsupported feature: Property Modification (Name) on "ApplyPackage(Action 3)".

            ApplicationArea = Basic;
        }
        modify(CopyPackage)
        {

            //Unsupported feature: Property Modification (Name) on "CopyPackage(Action 14)".

            ApplicationArea = Basic;
        }
        modify(ValidatePackage)
        {

            //Unsupported feature: Property Modification (Name) on "ValidatePackage(Action 17)".

            ApplicationArea = Basic;
        }
        modify(ExportToTranslation)
        {

            //Unsupported feature: Property Modification (Name) on "ExportToTranslation(Action 21)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ExportPackage(Action 22)".


        //Unsupported feature: Property Deletion (Enabled) on "ExportPackage(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ImportPackage(Action 13)".


        //Unsupported feature: Property Deletion (Enabled) on "ImportPackage(Action 13)".

        modify(ImportPredefinedPackage)
        {
            Visible = false;
        }

        //Unsupported feature: Code Modification on "ExportToExcel(Action 11).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Code);

            ConfigPackageTable.SETRANGE("Package Code",Code);
            IF ConfirmManagement.ConfirmProcess(STRSUBSTNO(Text004,Code),TRUE) THEN
              ConfigExcelExchange.ExportExcelFromTables(ConfigPackageTable);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            IF CONFIRM(Text004,TRUE,Code) THEN
              ConfigExcelExchange.ExportExcelFromTables(ConfigPackageTable);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ExportToExcel(Action 11)".


        //Unsupported feature: Property Deletion (Promoted) on "ExportToExcel(Action 11)".


        //Unsupported feature: Property Deletion (Enabled) on "ExportToExcel(Action 11)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "ExportToExcel(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ImportFromExcel(Action 15)".


        //Unsupported feature: Property Deletion (Promoted) on "ImportFromExcel(Action 15)".


        //Unsupported feature: Property Deletion (Enabled) on "ImportFromExcel(Action 15)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "ImportFromExcel(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetTables(Action 19)".



        //Unsupported feature: Code Modification on "ApplyPackage(Action 3).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Code);
            IF ConfirmManagement.ConfirmProcess(STRSUBSTNO(Text003,Code),TRUE) THEN BEGIN
              ConfigPackageTable.SETRANGE("Package Code",Code);
              ConfigPackageMgt.ApplyPackage(Rec,ConfigPackageTable,TRUE);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TESTFIELD(Code);
            IF CONFIRM(Text003,TRUE,Code) THEN BEGIN
            #3..5
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ApplyPackage(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CopyPackage(Action 14)".



        //Unsupported feature: Code Modification on "ValidatePackage(Action 17).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ConfirmManagement.ConfirmProcess(STRSUBSTNO(Text002,"Package Name"),TRUE) THEN BEGIN
              ConfigPackageTable.SETRANGE("Package Code",Code);
              ConfigProgressBar.Init(ConfigPackageTable.COUNT,1,ValidatingTableRelationsMsg);

              BackgroundSessionId := 0;
              STARTSESSION(BackgroundSessionId,CODEUNIT::"Config. Validate Package",COMPANYNAME,ConfigPackageTable);

              ConfigPackageTable.SETRANGE(Validated,FALSE);
              ConfigPackageTable.SETCURRENTKEY("Package Processing Order","Processing Order");

              SLEEP(1000);
              WHILE NOT Canceled AND ActiveSession.GET(SERVICEINSTANCEID,BackgroundSessionId) AND ConfigPackageTable.FINDFIRST DO BEGIN
                ConfigPackageTable.CALCFIELDS("Table Name");
                Canceled := NOT ConfigProgressBar.UpdateCount(ConfigPackageTable."Table Name",ConfigPackageTable.COUNT);
                SLEEP(1000);
              END;

              IF ActiveSession.GET(SERVICEINSTANCEID,BackgroundSessionId) THEN
                STOPSESSION(BackgroundSessionId,ValidationCanceledMsg);

              IF NOT Canceled AND ConfigPackageTable.FINDFIRST THEN BEGIN
                SessionEvent.SETASCENDING("Event Datetime",TRUE);
                SessionEvent.SETRANGE("User ID",USERID);
                SessionEvent.SETRANGE("Server Instance ID",SERVICEINSTANCEID);
                SessionEvent.SETRANGE("Session ID",BackgroundSessionId);
                SessionEvent.FINDLAST;
                MESSAGE(SessionEvent.Comment);
              END;

              ConfigProgressBar.Close;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF CONFIRM(Text002,TRUE,"Package Name") THEN BEGIN
              ConfigPackageTable.SETRANGE("Package Code",Code);
              ConfigPackageMgt.ValidatePackageRelations(ConfigPackageTable,TempConfigPackageTable,TRUE);
            END;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ValidatePackage(Action 17)".



        //Unsupported feature: Code Modification on "ExportToTranslation(Action 21).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Code);
            ConfigXMLExchange.SetAdvanced(TRUE);
            ConfigPackageTable.SETRANGE("Package Code",Code);
            IF ConfirmManagement.ConfirmProcess(STRSUBSTNO(Text004,Code),TRUE) THEN
              ConfigXMLExchange.ExportPackageXML(ConfigPackageTable,'');
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            IF CONFIRM(Text004,TRUE,Code) THEN
              ConfigXMLExchange.ExportPackageXML(ConfigPackageTable,'');
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ExportToTranslation(Action 21)".

        addafter(ValidatePackage)
        {
            separator(Action12)
            {
            }
        }
    }

    var
        TempConfigPackageTable: Record "Config. Package Table" temporary;
        ConfigPackageMgt: Codeunit "Config. Package Management";

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
