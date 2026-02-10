report 52186371 "Purchase Requisition Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Purchase Requisition Form.rdl';

    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            DataItemTableView = where("Document Type" = CONST(Quote),
                            DocApprovalType = CONST(Requisition));

            column(PurchaseReqNo; "No.")
            {

            }
            column(UserID; "Assigned User ID")
            {

            }
            column(Branch; "Shortcut Dimension 1 Code")
            {

            }
            column(Date; "Document Date")
            {

            }
            column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
            {

            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(BudgetedAmount; BudgetedAmount)
            {

            }
            column(Expenditure; Expenditure)
            {

            }
            column(AvailableBal; AvailableBal)
            {

            }
            column(ItemGL; ItemGL)
            {

            }
            column(Name; Name)
            {

            }

            dataitem(PurchaseLine; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where("Document Type" = filter(Quote), Type = filter(Item));
                column(PurchLineNo; "No.")
                {

                }
                column(Document_No_; "Document No.")
                {

                }
                column(Description; Description)
                {

                }
                column(Description_2; "Description 2")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Direct_Unit_Cost; "Direct Unit Cost")
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }
                COLUMN(Amount_Including_VAT; "Amount Including VAT")
                {

                }
                trigger OnAfterGetRecord()

                var
                    item: record Item;
                    GLAccount: record "G/L Account";
                    PurchLine: record "Purchase Line";
                    PurchHeader: record "Purchase Header";
                begin
                    BudgetedAmount := 0;
                    Expenditure := 0;
                    AvailableBal := 0;
                    Line_Amount := 0;

                    PurchLineNo := '';

                    Direct_Unit_Cost := 0;
                    Item.reset();
                    Item.SetRange("No.", PurchaseLine."No.");
                    if Item.find('-') then begin
                        repeat
                            ItemGL := item."Item G/L Budget Account";
                            GLAccount.reset();
                            GLAccount.SetRange("No.", item."Item G/L Budget Account");
                            IF GLAccount.find('-') then begin
                                GLAccount.CalcFields("Budgeted Amount");
                                BudgetedAmount := GLAccount."Budgeted Amount";
                                Name := GLAccount.Name;
                                Commitment.reset();
                                //Commitment.Setrange(Budget,Commitment.Budget);
                                Commitment.SetRange("G/L Account No.", GLAccount."No.");
                                if commitment.FindFirst() then begin
                                    Commitment.CalcSums(Amount);
                                    Expenditure := Commitment.Amount;
                                    AvailableBal := BudgetedAmount - Expenditure;

                                end;

                            end;
                        Until item.next = 0;

                    end;
                end;

            }
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        ItemGL: code[30];
        BudgetedAmount: Decimal;
        Name: text[100];
        Commitment: record Committment;
        Expenditure: decimal;
        AvailableBal: decimal;
        PurchLineNo: code[40];
        Description: text[100];
        Quantity: decimal;
        Direct_Unit_Cost: decimal;
        Line_Amount: decimal;
}

