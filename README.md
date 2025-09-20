# Delta Surya Husada Mini Test
### Prerequisites
What things you need to install the software and how to install them.

-   [PHP v8.2](https://www.php.net/downloads.php)
-   [Composer](https://getcomposer.org/download/)
-   [Postgresql v15.xx](https://www.postgresql.org/download/)

### PHP Modules

The following PHP modules are required:
-   bcmath
-   bz2
-   calendar
-   Core
-   ctype
-   curl
-   date
-   dom
-   exif
-   FFI
-   fileinfo
-   filter
-   ftp
-   gd
-   gettext
-   hash
-   iconv
-   igbinary
-   imagick
-   imap
-   intl
-   json
-   ldap
-   libxml
-   mbstring
-   openssl
-   pcntl
-   pcre
-   PDO
-   pdo_pgsql
-   pdo_sqlite
-   pgsql
-   Phar
-   posix
-   random
-   readline
-   redis
-   Reflection
-   session
-   shmop
-   SimpleXML
-   soap
-   sockets
-   sodium
-   SPL
-   sqlite3
-   standard
-   sysvmsg
-   sysvsem
-   sysvshm
-   tokenizer
-   xml
-   xmlreader
-   xmlwriter
-   xsl
-   Zend OPcache
-   zip
-   zlib

### Installation

A step-by-step guide on setting up the project locally.

1. Clone the repository.

via ssh

```bash
git clone git@github.com:alxndr29/delta-surya-mini-test.git
```

via https

```bash
git clone https://github.com/alxndr29/delta-surya-mini-test.git
```

2. Navigate into the directory.

```bash
cd delta-surya-mini-test
```

3. Copy file `.env.example` to `.env` and configure database settings, payment gateway settings, and any other configurations you need.

```bash
cp .env.example .env
```
4. Setup .env
```bash
APP_URL=http://localhost:8000

DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=delta-surya
DB_USERNAME=postgres
DB_PASSWORD=123456

API_URL=http://recruitment.rsdeltasurya.com/api/v1/
API_AUTH_EMAIL=xxxx@gmail.com
API_AUTH_PASSWORD=xxxx
```

5. Install the dependencies.

```bash
composer install
```

6. Generate application key using this command.

```bash
php artisan key:generate
```

7. Running migration and seeder for initial data.

```bash
php artisan migrate --seed
```

## Running Development (Laravel)

How to run the development server.

1. Start the application using development environment.

```bash
php artisan serve
```
2. Acces the apps
```bash
localhost:8000
```
3. Cred for access

```bash
email   : admin@email.com
password: 12345678

all password from master users is 12345678
```
