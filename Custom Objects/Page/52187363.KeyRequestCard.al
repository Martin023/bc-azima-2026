page 52187363 "Key Request Card"
{
    ApplicationArea = All;
    Caption = 'Key Request Card';
    PageType = Card;
    SourceTable = "Key Request Table";
    PromotedActionCategories = 'New,Process,Reports,Approvals,Views,Home,Creation';
    DeleteAllowed = false;
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Key Request No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Key Request No.';
                    Editable = false;
                }
                field("Date of Request"; Rec."Date of Request")
                {
                    ApplicationArea = All;
                    Caption = 'Date of Request';
                    Editable = true;
                }
                field("Staff No."; Rec."Staff Number")
                {
                    ApplicationArea = All;
                    Caption = 'Staff No.';
                    ShowMandatory = true;
                }
                field("Staff Name"; Rec."Name")
                {
                    ApplicationArea = All;
                    Caption = 'Staff Name';
                    Editable = false;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department Name';
                    ShowMandatory = true;
                    //Editable = false;
                }
                // field("Key No."; Rec."Key No.")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Key No.';
                // }
                field("Key Room/Office Name"; Rec."Name of Room/Office")
                {
                    Caption = 'Key Room/Office Name';
                    ApplicationArea = All;
                   // Caption = 'Key Name';
                }
                field("Purpose of Request"; Rec."Purpose of Request")
                {
                    ApplicationArea = All;
                    Caption = 'Purpose of Request';
                    ShowMandatory = true;
                    //Editable = false;
                }
                field("Key Status";Rec."Key Status")
                {
                    ApplicationArea = All;
                    Caption = 'Key Status';
                   Editable = false;
                }
                field(Received;Rec.Received)
                {
                    ApplicationArea = All;
                    Caption = 'Received';
                    Editable = false;
                }
                field("Date Received"; Rec."Date Received")
                {
                    ApplicationArea = All;
                    Caption = 'Date Received';
                    Editable = false;
                }
                field(Returned;Rec.Returned)
                {
                    ApplicationArea = All;
                    Caption = 'Returned';
                    Editable = false;
                }
                field("Date Returned"; Rec."Date Returned")
                {
                    ApplicationArea = All;
                    Caption = 'Date Returned';
                    EDITABLE = FALSE;
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Caption = 'Responsibility Center';
                    Editable = false;
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Global Dimension 1 Code';
                    Editable = false;
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Global Dimension 2 Code';
                    Editable = false;
                }
                field("Created at"; Rec."Created at")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created by"; Rec."Created by")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                } 
            }
            group("Dispatch Details")
            {
                field("Key"; Rec."Key No.")
                {
                    ApplicationArea = All;
                    Caption = 'Key';
                }
                field("Key Office Name"; Rec."Key Room Name")
                {
                    ApplicationArea = All;
                    Caption = 'Key Room/Office Name';
                    Editable = false;
                }
                FIELD(Dispatched;Rec.Dispatched)
                {
                    ApplicationArea = All;
                    Caption = 'Dispatched';
                    Editable = false;
                }
                field("Dispatch Date"; Rec."Date of Issue")
                {
                    ApplicationArea = All;
                    Caption = 'Dispatch Date';
                    Editable = False;
                }
                field(Closed;Rec.Closed)
                {
                    ApplicationArea = All;
                    Caption = 'Closed';
                    Editable = false;
                }
                field("Date Closed"; Rec."Date Closed")
                {
                    ApplicationArea = All;
                    Caption = 'Date Closed';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
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
                    Rec.TestField("Staff Number");
                    //Rec.TestField(Name);
                    //Rec.TestField("Key Room Name");
                    Rec.TestField("Name of Room/Office");
                    Rec.TestField("Purpose of Request");
                    Rec.TestField("Department Name");
                    //Rec.TestField("Key Room Name");
                    REc.TestField("Date of Request");


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
                    if Rec.Status = Rec.Status::Open then
                    Error('Document is Open!');
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
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
           
            // action(Request)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Request';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Image = Request;
            //     trigger OnAction()
            //     begin
            //         Rec.TestField(Status, Rec.Status::Approved);
            //         Rec.TestField("Key Status" , Rec."Key Status"::Open);
            //         Rec.TestField("Staff Number");
            //         Rec.TestField("Key Room Name");
            //         Rec.TestField("Purpose of Request");
            //         Rec.TestField("Department Name");
            //         Rec.TestField("Key Room Name");
            //         REc.TestField("Date of Request");
                    
            //         Rec."Key Status" := Rec."Key Status"::Requested;
            //         Rec.MODIFY;
            //         MESSAGE('Key Requested');
            //     end;
            // }   
            action("Receive Key")
            {
                ApplicationArea = All;
                Caption = 'Receive Key';    
                Promoted = true;
                PromotedCategory = Process;
                Image = Receive;
                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec."Date Received" := CURRENTDATETIME;
                    Rec.Received := True;
                    Rec."Key Status" := Rec."Key Status"::Received;
                    Rec.MODIFY;
                    MESSAGE('Key Received');
                end;
            }
            action("Return Key")
            {
                ApplicationArea = All;
                Caption = 'Return Key';
                Promoted = true;
                PromotedCategory = Process;
                Image = Return;
                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField("Key Status" , Rec."Key Status"::Received);
                    Rec."Date Returned" := CURRENTDATETIME;
                    Rec.Returned := True;
                    Rec."Key Status" := Rec."Key Status"::Returned;
                    Rec.MODIFY;
                    MESSAGE('Key Returned');
                    
                    // KeyDispatch.RESET;
                    // KeyDispatch.SETRANGE(KeyDispatch."No.",Rec."No.");
                    // if KeyDispatch.FINDSET then
                    // begin
                    //     if Rec."Key Status" = Rec."Key Status"::Returned then
                    // begin
                    //     KeyDispatch."Key Status" := KeyDispatch."Key Status"::Returned;
                    //     KeyDispatch.MODIFY;
                    // end;
                    // end; 
   
                end;
            }
            action("Dispatch Key")
            {
                ApplicationArea = All;
                Caption = 'Dispatch Key';
                Promoted = true;
                PromotedCategory = Process;
                Image = Dispatch;
                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField("Key Status" , Rec."Key Status"::Open);

                    // Rec.Testfield(Rec."User ID");
                    // UserSetup.Get(Rec."User ID");
                    // if UserSetup."User ID" = Rec."Created By" then
                    // Error('You cannot dispatch a key you requested')
                    // else
                    
                    Rec."Date of Issue" := CURRENTDATETIME;
                    Rec.Dispatched := True;
                    Rec."Key Status" := Rec."Key Status"::Dispatched;
                    Rec.MODIFY;
                    MESSAGE('Key Dispatched');
                    
                    // KeyDispatch.RESET;
                    // KeyDispatch.SETRANGE(KeyDispatch."No.",Rec."No.");
                    // if KeyDispatch.FINDSET then
                    // begin
                    //     if Rec."Key Status" = Rec."Key Status"::Dispatched then
                    // begin
                    //     KeyDispatch."Key Status" := KeyDispatch."Key Status"::Dispatched;
                    //     KeyDispatch.MODIFY;
                    // end;
                    // end; 
                end;
            }
            action("Receive Key Back")
            {
                ApplicationArea = All;
                Caption = 'Receive Key Back';
                Promoted = true;
                PromotedCategory = Process;
                Image = ReceiveBack;
                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField("Key Status" , Rec."Key Status"::Returned);
                    // Rec.Testfield(Rec."User ID");
                    // UserSetup.Get(Rec."User ID");
                    // if UserSetup."User ID" = Rec."Created By" then
                    // Error('You cannot receive a key you requested')
                    // else

                    Rec."Date Closed" := CURRENTDATETIME;
                    Rec.Closed := True;
                    Rec."Key Status" := Rec."Key Status"::Closed;
                    Rec.MODIFY;
                    MESSAGE('Key Received Back');
                    
                    // KeyDispatch.RESET;
                    // KeyDispatch.SETRANGE(KeyDispatch."No.",Rec."No.");
                    // if KeyDispatch.FINDSET then
                    // begin
                    //     if Rec."Key Status" = Rec."Key Status"::Received then
                    // begin
                    //     KeyDispatch."Key Status" := KeyDispatch."Key Status"::Received;
                    //     KeyDispatch.MODIFY;
                    // end;
                    // end; 
                end;
            }
        }  
    }

    Var
        UserSetup: Record "User Setup";
        PageEdit: Boolean;
        VarVariant: Variant;
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        //KeyDispatch : Record "Office Keys";
}
