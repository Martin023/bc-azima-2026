namespace KenpipeCBS.KenpipeCBS;

report 52186221 UpdateDormantAccounts
{
    ApplicationArea = All;
    Caption = 'UpdateDormantAccounts';
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        // dataitem(SavingsAccounts; "Savings Accounts")
        // {
        //     DataItemTableView = where("Product Type" = filter(<> '191' & <> '1'), Status = const(Dormant));
        //     column(MemberNo; "Member No.")
        //     {
        //     }
        //     column(No; "No.")
        //     {
        //     }
        //     trigger OnAfterGetRecord()
        //     begin
        //         SavingsAccounts.Status := SavingsAccounts.Status::Active;
        //         SavingsAccounts.Modify();
        //     end;
        // }
        // dataitem(Members; Members)
        // {
        //     DataItemTableView = where(Status = const(Deceased));

        //     trigger OnAfterGetRecord()
        //     begin
        //         SavingsAccounts.Reset();
        //         SavingsAccounts.SetRange("Member No.", Members."No.");
        //         if SavingsAccounts.FindFirst() then begin
        //             repeat
        //                 if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"Share Capital" then begin
        //                     SavingsAccounts.CalcFields("Balance (LCY)");
        //                     if SavingsAccounts."Balance (LCY)" > 0 then begin
        //                         Members.Subflag := Members.Subflag::"Pending Share Capital Transfer";
        //                         Members.Modify();
        //                     end;
        //                 end;
        //                 SavingsAccounts.Status := SavingsAccounts.Status::Deceased;
        //                 SavingsAccounts.Modify();
        //             until SavingsAccounts.Next = 0;
        //         end;
        //     end;
        // }
        dataitem(SaVacc; "Savings Accounts")
        {
            DataItemTableView = where(Status = const(Active), "Product Type" = const('1'));

            trigger OnAfterGetRecord()
            begin
                OtherAcc.reset();
                OtherAcc.SetRange("Member No.", SaVacc."Member No.");
                OtherAcc.setfilter("Product Type", '<>%1', '191');
                if OtherAcc.FindFirst() then begin
                    repeat
                        OtherAcc.Status := OtherAcc.Status::Active;
                        OtherAcc.Modify();
                    until OtherAcc.Next = 0;
                end;
                if Members.get(SaVacc."Member No.") then begin
                    Members.Status := Members.Status::Active;
                    if Members.Subflag = Members.Subflag::Withdrawal then
                        Members.Subflag := Members.Subflag::Rejoined;
                    Members.Modify();
                end;
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
        //SavingsAccounts: record "Savings Accounts";
        OtherAcc: record "Savings Accounts";
        Members: record Members;

}
