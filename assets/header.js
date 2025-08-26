(function(){
	const navToggle=document.querySelector('.nav-toggle');
	const nav=document.getElementById('primary-nav');
	if(navToggle&&nav){
		navToggle.addEventListener('click',()=>{
			const expanded=navToggle.getAttribute('aria-expanded')==='true';
			navToggle.setAttribute('aria-expanded',String(!expanded));
			nav.classList.toggle('open');
		});
	}
	const submenuButtons=[...document.querySelectorAll('.menu-item.has-submenu>button')];
	submenuButtons.forEach(btn=>{
		btn.addEventListener('click',e=>{
			const item=btn.closest('.menu-item');
			const isOpen=item.classList.contains('open');
			item.classList.toggle('open');
			btn.setAttribute('aria-expanded',String(!isOpen));
		});
	});
})();