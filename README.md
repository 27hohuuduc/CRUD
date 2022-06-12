# CRUD
 Demo WebMethods

SQL
--

use master

go

create database CRUD

go

use CRUD

go
-- Tạo bảng công ty.
create table Company (
	IdC varchar(10) primary key,
	NameC nvarchar(50),
	Infor nvarchar(max)
)

go

-- Tạo bảng nhân viên.
create table Staff (
	IdS varchar(10) primary key,
	NameS nvarchar(30),
	Company varchar(10) foreign key references Company(IdC)
)

go
--Thêm dữ liệu
insert into Company values ('VH', N'Vĩnh Hy', '')
declare @index int
set @index = 1
begin
	while @index < 12
	begin 
		insert into Company values (concat('VH',@index), N'Vĩnh Hy', '')
		set @index = @index + 1
	end
end

go

insert into Company values ('VHA', N'Vĩnh Hy', '')
declare @index int
set @index = 1
begin
	while @index < 3
	begin 
		insert into Company values (concat('VHA',@index), N'Vĩnh Hy', '')
		set @index = @index + 1
	end
end

go

-- Tạo mã công ty và thêm công ty
create procedure AddCompany @NameC nvarchar(50), @Infor nvarchar(max), @Id varchar(10) output
as
begin
	if @NameC is null or trim(@NameC) = ''
			throw 51000, N'Tên công ty không được để trống', 1
	-- Tạo Id 
	declare @Duplicat nvarchar(50) = @NameC,
			@Index int = 1,
			@num int
	set @Id = ''
	while charindex(' ', @Duplicat) != 0
	begin
		select @Id = @Id + upper(left(@Duplicat, 1))
		select @Duplicat = stuff(@Duplicat, 1, charindex(' ', @Duplicat), '')
	end
	select @Id = @Id + left(@Duplicat, 1)
	-- Kiểm tra Id trùng
	set @num = (select	max(cast(substring(IdC, datalength(@Id) + 1, datalength(IdC)) as int))
				from	Company
				where	IdC like concat(@Id, '%') and (Idc = @Id or isnumeric(substring(IdC, datalength(@Id) + 1, datalength(IdC))) = 1))
	set @Id = concat(@Id, @num + 1)
	insert into Company values(@Id, @NameC, @Infor)
	return;
end

go

-- Test procedure
-- declare @IdC varchar(10); exec AddCompany @NameC = N'Vĩnh Hy', @Infor = N'', @Id = @IdC output; select @IdC; select * from Company

go
-- Tạo mã nhân viên và thêm nhân viên
create procedure AddStaff @NameS nvarchar(30), @Company varchar(10), @Id varchar(10) output
as
begin
	if @NameS is null or trim(@NameS) = ''
		throw 51000, N'Tên nhân viên không được để trống', 1
	declare @num int
	set @num = (select	isnull(max(cast(substring(IdS, datalength(@Company + '_') + 1, datalength(IdS)) as int)), 0)
				from	Staff
				where	IdS like concat(@Company + '_', '%') and (IdS = @Company + '_' or isnumeric(substring(IdS, datalength(@Company + '_') + 1, datalength(IdS))) = 1))
	set @Id = concat(@Company + '_', @num +1)
	insert into Staff values(@Id, @NameS, @Company)
	return;
end

go

-- Test procedure
-- declare @IdS varchar(10); exec AddStaff @NameS = N'Nguyễn Văn A', @Company = 'H', @Id = @IdS output; select @IdS; select * from Staff

go

-- Xoá công ty
create procedure DelCompany @IdC varchar(10)
as
begin
	delete from Staff where Company = @IdC
	delete from Company where IdC = @IdC
end

go

-- Xoá nhân viên
create procedure DelStaff @IdS varchar(10)
as
begin
	delete from Staff where IdS = @IdS
end

go

-- Sửa công ty
create procedure EditCompany @IdC varchar(10), @NameC nvarchar(50), @Infor nvarchar(max)
as
begin
	if @NameC is null or trim(@NameC) = ''
		throw 51000, N'Tên công ty không được để trống', 1
	else
		update Company set NameC = @NameC, Infor = @Infor where IdC = @IdC
end

go

-- Sửa nhân viên
create procedure EditStaff @IdS varchar(10), @NameS nvarchar(50), @Company nvarchar(max)
as
begin
	if @NameS is null or trim(@NameS) = ''
		throw 51000, N'Tên nhân viên không được để trống', 1
	else
		update Staff set NameS = @NameS, Company = @Company where IdS = @IdS
end

-- Test procedure
-- exec EditCompany @IdC = 'VH', @NameC = N'Vinh Hy', @Infor = '' select * from Company

