page 52187342 "Rejected Vehicles Card"
{
    ApplicationArea = All;
    Caption = 'Rejected Vehicles';
    PageType = Card;
    SourceTable = "Company Vehicles";
    UsageCategory = Lists;
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    SourceTableView = where(Status = const(Rejected));
    PromotedActionCategories = 'New,Process,Reports,Approvals,Views,Home,Creation';
    
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = PageEdit;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field("Asset No."; Rec."Asset No.")
                {
                    ToolTip = 'Specifies the value of the Asset No. field.';
                }
                field("Type of Vehicle"; Rec."Type of Vehicle")
                {
                }
                field("Registration No."; Rec."Registration No.")
                {
                    ToolTip = 'Specifies the value of the Registration No. field.';
                }
                field("Vehicle Make"; Rec."Vehicle Make")
                {
                    ToolTip = 'Specifies the value of the Vehicle Make field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    Editable = false;
                }
                // field(Color; Rec.Color)
                // {
                //     ToolTip = 'Specifies the value of the Color field.';
                // }
                field("Engine No."; Rec."Engine No.")
                {
                    ToolTip = 'Specifies the value of the Engine No. field.';
                }
                field("Logbook No."; Rec."Logbook No.")
                {
                    ToolTip = 'Specifies the value of the Logbook No. field.';
                }
                field("Vehicle Frame Number"; Rec."Vehicle Frame Number")
                {
                    ToolTip = 'Specifies the value of the Vehicle Frame Number field.';
                }
                // field("Vehicle Type"; Rec."Vehicle Type")
                // {
                //     ToolTip = 'Specifies the value of the Vehicle Type field.';
                // }
                field("Year of Manufacture"; Rec."Year of Manufacture")
                {
                    ToolTip = 'Specifies the value of the Year of Manufacture field.';
                }
                field(Capacity; Rec.Capacity)
                {
                    ToolTip = 'Specifies the value of the Capacity field.';
                }
                field("Load Limit (Tonnes)"; Rec."Load Limit")
                {
                    Caption = 'Load Limit (Tonnes)';
                    ToolTip = 'Specifies the value of the Load Limit field.';
                }

                field("Vehicle Status"; Rec."Vehicle Status")
                {
                    ToolTip = 'Specifies the value of the Vehicle Status field.';
                    Editable = false;
                }
                field("Branch"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field("Department"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field("Created At"; Rec."Created at")

                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                    Editable = False;
                }
                field(Status;Rec.Status)
                {
                    Editable = false;
                }
            }
            group("Insurance Details")
            {
                Editable = PageEdit;
                field("Date of Last Insurance"; Rec."Date of last insurace")
                {
                    ToolTip = 'Specifies the value of the Date of last insurace field.';
                }
                field("Insurance Company"; Rec."Insurance Company")
                {
                    ToolTip = 'Specifies the value of the Insurance Company field.';
                }
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Specifies the value of the Company Name field.';
                }
                field("Insurance Expiry Date"; Rec."Insurance Expiry Date")
                {
                    ToolTip = 'Specifies the value of the Insurance Expiry Date field.';
                }
                field("Insurance Policy No."; Rec."Insurance Policy No.")
                {
                    ToolTip = 'Specifies the value of the Insurance Policy No. field.';
                }
            }
            group("Purchase Details")
            {
                Editable = PageEdit;
                field("Purchase Date"; Rec."Purchase Date")
                {
                    ToolTip = 'Specifies the value of the Purchase Date field.';
                    Editable = false;
                }
                field("Purchase Price"; Rec."Purchase Price")
                {
                    ToolTip = 'Specifies the value of the Purchase Price field.';
                    Editable = false;
                }
                field("Purchase Vendor/Company"; Rec."Purchase Vendor/Company")
                {
                    ToolTip = 'Specifies the value of the Purchase Vendor/Company field.';
                    Editable = false;
                }
                field("Vendor Contact Details"; Rec."Vendor Contact Details")
                {
                    ToolTip = 'Specifies the value of the Vendor Contact Details field.';

                }
            }
        }

    }

    actions
    {
        area(creation)
        {
            action("Activate Vehicle")
            {
                ApplicationArea = All;
                Caption = 'Activate Vehicle';
                Image = ActivateVehicle;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.TestField("Vehicle Status", Rec."Vehicle Status"::Inactive);
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField("Asset No.");
                    Rec.TestField("Type of Vehicle");
                    Rec.TestField("Registration No.");
                    Rec.TestField("Created By");


                    if Rec."Vehicle Status" = Rec."Vehicle Status"::Inactive then begin
                        Rec."Vehicle Status" := Rec."Vehicle Status"::Active;
                        Rec.Modify;
                        Message('Vehicle Activated');
                    end;
                end;
            }
            action("Deactivate Vehicle")
            {
                ApplicationArea = All;
                Caption = 'Dectivate Vehicle';
                Image = DeactivateVehicle;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.TestField("Vehicle Status", Rec."Vehicle Status"::Active);
                    if Rec."Vehicle Status" = Rec."Vehicle Status"::Active then begin
                        Rec."Vehicle Status" := Rec."Vehicle Status"::Inactive;
                        Rec.Modify;
                        Message('Vehicle Deactivated');
                    end;
                end;
            }
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
                    Rec.TestField("Asset No.");
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

                    if Rec.Status <> Rec.Status::"Pending Approval" then
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

            
            action(Close)
            {
                ApplicationArea = All;
                Caption = 'Close Vehicle';
                Image = Close;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                begin
                    Rec.TestField("Vehicle Status", Rec."Vehicle Status"::Inactive);
                    if Rec."Vehicle Status" = Rec."Vehicle Status"::Inactive then begin
                    
                        Rec."Status" := Rec."Status"::Closed;
                        Rec.Modify;
                        Message('Vehicle Closed');
                    end;
                end;
            }
            action(Servicing)
            {
                ApplicationArea = All;
                Caption = 'Repair';
                //Image = Servicing;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "Motor Vehicle Repair";
                RunPageLink = "Car Registration No." = field ("No.");
            }
            action(Repair)
            {
                ApplicationArea = All;
                Caption = 'Servicing';
                //Image = Servicing;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "Vehicle Servicing List Page";
                RunPageLink = "Record ID" = field ("No.");
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
            Rec.SystemCreatedAt := CURRENTDATETIME;
            Rec.Modify;
        end;
    end;

    trigger OnAfterGetRecord();
    begin
        if Rec."Vehicle Status" = Rec."Vehicle Status"::Active then
            PageEdit := false else
            PageEdit := true;
    end;

    Var
        UserSetup: Record "User Setup";
        PageEdit: Boolean;
        VarVariant: Variant;
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
}

