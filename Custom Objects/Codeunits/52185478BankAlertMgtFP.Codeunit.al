#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185478 "BankAlertMgt FP"
{

    trigger OnRun()
    begin
        InitAlert();
    end;

    var
        CurrentUserID: Code[20];
        BankAcc: Record "Bank Account";
        TellerSetup: Record "Cash Office User Template";
        Selection: Boolean;
        LineNo: Integer;


    procedure InitAlert()
    begin
        CurrentUserID := UserId;
        if AlertUser then begin
            GetTellers();
        end
        else begin
            exit;
        end;
        ShowBankAlert();
    end;


    procedure GetTellers()
    begin
        //this function gets all the tellers who are supervised by the current user
        TellerSetup.Reset;
        TellerSetup.SetRange(TellerSetup."Supervisor ID", CurrentUserID);

        if TellerSetup.Find('-') then begin
            repeat
                GetTellerBalance
                                (
                                TellerSetup.UserID
                                , TellerSetup."Default Receipts Bank"
                                , TellerSetup."Max. Cash Collection"
                                );
            until TellerSetup.Next = 0;
        end;
    end;


    procedure GetTellerBalance(var TellerID: Code[20]; var "Bank No.": Code[20]; var MaxBal: Decimal)
    var
        Balance: Decimal;
    begin
        /*
        //this function gets the teller balance from the database
        BankAcc.RESET;
        BankAcc.GET("Bank No.");
        BankAcc.CALCFIELDS(BankAcc."Balance (LCY)");
        Balance:=BankAcc."Balance (LCY)";
          LineNo:=LineNo + 1;
        InsertAlertRecord();
          BuffAlert."Line No.":=LineNo;
          BuffAlert."Teller ID":=TellerID;
          BuffAlert.VALIDATE(BuffAlert."Teller ID");
          BuffAlert."Account No.":=BankAcc."No.";
          BuffAlert."Account Name":=BankAcc.Name;
          BuffAlert."Max. Balance":=MaxBal;
          BuffAlert."Curr. Balance":=Balance;
          BuffAlert."Min. Balance":=BankAcc."Min. Balance";
          BuffAlert."Supervisor ID":=CurrentUserID;
        BuffAlert.INSERT();
        */

    end;


    procedure InsertAlertRecord()
    begin
        /*
        BuffAlert.INIT;
        */

    end;


    procedure AlertUser(): Boolean
    begin
        /*
        //CHECK IF THE USER SHOULD BE ALERTED IN RELATION TO THE BANK ALERTS
        
        TellerSetup.RESET;
        TellerSetup.SETRANGE(TellerSetup."Supervisor ID",CurrentUserID);
        
        BuffAlert.RESET;
        IF BuffAlert.FINDLAST THEN
          BEGIN
            LineNo:=BuffAlert."Line No.";
          END;
        
        BuffAlert.RESET;
        BuffAlert.SETRANGE(BuffAlert."Supervisor ID",CurrentUserID);
        IF BuffAlert.FIND('-') THEN
          BEGIN
            BuffAlert.DELETEALL;
          END;
        
        //getthe last number from the database
        
        EXIT((TellerSetup.COUNT>0));
        */

    end;


    procedure ShowBankAlert()
    begin
        /*
        //this function shows the form depending on whether the are people in the list who have more money that they should
        BuffAlert.RESET;
        BuffAlert.SETRANGE(BuffAlert."Supervisor ID",CurrentUserID);
        IF BuffAlert.FIND('-') THEN
          BEGIN
            REPEAT
              BuffAlert.MARK(FALSE);
              BuffAlert.MODIFY;
            UNTIL BuffAlert.NEXT=0;
          END;
        
        IF BuffAlert.FIND('-') THEN
          BEGIN
            REPEAT
              IF BuffAlert."Max. Balance"<=BuffAlert."Curr. Balance" THEN
                BEGIN
                  BuffAlert.MARK(TRUE);
                  BuffAlert.MODIFY;
                END;
            UNTIL BuffAlert.NEXT=0;
          END;
        
        //get the count of marked records
        BuffAlert.MARKEDONLY(TRUE);
        
        //check if the count is greater than zero
        IF BuffAlert.COUNT>0 THEN
          BEGIN
            Selection:=CONFIRM('Alert Some Tellers have reached the maximum allowable collection. View details?',FALSE);
            CASE Selection OF
                TRUE://show the user the form
                  BEGIN
                    PAGE.RUN(39006031,BuffAlert)
                  END;
                FALSE://exit the screen
                  BEGIN
                    EXIT;
                  END;
              END;
          END;
        */

    end;


    procedure CreateCashRequest(CurrUser: Code[20]): Code[20]
    var
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        TSetup: Record "Cash Office User Template";
        CSSetup: Record "Cash Office Setup";
        UserSelection: Boolean;
    begin
        /*
        //this function creates a cash request from the teller to the person who initiated the request
        WITH Rec DO BEGIN
          //INSERT THE REQUEST INTO THE DATABASE AFTER GETTING THE NEXT NUMBER IN THE REQUEST TABLE
            CSSetup.RESET;
            CSSetup.GET();
            Request.INIT;
              Request."No.":=NoSeriesMgt.GetNextNo(CSSetup."Cash Request Nos",TODAY,TRUE);
              Request."Request Date":=TODAY;
              Request."Request Time":=TIME;
              Request."Requester ID":=CurrUser;
              Request.VALIDATE(Request."Requester ID");
              Request."Request Amount":="Curr. Balance"-"Min. Balance";
              Request."Request From ID":="Teller ID";
              Request.VALIDATE(Request."Request From ID");
              Request."Request From Acc. No.":="Account No.";
              Request."Curr. Balance":="Curr. Balance";
              Request."Max. Balance":="Max. Balance";
              Request."Min. Balance":="Min. Balance";
              Request."Amount Pending":=Request."Request Amount";
            //get the details of the person who is requesting for cash
              TSetup.RESET;
              IF TSetup.GET(CurrUser) THEN
                BEGIN
                  Request."Requester Acc. No.":=TSetup."Default Receipts Bank";
                END;
              "Request Created":=TRUE;
              MODIFY;
            Request.INSERT();
        END;
        IF Request.COUNT <1 THEN BEGIN EXIT END;
        //ask for user confirmation
        UserSelection:=CONFIRM('A Cash Request ' + FORMAT(Request."No.") + ' has been created. View Request?',FALSE);
        
        Request.SETRANGE(Request."No.",Request."No.");
        
        //check the user selection
        IF (UserSelection) AND (Req.COUNT>0) THEN
          BEGIN
            EXIT(Request."No.");
          END;
        */

    end;


    procedure RetrieveActiveRequests()
    begin
        /*
        //this function gets the active requests from the database that have not been met
        WITH Requests DO BEGIN
          RESET;
          SETFILTER(Requests."Request From ID",USERID);
          SETFILTER(Requests.Posted,FORMAT(TRUE));
          IF FIND('-') THEN
            BEGIN
              REPEAT
                IF "Amount Pending"<>0 THEN
                  BEGIN
                    MARK(TRUE);
                    MODIFY;
                  END
                ELSE
                  BEGIN
                    MARK(FALSE);
                    MODIFY;
                  END;
              UNTIL NEXT=0;
            END;
            MARKEDONLY(TRUE);
            IF COUNT>0 THEN
              BEGIN
                IF CONFIRM
                          (
                            'You have some pending Requests. View Them ?'
                            ,
                            FALSE
                          ) =FALSE
                THEN
                  BEGIN
                    EXIT;
                  END
                ELSE
                  BEGIN
                    PAGE.RUN(39006033,Requests);
                  END;
              END;
        END;
        */

    end;


    procedure CreateCashIssue()
    var
        // // NoSeriesMgt: Codeunit NoSeriesManagement;
        CSSetup: Record "Cash Office Setup";
        Selection: Boolean;
    begin
        /*
        //this function creates an issue in relation to the a request that has been sent to the teller
        CSSetup.GET();
        WITH Issue DO BEGIN
          INIT;
            Issue."No.":=NoSeriesMgt.GetNextNo(CSSetup."Cash Issue Nos",TODAY,TRUE);
            Issue."Request No.":=Request."No.";
            Issue."Issue Date":=TODAY;
            Issue."Issue Time":=TIME;
            Issue."Requester ID":=Request."Requester ID";
            Issue."Requester Name":=Request."Requester Name";
            Issue."Requester Acc. No.":=Request."Requester Acc. No.";
            Issue."Request Amount":=Request."Request Amount";
            Issue."Issuer ID":=USERID;
            Issue."Issuer Name":=Request."Request From Name";
            Issue."Issuer Acc. No.":=Request."Requester Acc. No.";
            Issue."Issue Amount":=Request."Amount Pending";
            Issue.Remarks:='';
          INSERT;
        
          SETRANGE("No.","No.");
        
          IF COUNT>0 THEN
            BEGIN
              Selection:=CONFIRM('A Cash Issue Document ' + Issue."No." + ' has been created. View The Document ?',FALSE);
        
              CASE Selection OF
                TRUE://show the issue form
                  BEGIN
                    PAGE.RUN(39006034,Issue);
                  END;
                FALSE://do not show issue form
                  BEGIN
                  END;
              END;
            END;
        END;
        */

    end;


    procedure RetrieveActiveIssues(): Boolean
    var
        Selection: Boolean;
    begin
        /*
        //this function retrieves the active issues and prompts user for response
        WITH Issue DO BEGIN
          RESET;
          SETFILTER(Issue."Requester ID",USERID);
          SETFILTER(Issue.Receipted,FORMAT(FALSE));
          SETFILTER(Issue.Posted,FORMAT(TRUE));
          IF FINDFIRST THEN
            BEGIN
              //get the user option from the database
              Selection:=CONFIRM('There are pending cash issues. Do you wish to view them now?',FALSE);
        
              CASE Selection OF
                  TRUE://show the form
                    BEGIN
                      PAGE.RUN(39006036,Issue);
                    END;
                  FALSE://decide what to do user can be forced to view and receipt here
                    BEGIN
                      EXIT(FALSE);
                    END;
                END;
            END;
        END;
        */

    end;


    procedure CreateCashReceipt()
    var
        // // NoSeriesMgt: Codeunit NoSeriesManagement;
        CSSetup: Record "Cash Office Setup";
        Selection: Boolean;
    begin
        /*
        //this function creates a cash receipt in the database
        CSSetup.GET();
        WITH Receipt DO BEGIN
          INIT;
            "No.":=NoSeriesMgt.GetNextNo(CSSetup."Cash Receipt Nos",TODAY,TRUE);
            "Issue No.":=Issue."No.";
            "Receipt Date":=TODAY;
            "Receipt Time":=TIME;
            "Issuer ID":=Issue."Issuer ID";
            "Issuer Name":=Issue."Issuer Name";
            "Issuer Acc. No.":=Issue."Issuer Acc. No.";
            "Issue Amount":=Issue."Issue Amount";
            "Receiver ID":=Issue."Requester ID";
            "Receiver Acc. No.":=Issue."Requester Acc. No.";
            "Receiver Amount":=Issue."Issue Amount";
            "Receiver Name":=Issue."Requester Name";
          INSERT;
        END;
        
        //ask for user confirmation
        Selection:=CONFIRM('A Cash Receipt ' + Receipt."No." + ' has been created. View the created Cash Receipt?',FALSE);
        
        //check the selection made by the user of the system
        CASE Selection OF
            TRUE://user wishes to view hence show the form
              BEGIN
                PAGE.RUN(39006037,Receipt);
              END;
            FALSE://user does not wish to view the form
              BEGIN
              END;
          END;
        */

    end;
}
