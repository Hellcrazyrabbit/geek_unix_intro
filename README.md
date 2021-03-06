# Введение в UNIX-системы
## Работа в консоли
* Просмотреть содержимое директорий /etc, /proc, /home. Посмотреть пару произвольных файлов в /etc.

    - Используя команду `ls /$DIRNAME` просматриваем содержимое директории.
     Команда `cat /etc/$FILENAME ` позволяет просмотреть файлы

* Выяснить, для чего предназначена команда cat. Используя данную команду, создать два файла с данными, а затем объединить их. Просмотреть содержимое созданного файла. Переименовать файл, дав ему новое имя.

    - `cat` объединяет и печатает файлы в стандартный вывод. С помощью `cat > file#` создаем 2 файла и заполняем данными введенными в консоли. `cat file1 file2 >> file3` объединяем файлы в новом файле, командой `mv` переименовываем его название

* Создать несколько файлов. Создать директорию, переместить файл туда. Удалить все созданные в этом и предыдущем задании директории и файлы.

    - Переместить файл в директорию можно командой `mv $FILENAME $DIRNAME`. Удаляем все файлы командой `rm -r` находясь в директории практического занятия

* В ОС Linux скрытыми файлами считаются те, имена которых начинаются с символа “.”. Сколько скрытых файлов в вашем домашнем каталоге? (Использовать конвейер. Подсказка: для подсчета количества строк можно использовать wc.)

    - Конвейер `ls -ld .?* | wc -l` выведет количество скрытых файлов в текущей директории, в моем домашнем каталоге их 16

* Попробовать вывести с помощью cat все файлы в директории /etc. Направить ошибки в отдельный файл в вашей домашней директории. Сколько файлов, которые не удалось посмотреть, оказалось в списке?

    - Командой `cat /etc/* 2> catalogs` отправляем ошибочные выводы в файл "catalogs", потом считаем строки в файле `wc -l catalogs`. У меня вышло 126

* Запустить в одном терминале программу, а в другом терминале посмотреть PID процесса и остановить с помощью kill, посылая разные типы сигналов. Что происходит?

    - В зависимости от типа сигнала процесс переходит в определенный статус, например `kill -9 $PID` завершит процесс сразу

* Отобразить в /dev список устройств, которые в настоящее время используются вашим UID (для этого используется команда lsof). Организовать конвейер через less, чтобы посмотреть их должным образом. 

    - Не нужно делать

* Cоздать директорию для хранения фотографий. В ней должны быть директории по годам (например, за последние 5 лет), и в каждой директории года — по директории для каждого месяца. 

    - Не нужно делать

* Заполнить директории файлами вида ГГГГММДДНН.txt. Внутри файла должно быть его имя. Например: 2018011301.txt, 2018011302.txt.

    - Не нужно делать

* Полезное задание на конвейер. Использовать команду cut на вывод длинного списка каталога, чтобы отобразить только права доступа к файлам. Затем отправить в конвейере этот вывод на sort и uniq, чтобы отфильтровать все повторяющиеся строки. Потом с помощью wc подсчитать различные типы разрешений в этом каталоге. Самостоятельно решить задачу, как сделать так, чтобы в подсчет не добавлялись строка «Итого» и файлы . и .. (ссылки на текущую и родительскую директории).

    - Используем команду `ls -lA` в сочетании с конвейером для выполнения условий задания. Вывод:
    `````
    ls -lA /etc | cut -d " " -f1 | grep -v итого | sort | uniq        
    drwxr-s---
    drwxr-xr-x
    lrwxrwxrwx
    -r--r-----
    -r--r--r--
    -rw-------
    -rw-r-----
    -rw-r--r--
    -rw-rw-r--
    -rwxr-xr-x
    `````
     - добавляем `|wc -l`  и подстчет выдает нам 10 типов разрешений

## Файлы и права доступа в Linux

* Создать файл file1 и наполнить его произвольным содержимым. Скопировать его в file2. Создать символическую ссылку file3 на file1. Создать жесткую ссылку file4 на file1. Посмотреть, какие айноды у файлов. Удалить file1. Что стало с остальными созданными файлами? Попробовать вывести их на экран.

    - Файлы file1 и file4 будут иметь одинаковые айноды. После удаления останутся все файлы, кроме file1, при этом символическая ссылка будет битой, а при входе по ней в текстовый редактор будет создан новый файл file1.

* Дать созданным файлам другие, произвольные имена. Создать новую символическую ссылку. Переместить ссылки в другую директорию.

    -  Как от переименования, так и от перемещения пострадают только символьные ссылки, так как они будут ссылаться или не натот файл, или не по тому пути.

* Создать два произвольных файла. Первому присвоить права на чтение, запись для владельца и группы, только на чтение — для всех. Второму присвоить права на чтение, запись — только для владельца. Сделать это в численном и символьном виде.
 
    - `chmod 664 file1 && chmod 644 file2` в числовом виде и `chmod ug=rw,o=r file1 && chmod u=rw,og=r file2` в символьном(можно также использовать +-, если известны права доступа).

* Создать пользователя, обладающего возможностью выполнять действия от имени суперпользователя.
 
    - на выбор `useradd` или `adduser` быстрее всего сделать одной командой `useradd -m -G sudo -s /bin/bash adminuser`

* Создать группу developer и несколько пользователей, входящих в нее. Создать директорию для совместной работы. Сделать так, чтобы созданные одними пользователями файлы могли изменять другие пользователи этой группы.

    - Создаем группу командой `groupadd developer`, затем создаем новых пользователей командами из предыдущей задачи указав необходиму группу или добавляем существующих пользователей в группу при помощи `usermod -aG developer $USERNAME`. На каталоге меняем группу рекурсивно `chgrp -R developer`, затем меняем права `chmod -R 2775 newpol` 2 - _setGID_ означает, что все новые файлы наследуют группу каталога.

* Создать в директории для совместной работы поддиректорию для обмена файлами, но чтобы удалять файлы могли только их создатели.

    - Если добавить атрибут `t` на каталог, то удалить файлы из него смогут только владельцы

* Создать директорию, в которой есть несколько файлов. Сделать так, чтобы открыть файлы можно было, только зная имя файла, а через ls список файлов посмотреть было нельзя.
 
    - Удаляем атрибут `r` из прав на каталог

## Bash, скрипты и автоматизация

* Написать скрипт, который удаляет из текстового файла пустые строки и заменяет маленькие символы на большие (воспользуйтесь tr или sed).
   
    - Скрипт chscript.sh для выполнения указанной задачи добавлен в репозиторий

* Создать скрипт, который создаст директории для нескольких годов (2010 — 2017), в них — поддиректории для месяцев (от 01 до 12), и в каждый из них запишет несколько файлов с 
произвольными записями (например, 001.txt, содержащий текст«Файл 001», 002.txt с текстом Файл 002) и т. д.
    
    - Скрипт dirmaker.sh для выполнения указанной задачи добавлен в репозиторий

* Создать файл crontab, который ежедневно регистрирует занятое каждым пользователем дисковое пространство в его домашней директории.
    
    -  Задачу cron нужно запустить от root пользователя, чтобы иметь доступ ко всем данным. Строка команды в crontab будет выглядеть так `@daily  date >> /var/log/diskspacemonitor; du -hs /home/* >> /var/log/diskspacemonitor`

* Создать скрипт ownersort.sh, который в заданной папке копирует файлы в директории, названные по имени владельца каждого файла. Учтите, что файл должен принадлежать соответствующему владельцу.

    - Скрипт ownersort.sh добавлен в репозиторий, настроен на копирование без рекурсии, для копирования всех файлов убрать `-maxdepth 1` из параметров

## Сетевые возможности Linux
* Произвести ручную настройку сети в Ubuntu.

    - задаем адрес c помощью ifconfig предварительно установив пакет net-tools. `ifconfig eth0 10.10.10.10 netmask 255.255.255.0`, затем добавляем роут `route add default gw 10.10.10.1 eth0`

* Переключить настройку сети на автоматическую через DHCP, проверить получение адреса.

    - переходим в директорию /etc/network/interfaces
    прописываем следующие строки и перезапускаем службу networking
    `````
    auto eth0
    iface eth0 inet dhcp
    `````

* Изменить адрес DNS на 1.1.1.1 и проверить доступность интернета, например, открыв любой браузер на адрес https://geekbrains.ru.

    - Способов несколько, один из них добавление в /etc/network/interfaces строки `dns-nameservers 1.1.1.1`, я отредактировал файл /etc/resov.conf, до перезагрузки будут действовать установленные настройки

* Настроить правила iptables, чтобы из внешней сети можно было обратиться только к портам 80 и 443.

    - Очищаем текущие правила приема  `iptables -F INPUT` добавляем новые
    `````
    iptables -A INPUT -i eth0 -p tcp --dport 80 -j ACCEPT
    iptables -A INPUT -i eth0 -p tcp --dport 443 -j ACCEPT
    iptables -A INPUT -i eth0 -j DROP
    `````

* Дополнительно к предыдущему заданию настроить доступ по ssh только из указанной сети.

    - Предполагается, что ssh будет на стандартном 22 порту, добавить правило `iptables -A INPUT -i eth0 -p tcp -s 10.0.0.1/24 --dport 22 -j ACCEPT`
