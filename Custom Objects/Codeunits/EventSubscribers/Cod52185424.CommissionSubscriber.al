namespace MNS.MNS;
using System.Security.User;

codeunit 52185424 EventSubscribers
{

    // [EventSubscriber(ObjectType::Table, 52185700, 'OnAfterInsertEvent', '', false, false)]
    // local procedure OnMembersInsert(Rec: Record "Members"); //xRec: Record "Members")
    // var
    //     Recruiter: Record "Members";
    //     Commission: Record "Commission";
    //     RecruitCount: Integer;
    //     CommissionableCount: Integer;
    //     CommissionAmount: Decimal;

    // begin
    //     if Rec."Recruited By" = '' then
    //         exit;

    //     // Find the recruiter
    //     RecruitCount := 0;
    //     Recruiter.SetRange(Recruiter.Name, Rec."Recruited By");
    //     if Recruiter.FindFirst() then begin
    //         // Count how many members this recruiter has recruited
    //         Recruiter.SetRange(Recruiter."Recruited By", Rec."Recruited By");

    //         RecruitCount := Recruiter.Count();

    //         // If recruits are over 43, calculate commission
    //         if RecruitCount > 43 then begin
    //             CommissionableCount := RecruitCount - 43;
    //             CommissionAmount := CommissionableCount * 1000;

    //             // Insert a new record into the Commission table
    //             Commission.Init();
    //             Commission."MemberID" := Rec."Recruited By";
    //             Commission.CommissionAmount := CommissionableCount;
    //             Commission."CommissionAmount" := CommissionAmount;
    //             Commission.Insert();
    //         end;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnBeforeDelegateApprovalRequests', '', false, false)]
    procedure OnDelegateApprovalEntry()
    begin
        userSetup.get(UserId);
        if not userSetup."Delegate Approval" then
            Error('You do not have permission to delegate approval requests. Contact system administrator for assistance.');
    end;

    var
        userSetup: record "User Setup";

}
