#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185442 pageextension52185442 extends "Vendor List"
{
    Caption = 'Vendor List';
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Responsibility Center")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Phone No.")
        {
            ApplicationArea = Basic;
        }
        modify("Fax No.")
        {
            ApplicationArea = Basic;
        }
        modify("IC Partner Code")
        {
            ApplicationArea = Basic;
        }
        modify(Contact)
        {
            ApplicationArea = Basic;
        }
        modify("Purchaser Code")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Terms Code")
        {
            ApplicationArea = Basic;
        }
        modify("Fin. Charge Terms Code")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Language Code")
        {
            ApplicationArea = Basic;
        }
        modify("Search Name")
        {
            ApplicationArea = Basic;
        }
        modify(Blocked)
        {
            ApplicationArea = Basic;
        }
        modify("Last Date Modified")
        {
            ApplicationArea = Basic;
        }
        modify("Application Method")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code2")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Method Code")
        {
            ApplicationArea = Basic;
        }
        modify("Lead Time Calculation")
        {
            ApplicationArea = Basic;
        }
        modify("Base Calendar Code")
        {
            ApplicationArea = Basic;
        }


        modify("Privacy Blocked")
        {
            Visible = false;
        }


        modify("Balance (LCY)")
        {
            Visible = true;
        }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }
        modify("Payments (LCY)")
        {
            Visible = false;
        }
        // modify("Power BI Report FactBox")
        // {
        //     Visible = false;
        // }
        addafter("Balance (LCY)")
        {
            field("Created By"; Rec."Created By")
            {
                Editable = false;
            }
            field("Created At"; Rec."Created At")
            {
                Editable = false;
            }
        }



    }
    actions
    {
        modify(DimensionsSingle)
        {

            //Unsupported feature: Property Modification (Name) on "DimensionsSingle(Action 84)".

            ApplicationArea = Basic;
        }
        modify(DimensionsMultiple)
        {

            //Unsupported feature: Property Modification (Name) on "DimensionsMultiple(Action 43)".

            ApplicationArea = Basic;
        }
        modify("Bank Accounts")
        {
            ApplicationArea = Basic;
        }
        modify("C&ontact")
        {
            ApplicationArea = Basic;
        }
        modify(OrderAddresses)
        {

            //Unsupported feature: Property Modification (Name) on "OrderAddresses(Action 53)".

            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        // modify("Cross Re&ferences")
        // {
        //     ApplicationArea = Basic;
        // }
        modify(Items)
        {
            ApplicationArea = Basic;
        }
        modify("Invoice &Discounts")
        {
            ApplicationArea = Basic;
        }
        modify(Prices)
        {
            ApplicationArea = Basic;
        }
        modify("Line Discounts")
        {
            ApplicationArea = Basic;
        }
        modify("Prepa&yment Percentages")
        {
            ApplicationArea = Basic;
        }
        modify("Recurring Purchase Lines")
        {
            Caption = 'S&td. Vend. Purchase Codes';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Recurring Purchase Lines"(Action 67)".

        }
        modify(Quotes)
        {
            ApplicationArea = Basic;
        }
        modify(Orders)
        {
            ApplicationArea = Basic;
        }
        modify("Return Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Blanket Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Ledger E&ntries")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunPageView) on ""Ledger E&ntries"(Action 22)".


            //Unsupported feature: Property Modification (Image) on ""Ledger E&ntries"(Action 22)".


            //Unsupported feature: Property Modification (PromotedCategory) on ""Ledger E&ntries"(Action 22)".

        }
        modify(Statistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 18)".

        }
        modify(Purchases)
        {
            ApplicationArea = Basic;
        }
        modify("Entry Statistics")
        {
            ApplicationArea = Basic;
        }
        modify("Statistics by C&urrencies")
        {
            ApplicationArea = Basic;
        }
        modify("Item &Tracking Entries")
        {
            ApplicationArea = Basic;
        }
        modify(NewBlanketPurchaseOrder)
        {

            //Unsupported feature: Property Modification (Name) on "NewBlanketPurchaseOrder(Action 1903213705)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on "NewBlanketPurchaseOrder(Action 1903213705)".


            //Unsupported feature: Property Insertion (PromotedCategory) on "NewBlanketPurchaseOrder(Action 1903213705)".

        }
        modify(NewPurchaseQuote)
        {

            //Unsupported feature: Property Modification (Name) on "NewPurchaseQuote(Action 1901469405)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on "NewPurchaseQuote(Action 1901469405)".


            //Unsupported feature: Property Insertion (PromotedCategory) on "NewPurchaseQuote(Action 1901469405)".

        }
        modify(NewPurchaseInvoice)
        {

            //Unsupported feature: Property Modification (Name) on "NewPurchaseInvoice(Action 1907709505)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on "NewPurchaseInvoice(Action 1907709505)".


            //Unsupported feature: Property Modification (PromotedCategory) on "NewPurchaseInvoice(Action 1907709505)".

        }
        modify(NewPurchaseOrder)
        {

            //Unsupported feature: Property Modification (Name) on "NewPurchaseOrder(Action 1907375405)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "NewPurchaseOrder(Action 1907375405)".

        }
        modify(NewPurchaseCrMemo)
        {

            //Unsupported feature: Property Modification (Name) on "NewPurchaseCrMemo(Action 1905024805)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Promoted) on "NewPurchaseCrMemo(Action 1905024805)".


            //Unsupported feature: Property Modification (PromotedCategory) on "NewPurchaseCrMemo(Action 1905024805)".

        }
        modify(NewPurchaseReturnOrder)
        {

            //Unsupported feature: Property Modification (Name) on "NewPurchaseReturnOrder(Action 1904749705)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on "NewPurchaseReturnOrder(Action 1904749705)".


            //Unsupported feature: Property Insertion (PromotedCategory) on "NewPurchaseReturnOrder(Action 1904749705)".

        }
        modify(SendApprovalRequest)
        {
            ApplicationArea = Basic;
            //Enabled = not OpenApprovalEntriesExist;
        }
        modify(CancelApprovalRequest)
        {
            ApplicationArea = Basic;
            //Enabled = OpenApprovalEntriesExist;

            //Unsupported feature: Property Modification (Image) on "CancelApprovalRequest(Action 17)".

        }
        modify("Payment Journal")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Payment Journal"(Action 1902327104)".

        }
        modify("Purchase Journal")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Promoted) on ""Purchase Journal"(Action 1906371704)".


            //Unsupported feature: Property Modification (PromotedCategory) on ""Purchase Journal"(Action 1906371704)".

        }
        // modify("Vendor - List")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (Promoted) on ""Vendor - List"(Action 1900518506)".


        //     //Unsupported feature: Property Insertion (PromotedCategory) on ""Vendor - List"(Action 1900518506)".

        // }
        modify("Vendor Register")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on ""Vendor Register"(Action 1906328906)".


            //Unsupported feature: Property Insertion (PromotedCategory) on ""Vendor Register"(Action 1906328906)".

        }
        modify("Vendor Item Catalog")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on ""Vendor Item Catalog"(Action 1906643406)".


            //Unsupported feature: Property Insertion (PromotedCategory) on ""Vendor Item Catalog"(Action 1906643406)".

        }
        modify("Vendor - Labels")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on ""Vendor - Labels"(Action 1905916106)".


            //Unsupported feature: Property Insertion (PromotedCategory) on ""Vendor - Labels"(Action 1905916106)".

        }
        modify("Vendor - Top 10 List")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on ""Vendor - Top 10 List"(Action 1900497106)".


            //Unsupported feature: Property Insertion (PromotedCategory) on ""Vendor - Top 10 List"(Action 1900497106)".

        }
        modify("Vendor - Order Summary")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on ""Vendor - Order Summary"(Action 1906294906)".


            //Unsupported feature: Property Insertion (PromotedCategory) on ""Vendor - Order Summary"(Action 1906294906)".

        }
        modify("Vendor - Order Detail")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on ""Vendor - Order Detail"(Action 1904076306)".


            //Unsupported feature: Property Insertion (PromotedCategory) on ""Vendor - Order Detail"(Action 1904076306)".

        }
        modify("Vendor - Purchase List")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on ""Vendor - Purchase List"(Action 1907303206)".


            //Unsupported feature: Property Insertion (PromotedCategory) on ""Vendor - Purchase List"(Action 1907303206)".

        }
        modify("Vendor/Item Purchases")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on ""Vendor/Item Purchases"(Action 1904498706)".


            //Unsupported feature: Property Insertion (PromotedCategory) on ""Vendor/Item Purchases"(Action 1904498706)".

        }
        modify("Purchase Statistics")
        {
            ApplicationArea = Basic;



        }

        modify("Aged Accounts Payable")
        {
            ApplicationArea = Basic;



        }

        modify("Vendor - Trial Balance")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on ""Vendor - Trial Balance"(Action 1906387606)".


            //Unsupported feature: Property Insertion (PromotedCategory) on ""Vendor - Trial Balance"(Action 1906387606)".

        }

        modify(ApprovalEntries)
        {
            Visible = false;
        }



        modify("Mapping Text to Account")
        {
            Visible = false;
        }


        modify(ApplyTemplate)
        {
            Visible = false;
        }
        modify(PayVendor)
        {
            Visible = false;
        }
        // modify(Display)
        // {
        //     Visible = false;
        // }
        // modify(ReportFactBoxVisibility)
        // {
        //     Visible = false;
        // }
        modify(OCR)
        {
            Visible = false;
        }
        modify(Resync)
        {
            Visible = false;
        }


    }




    local procedure SetSocialListeningFactboxVisibility()
    var
    //SocialListeningMgt: Codeunit 871;
    begin
        //SocialListeningMgt.GetVendFactboxVisibility(Rec, SocialListeningSetupVisible, SocialListeningVisible);
    end;

}
