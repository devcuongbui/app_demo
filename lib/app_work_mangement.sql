create database app_work_mangement
go
use app_work_mangement
go
--
-- Cấu trúc bảng cho bảng roles
--
CREATE TABLE  roles  (
RoleID  int IDENTITY(1,1) NOT NULL,
Role  nvarchar(50) NOT NULL,
Permissions  nvarchar(50) ,
Role_User nvarchar(50),
Permission_Role  nvarchar(50) ,
CONSTRAINT PK_roles PRIMARY KEY(RoleID),
)
------------------------------ Insert into table Roles --------------------------------------
insert into roles VALUES('edit','','','')
insert into roles VALUES('view','','','')
--
-- Cấu trúc bảng cho bảng users
--
CREATE TABLE  users  (
UserID  int IDENTITY(1,1) NOT NULL,
Username  varchar(50) NOT NULL,
Fullname  nvarchar(255) NOT NULL,
Password  varchar(100) NOT NULL,
Email  varchar(255) NOT NULL,
AvatarUrl  varchar(255),
RoleID  int NOT NULL,
CreatedDate  datetime NOT NULL,
LastLoginTime  datetime ,
CONSTRAINT PK_users PRIMARY KEY(UserID),
CONSTRAINT FK_users_roles FOREIGN KEY(RoleID) REFERENCES roles(RoleID)
)
------------------------------ Insert into table Users --------------------------------------
insert into users VALUES('doxuannam',N'đỗ xuân nam','123456','doxuannam@gmail.com','assets/images/avatar.jpg',1,'2022-01-14 21:56:19 PM','')
insert into users VALUES('phamphuquang',N'phạm phú quang','123123123','phamphuquang@gmail.com','assets/images/avatar1.jpg',2,'2022-2-2 14:48:25 PM','')
insert into users VALUES('buiduccuong',N'bùi đức cường','456456456','buiduccuong@gmail.com','assets/images/avatar2.jpg',2,'2022-3-8 08:45:09 AM','')
insert into users VALUES('hoangthigam',N'hoàng thị gấm','123456123456','doxuannam@gmail.com','assets/images/avatar3.jpg',2,'2022-3-9 21:56:19 PM','')
--
-- Cấu trúc bảng cho bảng boards
--
CREATE TABLE boards (
BoardID int IDENTITY(1,1) NOT NULL,
BoardName nvarchar(50) NOT NULL,
CreatedDate datetime NOT NULL,
UserID int NOT NULL,
Labels  nvarchar(250)  ,
LabelsColor nvarchar(250)  ,
CONSTRAINT PK_boards PRIMARY KEY(BoardID),
CONSTRAINT PK_boards_users FOREIGN KEY(UserID) REFERENCES users(UserID) ,
)
--------------------------------------- Insert into table Boards ---------Đang sai phải sửa lại phần insert------------------------
insert into boards VALUES(N'Hạn đến 2 tháng 4',N'Công việc ở công ty','2023-2-20 10:25:48 AM',1,'','false','true','','green','Private','','')
insert into boards VALUES(N'Công việc bên ngoài',N'Công việc ở công ty ABC','2023-3-2',3,'','true','false','','red','Private','','')
insert into boards VALUES(N'Làm thêm',N'Công việc làm web freelancer','2023-3-2',3,'','true','false','','blue','Private','','')
insert into boards VALUES(N'Cố gắng làm thêm đi!',N'Phân tích nghiệp vụ','2022-1-2',2,'','true','false','','yellow','Private','','')
insert into boards VALUES(N'Phân việc này chưa được ổn lắm',N'Dự án phong thuỷ thổ địa','2023-3-2',1,'','true','false','','red','Private','','')
insert into boards VALUES(N'Mọi người cố gắng tập trung làm phần này',N'Sơ đồ chi tiết','2023-4-3',2,'','true','false','','blue','Private','','')
insert into boards VALUES(N'Dưới sao trên vậy',N'Code dự án phát triển','2023-11-2',3,'','true','false','','green','Private','','')
insert into boards VALUES(N'Làm dự án đẩy nhanh tiến độ',N'Công việc làm web freelancer','2023-9-25',1,'','true','false','','yellow','Private','','')
insert into boards VALUES(N'Cái quần què j đây trời',N'Database hoàn chỉnh','2023-5-20',2,'','true','false','','red','Private','','')
insert into boards VALUES(N'Tôi rất thất vọng với kết quả này',N'Dự án công trình dưỡng lão','2023-7-11',1,'','true','false','','green','Private','','')
insert into boards VALUES(N'Chúng bây làm ăn rất thiếu chuyên nghiệp',N'Phân tích quá trình giảm đau cột sống','2023-8-3',2,'','true','false','','blue','Private','','')
--
-- Cấu trúc bảng cho bảng  lists
--
CREATE TABLE  lists  (
ListID  int IDENTITY(1,1) NOT NULL,
BoardID  int  NOT NULL,
ListName  nvarchar(255) NOT NULL,
Position  int  NOT NULL,
Closed  bit  NOT NULL,
DateCreated  datetime NOT NULL,
DateLastActivity  datetime NOT NULL,
DateArchived  datetime  ,
Subscribed  bit  NOT NULL,
CONSTRAINT PK_lists PRIMARY KEY(ListID),
CONSTRAINT FK_lists_boards FOREIGN KEY(BoardID)REFERENCES Boards(BoardID)
)
------------------------------ Insert into table Lists --------------------------------------
insert into lists VALUES(1,N'Website bán hàng',1,'false','2023-2-20','2023-3-1','','true')
insert into lists VALUES(1,N'Website quản lý đất đai',2,'false','2023-2-20','2023-3-1','','true')
insert into lists VALUES(1,N'Làm app quản lý công việc cá nhân',3,'false','2023-2-20','2023-3-1','','true')
insert into lists VALUES(2,N'Phần mềm quản lý nhân viên',4,'false','2023-2-20','2023-3-1','','true')
insert into lists VALUES(3,N'Thiết kế giao diện quản lý điểm trường học',5,'false','2023-2-20','2023-3-1','','true')
--
-- Cấu trúc bảng cho bảng  creators
--
CREATE TABLE  creators  (
CreatorID  int IDENTITY(1,1) NOT NULL,
UserID  int  NOT NULL,
ListID  int ,
BoardID  int ,
CONSTRAINT PK_creators PRIMARY KEY(CreatorID),
CONSTRAINT FK_creators_users FOREIGN KEY(UserID) REFERENCES users(UserID),
CONSTRAINT FK_creators_lists FOREIGN KEY(ListID) REFERENCES lists(ListID),
CONSTRAINT FK_creators_boards FOREIGN KEY(BoardID) REFERENCES boards(BoardID),
)
------------------------------ Insert into table Creators --------------------------------------
insert into creators VALUES(1,1,1)
insert into creators VALUES(2,2,1)
insert into creators VALUES(3,3,1)
--
-- Cấu trúc bảng cho bảng  AsignedTo
--
CREATE TABLE  assignedTo (
AssignedToID  int IDENTITY(1,1) NOT NULL,
UserID  int  NOT NULL,
ListID  int ,
BoardID  int ,
CONSTRAINT PK_assignedTo PRIMARY KEY(AssignedToID),
CONSTRAINT FK_asignedTo_users FOREIGN KEY(UserID) REFERENCES users(UserID),
CONSTRAINT FK_asignedTo_lists FOREIGN KEY(ListID) REFERENCES lists(ListID),
CONSTRAINT FK_asignedTo_boards FOREIGN KEY(BoardID) REFERENCES boards(BoardID),
)
------------------------------ Insert into table AssignedTo --------------------------------------
insert into assignedTo VALUES(1,1,1)
insert into assignedTo VALUES(2,1,1)
insert into assignedTo VALUES(3,1,1)
--
-- Cấu trúc bảng cho bảng  cards
--
CREATE TABLE  cards  (
CardID  int IDENTITY(1,1) NOT NULL,
ListID  int  NOT NULL,
AssignedToID  int,
CreatorID  int  NOT NULL,
Checklist int ,
Label  nvarchar(255)  ,
Comment  int,
CardName  nvarchar(255) NOT NULL,
StatusView  nvarchar(255)  ,
CreatedDate  datetime NOT NULL,
StartDate date ,
DueDate  date,
Attachment  nvarchar(max)  ,
CompletedStatus  bit  NOT NULL,
Description  nvarchar(255)  ,
Activity  nvarchar(255),
IntCheckList int,
LabelColor nchar(10),
CONSTRAINT PK_cards PRIMARY KEY(CardID),
CONSTRAINT FK_cards_lists FOREIGN KEY(ListID) REFERENCES lists(ListID),
CONSTRAINT FK_cards_creators FOREIGN KEY(CreatorID) REFERENCES creators(CreatorID),
CONSTRAINT FK_cards_assignedTo FOREIGN KEY(AssignedToID) REFERENCES assignedTo(AssignedToID),
)
------------------------------ Insert into table Cards --------------------------------------
insert into cards VALUES(1,3,1,'','Medium','',N'FrontEnd','','2023-2-20 11:00:50 AM','2023-2-28','2023-3-5 3:30 PM','','false','','')
insert into cards VALUES(1,3,1,'','Low','',N'Create Database','','2023-2-20 11:00:50 AM','2023-2-28','2023-3-5 3:30 PM','','false','','')
insert into cards VALUES(1,3,1,'','High','',N'Create WebAPI','','2023-2-20 11:00:50 AM','2023-2-28','2023-3-5 3:30 PM','','false','','')
insert into cards VALUES(1,3,1,'','High','',N'BackEnd','','2023-2-20 11:00:50 AM','2023-2-28','2023-3-5 3:30 PM','','false','','')
insert into cards VALUES(2,3,2,'','Medium','',N'Nghiệp vụ','','2023-2-28 11:00:50 AM','2023-3-28','2023-5-5 3:30 PM','','false','','')
insert into cards VALUES(2,1,2,'','Low','',N'Dữ liệu mèo','','2023-5-20 11:00:50 AM','2023-5-28','2023-7-5 3:30 PM','','false','','')
insert into cards VALUES(2,1,3,'','High','',N'Dữ liệu cún','','2023-7-20 11:00:50 AM','2023-7-28','2023-9-5 3:30 PM','','false','','')
insert into cards VALUES(2,3,2,'','High','',N'Code lỗi','','2023-10-20 11:00:50 AM','2023-10-28','2023-12-5 3:30 PM','','false','','')
insert into cards VALUES(3,3,1,'','Medium','',N'Yêu cầu khách hàng','','2023-2-28 11:00:50 AM','2023-3-28','2023-5-5 3:30 PM','','false','','')
insert into cards VALUES(3,3,1,'','Low','',N'Cố gắng mà sửa','','2023-5-20 11:00:50 AM','2023-5-28','2023-7-5 3:30 PM','','false','','')
insert into cards VALUES(3,3,1,'','High','',N'Lỗi tồn đọng','','2023-11-20 11:00:50 AM','2023-11-28','2024-2-5 3:30 PM','','false','','')
insert into cards VALUES(3,3,1,'','High','',N'Khẩn cấp vá lỗi nhanh!','','2023-10-20 11:00:50 AM','2023-10-28','2024-2-5 3:30 PM','','false','','')
insert into cards VALUES(4,2,3,'','Medium','',N'Dữ liệu chưa đủ','','2023-2-28 11:00:50 AM','2023-3-28','2023-5-5 3:30 PM','','false','','')
insert into cards VALUES(4,2,3,'','Low','',N'Cường em làm chỗ này đi','','2023-5-20 11:00:50 AM','2023-5-28','2023-7-5 3:30 PM','','false','','')
insert into cards VALUES(4,2,3,'','High','',N'Phân việc của Nam','','2023-7-20 11:00:50 AM','2023-7-28','2023-9-5 3:30 PM','','false','','')
insert into cards VALUES(4,1,3,'','High','',N'Mọi người tập trung kết quả','','2023-10-20 11:00:50 AM','2023-10-28','2023-12-5 3:30 PM','','false','','')
insert into cards VALUES(5,3,1,'','Medium','',N'Vẽ trên Figma','','2023-2-28 11:00:50 AM','2023-3-28','2023-5-5 3:30 PM','','false','','')
insert into cards VALUES(5,3,1,'','Medium','',N'Cắt giao diện','','2023-5-20 11:00:50 AM','2023-5-28','2023-7-5 3:30 PM','','false','','')
--
-- Cấu trúc bảng cho bảng  comments
--
CREATE TABLE  comments  (
CommentID  int IDENTITY(1,1) NOT NULL,
UserID  int  NOT NULL,
CardID  int  NOT NULL,
Detail  nvarchar(255) NOT NULL,
CONSTRAINT PK_comments PRIMARY KEY(CommentID),
CONSTRAINT FK_comments_users FOREIGN KEY(UserID) REFERENCES users(UserID),
CONSTRAINT FK_comments_cards FOREIGN KEY(CardID) REFERENCES cards(CardID),
)
------------------------------ Insert into table comments --------------------------------------
insert into comments VALUES(1,1,N'Yêu cầu đổi lịch hết hạn')
insert into comments VALUES(2,2,N'Xem xét lại database')
insert into comments VALUES(3,3,N'Hoàn thành dự án trước ngày 2/4')
insert into comments VALUES(4,4,N'code em sửa lại r đó ạ!')
insert into comments VALUES(1,5,N'Em đã làm xong ahihi')
insert into comments VALUES(3,6,N'Có con mèo này em nghĩ là ổn đó sếp')
insert into comments VALUES(2,7,N'Bé cún chinh chinh :D')
insert into comments VALUES(4,8,N'HUHU e sẽ sửa lại ạ ')
insert into comments VALUES(3,9,N'Khách hàng hãm vcl')
insert into comments VALUES(1,10,N'E đã sửa lại một số lỗi quan trọng')
insert into comments VALUES(2,11,N'Done đã xong hoàn thành và ấn định')
insert into comments VALUES(3,12,N'Không hiểu kiểu gì lỗi này ở đâu ra dị')
--
-- Cấu trúc bảng cho bảng  checklists
--

DROP TABLE checklists
CREATE TABLE  checklists  (
ChecklistID  int IDENTITY(1,1) NOT NULL,
CardID  int  NOT NULL,
ChecklistTitle nvarchar(255) NOT NULL,
Completed  bit   ,
Position  int  NOT NULL,
DateCreated  datetime NOT NULL,
DateUpdated  datetime NOT NULL,
DateCompleted  datetime,
CONSTRAINT PK_checklists PRIMARY KEY(ChecklistID),
CONSTRAINT FK_checklists_cards FOREIGN KEY(CardID) REFERENCES cards(CardID)
)
------------------------------ Insert into table checklists --------------------------------------
insert into checklists VALUES('1',N'Danh sách việc cần làm của card 1','false',1,'2023-2-20 10:48:50 AM','','')
insert into checklists VALUES('2',N'Danh sách việc cần làm của card 2','false',2,'2023-2-20 10:48:50 AM','','')
insert into checklists VALUES('3',N'Danh sách việc cần làm của card 3','false',3,'2023-2-20 10:48:50 AM','','')
insert into checklists VALUES('4',N'Danh sách việc cần làm của card 4','false',1,'2023-2-20 10:48:50 AM','','')
insert into checklists VALUES('5',N'Danh sách việc cần làm của card 5','false',2,'2023-2-20 10:48:50 AM','','')
insert into checklists VALUES('6',N'Danh sách việc cần làm của card 6','false',3,'2023-2-20 10:48:50 AM','','')
--
-- Cấu trúc bảng cho bảng  checklistitems
--

DROP TABLE checklistitems
CREATE TABLE  checklistitems  (
ChecklistitemID  int IDENTITY(1,1) NOT NULL,
ChecklistID  int  NOT NULL,
Title  nvarchar(255) NOT NULL,
Description  nvarchar(255)  ,
DueDate  datetime  ,
Completed  bit   ,
CompletedDate  datetime  ,
CreatedDate  datetime  ,
UpdatedDate  datetime  ,
Position  int,
CONSTRAINT PK_checklistitems PRIMARY KEY(ChecklistitemID),
CONSTRAINT FK_checklistitems_checklists FOREIGN KEY(ChecklistID) REFERENCES checklists(ChecklistID)
)
------------------------------ Insert into table checklistitems --------------------------------------
insert into checklistitems VALUES(1,N'việc làm 1 của checklist 1','','',1,'','2023-2-20 10:51:50 AM','',1)
insert into checklistitems VALUES(1,N'việc làm 2 của checklist 1','','',1,'','2023-2-20 10:51:50 AM','',2)
insert into checklistitems VALUES(1,N'việc làm 3 của checklist 1','','',0,'','2023-2-20 10:51:50 AM','',3)
insert into checklistitems VALUES(1,N'việc làm 4 của checklist 1','','',0,'','2023-2-20 10:51:50 AM','',3)

insert into checklistitems VALUES(2,N'việc làm 1 của checklist 2','','',1,'','2023-2-20 10:51:50 AM','',1)
insert into checklistitems VALUES(2,N'việc làm 2 của checklist 2','','',1,'','2023-2-20 10:51:50 AM','',2)
insert into checklistitems VALUES(2,N'việc làm 3 của checklist 2','','',0,'','2023-2-20 10:51:50 AM','',3)
insert into checklistitems VALUES(2,N'việc làm 4 của checklist 2','','',0,'','2023-2-20 10:51:50 AM','',3)
insert into checklistitems VALUES(2,N'việc làm 5 của checklist 2','','',0,'','2023-2-20 10:51:50 AM','',3)

insert into checklistitems VALUES(3,N'việc làm 1 của checklist 3','','',1,'','2023-2-20 10:51:50 AM','',1)
insert into checklistitems VALUES(3,N'việc làm 2 của checklist 3','','',1,'','2023-2-20 10:51:50 AM','',2)
insert into checklistitems VALUES(3,N'việc làm 3 của checklist 3','','',0,'','2023-2-20 10:51:50 AM','',3)

insert into checklistitems VALUES(4,N'việc làm 1 của checklist 4','','',1,'','2023-2-20 10:51:50 AM','',1)
insert into checklistitems VALUES(4,N'việc làm 2 của checklist 4','','',1,'','2023-2-20 10:51:50 AM','',2)
insert into checklistitems VALUES(4,N'việc làm 3 của checklist 4','','',0,'','2023-2-20 10:51:50 AM','',3)

insert into checklistitems VALUES(5,N'việc làm 1 của checklist 5','','',1,'','2023-2-20 10:51:50 AM','',1)
insert into checklistitems VALUES(5,N'việc làm 2 của checklist 5','','',1,'','2023-2-20 10:51:50 AM','',2)
insert into checklistitems VALUES(5,N'việc làm 3 của checklist 5','','',0,'','2023-2-20 10:51:50 AM','',3)

insert into checklistitems VALUES(6,N'việc làm 1 của checklist 6','','',1,'','2023-2-20 10:51:50 AM','',1)
insert into checklistitems VALUES(6,N'việc làm 2 của checklist 6','','',1,'','2023-2-20 10:51:50 AM','',2)
insert into checklistitems VALUES(6,N'việc làm 3 của checklist 6','','',0,'','2023-2-20 10:51:50 AM','',3)

--
-- Cấu trúc bảng cho bảng  notification
--
CREATE TABLE  notifications  (
NotificationID  int IDENTITY(1,1) NOT NULL,
UserID  int  NOT NULL,
NotificationType  int NOT NULL,
Title nvarchar(500),
CardID  int,
BoardID  int,
Content  nvarchar(max) NOT NULL,
CreatedDate  datetime NOT NULL,
Status bit  NOT NULL,
CONSTRAINT PK_notifications PRIMARY KEY(NotificationID),
CONSTRAINT FK_notifications_users FOREIGN KEY(UserID) REFERENCES users(UserID),
CONSTRAINT FK_notifications_cards FOREIGN KEY(CardID) REFERENCES cards(CardID),
CONSTRAINT FK_notifications_boards FOREIGN KEY(BoardID) REFERENCES boards(BoardID),
)
------------------------------ Insert into table notifications --------------------------------------
insert into notifications VALUES(1,1,N'Unread',1,1,N'hết hạn vào ngày mai','2023-3-8 09:55:21 AM','true')
insert into notifications VALUES(1,1,N'Unread',1,1,N'hết hạn vào ngày mai','2023-3-8 09:55:21 AM','true')
insert into notifications VALUES(1,1,N'Unread',1,1,N'hết hạn vào ngày mai','2023-3-8 09:55:21 AM','true')
insert into notifications VALUES(1,1,N'Unread',1,1,N'hết hạn vào ngày mai','2023-3-8 09:55:21 AM','true')
insert into notifications VALUES(2,2,N'All categories',1,1,N'đã thay đổi ngày hết hạn','2023-3-7 10:25:41 PM','false')
insert into notifications VALUES(2,2,N'All categories',1,1,N'đã thay đổi ngày hết hạn','2023-3-7 10:25:41 PM','false')
insert into notifications VALUES(2,2,N'All categories',1,1,N'đã thay đổi ngày hết hạn','2023-3-7 10:25:41 PM','false')
insert into notifications VALUES(2,2,N'All categories',1,1,N'đã thay đổi ngày hết hạn','2023-3-7 10:25:41 PM','false')
insert into notifications VALUES(3,3,N'Me',1,1,N'đã di chuyển thẻ sang','2023-3-6 11:57:10 AM','false')
insert into notifications VALUES(3,3,N'Me',1,1,N'đã di chuyển thẻ sang','2023-3-6 11:57:10 AM','false')
insert into notifications VALUES(3,3,N'Me',1,1,N'đã di chuyển thẻ sang','2023-3-6 11:57:10 AM','false')
insert into notifications VALUES(3,3,N'Me',1,1,N'đã di chuyển thẻ sang','2023-3-6 11:57:10 AM','false')
insert into notifications VALUES(3,4,N'Comment',1,1,N'đã bình luận ở thẻ','2023-3-6 11:57:10 AM','false')
insert into notifications VALUES(3,4,N'Comment',1,1,N'đã bình luận ở thẻ','2023-3-6 11:57:10 AM','false')
insert into notifications VALUES(3,4,N'Comment',1,1,N'đã bình luận ở thẻ','2023-3-6 11:57:10 AM','false')
insert into notifications VALUES(3,4,N'Comment',1,1,N'đã bình luận ở thẻ','2023-3-6 11:57:10 AM','false')
insert into notifications VALUES(4,0,N'Default',1,1,N'đã thêm thành viên vào bảng','2023-12-6 11:57:10 AM','false')
insert into notifications VALUES(4,0,N'Default',1,1,N'đã loại thành viên ở thẻ','2023-3-6 11:57:10 AM','false')
insert into notifications VALUES(4,0,N'Default',1,1,N'đã mời thêm thành viên ở bảng','2023-3-6 11:57:10 AM','false')
insert into notifications VALUES(4,0,N'Default',1,1,N'đã mời thêm thành viên ở thẻ','2023-3-6 11:57:10 AM','false')


ALTER TABLE cards
ALTER  COLUMN DueDate date

ALTER TABLE boards
DROP COLUMN Lists;

ALTER TABLE cards
ADD LabelColor nchar(10)


--------------TEST QUERY--------------------------------

SELECT cards.*, checklists., checklist.checklist_title, checklist.checklist_status
FROM cards
INNER JOIN checklists ON cards.CardID = checklists.CardID;



SELECT COUNT(checklistitems.ChecklistItemID) AS 'SUM',
SUM(CASE WHEN checklistitems.Completed = 1 THEN 1 ELSE 0 END) AS 'index_checked'
FROM checklists
INNER JOIN checklistitems ON checklists.ChecklistID = checklistitems.ChecklistID
WHERE checklists.ChecklistID = 1;

SELECT cards.*, 
       COUNT(checklistitems.ChecklistItemID) AS 'SUM', 
       SUM(CASE WHEN checklistitems.Completed = 1 THEN 1 ELSE 0 END) AS 'index_checked'
FROM cards 
INNER JOIN checklists ON cards.cardID = checklists.cardID 
INNER JOIN checklistitems ON checklists.checklistID = checklistitems.checklistID
GROUP BY cards.cardID,cards.ListID,cards.AssignedToID,cards.CreatorID,cards.Checklist,cards.Label,cards.Comment,cards.CardName
,cards.StatusView,cards.CreatedDate,cards.StartDate,cards.DueDate,cards.Attachment,cards.CompletedStatus,cards.Description,cards.Activity
,cards.IntCheckList,cards.LabelColor;

Select checklists.ChecklistTitle,checklistitems.Title from checklists 
inner join checklistitems on checklists.ChecklistID = checklistitems.ChecklistID where checklists.CardID = 1