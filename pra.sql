create table Students(
    sno varchar(20) primary key,
    sname varchar(20) not null,
    ssex varchar(10) not null,
    sbrithday datetime,
    class varchar(20)
);
create table Course(
    cno varchar(20) primary key,
    Cname varchar(20) not null,
    tno varchar(20) not null,
    foreign key(tno) references teacher(tno) 
);
create table teacher(
    tno varchar(20) primary key,
    tname varchar(20) not null,
    tsex varchar(10) not null,
    tbrithday datetime,
    prof varchar(10) not null,
    depart varchar(20) not null
);
create table score(
    sno varchar(20) not null,
    cno varchar(20) not null,
    degree decimal not null,
    foreign key(sno) references Students(sno),
    foreign key(cno) references Course(cno),
    primary key(sno,cno)
);
insert into Students values("101","张三","男","1997-01-29","16222513");
insert into Students values("102","老客户","女","1997-10-09","16222515");
insert into Students values("103","撒是否","女","1997-08-15","16222514");
insert into Students values("104","阿顺帆","男","1997-05-24","16222515");
insert into Students values("105","无法是","男","1997-04-26","16222515");
insert into Students values("106","阿萨德","男","1997-06-27","16222514");
insert into Students values("107","阿萨芬帆","男","1997-11-09","16222515");
insert into Students values("108","无法","男","1997-11-05","16222516");

insert into teacher values("222","湿度","男","1988-01-29","教师","计算机系");
insert into teacher values("223","方法","女","1985-10-09","教师","电子信息系");
insert into teacher values("224","阿迪","女","1966-08-15","教师","数字媒体系");
insert into teacher values("225","飞萨芬","男","1988-05-24","副教授","人文艺术系");
insert into teacher values("226","是","男","1977-04-26","教师","土木工程系");
insert into teacher values("227","萨芬","男","1989-06-27","教授","计算机系");
insert into teacher values("228","问问","男","1990-11-09","博导","计算机系");

insert into Course values("3-105","数据结构","222");
insert into Course values("6-105","数字艺术","225");
insert into Course values("9-105","建筑学","226");

insert into score values("101","3-105","99");
insert into score values("101","6-105","55");
insert into score values("101","9-105","88");
insert into score values("102","3-105","44");
insert into score values("102","6-105","75");
insert into score values("102","9-105","55");
insert into score values("103","3-105","66");
insert into score values("103","6-105","85");
insert into score values("103","9-105","46");

select * from students where class ="16222515
select * from students where year(sbrithday) in (select year(sbrithday) from students where sno in (102,10)
create table lamp(
    id int primary key,
    switch int,
    mode int,
    lightness varchar(20),
    color int,
    name varchar(20),
    equipName varchar(20),
    foreign key(name) references room(roomName),
    foreign key(equipName) references equipName(equipName)
);
create table lamp(
    id int primary key,
    switch int not null,
    mode int not null,
    lightness varchar(20)  not null,
    color int not null,
    name varchar(20) not null,
    equipName varchar(20) not null,
    foreign key(name) references room(roomName),
    foreign key(equipName) references equipment(equipName)
);
create table door(
    id int primary key,
    switch int not null,
    password int(20) not null,
    camera int  not null,
    sound int not null,
    name varchar(20) not null,
    equipName varchar(20) not null,
    foreign key(name) references room(roomName),
    foreign key(equipName) references equipment(equipName)
);
create table sound(
    id int primary key,
    switch int not null,
    child int not null,
    mode int  not null,
    name varchar(20) not null,
    equipName varchar(20) not null,
    foreign key(name) references room(roomName),
    foreign key(equipName) references equipment(equipName)
);
create table heater(
    id int primary key,
    switch int not null,
    temperature int not null,
    ezeng int  not null,
    cloud int  not null,
    highTem int  not null,
    noEletri int  not null,
    time int  not null,
    fastHeat int  not null,
    name varchar(20) not null,
    equipName varchar(20) not null,
    foreign key(name) references room(roomName),
    foreign key(equipName) references equipment(equipName)
);
temperature,mode,sxfeng,zyfeng,speed,clear,time,heat,dry,name,equipName,switch