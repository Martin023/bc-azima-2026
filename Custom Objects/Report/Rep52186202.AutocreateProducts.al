namespace KenpipeCBS.KenpipeCBS;

report 52186202 AutocreateProducts
{
    ApplicationArea = All;
    Caption = 'AutocreateProducts';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where(Status = filter(new));
            trigger OnAfterGetRecord()
            begin
                productFactory.reset();
                ProductFactory.setrange("Auto Open Account", true);
                if ProductFactory.findfirst() then begin
                    repeat
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
                        end;
                        //if SavingsAcc.Status:= SavingsAcc.Status::" " then
                    until ProductFactory.next = 0;
                end;
                if not MemberFactBox.get(Members."No.") then begin
                    MemberFactBox.Init();
                    MemberFactBox."Member No." := Members."No.";
                    MemberFactBox.Insert();
                end;
                if Members."No." = '' then
                    Members.Delete();

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        SavingsAcc: Record "Savings Accounts";
        ProductFactory: record "Product Factory";
        RegistrationProcess: Codeunit "Registration Process";
        AccountNo: Code[50];
        MemberClass: record "Member Classes";
        MemberFactBox: Record "Member FactBox";
}
