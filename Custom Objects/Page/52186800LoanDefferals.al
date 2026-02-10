page 52186800 "Loan Defferals"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Loan Defferals";

    layout
    {
        area(Content)
        {
            repeater("Defferal Reasons")
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field(Deffercode; Rec.Deffercode)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    trigger OnClosePage()
    var
        myInt: Integer;
        MemmberRec: Record Members;
        SmsSource: Enum "SMS Source";
        msg: Text;
        Loans: Record Loans;
        DimensionValue: Record "Dimension Value";
        CellNo: Code[40];
        SendSMS: Codeunit SendSms;
        DefferRSon: Record "Loan Defferals";
        DefS: Record "Loan Defferals";
    begin
        if Confirm('Do you want to send SMS notification to the member?', false) = true then begin
            DefferRSon.Reset();
            DefferRSon.SetRange("Loan No.", Rec."Loan No.");
            DefferRSon.SetRange("Sms Sent", false);
            if DefferRSon.FindFirst() then begin
                repeat
                    Loans.Reset();
                    Loans.SetRange(Loans."Loan No.", Rec."Loan No.");
                    if Loans.FindFirst() then begin
                        DimensionValue.Reset;
                        DimensionValue.SetRange(Code, Loans."Global Dimension 2 Code");
                        if DimensionValue.Find('-') then begin
                            CellNo := DimensionValue."Phone No.";
                        end;

                        if MemmberRec.Get(Loans."Member No.") then begin

                            msg := 'Your Loan application of' + ' ' + Loans."Loan Product Type Name" + ' ' + Format(Loans."Approved Amount") + ' ' + 'has been Deffered' + ': ' + DefferRSon.Description
                             + 'Call ' + CellNo;

                            SendSMS.SendSms(SMSSource::LOAN_APPLICATION, MemmberRec."Phone No.", msg, Format(Loans."Disbursement Account No"), '', true, 0, false, 'CBS', Loans."Disbursement Account No", 'CBS');
                        end;
                    end;
                    DefS.Reset();
                    DefS.SetRange("Loan No.", DefferRSon."Loan No.");
                    DefS.SetRange("Entry No", DefferRSon."Entry No");
                    if DefS.FindFirst() then begin
                        DefS."Sms Sent" := true;
                        DefS.Modify();
                    end;
                until DefferRSon.Next() = 0;
            end;
        end;
        if Confirm('Do you want  to deffer this Loan?') = true then begin
            Loans.Reset();
            Loans.SetRange(Loans."Loan No.", Rec."Loan No.");
            if Loans.FindFirst() then begin
                Loans.Status := Loans.Status::Deffered;
                Loans.Modify();
            end;
        end;

    end;
}