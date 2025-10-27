<?php
// اتصال قاعدة البيانات باستخدام PDO (MySQL)
// يعتمد على متغيرات البيئة في ملف .env إن وُجد

function _load_env_file(string $path): void {
	if (!is_file($path)) {
		return;
	}
	$lines = file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
	if ($lines === false) {
		return;
	}
	foreach ($lines as $line) {
		$trim = ltrim($line);
		if ($trim === '' || $trim[0] === '#') {
			continue;
		}
		$pos = strpos($line, '=');
		if ($pos === false) {
			continue;
		}
		$key = trim(substr($line, 0, $pos));
		$value = trim(substr($line, $pos + 1));
		if ($value !== '' && ($value[0] === '"' || $value[0] === "'")) {
			$quote = $value[0];
			if (substr($value, -1) === $quote) {
				$value = substr($value, 1, -1);
			}
		}
		putenv($key . '=' . $value);
		$_ENV[$key] = $value;
		$_SERVER[$key] = $value;
	}
}

function env_get(string $key, ?string $default = null): ?string {
	$val = getenv($key);
	return $val === false ? $default : $val;
}

function db(): PDO {
	static $pdo = null;
	if ($pdo instanceof PDO) {
		return $pdo;
	}
	$root = dirname(__DIR__);
	_load_env_file($root . '/.env');

	$host = env_get('DB_HOST', '127.0.0.1');
	$port = env_get('DB_PORT', '3306');
	$name = env_get('DB_NAME', 'malbas_db');
	$user = env_get('DB_USER', 'root');
	$pass = env_get('DB_PASS', '');
	$charset = env_get('DB_CHARSET', 'utf8mb4');

	$dsn = 'mysql:host=' . $host . ';port=' . $port . ';dbname=' . $name . ';charset=' . $charset;
	$options = [
		PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
		PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
		PDO::ATTR_EMULATE_PREPARES => false,
	];

	$pdo = new PDO($dsn, $user, $pass, $options);
	return $pdo;
}