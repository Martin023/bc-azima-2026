namespace MNS.MNS;

page 52186575 "Perfection In Progress list"
{
    ApplicationArea = All;
    Caption = 'Perfection In Progress list';
    PageType = List;
    SourceTable = "Perfection Lines";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Header No. field.';
                    EDITABLE = FALSE;
                }
                field("Security No."; Rec."Security No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Security No. field.';
                    EDITABLE = FALSE;
                }
                field("Property No."; Rec."Property No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property No. field.';
                    EDITABLE = FALSE;
                }
                field("Collateral Value Sum"; Rec."Collateral Value Sum")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Collateral Value Sum field.';
                    Caption = 'Collateral Value';
                    EDITABLE = FALSE;
                }
                field("Force Sale Value"; Rec."Forced Sale Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Force Sale Value field.';
                    EDITABLE = FALSE;
                }
                field("Market Value"; Rec."Market Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Market Value field.';
                    EDITABLE = FALSE;
                }
                field("Spousal Consent"; Rec."Spousal Consent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Spousal Consent field.';
                    EDITABLE = FALSE;
                }
                field("Land Control Board Consent"; Rec."Land Control Board Consent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Land Control Board Consent field.';
                    EDITABLE = FALSE;
                }
                field("Fees Payable to the Firm"; Rec."Fees Payable to the firm")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fees Payable to the Firm field.';
                    EDITABLE = FALSE;
                }
                field("Status of the fees"; Rec."Status of the fees")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status of the fees field.';
                    EDITABLE = FALSE;
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charge Type field.';
                    EDITABLE = FALSE;
                }
                field("Amount to Charge"; Rec."Amount to Charge")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount to Charge field.';
                    EDITABLE = FALSE;
                }
                field("Collaeral Owner"; Rec."Collateral Owner")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Collaeral Owner field.';
                    EDITABLE = FALSE;
                }
                // field("Market Value"; Rec."Market Value")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Market Value field.';
                // }
                // field("Forced Sale Value"; Rec."Forced Sale Value")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Forced Sale Value field.';
                // }
                field("Collateral Types"; Rec."Collateral Types")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Collateral Types field.';
                    EDITABLE = FALSE;
                }
                field("Collateral Owner"; Rec."Collateral Owner")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Collateral Owner field.';
                    //EDITABLE = FALSE;
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Registered field.';

                }
                field(Perfected; Rec.Perfected)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Perfected field.';
                    //EDITABLE = FALSE;
                }
                field(Discharged; Rec.Discharged)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Discharged field.';
                    EDITABLE = FALSE;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Perfection)
            {
                ApplicationArea = All;
                Caption = 'Perfection';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Perfection Lines";
            }
            action("Register Collateral")
            {
                ApplicationArea = All;
                Caption = 'Register Collateral';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.TestField("Date Registered");
                    Rec.Perfected := true;
                end;
            }
            action("Send SMS")
            {
                ApplicationArea = All;
                Caption = 'Send SMS';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    //Rec.TestField("Collateral Owner");
                    Rec.TestField(Perfected);

                    if Rec."Collateral Owner" = Rec."Collateral Owner"::" " then begin
                        Rec."Collateral Owner" := Rec."Collateral Owner"::Loanee
                    end;

                    //     Error('Collateral Owner field is Required!')
                    if Rec."Collateral Owner" = Rec."Collateral Owner"::Loanee then begin

                        Members.Reset();
                        Members.SetRange("No.", Rec."Member No.");
                        if Members.Find('-') then begin
                            if Members."Phone No." <> '' then begin
                                if Confirm('Do you want to send an SMS to the Loanee?') then
                                    msg := 'Dear, ' + Rec."Member Name" + ', This is to formally inform you that the ' + Rec."Concatenated Property" + ' ' + 'which you offered as collateral for' + ' ' + Rec."Loan Name" + ' ' + 'was successfully registered in favour of AZIMA DT SACCO on' + ' ' + FORMAT(Rec."Date Registered") + '. ';
                                SendSMS.SendSms(Source::"Security Perfection", Members."Phone No.", msg, ' ', ' ', false, 0, false, 'CBS', Rec."Security No.", 'CBS', Rec."Date Registered");
                            end
                            else if Members."Transactional Mobile Number" <> ' ' then begin
                                msg := 'Dear, ' + Rec."Member Name" + ', This is to formally inform you that the ' + Rec."Concatenated Property" + ' ' + 'which you offered as collateral for' + ' ' + Rec."Loan Name" + ' ' + 'was successfully registered in favour of AZIMA DT SACCO on' + ' ' + FORMAT(Rec."Date Registered") + '. ';
                                SendSMS.SendSms(Source::"Security Perfection", Members."Transactional Mobile Number", msg, ' ', ' ', false, 0, false, 'CBS', Rec."Security No.", 'CBS', Rec."Date Registered");
                            end
                            else
                                Error('Member Phone Number is Required!');
                        end;
                    end
                    else
                        if Rec."Collateral Owner" = Rec."Collateral Owner"::Chargor then begin
                            if Rec."Chargor Phone No." <> ' ' then begin
                                if Confirm('Do you want to send SMS to the Chargor') then
                                    msg := 'Dear ' + Rec."Chargor/Owner Name" + ',\' + ' please note that the ' + FORMAT(Rec."Charge Type") + 'over Property No. ' + Rec."Property No." + 'which you offered as collateral for' + ' ' + Rec."Loan Name" + ' ' + 'for ' + Rec."Member Name" + ' was successfully registered in favour of Kenpipe DT SACCO on the' + ' ' + FORMAT(Rec."Date Registered") + '. ' + 'The same was charged at Kshs. ' + Format(Rec."Amount To Charge") + '.';
                                SendSMS.SendSms(Source::"Security Perfection", Rec."Chargor Phone No.", msg, ' ', ' ', false, 0, false, 'CBS', Rec."Security No.", 'CBS', Rec."Date Registered");
                            end
                            else
                                Error('Chargor Phone Number is Required!');
                        end;
                    Rec."SMS Sent" := true;
                    Rec.Modify();
                    MESSAGE('SMS Sent Successfully!');
                end;
            }
        }
    }
    local procedure concatenatepropertyforSMS()
    var
        myInt: Integer;
        HeaderRec: Record "Security Perfection";
        //LinesRec: Record "Perfection Lines";
        LinesRec: Record "Securities Register";
        Concatenatedproperty: Text;
        LineCount: Integer;
        i: Integer;
        Property: Text;
    begin
        //HeaderRec.RESET;
        //HeaderRec.SETRANGE("Loan No.", Rec."Loan No.");
        //if HeaderRec.FINDFIRST() then begin
        LinesRec.RESET;
        LinesRec.SETRANGE("Loan No.", Rec."Loan No.");
        LinesRec.SetRange(Status, LinesRec.Status::Approved);
        LinesRec.Setrange("Collateral Discharged", false);
        LinesRec.Setrange("Collateral Perfected", false);
        LineCount := LinesRec.COUNT;
        if LinesRec.FIND('-') then begin
            i := 1;
            repeat
                Property := LinesRec."Charge Type" + ' over Property No. ' + LinesRec."Collateral Ref No." + ' ' + 'whose amount to charge was KES. ' + FORMAT(LinesRec."Amount to be Charged") + '.00' + ' ';
                if i = LineCount then
                    Concatenatedproperty += Property
                else
                    Concatenatedproperty += Property + 'and,' + ' ';
                i += 1;
            until LinesRec.NEXT = 0;
            Message('SMS Body: %1', Concatenatedproperty);
            Rec."Concatenated Property" := Concatenatedproperty;

            Rec.MODIFY;
        end
        else
            Error('No Collateral Found!');
        //end;
    end;

    var
        SendSMS: Codeunit SendSms;
        msg: Text;
        Source: enum "SMS Source";
        Members: Record Members;
}
