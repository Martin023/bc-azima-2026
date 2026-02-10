// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Codeunit 52185487 "WP Budget Allocation"
// {

//     trigger OnRun()
//     begin
//     end;

//     var
//         GLBudgetName: Record "G/L Budget Name";
//         GLSetup: Record "General Ledger Setup";
//         ItemBudgetName: Record "Item Budget Name";
//         WorkplanAct: Record "Workplan Activities";


//     procedure AutoAllocatePurch(var Rec: Record "Temp Budget Alloc Purch")
//     var
//         Budget: Record "Item Budget Name";
//         DimVal: Record "Dimension Value";
//         GLBudgetEntry: Record "Item Budget Entry";
//         IntC: Integer;
//         NewDate: Date;
//         Period: Text[30];
//         Amnt: Decimal;
//         EntryNo: Integer;
//         GL: Record Item;
//     begin
//         begin

//             //check if the date inserted as the start date is greater than the end date
//             if ("Start Date" > "End Date") then begin
//                 Error('Ending Date must BE greater than or equal to start date');
//             end;
//             /*Get the new date selected by the user first*/
//             NewDate := "Start Date";
//             /*Get the period*/
//             if "Period Type" = "period type"::Daily then begin
//                 Period := 'D';
//             end
//             else
//                 if "Period Type" = "period type"::Weekly then begin
//                     Period := 'W';
//                 end
//                 else
//                     if "Period Type" = "period type"::Monthly then begin
//                         Period := 'M';
//                     end
//                     else
//                         if "Period Type" = "period type"::Quarterly then begin
//                             Period := 'Q';
//                         end
//                         else begin
//                             Period := 'Y';
//                         end;
//             /*Initiate the loop*/
//             while NewDate <= "End Date"
//               do begin
//                 IntC := IntC + 1;
//                 NewDate := CalcDate('1' + Period, NewDate);
//             end;
//             /*Number of times to divide amount has been identified*/
//             /*Get the amount and get the amount per period identified*/

//             Amnt := Amount / IntC;

//             /*Get the entry number*/
//             GLBudgetEntry.Reset;
//             if GLBudgetEntry.Find('+') then begin
//                 EntryNo := GLBudgetEntry."Entry No.";
//             end
//             else begin
//                 EntryNo := 0;
//             end;
//             EntryNo := EntryNo + 1;
//             /*Check if the user wishes to overwrite the details already in the system*/
//             if Overwrite = true then begin
//                 GLBudgetEntry.Reset;
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Name", Name);
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Item No.", "Item No");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Global Dimension 1 Code", "Global Dimension 1 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Global Dimension 2 Code", "Global Dimension 2 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 1 Code", "Budget Dimension 1 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 2 Code", "Budget Dimension 2 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 3 Code", "Budget Dimension 3 Code");
//                 if GLBudgetEntry.Find('-') then begin
//                     GLBudgetEntry.DeleteAll;
//                 end;
//             end;
//             /*Reset the new date*/
//             NewDate := "Start Date";
//             /*Initiate the loop to save the details into the table*/
//             while NewDate <= "End Date"
//               do begin
//                 GLBudgetEntry.Init;
//                 GLBudgetEntry."Entry No." := EntryNo;

//                 GLBudgetEntry."Analysis Area" := GLBudgetEntry."analysis area"::Purchase;

//                 GLBudgetEntry."Budget Name" := Name;
//                 GLBudgetEntry.Validate(GLBudgetEntry."Budget Name");

//                 GLBudgetEntry."Item No." := "Item No";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Item No.");
//                 GL.Reset;
//                 GL.Get("Item No");
//                 /*
//                       Forced to comment out by TChibo
//                 //    GLBudgetEntry."Item G/L Sales Account":=GL."Item G/L Sales Account";
//                 //    GLBudgetEntry."Item G/L Cost Account":=GLBudgetEntry."Item G/L Cost Account";
//                 */
//                 GLBudgetEntry."Global Dimension 1 Code" := "Global Dimension 1 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 1 Code");

//                 GLBudgetEntry."Global Dimension 2 Code" := "Global Dimension 2 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 2 Code");

//                 GLBudgetEntry."Budget Dimension 1 Code" := "Budget Dimension 1 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 1 Code");

//                 GLBudgetEntry."Budget Dimension 2 Code" := "Budget Dimension 2 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 2 Code");

//                 GLBudgetEntry."Budget Dimension 3 Code" := "Budget Dimension 3 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 3 Code");

//                 GLBudgetEntry.Date := NewDate;


//                 if "Show As" = "show as"::Quantity then begin
//                     GLBudgetEntry."Sales Amount" := Amnt;
//                 end
//                 else
//                     if "Show As" = "show as"::"Cost Amount" then begin
//                         GLBudgetEntry.Quantity := Amnt;
//                     end
//                     else
//                         if "Show As" = "show as"::"2" then begin
//                             GLBudgetEntry."Cost Amount" := Amnt;
//                         end;

//                 GLBudgetEntry."User ID" := UserId;

//                 GLBudgetEntry.Insert(true);
//                 NewDate := CalcDate('1' + Period, NewDate);
//                 EntryNo := EntryNo + 1;
//             end;
//             Processed := true;
//             Rec."User ID" := UserId;
//             Rec.Modify;
//             Message('Budgetary Allocation Complete');

//         end;
//         Rec.Delete;

//     end;


//     procedure AutoAllocateSale(var Rec: Record "Temp Budget Alloc Sale")
//     var
//         Budget: Record "Item Budget Name";
//         DimVal: Record "Dimension Value";
//         GLBudgetEntry: Record "Item Budget Entry";
//         IntC: Integer;
//         NewDate: Date;
//         Period: Text[30];
//         Amnt: Decimal;
//         EntryNo: Integer;
//         GL: Record Item;
//     begin
//         begin

//             //check if the date inserted as the start date is greater than the end date
//             if ("Start Date" > "End Date") then begin
//                 Error('Ending Date must BE greater than or equal to start date');
//             end;

//             /*Get the new date selected by the user first*/
//             NewDate := "Start Date";
//             /*Get the period*/
//             if "Period Type" = "period type"::Daily then begin
//                 Period := 'D';
//             end
//             else
//                 if "Period Type" = "period type"::Weekly then begin
//                     Period := 'W';
//                 end
//                 else
//                     if "Period Type" = "period type"::Monthly then begin
//                         Period := 'M';
//                     end
//                     else
//                         if "Period Type" = "period type"::Quarterly then begin
//                             Period := 'Q';
//                         end
//                         else begin
//                             Period := 'Y';
//                         end;
//             /*Initiate the loop*/
//             while NewDate <= "End Date"
//               do begin
//                 IntC := IntC + 1;
//                 NewDate := CalcDate('1' + Period, NewDate);
//             end;
//             /*Number of times to divide amount has been identified*/
//             /*Get the amount and get the amount per period identified*/

//             Amnt := Amount / IntC;

//             /*Get the entry number*/
//             GLBudgetEntry.Reset;
//             if GLBudgetEntry.Find('+') then begin
//                 EntryNo := GLBudgetEntry."Entry No.";
//             end
//             else begin
//                 EntryNo := 0;
//             end;
//             EntryNo := EntryNo + 1;
//             /*Check if the user wishes to overwrite the details already in the system*/
//             if Overwrite = true then begin
//                 GLBudgetEntry.Reset;
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Name", Name);
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Item No.", "Item No");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Global Dimension 1 Code", "Global Dimension 1 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Global Dimension 2 Code", "Global Dimension 2 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 1 Code", "Budget Dimension 1 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 2 Code", "Budget Dimension 2 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 3 Code", "Budget Dimension 3 Code");
//                 if GLBudgetEntry.Find('-') then begin
//                     GLBudgetEntry.DeleteAll;
//                 end;
//             end;
//             /*Reset the new date*/
//             NewDate := "Start Date";
//             /*Initiate the loop to save the details into the table*/
//             while NewDate <= "End Date"
//               do begin
//                 GLBudgetEntry.Init;
//                 GLBudgetEntry."Entry No." := EntryNo;

//                 GLBudgetEntry."Analysis Area" := "analysis area"::Sales;

//                 GLBudgetEntry."Budget Name" := Name;
//                 GLBudgetEntry.Validate(GLBudgetEntry."Budget Name");

//                 GLBudgetEntry."Item No." := "Item No";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Item No.");
//                 GL.Reset;
//                 GL.Get("Item No");
//                 /*
//                       Forced to comment out by TChibo
//                 //    GLBudgetEntry."Item G/L Sales Account":=GL."Item G/L Sales Account";
//                 //    GLBudgetEntry."Item G/L Cost Account":=GLBudgetEntry."Item G/L Cost Account";
//                 */
//                 GLBudgetEntry."Global Dimension 1 Code" := "Global Dimension 1 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 1 Code");

//                 GLBudgetEntry."Global Dimension 2 Code" := "Global Dimension 2 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 2 Code");

//                 GLBudgetEntry."Budget Dimension 1 Code" := "Budget Dimension 1 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 1 Code");

//                 GLBudgetEntry."Budget Dimension 2 Code" := "Budget Dimension 2 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 2 Code");

//                 GLBudgetEntry."Budget Dimension 3 Code" := "Budget Dimension 3 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 3 Code");

//                 GLBudgetEntry.Date := NewDate;


//                 if "Show As" = "show as"::"Sales Amount" then begin
//                     GLBudgetEntry."Sales Amount" := Amnt;
//                 end
//                 else
//                     if "Show As" = "show as"::Quantity then begin
//                         GLBudgetEntry.Quantity := Amnt;
//                     end
//                     else
//                         if "Show As" = "show as"::COGS then begin
//                             GLBudgetEntry."Cost Amount" := Amnt;
//                         end;

//                 GLBudgetEntry."User ID" := UserId;

//                 GLBudgetEntry.Insert;

//                 NewDate := CalcDate('1' + Period, NewDate);
//                 EntryNo := EntryNo + 1;
//             end;
//             Processed := true;
//             Rec."User ID" := UserId;
//             Rec.Modify;
//             Message('Budgetary Allocation Complete');

//         end;
//         Rec.Delete;

//     end;


//     procedure AutoAllocateGL(var Rec: Record "Temp Budget Alloc G/L")
//     var
//         Budget: Record "G/L Budget Name";
//         DimVal: Record "Dimension Value";
//         GLBudgetEntry: Record "G/L Budget Entry";
//         IntC: Integer;
//         NewDate: Date;
//         Period: Text[30];
//         Amnt: Decimal;
//         EntryNo: Integer;
//         GL: Record "G/L Account";
//     begin
//         begin

//             //check if the date inserted as the start date is greater than the end date
//             if ("Start Date" > "End Date") then begin
//                 Error('Ending Date must BE greater than or equal to start date');
//             end;

//             if "Type of Entry" = "type of entry"::" " then begin
//                 Error('Type Of Entry must not be blank in Line no.' + Format("Line No."));
//             end;
//             /*Get the new date selected by the user first*/
//             NewDate := "Start Date";
//             /*Get the period*/
//             if "Period Type" = "period type"::Daily then begin
//                 Period := 'D';
//             end
//             else
//                 if "Period Type" = "period type"::Weekly then begin
//                     Period := 'W';
//                 end
//                 else
//                     if "Period Type" = "period type"::Monthly then begin
//                         Period := 'M';
//                     end
//                     else
//                         if "Period Type" = "period type"::Quarterly then begin
//                             Period := 'Q';
//                         end
//                         else begin
//                             Period := 'Y';
//                         end;
//             /*Initiate the loop*/
//             while NewDate <= "End Date"
//               do begin
//                 IntC := IntC + 1;
//                 NewDate := CalcDate('1' + Period, NewDate);
//             end;
//             /*Number of times to divide amount has been identified*/
//             /*Get the amount and get the amount per period identified*/

//             Amnt := Amount / IntC;

//             /*Get the entry number*/
//             GLBudgetEntry.Reset;
//             if GLBudgetEntry.Find('+') then begin
//                 EntryNo := GLBudgetEntry."Entry No.";
//             end
//             else begin
//                 EntryNo := 0;
//             end;
//             EntryNo := EntryNo + 1;
//             /*Check if the user wishes to overwrite the details already in the system*/
//             if Overwrite = true then begin
//                 GLBudgetEntry.Reset;
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Name", Name);
//                 GLBudgetEntry.SetRange(GLBudgetEntry."G/L Account No.", "G/L Account");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Global Dimension 1 Code", "Global Dimension 1 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Global Dimension 2 Code", "Global Dimension 2 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Business Unit Code", "Business Unit");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 1 Code", "Budget Dimension 1 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 2 Code", "Budget Dimension 2 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 3 Code", "Budget Dimension 3 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 4 Code", "Budget Dimension 4 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 5 Code", "Budget Dimension 5 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 6 Code", "Budget Dimension 6 Code");
//                 if GLBudgetEntry.Find('-') then begin
//                     GLBudgetEntry.DeleteAll;
//                 end;
//             end;
//             /*Reset the new date*/
//             NewDate := "Start Date";
//             /*Initiate the loop to save the details into the table*/
//             while NewDate <= "End Date"
//               do begin
//                 GLBudgetEntry.Init;
//                 GLBudgetEntry."Entry No." := EntryNo;

//                 GLBudgetEntry."Budget Name" := Name;
//                 GLBudgetEntry.Validate(GLBudgetEntry."Budget Name");

//                 GLBudgetEntry."G/L Account No." := "G/L Account";
//                 GLBudgetEntry.Validate(GLBudgetEntry."G/L Account No.");

//                 GLBudgetEntry."Global Dimension 1 Code" := "Global Dimension 1 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 1 Code");

//                 GLBudgetEntry."Global Dimension 2 Code" := "Global Dimension 2 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 2 Code");

//                 GLBudgetEntry."Business Unit Code" := "Business Unit";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Business Unit Code");

//                 GLBudgetEntry."Budget Dimension 1 Code" := "Budget Dimension 1 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 1 Code");

//                 GLBudgetEntry."Budget Dimension 2 Code" := "Budget Dimension 2 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 2 Code");

//                 GLBudgetEntry."Budget Dimension 3 Code" := "Budget Dimension 3 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 3 Code");

//                 GLBudgetEntry."Budget Dimension 4 Code" := "Budget Dimension 4 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 4 Code");

//                 GLBudgetEntry."Budget Dimension 5 Code" := "Budget Dimension 5 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 5 Code");

//                 GLBudgetEntry."Budget Dimension 6 Code" := "Budget Dimension 6 Code";
//                 GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 6 Code");

//                 GLBudgetEntry.Date := NewDate;
//                 if "Type of Entry" = "type of entry"::Debit then begin
//                     GLBudgetEntry.Amount := Amnt;
//                 end
//                 else
//                     if "Type of Entry" = "type of entry"::Credit then begin
//                         GLBudgetEntry.Amount := -Amnt;
//                     end;
//                 GLBudgetEntry."User ID" := UserId;

//                 GLBudgetEntry.Insert;

//                 //Added to Ensure that Respective Dimension is added to the Dimension buffer
//                 GLSetup.Get;
//                 GLBudgetName.Get(GLBudgetEntry."Budget Name");
//                 UpdateDim(GLSetup."Global Dimension 1 Code", "Global Dimension 1 Code", GLBudgetEntry);
//                 UpdateDim(GLSetup."Global Dimension 2 Code", "Global Dimension 2 Code", GLBudgetEntry);
//                 UpdateDim(GLBudgetName."Budget Dimension 1 Code", "Budget Dimension 1 Code", GLBudgetEntry);
//                 UpdateDim(GLBudgetName."Budget Dimension 2 Code", "Budget Dimension 2 Code", GLBudgetEntry);
//                 UpdateDim(GLBudgetName."Budget Dimension 3 Code", "Budget Dimension 3 Code", GLBudgetEntry);
//                 UpdateDim(GLBudgetName."Budget Dimension 4 Code", "Budget Dimension 4 Code", GLBudgetEntry);
//                 //End Added items

//                 NewDate := CalcDate('1' + Period, NewDate);
//                 EntryNo := EntryNo + 1;
//             end;
//             Processed := true;
//             Rec."User ID" := UserId;
//             Rec.Modify;

//             Message('Budgetary Allocation Complete');

//         end;
//         Rec.Delete;

//     end;


//     procedure UpdateDim(DimCode: Code[20]; DimValueCode: Code[20]; Rec: Record "G/L Budget Entry")
//     begin
//         if DimCode = '' then
//             exit;
//         /*
//         WITH GLBudgetDim DO BEGIN
//           IF GET(Rec."Entry No.",DimCode) THEN
//             DELETE;
//           IF DimValueCode <> '' THEN BEGIN
//             INIT;
//             "Entry No." := Rec."Entry No.";
//             "Dimension Code" := DimCode;
//             "Dimension Value Code" := DimValueCode;
//             INSERT;
//           END;
//         END;
//         */

//     end;


//     procedure CreateBudgetFromWorkplan(WorkBugAlloc: Record "Procur. Plan Budget Allocation")
//     var
//         GLBudgetEntry: Record "G/L Budget Entry";
//         ItemBudgetEntry: Record "Item Budget Entry";
//         WorkplanEntry: Record "Workplan Entry";
//         EntryNo: Integer;
//         Items: Record Item;
//     begin

//         begin

//             //Get the entry number
//             GLBudgetEntry.Reset;
//             if GLBudgetEntry.Find('+') then begin
//                 EntryNo := GLBudgetEntry."Entry No.";
//             end
//             else begin
//                 EntryNo := 0;
//             end;

//             EntryNo := EntryNo + 1;

//             //Check if the user wishes to overwrite the details already in the system}
//             if Overwrite = true then begin
//                 GLBudgetEntry.Reset;
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Name", "Current G/L Budget");
//                 //GLBudgetEntry.SETRANGE(GLBudgetEntry."G/L Account No.","G/L Account");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Global Dimension 1 Code", "Global Dimension 1 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Global Dimension 2 Code", "Global Dimension 2 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Business Unit Code", "Business Unit");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 1 Code", "Budget Dimension 1 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 2 Code", "Budget Dimension 2 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 3 Code", "Budget Dimension 3 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 4 Code", "Budget Dimension 4 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 5 Code", "Budget Dimension 5 Code");
//                 GLBudgetEntry.SetRange(GLBudgetEntry."Budget Dimension 6 Code", "Budget Dimension 6 Code");
//                 if GLBudgetEntry.Find('-') then begin
//                     GLBudgetEntry.DeleteAll;
//                 end;
//             end;
//             //*************************************************************************************************************
//             //FOR G/L ACCOUNT
//             WorkplanEntry.Reset;
//             //WorkplanEntry.SETRANGE(WorkplanEntry."Workplan Code",Name);
//             WorkplanEntry.SetRange(WorkplanEntry."Account Type", WorkplanEntry."account type"::"G/L Account");
//             WorkplanEntry.SetRange(WorkplanEntry."Processed to Budget", false); //Added DW. not to Re-Transfer Amount already processed
//             if ("Start Date" <> 0D) and ("End Date" <> 0D) then WorkplanEntry.SetRange(WorkplanEntry.Date, "Start Date", "End Date");
//             if WorkplanEntry.Find('-') then begin
//                 repeat
//                     GLBudgetEntry.Init;
//                     GLBudgetEntry."Entry No." := EntryNo;

//                     GLBudgetEntry."Budget Name" := WorkBugAlloc."Current G/L Budget";
//                     GLBudgetEntry.Validate("Budget Name");
//                     GLBudgetEntry."Processed from Workplan" := true;
//                     GLBudgetEntry."G/L Account No." := WorkplanEntry."G/L Account No.";
//                     GLBudgetEntry.TestField("G/L Account No.");
//                     GLBudgetEntry.Validate(GLBudgetEntry."G/L Account No.");


//                     GLBudgetEntry."Global Dimension 1 Code" := WorkplanEntry."Global Dimension 1 Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 1 Code");

//                     GLBudgetEntry."Global Dimension 2 Code" := WorkplanEntry."Global Dimension 2 Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 2 Code");

//                     GLBudgetEntry."Business Unit Code" := WorkplanEntry."Business Unit Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Business Unit Code");

//                     GLBudgetEntry."Budget Dimension 1 Code" := WorkplanEntry."Budget Dimension 1 Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 1 Code");

//                     GLBudgetEntry."Budget Dimension 2 Code" := WorkplanEntry."Budget Dimension 2 Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 2 Code");

//                     GLBudgetEntry."Budget Dimension 3 Code" := WorkplanEntry."Budget Dimension 3 Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 3 Code");

//                     GLBudgetEntry."Budget Dimension 4 Code" := WorkplanEntry."Budget Dimension 4 Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 4 Code");

//                     GLBudgetEntry."Budget Dimension 5 Code" := WorkplanEntry."Budget Dimension 5 Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 5 Code");

//                     GLBudgetEntry."Budget Dimension 6 Code" := WorkplanEntry."Budget Dimension 6 Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 6 Code");


//                     //Get Description from Workplan Activities
//                     WorkplanAct.Reset;
//                     WorkplanAct.SetRange(WorkplanAct."Activity Code", WorkplanEntry."Activity Code");
//                     if WorkplanAct.Find('-') then begin
//                         GLBudgetEntry.Description := WorkplanAct."Activity Description";
//                     end else begin
//                         GLBudgetEntry.Description := WorkplanEntry.Description;
//                     end;

//                     GLBudgetEntry.Date := WorkplanEntry.Date;
//                     GLBudgetEntry.WorkplanCode := WorkplanEntry."Activity Code";
//                     GLBudgetEntry.Amount := WorkplanEntry.Amount;
//                     GLBudgetEntry."User ID" := UserId;

//                     GLBudgetEntry.Insert;

//                     //Added DW: to mark entry as already processed
//                     WorkplanEntry."Processed to Budget" := true;
//                     WorkplanEntry.Validate(WorkplanEntry."Processed to Budget");
//                     WorkplanEntry.Modify;
//                     //Added to Ensure that Respective Dimension is added to the Dimension buffer
//                     GLSetup.Get;
//                     GLBudgetName.Get(GLBudgetEntry."Budget Name");
//                     UpdateDim(GLSetup."Global Dimension 1 Code", "Global Dimension 1 Code", GLBudgetEntry);
//                     UpdateDim(GLSetup."Global Dimension 2 Code", "Global Dimension 2 Code", GLBudgetEntry);
//                     UpdateDim(GLBudgetName."Budget Dimension 1 Code", "Budget Dimension 1 Code", GLBudgetEntry);
//                     UpdateDim(GLBudgetName."Budget Dimension 2 Code", "Budget Dimension 2 Code", GLBudgetEntry);
//                     UpdateDim(GLBudgetName."Budget Dimension 3 Code", "Budget Dimension 3 Code", GLBudgetEntry);
//                     UpdateDim(GLBudgetName."Budget Dimension 4 Code", "Budget Dimension 4 Code", GLBudgetEntry);
//                     //End Added items

//                     EntryNo += 1;
//                 until WorkplanEntry.Next = 0;
//             end;

//             //ITEM BUDGETS
//             //Get the entry number
//             ItemBudgetEntry.Reset;
//             if ItemBudgetEntry.Find('+') then begin
//                 EntryNo := ItemBudgetEntry."Entry No.";
//             end
//             else begin
//                 EntryNo := 0;
//             end;
//             EntryNo := EntryNo + 1;

//             //Check if the user wishes to overwrite the details already in the system
//             if Overwrite = true then begin
//                 ItemBudgetEntry.Reset;
//                 ItemBudgetEntry.SetRange(ItemBudgetEntry."Budget Name", "Current Item Budget");
//                 ItemBudgetEntry.SetRange(ItemBudgetEntry."Global Dimension 1 Code", "Global Dimension 1 Code");
//                 ItemBudgetEntry.SetRange(ItemBudgetEntry."Global Dimension 2 Code", "Global Dimension 2 Code");
//                 ItemBudgetEntry.SetRange(ItemBudgetEntry."Budget Dimension 1 Code", "Budget Dimension 1 Code");
//                 ItemBudgetEntry.SetRange(ItemBudgetEntry."Budget Dimension 2 Code", "Budget Dimension 2 Code");
//                 ItemBudgetEntry.SetRange(ItemBudgetEntry."Budget Dimension 3 Code", "Budget Dimension 3 Code");
//                 if ItemBudgetEntry.Find('-') then begin
//                     ItemBudgetEntry.DeleteAll;
//                 end;
//             end;

//             //*******************************************************************************************************************
//             //FOR ITEMS


//             WorkplanEntry.Reset;
//             //WorkplanEntry.SETRANGE(WorkplanEntry."Workplan Code",Name);
//             WorkplanEntry.SetRange(WorkplanEntry."Processed to Budget", false); //Added DW: Not to reprocess amounts already Processed
//             WorkplanEntry.SetRange(WorkplanEntry."Account Type", WorkplanEntry."account type"::Item);
//             if ("Start Date" <> 0D) and ("End Date" <> 0D) then WorkplanEntry.SetRange(WorkplanEntry.Date, "Start Date", "End Date");
//             if WorkplanEntry.Find('-') then begin
//                 repeat

//                     //Get the entry number
//                     ItemBudgetEntry.Reset;
//                     if ItemBudgetEntry.Find('+') then begin
//                         EntryNo := ItemBudgetEntry."Entry No.";
//                     end
//                     else begin
//                         EntryNo := 0;
//                     end;
//                     EntryNo := EntryNo + 1;

//                     ItemBudgetEntry.Init;
//                     ItemBudgetEntry."Entry No." := EntryNo;

//                     ItemBudgetEntry."Analysis Area" := ItemBudgetEntry."analysis area"::Purchase;

//                     ItemBudgetEntry."Budget Name" := WorkBugAlloc."Current Item Budget";
//                     ItemBudgetEntry.Validate(ItemBudgetEntry."Budget Name");

//                     ItemBudgetEntry."Item No." := WorkplanEntry."G/L Account No.";
//                     ItemBudgetEntry.Validate(ItemBudgetEntry."Item No.");

//                     Items.Reset;
//                     Items.Get(ItemBudgetEntry."Item No.");

//                     ItemBudgetEntry."Global Dimension 1 Code" := WorkplanEntry."Global Dimension 1 Code";
//                     ItemBudgetEntry.Validate(ItemBudgetEntry."Global Dimension 1 Code");

//                     ItemBudgetEntry."Global Dimension 2 Code" := WorkplanEntry."Global Dimension 2 Code";
//                     ItemBudgetEntry.Validate(ItemBudgetEntry."Global Dimension 2 Code");

//                     ItemBudgetEntry."Budget Dimension 1 Code" := WorkplanEntry."Budget Dimension 1 Code";
//                     ItemBudgetEntry.Validate(ItemBudgetEntry."Budget Dimension 1 Code");

//                     ItemBudgetEntry."Budget Dimension 2 Code" := WorkplanEntry."Budget Dimension 2 Code";
//                     ItemBudgetEntry.Validate(ItemBudgetEntry."Budget Dimension 2 Code");

//                     ItemBudgetEntry."Budget Dimension 3 Code" := WorkplanEntry."Budget Dimension 3 Code";
//                     ItemBudgetEntry.Validate(ItemBudgetEntry."Budget Dimension 3 Code");

//                     //Get Description from Workplan Activities
//                     WorkplanAct.Reset;
//                     WorkplanAct.SetRange(WorkplanAct."Activity Code", WorkplanEntry."Activity Code");
//                     if WorkplanAct.Find('-') then begin
//                         ItemBudgetEntry.Description := WorkplanAct."Activity Description";
//                     end else begin
//                         ItemBudgetEntry.Description := WorkplanEntry.Description;
//                     end;

//                     ItemBudgetEntry.Date := WorkplanEntry.Date;
//                     ItemBudgetEntry.Quantity := WorkplanEntry.Quantity;
//                     ItemBudgetEntry."Cost Amount" := WorkplanEntry.Amount;

//                     ItemBudgetEntry."User ID" := UserId;

//                     ItemBudgetEntry.Insert(true);

//                     //Added DW: to mark entry as already processed
//                     WorkplanEntry."Processed to Budget" := true;
//                     WorkplanEntry.Validate(WorkplanEntry."Processed to Budget");
//                     //WorkplanEntry.modify;

//                     //Added to Ensure that Respective Dimension is added to the Dimension buffer
//                     GLSetup.Get;
//                     //        ItemBudgetName.GET(ItemBudgetName."Analysis Area"=ItemBudgetName."Analysis Area"::Purchase,ItemBudgetEntry."Budget Name");
//                     UpdateItemDim(GLSetup."Global Dimension 1 Code", "Global Dimension 1 Code", ItemBudgetEntry);
//                     UpdateItemDim(GLSetup."Global Dimension 2 Code", "Global Dimension 2 Code", ItemBudgetEntry);
//                     UpdateItemDim(GLBudgetName."Budget Dimension 1 Code", "Budget Dimension 1 Code", ItemBudgetEntry);
//                     UpdateItemDim(GLBudgetName."Budget Dimension 2 Code", "Budget Dimension 2 Code", ItemBudgetEntry);
//                     UpdateItemDim(GLBudgetName."Budget Dimension 3 Code", "Budget Dimension 3 Code", ItemBudgetEntry);
//                     UpdateItemDim(GLBudgetName."Budget Dimension 4 Code", "Budget Dimension 4 Code", ItemBudgetEntry);
//                     //End Added items

//                     EntryNo += 1;
//                     //Insert also into GL Budget Entries ************************************************************************************

//                     //Get the entry number
//                     GLBudgetEntry.Reset;
//                     if GLBudgetEntry.Find('+') then begin
//                         EntryNo := GLBudgetEntry."Entry No.";
//                     end
//                     else begin
//                         EntryNo := 0;
//                     end;

//                     EntryNo := EntryNo + 1;

//                     GLBudgetEntry.Init;
//                     GLBudgetEntry."Entry No." := EntryNo;

//                     GLBudgetEntry."Budget Name" := WorkBugAlloc."Current G/L Budget";
//                     GLBudgetEntry.Validate("Budget Name");

//                     Items.Get(WorkplanEntry."G/L Account No.");
//                     Items.TestField(Items."Item G/L Budget Account");

//                     GLBudgetEntry."G/L Account No." := Items."Item G/L Budget Account";

//                     GLBudgetEntry.TestField("G/L Account No.");
//                     GLBudgetEntry.Validate(GLBudgetEntry."G/L Account No.");
//                     GLBudgetEntry."Processed from Workplan" := true;

//                     GLBudgetEntry."Global Dimension 1 Code" := WorkplanEntry."Global Dimension 1 Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 1 Code");

//                     GLBudgetEntry."Global Dimension 2 Code" := WorkplanEntry."Global Dimension 2 Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 2 Code");

//                     GLBudgetEntry."Business Unit Code" := WorkplanEntry."Business Unit Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Business Unit Code");

//                     GLBudgetEntry."Budget Dimension 1 Code" := WorkplanEntry."Budget Dimension 1 Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 1 Code");

//                     GLBudgetEntry."Budget Dimension 2 Code" := WorkplanEntry."Budget Dimension 2 Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 2 Code");

//                     GLBudgetEntry."Budget Dimension 3 Code" := WorkplanEntry."Budget Dimension 3 Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 3 Code");

//                     GLBudgetEntry."Budget Dimension 4 Code" := WorkplanEntry."Budget Dimension 4 Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 4 Code");

//                     GLBudgetEntry."Budget Dimension 5 Code" := WorkplanEntry."Budget Dimension 5 Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 5 Code");

//                     GLBudgetEntry."Budget Dimension 6 Code" := WorkplanEntry."Budget Dimension 6 Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry."Budget Dimension 6 Code");

//                     //Get Description from Workplan Activities
//                     WorkplanAct.Reset;
//                     WorkplanAct.SetRange(WorkplanAct."Activity Code", WorkplanEntry."Activity Code");
//                     if WorkplanAct.Find('-') then begin
//                         GLBudgetEntry.Description := WorkplanAct."Activity Description";
//                     end else begin
//                         GLBudgetEntry.Description := WorkplanEntry.Description;
//                     end;

//                     GLBudgetEntry.Date := WorkplanEntry.Date;
//                     GLBudgetEntry.WorkplanCode := WorkplanEntry."Workplan Code";
//                     GLBudgetEntry.Validate(GLBudgetEntry.WorkplanCode);
//                     GLBudgetEntry.Amount := WorkplanEntry.Amount;
//                     GLBudgetEntry."User ID" := UserId;

//                     GLBudgetEntry.Insert;

//                     //Added DW: to mark entry as already processed
//                     WorkplanEntry."Processed to Budget" := true;
//                     WorkplanEntry.Validate(WorkplanEntry."Processed to Budget");

//                     //Added to Ensure that Respective Dimension is added to the Dimension buffer
//                     GLSetup.Get;
//                     GLBudgetName.Get(GLBudgetEntry."Budget Name");
//                     UpdateDim(GLSetup."Global Dimension 1 Code", "Global Dimension 1 Code", GLBudgetEntry);
//                     UpdateDim(GLSetup."Global Dimension 2 Code", "Global Dimension 2 Code", GLBudgetEntry);
//                     UpdateDim(GLBudgetName."Budget Dimension 1 Code", "Budget Dimension 1 Code", GLBudgetEntry);
//                     UpdateDim(GLBudgetName."Budget Dimension 2 Code", "Budget Dimension 2 Code", GLBudgetEntry);
//                     UpdateDim(GLBudgetName."Budget Dimension 3 Code", "Budget Dimension 3 Code", GLBudgetEntry);
//                     UpdateDim(GLBudgetName."Budget Dimension 4 Code", "Budget Dimension 4 Code", GLBudgetEntry);
//                 //End Added items

//                 //Insert also into GL Budget Entries ************************************************************************************
//                 until WorkplanEntry.Next = 0;
//             end;

//         end;
//         Message('Budget Entries Created Successfully');
//     end;


//     procedure UpdateItemDim(DimCode: Code[20]; DimValueCode: Code[20]; Rec: Record "Item Budget Entry")
//     var
//         ItemBudgetDim: Record "Item Budget Dimension";
//     begin
//         if DimCode = '' then
//             exit;
//         /*
//         WITH ItemBudgetDim DO BEGIN
//           IF GET(Rec."Entry No.",DimCode) THEN
//             DELETE;
//           IF DimValueCode <> '' THEN BEGIN
//             INIT;
//             "Entry No." := Rec."Entry No.";
//             "Dimension Code" := DimCode;
//             "Dimension Value Code" := DimValueCode;
//             INSERT;
//           END;
//         END;
//         */

//     end;
// }
