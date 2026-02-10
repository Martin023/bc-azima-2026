// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186281 pageextension52186281 extends "Create Task" 
// {

//     //Unsupported feature: Property Modification (Name) on ""Create Task"(Page 5097)".

//     Caption = 'Create To-do';

//     //Unsupported feature: Property Modification (PageType) on ""Create Task"(Page 5097)".

//     layout
//     {
//         modify(General)
//         {

//             //Unsupported feature: Property Modification (Name) on "General(Control 1)".

//             Caption = 'Step 1';

//             //Unsupported feature: Property Insertion (Visible) on "General(Control 1)".


//             //Unsupported feature: Property Insertion (InstructionalTextML) on "General(Control 1)".

//         }
//         modify(TypeSaaS)
//         {

//             //Unsupported feature: Property Modification (Name) on "TypeSaaS(Control 18)".

//             Caption = 'What is the type of the to-do?';
//             ApplicationArea = Basic;
//         }
//         modify(Description)
//         {
//             ApplicationArea = Basic;
//             Caption = 'Describe your to-do.';
//         }
//         modify(AllDayEvent)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Date)
//         {
//             Caption = 'What is the start date of the to-do?';
//             ApplicationArea = Basic;
//         }
//         modify("Start Time")
//         {
//             Caption = 'What is the start time of the to-do?';
//             ApplicationArea = Basic;
//             Enabled = "Start TimeEnable";
//         }
//         modify(Duration)
//         {
//             Caption = 'What is the duration of the to-do?';
//             ApplicationArea = Basic;
//         }
//         modify("Ending Date")
//         {
//             Caption = 'What is the end date of the to-do?';
//             ApplicationArea = Basic;
//         }
//         modify("Ending Time")
//         {
//             Caption = 'What is the end time of the to-do?';
//             ApplicationArea = Basic;
//             Enabled = "Ending TimeEnable";
//         }
//         modify(TeamTask)
//         {

//             //Unsupported feature: Property Modification (Name) on "TeamTask(Control 29)".

//             Caption = 'Team to-do';
//             ApplicationArea = Basic;
//             Editable = TeamTodoEditable;
//         }
//         modify(Priority)
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "Priority(Control 2)".


//             //Unsupported feature: Property Modification (Name) on "Priority(Control 2)".

//             Enabled = "Language CodeEnable";
//         }
//         // modify(Location)
//         // {

//         //     //Unsupported feature: Property Modification (Level) on "Location(Control 3)".


//         //     //Unsupported feature: Property Modification (ControlType) on "Location(Control 3)".


//         //     //Unsupported feature: Property Modification (Name) on "Location(Control 3)".

//         //     Caption = 'Step 3';

//             //Unsupported feature: Property Modification (Visible) on "Location(Control 3)".


//             //Unsupported feature: Property Insertion (GroupType) on "Location(Control 3)".


//             //Unsupported feature: Property Insertion (InstructionalTextML) on "Location(Control 3)".

//       //}

//         modify(MeetingAttendees)
//         {

//             //Unsupported feature: Property Modification (Level) on "MeetingAttendees(Control 20)".


//             //Unsupported feature: Property Modification (ControlType) on "MeetingAttendees(Control 20)".


//             //Unsupported feature: Property Modification (Name) on "MeetingAttendees(Control 20)".

//             Caption = 'What is the priority of the to-do?';

//             //Unsupported feature: Property Insertion (SourceExpr) on "MeetingAttendees(Control 20)".

//             //ApplicationArea = all;
//         }
//         modify(RecurringOptions)
//         {

//             //Unsupported feature: Property Modification (Name) on "RecurringOptions(Control 4)".

//             Caption = 'Step 4';

//             //Unsupported feature: Property Insertion (Visible) on "RecurringOptions(Control 4)".


//             //Unsupported feature: Property Insertion (InstructionalTextML) on "RecurringOptions(Control 4)".

//         }
//         modify(Recurring)
//         {
//             Caption = 'Recurring to-do.';
//             ApplicationArea = Basic;
//         }
//         modify("Recurring Date Interval")
//         {
//             Caption = 'What is the recurring date interval?';
//             ApplicationArea = Basic;
//             Enabled = "Recurring Date IntervalEnable";
//         }
//         modify("Calc. Due Date From")
//         {
//             Caption = 'From which date do you want to calculate the due date?';
//             ApplicationArea = Basic;
//             Enabled = "Calc. Due Date FromEnable";
//         }

//         //Unsupported feature: Code Modification on "TypeSaaS(Control 18).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             ValidateTypeField;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             IF Type <> xRec.Type THEN
//               IF Type = Type::Meeting THEN BEGIN
//                 AssignDefaultAttendeeInfo;
//                 LoadTempAttachment;
//               END ELSE
//                 ClearDefaultAttendeeInfo;
//             TypeOnAfterValidate;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "TypeSaaS(Control 18)".


//         //Unsupported feature: Property Deletion (OptionCaptionML) on "TypeSaaS(Control 18)".


//         //Unsupported feature: Property Deletion (Visible) on "TypeSaaS(Control 18)".

//         modify(TypeOnPrem)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 23)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "AllDayEvent(Control 44)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Date(Control 12)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Start Time"(Control 49)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Duration(Control 51)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Date"(Control 45)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Time"(Control 55)".



//         //Unsupported feature: Code Modification on "TeamTask(Control 29).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             IF NOT "Team To-do" THEN BEGIN
//               "Team Code" := '';
//               SalespersonCodeEnable := FALSE;
//               IF Type = Type::Meeting THEN BEGIN
//                 ClearDefaultAttendeeInfo;
//                 AssignDefaultAttendeeInfo;
//               END;
//             END;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             IF NOT "Team To-do" THEN BEGIN
//               "Team Code" := '';
//               IF Type = Type::Meeting THEN BEGIN
//                 ClearDefaultAttendeeInfo;
//                 AssignDefaultAttendeeInfo
//               END
//             END
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "TeamTask(Control 29)".

//         // modify("Wizard Contact Name")
//         // {
//         //     Visible = false;
//         // }
//         // modify("Salesperson Code")
//         // {
//         //     Visible = false;
//         // }
//         // modify("Team Code")
//         // {
//         //     Visible = false;
//         // }
//         // modify("Wizard Campaign Description")
//         // {
//         //     Visible = false;
//         // }
//         // modify("Wizard Opportunity Description")
//         // {
//         //     Visible = false;
//         // }
//         // modify(SegmentDesc)
//         // {
//         //     Visible = false;
//         // }


//         // //Unsupported feature: Code Insertion on ""Language Code"(Control 2)".

//         // //trigger OnLookup(var Text: Text): Boolean
//         // //begin
//         //     /*
//         //     LookupLanguageCode;
//         //     */
//         // //end;


//         //Unsupported feature: Code Insertion on ""Language Code"(Control 2)".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //begin
//             /*
//             ValidateLanguageCode;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (CaptionML) on "Priority(Control 2)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Priority(Control 2)".


//         //Unsupported feature: Property Deletion (Importance) on "Priority(Control 2)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Location(Control 3)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Location(Control 3)".


//         //Unsupported feature: Property Deletion (SourceExpr) on "Location(Control 3)".


//         //Unsupported feature: Property Deletion (Importance) on "Location(Control 3)".


//         //Unsupported feature: Property Deletion (Enabled) on "Location(Control 3)".


//         //Unsupported feature: Property Deletion (Visible) on "MeetingAttendees(Control 20)".


//         //Unsupported feature: Property Deletion (GroupType) on "MeetingAttendees(Control 20)".

//         // modify(AttendeeSubform)
//         // {
//         //     Visible = false;
//         // }
//         // modify(MeetingInteraction)
//         // {
//         //     Visible = false;
//         // }
//         // modify("Send on finish")
//         // {
//         //     Visible = false;
//         // }
//         // modify("Interaction Template Code")
//         // {
//         //     Visible = false;
//         // }
//         // modify("Language Code")
//         // {
//         //     Visible = false;
//         // }
//         modify(Attachment)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Recurring(Control 17)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Recurring Date Interval"(Control 26)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Calc. Due Date From"(Control 34)".

//         addfirst(Content)
//         {
//             group(Step2)
//             {
//                 Caption = 'Step 2';
//                 InstructionalText = 'If you want to invite attendees, you may now select them from contacts and salespeople.';
//                 Visible = Step2Visible;
//                 part(AttendeeSubform;"Attendee Wizard Subform")
//                 {
//                     SubPageLink = "To-do No."=field("No.");
//                     Visible = AttendeeSubformVisible;
//                 }
//                 field("Send on finish";Rec."Send on finish")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Send invitation(s) when I click Finish.';
//                 }
//                 field("Interaction Template Code";Rec."Interaction Template Code")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Which template will you use for this e-mail invitation?';
//                     TableRelation = "Interaction Template";

//                     trigger OnValidate()
//                     begin
//                         Rec.ValidateInteractionTemplCode;
//                         InteractionTemplateCodeOnAfter;
//                     end;
//                 }
//             }
//         }
//         addfirst(Priority)
//         {
//             field(Attachment;Rec."Attachment No." > 0)
//             {
//                 ApplicationArea = Basic;
//                 AssistEdit = true;
//                 Caption = 'Attachment';
//                 Editable = false;
//                 Enabled = AttachmentEnable;

//                 trigger OnAssistEdit()
//                 begin
//                     Rec.AssistEditAttachment;
//                 end;
//             }
//         }
//         addafter(Location)
//         {
//             field("Wizard Campaign Description";Rec."Wizard Campaign Description")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'To which campaign is the to-do linked?';
//                 Editable = WizardCampaignDescriptionEdita;
//                 Lookup = false;
//                 TableRelation = Campaign;

//                 trigger OnAssistEdit()
//                 var
//                     Campaign: Record Campaign;
//                 begin
//                     if Rec.GetFilter(Rec."Campaign No.") = '' then begin
//                       if Campaign.Get(Rec."Campaign No.") then ;
//                       if Page.RunModal(0,Campaign) = Action::LookupOK then begin
//                         Rec.Validate(Rec."Campaign No.",Campaign."No.");
//                         Rec."Wizard Campaign Description" := Campaign.Description;
//                       end;
//                     end;
//                 end;
//             }
//             field("Wizard Opportunity Description";Rec."Wizard Opportunity Description")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'What is the opportunity?';
//                 Editable = WizardOpportunityDescriptionEd;
//                 Lookup = false;
//                 TableRelation = Opportunity;

//                 trigger OnAssistEdit()
//                 var
//                     Opp: Record Opportunity;
//                 begin
//                     if Rec.GetFilter(Rec."Opportunity No.") = '' then begin
//                       if Opp.Get(Rec."Opportunity No.") then ;
//                       if Page.RunModal(0,Opp) = Action::LookupOK then begin
//                         Rec.Validate(Rec."Opportunity No.",Opp."No.");
//                         Rec."Wizard Opportunity Description" := Opp.Description;
//                       end;
//                     end;
//                 end;
//             }
//             field(SegmentDesc;Rec."Segment Description")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'To-dos will be created for contacts linked to segment:';
//                 Editable = SegmentDescEditable;
//                 Lookup = false;
//                 TableRelation = "Segment Header";

//                 trigger OnAssistEdit()
//                 var
//                     Segment: Record "Segment Header";
//                 begin
//                     if Rec.GetFilter(Rec."Segment No.") = '' then begin
//                       if Segment.Get(Rec."Segment No.") then ;
//                       if Page.RunModal(0,Segment) = Action::LookupOK then begin
//                         Rec.Validate(Rec."Segment No.",Segment."No.");
//                         Rec."Segment Description" := Segment.Description;
//                       end;
//                     end;
//                 end;
//             }
//         }
//         addfirst(MeetingAttendees)
//         {
//             field(Location;Rec.Location)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'What is the location of the to-do?';
//                 Enabled = LocationEnable;
//             }
//         }
//         addafter(General)
//         {
//             group(Step2NoAttendees)
//             {
//                 Caption = 'Step 2 - No Attendees';
//                 InstructionalText = 'You must now record the contact, and the salesperson or the team linked to this to-do.';
//                 Visible = Step2NoAttendeesVisible;
//                 field("Wizard Contact Name";Rec."Wizard Contact Name")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Who is the contact?';
//                     Editable = "Wizard Contact NameEditable";
//                     Enabled = "Wizard Contact NameEnable";
//                     Lookup = false;
//                     TableRelation = Contact;

//                     trigger OnAssistEdit()
//                     var
//                         Cont: Record Contact;
//                     begin
//                         if (Rec.GetFilter(Rec."Contact No.") = '') and (Rec.GetFilter(Rec."Contact Company No.") = '') and (Rec."Segment Description" = '') then begin
//                           if Cont.Get(Rec."Contact No.") then ;
//                           if Page.RunModal(0,Cont) = Action::LookupOK then begin
//                             Rec.Validate(Rec."Contact No.",Cont."No.");
//                             Rec."Wizard Contact Name" := Cont.Name;
//                           end;
//                         end;
//                     end;
//                 }
//                 field("Salesperson Code";Rec."Salesperson Code")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Who is the salesperson responsible?';
//                     Editable = "Salesperson CodeEditable";
//                     Enabled = "Salesperson CodeEnable";
//                 }
//                 field("Team Code";Rec."Team Code")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'What is the team code?';
//                     Editable = "Team CodeEditable";
//                     Enabled = "Team CodeEnable";

//                     trigger OnValidate()
//                     begin
//                         if (xRec."Team Code" <> Rec."Team Code") and
//                            (Rec."Team Code" <> '') and
//                            (Rec.Type = Rec.Type::Meeting)
//                         then begin
//                           Rec.ClearDefaultAttendeeInfo;
//                           Rec.AssignDefaultAttendeeInfo
//                         end
//                     end;
//                 }
//             }
//         }
//         moveafter(Control1900000001;Priority)
//     }
//     actions
//     {
//         modify(Finish)
//         {
//             ApplicationArea = Basic;
//             Enabled = FinishEnable;
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
//             CurrPage.AttendeeSubform.PAGE.GetAttendee(AttendeeTemp);
//             SetAttendee(AttendeeTemp);

//             CheckStatus;
//             FinishWizard;
//             CurrPage.CLOSE;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "Finish(Action 10)".


//         //Unsupported feature: Property Deletion (Promoted) on "Finish(Action 10)".


//         //Unsupported feature: Property Deletion (Visible) on "Finish(Action 10)".

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
//                     // UpdateCntrls;
//                 end;
//             }
//             action(NextStep)
//             {
//                 ApplicationArea = Basic;
//                 Caption = '&Next';
//                 Enabled = NextEnable;
//                 Image = NextRecord;
//                 InFooterBar = true;

//                 trigger OnAction()
//                 begin
//                     if Rec."Wizard Step" = Rec."wizard step"::"3" then begin
//                       CurrPage.AttendeeSubform.Page.GetAttendee(AttendeeTemp);
//                       Rec.SetAttendee(AttendeeTemp);
//                     end;

//                     Rec.CheckStatus;
//                     ShowStep(false);
//                     PerformNextWizardStatus;
//                     ShowStep(true);
//                     CurrPage.Update(true);
//                     // UpdateCntrls;
//                 end;
//             }
//         }
//     }


//     //Unsupported feature: Property Modification (Length) on "SalespersonFilter(Variable 1026)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //SalespersonFilter : 20;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //SalespersonFilter : 10;
//         //Variable type has not been exported.

//     var
//         FormWidth: Integer;

//     var
//         
//         TeamTodoEditable: Boolean;
//         
//         "Wizard Contact NameEditable": Boolean;

//     var
//         
//         "Salesperson CodeEditable": Boolean;
//         
//         "Team CodeEditable": Boolean;

//     var
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
//         Step2NoAttendeesVisible: Boolean;
//         
//         Step2Visible: Boolean;
//         
//         AttendeeSubformVisible: Boolean;
//         
//         Step3Visible: Boolean;
//         
//         Step4Visible: Boolean;
//         
//         "Salesperson CodeEnable": Boolean;
//         
//         "Team CodeEnable": Boolean;
//         
//         "Start TimeEnable": Boolean;
//         
//         "Ending TimeEnable": Boolean;

//     var
//         
//         FinishEnable: Boolean;
//         
//         BackEnable: Boolean;
//         
//         NextEnable: Boolean;
//         
//         "Wizard Contact NameEnable": Boolean;
//         
//         "Recurring Date IntervalEnable": Boolean;
//         
//         "Calc. Due Date FromEnable": Boolean;
//         
//         "Language CodeEnable": Boolean;


//     //Unsupported feature: Code Modification on "OnInit".

//     //trigger OnInit()
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         AttachmentEnable := TRUE;
//         LanguageCodeEnable := TRUE;
//         CalcDueDateFromEnable := TRUE;
//         RecurringDateIntervalEnable := TRUE;
//         WizardContactNameEnable := TRUE;
//         AllDayEventEnable := TRUE;
//         LocationEnable := TRUE;
//         DurationEnable := TRUE;
//         EndingTimeEnable := TRUE;
//         StartTimeEnable := TRUE;
//         SalespersonCodeEnable := TRUE;
//         SalespersonCodeEditable := TRUE;
//         WizardOpportunityDescriptionEd := TRUE;
//         WizardCampaignDescriptionEdita := TRUE;
//         WizardContactNameEditable := TRUE;
//         TeamTaskEditable := TRUE;
//         IsSoftwareAsAService := PermissionManager.SoftwareAsAService;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         AttachmentEnable := TRUE;
//         "Language CodeEnable" := TRUE;
//         "Calc. Due Date FromEnable" := TRUE;
//         "Recurring Date IntervalEnable" := TRUE;
//         "Wizard Contact NameEnable" := TRUE;
//         NextEnable := TRUE;
//         #6..8
//         "Ending TimeEnable" := TRUE;
//         "Start TimeEnable" := TRUE;
//         "Team CodeEnable" := TRUE;
//         "Salesperson CodeEnable" := TRUE;
//         AttendeeSubformVisible := TRUE;
//         "Team CodeEditable" := TRUE;
//         "Salesperson CodeEditable" := TRUE;
//         WizardOpportunityDescriptionEd := TRUE;
//         WizardCampaignDescriptionEdita := TRUE;
//         "Wizard Contact NameEditable" := TRUE;
//         TeamTodoEditable := TRUE;
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IsOnMobile := ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Phone;

//         WizardContactNameEditable := FALSE;
//         WizardCampaignDescriptionEdita := FALSE;
//         WizardOpportunityDescriptionEd := FALSE;

//         IF SalesPurchPerson.GET(GETFILTER("Salesperson Code")) THEN BEGIN
//           SalespersonCodeEditable := FALSE;
//           TeamTaskEditable := FALSE;
//         END;

//         IF "Segment Description" <> '' THEN
//           SegmentDescEditable := FALSE;

//         IsMeeting := (Type = Type::Meeting);
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

//         "Wizard Contact NameEditable" := FALSE;
//         #4..7
//           "Salesperson CodeEditable" := FALSE;
//           TeamTodoEditable := FALSE;
//         END;

//         IF "Team To-do" THEN BEGIN
//           "Team CodeEditable" := FALSE;
//           TeamTodoEditable := FALSE;
//         #10..14
//         ShowStep(TRUE);
//         */
//     //end;


//     //Unsupported feature: Code Modification on "EnableFields(PROCEDURE 21)".

//     //procedure EnableFields();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         RecurringDateIntervalEnable := Recurring;
//         CalcDueDateFromEnable := Recurring;

//         IF NOT Recurring THEN BEGIN
//           EVALUATE("Recurring Date Interval",'');
//           CLEAR("Calc. Due Date From");
//         END;

//         IsMeeting := Type = Type::Meeting;

//         IF IsMeeting THEN BEGIN
//           StartTimeEnable := NOT "All Day Event";
//           EndingTimeEnable := NOT "All Day Event";
//           DurationEnable := NOT "All Day Event";
//           LocationEnable := TRUE;
//           AllDayEventEnable := TRUE;
//           LanguageCodeEnable := "Interaction Template Code" <> '';
//           AttachmentEnable := "Interaction Template Code" <> '';
//         END ELSE BEGIN
//           StartTimeEnable := FALSE;
//           EndingTimeEnable := FALSE;
//           LocationEnable := FALSE;
//           DurationEnable := FALSE;
//           AllDayEventEnable := FALSE;
//         END;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         "Recurring Date IntervalEnable" := Recurring;
//         "Calc. Due Date FromEnable" := Recurring;
//         #3..8
//         IF Type = Type::Meeting THEN BEGIN
//           "Start TimeEnable" := NOT "All Day Event";
//           "Ending TimeEnable" := NOT "All Day Event";
//         #14..16
//           "Language CodeEnable" := "Interaction Template Code" <> '';
//           AttachmentEnable := "Interaction Template Code" <> '';
//         END ELSE BEGIN
//           "Start TimeEnable" := FALSE;
//           "Ending TimeEnable" := FALSE;
//         #22..25
//         */
//     //end;

//     //Unsupported feature: Parameter Insertion (Parameter: Visible) (ParameterCollection) on "ShowStep(PROCEDURE 2)".


//     //Unsupported feature: Property Modification (Name) on "FinishPage(PROCEDURE 2)".



//     //Unsupported feature: Code Modification on "FinishPage(PROCEDURE 2)".

//     //procedure FinishPage();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         CurrPage.AttendeeSubform.PAGE.GetAttendee(AttendeeTemp);
//         SetAttendee(AttendeeTemp);

//         CheckStatus;
//         FinishWizard(FALSE);
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
//               END;
//             END;
//           "Wizard Step"::"2":
//             BEGIN
//               Step2NoAttendeesVisible := Visible;

//               IF Visible THEN BEGIN
//                 IF "Team To-do" = FALSE THEN BEGIN
//                   "Salesperson CodeEnable" := Visible;
//                   "Team CodeEnable" := NOT Visible;
//                 END ELSE BEGIN
//                   "Salesperson CodeEnable" := NOT Visible;
//                   "Team CodeEnable" := Visible;
//                 END;
//                 BackEnable := TRUE;
//                 IF Type = Type::Meeting THEN
//                   "Wizard Contact NameEnable" := FALSE
//                 ELSE
//                   FinishEnable := Visible;
//               END;
//             END;
//           "Wizard Step"::"3":
//             BEGIN
//               Step2Visible := Visible;
//               IF NOT Visible THEN
//                 CurrPage.AttendeeSubform.PAGE.GetAttendee(AttendeeTemp);
//               IF Visible THEN BEGIN
//                 GetAttendee(AttendeeTemp);
//                 CurrPage.AttendeeSubform.PAGE.SetAttendee(AttendeeTemp);
//                 CurrPage.AttendeeSubform.PAGE.SetTodoFilter(SalespersonFilter,ContactFilter);
//                 CurrPage.AttendeeSubform.PAGE.UpdateForm;
//               END;

//               IF Visible THEN BEGIN
//                 FinishEnable := TRUE;
//                 BackEnable := TRUE;
//                 NextEnable := TRUE;
//               END;
//             END;
//           4:
//             BEGIN
//               Step3Visible := Visible;
//               IF Visible THEN BEGIN
//                 FinishEnable := TRUE;
//                 BackEnable := TRUE;
//                 NextEnable := TRUE;
//               END;
//             END;
//           5:
//             BEGIN
//               Step4Visible := Visible;
//               IF Visible THEN BEGIN
//                 FinishEnable := TRUE;
//                 BackEnable := TRUE;
//                 NextEnable := FALSE;
//               END;
//             END;
//         END;
//         */
//     //end;
// }
