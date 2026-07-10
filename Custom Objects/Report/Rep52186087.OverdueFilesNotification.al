namespace MNS.MNS;
using System.Email;
using System.Security.User;

report 52186087 "Overdue Files Notification"
{
    ApplicationArea = All;
    Caption = 'Overdue Files Notification';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        // dataitem(FileRequests; "File Requests")
        dataitem(FileTracker; "File Tracker")
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                FileDueDate: Date;
                usermail: Text;
                username: text;
                EmailManager: Codeunit "Email Message";
                Email: Codeunit Email;
                UserSetup: Record "User Setup";
                msg: Text;

            begin
                if FileTracker.Overdue then
                    exit;
                if FileTracker."File Request Status" = FileTracker."File Request Status"::Open then
                    exit;
                if FileTracker."File Request Status" = FileTracker."File Request Status"::Closed then
                    exit;
                if FileTracker."File Request Status" = FileTracker."File Request Status"::Requested then
                    exit
                else begin
                    FileDueDate := CalcDate('+2W', FileTracker."File Request Date");
                    if FileDueDate <= TODAY then begin
                        // begin
                        //     UserSetup.GET(UserId);
                        //     msg := 'Dear ' + UserSetup."Full Name" + ',<br><br>' + 'This is to inform you that the file request for ' + FileRequests."File Number" + 'which you requested on the '
                        //     + FORMAT(FileRequests."File Request Date") + ' ' + 'is overdue. Please take necessary action to avail it back to Records Department.<br><br>Regards,<br>Records Department.';
                        //     EmailManager.Create(UserSetup."E-Mail", 'Contract Execution', msg, true);
                        //     Email.Send(EmailManager, Enum::"Email Scenario"::Default);
                        //     Message('Email Sent Successfully');
                        // end;
                        FileTracker."Overdue" := true;
                        FileTracker."Date Overdue" := TODAY;
                        FileTracker.Modify;
                        FileTracker.Validate(Overdue);
                    end;
                end;
                // if FileRequests.Overdue then exit;
                // if FileRequests.Status = FileRequests.Status::Open then exit;
                // if FileRequests.Status = FileRequests.Status::Rejected then exit;
                // if FileRequests.Status = FileRequests.Status::Requested then
                //     if FileRequests.Overdue = false then begin
                //         FileDueDate := CalcDate('+2W', FileRequests."File Request Date");
                //         if FileDueDate <= TODAY then begin
                //             // begin
                //             //     UserSetup.GET(UserId);
                //             //     msg := 'Dear ' + UserSetup."Full Name" + ',<br><br>' + 'This is to inform you that the file request for ' + FileRequests."File Number" + 'which you requested on the '
                //             //     + FORMAT(FileRequests."File Request Date") + ' ' + 'is overdue. Please take necessary action to avail it back to Records Department.<br><br>Regards,<br>Records Department.';
                //             //     EmailManager.Create(UserSetup."E-Mail", 'Contract Execution', msg, true);
                //             //     Email.Send(EmailManager, Enum::"Email Scenario"::Default);
                //             //     Message('Email Sent Successfully');
                //             // end;
                //             FileRequests."Overdue" := true;
                //             FileRequests.Modify;
                //         end;
                //     end;
            end;
        }
        dataitem(Members; Members)
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

                if (Members.Status = Members.Status::Deceased) AND (Members.Status = Members.Status::Closed) then begin

                    SavingAccounts.RESET;
                    SavingAccounts.SETRANGE("Member No.", Members."No.");
                    SavingAccounts.SETRANGE("Product Category", SavingAccounts."Product Category"::"Transfered Share Capital");
                    if SavingAccounts.Find('-') then begin
                        SavingAccounts.CalcFields("Balance (LCY)");
                        if SavingAccounts."Balance (LCY)" <= 0 then begin

                            FileVolumes.RESET;
                            FileVolumes.SETRANGE("Member No.", Members."No.");
                            if FileVolumes.Find('-') then begin
                                repeat
                                    FileVolumes.Closed := true;
                                    FileVolumes."Closed By" := UserID;
                                    FileVolumes."Archived" := true;
                                    FileVolumes."Archived By" := UserID;
                                    FileVolumes."Date Archived" := TODAY;
                                    FileVolumes.Modify();
                                until FileVolumes.NEXT = 0;
                            end;
                        end
                        else
                            exit;
                    end;
                end;
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
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        FileVolumes: Record "File Volumes";
        SavingAccounts: Record "Savings Accounts";
}
