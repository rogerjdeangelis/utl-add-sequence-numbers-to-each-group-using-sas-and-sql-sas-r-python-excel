%let pgm=utl-add-sequence-numbers-to-each-group-using-sas-and-sql-sas-r-python-excel;

%stop_submission;

post too long see github

Add sequence numbers to each group using sas and sql sas r python excel

I need to enumerate test grades
by student, testdate and subject
Data is already sorted by student and date.
This allows us to compare the
second test score by student and subject?

CONTENT

  1 sas base
  2 r sql
    for python and excel see
    https://tinyurl.com/4e6yaap8
  3 related repos
    partitioning has many applications

github
https://tinyurl.com/yjeyyh6n
https://github.com/rogerjdeangelis/utl-add-sequence-numbers-to-each-group-using-sas-and-sql-sas-r-python-excel

ommunities.sas
https://tinyurl.com/ye25r6dc
https://communities.sas.com/t5/SAS-Programming/Enumerate-by-group-but-sorted-by-dates/td-p/811855

For python and excel solutions see
https://tinyurl.com/4e6yaap8
https://github.com/rogerjdeangelis/utl-identify-changes-in-all-variable-values-between-phase1-and-phase2-trials


/**************************************************************************************************************************/
/*            INPUT             |            PROCESS                          |                  OUTPUT                   */
/*           =====              |            =======                          |                  ======                   */
/* options validvarname=upcase; | I need to enumerate test grades             | STUDENT  TESTDATE   COUNT  SUBJECT GRADE  */
/* libname sd1 "d:/sd1";        | by student, testdate and subject            |                                           */
/* data sd1.have;               | Data is already sorted by student and date. |  Alice  2022-04-15    1    english   91   */
/*   input student$ testdate$10.| This allows us to compare the               |  Alice  2022-05-01    2    english   72   */
/*    subject$ grade;           | second test score by student and subject?   |                                           */
/* cards4;                      |                                             |  Alice  2022-01-28    1    history   93   */
/* Alice 2022-01-28 history  93 | 1 BASE SAS                                  |  Alice  2022-02-15    2    history   88   */
/* Alice 2022-02-15 history  88 | ==========                                  |  Alice  2022-02-28    3    history   78   */
/* Alice 2022-02-28 history  78 |                                             |  Alice  2022-02-28    4    history   78   */
/* Alice 2022-02-28 history  78 | data want;                                  |                                           */
/* Alice 2022-03-01 science  81 |   retain count 0;                           |  Alice  2022-03-01    1    science   81   */
/* Alice 2022-04-01 science  66 |   set sd1.have;                             |  Alice  2022-04-01    2    science   66   */
/* Alice 2022-04-15 english  91 |   by  subject notsorted;                    |                                           */
/* Alice 2022-05-01 english  72 |   count=ifn(first.subject,1,count+1);       |  James  2021-12-21    1    history   66   */
/* James 2021-12-21 history  66 | run;                                        |  James  2022-01-20    2    history   70   */
/* James 2022-01-20 history  70 |                                             |                                           */
/* James 2022-03-18 science  96 |                                             |  James  2022-04-04    1    physics   67   */
/* James 2022-04-04 physics  67 |                                             |  James  2022-05-03    2    physics   87   */
/* James 2022-05-03 physics  87 |                                             |                                           */
/* Janet 2022-02-16 history  79 |                                             |  James  2022-03-18    1    science   96   */
/* Janet 2022-03-10 history  81 |                                             |                                           */
/* Janet 2022-04-03 physics  88 |                                             |  Janet  2022-02-16    1    history   79   */
/* ;;;;                         |                                             |  Janet  2022-03-10    2    history   81   */
/* run;quit;                    |                                             |                                           */
/*                              |                                             |  Janet  2022-04-03    1    physics   88   */
/*                              |                                             |                                           */
/*                              |                                             |                                           */
/*                              |-----------------------------------------------------------------------------------------*/
/*                              | 2 R SQL FOR PYTHON AND EXCEL SEE            |  R                                 PART-  */
/*                              | https://tinyurl.com/4e6yaap8                |  STUDENT   TESTDATE SUBJECT GRADE TITION  */
/*                              | ================================            |                                           */
/*                              |                                             |    Alice 2022-04-15 english    91      1  */
/*                              | proc datasets lib=sd1 nolist nodetails;     |    Alice 2022-05-01 english    72      2  */
/*                              |  delete want;                               |    Alice 2022-01-28 history    93      1  */
/*                              | run;quit;                                   |    Alice 2022-02-15 history    88      2  */
/*                              |                                             |    Alice 2022-02-28 history    78      3  */
/*                              | %utl_rbeginx;                               |    Alice 2022-02-28 history    78      4  */
/*                              | parmcards4;                                 |    Alice 2022-03-01 science    81      1  */
/*                              | library(haven)                              |    Alice 2022-04-01 science    66      2  */
/*                              | library(sqldf)                              |    James 2021-12-21 history    66      1  */
/*                              | source("c:/oto/fn_tosas9x.R")               |    James 2022-01-20 history    70      2  */
/*                              | options(sqldf.dll = "d:/dll/sqlean.dll")    |    James 2022-04-04 physics    67      1  */
/*                              | have<-read_sas("d:/sd1/have.sas7bdat")      |    James 2022-05-03 physics    87      2  */
/*                              | print(have)                                 |    James 2022-03-18 science    96      1  */
/*                              | want<-sqldf('                               |    Janet 2022-02-16 history    79      1  */
/*                              | select                                      |    Janet 2022-03-10 history    81      2  */
/*                              |    student                                  |    Janet 2022-04-03 physics    88      1  */
/*                              |   ,testdate                                 |                                           */
/*                              |   ,subject                                  |                                           */
/*                              |   ,grade                                    |  SAS                               PART-  */
/*                              |   ,partition                                |  STUDENT  TESTDATE   SUBJECT GRADE TITION */
/*                              | from                                        |                                           */
/*                              |   (select                                   |    Alice  2022-04-15  english   91    1   */
/*                              |      *                                      |    Alice  2022-05-01  english   72    2   */
/*                              |     ,row_number()                           |    Alice  2022-01-28  history   93    1   */
/*                              |   over                                      |    Alice  2022-02-15  history   88    2   */
/*                              |     (partition by student,subject)          |    Alice  2022-02-28  history   78    3   */
/*                              |     as partition from have)                 |    Alice  2022-02-28  history   78    4   */
/*                              | ')                                          |    Alice  2022-03-01  science   81    1   */
/*                              | want                                        |    Alice  2022-04-01  science   66    2   */
/*                              | fn_tosas9x(                                 |    James  2021-12-21  history   66    1   */
/*                              |       inp    = want                         |    James  2022-01-20  history   70    2   */
/*                              |      ,outlib ="d:/sd1/"                     |    James  2022-04-04  physics   67    1   */
/*                              |      ,outdsn ="want"                        |    James  2022-05-03  physics   87    2   */
/*                              |      )                                      |    James  2022-03-18  science   96    1   */
/*                              | ;;;;                                        |    Janet  2022-02-16  history   79    1   */
/*                              | %utl_rendx;                                 |    Janet  2022-03-10  history   81    2   */
/*                              |                                             |    Janet  2022-04-03  physics   88    1   */
/*                              | proc print data=sd1.want;                   |                                           */
/*                              | run;quit;                                   |                                           */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
  input student$ testdate$10.
   subject$ grade;
cards4;
Alice 2022-01-28 history  93
Alice 2022-02-15 history  88
Alice 2022-02-28 history  78
Alice 2022-02-28 history  78
Alice 2022-03-01 science  81
Alice 2022-04-01 science  66
Alice 2022-04-15 english  91
Alice 2022-05-01 english  72
James 2021-12-21 history  66
James 2022-01-20 history  70
James 2022-03-18 science  96
James 2022-04-04 physics  67
James 2022-05-03 physics  87
Janet 2022-02-16 history  79
Janet 2022-03-10 history  81
Janet 2022-04-03 physics  88
;;;;
run;quit;

/**************************************************************************************************************************/
/* STUDENT     TESTDATE     SUBJECT    GRADE                                                                              */
/*                                                                                                                        */
/*  Alice     2022-01-28    history      93                                                                               */
/*  Alice     2022-02-15    history      88                                                                               */
/*  Alice     2022-02-28    history      78                                                                               */
/*  Alice     2022-02-28    history      78                                                                               */
/*  Alice     2022-03-01    science      81                                                                               */
/*  Alice     2022-04-01    science      66                                                                               */
/*  Alice     2022-04-15    english      91                                                                               */
/*  Alice     2022-05-01    english      72                                                                               */
/*  James     2021-12-21    history      66                                                                               */
/*  James     2022-01-20    history      70                                                                               */
/*  James     2022-03-18    science      96                                                                               */
/*  James     2022-04-04    physics      67                                                                               */
/*  James     2022-05-03    physics      87                                                                               */
/*  Janet     2022-02-16    history      79                                                                               */
/*  Janet     2022-03-10    history      81                                                                               */
/*  Janet     2022-04-03    physics      88                                                                               */
/**************************************************************************************************************************/

/*   _
/ | | |__   __ _ ___  ___   ___  __ _ ___
| | | `_ \ / _` / __|/ _ \ / __|/ _` / __|
| | | |_) | (_| \__ \  __/ \__ \ (_| \__ \
|_| |_.__/ \__,_|___/\___| |___/\__,_|___/

*/

data want;
  set sd1.have;
  by  subject notsorted;
  count=ifn(first.subject,1,count+1);
  retain count 0;
run;

/**************************************************************************************************************************/
/* STUDENT     TESTDATE     SUBJECT    GRADE    COUNT                                                                     */
/*                                                                                                                        */
/*  Alice     2022-01-28    history      93       1                                                                       */
/*  Alice     2022-02-15    history      88       2                                                                       */
/*  Alice     2022-02-28    history      78       3                                                                       */
/*  Alice     2022-02-28    history      78       4                                                                       */
/*  Alice     2022-03-01    science      81       1                                                                       */
/*  Alice     2022-04-01    science      66       2                                                                       */
/*  Alice     2022-04-15    english      91       1                                                                       */
/*  Alice     2022-05-01    english      72       2                                                                       */
/*  James     2021-12-21    history      66       1                                                                       */
/*  James     2022-01-20    history      70       2                                                                       */
/*  James     2022-03-18    science      96       1                                                                       */
/*  James     2022-04-04    physics      67       1                                                                       */
/*  James     2022-05-03    physics      87       2                                                                       */
/*  Janet     2022-02-16    history      79       1                                                                       */
/*  Janet     2022-03-10    history      81       2                                                                       */
/*  Janet     2022-04-03    physics      88       1                                                                       */
/**************************************************************************************************************************/

/*___                     _
|___ \   _ __   ___  __ _| |
  __) | | `__| / __|/ _` | |
 / __/  | |    \__ \ (_| | |
|_____| |_|    |___/\__, |_|

                    |_|
*/
proc datasets lib=sd1 nolist nodetails;
 delete want;
run;quit;

%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
options(sqldf.dll = "d:/dll/sqlean.dll")
have<-read_sas("d:/sd1/have.sas7bdat")
print(have)
want<-sqldf('
select
   student
  ,testdate
  ,subject
  ,grade
  ,partition
from
  (select
     *
    ,row_number()
  over
    (partition by student,subject)
    as partition from have)
')
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/* R                                              SAS                                                                     */
/* STUDENT   TESTDATE SUBJECT GRADE PARTITION     ROWNAMES    STUDENT     TESTDATE     SUBJECT    GRADE    PARTITION      */
/*                                                                                                                        */
/*   Alice 2022-04-15 english    91         1         1        Alice     2022-04-15    english      91         1          */
/*   Alice 2022-05-01 english    72         2         2        Alice     2022-05-01    english      72         2          */
/*   Alice 2022-01-28 history    93         1         3        Alice     2022-01-28    history      93         1          */
/*   Alice 2022-02-15 history    88         2         4        Alice     2022-02-15    history      88         2          */
/*   Alice 2022-02-28 history    78         3         5        Alice     2022-02-28    history      78         3          */
/*   Alice 2022-02-28 history    78         4         6        Alice     2022-02-28    history      78         4          */
/*   Alice 2022-03-01 science    81         1         7        Alice     2022-03-01    science      81         1          */
/*   Alice 2022-04-01 science    66         2         8        Alice     2022-04-01    science      66         2          */
/*   James 2021-12-21 history    66         1         9        James     2021-12-21    history      66         1          */
/*   James 2022-01-20 history    70         2        10        James     2022-01-20    history      70         2          */
/*   James 2022-04-04 physics    67         1        11        James     2022-04-04    physics      67         1          */
/*   James 2022-05-03 physics    87         2        12        James     2022-05-03    physics      87         2          */
/*   James 2022-03-18 science    96         1        13        James     2022-03-18    science      96         1          */
/*   Janet 2022-02-16 history    79         1        14        Janet     2022-02-16    history      79         1          */
/*   Janet 2022-03-10 history    81         2        15        Janet     2022-03-10    history      81         2          */
/*   Janet 2022-04-03 physics    88         1        16        Janet     2022-04-03    physics      88         1          */
/**************************************************************************************************************************/

/*____           _       _           _
|___ /  _ __ ___| | __ _| |_ ___  __| |  _ __ ___ _ __   ___  ___
  |_ \ | `__/ _ \ |/ _` | __/ _ \/ _` | | `__/ _ \ `_ \ / _ \/ __|
 ___) || | |  __/ | (_| | ||  __/ (_| | | | |  __/ |_) | (_) \__ \
|____/ |_|  \___|_|\__,_|\__\___|\__,_| |_|  \___| .__/ \___/|___/
                                          |_|
*/

REPO
----------------------------------------------------------------------------------------------------------------------------------------
https://github.com/rogerjdeangelis/utl-adding-sequence-numbers-and-partitions-in-SAS-sql-without-using-monotonic
https://github.com/rogerjdeangelis/utl-create-equally-spaced-values-using-partitioning-in-sql-wps-r-python
https://github.com/rogerjdeangelis/utl-create-primary-key-for-duplicated-records-using-sql-partitionaling-and-pivot-wide-sas-python-r
https://github.com/rogerjdeangelis/utl-find-first-n-observations-per-category-using-proc-sql-partitioning
https://github.com/rogerjdeangelis/utl-flag-second-duplicate-using-base-sas-and-sql-sas-python-and-r-partitioning-multi-language
https://github.com/rogerjdeangelis/utl-incrementing-by-one-for-each-new-group-of-records-sas-r-python-sql-partitioning
https://github.com/rogerjdeangelis/utl-macro-to-enable-sql-partitioning-by-groups-montonic-first-and-last-dot
https://github.com/rogerjdeangelis/utl-maintaining-the-orginal-order-while-partitioning-groups-using-sql-partitioning
https://github.com/rogerjdeangelis/utl-partitioning-your-table-for-a-big-parallel-systask-sort
https://github.com/rogerjdeangelis/utl-pivot-long-pivot-wide-transpose-partitioning-sql-arrays-wps-r-python
https://github.com/rogerjdeangelis/utl-pivot-transpose-by-id-using-wps-r-python-sql-using-partitioning
https://github.com/rogerjdeangelis/utl-sql-partitioning-increase-in-investment-when-interest-rates-change-over-time-compound-interest
https://github.com/rogerjdeangelis/utl-top-four-seasonal-precipitation-totals--european-cities-sql-partitions-in-wps-r-python
https://github.com/rogerjdeangelis/utl-transpose-pivot-wide-using-sql-partitioning-in-wps-r-python
https://github.com/rogerjdeangelis/utl-transposing-rows-to-columns-using-proc-sql-partitioning
https://github.com/rogerjdeangelis/utl-transposing-words-into-sentences-using-sql-partitioning-in-r-and-python
https://github.com/rogerjdeangelis/utl-using-DOW-loops-to-identify-different-groups-and-partition-data
https://github.com/rogerjdeangelis/utl-using-sql-in-wps-r-python-select-the-four-youngest-male-and-female-students-partitioning
https://github.com/rogerjdeangelis/utl_partition_a_list_of_numbers_into_3_groups_that_have_the_similar_sums_python
https://github.com/rogerjdeangelis/utl_partition_a_list_of_numbers_into_k_groups_that_have_the_similar_sums
https://github.com/rogerjdeangelis/utl_scalable_partitioned_data_to_find_statistics_on_a_column_by_a_grouping_variable

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
