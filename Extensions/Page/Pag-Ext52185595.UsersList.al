namespace AzimaBC.AzimaBC;

using System.Security.User;
using System.Security.AccessControl;

pageextension 52185595 "Users List" extends Users
{
    layout
    {
        addAfter("License Type")
        {
            field(GetRsponsibility; GetRsponsibility(rec."User Name"))
            {
                Caption = 'Responsibility Centre';
                ApplicationArea = All;
            }
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                Caption = 'Created At';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
            }
            field(CreatedBy; CreatedBy)
            {
                caption = 'Created By.';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemCreatedBy field.';
            }
            field(SystemModifiedAt; Rec.SystemModifiedAt)
            {
                Caption = 'Modified At';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
            }
            field(ModifiedBy; ModifiedBy)
            {
                Caption = 'Modified By';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemModifiedBy field.';
            }
        }

    }

    trigger OnAfterGetrecord()
    begin
        CreatedBy := Getusername(rec.SystemCreatedBy);
        ModifiedBy := Getusername(rec.SystemModifiedBy);
    end;

    trigger OnAfterGetCurrrecord()
    begin
        CreatedBy := Getusername(rec.SystemCreatedBy);
        ModifiedBy := Getusername(rec.SystemModifiedBy);
    end;

    var
        CreatedBy: code[40];
        ModifiedBy: code[40];

        Users: Record User;

    procedure GetUserName(UserSecurityID: Guid): Text;
    begin
        if Users.Get(UserSecurityID) then
            exit(Users."User Name");
    end;

    procedure GetRsponsibility(UserID: code[100]): Text;
    begin
        if Usersetup.get(UserID) then
            exit(Usersetup."Responsibility Centre");
    end;

    var
        Usersetup: record "User Setup";
}
