# Калькулятор Стьюарда

Проект представляет собой обычный калькулятор в виде таблицы. Реализован как обычное статическое spa приложение без ssr. Для работы нужен vps с установленным docker и docker-compose и настроен на работу с доменом. Имеет скрипт для подписания ssl сертификатов.

Для запуска проекта необходимо пойти следующие шаги:

- Создать .env файл с настройками
- Добавить файлы ssl настроек для nginx

## Создание .env файла

Создаем файл .env в корне проекта и заполняем следующий шаблон

```
HTTP_PORT=<Порт для http>
HTTPS_PORT=<Порт для https>

# paths
STATIC_PATH=<Где сохраняются статически сгенерированных сайт>
ETC_LETSENCRYPT=<Необходимо для работы ssl сертификата>
WWW_LETSENCRYPT=<Необходимо для авторизации ssl сертификата>
LOGS=<Путь по каторому сохраняются логи сервера>

# domains
DOMAIN=<Имя желаемого домена>
```

Все что в <> нужно заполнить. Порты привязаны к переменным для использования нескольких проектов на одном сервере и сделано для удобства. Если вы не работаете на сервере с несколькими проектами нужно установить HTTP_PORT на 80, а HTTPS_PORT на 443.

## Добавление настроек для ssl в nginx

Все настройки находятся по адресу /configs/nginx. Всего файлов два это options-ssl-nginx.conf и ssl-dhparams.pem.

Файл options-ssl-nginx.conf содержит примерно такое содержание:

```
# This file contains important security parameters. If you modify this file
# manually, Certbot will be unable to automatically provide future security
# updates. Instead, Certbot will print and log an error message with a path to
# the up-to-date file that you will need to refer to when manually updating
# this file.

ssl_session_cache shared:le_nginx_SSL:10m;
ssl_session_timeout 1440m;
ssl_session_tickets off;

ssl_protocols TLSv1.2 TLSv1.3;
ssl_prefer_server_ciphers off;

ssl_ciphers "что то там";
```

Нужно заполнить поле ss_ciphers, вот [https://nginx.org/ru/docs/http/ngx_http_ssl_module.html#ssl_ciphers](ссылка на доку). Не проверял но возможно и без этого параметра все будет работать, но лучше заполнить.

Файл ssl-dhparams.pem создается с командой:

```bash
openssl dhparam -out /etc/pki/nginx/dhparam.pem 4096
```

## Запуск проекта

Для работы сервера необходимо иметь docker и docker-compose и все команды используются через npm. Если нет npm можно все команды найти в package.json в поле scripts.

Запускаем первую команду для инициализации ssl сертификатов:

```bash
npm run ssl-init
```

Смотрим чтобы certbot отрапортовал об успехе и выключаем процесс. После инициализации ssl запускаем сам сервер следующей командой:

```bash
npm run start
```