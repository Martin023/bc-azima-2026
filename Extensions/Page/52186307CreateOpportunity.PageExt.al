// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186307 pageextension52186307 extends "Create Opportunity" 
// {

//     //Unsupported feature: Property Modification (PageType) on ""Create Opportunity"(Page 5126)".

//     layout
//     {
//         modify(General)
//         {

//             //Unsupported feature: Property Modification (Name) on "General(Control 1)".

//             Caption = 'Step 1';

//             //Unsupported feature: Property Insertion (Visible) on "General(Control 1)".


//             //Unsupported feature: Property Insertion (InstructionalTextML) on "General(Control 1)".

//         }
//         modify(Description)
//         {
//             ApplicationArea = Basic;
//             Caption = 'Describe the opportunity.';
//         }
//         modify("Creation Date")
//         {
//             ApplicationArea = Basic;
//             Caption = 'What is the date of the opportunity?';
//         }
//         modify(Priority)
//         {
//             ApplicationArea = Basic;
//             Caption = 'What is the priority of the opportunity?';
//         }
//         modify("Salesperson Code")
//         {
//             Caption = 'What is the sales cycle code?';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Salesperson Code"(Control 4)".


//             //Unsupported feature: Property Modification (Name) on ""Salesperson Code"(Control 4)".

//         }
//         modify("Sales Cycle Code")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Sales Cycle Code"(Control 2)".


//             //Unsupported feature: Property Modification (ControlType) on ""Sales Cycle Code"(Control 2)".

//             Caption = 'Step 2';

//             //Unsupported feature: Property Modification (Name) on ""Sales Cycle Code"(Control 2)".


//             //Unsupported feature: Property Insertion (Visible) on ""Sales Cycle Code"(Control 2)".


//             //Unsupported feature: Property Insertion (GroupType) on ""Sales Cycle Code"(Control 2)".


//             //Unsupported feature: Property Insertion (InstructionalTextML) on ""Sales Cycle Code"(Control 2)".

//         }
//         modify("Segment Description")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Segment Description"(Control 3)".


//             //Unsupported feature: Property Modification (ControlType) on ""Segment Description"(Control 3)".

//             Caption = 'Step 3';

//             //Unsupported feature: Property Modification (Name) on ""Segment Description"(Control 3)".


//             //Unsupported feature: Property Insertion (Visible) on ""Segment Description"(Control 3)".


//             //Unsupported feature: Property Insertion (GroupType) on ""Segment Description"(Control 3)".


//             //Unsupported feature: Property Insertion (InstructionalTextML) on ""Segment Description"(Control 3)".

//         }
//         modify(Estimates)
//         {

//             //Unsupported feature: Property Modification (Name) on "Estimates(Control 34)".

//             Caption = 'Step 4';

//             //Unsupported feature: Property Insertion (Visible) on "Estimates(Control 34)".


//             //Unsupported feature: Property Insertion (InstructionalTextML) on "Estimates(Control 34)".

//         }
//         modify("Activate First Stage")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Wizard Estimated Value (LCY)")
//         {
//             Caption = 'What is the estimated sales value (LCY)?';
//             ApplicationArea = Basic;
//             Enabled = WizardEstimatedValueLCYEnable;
//         }
//         modify("Wizard Chances of Success %")
//         {
//             Caption = 'What are the chances of success (%)?';
//             ApplicationArea = Basic;
//             Enabled = "WizardChancesofSuccess%Enable";
//         }
//         modify("Wizard Estimated Closing Date")
//         {
//             Caption = 'What is the estimated closing date?';
//             ApplicationArea = Basic;
//             Enabled = WizardEstimatedClosingDateEnab;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 23)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Creation Date"(Control 12)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Priority(Control 20)".

//         modify("Wizard Contact Name")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 4)".


//         //Unsupported feature: Property Deletion (Editable) on ""Salesperson Code"(Control 4)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Cycle Code"(Control 2)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on ""Sales Cycle Code"(Control 2)".


//         //Unsupported feature: Property Deletion (SourceExpr) on ""Sales Cycle Code"(Control 2)".

//         modify("Wizard Campaign Description")
//         {
//             Visible = false;
//         }
//         modify("Segment Description")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (Lookup) on ""Segment Description"(Control 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Segment Description"(Control 3)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on ""Segment Description"(Control 3)".


//         //Unsupported feature: Property Deletion (SourceExpr) on ""Segment Description"(Control 3)".


//         //Unsupported feature: Property Deletion (TableRelation) on ""Segment Description"(Control 3)".


//         //Unsupported feature: Property Deletion (Importance) on ""Segment Description"(Control 3)".


//         //Unsupported feature: Property Deletion (Editable) on ""Segment Description"(Control 3)".


//         //Unsupported feature: Code Modification on ""Activate First Stage"(Control 37).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             IF NOT "Activate First Stage" THEN BEGIN
//               "Wizard Estimated Value (LCY)" := 0;
//               "Wizard Chances of Success %" := 0;
//               "Wizard Estimated Closing Date" := 0D;
//             END;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             WizardEstimatedValueLCYEnable := "Activate First Stage";
//             "WizardChancesofSuccess%Enable" := "Activate First Stage";
//             WizardEstimatedClosingDateEnab := "Activate First Stage";

//             IF NOT "Activate First Stage" THEN BEGIN
//               OppEntry."Estimated Value (LCY)" := 0;
//               OppEntry."Chances of Success %" := 0;
//               OppEntry."Estimated Close Date" := 0D;
//             END;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Activate First Stage"(Control 37)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Wizard Estimated Value (LCY)"(Control 25)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Wizard Chances of Success %"(Control 27)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Wizard Estimated Closing Date"(Control 31)".

//         addfirst("Segment Description")
//         {
//             field("Wizard Campaign Description";Rec."Wizard Campaign Description")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'What campaign is the interaction linked to?';
//                 Editable = WizardCampaignDescriptionEdita;
//                 Lookup = false;
//                 MultiLine = true;
//                 TableRelation = Campaign;

//                 trigger OnAssistEdit()
//                 var
//                     Campaign: Record Campaign;
//                 begin
//                     if Rec.GetFilter(Rec."Campaign No.") = '' then
//                       if Page.RunModal(0,Campaign) = Action::LookupOK then begin
//                         Rec.Validate(Rec."Campaign No.",Campaign."No.");
//                         Rec."Wizard Campaign Description" := Campaign.Description;
//                       end;
//                 end;
//             }
//             field("Segment Description";Rec."Segment Description")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Opportunities will be created for contacts linked to segment';
//                 Editable = false;
//                 Lookup = false;
//                 MultiLine = true;
//                 TableRelation = "Segment Header";

//                 trigger OnAssistEdit()
//                 var
//                     Segment: Record "Segment Header";
//                 begin
//                     if SegHeader."No." = '' then
//                       if Page.RunModal(0,Segment) = Action::LookupOK then begin
//                         Rec.Validate(Rec."Segment No.",Segment."No.");
//                         Rec."Segment Description" := Segment.Description;
//                       end;
//                 end;
//             }
//         }
//         addafter("Sales Cycle Code")
//         {
//             field("Wizard Contact Name";Rec."Wizard Contact Name")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Which contact is involved?';
//                 Editable = "Wizard Contact NameEditable";
//                 Lookup = false;
//                 TableRelation = Contact;

//                 trigger OnAssistEdit()
//                 var
//                     Cont: Record Contact;
//                 begin
//                     if (Rec.GetFilter(Rec."Contact No.") = '') and (Rec.GetFilter(Rec."Contact Company No.") = '') then
//                       if (Cont."No." = '') and (Rec."Segment Description" = '') then begin
//                         if Cont.Get(Rec."Contact No.") then ;
//                         if Page.RunModal(0,Cont) = Action::LookupOK then begin
//                           Rec.Validate(Rec."Contact No.",Cont."No.");
//                           Rec."Wizard Contact Name" := Cont.Name;
//                         end;
//                       end;
//                 end;
//             }
//             field("Salesperson Code";Rec."Salesperson Code")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Which salesperson is involved with this opportunity?';
//                 Editable = "Salesperson CodeEditable";
//             }
//         }
//         moveafter(Control1900000001;"Segment Description")
//         moveafter(Priority;Estimates)
//         moveafter("Wizard Estimated Closing Date";"Sales Cycle Code")
//     }
//     actions
//     {
//         modify(FinishWizard)
//         {

//             //Unsupported feature: Property Modification (Name) on "FinishWizard(Action 10)".

//             ApplicationArea = Basic;
//             Enabled = FinishEnable;
//         }


//         //Unsupported feature: Code Modification on "FinishWizard(Action 10).OnAction".

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
//             CheckStatus;
//             FinishWizard;
//             CurrPage.CLOSE;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "FinishWizard(Action 10)".


//         //Unsupported feature: Property Deletion (Promoted) on "FinishWizard(Action 10)".


//         //Unsupported feature: Property Deletion (Visible) on "FinishWizard(Action 10)".

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
//                     PerformPrevWizardStatus;
//                     ShowStep(true);
//                     CurrPage.Update(true);
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
//                     Rec.CheckStatus;
//                     ShowStep(false);
//                     PerformNextWizardStatus;
//                     ShowStep(true);
//                     CurrPage.Update(true);
//                 end;
//             }
//         }
//     }

//     var
//         OppEntry: Record "Opportunity Entry";
//         FormWidth: Integer;
//         
//         WizardEstimatedValueLCYEnable: Boolean;
//         
//         "WizardChancesofSuccess%Enable": Boolean;
//         
//         WizardEstimatedClosingDateEnab: Boolean;
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
//         Step4Visible: Boolean;
//         
//         "Wizard Contact NameEditable": Boolean;
//         
//         "Salesperson CodeEditable": Boolean;
//         
//         "Sales Cycle CodeEditable": Boolean;

//     var
//         
//         FinishEnable: Boolean;
//         
//         BackEnable: Boolean;
//         
//         NextEnable: Boolean;


//     //Unsupported feature: Code Modification on "OnInit".

//     //trigger OnInit()
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         SalespersonCodeEditable := TRUE;
//         WizardCampaignDescriptionEdita := TRUE;
//         WizardContactNameEditable := TRUE;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         NextEnable := TRUE;
//         "Salesperson CodeEditable" := TRUE;
//         WizardCampaignDescriptionEdita := TRUE;
//         "Wizard Contact NameEditable" := TRUE;
//         WizardEstimatedClosingDateEnab := TRUE;
//         "WizardChancesofSuccess%Enable" := TRUE;
//         WizardEstimatedValueLCYEnable := TRUE;
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IsOnMobile := ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Phone;
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

//         UpdateEditable;

//         ShowStep(TRUE);
//         */
//     //end;

//     local procedure ShowStep(Visible: Boolean)
//     begin
//         case Rec."Wizard Step" of
//           Rec."wizard step"::"1":
//             begin
//               Step1Visible := Visible;
//               if Visible then begin
//                 FinishEnable := false;
//                 BackEnable := false;
//                 NextEnable := true;
//               end;
//             end;
//           Rec."wizard step"::"2":
//             begin
//               Step2Visible := Visible;
//               if Visible then begin
//                 FinishEnable := true;
//                 BackEnable := true;
//                 NextEnable := true;
//                 if "Wizard Contact NameEditable" then begin
//                 end
//                 else
//                   if "Salesperson CodeEditable" then begin
//                   end
//                   else
//                     if "Sales Cycle CodeEditable" then;
//               end;
//             end;
//           Rec."wizard step"::"3":
//             begin
//               Step3Visible := Visible;
//               if Visible then begin
//                 FinishEnable := true;
//                 BackEnable := true;
//                 NextEnable := true;
//               end;
//             end;
//           Rec."wizard step"::"4":
//             begin
//               Step4Visible := Visible;
//               if Visible then begin
//                 FinishEnable := true;
//                 BackEnable := true;
//                 NextEnable := false;
//               end;
//             end;
//         end;
//     end;

//     local procedure UpdateEditable()
//     begin
//         "Wizard Contact NameEditable" := false;
//         WizardCampaignDescriptionEdita := false;

//         if SalesPurchPerson.Get(Rec.GetFilter(Rec."Salesperson Code")) then
//           "Salesperson CodeEditable" := false;

//         WizardEstimatedValueLCYEnable := Rec."Activate First Stage";
//         "WizardChancesofSuccess%Enable" := Rec."Activate First Stage";
//         WizardEstimatedClosingDateEnab := Rec."Activate First Stage";
//     end;
// }
