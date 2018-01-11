---
type: docs
---

## Introduction

**Zman** is a PHP package that makes Jewish date conversions simple and easy.

The `Zman` class is inherited from the amazing [briannesbitt/Carbon](https://github.com/briannesbitt/Carbon) which in turn inherits from PHP's [DateTime](http://www.php.net/manual/en/class.datetime.php) class, thus giving us access to some pretty nifty methods.

## Getting Started

#### Use Composer

```bash
$ composer require zman/zman
```

``` PHP
<?php

use Zman\Zman;

printf("Now: %s", Zman::now()->toFormattedJewishDateString());
```


## Instantiation

There are five different ways to create a new instance of `Zman`.

``` PHP
$zman = new Zman('first day of November 2016');
$zman = new Zman('November 3, 2016');

$zman = Zman::parse('first day of November 2016');
$zman = Zman::parse('November 3, 2016');

$zman = Zman::createFromDate(1967, 10, 6);

$zman = Zman::createJewishDate(5777, 1, 1);

$zman = Zman::now();
```

## Conversions

Every instance of `Zman` contains information about a day's Gregorian calendar date as well as its Jewish calendar date. Thus, for any conversion, simply create a new instance of `Zman` with the day in question (Gregorian or Jewish) and access the desired converted properties.

For example:

```PHP
$zman = Zman::createFromDate(1993, 2, 21);

echo $zman->jewishDay;                               // 30
echo $zman->jewishMonth;                             // 5
echo $zman->jewishYear;                              // 5753
echo $zman->toFormattedJewishDateString();           // 30 Shvat, 5753
echo $zman->toFormattedJewishHebrewDateString();     // ל׳ שבט, תשנ״ג


$zman = Zman::createFromJewishDate(5753, 5, 30);

echo $zman->day;                                     // 21
echo $zman->month;                                   // 2
echo $zman->year;                                    // 1993
echo $zman->toFormattedDateString();                 // Feb 21, 1993
```


## String Formats
All of the `toXXXString()` methods defined by [Carbon](http://carbon.nesbot.com/docs/#api-formatting) are also available on `Zman`. Additionally, there are a few methods specific to printing the Jewish date as a string in both English and Hebrew.

```PHP
$zman = Zman::parse('1993-2-21 14:15:16');

echo $zman->toJewishDateString();                    // 5753-5-30
echo $zman->toJewishDateTimeString();                // 5753-5-30 14:15:16
echo $zman->toFormattedJewishDateString();           // 30 Shvat, 5753
echo $zman->toFormattedJewishHebrewDateString();     // ל׳ שבט, תשנ״ג
```

Of course, you can always build up your own string by combining the [getters](#Getters).

## Getters

`Zman` inherits all getters from [Carbon](http://carbon.nesbot.com/docs/#api-getters), so you'll always have `month`, `day`, `year`, `hour`, `dayOfWeek`, etc. Additionally, `Zman` provides getters specific to its Jewish date properties.

The getters are implemented via PHP's <em>`__get()`</em> method, enabling access to the value as if it was a property rather than a function call.

```PHP
$zman = Zman::parse('1993-2-21 23:26:11.123789');

echo $zman->jewishDay;                                // 30
echo $zman->jewishMonth;                              // 5
echo $zman->jewishMonthName;                          // Shvat
echo $zman->jewishYear;                               // 5753

echo $zman->jewishDayHebrew                           // ל׳
echo $zman->jewishMonthNameHebrew;                    // שבט
echo $zman->jewishYearHebrew                          // תשנ״ג
```

## Setters

`Zman` inherits all setters from [Carbon](http://carbon.nesbot.com/docs/#api-setters), so you'll always have `month`, `day`, `year`, `hour`, `dayOfWeek`, etc. Additionally, `Zman` provides setters specific to its Jewish date properties. However, no validation is performed whatsoever for the Jewish properties so only use these methods if you're sure you know what you're doing.

The setters are implemented via PHP's <em>`__set()`</em> method, enabling access to the value as if it was a property rather than a function call.

``` PHP
$zman = Zman::parse('February 21, 1993');

echo $zman->jewishDay                             // 30
$zman->jewishDay = 10
echo $zman->jewishDay                             // 10

echo $zman->jewishMonth                           // 2
$zman->jewishMonth = 10
echo $zman->jewishMonth                           // 10

echo $zman->jewishYear                            // 5753
$zman->jewishYear = 10
echo $zman->jewishYear                            // 10
```

## Addition and Subtraction

Since `Zman` inherits Carbon, all of the addition and subtraction methods Carbon provides are available (`addDay`, `addMonth`, etc.). See the [Carbon docs](http://carbon.nesbot.com/docs/#api-addsub) for more information.

## Parshas HaShavua

The <em>Parshas Hashavua </em> for any date can be retrieved via the `parsha` getter. A few examples are shown below.

``` PHP
Zman::parse('10/26/16')->parsha          // Breishis
Zman::parse('11/1/16')->parsha           // Noach
Zman::parse('2/22/17')->parsha           // Mishpatim
Zman::parse('5/4/17')->parsha            // Acharei Mos - Kedoshim
Zman::parse('9/21/17')->parsha           // Haazinu
```

In addition, the <em>Parshas Hashavua</em> can be retrieved in Hebrew.
``` PHP
Zman::parse('10/26/16')->parshaHebrew          // בראשית
Zman::parse('11/1/16')->parshaHebrew           // נח
Zman::parse('2/22/17')->parshaHebrew           // משפטים
Zman::parse('5/4/17')->parshaHebrew            // אחרי מות - קדושים
Zman::parse('9/21/17')->parshaHebrew           // האזינו
```

## Moadim

In addition to manually converting dates, `Zman` supports finding and checking for all of the Jewish holidays and Moadim. Leap years and days that are <em>nidchech</em> are taken care of so you don't need to worry about it.

### Holidays

There are convenience methods for finding the Gregorian date of any holiday for a given year, as well as checking if a specific Gregorian date is any of the holidays.

#### Rosh Hashana
``` PHP
Zman::firstDayOfRoshHashana('5777')->toFormattedDateString(); // Oct 3, 2016
Zman::parse('October 3, 2016')->isRoshHashana();              // true
```

#### Yom Kippur
``` PHP
Zman::dayOfYomKippur('5777')->toFormattedDateString();        // Oct 12, 2016
Zman::parse('Oct 12, 2016')->isYomKippur();                   // true
```

#### Sukkos
``` PHP
Zman::firstDayOfSukkos('5777')->toFormattedDateString();      // Oct 17, 2016
Zman::parse('Oct 17, 2016')->isSukkos();                      // true
```

#### Shmini Atzeres
``` PHP
Zman::dayOfShminiAtzeres('5777')->toFormattedDateString();    // Oct 24, 2016
Zman::parse('Oct 24, 2016')->isShminiAtzeres();               // true
```

#### Simchas Torah
``` PHP
Zman::dayOfSimchasTorah('5777')->toFormattedDateString();     // Oct 25, 2016
Zman::parse('Oct 25, 2016')->isSimchasTorah();                // true
```

#### Chanuka
``` PHP
Zman::firstDayOfChanuka('5777')->toFormattedDateString();     // Dec 25, 2016
Zman::parse('Dec 25, 2016')->isChanuka();                     // true
```

#### Tu Bishvat
``` PHP
Zman::dayOfTuBishvat('5777')->toFormattedDateString();        // Feb 11, 2017
Zman::parse('Feb 11, 2017')->isTuBishvat();                   // true
```

#### Purim
``` PHP
Zman::dayOfPurim('5777')->toFormattedDateString();            // Mar 12, 2017
Zman::parse('Mar 12, 2017')->isPurim();                       // true
```

#### Shushan Purim
``` PHP
Zman::dayOfShushanPurim('5777')->toFormattedDateString();     // Mar 13, 2017
Zman::parse('March 13, 2017')->isShushanPurim();              // true
```

#### Purim Kattan
``` PHP
Zman::dayOfPurimKattan('5779')->toFormattedDateString();      // Feb 19, 2019
Zman::parse('Feb 19, 2019')->isPurimKattan();                 // true
```

#### Pesach
``` PHP
Zman::firstDayOfPesach('5777')->toFormattedDateString();      // Apr 11, 2017
Zman::parse('Apr 11, 2017')->isPesach();                      // true
```

#### Pesach Sheni
``` PHP
Zman::dayOfPesachSheni('5777')->toFormattedDateString();      // May 10, 2017
Zman::parse('May 10, 2017')->isPesachSheni();                 // true
```

#### Shavuos
``` PHP
Zman::firstDayOfShavuos('5777')->toFormattedDateString();     // May 31, 2017
Zman::parse('May 31, 2017')->isShavuos();                     // true
```

<p class="tip">Outside of <em>Eretz Yisroel</em> is the default setting. To find the value specific to Israel pass `false` as the second parameter. (e.g. `Zman::dayOfSimchasTorah('5777', false)`)</p>


### Fast Days

There are convenience methods for finding the Gregorian date of any fast day for a given year, as well as checking if a specific Gregorian date is any of the fast days.

#### Yom Kippur
``` PHP
Zman::dayOfYomKippur('5777')->toFormattedDateString());       // Oct 12, 2016
Zman::parse('October 12, 2016')->isYomKippur();               // true
```

#### Tzom Gedaliah
``` PHP
Zman::dayOfTzomGedaliah(5777)->toFormattedDateString());      // Oct 5, 2016
Zman::parse('October 5, 2016')->isTzomGedaliah();             // true
```

#### Asara Biteives
``` PHP
Zman::dayOfAsaraBiteives(5777)->toFormattedDateString();      // Jan 8, 2017
Zman::parse('January 8, 2017')->isAsaraBiteives();            // true
```

#### Taanis Esther
``` PHP
Zman::dayOfTaanisEsther(5777)->toFormattedDateString();       // Mar 9, 2017
Zman::parse('February 28, 2018')->isTaanisEsther();           // true
```

#### Shiva Asar Bitamuz
``` PHP
Zman::dayOfShivaAsarBitamuz(5777)->toFormattedDateString();   // Jul 11, 2017
Zman::parse('July 11, 2017')->isShivaAsarBitamuz();           // true
```

#### Tisha Bav
``` PHP
Zman::dayOfTishaBav(5777)->toFormattedDateString();           // Aug 1, 2017
Zman::parse('August 1, 2017')->isTishaBav();                  // true
```

#### General
``` PHP
Zman::parse('October 5, 2016')->isFastDay());                 // true
```

### Yuntif

In some cases you may want to check if it is actually <em>Yuntif</em>. Here's how you can:

``` PHP
Zman::parse('April 11, 2017')->isPesachYuntif();      // true  - Pesach
Zman::parse('April 13, 2017')->isPesachYuntif();      // false - Chol HaMoed
Zman::parse('April 17, 2017')->isPesachYuntif();      // true  - Pesach
Zman::parse('May 31, 2017')->isYuntif();              // true  - Shavuos
Zman::parse('October 17, 2016')->isSukkosYuntif();    // true  - Sukkos
Zman::parse('October 20, 2016')->isSukkosYuntif();    // false - Chol HaMoed
Zman::parse('October 3, 2016')->isYuntif();           // true  - Rosh Hashana
Zman::parse('December 17, 2017')->isYuntif();         // false - Chanuka

// etc.
```

### Chol Hamoed

In some cases you may want to check if it is <em>Chol Hamoed</em>. Here's how you can:

``` PHP
Zman::parse('April 13, 2017')->isCholHamoed();          // true
Zman::parse('April 13, 2017')->isCholHamoedPesach();    // true
Zman::parse('October 19, 2016')->isCholHamoedSukkos();  // true
```

### Rosh Chodesh
``` PHP
Zman::parse('November 1, 2016')->isRoshChodesh();       // true
Zman::parse('November 2, 2016')->isRoshChodesh();       // true
Zman::parse('November 3, 2016')->isRoshChodesh();       // false
```

### Aseres Yimei Teshuva
``` PHP
Zman::parse('September 21, 2017')->isAseresYimeiTeshuva(); // true
Zman::parse('September 22, 2017')->isAseresYimeiTeshuva(); // true
Zman::parse('September 23, 2017')->isAseresYimeiTeshuva(); // true
Zman::parse('September 24, 2017')->isAseresYimeiTeshuva(); // true
Zman::parse('September 25, 2017')->isAseresYimeiTeshuva(); // true
Zman::parse('September 26, 2017')->isAseresYimeiTeshuva(); // true
Zman::parse('September 27, 2017')->isAseresYimeiTeshuva(); // true
Zman::parse('September 28, 2017')->isAseresYimeiTeshuva(); // true
Zman::parse('September 29, 2017')->isAseresYimeiTeshuva(); // true
Zman::parse('September 30, 2017')->isAseresYimeiTeshuva(); // true

Zman::parse('October 23, 2017')->isAseresYimeiTeshuva();   // false
```

## Davening

A few handy **boolean** checks have been implemented to check for special additions to <em>davening</em>.

### Leining

To check if a day has leining, just use the `hasLeining` method.

``` PHP
Zman::parse('November 7, 2016')->hasLeining();    // true - Monday
Zman::parse('November 10, 2016')->hasLeining();   // true - Thursday
Zman::parse('November 12, 2016')->hasLeining();   // true - Shabbos
Zman::parse('November 1, 2016')->hasLeining();    // true - Rosh Chodesh
Zman::parse('January 8, 2017')->hasLeining();     // true - Fast Day
Zman::parse('April 11, 2017')->hasLeining();      // true - Yuntif
Zman::parse('April 14, 2017')->hasLeining();      // true - Chol HaMoed
Zman::parse('December 27, 2016')->hasLeining();   // true - Chanuka
Zman::parse('March 12, 2017')->hasLeining();      // true - Purim

Zman::parse('November 6, 2016')->hasLeining();    // false - Average day
```

To check if a day has leining during a specific minyan, use the `leiningAt` method as shown below.
``` PHP
// Weekdays
Zman::parse('November 7, 2016')->leiningAt('shacharis')     // Lech Licha

// Holidays
Zman::parse('December 27, 2016')->leiningAt('shacharis')    // Chanuka

// Shabbos Mincha
Zman::parse('November 12, 2016')->leiningAt('mincha')       // Vayera

// Shabbos & Rosh Chodesh
Zman::parse('January 28, 2017')->leiningAt('shacharis')     // Vaeira & Rosh Chodesh
```


### Hallel

``` PHP
Zman::parse('April 18, 2017')->hasHallel();       // true - Pesach
Zman::parse('June 1, 2017')->hasHallel();         // true - Shavuos
Zman::parse('October 23, 2016')->hasHallel();     // true - Sukkos
Zman::parse('October 24, 2016')->hasHallel();     // true - Shmini Atzeres
Zman::parse('October 25, 2016')->hasHallel();     // true - Simchas Torah
Zman::parse('January 1, 2017')->hasHallel();      // true - Chanuka
Zman::parse('November 1, 2016')->hasHallel();     // true - Rosh Chodesh

Zman::parse('March 12, 2017')->hasHallel();       // false - Purim
```

### Mussaf

``` PHP
Zman::parse('November 1, 2016')->hasMussaf();    // true - Rosh Chodesh
Zman::parse('April 11, 2017')->hasMussaf();      // true - Yuntif
Zman::parse('April 13, 2017')->hasMussaf();      // true - Chol HaMoed

Zman::parse('December 20, 2017')->hasMussaf();   // false - Chanuka
```

### Slichos

Besides for checking if a given day has <em>slichos</em>, the first day of <em>slichos</em> for both <em>ashkenazim</em> and <em>sfardim</em> before the <em>Yomim Noraim</em> is available via a helper method.

``` PHP
Zman::firstDayOfSfardiSlichos('5776')->toFormattedDateString();     // Sep 4, 2016
Zman::firstDayOfAshkenaziSlichos('5776')->toFormattedDateString();  // Sep 25, 2016

Zman::firstDayOfSlichos('5777', true)->toFormattedDateString();     // Sep 4, 2016
Zman::firstDayOfSlichos('5777', false)->toFormattedDateString();    // Sep 25, 2016

Zman::parse('September 17, 2017')->hasSlichos();                    // true
Zman::parse('September 11, 2017')->hasSlichos(true);                // true
Zman::parse('September 11, 2017')->hasSlichos();                    // false
Zman::parse('December 11, 2017')->hasSlichos();                     // false
```

<p class="tip">The default value for <em>slichos</em> is <em>ashkenazi</em>. To check for <em>sfardi</em> values pass `true` as a parameter.</p>

## Zmanim (Coming Soon)

Coming Soon!
