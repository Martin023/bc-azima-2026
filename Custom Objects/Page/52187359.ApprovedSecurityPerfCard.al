page 52187359 "Approved Security Perf. Card"
{
    ApplicationArea = All;
    Caption = 'Approved Security Perf. Card';
    PageType = Card;
    SourceTable = "Security Perfection";
    SourceTableView = WHERE ("Status" = CONST(Approved));
    
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
                field("Security No."; Rec."Security No.")
                {
                    ToolTip = 'Specifies the value of the Security No. field.';
                }
                field("Property No."; Rec."Property Number")
                {
                    ToolTip = 'Specifies the value of the Property No. field.';
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
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of the Loan No. field.';
                    Editable = false;
                }
                // field("Loan Type"; Rec."Loan Type")
                // {
                //     ToolTip = 'Specifies the value of the Loan Type field.';
                //     Editable = False;
                // }
                field("Loan Name"; Rec."Loan Name")
                {
                    ToolTip = 'Specifies the value of the Loan Name field.';
                    Editable = False;
                }
                field("Collateral Types"; Rec."Collateral Types")
                {
                    ToolTip = 'Specifies the value of the Collateral Types field.';
                }
                field("Relevant Consents"; Rec."Relevant Consents")
                {
                    ToolTip = 'Specifies the value of the Relevant Consents field.';
                }
                field("Others"; Rec."Others")
                {
                    ToolTip = 'Specifies the value of the Others field.';
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    ToolTip = 'Specifies the value of the Charge Type field.';
                }
                field("Date of Issuance Instructions"; Rec."Date of Issuance Instructions")
                {
                    ToolTip = 'Specifies the value of the Date of Issuance of Instructions field.';
                }
                field("Law Firm Hanlding the Matter"; Rec."Law Firm Hanlding the Matter")
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
                // field(Remarks; Rec.Remarks)
                // {
                //     ToolTip = 'Specifies the value of the Remarks field.';
                // }
                field("Valuation Comments"; Rec."Valuation Comments")
                {
                    Tooltip = 'Specifies the value of the Valuation Comments field.';
                }
                field("Branch Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Branch Code field.';
                    Editable = false;
                }
                field("Activity Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Activity Code field.';
                    Editable = false;
                }
                field("Status"; Rec."Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
                Field("Perfected"; Rec."Perfected")
                {
                    ToolTip = 'Specifies the value of the Perfected field.';
                    Editable = false;
                }
                field("Perfected By"; Rec."Perfected By")
                {
                    ToolTip = 'Specifies the value of the Perfected By field.';
                    Editable = false;
                }
                field("Discharged"; Rec."Discharged")
                {
                    Editable = false;
                }
                field("Discharged On"; Rec."Discharged On")
                {
                    Editable = false;
                }
                field("Created at"; Rec."Created at")
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created by")
                {
                    Editable = false;
                }
            }
        }  
    }
    actions
    {
        area(Creation)
        {
            action("Send for Approval")
            {
                ApplicationArea = All;
                Caption = 'Send for Approval';
                Promoted = true;
                PromotedCategory = Process;
        
                trigger OnAction()
                begin

                    //Rec.Testfield("Status");
                    //Rec.TestField("Perfected");

                    Rec."Status" := Rec."Status"::"Pending";
                    Rec.Modify;
                    MESSAGE('File Sent for Approval');
                end;
            }
            action("Cancel")
            {
                ApplicationArea = All;
                Caption = 'Cancel';
                Promoted = true;
                PromotedCategory = Process;
                Image = Cancel;
                trigger OnAction()
                begin

                    //Rec.Testfield("Status");
                    //Rec.TestField("Perfected");

                    Rec."Status" := Rec."Status"::"Rejected";
                    Rec.Modify;
                    MESSAGE('File Cancelled');
                end;
            }
            action("Instruction Template")
            {
                ApplicationArea = All;
                Caption = 'Instruction Template';
                Promoted = true;
                PromotedCategory = Report;
                Image = Template;
                trigger OnAction()
                begin
                    SecurityPerfection.RESET;
                    SecurityPerfection.SETRANGE("No.", Rec."No.");
                    SecurityPerfection.SetRange("No.", Rec."Security No.");
                    if SecurityPerfection.Find('-') then
                    begin
                        Report.Run(Report::"Instruction Template - Perfc",true,false,SecurityPerfection);
                    end;

                end;
            }
            action("Return to Credit")
            {
                ApplicationArea = All;
                Caption = 'Return to Credit';
                Promoted = true;
                PromotedCategory = Process;
                Image = Return;
                trigger OnAction()
                begin

                    Rec.Testfield("Status");
                    Rec.TestField("Perfected");
                    
                    Rec."Status" := Rec."Status"::"At Credit";

                    SecuritiesRegister.Reset();
                    SecuritiesRegister.SetRange("No.", Rec."Security No.");
                    if SecuritiesRegister.Find('-') then
                    begin
                        SecuritiesRegister.Init();
                        SecuritiesRegister.Modify();
                        SecuritiesRegister."Collateral Perfected" := true
                    end;

                    Rec.Modify;
                    MESSAGE('File Sent to Credit');
                end;
            }
            action("Perfect Security")
            {
                ApplicationArea = All;
                Caption = 'Perfect Security';
                Promoted = true;
                PromotedCategory = Process;
                Image = Check;

                trigger onAction()
                begin

                    Rec.TestField("No.");
                    Rec.TestField("Security No.");
                    // Rec.TestField("Member No.");
                    // Rec.TestField("Member Name");
                    // Rec.TestField("Loan No.");
                    // Rec.TestField("Loan Type");
                    // Rec.TestField("Loan Name");
                    Rec.TestField("Collateral Types");
                    Rec.TestField("Relevant Consents");
                    // Rec.TestField("Date of Issuance Instructions");
                    // Rec.TestField("Law Firm Hanlding the Matter");
                    // Rec.TestField("Fees Payable to the firm");
                    //Rec.TestField("Status of the Fees");
                    //Rec.TestField("Remarks");
                    Rec.TestField("Valuation Comments");
                    Rec.TestField(Status);
                    

                    Rec."Status" := Rec."Status"::"Completed";
                    Rec."Perfected" := true;
                    Rec."Perfected By" := UserId;
                    Rec.Modify;
                    MESSAGE('Security Perfected');
                end;
            }
            action("Discharge Security")
            {
                ApplicationArea = All;
                Caption = 'Discharge Security';
                Promoted = true;
                PromotedCategory = Process;
                Image = Delete;
                trigger OnAction()
                begin

                    Rec.Testfield("Status");
                    Rec.TestField("Perfected");

                    //Rec."Status" := Rec."Status"::"Discharged";
                    Rec."Collateral Status" := Rec."Collateral Status"::"Discharged";
                    Rec."Discharged" := true;
                    Rec."Discharged On" := CURRENTDATETIME;
                    Rec."Discharged By" := UserId;
                    Rec.Modify;
                    MESSAGE('Security Discharged');
                end;
            }
        }    
    }
    
    trigger OnOpenPage();
    begin
        if UserSetup.Get(Rec."Created By") then begin
        UserSetup.TestField(UserSetup."Global Dimension 1 Code");
        UserSetup.TestField(UserSetup."Global Dimension 2 Code");
        Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        Rec."Responsibility Center" := UserSetup."Responsibility Centre";

        
        end;
        //Rec.Modify;
        Rec."Created By" := UserId;
        Rec."Perfected By" := UserId;
    end; 

    Var
    UserSetup: Record "User Setup";
    SecuritiesRegister: Record "Securities Register";
    SecurityPerfection: Record "Security Perfection";
}
                

