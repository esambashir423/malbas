<?php
$primary_blue = '#0B4C8C';
$secondary_green = '#75D08A';
$white = '#ffffff';
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>جمعية ملبس الأهلية</title>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="/assets/header.css">
	<script>window.__THEME__={primary:'<?php echo $primary_blue; ?>',secondary:'<?php echo $secondary_green; ?>'};</script>
</head>
<body>
	<header class="site-header">
		<div class="container">
			<a href="/" class="brand" aria-label="الرئيسية">
				<img src="/logo.png" alt="شعار جمعية ملبس الأهلية" class="logo">
			</a>
			<button class="nav-toggle" aria-label="القائمة" aria-expanded="false" aria-controls="primary-nav">
				<span class="bar"></span>
				<span class="bar"></span>
				<span class="bar"></span>
			</button>
			<nav id="primary-nav" class="primary-nav" aria-label="القائمة الرئيسية">
				<ul class="menu level-1">
					<li class="menu-item"><a href="/">الرئيسية</a></li>
					<li class="menu-item has-submenu">
						<button class="submenu-toggle" aria-expanded="false">عن الجمعية</button>
						<ul class="submenu level-2">
							<li><a href="#">من نحن</a></li>
							<li><a href="#">الهيكل التنظيمي</a></li>
							<li><a href="#">أعضاء مجلس الإدارة</a></li>
							<li><a href="#">المدير التنفيذي</a></li>
							<li><a href="#">شهادة تسجيل الجمعية</a></li>
							<li><a href="#">الحسابات البنكية</a></li>
							<li><a href="#">احصائيات المستفيدين</a></li>
						</ul>
					</li>
					<li class="menu-item has-submenu">
						<button class="submenu-toggle" aria-expanded="false">الحوكمة والشفافية</button>
						<ul class="submenu level-2">
							<li><a href="#">اللوائح والسياسات</a></li>
							<li><a href="#">التقارير المالية</a></li>
							<li><a href="#">التقارير السنوية</a></li>
							<li><a href="#">الخطة الاستراتيجية</a></li>
							<li><a href="#">الخطة التشغيلية</a></li>
							<li><a href="#">الميثاق الأخلاقي</a></li>
						</ul>
					</li>
					<li class="menu-item has-submenu">
						<button class="submenu-toggle" aria-expanded="false">الجمعية العمومية</button>
						<ul class="submenu level-2">
							<li><a href="#">الأعضاء المؤسسون</a></li>
							<li><a href="#">أعضاء الجمعية العمومية</a></li>
							<li><a href="#">محاضر الجمعية العمومية العادية</a></li>
							<li><a href="#">محاضر الجمعية العمومية غير العادية</a></li>
						</ul>
					</li>
					<li class="menu-item has-submenu">
						<button class="submenu-toggle" aria-expanded="false">البرامج والمبادرات</button>
						<ul class="submenu level-2">
							<li><a href="#">البرامج الحالية</a></li>
							<li><a href="#">البرامج السابقة</a></li>
							<li><a href="#">التسجيل في برنامج</a></li>
						</ul>
					</li>
					<li class="menu-item has-submenu">
						<button class="submenu-toggle" aria-expanded="false">بوابة التطوع</button>
						<ul class="submenu level-2">
							<li><a href="#">بوابة المتطوعين</a></li>
							<li><a href="#">طلب متطوعين</a></li>
						</ul>
					</li>
					<li class="menu-item has-submenu">
						<button class="submenu-toggle" aria-expanded="false">المركز الإعلامي</button>
						<ul class="submenu level-2">
							<li><a href="#">الاخبار</a></li>
							<li><a href="#">المبادرات</a></li>
							<li><a href="#">مكتبة الصور</a></li>
							<li><a href="#">مكتبة الفيديو</a></li>
							<li><a href="#">البث المباشر</a></li>
							<li><a href="#">المسابقات</a></li>
							<li><a href="#">شركاء النجاح</a></li>
							<li><a href="#">التزكيات</a></li>
						</ul>
					</li>
					<li class="menu-item"><a href="#">متجر التبرع الالكتروني</a></li>
					<li class="menu-item"><a href="#">اتصل بنا</a></li>
				</ul>
			</nav>
		</div>
	</header>
	<script src="/assets/header.js" defer></script>
</body>
</html>