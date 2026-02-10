page 52187356 "Approved Vehicle Movt Card"
{
    ApplicationArea = All;
    Caption = 'Approved Vehicle Mov';
    PageType = Card;
    SourceTable = "Vehicle Movement";
    PromotedActionCategories = 'New,Process,Cancellation,Approval';
    SourceTableView = WHERE(Status = CONST(Approved));
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;

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
                    ToolTip = 'Specifies the value of the Movement No. field.';
                    Editable = false;
                }
                field("Driver Staff No."; Rec."Driver Staff No.")
                {
                    ToolTip = 'Specifies the value of the Driver Staff No. field.';
                    ApplicationArea = Basic, Suite;
                }
                field("Name of Driver"; Rec."Name of Driver")
                {
                    ToolTip = 'Specifies the value of the Name of Driver field.';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date of Travel"; Rec."Date of Travel")
                {
                    ToolTip = 'Specifies the value of the Date of Travel field.';
                    ApplicationArea = Basic, Suite;
                }
                field("Purposes of Travel"; Rec."Purpose of Travel")
                {
                    ToolTip = 'Specifies the value of the Purpose of Travel field';
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created At"; Rec."Created At")
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            Group("Travel Details")
            {
                Caption = 'Travel Details';
                field(From; Rec.From)
                {
                    ToolTip = 'Specifies the value of the From field.';

                    ApplicationArea = Basic, Suite;
                }
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the Destination field.';

                    ApplicationArea = Basic, Suite;
                }
                field("Destination Arrival Time"; Rec."Arrival Time")
                {
                    ToolTip = 'Specifies the value of the Arrival Time field.';

                    ApplicationArea = Basic, Suite;
                }
                field("Outward Distance in KM"; Rec."Outward Distance")
                {
                    ToolTip = 'Specifies the value in Kilometeres of the Outward Distance ';
                    ApplicationArea = Basic, Suite;
                }
                field("Return Distance-KM"; Rec."Return Distance")
                {
                    ToolTip = 'Specifies the value in Kilometeres of the Return Distance ';
                    ApplicationArea = Basic, Suite;
                }
                field("Return Departure Time"; Rec."Return Departure Time")
                {
                    ToolTip = 'Specifies the value of the Return Departure Time field';
                    ApplicationArea = Basic, Suite;
                }
                field("Return Arrival Time"; Rec."Return Arrival Time")
                {
                    ToolTip = 'Specifies the value of the Return Arrival Time field.';
                    ApplicationArea = Basic, Suite;
                }
                field("Total Distance in KM"; Rec."Total Distance")
                {
                    ToolTip = 'Specifies the value in Kilometeres of the Total Distance field.';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Officers Traveling")
            {
                ApplicationArea = all;
                Image = Relationship;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Travelling Officers";
                RunPageLink = "Record No." = FIELD("No.");
            }
            action("Send for Approval")
            {
                ApplicationArea = all;
                Image = Send;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    OfficersTravelling: Record "Travelling Officers";
                    Found: Boolean;
                    SecErr: Label 'You have not provided the list of Officers Traveling';
                    UserSetup: Record "User Setup";
                    VechicleM: Record "Vehicle Movement";

                begin
                    Rec.TestField("No.");
                    Rec.TestField("Driver Staff No.");
                    Rec.TestField("Name of Driver");
                    Rec.TestField("Driver Staff No.");
                    Rec.TestField("Purpose of Travel");
                    Rec.TestField("Date of Travel");
                    Rec.TestField("Purpose of Travel");
                    Rec.TestField("From");
                    Rec.TestField("Destination");
                    Rec.TestField("Arrival Time");
                    Rec.TestField("Outward Distance");
                    Rec.TestField("Return Distance");
                    Rec.TestField("Return Departure Time");
                    Rec.TestField("Return Arrival Time");
                    Rec.TestField("Total Distance");
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.TestField("Created By");
                    // Rec.TestField("Global Dimension 1 Code");
                    // Rec.TestField("Global Dimension 2 Code");

                    ApprovalsMgmt.Run();
                    UserSetup.Reset;
                    UserSetup.SetRange("User ID", UserId);
                    if UserSetup.FindFirst then begin
                        // UserSetup.TestField("Global Dimension 1 Code");
                        // UserSetup.TestField("Global Dimension 2 Code");
                        // UserSetup.TestField("Responsibility Centre");

                        VechicleM.Reset;
                        VechicleM.SetRange("No.", Rec."No.");
                        if VechicleM.Find('-') then begin
                            Rec."Created By" := UserId;
                            Rec."Created At" := Today;
                            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
                            Rec.Status := Rec.Status::Approved;
                            Rec.Modify;
                        end;
                            
                            // VechicleM.SetRange("No.", Rec."No.");
                            // if VechicleM.Find('-') then begin
                            //     Rec."Created At" := Today;
                            //     Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                            //     Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                            //     Rec."Responsibility Center" := UserSetup."Responsibility Centre";
                            //     Rec.Status := Rec.Status::Application;
                            //     Rec.Modify;
                            // end;
                       end;

                    // if  OfficersTravelling.Find('-') then
                    // OfficersTravelling.TestField("No.");
                    // OfficersTravelling.TestField("Officer's Name");
                    // OfficersTravelling.TestField("Staff Number");
                    // OfficersTravelling.TestField("Department");

                    // Found := true;
                    // if Found = false then
                    // Error(SecErr);

                    VarVariant := Rec;

                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action("Defer Movement Request")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                Image = Defer;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    if (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Pending) then begin
                        if Confirm('Are you sure you want to defer the Vehicle Movement Request?', false) = true then begin
                            Rec.Status := Rec.Status::Deffered;
                            Rec.Modify;
                        end;
                    end;
                end;
            }

            action("Re-Open Deferred Movement Request")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                Image = Reopen;
                PromotedCategory = Category4;
                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Deffered);
                    if (Rec.Status = Rec.Status::Deffered) or (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Pending) then begin
                        if Confirm('Are you sure you want to re-open the Vehicle Movement Request?', false) = true then begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                    end;
                end;
            }
            action("Reject Movement Request")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    if (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Pending) then begin
                        if Confirm('Are you sure you want to cancel the Vehicle Movement Request?', false) = true then begin
                            Rec.Status := Rec.Status::Rejected;
                            Rec.Modify;
                        end;
                    end;
                end;
            }
        }
    }
    var
        VarVariant: Variant;
        UserSetup: Record "User Setup";

    trigger OnOpenPage()
    begin
        if UserSetup.Get('-') then begin
            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
            Rec."Created By" := UserId;
            Rec.Modify;
        end;
    end;
}


