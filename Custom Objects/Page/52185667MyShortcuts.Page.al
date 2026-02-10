page 52185667 "My Shortcuts"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
    }

    actions
    {
        area(processing)
        {
            action("Insert Grades (AFFA 1 - 12)")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    GradeCode: Code[10];
                begin
                    //*********************************************************************************************************
                    if Confirm('Insert Grade [ AFFA 1 - 12 ] in HR Lookup Values table') = false then exit;
                    HRLookVal.Reset;
                    HRLookVal.Init;
                    MyCounter := 0;
                    repeat
                        if MyCounter < 9 then GradeCode := 'AFFA0' else GradeCode := 'AFFA';

                        HRLookVal.Type := HRLookVal.Type::Grade;
                        HRLookVal.Code := GradeCode + Format(MyCounter + 1);
                        HRLookVal.Description := 'GRADE ' + HRLookVal.Code;
                        MyCounter += 1;
                        HRLookVal.Insert;

                    until MyCounter = 12;
                    Message('[' + Format(MyCounter) + '] - ' + PROCESSCOMPLETE)
                    //*********************************************************************************************************
                    //*********************************************************************************************************
                end;
            }
            action("Update HR Employee Status")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    /*
                    HREmp.RESET;
                    HREmp.SETFILTER(HREmp."No.",'%1..%2','AFFA_0001','AFFA_0308');
                    IF HREmp.FINDFIRST THEN
                    BEGIN
                        REPEAT
                            HREmp.Status:=HREmp.Status::"Pending Approval";
                            HREmp."Company E-Mail":='dwesa@coretec.co.ke';
                            HREmp.MODIFY;
                        UNTIL HREmp.NEXT = 0;
                    END;
                    
                    HREmp.RESET;
                    HREmp.SETFILTER(HREmp."No.",'%1..%2','AFFA_0308','AFFA_0383');
                    IF HREmp.FINDFIRST THEN
                    BEGIN
                        REPEAT
                            HREmp.Status:=HREmp.Status::Active;
                            HREmp."Company E-Mail":='dwesa@coretec.co.ke';
                            HREmp.MODIFY;
                        UNTIL HREmp.NEXT = 0;
                    END;
                    
                    HREmp.RESET;
                    HREmp.SETFILTER(HREmp."No.",'%1..%2','AFFA_0383','AFFA_0477');
                    IF HREmp.FINDFIRST THEN
                    BEGIN
                        REPEAT
                            HREmp.Status:=HREmp.Status::New;
                            HREmp."Company E-Mail":='dwesa@coretec.co.ke';
                            HREmp.MODIFY;
                        UNTIL HREmp.NEXT = 0;
                        MESSAGE('DONE');
                    END;
                    
                    
                    
                    HREmp.RESET;
                    HREmp.SETFILTER(HREmp.Status,'%1',HREmp.Status::Active);
                    IF HREmp.FINDFIRST THEN
                    BEGIN
                        HREmp.MODIFYALL(HREmp.Status,HREmp.Status::New);
                    END;
                    
                    MESSAGE('DONE');
                    */
                    //*********************************************************************************************************

                end;
            }
        }
    }

    var
        HRLookVal: Record "HR Lookup Values";
        MyCounter: Integer;
        PROCESSCOMPLETE: Label 'Process Complete';
        HREmp: Record "HR Employees";
}

