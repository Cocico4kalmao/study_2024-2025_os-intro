---
## Front matter
title: "Лабораторная работа №1"
subtitle: "Дисциплина: Архитектура компьютера"
author: "Орлов Илья Сергеевич"

## Generic otions
lang: ru-RU
toc-title: "Содержание"

## Bibliography
bibliography: bib/cite.bib
csl: pandoc/csl/gost-r-7-0-5-2008-numeric.csl

## Pdf output format
toc: true # Table of contents
toc-depth: 2
lof: true # List of figures
lot: true # List of tables
fontsize: 12pt
linestretch: 1.5
papersize: a4
documentclass: scrreprt
## I18n polyglossia
polyglossia-lang:
  name: russian
  options:
	- spelling=modern
	- babelshorthands=true
polyglossia-otherlangs:
  name: english
## I18n babel
babel-lang: russian
babel-otherlangs: english
## Fonts
mainfont: IBM Plex Serif
romanfont: IBM Plex Serif
sansfont: IBM Plex Sans
monofont: IBM Plex Mono
mathfont: STIX Two Math
mainfontoptions: Ligatures=Common,Ligatures=TeX,Scale=0.94
romanfontoptions: Ligatures=Common,Ligatures=TeX,Scale=0.94
sansfontoptions: Ligatures=Common,Ligatures=TeX,Scale=MatchLowercase,Scale=0.94
monofontoptions: Scale=MatchLowercase,Scale=0.94,FakeStretch=0.9
mathfontoptions:
## Biblatex
biblatex: true
biblio-style: "gost-numeric"
biblatexoptions:
  - parentracker=true
  - backend=biber
  - hyperref=auto
  - language=auto
  - autolang=other*
  - citestyle=gost-numeric
## Pandoc-crossref LaTeX customization
figureTitle: "Рис."
tableTitle: "Таблица"
listingTitle: "Листинг"
lofTitle: "Список иллюстраций"
lotTitle: "Список таблиц"
lolTitle: "Листинги"
## Misc options
indent: true
header-includes:
  - \usepackage{indentfirst}
  - \usepackage{float} # keep figures where there are in the text
  - \floatplacement{figure}{H} # keep figures where there are in the text
---

# Цель работы

Целью данной работы является приобретение практических навыков установки операционной системы на виртуальную машину, настройки минимально необходимых для дальнейшей работы сервисов.

# Задание

- Установка Linux на VirtualBox
- Установка необходимого ПО
- Первоначальная настройка ОС для дальнейшей работы

# Выполнение лабораторной работы

Установил диструбутив на VirtualBox (рис. [-@fig:001]).

![Базовые настройки](image/1.png){#fig:001 width=70%}

Скачиваю набор необходимых пакетов для работы с ОС. (рис. -@fig:002)

![Установка ПО](image/2.png){#fig:002 width=70%}

Запускаю скрипт для автоматического обновления пакетов через пакетный менеджер dnf. (рис. -@fig:003)

![Запуск скрипта](image/3.png){#fig:003 width=70%}

Отключаю защиту SELinux, так как на данном курсе мы не будем рассматривать работу с ней. (рис. -@fig:004)

![Отключение защиты Linux](image/4.png){#fig:004 width=70%}

Настраиваю xkb, добавляю вторую раскладку клавиатуры с русским языком и задаю переключение на right ctrl. (рис. -@fig:005)

![Настройка xkb](image/5.png){#fig:005 width=70%}

Проверяю корректность заданного имени для hostname. (рис. -@fig:006)

![Вывод команды hostnamectl](image/6.png){#fig:006 width=70%}

Устанавливаю pandoc, pandoc-crossref, texlive для работы над отчетами для лабораторных работ. (рис. -@fig:007)

![Установка ПО для выполнения отчетов](image/7.png){#fig:007 width=70%}

# Домашнее задание

Проверяю последовательность загрузки графического окружения командой dmesg | grep -i с указанием вывода желаемого нахождения (рис. -@fig:008)

![Вывод команды dmesg](image/8.png){#fig:008 width=70%}

# Контрольные вопросы

Контрольные вопросы и ответы
1.Какую информацию содержит учётная запись пользователя?
Учётная запись пользователя в UNIX/Linux содержит:

Имя пользователя (логин) – уникальный идентификатор.

UID (User ID) – числовой идентификатор пользователя.

GID (Group ID) – числовой идентификатор основной группы.

Полное имя (GECOS) – дополнительная информация (ФИО, контакты).

Домашний каталог – путь к личной папке (/home/username).

Оболочка (shell) – командная оболочка (/bin/bash, /bin/sh и др.).

Пароль (в зашифрованном виде) – хранится в /etc/shadow.

2.Команды терминала с примерами
Справка по команде:
man ls – документация по ls
ls --help – краткая справка

Перемещение по файловой системе:
cd /home/user – переход в каталог
cd .. – на уровень выше

Просмотр содержимого каталога:
ls – список файлов
ls -l – подробный вывод

Определение объёма каталога:
du -sh /home/user – размер каталога в человеко-читаемом формате

Создание/удаление каталогов:
mkdir new_dir – создать папку
rmdir empty_dir – удалить пустую папку
rm -r old_dir – удалить папку с содержимым

Создание/удаление файлов:
touch file.txt – создать файл
rm file.txt – удалить файл

Изменение прав:
chmod 755 script.sh – дать права rwxr-xr-x

История команд:
history – просмотр истории
!10 – выполнить 10-ю команду из истории

3.Что такое файловая система? Примеры
Файловая система – способ организации данных на диске. Примеры:

ext4 – стандартная для Linux, журналируемая, надежная.

NTFS – используется в Windows, поддерживает большие файлы.

FAT32 – устаревшая, ограничение 4 ГБ на файл.

XFS – для больших файлов, высокая производительность.

Btrfs – современная, с поддержкой снапшотов.

4.Как посмотреть подмонтированные файловые системы?
Команды:

mount – список смонтированных ФС

df -h – с информацией о размере и использовании

Пример вывода:
/dev/sda1 on / type ext4 (rw,relatime)

5.Как удалить зависший процесс?
Найти PID процесса:
ps aux | grep "имя_процесса"
или
top (затем искать процесс)

Завершить процесс:
kill -9 PID – принудительное завершение
или
pkill -9 "имя_процесса"

# Выводы

В ходе выполнения лабораторный работы приборел навыки установки виртуальной машины на VirtualBox, установил ряд пакетов и настроил ОС для дальнейшей работы на ней.

# Список литературы{.unnumbered}

::: {#refs}
:::
