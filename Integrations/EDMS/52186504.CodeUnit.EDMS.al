codeunit 52186504 "EDMS Integration"
{
    procedure ArchiveMemberFiles(MemberApplicationNumber: Text) Response: Text
    var
        Member: Record Members;

        MemberApplication: Record "Member Application";
        CRMMemberEdit: Record "CRM Member Edit";
        MSmartMemberEdit: Record "M-Smart Member Edit";
        LoanApplication: Record Loans;
        MemberWithdrawalApplication: Record "Member withdrawal Notice";
        SinkFundApplication: Record "SinkFund Report Information";
        LoanGuarantorSubstitution: Record "Guarantors Substitution";
        SavingsAccountApplication: Record "Savings Account Application";
        Variations: Record "Product Variations";
        ShareCapitalTransfer: Record "Share Capital Transfer Buffer";
        MBWhitelist: Record "M-Banking Whitelist App";

        EDMSScannedLog: Record "EDMS Scanned Apps. Log";

        TypeOfApplication: Text;
    begin
        TypeOfApplication := 'Application';

        MemberApplication.Reset;
        MemberApplication.SetRange("No.", MemberApplicationNumber);

        // if not MemberApplication.FindFirst then begin
        //     MemberApplication.Reset;
        //     MemberApplication.SetRange("CRM Application No.", MemberApplicationNumber);
        // end;

        if MemberApplication.FindFirst then begin
            TypeOfApplication := 'MA';

            Response += '<ArchiveMemberFilesResponse>';

            if MemberApplication."Primary Identification Type" = MemberApplication."Primary Identification Type"::"ID Number" then begin
                Response += '<IDNumber>' + MemberApplication."Primary Identification" + '</IDNumber>';
            end else begin
                if MemberApplication."Secondary Identification Type" = MemberApplication."Secondary Identification Type"::"ID Number" then begin
                    Response += '<IDNumber>' + MemberApplication."Secondary Identification" + '</IDNumber>';
                end else begin
                    Response += '<IDNumber>' + MemberApplication."Primary Identification" + '</IDNumber>';
                end;
            end;

            Response += '<PFNumber>' + MemberApplication."Payroll/Staff No." + '</PFNumber>';
            Response += '<MemberName>' + MemberApplication.Name + '</MemberName>';

            MemberApplication.CalcFields("Member No.");
            if MemberApplication."Member No." = '' then begin
                Response += '<MemberNumber>' + MemberApplication."No." + '</MemberNumber>';
            end else begin
                Response += '<MemberNumber>' + MemberApplication."Member No." + '</MemberNumber>';
            end;

            Response += '<TypeOfApplication>' + TypeOfApplication + '</TypeOfApplication>';

            Response += '</ArchiveMemberFilesResponse>';

        end else begin
            Member.Reset;

            CRMMemberEdit.Reset;
            CRMMemberEdit.SetRange("No.", MemberApplicationNumber);
            if CRMMemberEdit.FindFirst then begin
                Member.SetRange("No.", CRMMemberEdit."Member No.");
                TypeOfApplication := 'ME';
            end;

            MSmartMemberEdit.Reset;
            MSmartMemberEdit.SetRange("No.", MemberApplicationNumber);
            if MSmartMemberEdit.FindFirst then begin
                Member.SetRange("No.", MSmartMemberEdit."Member No.");
                TypeOfApplication := 'ME';
            end;

            LoanApplication.Reset;
            LoanApplication.SetRange("Loan No.", MemberApplicationNumber);
            if LoanApplication.FindFirst then begin
                Member.SetRange("No.", LoanApplication."Member No.");
                TypeOfApplication := 'LA';
            end;

            MemberWithdrawalApplication.Reset;
            MemberWithdrawalApplication.SetRange("No.", MemberApplicationNumber);
            if MemberWithdrawalApplication.FindFirst then begin
                Member.SetRange("No.", MemberWithdrawalApplication."Member No.");
                TypeOfApplication := 'MW';
            end;

            SinkFundApplication.Reset;
            SinkFundApplication.SetRange(No, MemberApplicationNumber);
            if SinkFundApplication.FindFirst then begin
                Member.SetRange("No.", SinkFundApplication."Member No");
                TypeOfApplication := 'BBF';
            end;

            LoanGuarantorSubstitution.Reset;
            LoanGuarantorSubstitution.SetRange("No.", MemberApplicationNumber);
            if LoanGuarantorSubstitution.FindFirst then begin
                Member.SetRange("No.", LoanGuarantorSubstitution."Member No.");
                TypeOfApplication := 'LGS';
            end;

            SavingsAccountApplication.Reset;
            SavingsAccountApplication.SetRange("No.", MemberApplicationNumber);
            if SavingsAccountApplication.FindFirst then begin
                Member.SetRange("No.", SavingsAccountApplication."Member No.");
                TypeOfApplication := 'SA';
            end;

            Variations.Reset;
            Variations.SetRange("No.", MemberApplicationNumber);
            if Variations.FindFirst then begin
                Member.SetRange("No.", Variations."Member No.");
                TypeOfApplication := 'VR';
            end;

            ShareCapitalTransfer.Reset;
            ShareCapitalTransfer.SetRange("Document No", MemberApplicationNumber);
            if ShareCapitalTransfer.FindFirst then begin
                Member.SetRange("No.", ShareCapitalTransfer."Source Member No");
                TypeOfApplication := 'ST';
            end;

            MBWhitelist.Reset;
            MBWhitelist.SetRange("No.", MemberApplicationNumber);
            if MBWhitelist.FindFirst then begin
                Member.SetRange("No.", MBWhitelist."Member No.");
                TypeOfApplication := 'MBW';
            end;

            // CRM Parcels and Cases
            if not Member.HasFilter then begin
                ResponseData := CRMFunctions.CRMGetCaseDetails(MemberApplicationNumber);
                if ResponseData.IsObject then begin
                    // {
                    //     "casetitle": "Arrears deducted erroneously.",
                    //     "caseno": "CRMCASE29",
                    //     "membername": "JAMES NYAMAHI MUGANDAH",
                    //     "memberno": "071695",
                    //     "category": "Service Related Complain",
                    //     "subcategory": "Refunds",
                    //     "department": "FINANCE",
                    //     "origin": "WhatsApp",
                    //     "originatingbranch": "UPPERHILL",
                    //     "description": "Erroneous deduction of arrears amounts."
                    // }
                    ResponseData.AsObject.Get('memberno', CRMMemberNo);

                    Member.SetRange("No.", CRMMemberNo.AsValue.AsText);
                    TypeOfApplication := 'CRM_CASE';
                end else begin
                    ResponseData := CRMFunctions.CRMGetParcelDetails(MemberApplicationNumber);
                    if ResponseData.IsObject then begin
                        // {
                        //     "sourcetype": "Individual",
                        //     "membername": "ESTHER OMBAJO MALO",
                        //     "memberno": "026222",
                        //     "corporatename": null,
                        //     "parceltype": "Payments",
                        //     "datereceived": "2024-03-20T05:00:00Z",
                        //     "description": "TGH",
                        //     "receivedby": "MNS CE Test User 2",
                        //     "followupdepartment": "CUSTOMER CARE",
                        //     "parcelno": "CRMPR1"
                        // }
                        ResponseData.AsObject.Get('memberno', CRMMemberNo);

                        Member.SetRange("No.", CRMMemberNo.AsValue.AsText);
                        TypeOfApplication := 'CRM_PARCEL';
                    end;
                end;
            end;

            if Member.HasFilter and Member.FindFirst then begin
                // <ArchiveMemberFilesResponse>
                //     <IDNumber>string</IDNumber>
                //     <PFNumber>string</PFNumber>
                //     <MemberName>string</MemberName>
                //     <MemberNumber>string</MemberNumber>
                //     <TypeOfApplication>string</TypeOfApplication>
                // </ArchiveMemberFilesResponse>
                Response += '<ArchiveMemberFilesResponse>';

                if Member."Primary Identification Type" = Member."Primary Identification Type"::"ID Number" then begin
                    Response += '<IDNumber>' + Member."Primary Identification" + '</IDNumber>';
                end else begin
                    if Member."Secondary Identification Type" = Member."Secondary Identification Type"::"ID Number" then begin
                        Response += '<IDNumber>' + Member."Secondary Identification" + '</IDNumber>';
                    end else begin
                        Response += '<IDNumber>' + Member."Primary Identification" + '</IDNumber>';
                    end;
                end;

                Response += '<PFNumber>' + Member."Payroll/Staff No." + '</PFNumber>';
                Response += '<MemberName>' + Member.Name + '</MemberName>';
                Response += '<MemberNumber>' + Member."No." + '</MemberNumber>';
                Response += '<TypeOfApplication>' + TypeOfApplication + '</TypeOfApplication>';

                Response += '</ArchiveMemberFilesResponse>';
            end else begin
                Error('Application with the number %1 NOT found', MemberApplicationNumber);

                // Response += '<ArchiveMemberFilesResponse>';

                // Response += '<IDNumber>' + MemberApplicationNumber + '</IDNumber>';

                // Response += '<PFNumber>' + MemberApplicationNumber + '</PFNumber>';
                // Response += '<MemberName>' + MemberApplicationNumber + '</MemberName>';
                // Response += '<MemberNumber>' + MemberApplicationNumber + '</MemberNumber>';
                // Response += '<TypeOfApplication>Application</TypeOfApplication>';

                // Response += '</ArchiveMemberFilesResponse>';
            end;
        end;

        // EDMS
        EDMSScannedLog.Reset;
        EDMSScannedLog.SetRange("Application No.", MemberApplicationNumber);

        if EDMSScannedLog.FindFirst then begin
            EDMSScannedLog.Scanned := true;
            EDMSScannedLog.Modify;
        end;

        exit(Response);
    end;

    procedure LoanFiles(ApplicationNumber: Text) Response: Text
    var
        Loan: Record Loans;
        BLA: Record "B/S Loan Account Application";
        Member: Record Members;

        EDMSScannedLog: Record "EDMS Scanned Apps. Log";
    begin
        Loan.Reset;
        Loan.SetRange("Loan No.", ApplicationNumber);

        if Loan.FindFirst then begin
            // <BusinessLoanFilesResponse>
            //     <IDNumber>string</IDNumber>
            //     <AccountType>string</AccountType>
            //     <ClientName>string</ClientName>
            //     <AccountNumber>string</AccountNumber>
            // </BusinessLoanFilesResponse>

            Response += '<LoanFilesResponse>';

            Member.Reset;
            Member.SetRange("No.", Loan."Member No.");

            if Member.FindFirst then begin
                if (Member."Primary Identification Type" = Member."Primary Identification Type"::"ID Number") then begin
                    Response += '<IDNumber>' + Member."Primary Identification" + '</IDNumber>';
                end else
                    if (Member."Secondary Identification Type" = Member."Secondary Identification Type"::"ID Number") then begin
                        Response += '<IDNumber>' + Member."Secondary Identification" + '</IDNumber>';
                    end else begin
                        Response += '<IDNumber>' + Member."Primary Identification" + '</IDNumber>';
                    end;
            end else begin
                Response += '<IDNumber></IDNumber>';
            end;

            Response += '<AccountType>' + Loan."Loan Product Type Name" + '</AccountType>';
            Response += '<ClientName>' + Loan."Member Name" + '</ClientName>';
            Response += '<AccountNumber>' + Loan."Loan No." + '</AccountNumber>';
            Response += '</LoanFilesResponse>';
        end else begin
            BLA.Reset;
            BLA.SetRange("No.", ApplicationNumber);

            if BLA.FindFirst then begin
                // <BusinessLoanFilesResponse>
                //     <IDNumber>string</IDNumber>
                //     <AccountType>string</AccountType>
                //     <ClientName>string</ClientName>
                //     <AccountNumber>string</AccountNumber>
                // </BusinessLoanFilesResponse>
                BLA.CalcFields(Name);

                Response += '<LoanFilesResponse>';

                if Member.FindFirst then begin
                    if (Member."Primary Identification Type" = Member."Primary Identification Type"::"ID Number") then begin
                        Response += '<IDNumber>' + Member."Primary Identification" + '</IDNumber>';
                    end else
                        if (Member."Secondary Identification Type" = Member."Secondary Identification Type"::"ID Number") then begin
                            Response += '<IDNumber>' + Member."Secondary Identification" + '</IDNumber>';
                        end else begin
                            Response += '<IDNumber>' + Member."Primary Identification" + '</IDNumber>';
                        end;
                end else begin
                    Response += '<IDNumber></IDNumber>';
                end;

                Response += '<AccountType>BUSINESS LOAN</AccountType>';
                Response += '<ClientName>' + BLA.Name + '</ClientName>';
                Response += '<AccountNumber>' + BLA."No." + '</AccountNumber>';
                Response += '</LoanFilesResponse>';
            end else begin
                Error('Business Loan application with given number %1 NOT found', ApplicationNumber);
            end;

            Error('Loan application with given number %1 NOT found', ApplicationNumber);
        end;

        // EDMS
        EDMSScannedLog.Reset;
        EDMSScannedLog.SetRange("Application No.", ApplicationNumber);

        if EDMSScannedLog.FindFirst then begin
            EDMSScannedLog.Scanned := true;
            EDMSScannedLog.Modify;
        end;

        exit(Response);
    end;

    procedure BusinessLoanFiles(ApplicationNumber: Text) Response: Text
    var
        BLA: Record "B/S Loan Account Application";
        Member: Record Members;
    begin
        BLA.Reset;
        BLA.SetRange("No.", ApplicationNumber);

        if BLA.FindFirst then begin
            // <BusinessLoanFilesResponse>
            //     <IDNumber>string</IDNumber>
            //     <AccountType>string</AccountType>
            //     <ClientName>string</ClientName>
            //     <AccountNumber>string</AccountNumber>
            // </BusinessLoanFilesResponse>
            BLA.CalcFields(Name);

            Response += '<BusinessLoanFilesResponse>';

            if Member.FindFirst then begin
                if (Member."Primary Identification Type" = Member."Primary Identification Type"::"ID Number") then begin
                    Response += '<IDNumber>' + Member."Primary Identification" + '</IDNumber>';
                end else
                    if (Member."Secondary Identification Type" = Member."Secondary Identification Type"::"ID Number") then begin
                        Response += '<IDNumber>' + Member."Secondary Identification" + '</IDNumber>';
                    end else begin
                        Response += '<IDNumber>' + Member."Primary Identification" + '</IDNumber>';
                    end;
            end else begin
                Response += '<IDNumber></IDNumber>';
            end;

            Response += '<AccountType></AccountType>';
            Response += '<ClientName>' + BLA.Name + '</ClientName>';
            Response += '<AccountNumber>' + BLA."No." + '</AccountNumber>';
            Response += '</BusinessLoanFilesResponse>';
        end else begin
            Error('Business Loan application with given number %1 NOT found', ApplicationNumber);
        end;

        exit(Response);
    end;

    procedure SkyCallback(ApplicationNumber: Text; IsScanned: Text) Response: Text
    var
        EDMSLogs: Record "EDMS Scanned Apps. Log";
    begin

        EDMSLogs.SetRange("Application No.", ApplicationNumber);

        if EDMSLogs.FindFirst then begin
            case IsScanned of
                'TRUE':
                    EDMSLogs.Scanned := true;
                'FALSE':
                    EDMSLogs.Scanned := false;
                else
                    EDMSLogs.Scanned := false;
            end;

            EDMSLogs.Modify;
        end else begin
            Error('Unknown application number = %1', ApplicationNumber);
        end;

        Response += '<CallbackResponse>';
        Response += '<ApplicationNumber>' + ApplicationNumber + '</ApplicationNumber>';
        Response += '<Message>Notification received</Message>';
        Response += '</CallbackResponse>';

        exit(Response);

    end;

    var
        LoginToken: Text;
        VendorName: Label 'Unimax';
        CRMFunctions: Codeunit "CRM Functions";
        ResponseData: JsonToken;
        CRMMemberNo: JsonToken;
}