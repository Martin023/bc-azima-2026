report 52186855 ActivateMember
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    ProcessingOnly = true;

    dataset
    {

        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                savingsAct: Record "Savings Accounts";
            begin
                savingsAct.Reset();
                savingsAct.SetRange("Member No.", Members."No.");
                savingsAct.SetRange("Product Category", savingsAct."Product Category"::"FOSA Account");
                if savingsAct.FindFirst() then begin
                    if (savingsAct.Status = savingsAct.Status::Dormant) or (savingsAct.Status = savingsAct.Status::Active) then begin
                        savingsAct.Status := savingsAct.Status::Active;
                        savingsAct.Modify();
                    end;
                    MembersRec.Reset();
                    MembersRec.SetRange("No.", savingsAct."Member No.");
                    if MembersRec.FindFirst() then begin
                        MembersRec.Subflag := MembersRec.Subflag::"First time";
                        MembersRec.Status := MembersRec.Status::Active;
                        MembersRec.Modify();
                    end;

                end;

            end;

        }

    }
    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        Message('Update Done');
    end;

    var
        myInt: Integer;
        MembersRec: Record Members;
}