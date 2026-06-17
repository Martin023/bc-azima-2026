codeunit 52185456 "Department Targets Management"
{
    procedure CopyPreviousYearTargets(NewTargetNo: Code[20]; PreviousYear: Integer)
    var
        PreviousHeader: Record "HR Department Targets Header";
        PreviousLine: Record "HR Department Target Line";
        NewLine: Record "HR Department Target Line";
        NewHeader: Record "HR Department Targets Header";
        LineNo: Integer;
    begin
        if not NewHeader.Get(NewTargetNo) then
            Error('Target No %1 does not exist.', NewTargetNo);

        PreviousHeader.Reset;
        PreviousHeader.SetRange("Responsibility Center", NewHeader."Responsibility Center");
        PreviousHeader.SetRange("Appraisal Year", PreviousYear);
        PreviousHeader.SetRange(Status, PreviousHeader.Status::Approved);
        if PreviousHeader.FindFirst then begin
            PreviousLine.Reset;
            PreviousLine.SetRange("Department Target No", PreviousHeader."Target No");
            if PreviousLine.Find('-') then begin
                LineNo := 0;
                repeat
                    LineNo := LineNo + 1;
                    NewLine.Init;
                    NewLine."Line No" := LineNo;
                    NewLine."Department Target No" := NewTargetNo;
                    NewLine."Perspective Code" := PreviousLine."Perspective Code";
                    NewLine.Objective := PreviousLine.Objective;
                    NewLine.Strategy := PreviousLine.Strategy;
                    NewLine.Measures := PreviousLine.Measures;
                    NewLine.Baseline := PreviousLine."Achieved Score";
                    NewLine."Targeted Score" := PreviousLine."Targeted Score";
                    NewLine."Start Date" := PreviousLine."Start Date";
                    NewLine."End Date" := PreviousLine."End Date";
                    NewLine.Insert;
                until PreviousLine.Next = 0;
            end;
        end else begin
            Error('No approved targets found for Department %1 in Year %2', NewHeader."Responsibility Center", PreviousYear);
        end;
    end;

    procedure CheckHODAccess(UserID: Code[50]; DepartmentCode: Code[20]): Boolean
    var
        HREmp: Record "HR Employees";
        HRHOD: Record "HR Heads of Departments";
    begin
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserID);
        if HREmp.Find('-') then begin
            HRHOD.Reset;
            HRHOD.SetRange(HRHOD."Employee No.", HREmp."No.");
            HRHOD.SetRange(HRHOD."Responsibility center", DepartmentCode);
            if HRHOD.Find('-') then
                exit(true);
        end;
        exit(false);
    end;

    procedure GetHODDepartments(UserID: Code[50]): Text
    var
        HREmp: Record "HR Employees";
        HRHOD: Record "HR Heads of Departments";
        DepartmentList: Text;
    begin
        DepartmentList := '';
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserID);
        if HREmp.Find('-') then begin
            HRHOD.Reset;
            HRHOD.SetRange(HRHOD."Employee No.", HREmp."No.");
            if HRHOD.Find('-') then begin
                repeat
                    if DepartmentList = '' then
                        DepartmentList := HRHOD."Responsibility center"
                    else
                        DepartmentList := DepartmentList + '|' + HRHOD."Responsibility center";
                until HRHOD.Next = 0;
            end;
        end;
        exit(DepartmentList);
    end;

    procedure IsHOD(UserID: Code[50]): Boolean
    var
        HREmp: Record "HR Employees";
        HRHOD: Record "HR Heads of Departments";
    begin
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserID);
        if HREmp.Find('-') then begin
            HRHOD.Reset;
            HRHOD.SetRange(HRHOD."Employee No.", HREmp."No.");
            if HRHOD.Find('-') then
                exit(true);
        end;
        exit(false);
    end;
}