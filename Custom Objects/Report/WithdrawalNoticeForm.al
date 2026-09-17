report 52185562 "Withdrawal Notice Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Withdrawal Notice Form.rdl';
    Caption = 'Withdrawal Notice Form';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Members; Members)
        {
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyAddress) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CompanyEmail; CompanyEmail) { }
            column(CompanyWebsite; CompanyInfo."Home Page") { }
            
            column(PrintDate; Format(Today, 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(PrintDateTime; Format(CurrentDateTime, 0, '<Day,2>/<Month,2>/<Year4> <Hours24,2>:<Minutes,2>')) { }

            column(MemName; Name) { }
            column(MemIDNo; "Primary Identification") { }
            column(MemWNo; "Payroll/Staff No.") { }
            column(MemNo; "No.") { }
            column(MemMobile; "Phone No.") { }
            column(MemDept; "Employer Name") { }

            trigger OnPreDataItem()
            begin
                if ReqMemberNo = '' then
                    Error('Please select a member before previewing or printing.');
                    
                SetRange("No.", ReqMemberNo);
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
                group(MemberSelection)
                {
                    Caption = 'Select Member to Withdraw';
                    
                    field(ReqMemberNo; ReqMemberNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '1. Member No. / Search';
                        TableRelation = Members."No.";
                        ToolTip = 'Select the member submitting the withdrawal notice.';
                        
                        trigger OnValidate()
                        var
                            MemRec: Record Members;
                        begin
                            if ReqMemberNo <> '' then begin
                                if MemRec.Get(ReqMemberNo) then begin
                                    ReqName := MemRec.Name;
                                    ReqIDNo := MemRec."Primary Identification";
                                    ReqWNo := MemRec."Payroll/Staff No.";
                                    
                                    MemRec.CalcFields("Employer Name");
                                    ReqDept := MemRec."Employer Name";
                                end;
                            end else begin
                                ReqName := ''; 
                                ReqIDNo := ''; 
                                ReqWNo := ''; 
                                ReqDept := '';
                            end;
                        end;
                    }
                    field(ReqName; ReqName)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Name';
                        Editable = false;
                    }
                    field(ReqIDNo; ReqIDNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'ID No.';
                        Editable = false;
                    }
                    field(ReqWNo; ReqWNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'W/No (Payroll)';
                        Editable = false;
                    }
                    field(ReqDept; ReqDept)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Department/Employer';
                        Editable = false;
                    }
                }
            }
        }
        actions { }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        CompanyAddress := 'P.O BOX ' + CompanyInfo."Post Code" + ' - ' + CompanyInfo.City;
        CompanyTelephone := 'TEL: ' + CompanyInfo."Phone No." + ', ' + CompanyInfo."Phone No. 2";
        CompanyEmail := CompanyInfo."E-Mail";
    end;

    var
        CompanyInfo: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        ReqMemberNo: Code[50];
        ReqName: Text[100];
        ReqIDNo: Code[50];
        ReqWNo: Code[50];
        ReqDept: Text[100];
}