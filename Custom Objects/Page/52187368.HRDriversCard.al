page 52187368 "HR Drivers Card"
{
    ApplicationArea = All;
    Caption = 'Drivers Card';
    PageType = Card;
    SourceTable = "HR Drivers";
    //DeleteAllowed = True;
    Editable = true;
    PromotedActionCategories = 'New,Process,Reports,Approvals';


    layout
    {
        area(content)
        {
            group(General)
            {

                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }

                field("Employee Number"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.';
                    Editable = false;
                }
                field("Driver Phone No."; Rec."Driver Phone No.")
                {
                }
                field("Driver License Number"; Rec."Driver License Number")
                {
                    ToolTip = 'Specifies the value of the Driver License Number field.';

                }
                field("Year Of Experience"; Rec."Year Of Experience")
                {
                    ToolTip = 'Specifies the value of the Year Of Experience field.';
                }
                field(Class; Rec.Class)
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                    Caption = 'Driver Class/Road Transport Services';
                }
                field("Last License Renewal"; Rec."Last License Renewal")
                {
                    ToolTip = 'Specifies the value of the Last License Renewal field.';
                }
                field("Next License Renewal"; Rec."Next License Renewal")
                {
                    ToolTip = 'Specifies the value of the Next License Renewal field.';
                }
                field("Renewal Interval"; Rec."Renewal Interval")
                {
                    ToolTip = 'Specifies the value of the Renewal Interval field.';
                }
                // field("Renewal Interval Value"; Rec."Renewal Interval Value")
                // {
                //     ToolTip = 'Specifies the value of the Renewal Interval Value field.';
                // }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.';
                    Editable = false;
                }
                field("Driver Availability"; Rec."Driver Availability")
                {
                    ToolTip = 'Specifies the value of the Driver Availability field.';
                }
                // field("No of Trips"; Rec."No of Trips")
                // {
                //     ToolTip = 'Specifies the value of the No of Trips field.';
                // }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
                // field(Created; Rec.Created)
                // {
                //     Editable = false;
                // }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                    Editable = false;
                }
                field("Creation at"; Rec."Created at")
                {
                    ToolTip = 'Specifies the value of the Creation Date field.';
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
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
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action("Create Driver")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create Driver';
                //Image = CreateDriver;
                Promoted = true;
                PromotedCategory = New;

                trigger OnAction()

                var
                    Text002: Label 'Are you sure you want to Create this Driver?';
                begin
                    Rec.TestField(Status, Rec.Status::Approved);

                    if not Confirm(Text002) = true then exit;

                    // Rec.Created := Rec.Created;
                    Rec.Active := True;
                    Rec.Modify();
                end;
            }
        }
    }
    // trigger OnAfterGetRecord()
    // var
    //     myInt: Integer;
    // begin
    //         if Rec.Status = Rec.Status::Open then begin
    //         CurrPageEditable := true;
    //     end else
    //         CurrPageEditable := false;

    // end;
    trigger OnOpenPage()
    begin
        //PageControl();
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
        InsertAllowed: Boolean;
}
