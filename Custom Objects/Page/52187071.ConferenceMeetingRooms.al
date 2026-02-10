page 52187071 "Confe & Mtng Room Appl Card"
{
    ApplicationArea = All;
    Caption = 'Conference & Meeting Rooms Application Card';
    PageType = Card;
    SourceTable = "Conf & Meeting Rooms List";
    PromotedActionCategories = 'New,Process,Reports,Approvals';
    Editable = true;
   


    layout
    {
    area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;

                }
                field(Floor; Rec."Floor Location")
                {
            
                }
                field("Room Name"; Rec."Room Name")
                {
                
                }
                field("Room Status"; Rec."Room Status")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Created at"; Rec."Created At")
                {
                    Editable = false;
                }
            }
        }

    }
    actions
    {
        area(Creation)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()

                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    
                    Rec.TestField(Status, Rec.Status::Open);

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;

            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    if Rec.Status <> Rec.Status::Pending then
                        Error(DocMustbePending);

                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action("Re-Open Document")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category4;
                Image = ReOpen;

                trigger OnAction()
                begin

                    if not Confirm('Are you sure you want to re-open this document?') then exit;
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                    Message('Document Reopened Sucessfully.');
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    //// //ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action("Close Meeting Room")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Close Meeting Room';
                Image = Close;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    if not Confirm('Are you sure you want to close this Meeting Room?') then exit;
                    Rec."Room Status" := Rec."Room Status"::Closed;
                    Rec.Modify;
                    Message('Meeting Room Closed Sucessfully.');
                end;
            }
            

        }
    }
    trigger OnOpenPage();
    begin
        if UserSetup.Get(Rec."Created By") then begin
            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
            Rec."Created By" := UserId;
            Rec.Modify;
            
        end;
        if Rec.Status = Rec.Status::Approved then
            CurrPage.editable := false;
    end;
        Var
        UserSetup: Record "User Setup";
        PageEdit: Boolean;
        VarVariant: Variant;
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
}



//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; Rec."No.")
//                 {
//                     ToolTip = 'Specifies the value of the No. field.';
//                     Editable = false;
//                 }
//                 field("Date of Meeting/Function"; Rec."Date of Meeting/Function")
//                 {
//                     ToolTip = 'Specifies the value of the Date of Meeting/Function field.';
//                 }
//                 field("Type of Meeting"; Rec."Type of Meeting/Function")
//                 {
//                     ToolTip = 'Specifies the value of the Type of Meeting/Function field.';
//                     trigger OnValidate()
//                     begin
//                         if Rec."Type of Meeting/Function" = Rec."Type of Meeting/Function"::"Internal" then begin
//                             VisibleInternal := true;
//                             VisibleExternal := false;
//                         end;
//                         if Rec."Type of Meeting/Function" = Rec."Type of Meeting/Function"::"External" then begin
//                             VisibleInternal := false;
//                             VisibleExternal := true;
//                         end;
//                     end;
//                 }
//                 field("Meeting Room"; Rec."Meeting Room")
//                 {
//                     ToolTip = 'Specifies the value of the Meeting Room field.';
//                 }
//                 field("Meeting Room Name"; Rec."Meeting Room Name")
//                 {
//                     ToolTip = 'Specifies the value of the Meeting Room Name field.';
//                     Editable = false;
//                 }
//                 field("Start Time of Meeting/Function"; Rec."Start Time of Meeting/Function")
//                 {
//                     ToolTip = 'Specifies the value of the Start Time of Meeting/Function field.';
//                 }
//                 field("Duration of Meeting/Fucntion"; Rec."Duration of Meeting/Fucntion")
//                 {
//                     ToolTip = 'Specifies the value of the Duration of Meeting/Fucntion field.';
//                 }
//                 field("No. of Attendees"; Rec."No. of Attendees")
//                 {
//                     ToolTip = 'Specifies the value of the No. of Attendees field.';
//                 }
//                 field("Special Requirements"; Rec."Special Requirements")
//                 {
//                     ToolTip = 'Specifies the value of the Special Requirements field.';
//                 }
//                 field("Status of Booking"; Rec."Status of the Booking")
//                 {
//                     ToolTip = 'Specifies the value of the Status of Booking field.';
//                     Editable = false;
//                 }
//                 field("Status"; Rec.Status)
//                 {
//                     Editable = False;
//                 }
//                 field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
//                 {
//                     Editable = false;
//                 }
//                 field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
//                 {
//                     Editable = false;
//                 }
//                 field("Created By"; Rec."Created By")
//                 {
//                     Editable = false;
//                 }
//                 field("Created at"; Rec."Created at")
//                 {
//                     Editable = false;
//                 }
//             }  
//             group("Internal Details")
//             {
//                 Visible = VisibleInternal;
//                 field(Department; Rec."Resposibility Center")
//                 {
//                     ToolTip = 'Specifies the value of the Department field.';
//                     Editable = false;
//                 }
//                 field("Staff Requesting"; Rec."Staff Requesting")
//                 {
//                     ToolTip = 'Specifies the value of the Staff Requesting field.';
//                     Editable = false;
//                 }
//                 field("Staff Name"; Rec."Staff Name")
//                 {
//                     ToolTip = 'Specifies the value of the Staff Name field.';
//                     Editable = false;
//                 }
//             }
//             group("External Details")
//             {
//                 Visible = VisibleExternal;
//                 field("Client/Company Name"; Rec."Department/Client/Company Name")
//                 {
//                     ToolTip = 'Specifies the value of the Department/Client/Company Name field.';
//                     Visible = VisibleExternal;
//                 }
//                 field("Client/company"; Rec."Staff/client/company Details")
//                 {
//                     ToolTip = 'Specifies the value of the Details of staff/client/company requesting field.';
//                     Visible = VisibleInternal;
//                 }
//                 field("Address"; Rec."Address")
//                 {
//                     ToolTip = 'Specifies the value of the Address field.';
//                     Visible = VisibleExternal;
//                 }
//                 field("Contact Person"; Rec."Contact Person")
//                 {
//                     ToolTip = 'Specifies the value of the Contact Person field.';
//                     Visible = VisibleExternal;
//                 }
//                 field("Contact No."; Rec."Contact No.")
//                 {
//                     ToolTip = 'Specifies the value of the Contact No. field.';
//                     Visible = VisibleExternal;
//                 }
//             }

//         }
//     }
//     actions
//     {
//         area(creation)
//         {
//             action("Send For Approval")
//             {
//                 Caption = 'Send For Approval';
//                 trigger OnAction()
//                 begin
//                     Rec."Status" := Rec."Status"::Pending;
//                     Rec.MODIFY;
//                     MESSAGE('Request Sent for Approval');

//                 end;
//             }
//             action("Defer")
//             {
//                 Caption = 'Cancel Appliation';
//                 trigger OnAction()
//                 begin
//                     Rec."Status" := Rec."Status"::Deffered;
//                     Rec.MODIFY;
//                     MESSAGE('Deffered');
//                 end;
//             }
//             action("Reject Application")
//             {
//                 Caption = 'Reject Application';
//                 trigger OnAction()
//                 begin
//                     Rec."Status" := Rec."Status"::Rejected;
//                     Rec.MODIFY;
//                     MESSAGE('Rejected');
//                 end;
//             }
//         }
//     }
//     trigger OnOpenPage()
//     begin
//         PageControl();
//     end;

//     local procedure PageControl()
//     begin
//         VisibleExternal := false;
//         VisibleInternal := false;

//         if Rec."Type of Meeting/Function" = Rec."Type of Meeting/Function"::"Internal" then begin
//             VisibleInternal := true;
//             VisibleExternal := false;
//         end;
//         if Rec."Type of Meeting/Function" = Rec."Type of Meeting/Function"::"External" then begin
//             VisibleInternal := false;
//             VisibleExternal := true;
//         end;
//         if Rec."Type of Meeting/Function" = Rec."Type of Meeting/Function"::" " then begin
//             VisibleInternal := false;
//             VisibleExternal := false;
//         end;
//     end;

//     var
//     VisibleInternal: Boolean;
//     VisibleExternal: Boolean;   
// }
