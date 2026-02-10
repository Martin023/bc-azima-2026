#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186961 pageextension52186961 extends "Config. Package Card" 
{
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
        modify("Product Version")
        {
            ApplicationArea = Basic;
        }
        modify("Language ID")
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

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Package Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Product Version"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Language ID"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Processing Order"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exclude Config. Tables"(Control 9)".

        modify(Errors)
        {
            Visible = false;
        }
        modify("No. of Errors")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control10(Control 10)".

    }
    actions
    {
        modify(ExportPackage)
        {

            //Unsupported feature: Property Modification (Name) on "ExportPackage(Action 23)".

            ApplicationArea = Basic;
        }
        modify(ImportPackage)
        {

            //Unsupported feature: Property Modification (Name) on "ImportPackage(Action 22)".

            ApplicationArea = Basic;
        }
        modify(ExportToExcel)
        {

            //Unsupported feature: Property Modification (Name) on "ExportToExcel(Action 21)".

            ApplicationArea = Basic;
        }
        modify(ImportFromExcel)
        {

            //Unsupported feature: Property Modification (Name) on "ImportFromExcel(Action 20)".

            ApplicationArea = Basic;
        }
        modify(GetTables)
        {

            //Unsupported feature: Property Modification (Name) on "GetTables(Action 17)".

            ApplicationArea = Basic;
        }
        modify(ApplyPackage)
        {

            //Unsupported feature: Property Modification (Name) on "ApplyPackage(Action 15)".

            ApplicationArea = Basic;
        }
        modify(CopyPackage)
        {

            //Unsupported feature: Property Modification (Name) on "CopyPackage(Action 13)".

            ApplicationArea = Basic;
        }
        modify(ValidatePackage)
        {

            //Unsupported feature: Property Modification (Name) on "ValidatePackage(Action 8)".

            ApplicationArea = Basic;
        }
        modify(ExportToTranslation)
        {

            //Unsupported feature: Property Modification (Name) on "ExportToTranslation(Action 6)".

            ApplicationArea = Basic;
        }
        modify(ProcessData)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ExportPackage(Action 23)".


        //Unsupported feature: Property Deletion (Enabled) on "ExportPackage(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ImportPackage(Action 22)".


        //Unsupported feature: Property Deletion (Enabled) on "ImportPackage(Action 22)".


        //Unsupported feature: Code Modification on "ExportToExcel(Action 21).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Code);

            ConfigPackageTable.SETRANGE("Package Code",Code);
            IF ConfirmManagement.ConfirmProcess(STRSUBSTNO(Text004,Code,ConfigPackageTable.COUNT),TRUE) THEN
              ConfigExcelExchange.ExportExcelFromTables(ConfigPackageTable);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            IF CONFIRM(Text004,TRUE,Code,ConfigPackageTable.COUNT) THEN
              ConfigExcelExchange.ExportExcelFromTables(ConfigPackageTable);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ExportToExcel(Action 21)".


        //Unsupported feature: Property Deletion (Promoted) on "ExportToExcel(Action 21)".


        //Unsupported feature: Property Deletion (Enabled) on "ExportToExcel(Action 21)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "ExportToExcel(Action 21)".



        //Unsupported feature: Code Modification on "ImportFromExcel(Action 20).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ConfigExcelExchange.ImportExcelFromSelectedPackage(Code);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ConfigExcelExchange.ImportExcelFromPackage;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ImportFromExcel(Action 20)".


        //Unsupported feature: Property Deletion (Promoted) on "ImportFromExcel(Action 20)".


        //Unsupported feature: Property Deletion (Enabled) on "ImportFromExcel(Action 20)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "ImportFromExcel(Action 20)".

        modify(ShowError)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "GetTables(Action 17)".



        //Unsupported feature: Code Modification on "ApplyPackage(Action 15).OnAction".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "ApplyPackage(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CopyPackage(Action 13)".



        //Unsupported feature: Code Modification on "ValidatePackage(Action 8).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ConfirmManagement.ConfirmProcess(STRSUBSTNO(Text002,"Package Name"),TRUE) THEN BEGIN
              ConfigPackageTable.SETRANGE("Package Code",Code);
              ConfigPackageMgt.ValidatePackageRelations(ConfigPackageTable,TempConfigPackageTable,TRUE);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF CONFIRM(Text002,TRUE,"Package Name") THEN BEGIN
            #2..4
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ValidatePackage(Action 8)".



        //Unsupported feature: Code Modification on "ExportToTranslation(Action 6).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Code);

            ConfigXMLExchange.SetAdvanced(TRUE);
            ConfigPackageTable.SETRANGE("Package Code",Code);
            IF ConfirmManagement.ConfirmProcess(STRSUBSTNO(Text004,Code,ConfigPackageTable.COUNT),TRUE) THEN
              ConfigXMLExchange.ExportPackageXML(ConfigPackageTable,'');
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
            IF CONFIRM(Text004,TRUE,Code,ConfigPackageTable.COUNT) THEN
              ConfigXMLExchange.ExportPackageXML(ConfigPackageTable,'');
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ExportToTranslation(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ProcessData(Action 12)".

        addafter(ValidatePackage)
        {
            separator(Action7)
            {
            }
        }
    }

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
