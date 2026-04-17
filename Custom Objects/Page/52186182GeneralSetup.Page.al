page 52186182 "General Setup"
{
    PageType = Card;
    SourceTable = "General Set-Up";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Member Age"; rec."Min. Member Age")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Member Age"; rec."Max. Member Age")
                {
                    ApplicationArea = Basic;
                }
                field("EFT Dest Acc Length"; rec."EFT Dest Acc Length")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Member Age - Disabled"; rec."Max. Member Age - Disabled")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Age Non-Common Bond"; rec."Max. Age Non-Common Bond")
                {
                    ApplicationArea = Basic;
                }
                field("Auto-Completion on approval"; Rec."AutoCompletion on approval")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Rejection Period"; Rec."Loan Rejection Period")
                {
                    ApplicationArea = all;
                }
                field("Loan Categorization Code"; Rec."Loan Categorization Code")
                {
                    ApplicationArea = all;
                }
                field("Release Doc Time"; Rec."Release Doc Time")
                {
                    ApplicationArea = all;
                }
                field("Dormancy SMS Period"; Rec."Dormancy SMS Period")
                {
                    ApplicationArea = all;
                }
            }
            group("Charges Setup")
            {
                field("Share Transfer Fee"; rec."Share Transfer Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Failed STO Fee"; Rec."Failed STO Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Fee"; Rec."Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Fee Account"; Rec."Withdrawal Fee Account")
                {
                    ApplicationArea = Basic;
                }

            }
            group("Finance Set-Up")
            {
                field("Excise Duty (%)"; rec."Excise Duty (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Excise Duty G/L"; rec."Excise Duty G/L")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding %"; Rec."Withholding %")
                {
                    ApplicationArea = all;
                }
                field("Board Salaries Account"; Rec."Board Salaries Account")
                {
                    ApplicationArea = all;
                }
                field("External STO Account No."; rec."External STO Account No.")
                {
                    ApplicationArea = Basic;
                }

                field("Dividend Payable Account"; rec."Dividend Payable Account")
                {
                    ApplicationArea = Basic;
                }

                field("Dividend Expense Account"; rec."Dividend Expense Account")
                {
                    ApplicationArea = Basic;
                }

                field("Withholding Tax Account"; rec."Withholding Tax Account")
                {
                    ApplicationArea = Basic;
                }

                field("Div. Advance Rate"; rec."Div. Advance Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Bankers Cheque Limit"; rec."Bankers Cheque Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Share Cpital"; rec."Minimum Share Capital")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Price"; rec."Shares Price")
                {
                    ApplicationArea = Basic;
                }

                field("AML Transaction Limit"; Rec."AML Transaction Limit")
                {
                    ToolTip = 'Specifies the value of AML Transaction Limit field.';
                }
                group("Member Withdrawal")
                {
                    Caption = 'Member Withdrawal';
                    field("Withdrawal Notice period"; Rec."Withdrawal Notice period")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Withdrawal Notice Penalty"; Rec."Withdrawal Notice Penalty")
                    {
                        ApplicationArea = Basic;
                    }

                    field("Early Withdrawal %"; Rec."Early Withdrawal %")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Early Withdrawal Account"; Rec."Early Withdrawal Account")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Max 1st Partial Withdrawal %"; Rec."Max 1st Partial Withdrawal %")
                    {
                        ToolTip = 'Specifies the value of the Maximum 1st partial withdrawal % field.';
                    }
                    field("Partial Account Fee"; Rec."Partial Account Fee")
                    {
                        ToolTip = 'Specifies the value of the Partial Account Fee field.';
                    }
                    field("Early Withdrawal Fee"; Rec."Early Withdrawal Fee")
                    {
                        ToolTip = 'Specifies the value of the Early Withdrawal Fee field.';
                    }

                }
            }
            group("Sky World Set-Up")
            {
                field("Sky Loan Interest Rate (%)"; Rec."Sky Loan Interest Rate (%)")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Savings Set-Up")
            {
                field("Registration Fee"; rec."Registration Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Rejoining Fee"; rec."Rejoining Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Rejoining Fees Account"; rec."Rejoining Fees Account")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum ATM Limit"; rec."Maximum ATM Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Salary SMS Suffix"; rec."Salary SMS Suffix")
                {
                    ApplicationArea = Basic;
                }
                field("Birthday Message"; rec."Birthday Message")
                {
                    ApplicationArea = Basic;
                }
                field("Membership Anniversary"; rec."Membership Anniversary")
                {
                    ApplicationArea = Basic;
                }
                field("Junior Birthday Message"; rec."Junior Birthday Message")
                {
                    ApplicationArea = Basic;
                }
                field("Loan SMS Suffix"; rec."Loan SMS Suffix")
                {
                    ApplicationArea = Basic;
                }
                field("Disable Salary SMS"; rec."Disable Salary SMS")
                {
                    ApplicationArea = Basic;
                }

                field("Control FOSA Posting"; rec."Control FOSA Posting")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Credit Set-Up")
            {
                field("Disable Loan SMS"; rec."Disable Loan SMS")
                {
                    ApplicationArea = Basic;
                }
                field("Loan SMS Charge"; rec."Loan SMS Charge")
                {
                    ApplicationArea = Basic;
                    Caption = 'Global SMS Charges';
                }
                field("Days for Checkoff"; rec."Days for Checkoff")
                {
                    ApplicationArea = Basic;
                }
                field("Dormant Account Activation Fee"; rec."Dormant Account Activation Fee")
                {
                    ApplicationArea = Basic;

                }
                field("ATM RePIN"; Rec."ATM RePIN")
                {
                    ApplicationArea = Basic;

                }
                field("Mobile Banking PIN Reset"; Rec."Mobile Banking PIN Reset")
                {

                }
                field("Closure Account Fee"; Rec."Closure Account Fee")
                {
                    ApplicationArea = Basic;
                }

                field("Risk Account Closure Fee"; Rec."Risk Account Closure Fee")
                {

                }
                field("Defaulter Notice Period"; rec."Defaulter Notice Period")
                {
                    ApplicationArea = Basic;
                }
                field("Guarantors Multiplier"; rec."Guarantors Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Max Major Loans To Guarantee"; rec."Max Major Loans To Guarantee")
                {
                    ApplicationArea = Basic;
                }
                field("Max Minor Loans To Guarantee"; rec."Max Minor Loans To Guarantee")
                {
                    ApplicationArea = Basic;
                }
                field("Max Loans To Guarantee"; rec."Max Loans To Guarantee")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Amount to Guarantee"; rec."Maximum Amount to Guarantee")
                {
                    ApplicationArea = Basic;
                }
                field("Self Deposits(As Guarantor)"; rec."Self Deposits(As Guarantor)")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Loan Grace Period"; Rec."Max. Loan Grace Period")
                { ApplicationArea = Basic; }
                // field("Bill Account"; rec."Bill Account")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Block Account for Ext.  Loan"; rec."Block Account for Ext.  Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Name"; rec."Insurance Name")
                {
                    ApplicationArea = Basic;
                }
                field("Sink Fund Process Charge"; rec."Sink Fund Process Charge")
                {
                    Caption = 'BBF Process Charge';
                    ApplicationArea = Basic;
                }

                field("Boosting Maturity"; rec."Boosting Maturity")
                {
                    ApplicationArea = Basic;
                }
                field("Boosting Shares %"; rec."Boosting Shares %")
                {
                    ApplicationArea = Basic;
                }
                field("Share Boost GL"; rec."Share Boost GL")
                {
                    ApplicationArea = Basic;
                }
                field("Self Guarantee %"; rec."Self Guarantee %")
                {
                    ApplicationArea = Basic;
                    Caption = 'One month % Self Guarantee Deposit';
                }
                field("Maximum Discounting %"; rec."Maximum Discounting %")
                {
                    ApplicationArea = Basic;
                }
                field("Special Charge on Loans GL"; rec."Special Charge on Loans GL")
                {
                    ApplicationArea = Basic;
                }
                field("Enforce Picture & Signature"; rec."Enforce Picture & Signature")
                {
                    ApplicationArea = Basic;
                }
                field("Unloged Claims Account"; rec."Unloged Claims Account")
                {
                    ApplicationArea = Basic;
                }
                field("BBF Claim %"; rec."BBF Claim %")
                {
                    ApplicationArea = Basic;
                }
                field("Benevolent Claim Account"; rec."Benevolent Claim Account")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Claim G\L"; Rec."Risk Claim G\L")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Vendor Payable Acc."; Rec."Risk Vendor Payable Acc.")
                {
                    ApplicationArea = Basic;
                }

                field("Allowed Loan Categories"; rec."Allowed Loan Categories")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed Loan Cat Billing"; rec."Allowed Loan Cat Billing")
                {
                    ApplicationArea = Basic;
                    Caption = 'Allowed Loan Billing Category';
                }
                field("Statement Limit Period"; rec."Statement Limit Period")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Valuation Period"; rec."Maximum Valuation Period")
                {
                    ApplicationArea = Basic;
                }
                field("KMRC Rate"; rec."KMRC Rate")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Minimum"; Rec."FOSA Minimum")
                {
                    ApplicationArea = Basic;
                }
                field("Mortgage Loan Vendor A/C"; rec."Mortgage Loan Vendor A/C")
                {
                    ApplicationArea = Basic;
                }
                field("Shamba Loan Vendor A/C"; rec."Shamba Loan Vendor A/C")
                {
                    ApplicationArea = Basic;
                }
                field("Mortgage FOSA Min Balance"; rec."Mortgage FOSA Min Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum No of Group Members"; rec."Minimum No of Group Members")
                {
                    ApplicationArea = Basic;
                }
                field("Surety Notice Period"; Rec."Surety Notice Period")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff Cuttoff Day"; Rec."Checkoff Cuttoff Day")
                {
                }

                field("Excempt Charges Expiry Date"; Rec."Excempt Charges Expiry Date")
                { }

            }
            group("Delegates Management")
            {
                field("Min. Delegates deposit"; rec."Min. Delegates deposit")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Delegate Membership Period"; rec."Min.Delegate Membership Period")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Delegates Share Capital"; rec."Min. Delegates Share Capital")
                {
                    ApplicationArea = Basic;
                }
                field("Requires Salary Processing"; rec."Requires Salary Processing")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Period"; rec."Salary Period")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Bank Transfer")
            {
                Caption = 'Bank Transfer and ATM Management';
                field(Reference; rec.Reference)
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card No Characters"; rec."ATM Card No Characters")
                {
                    ApplicationArea = Basic;
                }
                field("POS Bank Account"; rec."POS Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Settlement Account"; rec."ATM Settlement Account")
                {
                    ApplicationArea = Basic;
                }
                field("VISA Settlement Account"; rec."VISA Settlement Account")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Leaf Limit"; rec."Minimum Leaf Limit")
                {
                    ApplicationArea = Basic;
                    Caption = 'Minimum Leaf Limit Bankers Cheque';
                }
            }
            group("BDE Setup")
            {
                Caption = 'BDE Setup';
                field("BDE Loan Comission"; rec."BDE Loan Comission")
                {
                    ApplicationArea = Basic;
                }
                field("BDE Loan Above Target"; rec."BDE Loan Above Target")
                {
                    ApplicationArea = Basic;
                }
                field("BDE ATM Comission"; rec."BDE ATM Comission")
                {
                    ApplicationArea = Basic;
                }
                field("BDE New Member Comission"; rec."BDE New Member Comission")
                {
                    ApplicationArea = Basic;
                }
                field("BDE Salary Account Commision"; rec."BDE Salary Account Commision")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Ageny Banking")
            {
                Caption = 'Ageny Banking';
                field("Agency No Series"; rec."Agency No Series")
                {
                    ApplicationArea = Basic;
                }
                field("Agency Control Account"; rec."Agency Control Account")
                {
                    ApplicationArea = Basic;
                }
                field("Agency Expense Account"; rec."Agency Expense Account")
                {
                    ApplicationArea = Basic;
                }
                field("Agency Posting Template"; rec."Agency Posting Template")
                {
                    ApplicationArea = Basic;
                }
                field("Agency Posting Batch"; rec."Agency Posting Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Commission Account"; rec."Sacco Commission Account")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor Commission Account"; rec."Vendor Commission Account")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Store Requisition")
            {
                Caption = 'Store Requisition';
                field("Max Store Open Documents"; rec."Max Store Open Documents")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Sky Web Portal")
            {
                field("PDF B64 Folder"; rec."PDF B64 Folder")
                {
                    ApplicationArea = Basic;
                }
                field("Password History Limit"; rec."Password History Limit")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Sky Mobile Setup")
            {
                field("Sky Mobile Next Run Date"; rec."Sky Mobile Next Run Date")
                {
                    ApplicationArea = Basic;
                }
            }
            group("NCBA Setup")
            {
                field("NCBA Account Type"; Rec."NCBA Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("NCBA Account No"; Rec."NCBA Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("NCBA Account Name"; Rec."NCBA Account Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("NCBA Transaction Type"; Rec."NCBA Transaction Type")
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
        //OnAccesRestrictView();
    end;


    procedure OnAccesRestrictView()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestrictViewTxt: label 'You do Not have Permission on View,Read,Modify on this Page. Contact system administrator for assistance. %1-%2';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("Edit Setup", true);
        ChangePermission.SetRange("Function Extended", ChangePermission."function extended"::Administrator);
        if not ChangePermission.Find('-') then begin
            Error(ErrorOnRestrictViewTxt, UserId, rec.TableCaption);
        end;
    end;
}