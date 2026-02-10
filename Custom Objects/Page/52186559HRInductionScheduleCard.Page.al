page 52186559 "HR Induction Schedule Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'Manage,Process,Report,Participants';
    SourceTable = "HR Induction Schedule";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Induction Code"; Rec."Induction Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                group(Control8)
                {
                    ShowCaption = false;
                    grid(Control5)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control6)
                        {
                            ShowCaption = false;
                            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                            {
                                ApplicationArea = Basic;
                            }
                            field("Global Dimension 1 Name"; Rec."Global Dimension 1 Name")
                            {
                                ApplicationArea = Basic;
                                ShowCaption = false;
                            }
                        }
                    }
                }
                group(Control15)
                {
                    ShowCaption = false;
                    grid(Control14)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control13)
                        {
                            ShowCaption = false;
                            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                            {
                                ApplicationArea = Basic;
                            }
                            field("Global Dimension 2 Name"; Rec."Global Dimension 2 Name")
                            {
                                ApplicationArea = Basic;
                                ShowCaption = false;
                            }
                        }
                    }
                }
                group(Control9)
                {
                    ShowCaption = false;
                    grid(Control7)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control3)
                        {
                            ShowCaption = false;
                            field("Induction Start Date"; Rec."Induction Start Date")
                            {
                                ApplicationArea = Basic;
                            }
                            field("Induction Duration"; Rec."Induction Duration")
                            {
                                ApplicationArea = Basic;
                                Caption = 'Duration (e.g. 1D,2W)';
                            }
                            field("Induction End Date"; Rec."Induction End Date")
                            {
                                ApplicationArea = Basic;
                            }
                        }
                    }
                    field(Comments; Rec.Comments)
                    {
                        MultiLine = true;
                        ApplicationArea = Basic;
                    }
                    field("No. of Participants"; Rec."No. of Participants")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("HOD Notified?"; Rec."HOD Notified?")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control2; Outlook)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Action1102755014)
            {
            }
            action("Induction Participants ")
            {
                ApplicationArea = Basic;
                Caption = 'Induction Participants';
                Image = PersonInCharge;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "HR Induction Participants List";
                RunPageLink = "Induction Code" = FIELD("Induction Code");
            }
            action("Notify Head of Department")
            {
                ApplicationArea = Basic;
                Image = Email;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Message('Checks for HOD and sends an email to them to facilitate the Induction');
                    //Testfields
                    Rec.TestField("HOD Notified?", Rec."HOD Notified?"::No);
                    Rec.TestField("Global Dimension 1 Code");
                    Rec.TestField("Global Dimension 2 Code");
                    Rec.CalcFields("No. of Participants");
                    Rec.TestField("No. of Participants");
                    Rec.TestField("Induction Start Date");
                    Rec.TestField("Induction End Date");


                    //Check if respective HOD is setup in HR Heads of Depts. Table
                    HR_HODs.Reset;
                    HR_HODs.SetRange(HR_HODs."Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    HR_HODs.SetRange(HR_HODs."Global Dimension 2 Code", Rec."Global Dimension 2 Code");
                    if not HR_HODs.Find('-') then Error(ERR_HR_HOD_SETUP);
                    HR_HODs.TestField(HR_HODs."Employee No.");

                    //Check if E-Mail parameters have been setup
                    HREmailParam.Reset;
                    HREmailParam.SetRange(HREmailParam."Associate With", HREmailParam."Associate With"::"Induction Schedule");
                    if not HREmailParam.Find('-') then begin
                        //Create Email Parameters f not setup
                        HREmailParam.Init;

                        HREmailParam."Associate With" := HREmailParam."Associate With"::"Induction Schedule";
                        HREmailParam."Sender Name" := 'HUMAN RESOURCE';
                        HREmailParam."Sender Address" := 'dwesa@coretec.co.ke';
                        HREmailParam.Subject := 'Induction Schedule Participants';
                        HREmailParam.Body := 'Kindly faciliate an Induction for [ Induction Document No ] '
                                            + Rec."Induction Code" + '<br>' +
                                            'Kindly login in the system to view document and participants'
                                            + '<br>' + 'Warm Regards';

                        HREmailParam.Insert;
                    end;

                    //Check document as processed
                    Rec."HOD Notified?" := Rec."HOD Notified?"::Yes;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        UpdateControls;
    end;

    var
        Induction: Record "HR Induction Schedule";
        DepartmentName: Text[40];
        sDate: Date;
        Inductionschedule: Record "HR Induction Schedule";
        Number: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Budget Transfer","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval";
        //// //ApprovalEntries: Page "Approval Entries";
        HRJobs: Record "HR Jobs";
        Department: Record "Dimension Value";
        HREmailParam: Record "HR E-Mail Parameters";
        ERR_EMAIL_PARAM_SETUP: Label 'Please setup Induction Schedule Notification Template in HR E-Mail Parameters';
        HR_HODs: Record "HR Heads of Departments";
        //SMTPMail: Codeunit "SMTP Mail";
        ERR_HR_HOD_SETUP: Label 'Please define HOD for [ %1 - %2 ]';
        HRCodeunit: Codeunit "HR Codeunit2";

    local procedure UpdateControls()
    begin
        CurrPage.Editable := HRCodeunit.fn_UpdateControls(Format(Rec."HOD Notified?"));
    end;
}

