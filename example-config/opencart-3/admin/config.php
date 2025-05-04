<?php
// HTTP
define('HTTP_SERVER', 'http://' . $_ENV['VHOST_SERVER_NAME'] . '/admin/');
define('HTTP_CATALOG', 'http://' . $_ENV['VHOST_SERVER_NAME'] . '/');

// HTTPS
define('HTTPS_SERVER', 'http://' . $_ENV['VHOST_SERVER_NAME'] . '/admin/');
define('HTTPS_CATALOG', 'http://' . $_ENV['VHOST_SERVER_NAME'] . '/');

// DIR
define('DIR_APPLICATION', $_ENV['VHOST_DOCUMENT_ROOT'] . '/admin/');
define('DIR_SYSTEM', $_ENV['VHOST_DOCUMENT_ROOT'] . '/system/');
define('DIR_IMAGE', $_ENV['VHOST_DOCUMENT_ROOT'] . '/image/');
define('DIR_STORAGE', $_ENV['VHOST_DOCUMENT_ROOT'] . '/system/storage/');
define('DIR_CATALOG', $_ENV['VHOST_DOCUMENT_ROOT'] . '/catalog/');
define('DIR_LANGUAGE', DIR_APPLICATION . 'language/');
define('DIR_TEMPLATE', DIR_APPLICATION . 'view/template/');
define('DIR_CONFIG', DIR_SYSTEM . 'config/');
define('DIR_CACHE', DIR_STORAGE . 'cache/');
define('DIR_DOWNLOAD', DIR_STORAGE . 'download/');
define('DIR_LOGS', DIR_STORAGE . 'logs/');
define('DIR_MODIFICATION', DIR_STORAGE . 'modification/');
define('DIR_SESSION', DIR_STORAGE . 'session/');
define('DIR_UPLOAD', DIR_STORAGE . 'upload/');

// DB
define('DB_DRIVER', 'mysqli');
define('DB_HOSTNAME', $_ENV['MYSQL_HOST']);
define('DB_USERNAME', $_ENV['MYSQL_USER']);
define('DB_PASSWORD', $_ENV['MYSQL_PASSWORD']);
define('DB_DATABASE', $_ENV['MYSQL_DATABASE']);
define('DB_PORT', $_ENV['MYSQL_PORT']);
define('DB_PREFIX', 'oc_');

// OpenCart API
define('OPENCART_SERVER', 'https://www.opencart.com/');
define('OPENCARTFORUM_SERVER', 'https://opencartforum.com/');
