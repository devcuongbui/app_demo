USE [app_work_mangement]
GO
    /****** Object: Trigger [dbo].[tr_InsertNotification] Script Date: 3/25/2023 1:46:57 PM ******/
SET
    ANSI_NULLS ON
GO
SET
    QUOTED_IDENTIFIER ON
GO
    ALTER TRIGGER [dbo].[tr_InsertNotification] ON [dbo].[notifications]
AFTER
INSERT
    AS BEGIN DECLARE @title NVARCHAR(MAX),
    @body NVARCHAR(MAX),
    @DATA NVARCHAR(MAX) DECLARE @http INT
SELECT
    @title = Title,
    @body = Content
FROM
    inserted DECLARE @json NVARCHAR(MAX)
SET
    @json = '{ "to": "/topics/news", "notification": { "title": "' + @title + '", "body": "' + @body + @DATA + '" } }' DECLARE @url NVARCHAR(MAX)
SET
    @url = 'https://fcm.googleapis.com/fcm/send' DECLARE @http_status INT EXEC sp_OACreate 'MSXML2.ServerXMLHTTP',
    @http OUT EXEC sp_OAMethod @http,
    'open',
    NULL,
    'POST',
    @url,
    'false' EXEC sp_OAMethod @http,
    'setRequestHeader',
    NULL,
    'Content-Type',
    'application/json' EXEC sp_OAMethod @http,
    'setRequestHeader',
    NULL,
    'Authorization',
    'key=AAAACDPhmRI:APA91bHqrKcJrNKCFvghaDhkl523De27PsqyfC7_cKDWJRO3Edp0B1CLh3YDv_LmcnDH-8-gXZO7iYxHzKITmyMQYPkSsYsYMhrl7Puo0SOIjkje7eljIv_VPyM86CZznFfR9Qz3JVIK' EXEC sp_OAMethod @http,
    'send',
    NULL,
    @json EXEC sp_OAGetProperty @http,
    'status',
    @http_status OUT EXEC sp_OADestroy @http PRINT 'Notification sent: ' + @title + ' - ' + @body
END 