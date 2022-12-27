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

Демон auditd может быть настроен так, чтобы не писать файлы `/var/log/audit/audit.log`, демон journald умеет "кушать" события аудита.

Сопоставлять события запуска (laura_process_start) и остановки (laura_process_end) программы можно сопоставить по PID — уникальному идентификатору процессу, посчитав время ее работы как разницу между временными метками остановки и запуска.