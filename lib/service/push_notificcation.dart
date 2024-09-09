// import 'package:flutter/cupertino.dart';
//
// class PushNotificationService {
//   static Future<String> getAccessToken() async {
//     final serviceAccountJson = {
//       {
//         "type": "service_account",
//         "project_id": "fir-firebase-97c2f",
//         "private_key_id": "0aa75fcc5c05d29d5259d43642101de7301c7fc0",
//         "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCyw4IFA03CazIw\nc+p9k+yo8LdvlvVVqZvKm/YP4svlr3WbH5c1Lk0K4NuRh/ocV3rpn2wvKT8SGlbL\nQ4GKidlg7tgbspWVSJ3WIiG06QY6epUAZtdn9clyBFvUzAyLGn5KC0yBXV68DwiC\nOkx7O6f17fyRQbhQwwTJlnCKyubXwGxPM/G46hw7Zo8c/2b+8pb3kipXegoSNYyw\ntGGwUS+5PJIrCt4oyjQhbmOaKjF8//94CGju14iRt/PxpyLFWMPYFS9AIYpYTLKD\nlR5jWrPMWynTR0wPLdaHsqdoAyI8uRCyPWwfW+jGc9yTiiSO7/eFFy9FPqrMvC20\n/hpbRRqhAgMBAAECggEACY+jhfpmeM0Ohlx5XCfwedKyIGG3E5voNnEIlpuj0OJz\nDFcCtQFjB6P9mBvW74XXIi4dUNAj3vB/jugBnerJHkIu6UBUwRVYahNWQ3gElef6\nX8JXOlZu9wUczbEUe4YoA72sQFtT399/9ze3Knx01vHYjd5WDpIJ9XDMxbnlKwC5\nDoiwPHPgCpi1vjAINquE/3I4jmkrjW4ccYDJpjR+DAmgJOk7dIykiqWvb9xFEbC1\nnAUK0beNTZDdSsStlhxBRzGZqSL7PBXJGSCSjXoREZ9GrcXfukj8R+rRIAOCWjae\nUfn5qQllFbHPLLtVr4XsSTzoEehWxaxA7yva1q0fhwKBgQD4uoLowETC4/5CtdlD\n/gS0xUPX3xFe3ox2w7XXigkn9srQe+Ut7FqX3/HusxYTGRFL44fDJ6yt4JKPtsIS\nPhb2uORCDokCAOKB9JCcbST+f1f7ZF8dydCjiwE1X9FzZlBnbeELymOGOYDSN7ZS\nRYTrQi9SABnstKF9aut6AOYjUwKBgQC3/WDdnCvjehs3rzP74Q8WDvOxIjumsppD\nhZ+xnVJd+VvL7AJe3bLM3r5CaB1aK/EhptldSdWwnExa6er4VpYR4HALNtwL2vPv\nJbtV1Hbt83aQSkFy/VZAOp/Eoq1oPoq3/KVaeQDZGWQjVVZO2f3W40ZBBv40Nyb7\nWQYMU4zfuwKBgQCerc5qUo8LjoxdXso3GE1ETj0T8RmR3oTaF81gro1c05NcIk55\nV7oL/jDISbQhhvKD6appFFyTqRuXV87D+JyJ1ja49bDueEYJBk9jnDXnrrIgjU4p\nIOFcFIg21uQ2rOVKtszFyt5neTP36NcF8Zf0xoqN08a2Ph5wds+3S++GRQKBgEJe\nw4eNo4Nec90FdZIh4IhLgnreZ3g9q0o6NJ4kqya9IfEQxNYl0S74FtfrqNLzUPub\nrYNqdAxOhXiyMxG8Ykw2kxRoiL46EI6vJMHUb8ZscdOhBbUOUAPBYgrTyAv3q6Ct\nIZTeW4D1GNtqGEU/e8L9n0Ur2Z1KW+SFe5oMtZ+rAoGBANd8eN7aDWZ0gx1xcae/\nC1c14dI/FZlGZjkdtr6eyE+VLd9shxy6iZLUrbBuPIhT59M5Rvk+rnz3ecr5vlve\nh+VGgLkkWMs22Ih7VuTKH/z2aEargBuKbZ23xy4k7GqII0vJIQKUMWGtDey5Bozy\nsEX9XAEdnnDZwSQ0wkpRvJlG\n-----END PRIVATE KEY-----\n",
//         "client_email": "firebase-adminsdk-otdc4@fir-firebase-97c2f.iam.gserviceaccount.com",
//         "client_id": "115170199374463388193",
//         "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//         "token_uri": "https://oauth2.googleapis.com/token",
//         "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//         "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-otdc4%40fir-firebase-97c2f.iam.gserviceaccount.com",
//         "universe_domain": "googleapis.com"
//       }
//     };
//     List<String> scopes = [
//       "https://www.googleapis.com/auth/firebase.messaging"
//     ];
//   }
//
//   static sendNotificationToSelectedDriver(String deviveToken,
//       BuildContext context, String tripId) async {
//
//   }
// }