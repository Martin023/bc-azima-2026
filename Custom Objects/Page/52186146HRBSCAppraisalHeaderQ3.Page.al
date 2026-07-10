page 52186146 "HR Indiv Appraisal Card-Q3"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'Manage,Process,Report,Approvals,Functions,Training';
    SourceTable = "HR Individual Targets Header";


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        AppraisalPeriod.Reset;
                        AppraisalPeriod.SetRange(AppraisalPeriod.Closed, false);
                        if AppraisalPeriod.Find('-') then begin
                            OpenPeriod := AppraisalPeriod."Appraisal Period Description"
                        end;

                        HRIndividualTargetsHeader.Reset;
                    end;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Date"; Rec."Appraisal Date")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Cycle Stage"; Rec."Appraisal Cycle Stage")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Strong;
                }
                field("Review Sequence No"; Rec."Review Sequence No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Total Targeted Score"; Rec."Total Targeted Score")
                {
                    ApplicationArea = Basic;
                }
                field("Total Achieved Score"; Rec."Total Achieved Score")
                {
                    ApplicationArea = Basic;
                }
                field("Total Agreed Rating"; Rec."Total Agreed Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Lock appraisal"; Rec."Lock appraisal")
                {
                    ApplicationArea = Basic;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Source Department Target No"; Rec."Source Department Target No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("Individual Targets"; "End Year Review")
            {
                ApplicationArea = All;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
            }
            part(Control4; "Performance Attributes Sheet")
            {
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Import Assigned Department Targets")
            {
                Caption = 'Import Assigned Department Targets';
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Enabled = (Rec.Status = Rec.Status::Open) and (Rec."Appraisal Cycle Stage" = Rec."Appraisal Cycle Stage"::"Target Setting");

                trigger OnAction()
                var
                    Assignment: Record "HR Employee Target Assignment";
                    DeptTargetNo: Code[20];
                    DeptTargetList: Page "HR Employee Target Assgns List";
                begin
                    if Rec."Appraisal Cycle Stage" <> Rec."Appraisal Cycle Stage"::"Target Setting" then
                        Error('Can only import assigned targets during Target Setting stage.');

                    if Rec.Status <> Rec.Status::Open then
                        Error('Can only import targets when appraisal status is Open.');

                    Assignment.Reset;
                    Assignment.SetRange("Employee No", Rec."Employee No");
                    Assignment.SetFilter(Status, '%1|%2', Assignment.Status::Assigned, Assignment.Status::Accepted);
                    if Assignment.IsEmpty then
                        Error('You have no assigned department targets available for import. Please contact your HOD.');

                    DeptTargetList.SetTableView(Assignment);
                    DeptTargetList.LookupMode := true;
                    if DeptTargetList.RunModal = ACTION::LookupOK then begin
                        DeptTargetList.GetRecord(Assignment);
                        DeptTargetNo := Assignment."Department Target No";

                        if Confirm('Import all assigned targets from Department Target %1?', true, DeptTargetNo) then begin
                            Rec.ImportFromAssignedTargets(DeptTargetNo);
                            CurrPage.Update(false);
                        end;
                    end;
                end;
            }
            action("Send to supervisor")
            {
                Caption = 'Send to Supervisor';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                begin

                    if Confirm('Send this Appraisal to Supervisor?', true) = false then exit;

                    Rec.Status := Rec.Status::"Pending Approval";
                    Rec.Modify;
                end;
            }
            action("Return to Supervisor")
            {
                Caption = 'Return to Supervisor';
                Image = Pause;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                begin
                    if Confirm('Do you want to return this Appraisal to Supervisor?', true) = false then exit;

                    Rec.Status := Rec.Status::"Pending Approval";
                    Rec.Modify;
                end;
            }
            action("Send back to Target Setting")
            {
                Caption = 'Send Back to Target Setting';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                begin

                    if Confirm('Send this Appraisal back to Target Setting?', true) = false then exit;

                    Rec."Appraisal Cycle Stage" := Rec."Appraisal Cycle Stage"::"Target Setting";
                    Rec.Modify;
                end;
            }
            action(Action1000000020)
            {
                Caption = 'Print';
                Image = PrintForm;
                Promoted = true;
                PromotedCategory = Category5;
            }
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Category5;
                Visible = false;

                trigger OnAction()
                begin
                    if Rec."Appraisal Cycle Stage" = Rec."Appraisal Cycle Stage"::"Evaluation Review" then begin
                        Rec.TestField(Status, Rec.Status::Discussed);
                    end;

                    if Rec."Appraisal Cycle Stage" = Rec."Appraisal Cycle Stage"::"Target Setting" then begin
                        Rec.TestField(Status, Rec.Status::Approved);
                    end;

                    if Confirm('Are you sure you want to post?', false) = true then begin
                        Testfields;
                        HRIndividualTargetsHeader.Reset;
                        HRIndividualTargetsHeader.SetRange(HRIndividualTargetsHeader."Appraisal No", Rec."Appraisal No");
                        if HRIndividualTargetsHeader.Find('-') then begin
                            HRIndividualTargetsHeader.CreateLedgerEntries;
                        end;
                    end;
                end;
            }
            action("Training needs")
            {
                Image = List;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "MBanking Other Services";
                //RunPageLink = Field29 = FIELD("Employee No");
                Visible = false;
            }
            action(Print)
            {
            }
            action("Close Appraisal")
            {
                Image = Close;
                Promoted = true;

                trigger OnAction()
                begin
                    if Confirm('Send this Appraisal to Supervisor?', true) = false then exit;

                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /* CALCFIELDS("Finance Rating","Customer Rating","Training Rating","Service Rating",Customer,Training,Service,Finance);
         IF ("Finance Rating"<>0) AND (Finance<>0)  THEN
         "Finance Perc Score":=("Finance Rating"*25)/(Finance*5);
         IF ("Customer Rating"<>0)AND(Customer<>0)THEN
         "Customer Perc Score":=("Customer Rating"*25)/(Customer*5);
         IF ("Training Rating"<>0) AND(Training<>0) THEN
         "Training Perc Score":=("Training Rating"*25)/(Training*5);
         IF ("Service Rating"<>0) AND (Service<>0)THEN
         "Service Perc Score":=("Service Rating"*25)/(Service*5);
         //MESSAGE('%1,%2,%3,%4',"Finance Perc Score","Customer Perc Score","Training Perc Score","Service Perc Score");
         "Overall Perc Score":="Finance Perc Score"+"Customer Perc Score"+"Training Perc Score"+"Service Perc Score";
         MODIFY;*/

    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Rec."Lock appraisal" = true then
            Error('You connot modify a locked Appraisal');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if (UserId = xRec."User ID") and (Rec.Status <> Rec.Status::Approved) then
            Error('You have an open appraisal for the current period')
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        //IndividualTarget.VALIDATE(IndividualTarget."Finance Perc Score");
    end;

    trigger OnOpenPage()
    begin
        /*
        IF "Lock appraisal"=TRUE THEN
          CurrPage.EDITABLE:=FALSE;
        */
        //CurrPage.EDITABLE:=FALSE

    end;

    var
        HRIndividualTargetsHeader: Record "HR Individual Targets Header";
        OpenPeriod: Text[100];
        AppraisalPeriod: Record "HR Appraisal Period";
        Editpage: Boolean;

    //[Scope('OnPrem')]
    procedure Testfields()
    begin
        Rec.TestField("Appraisal Period");
        Rec.TestField("Appraisal No");
        Rec.TestField("Appraisal Period");
        Rec.TestField("Appraisal Date");
        Rec.TestField("Employee No");
    end;

    //[Scope('OnPrem')]
    procedure EditFields()
    begin
        /*
        IF Status<>Status::Open THEN
         Editpage:=FALSE ELSE
         Editpage:=TRUE;
         */

    end;
}

