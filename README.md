# Linux audit user run apps

Логирование запускаемых пользователем графических приложений (для сбора статистики).

Система работает следующим образом:

* запускается DE (графическая среда рабочего стола);
* в демон `auditd` прогружаются правила, которые ловят запуск (системный вызов `execve()`) и остановку (системные вызовы `exit_group()` и `kill()`) приложений при условии, что родительским процессом является процесс DE.

В настоящий момент поддерживается только KDE (plasmashell), однако не составит проблемы прописать, какие процессы являются процессами других DE, тем самым добавив поддержку других DE.

Логируется запуск и остановка только тех программ, которые были запущены непосредственно из DE. Если, например, пользователь из DE запустил браузер Chromium, а из Chromium плеер VLC, то запуск Chromium будет залогирован, а запуск VLC — нет.

Просмотр записей аудита проводится либо в `journalctl`, либо из логов демона auditd так:

* `ausearch -k laura_process_start`
* `ausearch -k laura_process_end`

Демон auditd может быть настроен так, чтобы не писать файлы `/var/log/audit/audit.log*`, демон journald умеет "кушать" события аудита. Для этого нужно указать в файле `/etc/audit/auditd.conf`: `write_logs = no`, тогда все события аудита будут храниться только в journald. Можно настроить централизированный сбор логов journald с разных компьютеров на единый сервер [по инструкции](http://wiki.rosalab.ru/ru/index.php/Сервер_логирования_Journald).

Сопоставлять события запуска (laura_process_start) и остановки (laura_process_end) программы можно по PID — уникальному идентификатору процессу, посчитав время ее работы как разницу между временными метками остановки и запуска.

# Установка

Установка из исходников:

`sudo make install`

Установка из репозитория ROSA Linux:

`sudo dnf install linux-audit-user-run-apps` (или: `sudo dnf install laura`)

Установка из репозитория ALT Linux:

`sudo apt-get install linux-audit-user-run-apps` (или: `sudo apt-get install laura`)

После установки выполнить:

`sudo systemctl enable --now laura.path`
