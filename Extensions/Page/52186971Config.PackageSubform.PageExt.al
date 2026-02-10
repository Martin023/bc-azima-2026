#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186971 pageextension52186971 extends "Config. Package Subform" 
{
    layout
    {
        modify("Table ID")
        {
            ApplicationArea = Basic;
        }
        modify("Table Name")
        {
            ApplicationArea = Basic;
        }
        modify("Table Caption")
        {
            ApplicationArea = Basic;
        }
        modify("Data Template")
        {
            ApplicationArea = Basic;
        }
        modify("Processing Order")
        {
            ApplicationArea = Basic;
        }
        modify("Skip Table Triggers")
        {
            ApplicationArea = Basic;
        }
        modify("Processing Report ID")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Package Records")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Fields Available")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Fields Included")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Fields to Validate")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Package Errors")
        {
            ApplicationArea = Basic;
        }
        modify(NoOfDatabaseRecords)
        {
            ApplicationArea = Basic;
        }
        modify(Filtered)
        {
            ApplicationArea = Basic;
        }
        modify("Page ID")
        {
            ApplicationArea = Basic;
        }
        modify(Comments)
        {
            ApplicationArea = Basic;
        }
        modify("Created Date and Time")
        {
            ApplicationArea = Basic;
        }
        modify("Created by User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Imported Date and Time")
        {
            ApplicationArea = Basic;
        }
        modify("Imported by User ID")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Table ID"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Table Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Table Caption"(Control 13)".

        modify("Parent Table ID")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Data Template"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Processing Order"(Control 3)".

        modify("Dimensions as Columns")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Skip Table Triggers"(Control 17)".

        modify("Delete Recs Before Processing")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Processing Report ID"(Control 12)".


        //Unsupported feature: Property Deletion (BlankZero) on ""Processing Report ID"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Package Records"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Fields Available"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Fields Included"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Fields to Validate"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Package Errors"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfDatabaseRecords(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Filtered(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Page ID"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comments(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Created Date and Time"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Created by User ID"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Imported Date and Time"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Imported by User ID"(Control 33)".

        modify("Delayed Insert")
        {
            Visible = false;
        }
    }
    actions
    {
        modify(PackageRecords)
        {
            ApplicationArea = Basic;
        }
        modify(DatabaseRecords)
        {
            ApplicationArea = Basic;
        }
        modify(PackageErrors)
        {
            ApplicationArea = Basic;
        }
        modify(PackageFields)
        {
            ApplicationArea = Basic;
        }
        modify(PackageFilters)
        {
            ApplicationArea = Basic;
        }
        modify(GetRelatedTables)
        {
            ApplicationArea = Basic;
        }
        modify(ValidateRelations)
        {
            ApplicationArea = Basic;
        }
        modify(ApplyData)
        {
            ApplicationArea = Basic;
        }
        modify(ExportToExcel)
        {
            ApplicationArea = Basic;
        }
        modify(ImportFromExcel)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PackageRecords(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DatabaseRecords(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PackageErrors(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PackageFields(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PackageFilters(Action 7)".

        modify(ProcessingRules)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "GetRelatedTables(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ValidateRelations(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApplyData(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ExportToExcel(Action 21)".


        //Unsupported feature: Property Deletion (Enabled) on "ExportToExcel(Action 21)".


        //Unsupported feature: Code Modification on "ImportFromExcel(Action 20).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ConfigPackageTable);
            ConfigExcelExchange.SetSelectedTables(ConfigPackageTable);
            ConfigExcelExchange.ImportExcelFromSelectedPackage("Package Code");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ConfigExcelExchange.ImportExcelFromPackage;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ImportFromExcel(Action 20)".


        //Unsupported feature: Property Deletion (Enabled) on "ImportFromExcel(Action 20)".

    }


    //Unsupported feature: Property Modification (TextConstString) on "SingleTableSelectedQst(Variable 1002)".

    //var
        //>>>> ORIGINAL VALUE:
        //SingleTableSelectedQst : @@@="%1 = Table name";ENU=One table has been selected. Do you want to continue?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //SingleTableSelectedQst : @@@="%1 = Table name";ENU=1 table has been selected. Do you want to continue?;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SETFILTER("Company Filter (Source Table)",'%1',COMPANYNAME);
        AditionalOptionsEnabled := ConfigPackage.WRITEPERMISSION;
        ConfigPackageManagement.RemoveRecordsWithObsoleteTableID(
          DATABASE::"Config. Package Table",FIELDNO("Table ID"));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SETFILTER("Company Filter (Source Table)",'%1',COMPANYNAME);
        */
    //end;
}
