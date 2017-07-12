jQuery(document).ready(function ($) {
    var formModal = $('.cd-user-modal'),
		formLogin = formModal.find('#cd-login'),
		formSignup = formModal.find('#cd-signup'),
		formModalTab = $('.cd-switcher'),
		tabLogin = formModalTab.children('li').eq(0).children('a'),
		tabSignup = formModalTab.children('li').eq(1).children('a'),
        loginButton = $('#loginButton'),
		signUpButton = $('#signUpButton');

	//switch from a tab to another
	formModalTab.on('click', function(event) {
		event.preventDefault();
		( $(event.target).is( tabLogin ) ) ? login_selected() : signup_selected();
	});

	function login_selected() {
		/*formLogin.addClass('is-selected');
		formSignup.removeClass('is-selected');*/
	    document.getElementById('cd-login').style.display = 'block';
	    document.getElementById('cd-signup').style.display = 'none';
		tabLogin.addClass('selected');
		tabSignup.removeClass('selected');
	}

	function signup_selected(){
		/*formLogin.removeClass('is-selected');
		formSignup.addClass('is-selected');*/
	    document.getElementById('cd-login').style.display = 'none';
	    document.getElementById('cd-signup').style.display = 'block';
		tabLogin.removeClass('selected');
		tabSignup.addClass('selected');
	}

	//REMOVE THIS - it's just to show error messages 
	//formLogin.find('input[type="submit"]').on('click', function(event){
		//event.preventDefault();
		//formLogin.find('input[type="email"]').toggleClass('has-error').next('span').toggleClass('is-visible');
	//});
	//formSignup.find('input[type="submit"]').on('click', function(event){
		//event.preventDefault();
		//formSignup.find('input[type="email"]').toggleClass('has-error').next('span').toggleClass('is-visible');
    //});

	function validateForm() {
	    var x = document.forms["form-signin"]["user"].value;
	    if (x == "") {
	        formLogin.find('input[type="email"]').toggleClass('has-error').next('span').toggleClass('is-visible');
	        return false;
	    }
	}

	loginButton.on('click', function (event) {
	    document.getElementById('modal-forms').style.display = 'block';
	    login_selected();
	});

	signUpButton.on('click', function (event) {
	    document.getElementById('modal-forms').style.display = 'block';
	    signup_selected();
	});

    // When the user clicks anywhere outside of the modal, close it
	window.onclick = function (event) {
	    if (event.target == document.getElementById('modal-forms')) {
	        document.getElementById('modal-forms').style.display = "none";
	    }
	}
});