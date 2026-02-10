// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186310 pageextension52186310 extends "Update Opportunity"
// {

//     //Unsupported feature: Property Modification (PageType) on ""Update Opportunity"(Page 5129)".

//     layout
//     {
//         // modify("Action type")
//         // {

//         //     //Unsupported feature: Property Modification (ControlType) on ""Action type"(Control 1)".


//         //     //Unsupported feature: Property Modification (Name) on ""Action type"(Control 1)".

//         //     Caption = 'Step 1';

//         //     //Unsupported feature: Property Insertion (Visible) on ""Action type"(Control 1)".

//         // }
//         // modify("Sales Cycle Stage")
//         // {

//         //     //Unsupported feature: Property Modification (Level) on ""Sales Cycle Stage"(Control 5)".

//         //     ApplicationArea = Basic;

//         //     //Unsupported feature: Property Modification (Name) on ""Sales Cycle Stage"(Control 5)".

//         //     CaptionClass = Text19070489;
//         // }
//         modify("Sales Cycle Stage Description")
//         {

//             //Unsupported feature: Property Modification (ControlType) on ""Sales Cycle Stage Description"(Control 3)".


//             //Unsupported feature: Property Modification (Name) on ""Sales Cycle Stage Description"(Control 3)".

//             Caption = 'Step 3';

//             //Unsupported feature: Property Insertion (Visible) on ""Sales Cycle Stage Description"(Control 3)".


//             //Unsupported feature: Property Insertion (InstructionalTextML) on ""Sales Cycle Stage Description"(Control 3)".

//         }
//         // modify("Date of Change")
//         // {

//         //     //Unsupported feature: Property Modification (ControlType) on ""Date of Change"(Control 2)".


//         //     //Unsupported feature: Property Modification (Name) on ""Date of Change"(Control 2)".

//         //     Caption = 'Step 2';

//         //     //Unsupported feature: Property Insertion (Visible) on ""Date of Change"(Control 2)".


//         //     //Unsupported feature: Property Insertion (InstructionalTextML) on ""Date of Change"(Control 2)".


//         // modify("Estimated Value (LCY)")
//         // {

//         //     //Unsupported feature: Property Modification (Level) on ""Estimated Value (LCY)"(Control 24)".

//         //     Caption = 'What is the estimated sales value (LCY)?';
//         //     ApplicationArea = Basic;
//         // }
//         // modify("Chances of Success %")
//         // {

//         //     //Unsupported feature: Property Modification (Level) on ""Chances of Success %"(Control 27)".

//         //     Caption = 'What is the chance of success (%)?';
//         //     ApplicationArea = Basic;
//         // }
//         modify("Estimated Close Date")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Estimated Close Date"(Control 22)".

//             Caption = 'What is the estimated closing date?';
//             ApplicationArea = Basic;
//         }
//         modify("Cancel Old To Do")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Cancel Old To Do"(Control 30)".

//             Caption = 'Cancel existing open to-dos.';
//             ApplicationArea = Basic;
//             // Enabled = "Cancel Old To DoEnable";
//         }
//         modify("Action type")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Action type"(Control 1)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on ""Action type"(Control 1)".


//         //Unsupported feature: Property Deletion (SourceExpr) on ""Action type"(Control 1)".


//         //Unsupported feature: Property Deletion (ValuesAllowed) on ""Action type"(Control 1)".

//         // modify("Sales Cycle Stage")
//         // {
//         //     Visible = false;
//         // }
//         // modify("Sales Cycle Stage")
//         // {
//         //     Visible = false;
//         // }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Cycle Stage"(Control 5)".


//         //Unsupported feature: Property Deletion (SourceExpr) on ""Sales Cycle Stage"(Control 5)".


//         //Unsupported feature: Property Deletion (Editable) on ""Sales Cycle Stage"(Control 5)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Cycle Stage Description"(Control 3)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on ""Sales Cycle Stage Description"(Control 3)".


//         //Unsupported feature: Property Deletion (SourceExpr) on ""Sales Cycle Stage Description"(Control 3)".


//         //Unsupported feature: Property Deletion (Editable) on ""Sales Cycle Stage Description"(Control 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Date of Change"(Control 2)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on ""Date of Change"(Control 2)".


//         //Unsupported feature: Property Deletion (SourceExpr) on ""Date of Change"(Control 2)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Estimated Value (LCY)"(Control 24)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Chances of Success %"(Control 27)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Estimated Close Date"(Control 22)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Cancel Old To Do"(Control 30)".




//         addfirst("Action type")
//         {
//             field(OptionOne;Rec."Action Type")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'This wizard helps you to update opportunities. Select one of the following options.';
//                 ValuesAllowed = First,Next,Previous,Skip,Jump,Update;

//                 trigger OnValidate()
//                 begin
//                     if Rec."Action Type" = Rec."action type"::Update then
//                       UpdateActionTypeOnValidate;
//                     if Rec."Action Type" = Rec."action type"::Jump then
//                       JumpActionTypeOnValidate;
//                     if Rec."Action Type" = Rec."action type"::Skip then
//                       SkipActionTypeOnValidate;
//                     if Rec."Action Type" = Rec."action type"::Previous then
//                       PreviousActionTypeOnValidate;
//                     if Rec."Action Type" = Rec."action type"::Next then
//                       NextActionTypeOnValidate;
//                     if Rec."Action Type" = Rec."action type"::First then
//                       FirstActionTypeOnValidate;
//                 end;
//             }
//         }
//         addfirst("Sales Cycle Stage")
//         {
//             field("Sales Cycle Stage";Rec."Sales Cycle Stage")
//             {
//                 ApplicationArea = Basic;
//                 CaptionClass = FORMAT(Rec."Sales Cycle Stage Description");
//                 Editable = "Sales Cycle StageEditable";

//                 trigger OnLookup(var Text: Text): Boolean
//                 begin
//                     Rec.LookupSalesCycleStage;
//                     Rec.ValidateSalesCycleStage;
//                 end;

//                 trigger OnValidate()
//                 begin
//                     Rec.ValidateStage;
//                     SalesCycleStageOnAfterValidate;
//                 end;
//             }
//             field("Date of Change";Rec."Date of Change")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'What is the date of this change?';
//             }
//         }
//         moveafter(Control1900000001;"Sales Cycle Stage Description")
//         moveafter(Step3;"Estimated Value (LCY)")
//         moveafter(Step1;"Date of Change")
//     }
//     actions
//     {
//         modify(Finish)
//         {
//             ApplicationArea = Basic;
//             Enabled = FinishEnable;
//         }
//         modify(SalesQuote)
//         {
//             ApplicationArea = Basic;
//         }


//         //Unsupported feature: Code Modification on "Finish(Action 10).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             FinishPage;
//             CurrPage.CLOSE;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             CheckStatus2;
//             FinishWizard2;
//             CurrPage.CLOSE;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "Finish(Action 10)".


//         //Unsupported feature: Property Deletion (Promoted) on "Finish(Action 10)".


//         //Unsupported feature: Property Deletion (Visible) on "Finish(Action 10)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "SalesQuote(Action 31)".


//         //Unsupported feature: Property Deletion (Promoted) on "SalesQuote(Action 31)".

//         addfirst(Processing)
//         {
//             action(Back)
//             {
//                 ApplicationArea = Basic;
//                 Caption = '&Back';
//                 Enabled = BackEnable;
//                 Image = PreviousRecord;
//                 InFooterBar = true;

//                 trigger OnAction()
//                 begin
//                     ShowStep(false);
//                     PerformPrevWizardStatus2;
//                     ShowStep(true);
//                     CurrPage.Update(true);
//                     UpdateCntrls;
//                 end;
//             }
//             action(Next)
//             {
//                 ApplicationArea = Basic;
//                 Caption = '&Next';
//                 Enabled = NextEnable;
//                 Image = NextRecord;
//                 InFooterBar = true;

//                 trigger OnAction()
//                 begin
//                     Rec.CheckStatus2;
//                     ShowStep(false);
//                     PerformNextWizardStatus2;
//                     ShowStep(true);
//                     CurrPage.Update(true);
//                     UpdateCntrls;
//                 end;
//             }
//         }
//     }

//     var
//         FormWidth: Integer;
//         CancelXPos: Integer;
//         CancelYPos: Integer;
//         CancelHeight: Integer;
//         CancelWidth: Integer;
//         FrmXPos: Integer;
//         FrmYPos: Integer;
//         FrmHeight: Integer;
//         FrmWidth: Integer;
//         
//         Step1Visible: Boolean;
//         
//         Step2Visible: Boolean;
//         
//         Step3Visible: Boolean;
//         
//         "Sales Cycle StageEditable": Boolean;

//     var
//         
//         FinishEnable: Boolean;
//         
//         BackEnable: Boolean;
//         
//         NextEnable: Boolean;

//     var
//         
//         "Cancel Old To DoEnable": Boolean;

//     var
//         Text19070489: label 'What is the sales cycle stage?';


//     //Unsupported feature: Code Modification on "OnInit".

//     //trigger OnInit()
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         CancelOldTaskEnable := TRUE;
//         SalesQuoteEnable := TRUE;
//         OptionSixEnable := TRUE;
//         OptionFiveEnable := TRUE;
//         OptionFourEnable := TRUE;
//         OptionThreeEnable := TRUE;
//         OptionTwoEnable := TRUE;
//         OptionOneEnable := TRUE;
//         SalesCycleStageEditable := TRUE;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         "Cancel Old To DoEnable" := TRUE;
//         SalesQuoteEnable := TRUE;
//         NextEnable := TRUE;
//         #3..8
//         "Sales Cycle StageEditable" := TRUE;
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IsOnMobile := ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Phone;
//         CreateStageList;
//         UpdateEditable;
//         IF Opp.GET("Opportunity No.") THEN
//           IF Opp."Sales Document No." <> '' THEN
//             SalesQuoteEnable := TRUE
//           ELSE
//             SalesQuoteEnable := FALSE;

//         UpdateCntrls;
//         UpdateEstimatedValues;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         FormWidth := CancelXPos + CancelWidth + 220;
//         FrmXPos := ROUND((FrmWidth - FormWidth) / 2,1) + FrmXPos;
//         FrmYPos := 3000;
//         FrmHeight := CancelYPos + CancelHeight + 220;
//         FrmWidth := FormWidth;

//         CreateStageList;
//         UpdateEditable;

//         ShowStep(TRUE);
//         */
//     //end;

//     //Unsupported feature: Variable Insertion (Variable: ToDo) (VariableCollection) on "UpdateCntrls(PROCEDURE 4)".



//     //Unsupported feature: Code Modification on "UpdateCntrls(PROCEDURE 4)".

//     //procedure UpdateCntrls();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         CASE "Action Type" OF
//           "Action Type"::First:
//             BEGIN
//               SalesCycleStageEditable := FALSE;
//               CancelOldTaskEnable := FALSE;
//             END;
//           "Action Type"::Next:
//             BEGIN
//               SalesCycleStageEditable := FALSE;
//               CancelOldTaskEnable := TRUE;
//             END;
//           "Action Type"::Previous:
//             BEGIN
//               SalesCycleStageEditable := FALSE;
//               CancelOldTaskEnable := TRUE;
//             END;
//           "Action Type"::Skip:
//             BEGIN
//               SalesCycleStageEditable := TRUE;
//               CancelOldTaskEnable := TRUE;
//             END;
//           "Action Type"::Update:
//             BEGIN
//               SalesCycleStageEditable := FALSE;
//               CancelOldTaskEnable := FALSE;
//             END;
//           "Action Type"::Jump:
//             BEGIN
//               SalesCycleStageEditable := TRUE;
//               CancelOldTaskEnable := TRUE;
//             END;
//         END;
//         Task.RESET;
//         Task.SETCURRENTKEY("Opportunity No.");
//         Task.SETRANGE("Opportunity No.","Opportunity No.");
//         IF Task.FINDFIRST THEN
//           CancelOldTaskEnable := TRUE;
//         MODIFY;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         CASE "Wizard Step" OF
//           "Wizard Step"::"1":
//             BEGIN
//               CASE "Action Type" OF
//                 "Action Type"::First:
//                   BEGIN
//                     "Sales Cycle StageEditable" := FALSE;
//                     "Cancel Old To DoEnable" := FALSE;
//                   END;
//                 "Action Type"::Next:
//                   BEGIN
//                     "Sales Cycle StageEditable" := FALSE;
//                     "Cancel Old To DoEnable" := TRUE;
//                   END;
//                 "Action Type"::Previous:
//                   BEGIN
//                     "Sales Cycle StageEditable" := FALSE;
//                     "Cancel Old To DoEnable" := TRUE;
//                   END;
//                 "Action Type"::Skip:
//                   BEGIN
//                     "Sales Cycle StageEditable" := TRUE;
//                     "Cancel Old To DoEnable" := TRUE;
//                   END;
//                 "Action Type"::Update:
//                   BEGIN
//                     "Sales Cycle StageEditable" := FALSE;
//                     "Cancel Old To DoEnable" := FALSE;
//                   END;
//                 "Action Type"::Jump:
//                   BEGIN
//                     "Sales Cycle StageEditable" := TRUE;
//                     "Cancel Old To DoEnable" := TRUE;
//                   END;
//               END;
//               ToDo.RESET;
//               ToDo.SETCURRENTKEY("Opportunity No.");
//               ToDo.SETRANGE("Opportunity No.","Opportunity No.");
//               IF ToDo.FINDFIRST THEN
//                 "Cancel Old To DoEnable" := TRUE;
//               MODIFY;
//             END;
//         END;
//         */
//     //end;

//     //Unsupported feature: Parameter Insertion (Parameter: Visible) (ParameterCollection) on "ShowStep(PROCEDURE 2)".


//     //Unsupported feature: Property Modification (Name) on "UpdateEstimatedValues(PROCEDURE 2)".



//     //Unsupported feature: Code Modification on "UpdateEstimatedValues(PROCEDURE 2)".

//     //procedure UpdateEstimatedValues();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IF SalesCycleStage.GET("Sales Cycle Code","Sales Cycle Stage") THEN BEGIN
//           "Estimated Close Date" := CALCDATE(SalesCycleStage."Date Formula","Date of Change");
//           "Chances of Success %" := SalesCycleStage."Chances of Success %";
//         END;
//         IF SalesHeader.GET(SalesHeader."Document Type"::Quote,Opp."Sales Document No.") THEN
//           "Estimated Value (LCY)" := GetSalesDocValue(SalesHeader);

//         MODIFY;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         CASE "Wizard Step" OF
//           "Wizard Step"::"1":
//             BEGIN
//               Step1Visible := Visible;
//               IF Visible THEN BEGIN
//                 FinishEnable := FALSE;
//                 BackEnable := FALSE;
//                 NextEnable := TRUE;
//                 CASE TRUE OF
//                   OptionOneEnable:
//                     ;
//                   OptionTwoEnable:
//                     ;
//                   OptionThreeEnable:
//                     ;
//                   OptionFiveEnable:
//                     ;
//                   OptionFourEnable:
//                     ;
//                   OptionSixEnable:
//                     ;
//                 END;
//               END;
//             END;
//           "Wizard Step"::"2":
//             BEGIN
//               Step2Visible := Visible;
//               IF Visible THEN BEGIN
//                 FinishEnable := FALSE;
//                 BackEnable := TRUE;
//                 NextEnable := TRUE;
//                 CASE "Action Type" OF
//                   "Action Type"::Previous,"Action Type"::Skip,"Action Type"::Jump:
//                     ;
//                   ELSE;
//                 END;
//               END;
//             END;
//           "Wizard Step"::"3":
//             BEGIN
//               Step3Visible := Visible;
//               IF Visible THEN BEGIN
//                 FinishEnable := TRUE;
//                 BackEnable := TRUE;
//                 NextEnable := FALSE;
//                 IF Opp.GET("Opportunity No.") THEN
//                   IF Opp."Sales Document No." <> '' THEN
//                     SalesQuoteEnable := TRUE
//                   ELSE
//                     SalesQuoteEnable := FALSE;
//               END;
//             END;
//         END;
//         */
//     //end;

//     //Unsupported feature: Deletion (VariableCollection) on "UpdateCntrls(PROCEDURE 4).Task(Variable 1000)".


//     //Unsupported feature: Deletion (VariableCollection) on "UpdateEstimatedValues(PROCEDURE 2).SalesCycleStage(Variable 1000)".


//     //Unsupported feature: Deletion (VariableCollection) on "UpdateEstimatedValues(PROCEDURE 2).SalesHeader(Variable 1001)".

// }
