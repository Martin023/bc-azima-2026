page 52185709 "Member Nos. Series"
{
    PageType = Card;
    SourceTable = "Credit Nos. Series";
    ApplicationArea = Basic;
    UsageCategory = Administration;
    Caption = 'Credit Nos. Series';
    layout
    {
        area(content)
        {
            group(General)
            {
                Visible = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Member Management")
            {
                field("Member Application Nos."; Rec."Member Application Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Nos."; Rec."Member Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("System Edits"; Rec."System Edits")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Group Account Nos"; Rec."Group Account Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Driver No."; Rec."Driver No.")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Group Exit and Transfer';
                // }
                // field("CRM Member Edits Nos."; Rec."CRM Member Edit App Nos.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("M-Smart Member Edit App Nos."; Rec."M-Smart Member Edit App Nos.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("General SMS Nos."; Rec."General SMS Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sales Route No."; Rec."Sales Route No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Portfolio Manager"; Rec."Portfolio Manager")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Dividend Rate No."; Rec."Dividend Rate No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("SMS Subscription"; Rec."SMS Subscription")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("SMS Code"; Rec."SMS Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("BBF Claims"; Rec."BBF Claims")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("BBF Report"; Rec."BBF Report")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Sink Fund Nos."; Rec."Sink Fund Nos.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("BBF Insurance Nos."; Rec."BBF Insurance Nos.")
                // {
                //     ApplicationArea = Basic, Suite;

                // }
                field("BDE Application"; Rec."BDE Application")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ECLT Zones"; Rec."ECLT Zones")
                {
                    ApplicationArea = all;
                }
                field("Digital Signature Nos."; Rec."Digital Signature Nos.")
                {

                }
                field("Volume Entry No."; Rec."Volume Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("File Request"; Rec."File Request")
                { }
                field("File Entry No."; Rec."File Entry No.") { }
                field("File Batching No."; Rec."File Batching No.") { }
                // field("MKey Case Forwarding"; Rec."MKey Case Forwarding")
                // {

                // }
                field("Template No."; Rec."Template No.")
                {
                }
                // field("Revenue Collection Nos."; Rec."Revenue Collection Nos.")
                // {
                // }
            }
            group("FOSA No. series")
            {
                field("Accounts Application"; Rec."Accounts Application")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fixed Deposit Contract"; Rec."Fixed Deposit Contract")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("FINANCE No. series")
            {
                field("Normal Closure Nos."; Rec."Normal Closure Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Pertial Closure Nos."; Rec."Pertial Closure Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Variations; Rec.Variations)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Loan Variations';
                }
                field("Savings Variations"; Rec."Savings Variations")
                {
                    ApplicationArea = all;
                    Caption = 'Savings Variations';
                }
                field("Checkoff No."; Rec."Checkoff No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Advice No."; Rec."Advice No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withdrawal Notice"; Rec."Withdrawal Notice")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Share Capital Transfer No"; Rec."Share Capital Transfer No")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Shares Transfer No';
                }
                // field("MKey Case Forwarding"; Rec."MKey Case Forwarding")
                // {
                //     ApplicationArea = Basic, Suite;
                // }

            }

            group(Securities)
            {

                field("Dependancy Application Nos."; Rec."Dependancy Application Nos.")
                {

                }
            }
            group("Credit Management ")
            {
                field("Loan Nos."; Rec."Loan Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("FOSA Loan Nos."; Rec."FOSA Loan Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Business Loan Nos."; Rec."Business Loan Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("HR Loan Nos."; Rec."HR Loan Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile Loan Nos."; Rec."Mobile Loan Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mora-Num"; Rec."Mora-Num")
                {
                    ApplicationArea = all;
                    Caption = 'Moratorium Num';
                }

                field("Loan Batch Nos"; Rec."Loan Batch Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Billing Nos."; Rec."Billing Nos.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Billing Nos.';
                }

                field("Loan Reschedule"; Rec."Loan Reschedule")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Batch Posting Series"; Rec."Loan Batch Posting Series")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Guarantors Substitution"; Rec."Guarantors Substitution")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Attachment"; Rec."Loan Attachment")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Reappotionment"; Rec."Loan Reappotionment")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Reversal"; Rec."Loan Reversal")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Recovery II"; Rec."Loan Recovery II")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("External Debt Collectors"; Rec."External Debt Collectors")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Factory"; Rec."Product Factory")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Security Nos."; Rec."Loan Security Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Security Setup Nos."; Rec."Loan Security Setup Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Security Collection Nos"; Rec."Loan Security Collection Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Security Perfection No."; Rec."Security Perfection No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Security Discharge No."; Rec."Security Discharge No.")
                {
                    ApplicationArea = Basic, Suite;
                }

                // field("Loan No EM"; Rec."Loan No EM")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Loan No SF"; Rec."Loan No SF")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Loan No DEV"; Rec."Loan No DEV")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Loan No JS"; Rec."Loan No JS")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Loan No Jsort"; Rec."Loan No Jsort")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Loan No Finje"; Rec."Loan No Finje")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Loan No Inuka"; Rec."Loan No Inuka")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Mortage Doc Release"; Rec."Mortage Doc Release")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Loan No Web DEV"; Rec."Loan No Web DEV")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Loan No Web SF"; Rec."Loan No Web SF")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Loan No Web EM"; Rec."Loan No Web EM")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Business Loan Acc App"; Rec."Business Loan Acc App")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Business Loan Account Closure"; Rec."Business Loan Account Closure")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("DMU SMS Alerts"; Rec."DMU SMS Alerts")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("DMU Case Forwarding"; Rec."DMU Case Forwarding")
                {

                }
                field("Promise To Pay"; Rec."Promise To Pay")
                {

                }
            }
            group("Administration")
            {
                // field("Driver No."; Rec."Driver No.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Key No."; Rec."Key No.")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Key Dispatch No."; Rec."Keys Dispatch Nos.")
                {
                    Visible = false;

                    ApplicationArea = Basic, Suite;
                }
                field("Key Request No."; Rec."Key Request No.")
                {
                    Visible = false;

                    ApplicationArea = Basic, Suite;
                }
                field("Company Vehicle Nos."; Rec."Company Vehicle Nos.")
                {
                    Visible = false;

                    ApplicationArea = Basic, Suite;
                }
                field("Motor Vehicle Movement No."; Rec."Motor Vehicle Movement No.")
                {
                    Visible = false;

                    ApplicationArea = Basic, Suite;
                }
                field("Motor Vehicle Request No."; Rec."Motor Vehicle Request No.")
                {
                    Visible = false;

                    ApplicationArea = Basic, Suite;
                }
                field("Conference Creation Nos."; Rec."Conference Creation Nos.")
                {
                    Visible = false;

                    ApplicationArea = Basic, Suite;
                }
                field("Conference/Meeting Room No."; Rec."Conference/Meeting Room No.")
                {
                    Visible = false;

                    ApplicationArea = Basic, Suite;
                }
                field("Fueling No."; Rec."Fueling No.")
                {
                    Visible = false;

                    ApplicationArea = Basic, Suite;
                }
                field("Repair No."; Rec."Repair No.")
                {
                    Visible = false;

                    ApplicationArea = Basic, Suite;
                }
                field("Service No."; Rec."Service No.")
                {
                    Visible = false;

                    ApplicationArea = Basic, Suite;
                }
                field("Accident No."; Rec."Accident No.")
                {
                    Visible = false;

                    ApplicationArea = Basic, Suite;
                }
                field("Permission Requisitions Nos"; Rec."Permission Requisitions Nos")
                {
                    Visible = true;
                    ApplicationArea = Basic, Suite;
                }
                field("User creation"; Rec."User creation")
                {
                    Visible = true;
                    ApplicationArea = Basic, Suite;
                }
                field("User Termination"; Rec."User Termination")
                {
                    Visible = true;
                    ApplicationArea = Basic, Suite;
                }
                field("Parking Creation No."; Rec."Parking Creation No.")
                {
                    visible = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Parking Space No."; Rec."Parking Space No.")
                {
                    visible = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Insurace Claim No."; Rec."Insurance Claim No.")
                {
                    visible = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Salary Agreement No"; Rec."Salary Agreement No")
                {
                    visible = false;
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Legal")
            {
                Visible = false;

                field("Nominee Legal No."; Rec."Nominee Legal No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Nominee Form Req No"; Rec."Nominee Form Req No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Case Nos."; Rec."Case Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Appeal No."; Rec."Appeal No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Witness Nos."; Rec."Witness Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contract No"; Rec."Contract No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contract Request No."; Rec."Contract Request No.")
                {
                    ApplicationArea = Basic, Suite;
                }
            }

            group("CRM - Originations")
            {
                field("CRM - Member Applications"; Rec."CRM - Member Applications")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("CRM - Member Readmissions"; Rec."CRM - Member Readmission")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("CRM - Loan Applications"; Rec."CRM - Loan Applications")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("CRM - FOSA Loan"; Rec."CRM - FOSA Loan")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("CRM - BOSA Loan"; Rec."CRM - BOSA Loan")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("CRM - Member Withdrawals"; Rec."CRM - Member Withdrawals")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("CRM - BBF Claims"; Rec."CRM - BBF Claims")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("CRM - Loan Guarantor Subs"; Rec."CRM - Loan Guarantor Subs")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("CRM - Sub Account Reqs"; Rec."CRM - Sub Account Reqs")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("CRM - Loan Variation Reqs"; Rec."CRM - Loan Variation Reqs")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("CRM - Deposit Variation Reqs"; Rec."CRM - Deposit Variation Reqs")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("CRM - Share Transfer Reqs"; Rec."CRM - Share Transfer Reqs")
                {
                    ApplicationArea = Basic, Suite;
                }
            }


        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        OnAccesRestrictView();
    end;

    //[Scope('OnPrem')]
    procedure OnAccesRestrictView()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestrictViewTxt: Label 'You do Not have Permission on View,Read,Modify on this Page. Contact system administrator for assistance. %1-%2';
    begin
        // ChangePermission.Reset;
        // ChangePermission.SetRange("User ID", UserId);
        // ChangePermission.SetRange("Edit Setup", true);
        // ChangePermission.SetRange("Function Extended", ChangePermission."Function Extended"::Administrator);
        // if not ChangePermission.Find('-') then begin
        //     Error(ErrorOnRestrictViewTxt, UserId, Rec.TableCaption);
        // end;
    end;
}

