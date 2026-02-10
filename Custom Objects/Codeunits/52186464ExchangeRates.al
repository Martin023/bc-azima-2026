// codeunit 52186464 "Fluentax Exchange Rate Update"
// {
//     trigger OnRun()
//     begin
//         UpdateExchangeRates();
//     end;

//     procedure UpdateExchangeRates()
//     var
//         HttpClient: HttpClient;
//         HttpResponseMessage: HttpResponseMessage;
//         ResponseText: Text;
//         JsonObject: JsonObject;
//         JsonArray: JsonArray;
//         CurrencyCode: Text;
//         ExchangeRate: Decimal;
//         ApiKey: Text; // Replace with your API key
//         Result: JsonToken;
//     begin
//         HttpClient := HttpClient;
//         HttpClient.DefaultRequestHeaders().Add('Authorization', 'Bearer ' + ApiKey);
//         HttpClient.Get('https://api.fluentax.com/v1/exchange-rates',HttpResponseMessage);

//         if HttpResponseMessage.IsSuccessStatusCode() then begin
//             HttpResponseMessage.Content().ReadAs(ResponseText);
//             JsonObject.ReadFrom(ResponseText);
//             JsonArray := JsonObject.Get('rates',Result);

//             foreach currency in JsonArray do begin
//                 CurrencyCode := currency.GetValue('currency').AsText();
//                 ExchangeRate := currency.GetValue('rate').AsDecimal();
//                 UpdateCurrencyExchangeRate(CurrencyCode, ExchangeRate);
//             end;
//         end else begin
//             Error('Failed to fetch exchange rates: %1', HttpResponseMessage.ReasonPhrase());
//         end;
//     end;

//     procedure UpdateCurrencyExchangeRate(CurrencyCode: Text; ExchangeRate: Decimal)
//     var
//         CurrencyExchangeRate: Record "Currency Exchange Rate";
//         DateToday: Date;
//     begin
//         DateToday := Today();
//         if CurrencyExchangeRate.Get(CurrencyCode, DateToday) then begin
//             CurrencyExchangeRate."Exchange Rate Amount" := ExchangeRate;
//             CurrencyExchangeRate.Modify();
//         end else begin
//             CurrencyExchangeRate.Init();
//             CurrencyExchangeRate."Currency Code" := CurrencyCode;
//             CurrencyExchangeRate."Exchange Rate Amount" := ExchangeRate;
//             CurrencyExchangeRate."Starting Date" := DateToday;
//             CurrencyExchangeRate.Insert();
//         end;
//     end;
// }
