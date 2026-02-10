#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185480 "Budget Allocation FP"
{

    trigger OnRun()
    begin
    end;


    procedure AutoAllocatePurch()
    var
        Budget: Record "Item Budget Name";
        DimVal: Record "Dimension Value";
        GLBudgetEntry: Record "Item Budget Entry";
        IntC: Integer;
        NewDate: Date;
        Period: Text[30];
        Amnt: Decimal;
        EntryNo: Integer;
        GL: Record Item;
    begin
        /*
        WITH Rec DO BEGIN
        
        //check if the date inserted as the start date is greater than the end date
        IF ("Start Date">"End Date") THEN
          BEGIN
            ERROR('Ending Date must BE greater than or equal to start date');
          END;
        {Get the new date selected by the user first}
        NewDate:="Start Date";
        {Get the period}
        IF "Period Type"="Period Type"::"0" THEN
          BEGIN
            Period:='D';
          END
        ELSE IF "Period Type"="Period Type"::"1" THEN
          BEGIN
            Period:='W';
          END
        ELSE IF "Period Type"="Period Type"::"2" THEN
          BEGIN
            Period:='M';
          END
        ELSE IF "Period Type"="Period Type"::"3" THEN
          BEGIN
            Period:='Q';
          END
        ELSE
          BEGIN
            Period:='Y';
          END;
        {Initiate the loop}
        WHILE NewDate<="End Date"
          DO
            BEGIN
              IntC:=IntC +1;
              NewDate:=CALCDATE('1' + Period,NewDate);
            END;
        {Number of times to divide amount has been identified}
        {Get the amount and get the amount per period identified}
        
        Amnt:=Amount/IntC;
        
        {Get the entry number}
        GLBudgetEntry.RESET;
        IF GLBudgetEntry.FIND('+') THEN
          BEGIN
            EntryNo:=GLBudgetEntry."Entry No.";
          END
        ELSE
          BEGIN
            EntryNo:=0;
          END;
        
        EntryNo:=EntryNo +1;
        {Check if the user wishes to overwrite the details already in the system}
        IF Overwrite=TRUE THEN
          BEGIN
            GLBudgetEntry.RESET;
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Name",Name);
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Item No.","Item No");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 1 Code","Global Dimension 1 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 2 Code","Global Dimension 2 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 1 Code","Budget Dimension 1 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 2 Code","Budget Dimension 2 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 3 Code","Budget Dimension 3 Code");
            IF GLBudgetEntry.FIND('-') THEN
              BEGIN
                GLBudgetEntry.DELETEALL;
              END;
          END;
        
        {Reset the new date}
        NewDate:="Start Date";
        {Initiate the loop to save the details into the table}
        WHILE NewDate<="End Date"
          DO
            BEGIN
            GLBudgetEntry.INIT;
            GLBudgetEntry."Entry No.":=EntryNo;
        
            GLBudgetEntry."Analysis Area":=GLBudgetEntry."Analysis Area"::Purchase;
        
            GLBudgetEntry."Budget Name":=Name;
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Name");
        
            GLBudgetEntry."Item No.":="Item No";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Item No.");
        //    GL.RESET;
        //    GL.GET("Item No");
        //      Forced to comment out by TChibo
        //    GLBudgetEntry."Item G/L Sales Account":=GL."Item G/L Sales Account";
        //    GLBudgetEntry."Item G/L Cost Account":=GLBudgetEntry."Item G/L Cost Account";
            GLBudgetEntry."Global Dimension 1 Code":="Global Dimension 1 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Global Dimension 1 Code");
        
            GLBudgetEntry."Global Dimension 2 Code":="Global Dimension 2 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Global Dimension 2 Code");
        
            GLBudgetEntry."Budget Dimension 1 Code":="Budget Dimension 1 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 1 Code");
        
            GLBudgetEntry."Budget Dimension 2 Code":="Budget Dimension 2 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 2 Code");
        
            GLBudgetEntry."Budget Dimension 3 Code":="Budget Dimension 3 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 3 Code");
        
            GLBudgetEntry.Date:=NewDate;
        
        
            IF "Show As"="Show As"::"0" THEN
              BEGIN
                GLBudgetEntry."Sales Amount":=Amnt;
              END
            ELSE IF "Show As"="Show As"::"1" THEN
              BEGIN
                GLBudgetEntry.Quantity:=Amnt;
              END
            ELSE IF "Show As"="Show As"::"2" THEN
              BEGIN
                GLBudgetEntry."Cost Amount":=Amnt;
              END;
        
            GLBudgetEntry."User ID":=USERID;
        
            GLBudgetEntry.INSERT;
            NewDate:=CALCDATE('1' + Period ,NewDate);
            EntryNo:=EntryNo + 1;
            END;
            Processed:=TRUE;
            Rec."User ID":=USERID;
            MODIFY;
        MESSAGE('Budgetary Allocation Complete');
        
        END;
        Rec.DELETE;
        */

    end;


    procedure AutoAllocateSale()
    var
        Budget: Record "Item Budget Name";
        DimVal: Record "Dimension Value";
        GLBudgetEntry: Record "Item Budget Entry";
        IntC: Integer;
        NewDate: Date;
        Period: Text[30];
        Amnt: Decimal;
        EntryNo: Integer;
        GL: Record Item;
    begin
        /*
        WITH Rec DO BEGIN
        
        //check if the date inserted as the start date is greater than the end date
        IF ("Start Date">"End Date") THEN
          BEGIN
            ERROR('Ending Date must BE greater than or equal to start date');
          END;
        
        {Get the new date selected by the user first}
        NewDate:="Start Date";
        {Get the period}
        IF "Period Type"="Period Type"::"0" THEN
          BEGIN
            Period:='D';
          END
        ELSE IF "Period Type"="Period Type"::"1" THEN
          BEGIN
            Period:='W';
          END
        ELSE IF "Period Type"="Period Type"::"2" THEN
          BEGIN
            Period:='M';
          END
        ELSE IF "Period Type"="Period Type"::"3" THEN
          BEGIN
            Period:='Q';
          END
        ELSE
          BEGIN
            Period:='Y';
          END;
        {Initiate the loop}
        WHILE NewDate<="End Date"
          DO
            BEGIN
              IntC:=IntC +1;
              NewDate:=CALCDATE('1' + Period,NewDate);
            END;
        {Number of times to divide amount has been identified}
        {Get the amount and get the amount per period identified}
        
        Amnt:=Amount/IntC;
        
        {Get the entry number}
        GLBudgetEntry.RESET;
        IF GLBudgetEntry.FIND('+') THEN
          BEGIN
            EntryNo:=GLBudgetEntry."Entry No.";
          END
        ELSE
          BEGIN
            EntryNo:=0;
          END;
        EntryNo:=EntryNo +1;
        {Check if the user wishes to overwrite the details already in the system}
        IF Overwrite=TRUE THEN
          BEGIN
            GLBudgetEntry.RESET;
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Name",Name);
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Item No.","Item No");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 1 Code","Global Dimension 1 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 2 Code","Global Dimension 2 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 1 Code","Budget Dimension 1 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 2 Code","Budget Dimension 2 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 3 Code","Budget Dimension 3 Code");
            IF GLBudgetEntry.FIND('-') THEN
              BEGIN
                GLBudgetEntry.DELETEALL;
              END;
          END;
        {Reset the new date}
        NewDate:="Start Date";
        {Initiate the loop to save the details into the table}
        WHILE NewDate<="End Date"
          DO
            BEGIN
            GLBudgetEntry.INIT;
            GLBudgetEntry."Entry No.":=EntryNo;
        
            GLBudgetEntry."Analysis Area":="Analysis Area"::"0";
        
            GLBudgetEntry."Budget Name":=Name;
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Name");
        
            GLBudgetEntry."Item No.":="Item No";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Item No.");
            GL.RESET;
            GL.GET("Item No");
        {
              Forced to comment out by TChibo
        //    GLBudgetEntry."Item G/L Sales Account":=GL."Item G/L Sales Account";
        //    GLBudgetEntry."Item G/L Cost Account":=GLBudgetEntry."Item G/L Cost Account";
        }
            GLBudgetEntry."Global Dimension 1 Code":="Global Dimension 1 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Global Dimension 1 Code");
        
            GLBudgetEntry."Global Dimension 2 Code":="Global Dimension 2 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Global Dimension 2 Code");
        
            GLBudgetEntry."Budget Dimension 1 Code":="Budget Dimension 1 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 1 Code");
        
            GLBudgetEntry."Budget Dimension 2 Code":="Budget Dimension 2 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 2 Code");
        
            GLBudgetEntry."Budget Dimension 3 Code":="Budget Dimension 3 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 3 Code");
        
            GLBudgetEntry.Date:=NewDate;
        
        
            IF "Show As"="Show As"::"0" THEN
              BEGIN
                GLBudgetEntry."Sales Amount":=Amnt;
              END
            ELSE IF "Show As"="Show As"::"1" THEN
              BEGIN
                GLBudgetEntry.Quantity:=Amnt;
              END
            ELSE IF "Show As"="Show As"::"2" THEN
              BEGIN
                GLBudgetEntry."Cost Amount":=Amnt;
              END;
        
            GLBudgetEntry."User ID":=USERID;
        
            GLBudgetEntry.INSERT;
            NewDate:=CALCDATE('1' + Period ,NewDate);
            EntryNo:=EntryNo + 1;
            END;
            Processed:=TRUE;
            Rec."User ID":=USERID;
            MODIFY;
        MESSAGE('Budgetary Allocation Complete');
        
        END;
        Rec.DELETE;
        */

    end;


    procedure AutoAllocateGL()
    var
        Budget: Record "G/L Budget Name";
        DimVal: Record "Dimension Value";
        GLBudgetEntry: Record "G/L Budget Entry";
        IntC: Integer;
        NewDate: Date;
        Period: Text[30];
        Amnt: Decimal;
        EntryNo: Integer;
        GL: Record "G/L Account";
    begin
        /*
        WITH Rec DO BEGIN
        
        //check if the date inserted as the start date is greater than the end date
        IF ("Start Date">"End Date") THEN
          BEGIN
            ERROR('Ending Date must BE greater than or equal to start date');
          END;
        
        IF "Type of Entry"="Type of Entry"::"0" THEN
          BEGIN
            ERROR('Type Of Entry must not be blank in Line no.' + FORMAT("Line No.") );
          END;
        {Get the new date selected by the user first}
        NewDate:="Start Date";
        {Get the period}
        IF "Period Type"="Period Type"::"0" THEN
          BEGIN
            Period:='D';
          END
        ELSE IF "Period Type"="Period Type"::"1" THEN
          BEGIN
            Period:='W';
          END
        ELSE IF "Period Type"="Period Type"::"2" THEN
          BEGIN
            Period:='M';
          END
        ELSE IF "Period Type"="Period Type"::"3" THEN
          BEGIN
            Period:='Q';
          END
        ELSE
          BEGIN
            Period:='Y';
          END;
        {Initiate the loop}
        WHILE NewDate<="End Date"
          DO
            BEGIN
              IntC:=IntC +1;
              NewDate:=CALCDATE('1' + Period,NewDate);
            END;
        {Number of times to divide amount has been identified}
        {Get the amount and get the amount per period identified}
        
        Amnt:=Amount/IntC;
        
        {Get the entry number}
        GLBudgetEntry.RESET;
        IF GLBudgetEntry.FIND('+') THEN
          BEGIN
            EntryNo:=GLBudgetEntry."Entry No.";
          END
        ELSE
          BEGIN
            EntryNo:=0;
          END;
        EntryNo:=EntryNo +1;
        {Check if the user wishes to overwrite the details already in the system}
        IF Overwrite=TRUE THEN
          BEGIN
            GLBudgetEntry.RESET;
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Name",Name);
            GLBudgetEntry.SETRANGE(GLBudgetEntry."G/L Account No.","G/L Account");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 1 Code","Global Dimension 1 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 2 Code","Global Dimension 2 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Business Unit Code","Business Unit");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 1 Code","Budget Dimension 1 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 2 Code","Budget Dimension 2 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 3 Code","Budget Dimension 3 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 4 Code","Budget Dimension 4 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 5 Code","Budget Dimension 5 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 6 Code","Budget Dimension 6 Code");
            IF GLBudgetEntry.FIND('-') THEN
              BEGIN
                GLBudgetEntry.DELETEALL;
              END;
          END;
        {Reset the new date}
        NewDate:="Start Date";
        {Initiate the loop to save the details into the table}
        WHILE NewDate<="End Date"
          DO
            BEGIN
            GLBudgetEntry.INIT;
            GLBudgetEntry."Entry No.":=EntryNo;
        
            GLBudgetEntry."Budget Name":=Name;
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Name");
        
            GLBudgetEntry."G/L Account No.":="G/L Account";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."G/L Account No.");
        
            GLBudgetEntry."Global Dimension 1 Code":="Global Dimension 1 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Global Dimension 1 Code");
        
            GLBudgetEntry."Global Dimension 2 Code":="Global Dimension 2 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Global Dimension 2 Code");
        
            GLBudgetEntry."Business Unit Code":="Business Unit";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Business Unit Code");
        
            GLBudgetEntry."Budget Dimension 1 Code":="Budget Dimension 1 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 1 Code");
        
            GLBudgetEntry."Budget Dimension 2 Code":="Budget Dimension 2 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 2 Code");
        
            GLBudgetEntry."Budget Dimension 3 Code":="Budget Dimension 3 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 3 Code");
        
            GLBudgetEntry."Budget Dimension 4 Code":="Budget Dimension 4 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 4 Code");
        
            GLBudgetEntry."Budget Dimension 5 Code":="Budget Dimension 5 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 5 Code");
        
            GLBudgetEntry."Budget Dimension 6 Code":="Budget Dimension 6 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 6 Code");
        
            GLBudgetEntry.Date:=NewDate;
            IF "Type of Entry"="Type of Entry"::"1" THEN
              BEGIN
                GLBudgetEntry.Amount:=Amnt;
              END
            ELSE IF "Type of Entry"="Type of Entry"::"2" THEN
              BEGIN
                GLBudgetEntry.Amount:=-Amnt;
              END;
            GLBudgetEntry."User ID":=USERID;
        
            GLBudgetEntry.INSERT;
            NewDate:=CALCDATE('1' + Period ,NewDate);
            EntryNo:=EntryNo + 1;
            END;
            Processed:=TRUE;
            Rec."User ID":=USERID;
            MODIFY;
        MESSAGE('Budgetary Allocation Complete');
        
        END;
        Rec.DELETE;
        */

    end;
}
