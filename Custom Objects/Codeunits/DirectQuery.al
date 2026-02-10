// codeunit 52187336 RunSQLQuery
// {
//     procedure RunSQLQuery()
//     var
//         Query: Record "Query";
//         QueryRun: Record "Query Run";
//         Customer: Record Customer;
//         TempBlob: TEMPORARY Record 16;
//     begin
//         // Load the Query record
//         Query.SETRANGE(Name, 'YourQueryName'); // Set the name of your saved query here

//         // Initialize the QueryRun record
//         QueryRun.INIT;
//         QueryRun.QUERY(Query);
//         QueryRun.RUN;

//         // Loop through the results and do something
//         IF QueryRun.FINDFIRST THEN BEGIN
//             REPEAT
//                 // Access fields from the query result
//                 Customer.GET(QueryRun."No.");

//                 // Do something with the customer data
//                 // For example, print the customer name
//                 MESSAGE('Customer Name: %1', Customer.Name);

//             UNTIL QueryRun.NEXT = 0;
//         END;
//     end;
// }