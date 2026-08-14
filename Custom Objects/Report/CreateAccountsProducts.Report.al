namespace KenpipeCBS.KenpipeCBS;

report 52185551 CreateAccountsProducts
{
    ApplicationArea = All;
    Caption = 'Create Accounts and Products';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Members; Members)
        {
            trigger OnPreDataItem()
            begin
                // Apply member filter if provided
                if MemberNoFilter <> '' then
                    Members.SetRange("No.", MemberNoFilter);
                
                // Validate at least one product is selected
                if (Product1 = '') and (Product2 = '') then
                    Error('You must select at least one product to create');
                
                AccountsCreated := 0;
            end;
            
            trigger OnAfterGetRecord()
            var
                ProductsToCreate: List of [Code[20]];
                ProductCode: Code[20];
            begin
                // Build list of products to create
                if Product1 <> '' then
                    ProductsToCreate.Add(Product1);
                if Product2 <> '' then
                    ProductsToCreate.Add(Product2);
                
                // Loop through selected products only
                foreach ProductCode in ProductsToCreate do begin
                    if ProductFactory.Get(ProductCode) then begin
                        SavingsAcc.Reset();
                        SavingsAcc.SetRange("Member No.", Members."No.");
                        SavingsAcc.SetRange("Product Type", ProductFactory."Product ID");
                        if not SavingsAcc.FindFirst() then begin
                            AccountNo := RegistrationProcess.CreateSavingsAccountNo(ProductFactory."Product ID", Members."Global Dimension 1 Code", Members."No.");
                            SavingsAcc.Init;
                            SavingsAcc."No." := AccountNo;
                            SavingsAcc.Validate(SavingsAcc.Name, Members.Name);
                            SavingsAcc."ID No." := Members."Primary Identification";
                            SavingsAcc."Passport No." := Members."Secondary Identification";
                            SavingsAcc."Customer Posting Group" := ProductFactory."Product Posting Group";
                            SavingsAcc.County := Members.City;
                            SavingsAcc."Phone No." := Members."Phone No.";
                            SavingsAcc."Transactional Mobile No" := Members."Phone No.";
                            SavingsAcc."Current Address" := Members."Current Address";
                            SavingsAcc."Post Code" := Members."Post Code";
                            SavingsAcc.City := Members.City;
                            SavingsAcc.Status := SavingsAcc.Status::New;
                            if Members."Account Type" = Members."Account Type"::"Group Account" then
                                SavingsAcc.Status := ProductFactory."Auto Openning Account Status";
                            SavingsAcc."Country/Region Code" := Members.Nationality;
                            SavingsAcc."Home Address" := Members."Home Address";
                            SavingsAcc."Registration Date" := Today;
                            SavingsAcc."Recruited by Type" := Members."Recruited by Type";
                            SavingsAcc."Relationship Manager" := Members."Allocated Officer";
                            SavingsAcc."Date of Birth" := Members."Date of Birth";
                            SavingsAcc."Payroll/Staff No." := Members."Payroll/Staff No.";
                            SavingsAcc."Recruited By" := Members."Recruited By";
                            SavingsAcc."Member Category" := Members."Member Class";
                            SavingsAcc."Marital Status" := Members."Marital Status";
                            SavingsAcc."Old Member No." := Members."Old Member No.";
                            SavingsAcc."Responsibility Center" := Members."Responsibility Center";
                            SavingsAcc."Company Registration No." := Members."Company Registration No.";
                            SavingsAcc."Employer Code" := Members."Employer Code";
                            SavingsAcc."Global Dimension 1 Code" := Members."Global Dimension 1 Code";
                            SavingsAcc."Global Dimension 2 Code" := ProductFactory."Global Dimension 2 Code";
                            if SavingsAcc."Global Dimension 2 Code" = '' then
                                SavingsAcc."Global Dimension 2 Code" := Members."Global Dimension 2 Code";
                            SavingsAcc."Group Account No" := Members."Group Account No.";
                            SavingsAcc."Created By" := Members."Created By";
                            if MemberClass.get(Members."Member Class") then begin
                                case
                                    ProductFactory."Product Category" of
                                    ProductFactory."Product Category"::"Share Capital":
                                        SavingsAcc."Monthly Contribution" := MemberClass."Default Share Capital";
                                    ProductFactory."Product Category"::"BOSA Deposits":
                                        SavingsAcc."Monthly Contribution" := MemberClass."Default BOSA Deposit";
                                    ProductFactory."Product Category"::"Entrance Fee":
                                        SavingsAcc."Monthly Contribution" := MemberClass."Entrance Fee";
                                end;
                            end
                            else
                                SavingsAcc."Monthly Contribution" := ProductFactory."Minimum Contribution";


                            if not ProductFactory."Loan Disbursement Account" then
                                SavingsAcc."Loan Disbursement Account" := false
                            else
                                SavingsAcc."Loan Disbursement Account" := true;

                            SavingsAcc."Product Category" := ProductFactory."Product Category";
                            SavingsAcc."Product Type" := ProductFactory."Product ID";
                            SavingsAcc."Product Name" := ProductFactory."Product Description";
                            SavingsAcc."Member No." := Members."No.";
                            SavingsAcc.Status := ProductFactory."Auto Openning Account Status";
                            SavingsAcc.Insert;
                            AccountsCreated += 1;
                        end else begin
                            Error('Account for product %1 - %2 already exists for member %3', ProductFactory."Product ID", ProductFactory."Product Description", Members."No.");
                        end;
                    end else begin
                        Error('Product %1 not found in Product Factory', ProductCode);
                    end;
                end;
                
                // Create member factbox if not exists
                if not MemberFactBox.get(Members."No.") then begin
                    MemberFactBox.Init();
                    MemberFactBox."Member No." := Members."No.";
                    MemberFactBox.Insert();
                end;
            end;
            
            trigger OnPostDataItem()
            begin
                if AccountsCreated > 0 then
                    Message('%1 account(s) created successfully for member %2 - %3', AccountsCreated, Members."No.", Members.Name)
                else
                    Message('No accounts were created');
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Account Creation")
                {
                    Caption = 'Account Creation Details';
                    field(MemberNoFilter; MemberNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Member No.';
                        Editable = false;
                        ToolTip = 'Member number for account creation';
                    }
                    field(MemberNameDisplay; MemberNameDisplay)
                    {
                        ApplicationArea = All;
                        Caption = 'Member Name';
                        Editable = false;
                        ToolTip = 'Name of the member';
                    }
                    field(Product1; Product1)
                    {
                        ApplicationArea = All;
                        Caption = 'Product 1 (Required)';
                        TableRelation = "Product Factory"."Product ID" where("Auto Open Account" = const(true));
                        ToolTip = 'Select the first product to create';
                        
                        trigger OnValidate()
                        begin
                            if Product1 <> '' then begin
                                if ProductFactory.Get(Product1) then
                                    Product1Name := ProductFactory."Product Description"
                                else
                                    Product1Name := '';
                            end else
                                Product1Name := '';
                        end;
                    }
                    field(Product1Name; Product1Name)
                    {
                        ApplicationArea = All;
                        Caption = 'Product 1 Name';
                        Editable = false;
                    }
                    field(Product2; Product2)
                    {
                        ApplicationArea = All;
                        Caption = 'Product 2 (Optional)';
                        TableRelation = "Product Factory"."Product ID" where("Auto Open Account" = const(true));
                        ToolTip = 'Optionally select a second product to create';
                        
                        trigger OnValidate()
                        begin
                            if Product2 <> '' then begin
                                if Product2 = Product1 then
                                    Error('Product 2 cannot be the same as Product 1');
                                if ProductFactory.Get(Product2) then
                                    Product2Name := ProductFactory."Product Description"
                                else
                                    Product2Name := '';
                            end else
                                Product2Name := '';
                        end;
                    }
                    field(Product2Name; Product2Name)
                    {
                        ApplicationArea = All;
                        Caption = 'Product 2 Name';
                        Editable = false;
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
        
        trigger OnOpenPage()
        begin
            // Auto-populate member name when page opens
            if MemberNoFilter <> '' then begin
                if Members.Get(MemberNoFilter) then
                    MemberNameDisplay := Members.Name
                else
                    MemberNameDisplay := 'Member not found';
            end;
        end;
    }
    var
        SavingsAcc: Record "Savings Accounts";
        ProductFactory: record "Product Factory";
        RegistrationProcess: Codeunit "Registration Process";
        AccountNo: Code[50];
        MemberClass: record "Member Classes";
        MemberFactBox: Record "Member FactBox";
        MemberNoFilter: Code[20];
        MemberNameDisplay: Text[100];
        Product1: Code[20];
        Product1Name: Text[100];
        Product2: Code[20];
        Product2Name: Text[100];
        AccountsCreated: Integer;
    
    procedure SetMemberFilter(MemberNo: Code[20])
    begin
        MemberNoFilter := MemberNo;
    end;
}
