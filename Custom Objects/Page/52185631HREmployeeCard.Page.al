page 52185631 "HR Employee Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Print,Functions,Employee,Attachments,,Approvals,Tranfsers';
    SourceTable = "HR Employees";


    layout
    {
        area(content)
        {
            group("General Details")
            {
                Caption = 'General Details';
                //field("No."; Rec."No.")
                //{
                //    ApplicationArea = Basic;
                //    Importance = Promoted;
                //    Editable = False;
                //}
                //NEW FIELD - EDITABLE TO ALLOW MANUAL ALPHANUMERIC INPUT
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    // Editable = true;
                    Editable = false;
                    trigger OnAssistEdit()
                    begin
                        /*
                        IF AssistEdit THEN
                          CurrPage.UPDATE;
                        */

                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;
                    Editable = Inst;


                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = DepType;

                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;
                    Editable = IntMode;



                }
                field("Primary Identification Type"; Rec."Primary Identification Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = CurrCode;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin

                    end;
                }
                field("Primary Identification"; Rec."Primary Identification")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = RespCenter;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Primary Identification Type" = Rec."Primary Identification Type"::" " then
                            Error('Primary identification type must have a value');
                    end;
                }
                field("Secondary Identification Type"; Rec."Secondary Identification Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = Rmks;
                    trigger OnValidate()
                    begin
                        if Rec."Primary Identification" = '' then
                            Error('Primary identification must have a value');

                        if Rec."Primary Identification Type" = Rec."Secondary Identification Type" then
                            Error('Primary and secondary identification types cannot be the same');
                    end;
                }
                field("Secondary Identification"; Rec."Secondary Identification")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = WtaxCode;
                    trigger OnValidate()
                    begin
                        if Rec."Primary Identification" = '' then
                            Error('Primary identification must have a value');

                        if Rec."Primary Identification Type" = Rec."Secondary Identification Type" then
                            Error('Primary and secondary identification types cannot be the same');
                    end;
                }
                // field("ID Number"; Rec."ID Number")
                // {
                //     ApplicationArea = Basic;
                //     ShowMandatory = true;

                // }
                // field("Passport Number"; Rec."Passport Number")
                // {
                //     ApplicationArea = Basic;
                //     Importance = Promoted;

                // }
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = Basic;
                    Editable = INVdate;

                }
                field("Responsibility Center"; Rec."Responsibility Center")

                {
                    ApplicationArea = Basic;

                    Editable = true;

                }
                field("<GlobSal Dimension 1 Code>"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    ShowMandatory = true;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Editable = true;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = Basic;
                    Editable = pType;


                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Title2; Rec.Title2)
                {
                    Caption = '2nd Title';
                    ApplicationArea = Basic;
                    Editable = pType;


                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin

                        SupervisorNames := GetSupervisor(Rec."User ID");
                    end;
                }
                field("Supervisor Code"; Rec."Supervisor Code")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Editable = Freq;


                    trigger OnValidate()
                    begin

                    end;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;

                }

                field("Last Date Modified By"; Rec."Last Date Modified By")
                {
                    ApplicationArea = Basic;

                }
                field("Residential status"; Rec."Residential status")
                {
                    ApplicationArea = Basic;
                    Editable = Intrate;

                }
                field("Type of Employee"; Rec."Type of Employee")
                {
                    ApplicationArea = Basic;
                    Editable = Mmarketpage;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    StyleExpr = StyleTxt;


                    trigger OnValidate()
                    begin


                    end;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    ApplicationArea = Basic;
                    Editable = Rec.Status = Rec.Status::InActive;
                    Visible = Rec.Status = Rec.Status::InActive;
                    MultiLine = true;
                    ShowMandatory = Rec.Status = Rec.Status::InActive;
                    ToolTip = 'Enter reason for rejecting this employee application';
                }
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;
                    Editable = Dimension;

                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;
                    Editable = MKS;

                }
                field(Religion; Rec.Religion)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = InvTcode;

                }
                field("First Language (R/W/S)"; Rec."First Language (R/W/S)")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = Inst;

                }
                field("First Language Read"; Rec."First Language Read")
                {
                    ApplicationArea = Basic;
                    Editable = DepType;

                }
                field("First Language Write"; Rec."First Language Write")
                {
                    ApplicationArea = Basic;
                    Editable = IntMode;

                }
                field("First Language Speak"; Rec."First Language Speak")
                {
                    ApplicationArea = Basic;
                    Editable = RespCenter;

                }
                field("Second Language (R/W/S)"; Rec."Second Language (R/W/S)")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = CurrCode;

                }
                field("Second Language Read"; Rec."Second Language Read")
                {
                    ApplicationArea = Basic;
                    Editable = Rmks;

                }
                field("Second Language Write"; Rec."Second Language Write")
                {
                    ApplicationArea = Basic;
                    Editable = WtaxCode;
                }
                field("Second Language Speak"; Rec."Second Language Speak")
                {
                    ApplicationArea = Basic;
                    Editable = INVdate;
                }
                field("Additional Language"; Rec."Additional Language")
                {
                    ApplicationArea = Basic;
                    Editable = pType;
                }
                field("Vehicle Registration Number"; Rec."Vehicle Registration Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = Intrate;

                }
                field("Number Of Dependants"; Rec."Number Of Dependants")
                {
                    ApplicationArea = Basic;
                    Editable = Mmarketpage;

                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;
                    Editable = Inst;

                    trigger OnValidate()
                    begin
                        if Rec."Date Of Birth" >= Today then begin
                            Error('Invalid Entry');
                        end;
                        //DAge:= HRCodeunit.DetermineAge("Date Of Birth",TODAY);
                    end;
                }
                field(Disabled; Rec.Disabled)
                {
                    ApplicationArea = Basic;
                    Editable = Dimension;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        IF rEC.Disabled = REC.Disabled::Yes then
                            Message('Please input certificate number.');
                    end;
                }

                field("Certificate No."; Rec."Certificate No.")
                {
                    Editable = MKS;
                    Caption = 'Disability Certificate No.';
                }
            }
            group("Communication Details")
            {
                Caption = 'Communication Details';
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Editable = InvTcode;

                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ApplicationArea = Basic;
                    Editable = Inst;

                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    ApplicationArea = Basic;
                    Editable = DepType;

                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = EMail;
                    Editable = IntMode;

                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = EMail;
                    Importance = Promoted;
                    Editable = CurrCode;



                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                    Editable = IntMode;

                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = Basic;
                    Editable = Dimension;

                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                    Editable = mks;

                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic;
                    Editable = InvTcode;
                }
            }
            group("Important Dates")
            {
                Caption = 'Important Dates';


                field(DAge; Rec.Age)
                {
                    Caption = 'Age';

                    Editable = false;
                    Importance = Promoted;
                }
                field("County Of Birth"; Rec."County Of Birth")
                {
                    Editable = DepType;

                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Visible = true;
                    Editable = IntMode;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        //DService:= HRCodeunit.DetermineAge("Date Of Join",TODAY);
                    end;
                }
                field(DService; Rec."Years of service")
                {
                    Caption = 'Years of Service';
                    Editable = false;

                }
                field("Probation Duration"; Rec."Probation Duration")
                {
                    ApplicationArea = Basic;
                    Editable = CurrCode;

                }
                field("End Of Probation Date"; Rec."End Of Probation Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    var
                        MyNotification: Notification;

                    begin

                        if HrEmp."End of Probation Date" <= Today then begin
                            MyNotification.Message := 'Probation Period has ended ';
                            //MyNotification.Scope := NotificationScope::LocalScope;
                            MyNotification.Send();

                        end;
                    end;
                }
                // FIELD("Retirement Age"; Rec."Retirement Age")
                // {
                //     Editable = RespCenter;

                // }
                field("Retirement date"; Rec."Retirement date")
                {
                    ApplicationArea = Basic;
                    Editable = false;


                    trigger OnValidate()
                    begin
                        Dretire := HRCodeunit.DetermineAge(Rec."Retirement date", Today);
                    end;
                }
                field("Pension Scheme Join Date"; Rec."Pension Scheme Join Date")
                {
                    ApplicationArea = Basic;


                    trigger OnValidate()
                    begin
                        DPension := HRCodeunit.DetermineAge(Rec."Pension Scheme Join Date", Today);
                    end;
                }

                // field(DMedical; Rec.DMedical)
                // {
                //     Caption = 'Time On Medical Aid Scheme';
                //     Editable = false;
                //     Enabled = false;
                // }
                field("Wedding Anniversary"; Rec."Wedding Anniversary")
                {
                    ApplicationArea = Basic;
                    Editable = WtaxCode;

                }
            }
            group("Job Details")
            {
                Caption = 'Job Details';
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;
                    Editable = INVdate;

                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Position Reporting To"; Rec."Position Reporting To")
                {
                    Editable = pType;

                }

                field("Salary Grade"; Rec."Salary Grade")
                {
                    ApplicationArea = Basic;
                    editable = false;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin

                    end;
                }

                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Editable = Freq;

                }
                field("Professional Body"; Rec."Professional Body")
                {
                    ApplicationArea = Basic;
                    Editable = intrate;
                }
                field("cpd points"; Rec."cpd points")
                {
                    Editable = false;

                }
                field("Effective From Date"; Rec."Effective From Date")
                {
                    ApplicationArea = Basic;
                    Editable = Mmarketpage;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = Basic;
                    Editable = Dimension;
                }
            }
            group("Terms of Service")
            {
                Caption = 'Terms of Service';
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Nature of employment';
                    Importance = Promoted;
                    ShowMandatory = true;
                    Editable = MKS;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        FChequeVisible := false;
                        if rec."Contract Type" = 'CONTRACT' then
                            FChequeVisible := true
                        else
                            FChequeVisible := false;
                    end;
                }
                field("Employee Group"; Rec."Employee Group")
                {
                    ApplicationArea = Basic;
                    Editable = InvTcode;
                }

                group(contract)
                {
                    caption = '.';
                    visible = FChequeVisible;
                    field("Contract Duration"; Rec."Contract Duration")
                    {
                        Editable = inst;

                    }
                    field("Contract End Date"; Rec."Contract End Date")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Importance = Promoted;
                    }
                }

                field("Notice Period"; Rec."Notice Period")
                {
                    ApplicationArea = Basic;
                    Editable = DepType;
                }
                field("Send Alert to"; Rec."Send Alert to")
                {
                    ApplicationArea = Basic;
                    Editable = IntMode;
                }
            }
            group("Payment Information")
            {
                Caption = 'Payment Information';
                field("PIN No."; Rec."PIN No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;
                    Editable = CurrCode;
                }
                field("Medical Insurance No."; Rec."Medical Insurance No.")
                {
                    Editable = RespCenter;

                }
                field("Medical Scheme Join Date"; Rec."Medical Scheme Join Date")
                {
                    ApplicationArea = Basic;
                    Editable = Rmks;


                    trigger OnValidate()
                    begin
                        DMedical := HRCodeunit.DetermineAge(Rec."Medical Scheme Join Date", Today);
                    end;
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;
                    Editable = Rmks;
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    Caption = 'SHIF NO.';
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;
                    Editable = WtaxCode;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Status"; Rec."Member Status")
                {

                }
                field("No. Of Bank A/Cs"; Rec."No. Of Bank A/Cs")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Leave Details")
            {
                Caption = 'Leave Details';
                field("Reimbursed Leave Days"; Rec."Reimbursed Leave Days")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = INVdate;
                }
                field("Allocated Leave Days"; Rec."Allocated Leave Days")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Total (Leave Days)"; Rec."Total (Leave Days)")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Total Leave Taken"; Rec."Total Leave Taken")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }

                field("Available Leave Days"; Rec."Available Leave Days")
                {
                    Editable = False;
                }

            }
            group("Separation Details")
            {
                Caption = 'Separation Details';
                field("Date Of Leaving the Company"; Rec."Date Of Leaving the Company")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = Mmarketpage;

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        /*
                        FrmCalendar.SetDate("Date Of Leaving the Company");
                        FrmCalendar.RUNMODAL;
                        D := FrmCalendar.GetDate;
                        CLEAR(FrmCalendar);
                        IF D <> 0D THEN
                          "Date Of Leaving the Company":= D;
                        //DAge:= HRCodeunit.DetermineAge("Date Of Birth",TODAY);
                        
                        */

                    end;
                }
                field("Termination Grounds"; Rec."Termination Grounds")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = Dimension;

                }
                field("Exit Interview Date"; Rec."Exit Interview Date")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = mks;
                }
                field("Exit Interview Done by"; Rec."Exit Interview Done by")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = InvTcode;
                }
                field(Activate; Rec.Activate)
                {
                    ApplicationArea = Basic;
                    Editable = inst;
                }
                field("Reengagement Datei"; Rec."Reengagement Date")
                {

                }
            }
            Group(Disciplinary)
            {
                field("Disciplinary Case"; Rec."Disciplinary Case")
                {

                }
                field("Date Reported"; Rec."Date Reported")
                {

                }
                field(Nature; Rec.Nature)
                {

                }
                field("Disciplinary Duration"; Rec."Disciplinary Duration")
                {

                }
                field("Action Taken"; Rec."Action Taken")
                {

                }
                field("Hearing Date"; Rec."Hearing Date")
                {

                }
            }
        }
        area(factboxes)
        {
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Basic;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            part(Control1102755004; "HR Employees Factbox")
            {
                ApplicationArea = Basic;
                SubPageLink = "No." = FIELD("No.");
            }
            part("Approved Images"; "Member Picture & Signature")
            {
                ApplicationArea = Basic;

                Caption = 'Approved Images';
                SubPageLink = "Member No" = FIELD("Member No.");
            }

            systempart(Control1102755002; Outlook)
            {
                ApplicationArea = Basic;
            }
            systempart(Control1; Links)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(navigation)
        {

            group("&Print")
            {
                Caption = '&Print';
                action("Misc. Article Info")
                {
                    ApplicationArea = Basic;
                    Caption = 'Misc. Article Info';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Misc.Reset;
                        Misc.SetRange(Misc."Employee No.", Rec."No.");
                        if Misc.Find('-') then
                            REPORT.Run(Report::"Employee - Misc. Article Info.", true, true, Misc);
                    end;
                }
                action("Confidential Info")
                {
                    ApplicationArea = Basic;
                    Caption = 'Confidential Info';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Conf.Reset;
                        Conf.SetRange(Conf."Employee No.", Rec."No.");
                        if Conf.Find('-') then
                            REPORT.Run(Report::"Employee - Confidential Info.", true, true, Conf);
                    end;
                }
                action(Label)
                {
                    ApplicationArea = Basic;
                    Caption = 'Label';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."No.");
                        if HREmp.Find('-') then
                            REPORT.Run(Report::"Employee - Labels", true, true, HREmp);
                    end;
                }
                action(Addresses)
                {
                    ApplicationArea = Basic;
                    Caption = 'Addresses';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."No.");
                        if HREmp.Find('-') then
                            REPORT.Run(Report::"Employee - Addresses", true, true, HREmp);
                    end;
                }
                action("Alt. Addresses")
                {
                    ApplicationArea = Basic;
                    Caption = 'Alt. Addresses';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."No.");
                        if HREmp.Find('-') then
                            REPORT.Run(Report::"Employee - Alt. Addresses", true, true, HREmp);
                    end;
                }
                action("Phone Nos")
                {
                    ApplicationArea = Basic;
                    Caption = 'Phone Nos';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", Rec."No.");
                        if HREmp.Find('-') then
                            REPORT.Run(Report::"Employee - Phone Nos.", true, true, HREmp);
                    end;
                }
            }
            group("&Employee")
            {
                Caption = '&Employee';
                action("Next of Kin")
                {
                    ApplicationArea = Basic;
                    Caption = 'Contact Persons';
                    Image = Relatives;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    RunPageView = WHERE(Type = FILTER("Next of Kin"));
                }
                action(Dependants)
                {
                    ApplicationArea = Basic;
                    Caption = 'Beneficiaries';
                    Image = Opportunity;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    RunPageView = WHERE(Type = FILTER(Beneficiary));
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Employee),
                                  "No." = FIELD("No.");
                }
                action(Qualifications)
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Qualification Line";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action(Appointment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Appointment';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Appointment";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action(Commentss)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    Caption = 'Comment';
                    PromotedCategory = Category6;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
                action("Employment History")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employment History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employment History Lines";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Alternative Addresses")
                {
                    ApplicationArea = Basic;
                    Caption = 'Alternative Addresses';
                    Image = AlternativeAddress;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Alternative Address Card";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Misc. Articles")
                {
                    ApplicationArea = Basic;
                    Caption = 'Misc. Articles';
                    Image = ExternalDocument;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Misc. Articles Overview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Misc. Articles Overview';
                    Image = ViewSourceDocumentLine;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Misc. Articles Overview";
                }
                action("&Confidential Information")
                {
                    ApplicationArea = Basic;
                    Caption = '&Confidential Information';
                    Image = SNInfo;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Co&nfidential Info. Overview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&nfidential Info. Overview';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Confidential Info. Overview";
                }
                action("A&bsences")
                {
                    ApplicationArea = Basic;
                    Caption = 'A&bsences';
                    Image = AbsenceCalendar;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(5200),
                                  "No." = FIELD("No.");
                }
                action("Bank Accounts")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Bank Accounts List";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    RunPageMode = Edit;
                }
                action("<Page Employee Competence>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee Competence';
                    Image = Job;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Competence List";
                    RunPageLink = "Employee No" = FIELD("No.");
                }
            }
        }
        area(processing)
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
                    //Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if not Confirm('Are you sure you want to reject this employee application? You can enter rejection reason after rejecting.', false) then
                            exit;

                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                        Message('Application rejected. Please enter the rejection reason in the Rejection Reason field.');
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
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.CommRecordApprovalRequest(Rec.RecordId);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    //Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin
                        if Rec.Disabled = Rec.Disabled::Yes then begin
                            //VALIDATE DISABILITY CERTIFICATE IS PROVIDED
                            if rec."Certificate No." = '' then
                                Error('Please Capture the Disability Certificate No. for the disabled Employee.');
                        end;

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);

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
                        Rec.TestField(Status, Rec.Status::"Pending Approval");
                        VarVariant := Rec;
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
                action("Reopen Employee Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reopen Employee Card';
                    Image = OpenJournal;
                    Promoted = true;
                    PromotedCategory = Category9;


                    trigger OnAction()
                    begin
                        Message('Sets the status of Employee to New');

                        Rec.Status := Rec.Status::New;
                        Rec.Modify;
                    end;
                }

                action("Staff File")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        DMS: Record EDMS;
                    begin
                        DMS.Reset;
                        DMS.SetRange(DMS.Key, DMS.Key::"Employee File");
                        if DMS.Find('-') then begin
                            HyperLink(DMS."url path" + Rec."No.");
                        end;
                    end;
                }
            }
        }
    }
    trigger OnClosePage()
    begin

    end;

    trigger OnOpenPage()
    var
        MyNotification: Notification;

    begin
        //VALIDATE KRA PIN MATCHES MEMBER REGISTER - FIXED TO REMOVE FORMATTING ISSUES
        if rec."No." <> '' then begin
            Members.reset();
            Members.setrange("Payroll/Staff No.", Rec."No.");
            if Members.FindFirst() then begin
                if UpperCase(DelChr(Rec."PIN No.", '=', ' ')) <> UpperCase(DelChr(Members."P.I.N Number", '=', ' ')) then
                    Message('KRA PIN MISMATCH DETECTED:' + '\' + '\' +
                        'Employee Card PIN: %1' + '\' +
                        'Member Register PIN: %2' + '\' + '\' +
                        'The KRA PIN number on the Employee Card differs from the Member Register. Please verify which PIN is correct and update the Member Register accordingly to maintain data consistency.',
                        Rec."PIN No.", Members."P.I.N Number");
            end;
        end;

        UpdateControls();
    end;



    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        usersetup.reset();
        usersetup.SetRange("User ID", UserId);
        IF usersetup.FindFirst() then begin
            // rec."Global Dimension 1 Code":=usersetup."Global Dimension 1 Code";
            //rec."Global Dimension 2 Code":=usersetup."Global Dimension 2 Code";
            rec."Responsibility Center" := usersetup."Responsibility Centre";



        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin



        HrJob.reset();
        HrJob.setrange("Job ID", rec."Job ID");
        if HrJob.FindSet() then begin
            rec."Global Dimension 1 Code" := HrJob."Global Dimension 1 Code";
            rec."Global Dimension 2 Code" := HrJob."Global Dimension 2 Code";
            rec."Responsibility Center" := HrJob."Responsibility Center";


        end;

    end;


    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance();
        UpdateControls();
        //UpdateMonthlyLeaveDays();
        //BLOCKED ALL EDITS FOR NON-NEW EMPLOYEES
        //if rec.Status <> rec.status::New then
        //    CurrPage.Editable := false else
        //    CurrPage.Editable := true;

        //ALLOW EDITS FOR ACTIVE EMPLOYEES, BLOCK ONLY PENDING APPROVAL
        if rec.Status = rec.Status::"Pending Approval" then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;

        if rec."No." <> '' then begin
            FChequeVisible := false;
            if rec."Contract Type" = 'CONTRACT' then
                FChequeVisible := true
            else
                FChequeVisible := false;
            if rec.status <> rec.Status::New then begin
                if (rec."Member No." = '') or (rec."Member Status" = rec."Member Status"::" ") then begin
                    rec.CalcFields(Picture);
                    customer.reset();
                    customer.setrange("Internal Staff Employer", true);
                    if customer.FindFirst() then begin
                        member.reset();
                        member.setrange("Employer Code", customer."No.");
                        member.SetRange("Payroll/Staff No.", rec."No.");
                        if member.FindFirst() then begin
                            rec."Member No." := member."No.";
                            rec."Member Status" := member.Status;



                            Rec.Modify(true);
                        end;
                    end;
                end;
            end;
            if rec."Date Of Birth" <> 0D then begin

                ag := Round(((Today - rec."Date of Birth") / 365), 1, '=');

                IF rec."Date Of Birth" >= TODAY THEN BEGIN
                    ERROR('Date of Birth cannot be after %1', TODAY);
                END;

                rec.Age := ag;


            end;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
        UpdateControls();
        //UpdateMonthlyLeaveDays();
        //
        if rec."No." <> '' then begin


            if rec."Date Of Join" <> 0D then begin
                if rec."Date Of Leaving the Company" = 0D then begin
                    Serviceyears := today - rec."Date Of Join";
                    rec."Years of service" := Serviceyears / 365;
                end else
                    rec."Years of service" := (rec."Date Of Leaving the Company" - rec."Date Of Join") / 365;
            end;
            DAge := '';
            DService := '';
            DPension := '';
            DMedical := '';
            Dretire := '';

            //Recalculate Important Dates
            if (Rec."Date Of Leaving the Company" = 0D) then begin
                if (Rec."Date Of Birth" <> 0D) then
                    DAge := HRCodeunit.DetermineAge(rec."Date Of Birth", TODAY);
                if (Rec."Date Of Join" <> 0D) then
                    //DService:= HRCodeunit.DetermineAge("Date Of Join",TODAY);
                    if (Rec."Pension Scheme Join Date" <> 0D) then
                        DPension := HRCodeunit.DetermineAge(Rec."Pension Scheme Join Date", Today);
                if (Rec."Medical Scheme Join Date" <> 0D) then
                    DMedical := HRCodeunit.DetermineAge(Rec."Medical Scheme Join Date", Today);
                rec.MODIFY;
            end else begin
                /*
                IF  ("Date Of Birth" <> 0D) THEN
                DAge:= HRCodeunit.DetermineAge("Date Of Birth","Date Of Leaving the Company");
                IF  ("Date Of Join" <> 0D) THEN
                DService:= HRCodeunit.DetermineAge("Date Of Join","Date Of Leaving the Company");
                IF  ("Pension Scheme Join Date" <> 0D) THEN
                DPension:= HRCodeunit.DetermineAge("Pension Scheme Join Date","Date Of Leaving the Company");
                IF  ("Medical Scheme Join Date" <> 0D) THEN
                DMedical:= HRCodeunit.DetermineAge("Medical Scheme Join Date","Date Of Leaving the Company");
                //MODIFY;
              END;
              */
                //Recalculate Leave Days
                Rec.Validate("Allocated Leave Days");
                SupervisorNames := GetSupervisor(Rec."User ID");

                if Rec."Retirement date" <> 0D then begin
                    Dretire := HRCodeunit.DetermineAge(TODAY, rec."Retirement date");
                    //END;
                end;
            end;
            if (rec."Member No." = '') or (rec."Member Status" = rec."Member Status"::" ") then begin
                rec.CalcFields(Picture);
                customer.reset();
                customer.setrange("Internal Staff Employer", true);
                if customer.FindFirst() then begin
                    member.reset();
                    member.setrange("Employer Code", customer."No.");
                    member.SetRange("Payroll/Staff No.", rec."No.");
                    if member.FindFirst() then begin
                        rec."Member No." := member."No.";
                        rec."Member Status" := member.Status;


                        Rec.Modify(true);
                    end;
                end;
            end;
            rec.CalcFields(rec."Total Leave Taken");
            rec."Total (Leave Days)" := rec."Allocated Leave Days" + rec."Reimbursed Leave Days";
            //SUM UP LEAVE LEDGER ENTRIES
            rec."Leave Balance" := rec."Total (Leave Days)" - rec."Total Leave Taken";


        end;
    end;

    var
        Text001: Label 'Do you want to replace the existing picture of %1 %2?';
        Text002: Label 'Do you want to delete the picture of %1 %2?';
        Text003: Label 'Welcome to Lotus Capital Limited';
        Text004a: Label 'It is a great pleasure to welcome you to Moi Teaching and Referral Hospital. You are now part of an organization that has its own culture and set of values. On your resumption and during your on-boarding process,  to help you to understand and adapt quickly and easily to the LOTUS CAPITAL culture and values, HR Unit shall provide you with various important documents that you are encouraged to read and understand.';
        Text004b: Label 'On behalf of the Managing Director, I congratulate you for your success in the interview process and I look forward to welcoming you on board LOTUS CAPITAL Limited.';
        Text004c: Label 'Adebola SAMSON-FATOKUN';
        Text004d: Label 'Strategy & Corporate Services';
        DocMustbePending: Label 'Document Must be Pending Approval';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        PictureExists: Boolean;
        HRCodeunit: Codeunit "HR Codeunit2";
        HrJob: record "HR Jobs";
        Serviceyears: integer;

        DAge: Text[100];
        DService: Text[100];
        usersetup: record "User Setup";
        DPension: Text[100];
        DMedical: Text[100];
        D: Date;
        DoclLink: Record "HR Employee Attachments";
        "Filter": Boolean;
        prEmployees: Record "HR Employees";
        prPayrollType: Record "prPayroll Type";
        Mail: Codeunit Mail;
        HREmp: Record "HR Employees";
        SupervisorNames: Text[60];
        Misc: Record "Misc. Article Information";
        Conf: Record "Confidential Information";
        //SMTP: Codeunit "SMTP Mail";
        CompInfo: Record "Company Information";
        Members: record Members;
        Body: Text[1024];
        customer: record Customer;
        Filename: Text;
        Recordlink: Record "Record Link";
        Days: Integer;
        DaysWorked: Decimal;
        NL: Char;
        LF: Char;
        HrLeave: record "HR Leave Ledger Entries";
        HRLeaveCal: record "HR Leave Calendar";

        objpostingGroup: Record "PR Salary Card";
        objDimVal: Record "Dimension Value";
        "Citizenship Text": Text[200];
        BankEditable: Boolean;
        HRBankAccounts: Record "HR Employee Bank Accounts";
        Dretire: Text[100];
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        StyleTxt: Text;
        InvTcode: Boolean;
        Inst: Boolean;
        DepType: Boolean;
        member: record Members;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        IntMode: Boolean;
        CurrCode: Boolean;
        RespCenter: Boolean;
        Rmks: Boolean;
        WtaxCode: Boolean;
        INVdate: Boolean;
        pType: Boolean;
        Freq: Boolean;
        Intrate: Boolean;
        Mmarketpage: Boolean;
        dAlloc: Decimal;
        SystemEdits: record "System Edits";
        dEarnd: Decimal;
        dTaken: Decimal;
        dLeft: Decimal;
        cReimbsd: Decimal;
        cPerDay: Decimal;
        cbf: Integer;
        SalGrade: record "Salary Grades";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        Dimension: Boolean;
        MKS: Boolean;
        FChequeVisible: boolean;
        HremployeesJobQueues: report HremployeesJobQueues;
        ag: Integer;

    //[Scope('OnPrem')]

    procedure GetSupervisor(var sUserID: Code[50]) SupervisorName: Text[200]
    var
        UserSetup: Record "User Setup";
    begin
        if sUserID <> '' then begin
            UserSetup.Reset;
            if UserSetup.Get(sUserID) then begin

                SupervisorName := UserSetup."Approver ID";
                if SupervisorName <> '' then begin

                    HREmp.SetRange(HREmp."User ID", SupervisorName);
                    if HREmp.Find('-') then
                        SupervisorName := HREmp.FullName;

                end else begin
                    SupervisorName := '';
                end;


            end else begin
                Error('User' + ' ' + sUserID + ' ' + 'does not exist in the user setup table');
                SupervisorName := '';
            end;
        end;
    end;

    //[Scope('OnPrem')]

    procedure UpdateMonthlyLeaveDays()
    begin
        if rec.Status = rec.Status::Active then begin
            HRLeaveCal.Reset;
            HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
            if HRLeaveCal.Find('-') then begin

                //Filter by Leave Period from HR Setup
                HRLeave.Reset;
                HRLeave.SetRange(HRLeave."Staff No.", Rec."No.");

                HRLeave.SetRange(HRLeave."Leave Calendar Code", HRLeaveCal."Calendar Code");
                HrLeave.SetRange("Leave Entry Type", HrLeave."Leave Entry Type"::Positive);
                HrLeave.SetRange(Closed, false);


                if HRLeave.Find('-') then begin
                    HrLeave.CalcSums(HrLeave."No. of days");

                    if (rec."Date Of Join" <> 0D) and (HRLeaveCal."Start Date" <> 0D) then begin
                        if rec."Date Of Join" > HRLeaveCal."Start Date" then
                            Days := Today - rec."Date Of Join"
                        else
                            Days := Today - HRLeaveCal."Start Date";


                        if (rec."Date Of Leaving the Company" <> 0D) AND (HRLeaveCal."End Date" <> 0D) then begin
                            IF rec."Date Of Leaving the Company" < HRLeaveCal."End Date" then begin
                                Days := rec."Date Of Leaving the Company" - HRLeaveCal."Start Date"
                            end else
                                Days := Today - HRLeaveCal."Start Date";
                        end;
                    END;
                    //HrLeave.CalcFields("No. of days");
                    DaysWorked := Days * (HrLeave."No. of days" / 365);

                    Rec."Monthly Leave Days" := Round(DaysWorked, 0.01, '<');
                    rec.modify(true);
                end;
                Rec.calcfields("Reimbursed Leave Days", "Total Leave Taken");
                Rec."Available Leave Days" := (DaysWorked + rec."Reimbursed Leave Days") - ABS(rec."Total Leave Taken");
                rec.modify(true);
            end else
                Error('Leave Calendar not setup');
        end;

    end;


    procedure GetSupervisorID(var EmpUserID: Code[50]) SID: Text[200]
    var
        UserSetup: Record "User Setup";
        SupervisorID: Code[20];
    begin
        if EmpUserID <> '' then begin
            SupervisorID := '';

            UserSetup.Reset;
            if UserSetup.Get(EmpUserID) then begin
                SupervisorID := UserSetup."Approver ID";
                if SupervisorID <> '' then begin
                    SID := SupervisorID;
                end else begin
                    SID := '';
                end;
            end else begin
                Error('User' + ' ' + EmpUserID + ' ' + 'does not exist in the user setup table');
            end;
        end;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    local procedure UpdateControls()
    begin
        //BLOCKED ALL EDITS FOR NON-NEW EMPLOYEES
        //if rec.Status <> rec.Status::New then
        //    CurrPage.EDITABLE := false;

        //ALLOW EDITS FOR ACTIVE EMPLOYEES, BLOCK ONLY PENDING APPROVAL
        if Rec.Status = Rec.Status::"Pending Approval" then
            CurrPage.EDITABLE := false
        else
            CurrPage.EDITABLE := true;


        if Rec.Status = Rec.Status::New then begin
            InvTcode := true;
            Inst := true;
            DepType := true;
            IntMode := true;
            CurrCode := true;
            RespCenter := true;
            Rmks := true;
            WtaxCode := true;
            INVdate := true;
            pType := true;
            Freq := true;
            Intrate := true;
            Mmarketpage := true;
            Dimension := true;
            MKS := true;
        end;


        if Rec.Status = Rec.Status::"Pending Approval" then begin
            InvTcode := false;
            Inst := false;
            DepType := false;
            IntMode := false;
            CurrCode := false;
            RespCenter := false;
            Rmks := false;
            WtaxCode := false;
            INVdate := false;
            pType := false;
            Freq := false;
            Intrate := false;
            Mmarketpage := false;
            Dimension := False;
            MKS := False;
        end;

        //BLOCKED EDITS FOR ACTIVE EMPLOYEES
        //if Rec.Status = Rec.Status::Active then begin
        //    InvTcode := false;
        //    Inst := false;
        //    DepType := false;
        //    IntMode := false;
        //    CurrCode := false;
        //    RespCenter := false;
        //    Rmks := false;
        //    WtaxCode := false;
        //    INVdate := false;
        //    pType := false;
        //    Freq := false;
        //    Intrate := false;
        //    Mmarketpage := false;
        //    Dimension := False;
        //    MKS := False;
        //end;

        //ALLOW EDITS FOR ACTIVE EMPLOYEES
        if Rec.Status = Rec.Status::Active then begin
            InvTcode := true;
            Inst := true;
            DepType := true;
            IntMode := true;
            CurrCode := true;
            RespCenter := true;
            Rmks := true;
            WtaxCode := true;
            INVdate := true;
            pType := true;
            Freq := true;
            Intrate := true;
            Mmarketpage := true;
            Dimension := true;
            MKS := true;
        end;

    end;


}

