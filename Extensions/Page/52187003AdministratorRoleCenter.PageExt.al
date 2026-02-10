#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187003 pageextension52187003 extends "Administrator Role Center" 
{
    Caption = 'Role Center';
    layout
    {

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1904484608(Control 1904484608)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control58(Control 58)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control52(Control 52)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control36(Control 36)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control32(Control 32)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901377608(Control 1901377608)".

        addafter(Control32)
        {
            // part(Control1903012608;"Copy Profile")
            // {
            // }
        }
    }
    actions
    {
        modify("Check on Ne&gative Inventory")
        {
            ApplicationArea = Basic;
        }
        modify("Job Queue Entries")
        {
            ApplicationArea = Basic;
        }
        modify("User Setup")
        {
            ApplicationArea = Basic;
        }
        // modify("Cases - Dynamics 365 for Customer Service")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""Cases - Dynamics 365 for Customer Service"(Action 5)".

        //     Caption = 'Job Qu&eue Setup';
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (RunObject) on ""Cases - Dynamics 365 for Customer Service"(Action 5)".


        //     //Unsupported feature: Property Modification (Name) on ""Cases - Dynamics 365 for Customer Service"(Action 5)".


        //     //Unsupported feature: Property Insertion (Image) on ""Cases - Dynamics 365 for Customer Service"(Action 5)".

        // }
        modify("No. Series")
        {
            ApplicationArea = Basic;
        }
        modify("Approval User Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Workflow User Groups")
        {
            ApplicationArea = Basic;
        }
        modify(Action57)
        {
            ApplicationArea = Basic;
        }
        modify("Data Templates List")
        {
            ApplicationArea = Basic;
        }
        modify("Base Calendar List")
        {
            ApplicationArea = Basic;
        }
        modify("Post Codes")
        {
            ApplicationArea = Basic;
        }
        modify("Reason Codes")
        {
            ApplicationArea = Basic;
        }
        modify("Extended Text")
        {
            ApplicationArea = Basic;
        }
        modify("JobQueue_JobQueueEntries")
        {

            //Unsupported feature: Property Modification (Name) on ""JobQueue_JobQueueEntries"(Action 54)".

            ApplicationArea = Basic;
        }
        modify("Job Queue Category List")
        {
            ApplicationArea = Basic;
        }
        modify("Job Queue Log Entries")
        {
            ApplicationArea = Basic;
        }
        modify(Workflows)
        {
            ApplicationArea = Basic;
        }
        modify("Workflow Templates")
        {
            ApplicationArea = Basic;
        }
        modify(ApprovalUserSetup)
        {
            ApplicationArea = Basic;
        }
        modify(WorkflowUserGroups)
        {
            ApplicationArea = Basic;
        }
        modify("Tariff Numbers")
        {
            ApplicationArea = Basic;
        }
        modify("Transaction Types")
        {
            ApplicationArea = Basic;
        }
        modify("Transaction Specifications")
        {
            ApplicationArea = Basic;
        }
        modify("Transport Methods")
        {
            ApplicationArea = Basic;
        }
        modify("Entry/Exit Points")
        {
            ApplicationArea = Basic;
        }
        modify(Areas)
        {
            ApplicationArea = Basic;
        }
        modify("VAT Registration No. Formats")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Analysis View List")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Analysis View List")
        {
            ApplicationArea = Basic;
        }
        modify("Inventory Analysis View List")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase &Order")
        {
            ApplicationArea = Basic;
        }
        modify("Com&pany Information")
        {
            ApplicationArea = Basic;
        }
        // modify("&Manage Style Sheets")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Migration O&verview")
        {
            ApplicationArea = Basic;
        }
        modify("Relocate &Attachments")
        {
            ApplicationArea = Basic;
        }
        modify("Create Warehouse &Location")
        {
            ApplicationArea = Basic;
        }
        modify("C&hange Log Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Setup &Questionnaire")
        {
            ApplicationArea = Basic;
        }
        modify("&General Ledger Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Sales && Re&ceivables Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase && &Payables Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Fixed &Asset Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Mar&keting Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Or&der Promising Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Catalog &Item Setup")
        {
            Caption = 'Nonstock &Item Setup';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Catalog &Item Setup"(Action 63)".

        }
        modify("Interaction &Template Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Inve&ntory Setup")
        {
            ApplicationArea = Basic;
        }
        modify("&Warehouse Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Mini&forms")
        {
            ApplicationArea = Basic;
        }
        modify("Man&ufacturing Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Res&ources Setup")
        {
            ApplicationArea = Basic;
        }
        modify("&Service Setup")
        {
            ApplicationArea = Basic;
        }
        modify("&Human Resource Setup")
        {
            ApplicationArea = Basic;
        }
        modify("&Service Order Status Setup")
        {
            ApplicationArea = Basic;
        }
        modify("&Repair Status Setup")
        {
            ApplicationArea = Basic;
        }
        modify(Action77)
        {
            ApplicationArea = Basic;
        }
        modify("&MapPoint Setup")
        {
            ApplicationArea = Basic;
        }
        // modify("SMTP Mai&l Setup")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Profile Quest&ionnaire Setup")
        {
            ApplicationArea = Basic;
        }
        modify("Report Selection - &Bank Account")
        {
            ApplicationArea = Basic;
        }
        modify("Report Selection - &Reminder && Finance Charge")
        {
            ApplicationArea = Basic;
        }
        modify("Report Selection - &Sales")
        {
            ApplicationArea = Basic;
        }
        modify("Report Selection - &Purchase")
        {
            ApplicationArea = Basic;
        }
        modify("Report Selection - &Inventory")
        {
            ApplicationArea = Basic;
        }
        modify("Report Selection - Prod. &Order")
        {
            ApplicationArea = Basic;
        }
        modify("Report Selection - S&ervice")
        {
            ApplicationArea = Basic;
        }
        modify("Report Selection - Cash Flow")
        {
            ApplicationArea = Basic;
        }
        modify("Date Compress &G/L Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Date Compress &VAT Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Date Compress Bank &Account Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Date Compress G/L &Budget Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Date Compress &Customer Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Date Compress V&endor Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Date Compress &Resource Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Date Compress &FA Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Date Compress &Maintenance Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Date Compress &Insurance Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Date Compress &Warehouse Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Create Contacts from &Customer")
        {
            ApplicationArea = Basic;
        }
        modify("Create Contacts from &Vendor")
        {
            ApplicationArea = Basic;
        }
        modify("Create Contacts from &Bank Account")
        {
            ApplicationArea = Basic;
        }
        modify("Task &Activities")
        {
            Caption = 'To-do &Activities';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Task &Activities"(Action 37)".

        }
        modify("Service Trou&bleshooting")
        {
            ApplicationArea = Basic;
        }
        modify("Import IRIS to &Area/Symptom Code")
        {
            ApplicationArea = Basic;
        }
        modify("Import IRIS to &Fault Codes")
        {
            ApplicationArea = Basic;
        }
        modify("Import IRIS to &Resolution Codes")
        {
            ApplicationArea = Basic;
        }
        modify(SalesAnalysisLineTmpl)
        {

            //Unsupported feature: Property Modification (Name) on "SalesAnalysisLineTmpl(Action 119)".

            ApplicationArea = Basic;
        }
        modify(SalesAnalysisColumnTmpl)
        {

            //Unsupported feature: Property Modification (Name) on "SalesAnalysisColumnTmpl(Action 120)".

            ApplicationArea = Basic;
        }
        modify(PurchaseAnalysisLineTmpl)
        {

            //Unsupported feature: Property Modification (Name) on "PurchaseAnalysisLineTmpl(Action 123)".

            ApplicationArea = Basic;
        }
        modify(PurchaseAnalysisColumnTmpl)
        {

            //Unsupported feature: Property Modification (Name) on "PurchaseAnalysisColumnTmpl(Action 124)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Check on Ne&gative Inventory"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Queue Entries"(Action 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User Setup"(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cases - Dynamics 365 for Customer Service"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. Series"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Approval User Setup"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Workflow User Groups"(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action57(Action 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Data Templates List"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Base Calendar List"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Codes"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Codes"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Extended Text"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""JobQueue_JobQueueEntries"(Action 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Queue Category List"(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Queue Log Entries"(Action 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Workflows(Action 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Workflow Templates"(Action 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApprovalUserSetup(Action 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WorkflowUserGroups(Action 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Tariff Numbers"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Types"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Specifications"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transport Methods"(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry/Exit Points"(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Areas(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Registration No. Formats"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Analysis View List"(Action 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Analysis View List"(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory Analysis View List"(Action 51)".

        modify("Data Privacy")
        {
            Visible = false;
        }
        modify("Page Data Classifications")
        {
            Visible = false;
        }
        modify(Classified)
        {
            Visible = false;
        }
        modify(Unclassified)
        {
            Visible = false;
        }
        modify("Page Data Subjects")
        {
            Visible = false;
        }
        modify("Page Change Log Entries")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase &Order"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Com&pany Information"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Manage Style Sheets"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Migration O&verview"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Relocate &Attachments"(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Warehouse &Location"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""C&hange Log Setup"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Setup &Questionnaire"(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&General Ledger Setup"(Action 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales && Re&ceivables Setup"(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase && &Payables Setup"(Action 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fixed &Asset Setup"(Action 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Mar&keting Setup"(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Or&der Promising Setup"(Action 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Catalog &Item Setup"(Action 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction &Template Setup"(Action 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inve&ntory Setup"(Action 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Warehouse Setup"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Mini&forms"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Man&ufacturing Setup"(Action 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Res&ources Setup"(Action 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Service Setup"(Action 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Human Resource Setup"(Action 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Service Order Status Setup"(Action 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Repair Status Setup"(Action 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action77(Action 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&MapPoint Setup"(Action 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""SMTP Mai&l Setup"(Action 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Profile Quest&ionnaire Setup"(Action 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report Selection - &Bank Account"(Action 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report Selection - &Reminder && Finance Charge"(Action 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report Selection - &Sales"(Action 86)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report Selection - &Purchase"(Action 87)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report Selection - &Inventory"(Action 88)".

        modify("Report Selection - &Warehouse")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Report Selection - Prod. &Order"(Action 89)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report Selection - S&ervice"(Action 91)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report Selection - Cash Flow"(Action 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Compress &G/L Entries"(Action 94)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Compress &VAT Entries"(Action 95)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Compress Bank &Account Ledger Entries"(Action 96)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Compress G/L &Budget Entries"(Action 97)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Compress &Customer Ledger Entries"(Action 98)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Compress V&endor Ledger Entries"(Action 99)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Compress &Resource Ledger Entries"(Action 90)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Compress &FA Ledger Entries"(Action 102)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Compress &Maintenance Ledger Entries"(Action 103)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Compress &Insurance Ledger Entries"(Action 104)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Compress &Warehouse Entries"(Action 105)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Contacts from &Customer"(Action 108)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Contacts from &Vendor"(Action 109)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Contacts from &Bank Account"(Action 110)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Trou&bleshooting"(Action 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Import IRIS to &Area/Symptom Code"(Action 260)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Import IRIS to &Fault Codes"(Action 261)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Import IRIS to &Resolution Codes"(Action 262)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesAnalysisLineTmpl(Action 119)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesAnalysisColumnTmpl(Action 120)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PurchaseAnalysisLineTmpl(Action 123)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PurchaseAnalysisColumnTmpl(Action 124)".

        moveafter("User Setup";"No. Series")
    }
}
