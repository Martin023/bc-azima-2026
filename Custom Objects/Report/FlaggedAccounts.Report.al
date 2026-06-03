#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006
Report 52185503 "Flagged Accounts"
{
    Caption = 'Flagged Accounts';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/FlaggedAccounts.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Comments; Comments)
        {
            DataItemTableView = WHERE(Types = CONST("Member Flagging"), "Disable Flag" = CONST(false));
            RequestFilterFields = "Header No.", Date, "Commented By", "Responsibility Center", "Global Dimension 1 Code", "Global Dimension 2 Code", "Expires At";
            
            column(ReportForNavId_1; 1)
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(MemberAccountNo; "Header No.")
            {
            }
            column(FlagReason; Comment)
            {
            }
            column(FlaggedBy; "Commented By")
            {
            }
            column(FlagDate; Date)
            {
            }
            column(ExpiresAt; "Expires At")
            {
            }
            column(Branch; "Global Dimension 1 Code")
            {
            }
            column(Department; "Global Dimension 2 Code")
            {
            }
            column(ResponsibilityCenter; "Responsibility Center")
            {
            }
            column(DisableFlag; "Disable Flag")
            {
            }
            column(LastModifiedBy; "Last Modified By")
            {
            }
            column(LastModifiedAt; "Last Modified At")
            {
            }
            column(DaysSinceFlagged; DaysSinceFlagged)
            {
            }
            column(FlagStatus; FlagStatus)
            {
            }
            column(DaysUntilExpiry; DaysUntilExpiry)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(ShowExpiredFlags; ShowExpiredFlags)
            {
            }
            column(ShowMemberDetails; ShowMemberDetails)
            {
            }
            column(GroupByBranch; GroupByBranch)
            {
            }
            
            dataitem(Members; Members)
            {
                DataItemLink = "No." = FIELD("Header No.");
                
                column(ReportForNavId_2; 2)
                {
                }
                column(MemberName; Name)
                {
                }
                column(FirstName; "First Name")
                {
                }
                column(MiddleName; "Middle Name")
                {
                }
                column(OtherNames; "Other Names")
                {
                }
                column(IDNumber; "Primary Identification")
                {
                }
                column(IDType; "Primary Identification Type")
                {
                }
                column(PhoneNumber; "Phone No.")
                {
                }
                column(MemberStatus; Status)
                {
                }
                column(MemberSubStatus; Subflag)
                {
                }
                column(MemberClass; "Member Class")
                {
                }
                column(AccountType; "Account Type")
                {
                }
                column(CurrentAddress; "Current Address")
                {
                }
                column(FullMemberName; FullMemberName)
                {
                }
                
                trigger OnAfterGetRecord()
                begin
                    FullMemberName := "First Name" + ' ' + "Other Names" + ' ' + "Middle Name";
                    FullMemberName := DelChr(FullMemberName, '<>', ' ');
                end;
            }
            
            trigger OnAfterGetRecord()
            begin
                DaysSinceFlagged := Today - DT2Date(Date);
                
                if "Expires At" <> 0D then begin
                    if "Expires At" < Today then begin
                        FlagStatus := 'Expired';
                        DaysUntilExpiry := 0;
                    end else begin
                        FlagStatus := 'Active';
                        DaysUntilExpiry := "Expires At" - Today;
                    end;
                end else begin
                    FlagStatus := 'Active - No Expiry';
                    DaysUntilExpiry := 0;
                end;
                
                if not ShowExpiredFlags then
                    if (FlagStatus = 'Expired') then
                        CurrReport.Skip();
            end;
            
            trigger OnPreDataItem()
            begin
                if not ShowExpiredFlags then
                    SetFilter("Expires At", '%1|>%2', 0D, Today);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Report Options';
                    
                    field(ShowExpiredFlags; ShowExpiredFlags)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Expired Flags';
                        ToolTip = 'Include flags that have passed their expiry date';
                    }
                    
                    field(ShowMemberDetails; ShowMemberDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Full Member Details';
                        ToolTip = 'Show complete member information including ID, phone, and status details';
                    }
                    
                    field(GroupByBranch; GroupByBranch)
                    {
                        ApplicationArea = All;
                        Caption = 'Group by Branch';
                        ToolTip = 'Group flagged accounts by branch (Global Dimension 1)';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        FullMemberName: Text[200];
        DaysSinceFlagged: Integer;
        FlagStatus: Text[30];
        DaysUntilExpiry: Integer;
        ShowExpiredFlags: Boolean;
        ShowMemberDetails: Boolean;
        GroupByBranch: Boolean;
}