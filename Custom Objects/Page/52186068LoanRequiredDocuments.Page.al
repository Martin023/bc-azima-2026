page 52186068 "Loan Required Documents"
{
    // DeleteAllowed = false;
    // InsertAllowed = false;
    PageType = List;
    SourceTable = "Loan Required Documents";
    ApplicationArea = Basic, Suite;

    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product ID"; Rec."Product ID")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Single Party/Multiple"; Rec."Single Party/Multiple")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Provided ?"; Rec."Provided ?")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("License Expiry Date"; Rec."License Expiry Date")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnClosePage()
    var
        myInt: Integer;
        Loansrec: Record Loans;
        msg: Text;
        Source: Enum "SMS Source";
        SendSMS: Codeunit SendSms;
        membersRec: Record Members;
    begin
        if Rec."Provided ?" <> Rec."Provided ?"::Yes then begin
            Loansrec.Reset();
            Loansrec.SetRange("Loan No.", Rec."Loan No.");
            if Loansrec.FindFirst() then begin
                membersRec.Get(Loansrec."Member No.");
                msg := 'You loan application of ' + ' ' + Loansrec."Loan Product Type Name" + ' of ' + ' Kes' + Format(Loansrec."Approved Amount") + ' ' + 'has a mandary requirement of ' + Rec.Description + '';
                SendSMS.SendSms(Source::MBANKING, membersRec."Phone No.", msg, Format(Loansrec."Disbursement Account No"), '', true, 0, false, 'CBS', Loansrec."Disbursement Account No", 'CBS');

            end;
        end;

    end;
}

