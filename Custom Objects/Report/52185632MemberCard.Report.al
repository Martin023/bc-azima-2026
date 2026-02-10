#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185632 "Member Card"
{
    DefaultLayout = RDLC;
    // RDLCLayout = './bc-kenpipe-2024/Layout/CustomerAging.rdl';
    RDLCLayout = './bc-kenpipe-2024/Layout/Member Card.rdl';

    Caption = 'Member Card';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";
            column(Name; Name)
            {
            }
            column(No; "No.")
            {
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {
            }
            column(Primary_Identification_Type; "Primary Identification Type") { }
            column(PrimaryIdentification; "Primary Identification")
            {
            }
            column(Marital_Status; "Marital Status") { }

            column(Payroll_Staff_No_; "Payroll/Staff No.")
            {
            }

            column(Phone_No_; "Phone No.")
            {
            }

            column(DirectorName; Name)
            {
            }
            column(CEOName; CompanyInformation."CEO")
            {
            }
            column(Picture; CompanyInformation.Picture)
            {
            }
            
            column(CompanyName; CompanyInformation."Name")
            {
            }
            column(ISOCertification; CompanyInformation."ISO Certification")
            {
            }
            column(PostOfficeAddress; CompanyInformation."Address")
            {
            }
            column(SACCOName; CompanyInformation."Name")
            {
            }
            column(Telephone; CompanyInformation."Phone No.")
            {
            }
            column(Email; CompanyInformation."E-Mail")
            {
            }
            column(Website; CompanyInformation."Website")
            {
            }
            column(PhysicalAddress; CompanyInformation."Address 2")
            {
            }
            // dataitem(SavingsAccounts; "Savings Accounts")
            // {
            //     DataItemLink = "Member No." = field("No.");
            //     RequestFilterFields = "Member No.", "Product Category";
            //     column(Product_Category; "Product Category")
            //     {
            //     }
            //     column(ShareCapBalance; Balance)
            //     {
            //     }
            //     column(Member_No; "Member No.")
            //     {
            //     }
            column(NoofShares; NoofShares)
            {
            }
            column(ImageDataPicture; ImageData.Picture)
            {
            }
            column(ImageDataSignature; ImageData.Signature)
            {
            }
            column(FOSAAccount; FOSAAccount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SavingsAccounts.Reset();
                SavingsAccounts.SETRANGE("Member No.", Members."No.");
                SavingsAccounts.SetRange("Product Type", '002');
                SavingsAccounts.SETRANGE(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"FOSA Account");
                if SavingsAccounts.FindFirst() then begin
                    FOSAAccount := SavingsAccounts."No.";
                end;

                ImageData.Reset();
                ImageData.SetRange("Member No", Members."No.");
                if ImageData.Find('-') then begin
                    ImageData.CalcFields(Signature, Picture)
                end;
            end;

            trigger OnPostDataItem()
            begin
                if Confirm('Do you want to mark the card as printed?') then begin
                    GlobalFunctions.LogMemberCardPrinting(Members."No.");
                    Message('Member card has been marked as printed successfully');
                end;
            end;
        }
    }

    trigger OnPreReport()
    begin
        if CompanyInformation.Get then begin
            CompanyInformation.CalcFields(CompanyInformation.Picture);
            CompanyAddress := CompanyInformation.Address;
            Telephone := CompanyInformation."Phone No.";
            EMail := CompanyInformation."E-Mail";
            Website := CompanyInformation."Website";
            PhysicalAddress := CompanyInformation."Address 2";
        end;
    end;

    var
        CompanyInformation: Record "Company Information";
        Website: Text;
        Email: Code[250];
        Telephone: Code[250];
        FOSAAccount: Code[20];
        SACCOName: Code[250];
        CompanyAddress: Code[250];
        ISOCertification: Code[250];
        PhysicalAddress: Code[250];
        PostOfficeAddress: Code[250];
        SavingsAccount: Record "Savings Accounts";
        Product_Category: Code[250];
        ShareCapBalance: Decimal;
        Member_No: Code[250];
        ImageData: Record "Image Data";
        GenSetups: Record "General Set-up";
        ShareCertBuffer: Record "Share Certificate Buffer";
        ShareCapTranserBuffer: Record "Share Capital Transfer Buffer";
        ShareCapTranferLines: Record "Share Capital Transfer Lines";
        NoofShares: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        GlobalFunctions: Codeunit "Global Functions";


}

