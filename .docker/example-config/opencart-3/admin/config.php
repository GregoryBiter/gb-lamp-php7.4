<?php
// HTTP
define('HTTP_SERVER', $_ENV['OC_URL'] . '/admin/');
define('HTTP_CATALOG', $_ENV['VHOST_SERVER_NAME'] . '/');

// HTTPS
define('HTTPS_SERVER', $_ENV['OC_URL'] . '/admin/');
define('HTTPS_CATALOG', $_ENV['OC_URL'] . '/');

// DIR
define('DIR_APPLICATION', $_ENV['OC_PATH'] . '/admin/');
define('DIR_SYSTEM', $_ENV['OC_PATH'] . '/system/');
define('DIR_IMAGE', $_ENV['OC_PATH'] . '/image/');
define('DIR_STORAGE', $_ENV['OC_PATH'] . '/system/storage/');
define('DIR_CATALOG', $_ENV['OC_PATH'] . '/catalog/');
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
define('DB_HOSTNAME', $_ENV['OC_DB_HOST']);
define('DB_USERNAME', $_ENV['OC_DB_USER']);
define('DB_PASSWORD', $_ENV['OC_DB_PASSWORD']);
define('DB_DATABASE', $_ENV['OC_DB_NAME']);
define('DB_PORT', $_ENV['OC_DB_PORT']);
define('DB_PREFIX', 'oc_');

// OpenCart API
define('OPENCART_SERVER', 'https://www.opencart.com/');
define('OPENCARTFORUM_SERVER', 'https://opencartforum.com/');
