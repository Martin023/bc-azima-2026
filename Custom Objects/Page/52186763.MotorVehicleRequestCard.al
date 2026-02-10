page 52186763 "Motor Vehicle Request Card"
{
    ApplicationArea = All;
    Caption = 'Motor Vehicle Request Card';
    PageType = Card;
    SourceTable = "Motor Vehicle Request";
    PromotedActionCategories = 'New,Home,Reports,Cancellation,Approval,Process';
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = PageEditable;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                // field("Date of Request"; Rec."Date of Request")
                // {
                //     ToolTip = 'Specifies the value of the Date of Request field.';
                // }
                field("Date of Travel"; Rec."Date of Travel")
                {
                    Caption = 'Date of Motor Vehicle Use';
                    ToolTip = 'Specifies the value of the Date of Travel field.';
                }
                field("Date of Return"; Rec."Return Date")
                {
                    ToolTip = 'Specifies the value of the Date of Return field.';
                }
                field("Type of Travel"; Rec."Type of Travel")
                {
                    ToolTip = 'Specifies the value of the Type of Travel field.';
                    trigger OnValidate()

                    begin
                        if Rec."Type of Travel" = Rec."Type of Travel"::Department then begin
                            VisibleDepartment := true;
                            VisibleIndividual := false;
                            VisibleOther := false;
                        end
                        else
                            if Rec."Type of Travel" = Rec."Type of Travel"::Individual then begin
                                VisibleDepartment := false;
                                VisibleIndividual := true;
                                VisibleOther := false;
                            end
                            else
                                if Rec."Type of Travel" = Rec."Type of Travel"::Other then begin
                                    VisibleDepartment := false;
                                    VisibleIndividual := false;
                                    VisibleOther := true;
                                end;
                    end;
                }
                field("Vehicle Purpose"; Rec."Vehicle Purpose")
                {
                    ToolTip = 'Specifies the value of the Vehicle Purpose field.';
                }
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the Destination field.';
                }
                field("No. of Passengers"; Rec."No. of Staff Traveling")
                {
                    ToolTip = 'Specifies the value of the No of Passengers field.';
                    Caption = 'No. of Passengers Travelling';

                }
                field("Resposibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Resposibility Center field.';
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
                field("Status"; Rec."Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
                // field("Driver Status"; Rec."Driver Status")
                // {
                //     ToolTip = 'Specifies the value of the Driver Status field.';
                //     Editable = false;
                // }
                // field("Vehicle Status"; Rec."Vehicle Status")
                // {
                //     ToolTip = 'Specifies the value of the Vehicle Status field.';
                //     Editable = false;
                // }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created Date field.';
                    Editable = false;
                }
                field("Deffer Comments"; Rec."Deffer Comments")
                {
                    Caption = 'Deffer Comments';
                    Visible = false;
                }
            }
            group("Driver and Vehicle Details")
            {
                //Visible = ReallocationVisible;
                Visible = AllocationVisible;
                field("Driver No."; Rec."Allocated Driver")
                {
                    Caption = 'Driver No.';
                }
                field("Driver Staff No"; Rec."Driver Staff No.")
                {
                    Caption = 'Driver Staff No.';
                    Editable = false;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    Editable = false;
                }
                field("Vehicle"; Rec."Allocated Vehicle")
                {
                }
                field("Registration No."; Rec."Registration No.")
                {
                    Caption = 'Registration No.';
                    Editable = false;
                }
            }

            group("Staff Details")
            {
                visible = VisibleIndividual;
                Caption = 'Request Details';
                Editable = PageEditable;
                field("Staff No."; Rec."Staff No.")
                {
                    ToolTip = 'Specifies the value of the Staff No. field.';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }
                field("Staff Department Name"; Rec."Department Name")
                {
                    Caption = 'Staff Department';
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
            }
            group("Department Details")
            {
                visible = VisibleDepartment;
                Caption = 'Department Details';
                Editable = PageEditable;
                field("Department Name"; Rec."Department Name")
                {
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
            }
            group("Others")
            {
                visible = VisibleOther;
                Caption = 'Other Details';
                Editable = PageEditable;
                field("Other"; Rec."Other Travel Type")
                {
                    ToolTip = 'Specifies the value of the Other Details field.';
                }
            }
            group("Reallocation")
            {
                Visible = ReallocationVisible;
                field("New Vehicle"; Rec."New Vehicle")
                {
                    Caption = 'New Vehicle';
                }
                field("New Registration No."; Rec."New Registration No.")
                {
                    Caption = 'Registration No.';
                    Editable = false;
                }
                field("New Driver No."; Rec."New Allocated Driver")
                {
                    Caption = 'New Driver No.';
                }
                field("New Driver Staff No"; Rec."New Driver Staff No.")
                {
                    Caption = 'New Driver Staff No.';
                    Editable = false;
                }
                field("New Driver Name"; Rec."New Driver Name")
                {
                    Editable = false;
                }
                field("Reallocation Reason"; Rec."New Reallocation Reason")
                {
                }
                field("Reallocated"; Rec."Reallocated")
                {
                    MultiLine = true;
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
                PromotedCategory = Category5;

                trigger OnAction()

                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";

                begin
                    //Rec.TestField("Date of Request");
                    Rec.TestField("Date of Travel");
                    Rec.TestField("Type of Travel");
                    Rec.TestField("Vehicle Purpose");
                    Rec.TestField("Destination");
                    Rec.TestField("No. of Staff Traveling");
                    Rec.TestField("Responsibility Center");
                    // Rec.TestField("Allocated Vehicle");
                    Rec.TestField(Status, Rec.Status::Open);

                    // if Rec."Type of Travel" = Rec."Type of Travel"::Department then begin
                    //     Rec.TestField("Department Name");
                    // end
                    // else
                    //     if Rec."Type of Travel" = Rec."Type of Travel"::Individual then begin
                    //         Rec.TestField("Staff No.");
                    //         Rec.TestField("Staff Name");
                    //     end;

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
            action("Re-Open Document")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category5;
                Image = ReOpen;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Open then
                        Error('Document is already open');
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
            action("Request Vehicle")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.TestField("Date of Travel");
                    Rec.TestField("Type of Travel");
                    Rec.testfield("Vehicle Purpose");
                    Rec.TestField("Destination");
                    rec.TestField("No. of Staff Traveling");

                    if Confirm('Do you want to place a vehicle request?') then begin
                        Rec.Status := Rec.Status::"Requested Pending Allocation";
                        Rec.MODIFY;
                        Message('Vehicle Requested, pending allocation.');
                    end;
                end;
            }
            action("Deffer Request")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                begin
                    Rec.TestField("Deffer Comments");
                    if Confirm('Do you want to deffer this request?') then begin
                        GlobalFunctions.CommentsManagement(Rec."No.");
                        Rec."Status" := Rec.Status::Deffered;
                        Rec.MODIFY;
                        MESSAGE('Request Deffered');
                    end;
                end;
            }
            action("Document Comments")
            {
                ApplicationArea = Basic, Suite;
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Category4;

                RunObject = page "Comments List";
                RunPageLink = "Header No." = field("No.");
                RunPageView = where(Types = CONST(comment));
            }
            action("Reallocate Driver")
            {
                ApplicationArea = All;
                Caption = 'Reallocate Driver';
                Image = Action;
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.TestField("New Reallocation Reason");
                    if Rec."Status" = Rec."Status"::Closed then begin
                        Error('Vehicle Request is Closed')
                    end
                    else begin
                        Drivers.RESET;
                        Drivers.SetRange("No.", Rec."Allocated Driver");
                        if Drivers.Find('-') then begin
                            Drivers.Status := Drivers."Driver Availability"::Unavailable;
                            Drivers.Modify();
                        end;
                        Rec.Reallocated := true;
                        Rec.Modify;
                        Message('Driver Allocated');
                    end;
                end;
            }
            action(Reallocate)
            {
                ApplicationArea = All;
                Caption = 'Reallocate Vehicle';
                Image = Action;
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                begin
                    Rec.TestField("New Reallocation Reason");
                    if Rec."Status" = Rec."Status"::Closed then begin
                        Error('Vehicle Request is Closed')
                    end
                    else begin
                        CompanyVehicles.RESET;
                        CompanyVehicles.SetRange(CompanyVehicles."No.", Rec."Allocated Vehicle");
                        if CompanyVehicles.Find('-') then begin
                            CompanyVehicles."Movement Status" := CompanyVehicles."Movement Status"::"In Transit";
                            CompanyVehicles.Modify;
                        end;
                        Rec.Reallocated := true;
                        Rec.Modify;
                        Message('Vehicle Allocated');
                    end;
                end;
            }
            action(Close)
            {
                ApplicationArea = All;
                Caption = 'Close Request';
                Image = Close;
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Closed then
                        Error('Vehicle Request is already Closed')
                    else

                        if Rec."Status" = Rec."Status"::Approved then begin
                            Drivers.RESET;
                            Drivers.SetRange(Drivers."No.", Rec."Allocated Driver");
                            if Drivers.Find('-') then begin
                                if Drivers."Driver Availability" = Drivers."Driver Availability"::Unavailable then
                                    Drivers."Driver Availability" := Drivers."Driver Availability"::Available;
                                Drivers.Modify;
                                Message('Driver Available');
                            end;

                            CompanyVehicles.RESET;
                            CompanyVehicles.SetRange(CompanyVehicles."No.", rec."Allocated Vehicle");
                            if CompanyVehicles.Find('-') then begin
                                if CompanyVehicles."Movement Status" = CompanyVehicles."Movement Status"::"In Transit" then
                                    CompanyVehicles."Movement Status" := CompanyVehicles."Movement Status"::Stationary;
                                CompanyVehicles.Modify;
                            end;
                            Rec."Status" := Rec."Status"::Closed;
                            Rec."Return Date" := Today;
                            Rec.Modify;
                            Message('Vehicle Available');
                        end;
                    Message('Vehicle Request Closed');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        begin
            PageControl();
        end;
        if UserSetup.Get(Rec."Created By") then begin
            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
            Rec.Modify;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        PageEditable := true;
        if Rec.Status <> Rec.Status::Open then
            PageEditable := false;
        AssignmentDetails := True;
        //ReallocationVisible := false;

        if Rec.Status = Rec.Status::Approved then
            PageEditable := false;
        AssignmentDetails := True;
        //ReallocationVisible := true;

        if Rec.Status = Rec.Status::Pending then
            PageEditable := true;
        AssignmentDetails := True;
        //ReallocationVisible := true;
    end;
    // To Be Unedited


    local procedure PageControl()
    begin
        VisibleDepartment := false;
        VisibleIndividual := false;
        VisibleOther := false;

        if Rec."Type of Travel" = Rec."Type of Travel"::Department then begin
            VisibleDepartment := true;
            VisibleIndividual := false;
            VisibleOther := false;
        end;
        if Rec."Type of Travel" = Rec."Type of Travel"::Individual then begin
            VisibleDepartment := false;
            VisibleIndividual := true;
            VisibleOther := false;
        end;
        if Rec."Type of Travel" = Rec."Type of Travel"::" " then begin
            VisibleDepartment := false;
            VisibleIndividual := false;
            VisibleOther := true;
        end;
        if Rec."Type of Travel" = Rec."Type of Travel"::Other then begin
            VisibleDepartment := false;
            VisibleIndividual := false;
            VisibleOther := true;
        end;

        PageEditable := true;
        if Rec.Status <> Rec.Status::Open then
            PageEditable := false;


        ReallocationVisible := false;
        if Rec.Status = Rec.Status::Open then begin
            ReallocationVisible := false;
        end;
        if Rec.Status = Rec.Status::Pending then begin
            ReallocationVisible := true;
        end;
        if Rec.Status = Rec.Status::Approved then begin
            ReallocationVisible := true;
        end;

    end;

    procedure UpdatePageControls()
    begin
        if Rec.Status = Rec.Status::Open then begin
            RequestEditable := True;
            ReallocationVisible := False;

            //ReallocationEditable := False;
        end
        else begin
            if Rec.Status = Rec.Status::Pending then begin
                RequestEditable := True;
                //ReallocationEditable := True;
                ReallocationVisible := True;
            end
            else
                if Rec.Status = rEC.Status::"Requested Pending Allocation" then begin
                    RequestEditable := True;
                    AllocationVisible := True;
                    ReallocationVisible := false;
                end

                else
                    if Rec.Status = Rec.Status::Deffered then begin
                        RequestEditable := True;
                        //ReallocationEditable := True;
                        ReallocationVisible := True;
                    end
                    else begin
                        if Rec.Status = Rec.Status::Approved then begin
                            RequestEditable := False;
                            //ReallocationEditable := True;
                            ReallocationVisible := True;
                        end;
                    end;
        end;
    end;


    var
        VehReq: Record "Motor Vehicle Request";
        IndividualRequest: Boolean;
        DepartmentRequest: Boolean;
        UserSetup: Record "User Setup";
        VisibleDepartment: Boolean;
        VisibleIndividual: Boolean;
        PageEditable: Boolean;
        PageEdit: Boolean;
        VarVariant: Variant;
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        RequestEditable: Boolean;
        ReallocationEditable: Boolean;
        ReallocationVisible: Boolean;
        Drivers: Record "HR DRivers";
        CompanyVehicles: Record "Company Vehicles";
        VisibleOther: Boolean;
        GlobalFunctions: Codeunit "Global Functions";
        Comments: Record Comments;
        AssignmentDetails: Boolean;
        AllocationVisible: Boolean;
}
