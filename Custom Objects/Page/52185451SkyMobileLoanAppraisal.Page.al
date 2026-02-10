page 52185451 "Sky Mobile Loan Appraisal"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sky Mobile Loan Appraisal";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date-Time"; Rec."Date-Time")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                // field(LastName; Rec.las)
                // {
                // }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                }
                field("Account Balance"; Rec."Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field(MBoosta; Rec.MBoosta)
                {
                    ApplicationArea = Basic;
                }
                field("MBoosta Msg"; Rec."MBoosta Msg")
                {
                    ApplicationArea = Basic;
                }
                field("Salary 1"; Rec."Salary 1")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Date 1"; Rec."Salary Date 1")
                {
                    ApplicationArea = Basic;
                }
                field("Salary 2"; Rec."Salary 2")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Date 2"; Rec."Salary Date 2")
                {
                    ApplicationArea = Basic;
                }
                field("Salary 3"; Rec."Salary 3")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Date 3"; Rec."Salary Date 3")
                {
                    ApplicationArea = Basic;
                }
                field("Salary In Advance"; Rec."Salary In Advance")
                {
                    ApplicationArea = Basic;
                }
                field("Salary In Advance Msg"; Rec."Salary In Advance Msg")
                {
                    ApplicationArea = Basic;
                }
                field("Finje Chap Chap"; Rec."Finje Chap Chap")
                {
                    ApplicationArea = Basic;
                }
                field("Finje Chap Chap Msg"; Rec."Finje Chap Chap Msg")
                {
                    ApplicationArea = Basic;
                }
                field("Jisort Advance"; Rec."Jisort Advance")
                {
                    ApplicationArea = Basic;
                }
                field("Jisort Advance Msg"; Rec."Jisort Advance Msg")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Advance"; Rec."Salary Advance")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Advance Msg"; Rec."Salary Advance Msg")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Get Lines")
            {
                ApplicationArea = Basic;
                Image = GetLines;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Success: Boolean;
                    Msg: Text;
                    LoanLimit: Decimal;
                    QualifiedAmt: Decimal;
                    TopUp: Decimal;
                    TotalLines: Integer;
                    k: Integer;
                    Salary: array[3] of Decimal;
                    SalDates: array[3] of Date;
                begin


                    dWindow.Open('Generating Entries:       #1#############');
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetFilter("Transactional Mobile No", '<>%1', '');
                    if SavingsAccounts.FindFirst then begin
                        TotalLines := SavingsAccounts.Count;
                        //\ERROR('%1',TotalLines);
                        repeat
                            TotalLines -= 1;

                            SavingsAccounts.CalcFields("Balance (LCY)");
                            if Appraisal.Get(SavingsAccounts."No.") then begin
                                Appraisal."User ID" := UserId;
                                Appraisal."Account No." := SavingsAccounts."No.";
                                Appraisal.Name := SavingsAccounts.Name;
                                Appraisal."Phone No." := SavingsAccounts."Transactional Mobile No";
                                Appraisal.Email := SavingsAccounts."E-Mail";
                                Appraisal."Member No." := SavingsAccounts."Member No.";
                                Appraisal."ID No." := SavingsAccounts."ID No.";
                                Appraisal."Account Balance" := SavingsAccounts."Balance (LCY)";
                                Appraisal."As At" := Today;
                                Appraisal."Date-Time" := CurrentDateTime;

                                MBoosta := 0;
                                ProductFactory.Get('126');
                                //SkyMbanking.MBoostaAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp);
                                MBoosta := QualifiedAmt;
                                MBoostaMsg := Msg;



                                for k := 3 downto 1 do begin
                                    Salary[k] := 0;
                                    SalDates[k] := 0D;
                                end;

                                // SalaryInAdvance := 0;
                                // ProductFactory.Get('123');
                                // SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
                                // SalaryInAdvance := QualifiedAmt;
                                // SalaryInAdvanceMsg := Msg;

                                // FinjeChapChap := 0;
                                // ProductFactory.Get('120');
                                // SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
                                // FinjeChapChap := QualifiedAmt;
                                // FinjeChapChapMsg := Msg;


                                // JisortAdvance := 0;
                                // ProductFactory.Get('121');
                                // SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
                                // JisortAdvance := QualifiedAmt;
                                // JisortAdvanceMsg := Msg;


                                // SalaryAdvance := 0;
                                // ProductFactory.Get('119');
                                // SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
                                // SalaryAdvance := QualifiedAmt;
                                // SalaryAdvanceMsg := Msg;



                                Appraisal.MBoosta := MBoosta;
                                Appraisal."MBoosta Msg" := MBoostaMsg;
                                Appraisal."Salary In Advance" := SalaryInAdvance;
                                Appraisal."Salary In Advance Msg" := SalaryInAdvanceMsg;
                                Appraisal."Finje Chap Chap" := FinjeChapChap;
                                Appraisal."Finje Chap Chap Msg" := FinjeChapChapMsg;
                                Appraisal."Jisort Advance" := JisortAdvance;
                                Appraisal."Jisort Advance Msg" := JisortAdvanceMsg;
                                Appraisal."Salary Advance" := SalaryAdvance;
                                Appraisal."Salary Advance Msg" := SalaryAdvanceMsg;

                                Appraisal."Salary 1" := Salary[1];
                                Appraisal."Salary Date 1" := SalDates[1];
                                Appraisal."Salary 2" := Salary[2];
                                Appraisal."Salary Date 2" := SalDates[2];
                                Appraisal."Salary 3" := Salary[3];
                                Appraisal."Salary Date 3" := SalDates[3];


                                Appraisal.Modify;
                                Commit;
                            end
                            else begin

                                Appraisal.Init;
                                Appraisal."User ID" := UserId;
                                Appraisal."Account No." := SavingsAccounts."No.";
                                Appraisal.Name := SavingsAccounts.Name;
                                Appraisal."Phone No." := SavingsAccounts."Transactional Mobile No";
                                Appraisal.Email := SavingsAccounts."E-Mail";
                                Appraisal."Member No." := SavingsAccounts."Member No.";
                                Appraisal."ID No." := SavingsAccounts."ID No.";
                                Appraisal."Account Balance" := SavingsAccounts."Balance (LCY)";
                                Appraisal."As At" := Today;
                                Appraisal."Date-Time" := CurrentDateTime;

                                // MBoosta := 0;
                                // ProductFactory.Get('126');
                                // SkyMbanking.MBoostaAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp);
                                // MBoosta := QualifiedAmt;
                                // MBoostaMsg := Msg;



                                // SalaryInAdvance := 0;
                                // ProductFactory.Get('123');
                                // SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
                                // SalaryInAdvance := QualifiedAmt;
                                // SalaryInAdvanceMsg := Msg;

                                // FinjeChapChap := 0;
                                // ProductFactory.Get('120');
                                // SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
                                // FinjeChapChap := QualifiedAmt;
                                // FinjeChapChapMsg := Msg;


                                // JisortAdvance := 0;
                                // ProductFactory.Get('121');
                                // SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
                                // JisortAdvance := QualifiedAmt;
                                // JisortAdvanceMsg := Msg;


                                // SalaryAdvance := 0;
                                // ProductFactory.Get('119');
                                // SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
                                // SalaryAdvance := QualifiedAmt;
                                // SalaryAdvanceMsg := Msg;



                                Appraisal.MBoosta := MBoosta;
                                Appraisal."MBoosta Msg" := MBoostaMsg;
                                Appraisal."Salary In Advance" := SalaryInAdvance;
                                Appraisal."Salary In Advance Msg" := SalaryInAdvanceMsg;
                                Appraisal."Finje Chap Chap" := FinjeChapChap;
                                Appraisal."Finje Chap Chap Msg" := FinjeChapChapMsg;
                                Appraisal."Jisort Advance" := JisortAdvance;
                                Appraisal."Jisort Advance Msg" := JisortAdvanceMsg;
                                Appraisal."Salary Advance" := SalaryAdvance;
                                Appraisal."Salary Advance Msg" := SalaryAdvanceMsg;

                                Appraisal."Salary 1" := Salary[1];
                                Appraisal."Salary Date 1" := SalDates[1];
                                Appraisal."Salary 2" := Salary[2];
                                Appraisal."Salary Date 2" := SalDates[2];
                                Appraisal."Salary 3" := Salary[3];
                                Appraisal."Salary Date 3" := SalDates[3];


                                Appraisal.Insert;
                                Commit;
                            end;
                            dWindow.Update(1, TotalLines);

                        until SavingsAccounts.Next = 0;

                    end;

                    dWindow.Close;
                end;
            }
            action("Update Selected Account")
            {
                ApplicationArea = Basic;
                Image = GetLines;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Success: Boolean;
                    Msg: Text;
                    LoanLimit: Decimal;
                    QualifiedAmt: Decimal;
                    TopUp: Decimal;
                    TotalLines: Integer;
                    Salary: array[3] of Decimal;
                    SalDates: array[3] of Date;
                begin


                    dWindow.Open('Generating Entries:       #1#############');
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetFilter("No.", Rec."Account No.");
                    if SavingsAccounts.FindFirst then begin
                        TotalLines := SavingsAccounts.Count;
                        //\ERROR('%1',TotalLines);
                        repeat
                            TotalLines -= 1;

                            SavingsAccounts.CalcFields("Balance (LCY)");
                            if Appraisal.Get(SavingsAccounts."No.") then begin
                                Appraisal."User ID" := UserId;
                                Appraisal."Account No." := SavingsAccounts."No.";
                                Appraisal.Name := SavingsAccounts.Name;
                                Appraisal."Phone No." := SavingsAccounts."Transactional Mobile No";
                                Appraisal.Email := SavingsAccounts."E-Mail";
                                Appraisal."Member No." := SavingsAccounts."Member No.";
                                Appraisal."ID No." := SavingsAccounts."ID No.";
                                Appraisal."Account Balance" := SavingsAccounts."Balance (LCY)";
                                Appraisal."As At" := Today;
                                Appraisal."Date-Time" := CurrentDateTime;

                                // MBoosta := 0;
                                // ProductFactory.Get('126');
                                // SkyMbanking.MBoostaAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp);
                                // MBoosta := QualifiedAmt;
                                // MBoostaMsg := Msg;



                                // SalaryInAdvance := 0;
                                // ProductFactory.Get('123');
                                // SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
                                // SalaryInAdvance := QualifiedAmt;
                                // SalaryInAdvanceMsg := Msg;

                                // FinjeChapChap := 0;
                                // ProductFactory.Get('120');
                                // SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
                                // FinjeChapChap := QualifiedAmt;
                                // FinjeChapChapMsg := Msg;


                                // JisortAdvance := 0;
                                // ProductFactory.Get('121');
                                // SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
                                // JisortAdvance := QualifiedAmt;
                                // JisortAdvanceMsg := Msg;


                                // SalaryAdvance := 0;
                                // ProductFactory.Get('119');
                                // SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
                                // SalaryAdvance := QualifiedAmt;
                                // SalaryAdvanceMsg := Msg;



                                Appraisal.MBoosta := MBoosta;
                                Appraisal."MBoosta Msg" := MBoostaMsg;
                                Appraisal."Salary In Advance" := SalaryInAdvance;
                                Appraisal."Salary In Advance Msg" := SalaryInAdvanceMsg;
                                Appraisal."Finje Chap Chap" := FinjeChapChap;
                                Appraisal."Finje Chap Chap Msg" := FinjeChapChapMsg;
                                Appraisal."Jisort Advance" := JisortAdvance;
                                Appraisal."Jisort Advance Msg" := JisortAdvanceMsg;
                                Appraisal."Salary Advance" := SalaryAdvance;
                                Appraisal."Salary Advance Msg" := SalaryAdvanceMsg;

                                Appraisal."Salary 1" := Salary[1];
                                Appraisal."Salary Date 1" := SalDates[1];
                                Appraisal."Salary 2" := Salary[2];
                                Appraisal."Salary Date 2" := SalDates[2];
                                Appraisal."Salary 3" := Salary[3];
                                Appraisal."Salary Date 3" := SalDates[3];


                                Appraisal.Modify;
                                Commit;
                            end
                            else begin

                                Appraisal.Init;
                                Appraisal."User ID" := UserId;
                                Appraisal."Account No." := SavingsAccounts."No.";
                                Appraisal.Name := SavingsAccounts.Name;
                                Appraisal."Phone No." := SavingsAccounts."Transactional Mobile No";
                                Appraisal.Email := SavingsAccounts."E-Mail";
                                Appraisal."Member No." := SavingsAccounts."Member No.";
                                Appraisal."ID No." := SavingsAccounts."ID No.";
                                Appraisal."Account Balance" := SavingsAccounts."Balance (LCY)";
                                Appraisal."As At" := Today;
                                Appraisal."Date-Time" := CurrentDateTime;

                                // MBoosta := 0;
                                // ProductFactory.Get('126');
                                // SkyMbanking.MBoostaAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp);
                                // MBoosta := QualifiedAmt;
                                // MBoostaMsg := Msg;



                                // SalaryInAdvance := 0;
                                // ProductFactory.Get('123');
                                // SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
                                // SalaryInAdvance := QualifiedAmt;
                                // SalaryInAdvanceMsg := Msg;

                                // FinjeChapChap := 0;
                                // ProductFactory.Get('120');
                                // SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
                                // FinjeChapChap := QualifiedAmt;
                                // FinjeChapChapMsg := Msg;


                                // JisortAdvance := 0;
                                // ProductFactory.Get('121');
                                // SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
                                // JisortAdvance := QualifiedAmt;
                                // JisortAdvanceMsg := Msg;


                                // SalaryAdvance := 0;
                                // ProductFactory.Get('119');
                                // SkyMbanking.SalaryMobileLoanAppraisal(SavingsAccounts."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, ProductFactory."Product ID", Salary, SalDates);
                                // SalaryAdvance := QualifiedAmt;
                                // SalaryAdvanceMsg := Msg;



                                Appraisal.MBoosta := MBoosta;
                                Appraisal."MBoosta Msg" := MBoostaMsg;
                                Appraisal."Salary In Advance" := SalaryInAdvance;
                                Appraisal."Salary In Advance Msg" := SalaryInAdvanceMsg;
                                Appraisal."Finje Chap Chap" := FinjeChapChap;
                                Appraisal."Finje Chap Chap Msg" := FinjeChapChapMsg;
                                Appraisal."Jisort Advance" := JisortAdvance;
                                Appraisal."Jisort Advance Msg" := JisortAdvanceMsg;
                                Appraisal."Salary Advance" := SalaryAdvance;
                                Appraisal."Salary Advance Msg" := SalaryAdvanceMsg;

                                Appraisal."Salary 1" := Salary[1];
                                Appraisal."Salary Date 1" := SalDates[1];
                                Appraisal."Salary 2" := Salary[2];
                                Appraisal."Salary Date 2" := SalDates[2];
                                Appraisal."Salary 3" := Salary[3];
                                Appraisal."Salary Date 3" := SalDates[3];


                                Appraisal.Insert;
                                Commit;
                            end;
                            dWindow.Update(1, TotalLines);

                        until SavingsAccounts.Next = 0;

                    end;

                    dWindow.Close;
                end;
            }
            action("Mboosta Analysis")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                //RunObject = Report "Mobile Loan Appraisal Analysis";//here
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        //SETFILTER("Member No.",'0056882');
    end;

    trigger OnAfterGetRecord()
    var
        AcctNo: Code[20];
        Success: Boolean;
        Msg: Text;
        LoanLimit: Decimal;
        QualifiedAmt: Decimal;
        TopUp: Decimal;
    begin
        /*
        //"Account No." := "Account No.";
        
        MBoosta:=0;
        ProductFactory.GET('126');
        SkyMbanking.MBoostaAppraisal("Account No.",Success,Msg,LoanLimit,QualifiedAmt,TopUp);
        MBoosta := QualifiedAmt;
        MBoostaMsg := Msg;
        
        
        
        SalaryInAdvance:=0;
        ProductFactory.GET('123');
        SkyMbanking.SalaryMobileLoanAppraisal("Account No.",Success,Msg,LoanLimit,QualifiedAmt,TopUp,ProductFactory."Product ID");
        SalaryInAdvance:=QualifiedAmt;
        SalaryInAdvanceMsg := Msg;
        
        FinjeChapChap:=0;
        ProductFactory.GET('120');
        SkyMbanking.SalaryMobileLoanAppraisal("Account No.",Success,Msg,LoanLimit,QualifiedAmt,TopUp,ProductFactory."Product ID");
        FinjeChapChap:=QualifiedAmt;
        FinjeChapChapMsg := Msg;
        
        
        JisortAdvance:=0;
        ProductFactory.GET('121');
        SkyMbanking.SalaryMobileLoanAppraisal("Account No.",Success,Msg,LoanLimit,QualifiedAmt,TopUp,ProductFactory."Product ID");
        JisortAdvance:=QualifiedAmt;
        JisortAdvanceMsg := Msg;
        
        
        SalaryAdvance:=0;
        ProductFactory.GET('119');
        SkyMbanking.SalaryMobileLoanAppraisal("Account No.",Success,Msg,LoanLimit,QualifiedAmt,TopUp,ProductFactory."Product ID");
        SalaryAdvance:=QualifiedAmt;
        SalaryAdvanceMsg := Msg;
        
        
        MBoosta := MBoosta;
        "MBoosta Msg" := MBoostaMsg;
        "Salary In Advance" := SalaryInAdvance;
        "Salary In Advance Msg" := SalaryInAdvanceMsg;
        "Finje Chap Chap" := FinjeChapChap;
        "Finje Chap Chap Msg" := FinjeChapChapMsg;
        "Jisort Advance" := JisortAdvance;
        "Jisort Advance Msg" := JisortAdvanceMsg;
        "Salary Advance" := SalaryAdvance;
        "Salary Advance Msg" := SalaryAdvanceMsg;
        
        */


        //LastName := SkyMbanking.FirstName(Name);

    end;

    trigger OnInit()
    begin
        //Member.GET(187584);
    end;

    trigger OnOpenPage()
    begin
        //SETFILTER("Member No.",'0186110');
    end;

    var
        Member: Record Members;
        Vendor: Record Vendor;
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        MBoosta: Decimal;
        SalaryInAdvance: Decimal;
        FinjeChapChap: Decimal;
        JisortAdvance: Decimal;
        SalaryAdvance: Decimal;
        ProductFactory: Record "Product Factory";
        // SkyMbanking: Codeunit "Sky Mbanking";
        MBoostaMsg: Text;
        SalaryInAdvanceMsg: Text;
        FinjeChapChapMsg: Text;
        JisortAdvanceMsg: Text;
        SalaryAdvanceMsg: Text;
        Appraisal: Record "Sky Mobile Loan Appraisal";
        dWindow: Dialog;
        LastName: Text;
}

