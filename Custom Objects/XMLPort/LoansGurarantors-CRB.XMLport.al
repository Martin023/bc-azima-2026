#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185503 "Loans Gurarantors- CRB"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
        textelement(Loans_Guarantors_CRB)
        {
            tableelement("Loan Guarantors and Security"; "Loan Guarantors and Security")
            {
                XmlName = 'LoansGuarantorsCRB';
                textelement(Lendername)
                {
                }
                textelement(LendernameI)
                {
                }
                textelement(BranchCodes)
                {
                }
                textelement(BranchCodesNA)
                {
                }
                fieldelement(MemberNo; "Loan Guarantors and Security"."Member No")
                {
                }
                fieldelement(LoanNo; "Loan Guarantors and Security"."Loan No")
                {
                }
                textelement(Name)
                {
                }
                textelement(DOB)
                {
                }
                textelement(Genders)
                {
                }
                textelement(Nationality)
                {
                }
                textelement(Mstatus)
                {
                }
                textelement(Type)
                {
                }
                textelement(Locations)
                {
                }
                textelement(Performings)
                {
                }
                fieldelement(AmountGuaranteed; "Loan Guarantors and Security"."Amount Guaranteed")
                {
                }
                textelement(PID)
                {
                }
                textelement(IDNUM)
                {
                }
                textelement(SSID)
                {
                }
                textelement(SIDNUM)
                {
                }
                textelement(LocationsI)
                {
                }
                textelement(LocationsII)
                {
                }
                textelement(LocationIII)
                {
                }
                textelement(LocationsIV)
                {
                }
                textelement(LocationsV)
                {
                }
                textelement(Phone)
                {
                }
                textelement(PhoneI)
                {
                }
                textelement(PhoneII)
                {
                }
                textelement(Address)
                {
                }
                textelement(AddressI)
                {
                }
                textelement(AddressII)
                {
                }
                textelement(NationalityI)
                {
                }
                textelement(LocationsVI)
                {
                }
                textelement(LocationsVII)
                {
                }
                textelement(LocationsVIII)
                {
                }
                textelement(LocationsIX)
                {
                }
                textelement(AddressIII)
                {
                }
                textelement(NationalityII)
                {
                }

                trigger OnAfterGetRecord()
                var
                    Name: Code[60];
                    Type: Code[10];
                    title: Code[20];
                    DOB: Date;
                    GENDERS: Code[30];
                    Nationality: Code[30];
                    Mstatus: Code[10];
                    PID: Code[20];
                    IDNUM: Code[60];
                    SSID: Code[10];
                    SIDNUM: Code[60];
                    phone: Code[60];
                    Address: Code[60];
                    locations: Code[60];
                    postcode: Code[60];
                    pinnumber: Code[60];
                    email: Code[60];
                    employer: Code[60];
                    BranchCodes: Code[60];
                    Currency: Code[60];
                    acctstatus: Code[50];
                    RepaymentFrequency: Code[50];
                    security: Code[30];
                    Lendername: Code[60];
                    BranchCodesNA: Code[60];
                    category: Code[60];
                    Performings: Code[60];
                    lastpaidamount: Decimal;
                    loanproduct: Code[50];
                    OVDDATE: Date;
                begin
                    if Cust.Get("Loan Guarantors and Security"."Member No") then begin
                        Name := Cust.Name;
                        DOB := Cust."Date of Birth";
                        Nationality := 'KE';
                        PID := '001';
                        SSID := '004';
                        Lendername := 'Stima Sacco Society Ltd';
                        IDNUM := Cust."Primary Identification";
                        SIDNUM := Cust."Payroll/Staff No.";
                        phone := Cust."Phone No.";
                        Address := Cust."Current Address";
                        postcode := Cust."Post Code";
                        // pinnumber := Cust."VAT Registration No.";
                        email := Cust."E-Mail";
                        employer := Cust."Employer Code";
                        Currency := 'KES';

                        loanproduct := 'H';

                        Type := 'B';


                        RepaymentFrequency := 'M';
                        security := 'S';
                        // if Cust."Single Party/Multiple" = Cust."single party/multiple"::Single then begin
                        //     category := 'S';
                        // end else begin
                        //     category := 'J';
                        // end;

                        if Cust."Global Dimension 2 Code" = 'HEAD' then begin
                            BranchCodes := 'N131001';
                            BranchCodesNA := 'HEAD OFFICE';
                        end else
                            if Cust."Global Dimension 2 Code" = 'ELD' then begin
                                BranchCodes := 'N131002';
                                BranchCodesNA := 'ELDORET';
                            end else
                                if Cust."Global Dimension 2 Code" = 'KSM' then begin
                                    BranchCodes := 'N131003';
                                    BranchCodesNA := 'KISUMU';
                                end else
                                    if Cust."Global Dimension 2 Code" = 'MSA' then begin
                                        BranchCodes := 'N131004';
                                        BranchCodesNA := 'MOMBASA';
                                    end else
                                        if Cust."Global Dimension 2 Code" = 'NBI' then begin
                                            BranchCodes := 'N131005';
                                            BranchCodesNA := 'NAIROBI';
                                        end else
                                            if Cust."Global Dimension 2 Code" = 'NKR' then begin
                                                BranchCodes := 'N131006';
                                                BranchCodesNA := 'NAKURU';
                                            end else
                                                if Cust."Global Dimension 2 Code" = 'OLK' then begin
                                                    BranchCodes := 'N131007';
                                                    BranchCodesNA := 'OLKARIA';
                                                end;

                        if Cust.Gender = Cust.Gender::Male then begin
                            if Cust."Marital Status" = Cust."marital status"::Married then begin
                                Mstatus := 'M';
                            end else begin
                                Mstatus := 'S';
                            end;
                            title := 'Mr.';
                            GENDERS := 'M';
                        end else begin
                            if Cust."Marital Status" = Cust."marital status"::Married then begin
                                Mstatus := 'M';
                                title := 'Mrs.';
                            end else begin
                                title := 'MISS';
                                Mstatus := 'S';
                            end;
                            GENDERS := 'F';
                        end;
                    end;

                    Performings := 'C';
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    var
        Cust: Record Members;
        Vend: Record Vendor;
}
