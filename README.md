**目录**

[前言](#%E5%89%8D%E8%A8%80)

[1.  查询" 01 "课程比" 02 "课程成绩高的学生的信息及课程分数](#t0)

[2.  查询同时存在" 01 "课程和" 02 "课程的情况](#t1)

[3.  查询存在" 01 "课程但可能不存在" 02 "课程的情况(不存在时显示为 null )](#t2)

[4.  查询不存在" 01 "课程但存在" 02 "课程的情况](#t3)

[5.  查询平均成绩大于等于 60 分的同学的学生编号和学生姓名和平均成绩](#t4)

[6.  查询在 t_mysql_score 表存在成绩的学生信息](#t5)

[7.  查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩(没成绩的显示为 null )](#t6)

[8.  查询「李」姓老师的数量](#t7)

[9.  查询学过「张三」老师授课的同学的信息](#t8)

[10.  查询没有学全所有课程的同学的信息](#t9)

[11.  查询没学过"张三"老师讲授的任一门课程的学生姓名](#t10)

[12.  查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩](#t11)

[13.  检索" 01 "课程分数小于 60，按分数降序排列的学生信息](#t12)

[14.  按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩](#t13)

[15.  查询各科成绩最高分、最低分和平均分：-- 以如下形式显示：课程 ID，课程 name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率。(及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90)-- 要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列](#t14)

[CASE 函数的详解](#t15)

[1\. 简单 CASE 表达式：](#t16)

[2\. 搜索 CASE 表达式：](#t17)

[if 函数详解](#t18)

---

## 前言

数据库的考察在面试时可是十分常见的，MySQL 作为一种常用的关系型数据库管理系统，对于它的介绍在面试时可是必不可少的，下面就是一些常见笔试题的模拟，希望可以帮助到你 🙂🙂

所用到的表如下：

**学生表（t_mysql_student）**

有学生 ID（sid），学生姓名（sname），学生年龄（sage），学生性别（ssex）

![](https://i-blog.csdnimg.cn/blog_migrate/af2b218c917ce64ce29285b9b7233d02.png)

**教师表（t_mysql_teacher）**

教师编号（tid），教师姓名（tname）

![](https://i-blog.csdnimg.cn/blog_migrate/70f9fe77bfaca363435e47f57e0a8cc1.png)

**课程表（t_mysql_course）**

课程编号（cid），课程名称（cname），教师编号（tid 外键）

![](https://i-blog.csdnimg.cn/blog_migrate/b61acb67368851c0475fec04b9a0e19b.png)

**成绩表（t_mysql_score）**

学生编号（sid 外键），课程编号（cid 外键），学生成绩（score）

![](https://i-blog.csdnimg.cn/blog_migrate/d281668c002e24dacdb283e2fec1cbc1.png)

##  1.  查询" 01 "课程比" 02 "课程成绩高的学生的信息及课程分数

```sql
select s.*,t1.score 01课程分数,t2.score 02课程分数 from  (select *from t_mysql_score where cid='01')t1,(select *from t_mysql_score where cid='02')t2,t_mysql_student swhere s.sid=t1.sid and s.sid=t2.sidand t1.score>t2.score
```

## 2.  查询同时存在" 01 "课程和" 02 "课程的情况

```sql
select s.*,t1.score 01课程分数,t2.score 02课程分数 from (select * from t_mysql_score where cid='01')t1,(select * from t_mysql_score where cid='02')t2,t_mysql_student swhere s.sid=t1.sid and s.sid=t2.sid
```

## 3.  查询存在" 01 "课程但可能不存在" 02 "课程的情况(不存在时显示为 null )

```sql
select t1.*,t2.score 02课程 from (select *from t_mysql_score where cid='01')t1 left join (select *from t_mysql_score where cid='02')t2 ont1.sid=t2.sid
```

## 4.  查询不存在" 01 "课程但存在" 02 "课程的情况

```sql
select *from t_mysql_score s where s.sid not in(select sid from t_mysql_score where cid='01')and cid='02'
```

## 5.  查询平均成绩大于等于 60 分的同学的学生编号和学生姓名和平均成绩

```sql
select s.sid,s.sname,ROUND(AVG(sc.score)) 平均成绩fromt_mysql_student s,t_mysql_score scwhere s.sid=sc.sidGROUP BYs.sid,s.snameHAVING平均成绩>60
```

## 6.  查询在 t_mysql_score 表存在成绩的学生信息

```sql
select *from t_mysql_student where sid in (select sid from t_mysql_score GROUP BY sid )
```

## 7.  查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩(没成绩的显示为 null )

```sql
select s.sid,s.sname,count(sc.cid),sum(sc.score)fromt_mysql_student s ,t_mysql_score scwhere s.sid=sc.sidGROUP BYs.sid,s.sname
```

## 8.  查询「李」姓老师的数量

```sql
select count(*) from t_mysql_teacher where tname like '李%'
```

## 9.  查询学过「张三」老师授课的同学的信息

```sql
select s.*,t.tnamefromt_mysql_student s,t_mysql_teacher t,t_mysql_course c,t_mysql_score scwhere s.sid=sc.sid and t.tid=c.tid and c.cid=sc.cidand tname='张三'
```

## 10.  查询没有学全所有课程的同学的信息

```sql
select s.sid,s.sname,count(sc.cid) 课程总数fromt_mysql_student s,t_mysql_score scwhere s.sid=sc.sidGROUP BYs.sid,s.snameHAVING课程总数<(select count(1) from t_mysql_course)
```

## 11.  查询没学过"张三"老师讲授的任一门课程的学生姓名

```sql
select s.* from t_mysql_student s where s.sid not in (selectsc.sidfromt_mysql_teacher t,t_mysql_course c,t_mysql_score scwhere t.tid=c.tid and c.cid=sc.cidand t.tname='张三'GROUP BYsc.sid)
```

## 12.  查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩

```sql
SELECTs.sid,s.sname,ROUND(AVG(sc.score)) 平均成绩,COUNT(sc.cid) 课程总数FROMt_mysql_student s,t_mysql_score scWHEREs.sid=sc.sid and sc.score<60GROUP BYs.sid,s.snameHAVING课程总数>=2
```

## 13.  检索" 01 "课程分数小于 60，按分数降序排列的学生信息

```sql
SELECTs.*FROMt_mysql_score sc,t_mysql_student sWHEREsc.sid=s.sid and sc.score<60 and cid='01'ORDER BY sc.score DESC
```

## 14.  按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩

```sql
SELECTs.sid,s.sname,round(AVG(sc.score),2) 平均成绩 ,max(case when sc.cid='01' then sc.score end)语文,max(case when sc.cid='02' then sc.score end)数学,max(case when sc.cid='03' then sc.score end)英语FROMt_mysql_score sc,t_mysql_student s,t_mysql_course cWHERE sc.sid=s.sid and sc.cid=c.cidGROUP BYs.sid,s.snameORDER BY 平均成绩 desc
```

## 15.  查询各科成绩最高分、最低分和平均分：

\-- 以如下形式显示：课程 ID，课程 name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率。(及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90)  
\-- 要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列

```sql
SELECTc.cid,c.cname,max(sc.score)最高分,min(sc.score)最低分,ROUND(AVG(sc.score))平均分,count(sc.score)选修人数,CONCAT(ROUND(sum(if(sc.score>=60,1,0))/count(sc.score)*100),'%')及格率,CONCAT(ROUND(sum(if(sc.score>=70 and sc.score<80,1,0))/count(sc.score)*100),'%')中等率,CONCAT(ROUND(sum(if(sc.score>=80 and sc.score<90,1,0))/count(sc.score)*100),'%')优良率,CONCAT(ROUND(sum(if(sc.score>=90,1,0))/count(sc.score)*100),'%')优秀率FROMt_mysql_score sc,t_mysql_course c,t_mysql_student sWHEREsc.sid=s.sid and sc.cid=c.cidGROUP BYc.cid,c.cnameORDER BY选修人数 desc,c.cid
```

### CASE 函数的详解

在 MySQL 数据库中，CASE 函数是一种条件表达式函数，它允许根据条件的结果返回不同的值。CASE 函数有两种形式：简单 CASE 表达式和搜索 CASE 表达式。

#### 1\. 简单 CASE 表达式：

简单 CASE 表达式用于对单个表达式进行多个条件的比较，语法如下：

```sql
CASE expression    WHEN value1 THEN result1    WHEN value2 THEN result2    ...    ELSE resultEND
```

expression 是需要进行比较的表达式（是可以省略的），value1、value2 等是待比较的值，result1、result2 等是满足条件时返回的结果，ELSE 子句用于指定当没有条件匹配时的默认结果（也是可以省略的）。

**用上面的第 14 题举例**

> **case when sc.cid='01' then sc.score end**
>
> - **case 后面的表达式和 else 后面的子句都进行了省略**
> - **sc.cid='01'是需要被比较的值，当它成立时，便输出 sc.score**

#### 2\. 搜索 CASE 表达式：

搜索 CASE 表达式用于根据多个条件进行比较，并返回满足条件的第一个结果。它的语法如下：

```sql
CASE    WHEN condition1 THEN result1    WHEN condition2 THEN result2    ...    ELSE resultEND
```

condition1、condition2 等是待比较的条件表达式，result1、result2 等是满足条件时返回的结果，ELSE 子句用于指定当没有条件匹配时的默认结果。

> 总结而言，CASE 函数在 MySQL 数据库中用于根据条件返回不同的值。简单 CASE 表达式适用于对单个表达式进行多个条件比较，而搜索 CASE 表达式适用于根据多个条件进行比较。它们可以在 SELECT 语句中使用，并且可以与其他函数和条件表达式组合使用。

### if 函数详解

MySQL 数据库中的 IF 函数是一个条件表达式函数，它允许根据条件的结果返回不同的值。IF 函数的语法如下：

```sql
IF(condition, value_if_true, value_if_false)
```

condition 是一个布尔表达式或条件，value_if_true 是当条件为真时返回的值，value_if_false 是当条件为假时返回的值。

**用上面的第 15 题举例**

> **if(sc.score>=60,1,0)**
>
> **如果 sc.score 大于 60 分，就输出 1，否则就输出 0**

> 总结而言，IF 函数在 MySQL 数据库中用于根据条件返回不同的值，它可以在 SELECT、INSERT、UPDATE 等语句中使用，并且可以与其他函数和运算符组合使用。

一起进步吧！！！✌✌✌
