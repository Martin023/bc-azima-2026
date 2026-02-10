#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185526 "PR Bank Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/PR Bank Summary.rdl';

    dataset
    {
        dataitem("HR Bank Summary"; "HR Bank Summary")
        {

            column(StaffNo_PRBankSummary; "HR Bank Summary"."Staff No.")
            {
            }
            column(Amount_PRBankSummary; "HR Bank Summary".Amount)
            {
            }
            column(PayrollPeriod_PRBankSummary; "HR Bank Summary"."Payroll Period")
            {
            }
            column(BranchCode_PRBankSummary; "HR Bank Summary"."Branch Code")
            {
            }
            column(BranchName_PRBankSummary; "HR Bank Summary"."Branch Name")
            {
            }
            column(BankCode_PRBankSummary; "HR Bank Summary"."Bank Code")
            {
            }
            column(BankName_PRBankSummary; "HR Bank Summary"."Bank Name")
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoAddress; CompInfo.Address)
            {
            }
            column(CompInfoCity; CompInfo.City)
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(CompInfoEMail; CompInfo."E-Mail")
            {
            }
            column(CompInfoHomePage; CompInfo."Home Page")
            {
            }
            column(Num; Num)
            {
            }
            column(StaffName; StaffName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Num += 1;

                HREmp.Reset;
                if HREmp.Get("Staff No.") then begin
                    StaffName := UpperCase(HREmp."Full Name");
                end;
            end;

            trigger OnPreDataItem()
            begin
                //OnViewCurrRec();
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
        CompInfo: Record "Company Information";
        Num: Decimal;
        StaffName: Text;
        HREmp: Record "HR Employees";


    // procedure OnViewCurrRec()
    // var
    //     ChangePermission: Record "Status Change Permissions.";
    //     ErrorOnRestricViewTxt: label 'You do not have Permissions to VIEW,MODIFY or DELETE on this record. Contact system administrator for assistance. %';
    // begin
    //     ChangePermission.Reset;
    //     ChangePermission.SetRange("User ID", UserId);
    //     ChangePermission.SetRange("View Payroll", true);
    //     ChangePermission.SetRange("Function Extended", ChangePermission."function extended"::"View Payroll");
    //     if not ChangePermission.Find('-') then
    //         Error(ErrorOnRestricViewTxt, UserId);
    // end;
}
