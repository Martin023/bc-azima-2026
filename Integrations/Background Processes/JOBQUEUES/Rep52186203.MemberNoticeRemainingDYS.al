namespace KenpipeCBS.KenpipeCBS;

report 52186203 MemberNoticeRemainingDYS
{
    ApplicationArea = All;
    Caption = 'Member Withdrawal Notice Remaining DYS';
    UsageCategory = Tasks;
    processingonly = true;
    dataset
    {
        dataitem(MemberwithdrawalNotice; "Member withdrawal Notice")
        {
            DataItemTableView = where(Status = const(Approved), "Clossure Created" = const(false));
            column(No; "No.")
            {
            }
            column(WithdrawalNoticeDate; "Withdrawal Notice Date")
            {
            }
            column(IDNo; "ID No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                if MemberwithdrawalNotice."Withdrawal Notice Date" <> 0D then
                    if MemberwithdrawalNotice."Date Modified" <> today then begin
                        MemberwithdrawalNotice.validate("No. of Days Remaining");
                        MemberwithdrawalNotice.Modify(true);

                        if MemberwithdrawalNotice."No. of Days Remaining" = 0 then begin
                            CreateClosure(MemberwithdrawalNotice);
                        end;
                    end;

            end;
        }
    }
    procedure CreateClosure(MemberwithdrawalNotice: Record "Member withdrawal Notice")
    var
        Member: record Members;
        MembershipClosure: Record "Membership Closure";
        MemNoticePage: page "Member withdrawal Notice";
    begin
        MemberwithdrawalNotice.TestField("Sent Back to CRM", false);
        MemberwithdrawalNotice.TestField("Member No.");
        MemberwithdrawalNotice.TestField("Notice Type");
        MemberwithdrawalNotice.TestField("Reason for withdrawal");
        MemberwithdrawalNotice.TestField("Notice Finalized", false);

        //Rec.Status := Rec.Status::Approved;
        MemberwithdrawalNotice."Clossure Created" := true;
        MemberwithdrawalNotice.Modify(true);

        Member.Reset();
        Member.SetRange("No.", MemberwithdrawalNotice."Member No.");
        if Member.FindFirst() then begin
            MemNoticePage.LogMemberSubStatus(Member."No.", Member.Subflag);
            Member.Subflag := Member.Subflag::"Pending Withdrawal";
            Member.Modify();
        end;

        MembershipClosure.Init();
        MembershipClosure."Closure Type" := MemberwithdrawalNotice."Notice Type";
        MembershipClosure.Insert(true);

        MemNoticePage.InsertLoanLines(MemberwithdrawalNotice, MembershipClosure);


        MembershipClosure.Validate("Notice Number", MemberwithdrawalNotice."No.");
        MembershipClosure.Modify(true);
    end;
}
