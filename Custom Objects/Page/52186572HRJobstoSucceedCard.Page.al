// page 52186572 "HR Jobs to Succeed Card"
// {
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = Card;
//     PromotedActionCategories = 'New,Process,Report,Functions,Job';
//     SourceTable = "HR Jobs";
//     SourceTableView = WHERE("Marked for Succession" = FILTER(true));

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("Job ID"; Rec."Job ID")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Job Description"; Rec."Job Description")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Job Title';
//                     Importance = Promoted;
//                 }
//                 group(Control17)
//                 {
//                     ShowCaption = false;
//                     grid(Control16)
//                     {
//                         GridLayout = Rows;
//                         ShowCaption = false;
//                         group(Control15)
//                         {
//                             ShowCaption = false;
//                             field("Position Reporting to"; Rec."Position Reporting to")
//                             {
//                                 ApplicationArea = Basic;
//                                 Importance = Promoted;
//                             }
//                             field("Position Reporting Name"; Rec."Position Reporting Name")
//                             {
//                                 ApplicationArea = Basic;
//                                 ShowCaption = false;
//                             }
//                         }
//                     }
//                 }
//                 field(Grade; Rec.Grade)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("No of Posts"; Rec."No of Posts")
//                 {
//                     ApplicationArea = Basic;
//                     Importance = Promoted;
//                 }
//                 field("Occupied Positions"; Rec."Occupied Positions")
//                 {
//                     ApplicationArea = Basic;
//                     Importance = Promoted;
//                 }
//                 field("Vacant Positions"; Rec."Vacant Positions")
//                 {
//                     ApplicationArea = Basic;
//                     Importance = Promoted;
//                 }
//                 group(Control13)
//                 {
//                     ShowCaption = false;
//                     grid(Control12)
//                     {
//                         GridLayout = Rows;
//                         ShowCaption = false;
//                         group(Control11)
//                         {
//                             ShowCaption = false;
//                         }
//                     }
//                 }
//                 field("Employee Requisitions"; Rec."Employee Requisitions")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Date Created"; Rec."Date Created")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Style = Attention;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                     Importance = Promoted;
//                     Style = Attention;
//                 }
//                 field("Marked for Succession"; Rec."Marked for Succession")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             group(Dimensions)
//             {
//                 Caption = 'Dimensions';
//                 group(Control29)
//                 {
//                     ShowCaption = false;
//                     grid(Control10)
//                     {
//                         GridLayout = Rows;
//                         ShowCaption = false;
//                         group(Control9)
//                         {
//                             ShowCaption = false;
//                             field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                             {
//                                 ApplicationArea = Basic;
//                                 Caption = 'Department';
//                             }
//                             field("Global Dimension 1 Name"; Rec."Global Dimension 1 Name")
//                             {
//                                 ApplicationArea = Basic;
//                                 ShowCaption = false;
//                             }
//                         }
//                     }
//                 }
//                 group(Control6)
//                 {
//                     ShowCaption = false;
//                     grid(Control5)
//                     {
//                         GridLayout = Rows;
//                         ShowCaption = false;
//                         group(Control4)
//                         {
//                             ShowCaption = false;
//                             field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                             {
//                                 ApplicationArea = Basic;
//                                 Caption = 'Region';
//                             }
//                             field("Global Dimension 2 Name"; Rec."Global Dimension 2 Name")
//                             {
//                                 ApplicationArea = Basic;
//                                 ShowCaption = false;
//                             }
//                         }
//                     }
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part(Control1102755004; "HR Jobs Factbox")
//             {
//                 SubPageLink = "Job Description" = FIELD("Job ID");
//                 ApplicationArea = Basic;
//             }
//             systempart(Control1102755006; Outlook)
//             {
//                 ApplicationArea = Basic;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Job)
//             {
//                 action(Requirements)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Requirements';
//                     Image = Card;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     RunObject = Page "HR Job Requirement Lines";
//                     RunPageLink = "Job ID" = FIELD("Job ID");
//                 }
//                 action(Responsibilities)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Responsibilities';
//                     Image = JobResponsibility;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     RunObject = Page "HR Job Responsiblities Lines";
//                     RunPageLink = "Job ID" = FIELD("Job ID");
//                 }
//                 action(Occupants)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Occupants';
//                     Image = ContactPerson;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     RunObject = Page "HR Job Occupants";
//                     RunPageLink = "Job ID" = FIELD("Job ID");
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin


//         Rec.Validate("Vacant Positions");
//         UpdateControls;
//     end;

//     var
//         HREmployees: Record "HR Employees";

//     local procedure UpdateControls()
//     begin
//         CurrPage.Editable := false;

//         if Rec.Status = Rec.Status::Open then begin
//             CurrPage.Editable := true;
//         end;
//     end;

//     //[Scope('OnPrem')]
//     procedure RecordLinkCheck(job: Record "HR Jobs") RecordLnkExist: Boolean
//     var
//         objRecordLnk: Record "Record Link";
//         TableCaption: RecordID;
//         objRecord_Link: RecordRef;
//     begin
//         objRecord_Link.GetTable(job);
//         TableCaption := objRecord_Link.RecordId;
//         objRecordLnk.Reset;
//         objRecordLnk.SetRange(objRecordLnk."Record ID", TableCaption);
//         if objRecordLnk.Find('-') then exit(true) else exit(false);
//     end;
// }

