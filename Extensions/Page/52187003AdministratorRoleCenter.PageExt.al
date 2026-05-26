#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187003 pageextension52187003 extends "Administrator Role Center"
{
    Caption = 'Role Center';
    layout
    {
    }
    actions
    {
        // modify("Check on Ne&gative Inventory")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Job Queue Entries")
        {
            ApplicationArea = Basic;
        }
        modify("User Setup")
        {
            ApplicationArea = Basic;
        }

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
        // modify("Extended Text")
        // {
        //     ApplicationArea = Basic;
        // }
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



        modify("Report Selection - &Warehouse")
        {
            Visible = false;
        }



        moveafter("User Setup"; "No. Series")
    }
}

