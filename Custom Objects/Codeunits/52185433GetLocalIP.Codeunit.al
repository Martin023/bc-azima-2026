#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185433 "Get Local IP"
{
    // You may want to visit my blog too http://navnab.wordpress.com/


    trigger OnRun()
    begin
    end;

    var
        ActiveSession: Record "Active Session";
        Dns: code[100];//dotnet Dns;
        IPAddresses: code[100];//dotnet List_Of_T;
        i: Integer;


    procedure GetLocalIP()
    var
        ActiveSession: Record "Active Session";
        Dns: code[100];//dotnet Dns;
        IPAddresses: code[100];//dotnet List_Of_T;
        i: Integer;
    begin
        ActiveSession.Get(ServiceInstanceId, SessionId);
        // IPAddresses := IPAddresses.List;
        // IPAddresses.AddRange(Dns.GetHostAddresses(ActiveSession."Client Computer Name"));
        // for i := 0 to IPAddresses.Count - 1 do begin
        //     Message('%1', IPAddresses.Item(i));
        // end;
    end;
}
