page 52185443 "Sky Mobile Loans"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Mobile loan App. Buffer";
    ApplicationArea = Basic;
    UsageCategory = Lists;
    SourceTableView = sorting("Entry No") Order(descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Session ID"; Rec."Session ID")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                // field("Account No"; Rec."Account No")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                // field(Date; Rec.Date)
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Requested Amount"; Rec."Requested Amount")
                // {
                //     ApplicationArea = Basic;
                // }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                // field(Blocked; Rec.Blocked)
                // {
                //     ApplicationArea = Basic;
                // }
                // field(Remarks; Rec.Remarks)
                // {
                //     ApplicationArea = Basic;
                // }
                // field(DocumentNo; Rec.DocumentNo)
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Expected Guarantors"; Rec."Expected Guarantors")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                // field("Loan Purpose"; Rec."Loan Purpose")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Loan Period"; Rec."Loan Period")
                // {
                //     ApplicationArea = Basic;
                // }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                }
                // field("Telephone No"; Rec."Telephone No")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Message Text"; Rec."Message Text")
                // {
                //     ApplicationArea = Basic;
                // }
                field(Deactivated; Rec.Deactivated)
                {
                    ApplicationArea = Basic;
                }
                // field("Deactivated By"; Rec."Deactivated By")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Date Deactivated"; Rec."Date Deactivated")
                // {
                //     ApplicationArea = Basic;
                // }
                // field(Branch; Rec.Branch)
                // {
                //     ApplicationArea = Basic;
                // }
            }
        }
    }

    // actions
    // {
    //     area(processing)
    //     {
    //         action("Activate/Deactivate Application")
    //         {
    //             ApplicationArea = Basic;

    //             trigger OnAction()
    //             begin

    //                 Rec.TestField(Posted, false);
    //                 if Rec.Deactivated then begin
    //                     if Confirm('Are you sure you want to deactivate this application') then begin
    //                         Rec.Deactivated := false;
    //                         Rec."Deactivated By" := UserId;
    //                         Rec."Date Deactivated" := Today;
    //                         Rec.Modify;
    //                     end;
    //                 end
    //                 else begin
    //                     if Confirm('Are you sure you want to activate this application') then begin
    //                         Rec.Deactivated := true;
    //                         Rec."Deactivated By" := UserId;
    //                         Rec."Date Deactivated" := Today;
    //                         Rec.Modify;
    //                     end;
    //                 end;
    //             end;
    //         }
    //         action("Unblock Mobile loan")
    //         {
    //             ApplicationArea = Basic;

    //             trigger OnAction()
    //             begin
    //                 if Confirm('Are you sure you want unflag this account') then begin
    //                     Rec.Blocked := false;
    //                     Rec.Modify;
    //                 end;
    //             end;
    //         }
    //         // action("Loan Guarantors")
    //         // {
    //         //     ApplicationArea = Basic;
    //         //     Image = ElectronicDoc;
    //         //     Promoted = true;
    //         //     PromotedIsBig = true;
    //         //     RunObject = Page "Mobile Loan Guarantors";
    //         //     RunPageLink = "Loan Entry No." = FIELD("Entry No");
    //         // }
    //         action("Return To Appraisal")
    //         {
    //             ApplicationArea = Basic;
    //             Image = Return;
    //             Promoted = true;
    //             PromotedIsBig = true;

    //             trigger OnAction()
    //             var
    //                 SkyPermissions: Record "Sky Permissions";
    //             begin
    //                 SkyPermissions.Reset;
    //                 SkyPermissions.SetRange("User ID", UserId);
    //                 SkyPermissions.SetRange("Return Loans to Appraisal", true);
    //                 if not SkyPermissions.FindFirst then
    //                     Error('You do not have permission to perform this action!');

    //                 Rec.TestField(Status, Rec.Status::Failed);
    //                 Rec.TestField(Posted, false);
    //                 if (Rec."Loan Product Type" = '111') or
    //                     (Rec."Loan Product Type" = '112') or
    //                     (Rec."Loan Product Type" = '113') or
    //                     (Rec."Loan Product Type" = '115') or
    //                     (Rec."Loan Product Type" = '140') or
    //                     (Rec."Loan Product Type" = '124') or
    //                     (Rec."Loan Product Type" = '143')

    //                 then begin
    //                     if Confirm('Are you sure you want to return this loan to appraissal?') then begin
    //                         Rec.Status := Rec.Status::Appraisal;
    //                         Rec.Modify;
    //                         Message('Update Complete');
    //                     end else
    //                         Message('Operation Aborted!');
    //                 end else
    //                     Error('You cannot edit this loan type');
    //             end;
    //         }
    //     }
    // }
}

