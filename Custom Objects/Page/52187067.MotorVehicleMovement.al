page 52187067 "Motor Vehicle Movement"
{
    ApplicationArea = All;
    Caption = 'Motor Vehicle Movement';
    PageType = Card;
    SourceTable = "Vehicle Movement";
    DeleteAllowed = true;
    PromotedActionCategories = 'New,Process,Reports,Cancellation,Approvals,Approval request,Defer Approval,Reject Approval,Reopen Application, Closure';

    //SourceTableView = SORTING("No.")
    //ORDER(Ascending)
    //WHERE(Status = CONST(Open));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                //Editable = CurrPageEditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Movement No. field.';
                    Editable = false;
                }
                field("Driver No."; Rec."Driver No.")
                {
                    ToolTip = 'Specifies the value of the Driver Staff No. field.';
                    ApplicationArea = Basic, Suite;
                }
                field("Driver Staff No."; Rec."Driver Staff No.")
                {
                    Caption = 'Driver PF No.';
                    ToolTip = 'Specifies the value of the Driver Staff No. field.';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
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
                field("Vehicle"; Rec."Allocated Vehicle")
                {
                }
                field("Registration No."; Rec."Registration No.")
                {
                    Caption = 'Registration No.';
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Caption = 'Branch';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Activity';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
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
                    // trigger OnValidate()
                    // var
                    //     myInt: Integer;
                    // begin
                    //     if Rec.Status = Rec.Status::Approved then begin
                    //         AssignDriversAndVehiclesToMovement(Rec);
                    //     end;
                    // end;
                }
                field("Movement Status"; Rec."Movement Status")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            Group("Travel Details")
            {
                Caption = 'Travel Details';
                //Editable = CurrPageEditable;
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
                Field("Departure Date"; Rec."Departure Date")
                {
                    ToolTip = 'Specifies the value of the Departure Date field.';

                    ApplicationArea = Basic, Suite;
                }
                Field("Departure Time"; Rec."Departure Time")
                {
                    ToolTip = 'Specifies the value of the Departure Time field.';

                    ApplicationArea = Basic, Suite;
                }
                field("Destination Arrival Time"; Rec."Arrival Time")
                {
                    ToolTip = 'Specifies the value of the Arrival Time field.';

                    ApplicationArea = Basic, Suite;
                }
                field("Outward Distance(KM)"; Rec."Outward Distance")
                {
                    Caption = 'Outward Distance(KM)';
                    ToolTip = 'Specifies the value in Kilometeres of the Outward Distance ';
                    ApplicationArea = Basic, Suite;
                }
                field("Return Distance(KM)"; Rec."Return Distance")
                {
                    Caption = 'Return Distance(KM)';
                    ToolTip = 'Specifies the value in Kilometeres of the Return Distance ';
                    ApplicationArea = Basic, Suite;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ToolTip = 'Specifies the value of the Return Date field.';
                    ApplicationArea = Basic, Suite;
                }
                field(Mileage; Rec.Mileage)
                {
                    Caption = 'Mileage';
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

            action("Send For Approval")
            {
                Caption = 'Send For Approval';
                ApplicationArea = all;
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category5;
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
                    Rec.TestField("Registration No.");
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
                    Rec.TestField("Global Dimension 1 Code");
                    Rec.TestField("Global Dimension 2 Code");

                    //ApprovalsMgmt.Run();
                    UserSetup.Reset;
                    UserSetup.SetRange("User ID", UserId);
                    if UserSetup.FindFirst then begin
                        UserSetup.TestField("Global Dimension 1 Code");
                        UserSetup.TestField("Global Dimension 2 Code");
                        UserSetup.TestField("Responsibility Centre");

                        VechicleM.Reset;
                        VechicleM.SetRange("No.", Rec."No.");
                        if VechicleM.Find('-') then begin
                            Rec."Created By" := UserId;
                            Rec."Created At" := Today;
                            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;

                        VechicleM.SetRange("No.", Rec."No.");
                        if VechicleM.Find('-') then begin
                            Rec."Created At" := Today;
                            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                        Message('Movement Details Saved Successfully');
                    end;

                    // if  OfficersTravelling.Find('-') then
                    // OfficersTravelling.TestField("No.");
                    // OfficersTravelling.TestField("Officer's Name");
                    // OfficersTravelling.TestField("Staff Number");
                    // OfficersTravelling.TestField("Department");

                    // Found := true;
                    // if Found = false then
                    //     Error(SecErr);

                    VarVariant := Rec;

                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category5;

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
            action("Reopen Document")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category5;
                Image = ReOpen;

                trigger OnAction()
                begin

                    if not Confirm('Are you sure you want to re-open this document?') then exit;
                    Rec.Status := Rec.Status::Open;
                    Rec."Movement Status" := Rec."Movement Status"::New;
                    Rec.Modify;
                    Message('Document Reopened Sucessfully.');
                end;
            }
            action("CLose Movement")
            {
                ApplicationArea = All;
                Caption = 'Close Movement';
                Image = Close;
                Promoted = true;
                PromotedCategory = Category10;
                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField("Movement Status", Rec."Movement Status"::"In-Progress");
                    if confirm('Do you want to close this Movement?') then begin
                        if Drivers.get(rec."Driver No.") then begin
                            if Drivers."Driver Availability" = Drivers."Driver Availability"::Unavailable
                            then begin
                                Drivers."Driver Availability" := Drivers."Driver Availability"::Available;
                                Drivers.Modify;
                                Message('Driver Availability Updated');
                            end;
                        end;

                        if CompanyVehicles.get(rec."Allocated Vehicle") then begin
                            if CompanyVehicles."Movement Status" = CompanyVehicles."Movement Status"::"In Transit"
                            then begin
                                CompanyVehicles."Movement Status" := CompanyVehicles."Movement Status"::Stationary;
                                CompanyVehicles.Modify;
                                Message('Vehicle Movement Closed!');
                            end;
                        end;
                        Rec."Movement Status" := Rec."Movement Status"::"Closed";
                        Rec.Modify();
                        Message('Vehicle Movement Closed!');
                    end;
                end;
            }
        }
    }

    var
        VarVariant: Variant;
        UserSetup: Record "User Setup";

    // trigger OnOpenPage()
    // begin
    //     if UserSetup.Get('-') then begin
    //         Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
    //         Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
    //         Rec."Responsibility Center" := UserSetup."Responsibility Centre";
    //         Rec."Created By" := UserId;
    //         Rec.Modify;
    //     end;
    // end;

    trigger OnOpenPage()
    begin
        //PageControl();
        if Rec.Status = Rec.Status::Approved then
            CurrPage.editable := false;
    end;

    // trigger OnAfterGetRecord()
    // begin
    //     if Rec.Status = Rec.Status::Open then begin
    //         CurrPage.Editable := true;
    //     end 
    //     //else
    //     //     CurrPage.Editable := true;
    // end;


    Var
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        Drivers: Record "HR Drivers";
        CompanyVehicles: Record "Company Vehicles";
        VehMov: Record "Vehicle Movement";
        CurrPageEditable: Boolean;

    // procedure AssignDriversAndVehiclesToMovement(VehMov: Record "Vehicle Movement")
    // begin
    //     if Confirm('Do you want to assign the selected driver and vehicle to the movement?') then begin
    //         Drivers.RESET;
    //         Drivers.SetRange(Drivers."No.", VehMov."Driver No.");
    //         //DRivers.SetRange("Staff Number", VehMov."Driver Staff No.");
    //         if Drivers.Find('-') then begin
    //             Drivers.Status := Drivers."Driver Availability"::Unavailable;
    //             Drivers.Modify;
    //             Message('Driver Assigned to Movement');
    //         end;

    //         CompanyVehicles.RESET;
    //         CompanyVehicles.SetRange(CompanyVehicles."No.", VehMov."Allocated Vehicle");
    //         if CompanyVehicles.Find('-') then begin
    //             CompanyVehicles."Movement Status" := CompanyVehicles."Movement Status"::"In Transit";
    //             CompanyVehicles.Modify;
    //             Message('Vehicle Assigned to Movement');
    //         end;
    //         Message('Movement Status Updated to In-Progress.');
    //     end
    // end;
}



