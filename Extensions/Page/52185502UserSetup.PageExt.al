#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185502 pageextension52185502 extends "User Setup"
{

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""User Setup"(Page 119)".

    layout
    {
        modify("User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Posting From")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Posting To")
        {
            ApplicationArea = Basic;
        }
        modify("Register Time")
        {
            ApplicationArea = Basic;
        }
        modify("Salespers./Purch. Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Salespers./Purch. Code"(Control 5)".


            //Unsupported feature: Property Modification (Name) on ""Salespers./Purch. Code"(Control 5)".

        }
        modify("Sales Resp. Ctr. Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Resp. Ctr. Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Service Resp. Ctr. Filter")
        {
            ApplicationArea = Basic;
        }
        modify("Time Sheet Admin.")
        {
            ApplicationArea = Basic;
        }
        modify(Email)
        {

            //Unsupported feature: Property Modification (Name) on "Email(Control 7)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Email(Control 7)".

        }



        addafter("User ID")
        {
            field("Full Name"; Rec."Full Name")
            {
                ApplicationArea = Basic;
            }
            field("Member No."; Rec."Member No.")
            {
                ApplicationArea = basic;
            }
        }
        addafter("Allow Posting To")
        {
            field("Allow Posting From [Time]"; Rec."Allow Posting From [Time]")
            {
                ApplicationArea = Basic;
            }
            field("Allow Posting To [Time]"; Rec."Allow Posting To [Time]")
            {
                ApplicationArea = Basic;
            }
            field("No. Active Session"; Rec."No. Active Session")
            {
                ApplicationArea = Basic;
            }
            field("Extended Posting Date"; Rec."Extended Posting Date")
            {
                ApplicationArea = Basic;
            }
            field("Approver ID"; Rec."Approver ID")
            {
                ApplicationArea = Basic;
            }
            field(Substitute; Rec.Substitute)
            {
                ApplicationArea = Basic;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = Basic;
            }
        }
        addafter(Email)
        {
            field("Responsibility Centre"; Rec."Responsibility Centre")
            {
                ApplicationArea = Basic;
            }
            field("User Type"; Rec."User Type")
            { ApplicationArea = Basic; }
            field("Employee No."; Rec."Employee No.")
            { ApplicationArea = Basic; }

            field("Employee Extension No."; Rec."Employee Extension No.")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Time Sheet Admin.")
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = Basic;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = Basic;
            }
            field("Unlimited PV Amount Approval"; Rec."Unlimited PV Amount Approval")
            {
                ApplicationArea = Basic;
            }
            field("PV Amount Approval Limit"; Rec."PV Amount Approval Limit")
            {
                ApplicationArea = Basic;
            }
            field("Unlimited PettyAmount Approval"; Rec."Unlimited PettyAmount Approval")
            {
                ApplicationArea = Basic;
            }
            field("Petty C Amount Approval Limit"; Rec."Petty C Amount Approval Limit")
            {
                ApplicationArea = Basic;
            }
            field("Unlimited Imprest Amt Approval"; Rec."Unlimited Imprest Amt Approval")
            {
                ApplicationArea = Basic;
            }
            field("Imprest Amount Approval Limit"; Rec."Imprest Amount Approval Limit")
            {
                ApplicationArea = Basic;
            }
            field("Unlimited Store RqAmt Approval"; Rec."Unlimited Store RqAmt Approval")
            {
                ApplicationArea = Basic;
            }
            field("Store Req. Amt Approval Limit"; Rec."Store Req. Amt Approval Limit")
            {
                ApplicationArea = Basic;
            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = Basic;
            }
            field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = Basic;
            }
            field("Unlimited ImprestSurr Amt Appr"; Rec."Unlimited ImprestSurr Amt Appr")
            {
                ApplicationArea = Basic;
            }
            field("ImprestSurr Amt Approval Limit"; Rec."ImprestSurr Amt Approval Limit")
            {
                ApplicationArea = Basic;
            }
            field("Unlimited Interbank Amt Appr"; Rec."Unlimited Interbank Amt Appr")
            {
                ApplicationArea = Basic;
            }
            field("Interbank Amt Approval Limit"; Rec."Interbank Amt Approval Limit")
            {
                ApplicationArea = Basic;
            }
            field("Imprest Account"; Rec."Imprest Account")
            {
                ApplicationArea = Basic;
            }
            field("Post JVs"; Rec."Post JVs")
            {
                ApplicationArea = Basic;
            }
            field("Post Bank Rec"; Rec."Post Bank Rec")
            {
                ApplicationArea = Basic;
            }
            field("Unlimited Receipt Amt Approval"; Rec."Unlimited Receipt Amt Approval")
            {
                ApplicationArea = Basic;
            }
            field("Receipt Amt Approval Limit"; Rec."Receipt Amt Approval Limit")
            {
                ApplicationArea = Basic;
            }
            field("Unlimited Claim Amt Approval"; Rec."Unlimited Claim Amt Approval")
            {
                ApplicationArea = Basic;
            }
            field("Claim Amt Approval Limit"; Rec."Claim Amt Approval Limit")
            {
                ApplicationArea = Basic;
            }
            field("Unlimited Advance Amt Approval"; Rec."Unlimited Advance Amt Approval")
            {
                ApplicationArea = Basic;
            }
            field("Advance Amt Approval Limit"; Rec."Advance Amt Approval Limit")
            {
                ApplicationArea = Basic;
            }
            field("Unlimited AdvSurr Amt Approval"; Rec."Unlimited AdvSurr Amt Approval")
            {
                ApplicationArea = Basic;
            }
            field("AdvSurr Amt Approval Limit"; Rec."AdvSurr Amt Approval Limit")
            {
                ApplicationArea = Basic;
            }
            field("Other Advance Staff Account"; Rec."Other Advance Staff Account")
            {
                ApplicationArea = Basic;
            }
            field("Office/Group"; Rec."Office/Group")
            {
                ApplicationArea = Basic;
            }
            field("Show Hidden"; Rec."Show Hidden")
            {
                ApplicationArea = Basic;
            }
            field("Post Reversals"; Rec."Post Reversals")
            {
                ApplicationArea = Basic;
            }
            field("Post Dividend"; Rec."Post Dividend")
            {
                ApplicationArea = Basic;
            }
            field("Restricted Posting Date"; Rec."Restricted Posting Date")
            {
                ApplicationArea = Basic;
            }
            field("Show Hidden Balance"; Rec."Show Hidden Balance")
            {
                ApplicationArea = Basic;
            }
            field("Self Posting Gn Jnl"; Rec."Self Posting Gn Jnl")
            {
                ApplicationArea = Basic;
            }
            field("Credit FOSA Account"; Rec."Credit FOSA Account")
            {
                ApplicationArea = Basic;
            }
            field(Admin; Rec.Admin)
            {
                ApplicationArea = Basic;
            }
            field("Allow Overdrawal"; Rec."Allow Overdrawal")
            {
                ApplicationArea = Basic;
            }
            field("Guarantor Release"; Rec."Guarantor Release")
            {
                ApplicationArea = Basic;
            }
            field("Update Loan Instalments"; Rec."Update Loan Instalments")
            {
                ApplicationArea = Basic;
            }
            field("Delegate Approval"; Rec."Delegate Approval")
            {
                ApplicationArea = Basic;
            }
            field("Run Sasra Report"; Rec."Run Sasra Report")
            {
                ApplicationArea = Basic;
            }
            field("Portal Onboarding"; Rec."Portal Onboarding")
            {
                ApplicationArea = Basic;
            }
            field("Member Change Permission"; Rec."Member Change Permission")
            {
                Caption = 'Sensitive Member Data';
                ApplicationArea = Basic;
            }
            field("Edit Sal Through FOSA"; Rec."Edit Sal Through FOSA")
            {
                ApplicationArea = Basic;
            }
            field("Allow Self Approval"; Rec."Allow Self Approval")
            {

            }


        }
        //moveafter("Global Dimension 1 Code"; Email)
    }



    procedure FnRestrictAccess()
    var
        StatusPermission: Record 52185687;
        ErrorOnRestrictViewTxt: label 'You do Not have Permission on View,Read,Modify on this Page. Contact system administrator for assistance. %1-%2';
    begin
        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", Database.UserId);
        StatusPermission.SetRange("Edit Setup", true);
        if not StatusPermission.Find('-') then begin
            CurrPage.Editable := false;
        end else begin
            CurrPage.Editable := true;
        end;
    end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
