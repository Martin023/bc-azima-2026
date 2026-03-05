page 52187353 "Security Discharge App Card"
{
    ApplicationArea = All;
    Caption = 'Security Discharge App Card';
    PageType = Card;
    SourceTable = "Security Discharge";
    PromotedActionCategories = 'Creation, New, Report , Process,Approval';
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field("Perfection No."; Rec."Perfection No.")
                {
                    ToolTip = 'Specifies the value of the Perfection No. field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.';
                    Editable = false;
                }
                // field("Loan No."; Rec."Loan No.")
                // {
                //     ToolTip = 'Specifies the value of the Loan No. field.';
                //     Editable = false;
                // }
                // field("Loan Type"; Rec."Loan Type")
                // {
                //     ToolTip = 'Specifies the value of the Loan Type field.';
                //     EDitable = false;
                // }
                // field("Loan Name"; Rec."Loan Name")
                // {
                //     ToolTip = 'Specifies the value of the Loan Name field.';
                //     Editable = false;
                // }
                field("Security No."; Rec."Security No.")
                {
                    ToolTip = 'Specifies the value of the Security No. field.';
                    Editable = false;
                }
                field("Collateral Types"; Rec."Collateral Types")
                {
                    ToolTip = 'Specifies the value of the Collateral Types field.';
                    Editable = false;

                }
                field("Collateral Value Sum"; Rec."Collateral Value Sum")
                {
                    ToolTip = 'Specifies the value of the Collateral Value Sum field.';
                    Editable = false;
                }
                // field("Valuation Comments"; Rec."Valuation Comments")
                // {
                //     ToolTip = 'Specifies the value of the Valuation Comments field.';
                // }
                field("Property Number"; Rec."Property Number")
                {
                    ToolTip = 'Specifies the value of the Property Number field.';
                    Editable = false;
                }

                field("Date of Issuance Instructions"; Rec."Date of Issuance Instructions")
                {
                    ToolTip = 'Specifies the value of the Date of Issuance of Instructions field.';
                }
                field("Law Firm Handling the Matter"; Rec."Law Firm Hanlding the Matter")
                {
                    ToolTip = 'Specifies the value of the Law Firm Hanlding the Matter field.';
                }
                field("Fees Payable to the firm"; Rec."Fees Payable to the firm")
                {
                    ToolTip = 'Specifies the value of the Fees Payable to the firm field.';
                }
                field("Status of the Fees"; Rec."Status of the Fees")
                {
                    ToolTip = 'Specifies the value of the Status of the Fees field.';
                }
      
                field("Collateral Status"; Rec."Collateral Status")
                {
                    ToolTip = 'Specifies the value of the Collateral Status field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Created at"; Rec."Created at")
                {
                    ToolTip = 'Specifies the value of the Created at field.';
                    Editable = false;
                }
                field("Created by"; Rec."Created by")
                {
                    ToolTip = 'Specifies the value of the Created by field.';
                    Editable = false;
                }
                field(Discharged; Rec.Discharged)
                {
                    ToolTip = 'Specifies the value of the Discharged field.';
                    Editable = false;
                }
                field("Discharged By"; Rec."Discharged By")
                {
                    ToolTip = 'Specifies the value of the Discharged By field.';
                    Editable = false;
                }
                field("Discharged On"; Rec."Discharged On")
                {
                    ToolTip = 'Specifies the value of the Discharged On field.';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Creation)
        {
            action(Discharge)
            {
                ApplicationArea = All;
                Caption = 'Discharge';
                Promoted = true;
                PromotedCategory = Process;
                Image = ReleaseDoc;
                trigger OnAction()
                begin
                    Rec.Discharged := true;
                    Rec."Discharged By" := USERID;
                    Rec."Discharged On" := CURRENTDATETIME;
                    Rec.Status := Rec.Status::Discharged;
                    Rec.MODIFY;
                    MESSAGE('Security Discharge has been successfully done.');
                end;
            }
            action(SendforApproval)
            {
                ApplicationArea = All;
                Caption = 'Send for Approval';
                Promoted = true;
                PromotedCategory = Category5;
                Image = SendApprovalRequest;
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Approved;
                    Rec.MODIFY;
                    MESSAGE('Security Discharge has been successfully sent for approval.');
                end;
                
            }
            action(CancelApproval)
            {
                ApplicationArea = All;
                Caption = 'Cancel Approval';
                Promoted = true;
                PromotedCategory = Category5;
                Image = CancelApprovalRequest;
                trigger OnAction()
                begin
                    //Rec.Status := Rec.Status::Created;
                    Rec.MODIFY;
                    MESSAGE('Security Discharge has been successfully cancelled.');
                end;
            }
        }

    }
}
