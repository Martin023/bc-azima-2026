Report 52185982 "UnClaimed Branch Allocation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/UnClaimed Branch Allocation.rdl';

    dataset
    {
        dataitem("Fosa Payments Header"; "Fosa Payments Header")
        {
            DataItemTableView = where(Posted = filter(false), Status = filter(Approved));
            column(No_; "No.")
            {
            }
            column(Date; Date)
            {
            }
            column(Date_Posted; "Date Posted")
            {
            }
            column(Posted; Posted)
            {
            }
            column(Posted_By; "Posted By")
            {
            }
            column(Cheque_No_; "Cheque No.")
            {
            }
            column(Cashier; Cashier)
            {
            }
            column(Status; Status)
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
            dataitem("FOSA Payment Line"; "FOSA Payment Line")
            {
                DataItemLink = No = FIELD("No.");

                column(Type; Type)
                {
                }
                column(Account_Type; "Account Type")
                {
                }
                column(Account_No_; "Account No.")
                {
                }
                column(Account_Name; "Account Name")
                {
                }
                column(Description; Description)
                {
                }
                column(Function_Name; "Function Name")
                {
                }
                column(Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
                {
                }
                column(Amount; Amount)
                {
                }
                column(Signatory; Signatory)
                {

                }

                trigger OnAfterGetRecord()
                var
                    SavAcc: Record "Savings Accounts";
                    AccSignatories: Record "Account Signatories";
                begin

                    SavAcc.Reset();
                    SavAcc.SetRange("No.", "FOSA Payment Line"."Account No.");
                    SavAcc.SetRange("Global Dimension 1 Code", "FOSA Payment Line"."Global Dimension 1 Code");
                    if SavAcc.Find('-') then begin

                        AccSignatories.Reset();
                        AccSignatories.SetRange("Account No", SavAcc."No.");
                        if AccSignatories.Find('-') then
                            repeat
                                Signatory := AccSignatories.Names;
                            until AccSignatories.Next() = 0;
                    end;

                end;

            }

            trigger OnPreDataItem()
            begin
                // if StartDate = 0D then Error('Kindly set the start date');
                // if EndDate = 0D then Error('Kindly set the end date');
                // // Company.Get;
                // Company.CalcFields(Picture);
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
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        StartDate: Date;
        EndDate: Date;
        Company: Record "Company Information";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Signatory: Text[100];
}

