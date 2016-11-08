---
type: docs
---

## Introduction

**Zman** is a PHP package that makes Jewish date conversions simple and easy.

The `Zman` class is inherited from the amazing [briannesbitt/Carbon](https://github.com/briannesbitt/Carbon) which in turn inherits from PHP's [DateTime](http://www.php.net/manual/en/class.datetime.php) class, thus giving us access to some pretty nifty methods.

## Getting Started

This is pre-release, so it is not available yet for installation. Check back soon iy"H.

## Instantiation

There are four different ways to create a new instance of `Zman`.

``` PHP
$zman = new Zman('first day of November 2016');
$zman = new Zman('November 3, 2016');

$zman = Zman::parse('first day of November 2016');
$zman = Zman::parse('November 3, 2016');

$zman = Zman::createFromDate(1967, 10, 6);

$zman = Zman::now();
```

## Getters

The following getters are implemented via PHP's <em>`__get()`</em> method. This enables access to the value as if it was a property rather than a function call.

```PHP
$zman = Carbon::parse('2012-9-5 23:26:11.123789');

var_dump($zman->month);                           // int(13)
var_dump($zman->day);                             // int(18)
var_dump($zman->year);                            // int(5772)

// inherited from Carbon\Carbon
var_dump($zman->hour);                            // int(23)
var_dump($zman->minute);                          // int(26)
var_dump($zman->second);                          // int(11)
var_dump($zman->micro);                           // int(123789)
var_dump($zman->dayOfWeek);                       // int(3)
var_dump($zman->dayOfYear);                       // int(248)
var_dump($zman->weekOfMonth);                     // int(1)
var_dump($zman->weekOfYear);                      // int(36)
var_dump($zman->daysInMonth);                     // int(30)
var_dump($zman->timestamp);                       // int(1346901971)
var_dump($zman->age);                             // int(4) calculated vs now in the same tz
var_dump($zman->quarter);                         // int(3)
```

<p class="tip">Note that only the `month`, `day`, and `year` getters will return the converted Jewish date. The other getters directly inherit from `Carbon\Carbon` and reflect the Gregorian date.</p>

## Setters

The following setters are implemented via PHP's <em>`__set()`</em> method. No validation is performed whatsoever so only use these methods if you're sure you know what you're doing.

``` PHP
// day
$zman = Zman::parse('November 7, 2016');
var_dump($zman->day);                             // int(6)

$zman->day = 10;
var_dump($zman->day);                             // int(10)

$zman->day(14);
var_dump($zman->day);                             // int(14)

// month
$zman = Zman::parse('November 7, 2016');
var_dump($zman->month);                           // int(2)

$zman->month = 4;
var_dump($zman->month);                           // int(4)

$zman->month(6);
var_dump($zman->month);                           // int(6)

// year
$zman = Zman::parse('November 7, 2016');
var_dump($zman->year);                            // int(5777)

$zman->year = 5000;
var_dump($zman->year);                            // int(5000)

$zman->year(5050);
var_dump($zman->year);                            // int(5050)

// etc.
```

<p class="tip">Note that only the `month`, `day`, and `year` setters will affect the converted Jewish date. The other setters directly inherit from `Carbon\Carbon` and reflect the Gregorian date.</p>

## String Formats

## Parshas HaShavua (Coming Soon)

Coming Soon!

## Moadim

There are convenience methods both for finding the Gregorian date of any holiday for a given year, as well as checking if a specific Gregorian date is any of the holidays.

### Holidays

``` PHP
Zman::firstDayOfRoshHashana('5777')->toFormattedDateString(); // Oct 3, 2016
Zman::parse('October 3, 2016')->isRoshHashana();              // true

Zman::dayOfYomKippur('5777')->toFormattedDateString();        // Oct 12, 2016
Zman::parse('Oct 12, 2016')->isYomKippur();                   // true

Zman::firstDayOfSukkos('5777')->toFormattedDateString();      // Oct 17, 2016
Zman::parse('Oct 17, 2016')->isSukkos();                      // true

Zman::dayOfShminiAtzeres('5777')->toFormattedDateString();    // Oct 24, 2016
Zman::parse('Oct 24, 2016')->isShminiAtzeres();               // true

Zman::dayOfSimchasTorah('5777')->toFormattedDateString();     // Oct 25, 2016
Zman::parse('Oct 25, 2016')->isSimchasTorah();                // true

Zman::firstDayOfChanuka('5777')->toFormattedDateString();     // Dec 25, 2016
Zman::parse('Dec 25, 2016')->isChanuka();                     // true

Zman::dayOfTuBishvat('5777')->toFormattedDateString();        // Feb 11, 2017
Zman::parse('Feb 11, 2017')->isTuBishvat();                   // true

Zman::dayOfPurim('5777')->toFormattedDateString();            // Mar 12, 2017
Zman::parse('Mar 12, 2017')->isPurim();                       // true

Zman::dayOfShushanPurim('5777')->toFormattedDateString();     // Mar 13, 2017
Zman::parse('March 13, 2017')->isShushanPurim();              // true

Zman::dayOfPurimKattan('5779')->toFormattedDateString();      // Feb 19, 2019
Zman::parse('Feb 19, 2019')->isPurimKattan();                 // true

Zman::firstDayOfPesach('5777')->toFormattedDateString();      // Apr 11, 2017
Zman::parse('Apr 11, 2017')->isPesach();                      // true

Zman::dayOfPesachSheni('5777')->toFormattedDateString();      // May 10, 2017
Zman::parse('May 10, 2017')->isPesachSheni();                 // true

Zman::firstDayOfShavuos('5777')->toFormattedDateString();     // May 31, 2017
Zman::parse('May 31, 2017')->isShavuos();                     // true
```
Leap years are taken care of so you don't need to worry about it.

<p class="tip">Outside of <em>Eretz Yisroel</em> is the default setting. To find the value specific to Israel pass `false` as the second parameter. (e.g. `Zman::dayOfSimchasTorah('5777', false)`)</p>

### Yuntif

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

``` PHP
Zman::parse('April 13, 2017')->isCholHamoedPesach();    // true
Zman::parse('October 19, 2016')->isCholHamoedSukkos();  // true
Zman::parse('April 13, 2017')->isCholHamoed();          // true
```

### Rosh Chodesh
``` PHP
Zman::parse('November 1, 2016')->isRoshChodesh();       // true
Zman::parse('November 2, 2016')->isRoshChodesh();       // true
Zman::parse('November 3, 2016')->isRoshChodesh();       // false
```

### Fast Days
``` PHP
Zman::parse('October 12, 2016')->isYomKippur();         // true
Zman::parse('October 5, 2016')->isTzomGedaliah();       // true
Zman::parse('January 8, 2017')->isAsaraBiteives();      // true
Zman::parse('February 28, 2018')->isTaanisEsther();     // true
Zman::parse('July 11, 2017')->isShivaAsarBitamuz();     // true
Zman::parse('August 1, 2017')->isTishaBav();            // true
Zman::parse('October 5, 2016')->isFastDay());           // true
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

A few handy boolean checks have been implemented to check for special additions to <em>davening</em>.

### Leining

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
