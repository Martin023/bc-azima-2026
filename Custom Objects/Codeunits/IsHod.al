codeunit 52185458 "HOD Management"
{
    procedure IsHOD(UserID: Code[50]): Boolean
    var
        HRHOD: Record "HR Heads of Departments";
    begin
        HRHOD.SetRange("User ID", UserID);
        exit(HRHOD.FindFirst());
    end;
}