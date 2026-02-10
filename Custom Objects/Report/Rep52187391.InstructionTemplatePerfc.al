report 52187391 "Instruction Template - Perfc"
{
    ApplicationArea = All;
    Caption = 'Instruction Template - Perfc';
    UsageCategory = ReportsAndAnalysis;
    // DefaultLayout = Word;
    // WordLayout = './bc-azima-2026/Layout/Instruction Template - Perfc.docx';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Instruction Template - Perfc.rdl';
    dataset
    {

        dataitem(SecurityPerfection; "Security Perfection")
        {
            RequestFilterFields = "No.";
            //CalcFields = "Perfection Summary";
            column(CollateralStatus; "Collateral Status")
            {
            }
            //column(BigTextSummary; BigTexTSummary){}
            column(Collateral_Value_Sum; "Collateral Value Sum")
            {
            }
            column(Loan_Offer_Letter_Date; "Loan Offer Letter Date")
            {
            }
            column(CollateralTypes; "Collateral Types")
            {
            }
            column(DateofIssuanceInstructions; "Date of Issuance Instructions")
            {
            }
            // column(Discharged; Discharged)
            // {
            // }
            column(LawFirmHanldingtheMatter; "Law Firm Hanlding the Matter")
            {
            }
            column(LoanName; "Loan Name")
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(Perfection_Summary; SecurityPerfection.GetRichText(SecurityPerfection))
            {
            }
            column(Perfection_Attachements; "Perfection Attachements")
            {
            }
            column(LegalOfficer; CompanyInformation."Legal Officer Name")
            {
            }
            column(LegalOfficerTitle; CompanyInformation."Legal Officer Title")
            {
            }
            column(LegalOfficerSiganature; CompanyInformation."Legal Officer Signature")
            {
            }
            column(Law_Firm_Address; "Law Firm Address")
            {
            }
            column(Law_Firm_Physical_Address; "Law Firm Physical Address")
            {
            }
            column(Telephone; Telephone) { }
            column(Email; Email) { }
            column(Address; Address) { }
            column(MembTown; Town) { }
            dataitem(PerfectionLines; "Perfection Lines")
            {
                DataItemLinkReference = SecurityPerfection;
                //DataItemTableView = where("Loan No." = filter("Loan No."));
                DataItemLink = "Loan No." = FIELD("Loan No.");
                column(SecurityNo; PerfectionLines."Security No.") { }
                column(PropertyNo; PerfectionLines."Property No.") { }
                column(Amount_To_Charge; PerfectionLines."Amount to Charge") { }
                column(Force_Sale_Value; PerfectionLines."Forced Sale Value") { }
                column(Charge_Type; PerfectionLines."Charge Type") { }
                // trigger OnAfterGetRecord()
                // BEGIN
                //     SecurityNo := '';
                //     PropertyNo := '';
                //     Amount_To_Charge := 0;
                //     Force_Sale_Value := 0;
                //     Charge_Type := ' ';

                //     SecurityNo := PerfectionLines."Security No.";
                //     PropertyNo := PerfectionLines."Property No.";
                //     Amount_To_Charge := PerfectionLines."Amount to Charge";
                //     Force_Sale_Value := PerfectionLines."Forced Sale Value";
                //     Charge_Type := PerfectionLines."Charge Type";
                // END;
            }
            // dataitem(MembTable; Members)
            // {
            //     DataItemLink = "No." = FIELD("Member No.");
            //     column(MembNumber;MembTable."No.")
            //     {
            //     }
            //     column(MembName;MembTable."Name")
            //     {
            //     }
            //     column(MembAddress; MembTable."Home Address")
            //     {
            //     }
            //     column(MembTown; MembTable."City")
            //     {
            //     }
            //     column(MembTelephone; MembTable."Phone No.")
            //     {
            //     }
            //     column(MembEmail; MembTable."E-Mail")
            //     {
            //     }
            //     // trigger OnAfterGetRecord()
            //     // begin
            //     //     Members.RESET;
            //     //     Members.Setrange(Members."No.", SecurityPerfection."Member No.");
            //     //     if Members.FIND('-') then begin
            //     //         Telephone := Members."Phone No.";
            //     //         Email := Members."E-Mail";
            //     //         Address := Members."Home Address";
            //     //         Town := Members."City";
            //     //     end;
            //     // end;
            // }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                if Members.get(SecurityPerfection."Member No.") then begin
                    Telephone := Members."Phone No.";
                    Email := Members."E-Mail";
                    Address := Members."Home Address";
                    MembTown := Members."City";
                end;
                // SecurityPerfection.CalcFields("Perfection Summary");
                // Evaluate(BigTextSummary, FORMAT(SecurityPerfection."Perfection Summary"));
                // Message(FORMAT(BigTextSummary))
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
                CompanyInformation.CalcFields("Legal Officer Signature");
                CompanyInformation.CalcFields("CEO Signature");
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
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyInformation.CalcFields("Legal Officer Signature");
        // CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        // CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        // CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
        LegalOfficer := CompanyInformation."Legal Officer Name";
        LegalOfficerTitle := CompanyInformation."Legal Officer Title";
    end;

    // procedure GetRichText(): Text
    // var
    //     InStream: Instream;
    //     TextValue: Text;
    //     TypeHelper: Codeunit "Type Helper";
    // begin
    //     Clear(TextValue);
    //     SecurityPerfect.CalcFields(SecurityPerfect."Perfection Summary");
    //     SecurityPerfect."Perfection Summary".CreateInStream(InStream, TextEncoding::UTF8);
    //     //InStream.ReadText(TextValue);
    //     exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(Instream, TypeHelper.LFSeparator(), SecurityPerfect.FieldName(SecurityPerfect."Perfection Summary")));
    //     //exit(TextValue);
    // end;


    var
        Adress: Text[50];
        City: Text[30];
        CompanyInformation: Record "Company Information";
        Members: Record "Members";
        Town: Text[30];
        Telephone: Code[20];
        Email: Code[100];
        Address: Text[50];
        LegalOfficer: Text;
        LegalOfficerTitle: Text;
        Perfection: Record "Security Perfection";
        MembTown: Text[30];
        //SecurityRegister: Record "Securities Register";
        SecurityNo: Text;
        PropertyNo: Text;
        Amount_To_Charge: Decimal;
        Force_Sale_Value: Decimal;
        Charge_Type: Text;
        SecurityRegister: Record "Perfection Lines";
        BigTexTSummary: Bigtext;
}
