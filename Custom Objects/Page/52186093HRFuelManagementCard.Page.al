page 52186093 "HR Fuel Management Card"
{
    SourceTable = "HR Fuel Management Header";
    PageType = Card;
    ApplicationArea = Basic;
    Caption = 'Fuel Management';
    PromotedActionCategories = 'New,Process,Reports,Approvals,Views,Home,Creation';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = Basic;
                }
                field("Vehicle Registration No."; Rec."Vehicle Registration No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Name Vehicle"; Rec."Name Vehicle")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Vehicle Type"; Rec."Type of Vehicle")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Driver Details"; Rec."Driver Staff No.")
                {
                    Caption = 'Driver No';
                    ApplicationArea = Basic;
                }
                field("Driver Staff No."; Rec."Driver No.")
                {
                    caption = 'Driver Staff No';
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Branch Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Branch field.';
                    Editable = false;
                    Caption = 'Branch Code';
                }
                field("Activity Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Department field.';
                    Editable = FALSE;
                    Caption = 'Activity Code';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = FALSE;
                }
                field("Created by"; Rec."Created by")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created On"; Rec."Created at")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Fuel Details")
            {
                field("Mode of Payment"; Rec."Type Of Payment")
                {
                    Caption = 'Type of Payment';
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        if Rec."Type Of Payment" = Rec."Type Of Payment"::Cash then begin
                            VisibleCash := true;
                            VisibleCard := false
                        end;
                        if Rec."Type Of Payment" = Rec."Type Of Payment"::Card then begin
                            VisibleCard := true;
                            VisibleCash := false
                        end;
                        if Rec."Type Of Payment" = Rec."Type Of Payment"::"Direct Fueling" then begin
                            VisibleCard := false;
                            VisibleCash := false;
                        end;
                        if Rec."Type Of Payment" = Rec."Type of Payment"::" " then begin
                            VisibleCard := false;
                            VisibleCash := false;
                        end
                    end;
                }
                field("Fuel Type"; Rec."Fuel Type")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Fueling"; Rec."Date of Fueling")
                {
                    ApplicationArea = Basic;
                }
                field("Fuel Balance"; Rec."Fuel Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fuel Card Balance';
                }
                field("Quantity of the Fuel"; Rec."Quantity")
                {
                    Caption = 'Quantity Fueled (Litres)';
                    ApplicationArea = Basic;
                }
                field("Cost of the Fuel"; Rec."Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Vehicle Fuel Ceiling"; Rec."Motor Vehicle Fuel Ceiling")
                {
                    ApplicationArea = Basic;
                }
                // Field("Petrol Station No."; Rec."Petrol Station Vendor No")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Petrol Station"; Rec."Petrol Station Name")
                {
                    ApplicationArea = Basic;
                }
                field("Fuel Card No."; Rec."Card No")
                {
                    ApplicationArea = Basic;
                    Editable = VisibleCard;
                }
                field("Cash Paid"; Rec."Cash Paid")
                {
                    ApplicationArea = Basic;
                    Editable = VisibleCash;
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
                    Rec.TestField("Vehicle No.");
                    Rec.TestField("Vehicle Registration No.");
                    Rec.TestField("Motor Vehicle Fuel Ceiling");
                    Rec.TestField("Driver Staff No.");

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
        }
    }
    trigger OnOpenPage();
    begin
        PageControl();
        if UserSetup.Get(Rec."Created By") then begin
            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
            Rec."Created By" := UserId;
            Rec.SystemCreatedAt := CURRENTDATETIME;
            Rec.Modify;
        end;
        if Rec.Status = Rec.Status::Approved then begin
            CurrPage.Editable := False;
        end;
        //VisibleCard := False;
        //VisibleCash := False;
    end;

    // trigger OnAfterGetRecord();
    // begin
    //     if Rec.Status = Rec.Status::Approved then begin
    //         CurrPage.Editable := False;
    //     end 
    //     // else
    //     //     CurrPage.Editable := false;
    // end;

    local procedure PageControl()
    begin
        VisibleCard := false;
        VisibleCash := false;

        if Rec."Type of Payment" = Rec."Type of Payment"::Cash then begin
            VisibleCash := true;
            VisibleCard := false;
        end;
        if Rec."Type of Payment" = Rec."Type of Payment"::Card then begin
            VisibleCash := false;
            VisibleCard := true;
        end;
        if Rec."Type of Payment" = Rec."Type of Payment"::" " then begin
            VisibleCash := false;
            VisibleCard := false;
        end;
    end;


    Var
        VisibleCash: Boolean;
        VisibleCard: Boolean;
        UserSetup: Record "User Setup";
        //PageEdit: Boolean;
        VarVariant: Variant;
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        //CurrPageEditable: Boolean;
}

