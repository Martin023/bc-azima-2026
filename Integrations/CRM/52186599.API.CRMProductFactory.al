page 52186599 "CRM Product Factory API"
{
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'productFactoryAPI';
    DelayedInsert = true;
    EntityName = 'product';
    EntitySetName = 'products';
    PageType = API;
    SourceTable = "Product Factory";

    EntityCaption = 'Product';
    EntitySetCaption = 'Products';

    ODataKeyFields = SystemId;
    
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(category; Rec.Category)
                {
                    Caption = 'Category';
                }
                field(productCategory; Rec."Product Category")
                {
                    Caption = 'Product Category';
                }
                field(name; Rec."Product Description")
                {
                    Caption = 'Product Description';
                }
                field(productNo; Rec."Product ID")
                {
                    Caption = 'Product No';
                }
                field(minimumGuarantors; Rec."Minimum Guarantors")
                {
                    Caption = 'Minimum Guarantors';
                }
                field(maximumGuarantors; Rec."Maximum Guarantors")
                {
                    Caption = 'Maximum Guarantors';
                }
                field(repaymentFrequency; Rec."Repayment Frequency")
                {
                    Caption = 'Repayment Frequency';
                }
                field(interestRateMax; Rec."Interest Rate (Max.)")
                {
                    Caption = 'Interest Rate (Max.)';
                }
                field(interestRateMin; Rec."Interest Rate (Min.)")
                {
                    Caption = 'Interest Rate (Min.)';
                }
                field(minimumLoanAmount; Rec."Minimum Loan Amount")
                {
                    Caption = 'Minimum Loan Amount';
                }
                field(maximumLoanAmount; Rec."Maximum Loan Amount")
                {
                    Caption = 'Maximum Loan Amount';
                }
                field(minTerm; Rec."Min. Mobile Installments")
                {
                    Caption = 'Min. Installments';
                }
                field(maxTerm; Rec."Ordinary Default Intallments")
                {
                    Caption = 'Max. Installments';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
