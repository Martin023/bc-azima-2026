namespace ALProject.ALProject;
using Microsoft.Inventory.Item;
using System.Automation;
using System.Security.User;

page 52186901 "Stock Keeping Header"
{
    ApplicationArea = All;
    Caption = 'Stock Keeping Header';
    PageType = Card;
    PromotedActionCategories=',,,,,Generate Items,,,Approvals';
     SourceTableView = where(Types = filter(Stock));
    SourceTable = "stock Keeping";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';


                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(TotalItems; Rec.TotalItems)
                {
                    ToolTip = 'Specifies the value of the Total Items field.';
                }
                field("User Id"; Rec."User Id")
                {
                    ToolTip = 'Specifies the value of the User Id field.';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {

                }

            }
            part(Control3; "Stock Keeping Lines")
            {
                ApplicationArea = Basic;
                SubPageLink = "Header No" = FIELD("No");
                
            }
        }

    }
    actions
    {
        area(navigation)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }

                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    //  // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin




                        VarVariant := Rec;




                        // Rec.Status := Rec.Status::Approved;
                        // Rec.MODIFY;

                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        //MESSAGE('Job Approved and now can be occupied')
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        Rec.TestField(Status, Rec.Status::Pending);
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnCancelDocApprovalRequest(VarVariant);

                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = all;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        Rec.TestField(Status, Rec.Status::Pending);


                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
            }
            action(GenerateItems)
            {
                ApplicationArea = all;
                Caption = 'Generate Item';
                Image = Item;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                trigger OnAction()
                var

                begin
                    rec.TestField(Status, rec.status::Open);
                    StockLines.SetRange(StockLines."Header No", Rec."No");
                    if StockLines.Find('-') then
                        StockLines.DeleteAll;


                    Item.Reset;
                    //Item.SetRange("No.", StockLines."Item No");
                    IF Item.FindFirst THEN begin
                        StockLines.Reset;
                        repeat
                            StockLines.Init;
                            StockLines."Header No" := REC.No;
                            StockLines."Item No" := Item."No.";
                            StockLines."Item Name" := Item.Description;
                            Item.CalcFields(Inventory);
                            StockLines.Inventory := Item.Inventory;
                            StockLines.Insert();
                        until Item.Next = 0;
                    end;

                end;


            }
        }
    }
     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rec.Types:=rec.Types::Stock;
    end;
    var
        HREmployees: Record "HR Employees";
        // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        HRCodeunit: Codeunit "HR Codeunit2";

        PageEditable: Boolean;
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        DocMustbePending: Label 'This application request must be Pending';
        DMS: Record EDMS;
        usersetup: record "User Setup";
        Item: record Item;
        StockLines: record "Stock Keeping Lines";
        StockKeeping: record "Stock Keeping";





}
