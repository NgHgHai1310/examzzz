create database NTB_DB;

create table Location (
LocationID char(6) Primary Key,
Name nvarchar (50) Not null,
Description nvarchar (100)
);

create table Land (
LandID int Primary key identity,
Title nvarchar (100) Not null,
LocationID char (6) Foreign Key REFERENCES Location(LocationID),
Detail nvarchar (1000),
StartDate datetime Not null,
EndDate datetime Not null
);

create table Building (
BuildingID int Primary key identity,
LandID int Foreign Key References Land(LandID),
BuildingType nvarchar (50),
Area int Default 50,
Floors int Default 1,
Rooms int Default 1,
Cost money
);


--3
-- Insert into Location
INSERT INTO Location (LocationID, Name, Description) VALUES
('LOC001', N'Đô thị', N'Mỹ Đình'),
('LOC002', N'Ngoại ô', N'Sóc Sơn'),
('LOC003', N'Nông thôn', N'Phương Công');

-- Insert into Land
INSERT INTO Land (Title, LocationID, Detail, StartDate, EndDate) VALUES
(N'đất 1', 'LOC001', N'52 Đ. Lê Đức Thọ, Mỹ Đình, Từ Liêm, Hà Nội', '2022-01-01', '2022-12-31'),
(N'đất 2', 'LOC002', N'Tổ 1 KĐT Mới, Đ. Núi Đôi, Sóc Sơn, Hà Nội', '2023-02-15', '2023-11-30'),
(N'đất 3', 'LOC003', N'Thôn đông, Quân Bác, Tiền Hải, Thái Bình', '2023-05-10', '2023-09-30');

-- Insert into Building
INSERT INTO Building (LandID, BuildingType, Area, Floors, Rooms, Cost) VALUES
(1, N'biệt thự', 150, 2, 4, 200000),
(2, N'Căn hộ', 120, 5, 3, 150000),
(3, N'Siêu thị', 500, 1, 1, 500000);


--4
SELECT * FROM Building WHERE Area >= 100;

--5
SELECT * FROM Land WHERE EndDate < '2013-01-01';


--6
SELECT B.* FROM Building B
INNER JOIN Land L ON B.LandID = L.LandID
WHERE L.Title = 'Mỹ Đình';

--7
CREATE VIEW v_Buildings AS
SELECT B.BuildingID, L.Title, L.Name, B.BuildingType, B.Area, B.Floors
FROM Building B
JOIN Land L ON B.LandID = L.LandID
JOIN Location LOC ON L.LocationID = LOC.LocationID;

--8
CREATE VIEW v_TopBuildings AS
SELECT TOP 5 B.BuildingID, L.Title, L.Name, B.BuildingType, B.Area, B.Floors
FROM Building B
JOIN Land L ON B.LandID = L.LandID
JOIN Location LOC ON L.LocationID = LOC.LocationID
ORDER BY B.Cost/B.Area DESC;


--9
CREATE PROCEDURE sp_SearchLandByLocation
    @AreaCode CHAR(6)
AS
BEGIN
    SELECT *
    FROM Land L
    WHERE L.LocationID = @AreaCode;
END;


--10
CREATE PROCEDURE sp_SearchBuildingByLand
    @LandCode INT
AS
BEGIN
    SELECT B.*
    FROM Building B
    WHERE B.LandID = @LandCode;
END;
