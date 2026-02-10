#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185882 "Update Virtual Members"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Update Virtual Members.rdl';

    dataset
    {
        dataitem("Member Application"; "Member Application")
        {
            //DataItemTableView = where("Virtual Member"=const(Yes));
            column(ReportForNavId_1; 1)
            {
            }
            dataitem(Members; Members)
            {
                DataItemLink = "Primary Identification" = field("Primary Identification");
                column(ReportForNavId_2; 2)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    // Members."Virtual Members" := true;
                    Members.Modify;

                    //create savings accounts
                    ProductFactory.SetFilter(ProductFactory.Status, '%1', ProductFactory.Status::Active);
                    ProductFactory.SetFilter(ProductFactory."Auto Open Account", '%1', true);
                    ProductFactory.SetFilter(ProductFactory."Product Category", '<>%1', ProductFactory."product category"::"Fixed Deposit");
                    if ProductFactory.Find('-') then begin
                        repeat
                            SavingsAcc.Init;
                            SavAcc.Reset;
                            SavAcc.SetRange("Member No.", Members."No.");
                            SavAcc.SetRange("Product Type", ProductFactory."Product ID");
                            if not SavAcc.Find('-') then begin
                                SavingsAcc."No." := ProductFactory."Account No. Prefix" + Members."No." + ProductFactory."Account No. Suffix";
                                SavingsAcc.Validate(SavingsAcc.Name, Members.Name);
                                SavingsAcc."ID No." := Members."Primary Identification";
                                SavingsAcc."Passport No." := Members."Secondary Identification";
                                //**SavingsAcc.VALIDATE(SavingsAcc."Monthly Contribution");
                                SavingsAcc."Customer Posting Group" := ProductFactory."Product Posting Group";
                                SavingsAcc.County := Members.City;
                                SavingsAcc."Phone No." := Members."Phone No.";
                                SavingsAcc."Mobile Phone No" := Members."Phone No.";
                                SavingsAcc."Current Address" := Members."Current Address";
                                SavingsAcc."Post Code" := Members."Post Code";
                                SavingsAcc.City := Members.City;
                                SavingsAcc.Status := SavingsAcc.Status::New;
                                SavingsAcc."Country/Region Code" := Members.Nationality;
                                SavingsAcc."Home Address" := Members."Home Address";
                                SavingsAcc."Registration Date" := Today;
                                SavingsAcc."Recruited by Type" := Members."Recruited by Type";
                                SavingsAcc."Relationship Manager" := Members."Allocated Officer";
                                SavingsAcc."Date of Birth" := Members."Date of Birth";
                                SavingsAcc."Payroll/Staff No." := Members."Payroll/Staff No.";
                                SavingsAcc."Recruited By" := Members."Recruited By";
                                SavingsAcc.Gender := Members.Gender;
                                SavingsAcc."Member Category" := Members."Member Class";
                                SavingsAcc."Marital Status" := Members."Marital Status";
                                SavingsAcc."Old Member No." := Members."Old Member No.";
                                SavingsAcc."Associated Member No." := Members."Principle Member";
                                SavingsAcc."Responsibility Center" := Members."Responsibility Center";
                                SavingsAcc."Company Registration No." := Members."Company Registration No.";
                                SavingsAcc."Employer Code" := Members."Employer Code";
                                //SavingsAcc."Single Party/Multiple/Business":=Members."Single Party/Multiple/Business";
                                SavingsAcc."Global Dimension 1 Code" := Members."Global Dimension 1 Code";
                                SavingsAcc."Global Dimension 2 Code" := Members."Global Dimension 2 Code";
                                SavingsAcc."Group Account No" := Members."Group Account No.";
                                SavingsAcc."Created By" := Members."Created By";

                                if not ProductFactory."Loan Disbursement Account" then
                                    SavingsAcc."Loan Disbursement Account" := false
                                else
                                    SavingsAcc."Loan Disbursement Account" := true;

                                if SavingsAcc."Loan Disbursement Account" = true then
                                    FOSAACC := SavingsAcc."No.";
                                SavingsAcc."Product Category" := ProductFactory."Product Category";
                                // if Members."Membership Option" = Members."membership option"::Agent then begin
                                //     // if ProductFactory."Product Category" = ProductFactory."product category"::"Agent Account" then begin
                                //     //     FOSAACC := SavingsAcc."No.";
                                //     // end;
                                // end;
                                SavingsAcc."Product Type" := ProductFactory."Product ID";
                                SavingsAcc."Product Name" := ProductFactory."Product Description";
                                SavingsAcc."Member No." := Members."No.";
                                SavingsAcc.Insert;
                            end;
                        until ProductFactory.Next = 0;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Member Application"."Application Date" < CalcDate('-CM', Today) then CurrReport.Skip;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ProductFactory: Record "Product Factory";
        SavingsAcc: Record "Savings Accounts";
        SavAcc: Record "Savings Accounts";
        FOSAACC: Code[30];
}
