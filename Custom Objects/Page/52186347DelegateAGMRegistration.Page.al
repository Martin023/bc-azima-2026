page 52186347 "Delegate AGM Registration"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    SourceTable = "ADM Registration";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Reg No"; Rec."Reg No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate Region Description"; Rec."Delegate Region Description")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Electoral Zone Description';
                    Editable = StatusEditableApproved;
                }
                field("Electoral Zone"; Rec."Electoral Zone")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Region Name';
                    Editable = StatusEditableApproved;
                }
                field("Electoral Zone Name"; Rec."Electoral Zone Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Region Name Description';
                    Editable = StatusEditableApproved;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = StatusEditableApproved;
                }
                field("Global Dimension 1 Name"; Rec."Global Dimension 1 Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = StatusEditableApproved;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = StatusEditableApproved;
                }
                field("Global Dimension 2 Name"; Rec."Global Dimension 2 Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = StatusEditableApproved;
                }
                field("Region Code"; Rec."Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = StatusEditableApproved;
                }
                field("Region Name"; Rec."Region Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = StatusEditableApproved;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = StatusEditableApproved;
                }
                field("County Name"; Rec."County Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = StatusEditableApproved;
                }
                field("Sub-County"; Rec."Sub-County")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = StatusEditableApproved;
                }
                field("Sub-County Name"; Rec."Sub-County Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = StatusEditableApproved;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = StatusEditableApproved;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = StatusEditableApproved;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = StatusEditableApproved;
                }
                field("AGM Member No"; Rec."AGM Member No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member ID No"; Rec."Member ID No")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
           
        }
        area(factboxes)
        {
            part("Approved Images"; "Member Picture & Signature")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approved Images';
                SubPageLink = "Member No" = FIELD("AGM Member No");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Delegates)
            {
                ApplicationArea = Basic, Suite;
                Image = BOMLedger;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    DelegateGroupss.Reset;
                    DelegateGroupss.SetRange(Code, Rec.Code);
                    //if DelegateGroupss.Find('-') then
                    //REPORT.Run(52186061, true, true, DelegateGroupss)
                end;
            }
            action("Delegate Tariff Payments")
            {
                ApplicationArea = Basic, Suite;
                Image = ProductionSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Region Delegate Tariffs";
                RunPageLink = "Region Code" = FIELD(Code);
            }
            action("Register Delegate")
            {
                ApplicationArea = Basic, Suite;
                Image = PostApplication;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    DelegateMemberss: Record "Delegate Members";
                    SavingsAccounts: Record "Savings Accounts";
                    CompInfo: Record "Company Information";
                    SendSms: Codeunit SendSms;
                    SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book",Internetbanking,CRM;
                    GeneralSetUp: Record "General Set-Up";
                    EndDateSalo: Date;
                    SalProc: Record "Salary Lines";
                    Text009: Label 'Salary Must be through the SACCO.';
                begin
                    GeneralSetUp.Get();
                    EndDateSalo := CalcDate('-' + Format(GeneralSetUp."Salary Period"), Today);
                    if Rec."AGM Member No" <> '' then begin
                        SalProc.Reset;
                        SalProc.SetRange("Member No.", Rec."AGM Member No");
                        SalProc.SetRange("Posting Date", EndDateSalo, Today);
                        SalProc.SetRange(Posted, true);
                        if not SalProc.Find('-') then begin
                            Error(Text009);
                        end;
                    end;
                    if not Confirm(ConfirmCreation) then
                        exit;
                    DelegateMemberss.Reset;
                    DelegateMemberss.SetRange(Type, DelegateMemberss.Type::ADM);
                    DelegateMemberss.SetRange("Delegate MNO.", Rec."AGM Member No");
                    DelegateMemberss.SetRange(Code, Rec.Code);
                    DelegateMemberss.SetRange("Attended AGM", false);
                    DelegateMemberss.SetRange(Paid, false);
                    if DelegateMemberss.Find('-') then begin
                        repeat
                            DelegateMemberss."Attended AGM" := true;
                            DelegateMemberss."Attendee Name" := DelegateMemberss."Delegate Name";
                            DelegateMemberss."Attendee No" := Rec."AGM Member No";
                            DelegateMemberss."Registered By" := UserId;
                            DelegateMemberss.Modify;
                            Message(DelegateMemberss."Delegate Name" + ' has been registered for ' + Rec."Delegate Region Description");
                            SavingsAccounts.Reset;
                            SavingsAccounts.SetRange("Member No.", Rec."AGM Member No");
                            SavingsAccounts.SetRange("Loan Disbursement Account", true);
                            if SavingsAccounts.Find('-') then begin
                                CompInfo.Get;

                                SendSMS.SendSms(Source::NEW_ACCOUNT, SavingsAccounts."Transactional Mobile No", msg, Format(SavingsAccounts."No."), '', true, 0, false, 'CBS', SavingsAccounts."No.", 'CBS');
                            end;
                        until DelegateMemberss.Next = 0;
                    end;
                    Rec."AGM Member No" := '';
                    Rec."Member ID No" := '';
                    Rec."Member Name" := '';
                    Rec.Modify;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId) then begin
            if UserSetup.Admin = false then begin

                Rec.Reset;
                Rec.SetRange("Reg No", UserId);
                if not ADMRegistration.Get(UserId, Rec."AGM Year") then begin
                    ADMRegistration.Init;
                    ADMRegistration."Reg No" := UserId;
                    ADMRegistration.Insert(true);

                end;
            end;
        end;
        FnRestrictAccess();
    end;

    var
        DelegateGroupss: Record "Delegate Region";
        StatusEditableApproved: Boolean;
        StatusEditablePending: Boolean;
        ConfirmCreation: Label 'Are you sure you want to Register this Member for ADM?';
        UserSetup: Record "User Setup";
        ADMRegistration: Record "ADM Registration";

    //[Scope('OnPrem')]
    procedure UpdateControls()
    begin
        /*IF Status=Status::Pending THEN
        StatusEditablePending:=FALSE
        ELSE
        StatusEditablePending:=FALSE;
        
        IF Status=Status::Approved THEN
        StatusEditableApproved:=FALSE
        ELSE
        StatusEditableApproved:=FALSE;
        */

    end;

    //[Scope('OnPrem')]
    procedure FnRestrictAccess()
    var
        StatusPermission: Record "Status Change Permissions.";
        ErrorOnRestrictViewTxt: Label 'You do Not have Permission on View,Read,Modify on this Page. Contact system administrator for assistance. %1-%2';
    begin
        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", DATABASE.UserId);
        StatusPermission.SetRange("Register ADM Attendance", true);
        if not StatusPermission.Find('-') then begin
            CurrPage.Editable := false;
        end else begin
            CurrPage.Editable := true;
        end;
    end;

    var
    Source: Enum "SMS Source";
    SendSMS: Codeunit SendSms;
    msg: Text;
}

