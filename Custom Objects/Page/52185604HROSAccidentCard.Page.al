page 52185604 "HR OSAccident Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "HR OSAccident";
    Caption = 'Accidents Card';
    ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Reports,Creations,Views,Home,Creation';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Accident No"; Rec."Accident No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Type of Accident"; Rec."Type of Accident")
                {
                    Caption = 'Type Accident';
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        if Rec."Type of Accident" = Rec."Type of Accident"::"Single Collision" then begin
                            SingleCollisionVisible := True;
                            MultipleCollisionVisible := False;

                        end
                        else
                            if Rec."Type of Accident" = Rec."Type of Accident"::"Multiple Collision" then begin
                                SingleCollisionVisible := False;
                                MultipleCollisionVisible := True;
                                begin
                                    Message('Please Capture Other Party Details!');
                                end;
                            end;
                        if Rec."Type of Accident" = Rec."Type of Accident"::" " then Error('This Field Cannot be empty')
                    end;
                }
                field("Driver No."; Rec."Driver No.")
                {
                    Caption = 'Driver No.';
                    ShowMandatory = true;
                }
                field("SACCO Driver Staff No."; Rec."Driver Staff No.")
                {
                    Caption = 'SACCO Driver Staff No.';
                    ShowMandatory = true;
                    Editable = false;
                }
                field("SACCO Driver Name"; Rec."MNS Driver Name")
                {
                    Editable = false;
                    Caption = 'SACCO Driver Name';
                    trigger OnValidate()
                    begin
                        if Rec."MNS Driver Name" = '' then Error('This Field Cannot be empty')
                    end;
                }
                field("SACCO Driver ID"; Rec."MNS Driver ID No.")
                {
                    Editable = false;
                    Caption = 'SACCO Driver ID';
                    trigger OnValidate()
                    begin
                        if Rec."MNS Driver ID No." = 0 then Error('This Field Cannot be empty')
                    end;
                }
                field("SACCO Driver Phone No"; Rec."MNS Driver Phone No.")
                {
                    Editable = false;
                    Caption = 'SACCO Driver Phone No';
                    trigger OnValidate()
                    begin
                        if Rec."MNS Driver Phone No." = '' then Error('This Field Cannot be empty')
                    end;
                }
                field("SACCO Vehicle No."; Rec."MNS Vehicle No.")
                {
                    Caption = 'SACCO Vehicle No.';
                    trigger OnValidate()
                    begin
                        if Rec."MNS Vehicle No." = '' then Error('This Field Cannot be empty')
                    end;
                }
                field("SACCO Vehicle Make"; Rec."MNS Vehicle Make")
                {
                    Editable = false;
                    Caption = 'SACCO Vehicle Make';
                    trigger OnValidate()
                    begin
                        if Rec."MNS Vehicle Make" = '' then Error('This Field Cannot be empty')
                    end;
                }
                field("Registration No."; Rec."Registration No.")
                {
                    Caption = 'Registration No.';
                    Editable = False;
                    trigger OnValidate()
                    begin
                        if Rec."Registration No." = '' then Error('This Field Cannot be empty')
                    end;
                }
                field("SACCO Vehicle Insurance"; Rec."SACCO Vehicle Insurance")
                {
                    Caption = 'SACCO Vehicle Insurance';
                    // trigger OnValidate()
                    // begin
                    //     if Rec."Other Party Vehicle Insurance" = Rec."Other Party Vehicle Insurance":: '' then 
                    //     Error ('This Field Cannot be empty')
                    // end;
                }
                field("Accident Date"; Rec."Accident Date")
                {
                    Trigger OnValidate()
                    begin
                        if Rec."Accident Date" = 0D then
                            Error('This Field Cannot be empty')
                    end;
                }
                field("Accident Time"; Rec."Accident Time")
                {
                }
                field("Accident Location"; Rec."Accident Location")
                {
                }
                field("Extent of Damages"; Rec."Extent of Damages")
                {
                }
                field("Branch"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Branch field.';
                    Editable = false;
                }
                field("Department"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Department field.';
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created Date"; Rec."Created at")
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
            // group ("SACCO Details")
            // {
            //     Caption = 'SACCO Details';

            // }

            part(Control; "Other Party Lines")
            {
                SubPageLink = "Accident No." = FIELD("Accident No.");
                Visible = MultipleCollisionVisible;
            }
            // part(Control5; "HR OSAccident Line")
            // {
            //     SubPageLink = "Accident No." = FIELD("Accident No.");
            // }
            part(Control6; "HR OSMeasure Line")
            {
                Caption = 'Assessment Details';
                SubPageLink = "Measure No" = FIELD("Accident No.");
            }



        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = Const(52185561), "No." = field("Accident No.");
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
                //Caption = 'Save Accident Details';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()

                begin

                    Rec.TestField("Type of Accident");
                    Rec.TestField("Driver Staff No.");
                    Rec.TestField("MNS Driver Name");
                    Rec.TestField("MNS Driver ID No.");
                    Rec.TestField("MNS Driver Phone No.");
                    Rec.TestField("MNS Vehicle No.");
                    Rec.TestField("MNS Vehicle Make");
                    Rec.TestField("Registration No.");
                    Rec.TestField("SACCO Vehicle Insurance");
                    Rec.TestField("Accident Date");
                    Rec.TestField("Accident Time");
                    Rec.TestField("Accident Location");
                    Rec.testfield("Extent of Damages");

                    if Rec."Type of Accident" = Rec."Type of Accident"::"Multiple Collision" then begin
                        // OtherPartyLines.Reset();
                        // OtherPartyLines.SetRange("Accident No.", Rec."Accident No.");
                        // if OtherPartyLines.Find('-') then begin
                        //     IF OtherPartyLines."Driver Name" = '' THEN
                        //         Error('Other Party Driver Name Cannot be empty');
                        //     if OtherPartyLines."Driver ID No." = ' ' THEN
                        //         Error('Other Party Driver ID No. Cannot be empty');
                        //     IF OtherPartyLines."Phone No." = '' THEN
                        //         Error('Other Party Driver Phone No. Cannot be empty');
                        //     IF OtherPartyLines."Vehicle No." = '' THEN
                        //         Error('Other Party Vehicle No. Cannot be empty');
                        //     if OtherPartyLines."Vehicle Make" = '' THEN
                        //         Error('Other Party Vehicle Make Cannot be empty');
                        //     if OtherPartyLines."Insurance Policy No." = '' THEN
                        //         Error('Other Party Vehicle Insurance Cannot be empty');
                        //     IF OtherPartyLines."Vehicle Insurance" = OtherPartyLines."Vehicle Insurance"::" " THEN
                        //         Error('Other Party Vehicle Insurance Cannot be empty');
                        // end;

                        OtherPartyLines.Reset();
                        OtherPartyLines.SetRange("Accident No.", Rec."Accident No.");
                        if OtherPartyLines.Find('-') then begin
                            repeat
                                OtherPartyLines.TestField("Driver Name");
                                OtherPartyLines.TestField("Driver ID No.");
                                OtherPartyLines.TestField("Phone No.");
                                OtherPartyLines.TestField("Vehicle No.");
                                OtherPartyLines.TestField("Vehicle Make");
                                OtherPartyLines.TestField("Insurance Policy No.");
                                OtherPartyLines.TestField("Vehicle Insurance");
                            until OtherPartyLines.Next() = 0;
                        end
                        else
                            //Error('Please Capture Other Party Details!');
                            IF OtherPartyLines."Driver Name" = '' THEN
                                Error('Other Party Driver Name Cannot be empty');
                        if OtherPartyLines."Driver ID No." = ' ' THEN
                            Error('Other Party Driver ID No. Cannot be empty');
                        IF OtherPartyLines."Phone No." = '' THEN
                            Error('Other Party Driver Phone No. Cannot be empty');
                        IF OtherPartyLines."Vehicle No." = '' THEN
                            Error('Other Party Vehicle No. Cannot be empty');
                        if OtherPartyLines."Vehicle Make" = '' THEN
                            Error('Other Party Vehicle Make Cannot be empty');
                        if OtherPartyLines."Insurance Policy No." = '' THEN
                            Error('Other Party Vehicle Insurance Cannot be empty');
                        IF OtherPartyLines."Vehicle Insurance" = OtherPartyLines."Vehicle Insurance"::" " THEN
                            Error('Other Party Vehicle Insurance Cannot be empty');
                    end;

                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
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
            // action(Close)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Close Vehicle';
            //     Image = Close;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     trigger OnAction()
            //     begin
            //         Rec.TestField(Status, Rec.Status::Approved);
            //         if Rec.Status = Rec.Status::Approved then begin

            //             Rec."Status" := Rec."Status"::Closed;
            //             Rec.Modify;
            //             Message('Accident Closed');
            //         end;
            //     end;
            // }
        }

    }
    // Trigger OnOpenPage()
    // begin
    //     OtherPartyInvolved := false;
    // end;

    trigger OnOpenPage();
    begin
        SingleCollisionVisible := false;
        MultipleCollisionVisible := false;

        if Rec."Type of Accident" = Rec."Type of Accident"::"Single Collision" then begin
            SingleCollisionVisible := True;
            MultipleCollisionVisible := False;
        end;
        if Rec."Type of Accident" = Rec."Type of Accident"::"Multiple Collision" then begin
            SingleCollisionVisible := False;
            MultipleCollisionVisible := True;
        end;

        if UserSetup.Get(Rec."Created By") then begin
            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
            Rec."Created By" := UserId;
            //Rec.SystemCreatedAt := CURRENTDATETIME;
            Rec.Modify;
        end;

    end;
    // trigger OnClosePage();
    // begin
    //     Rec.TestField("Type of Accident");
    //     Rec.TestField("Driver Staff No.");
    //     Rec.TestField("Driver Staff No.");

    //     if Rec."Type of Accident" = Rec."Type of Accident"::"mUltiple Collision" then begin

    //     end;
    // end;
    // procedure UpdatePageControls()
    // begin
    //     if Rec.Status =  Rec.Status::Open then begin
    //         PageEditable := True;
    //     end
    //     else begin
    //         if Rec.Status = Rec.Status::Pending then begin
    //             PageEditable := True;
    //         end
    //         else begin 
    //             if Rec.Status = Rec.Status::Approved then begin
    //                 PageEditable := False;
    //             end;
    //         end;
    //     end;
    // end;
    //     local procedure PageControl();
    // begin

    //     MultipleCollisionVisible := false;

    //     if Rec."Type of Accident" = Rec."Type of Accident"::"Single Collision" then begin
    //        MultipleCollisionVisible := false;
    //     end;
    //     if Rec."Type of Accident" = Rec."Type of Accident"::"Multiple Collision" then begin
    //         MultipleCollisionVisible := true;
    //         SingleCollisionVisible := false;
    //         begin
    //             Message('Please Capture Other Party Details!');
    //         end;
    //     end;
    //     if Rec."Type of Accident" = Rec."Type of Accident"::" " then Error('This Field Cannot be empty')
    // end;

    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OtherPartyInvolved: Boolean;
        Accidents: Record "HR OSAccident";
        UserSetup: Record "User Setup";
        PageEdit: Boolean;
        VarVariant: Variant;
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        //CustomApprovals: Codeunit "Custom Approvals Codeunit";
        PageEditable: Boolean;
        SingleCollisionVisible: Boolean;
        MultipleCollisionVisible: Boolean;
        OtherPartyLines: Record "Accident Lines Table";

}

