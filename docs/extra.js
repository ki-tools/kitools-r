var html = '<li> \
<div class="rpython-radio"> \
<label class="radio-inline"> \
  <input class="radio-lang" type="radio" id="r-radio" value="r">R \
</label> \
<label class="radio-inline"> \
  <input class="radio-lang" type="radio" id="py-radio" value="py">Python \
</label> \
<li> \
</div> \
';

var setLanguage = function(l) {
  localStorage.setItem('ki_tools_language', l);
  if (l !== 'r' && l !== 'py') {
    l = 'r';
  }
  var ol = (l === 'r') ? 'py': 'r';
  // change radio button
  $('#' + ol + '-radio').prop('checked', false);
  $('#' + l + '-radio').prop('checked', true);
  // show/hide scripts
  $('.rmd-' + ol + '-chunk').parent().hide();  
  $('.rmd-' + l + '-chunk').parent().show();  
}

$(document).ready(function() {
  // set language
  var lang = localStorage.getItem('ki_tools_language');
  if (lang === null) {
    lang = 'r';
    localStorage.setItem('ki_tools_language', lang);
  }
  $('.navbar-right').prepend(html);
  setLanguage(lang);

  // language change listener
  $('.radio-lang').on('click', function () {
    var l = $(this).prop('value');
    setLanguage(l);
  });

  // add links
  $("a[href='https://github.com/ki-tools/kitools-r']").parent()
    .append("<br><a href='https://github.com/ki-tools/kitools-py'>https://github.com/ki-tools/kitools-py</a>")
  $("a[href='https://github.com/ki-tools/kitools-r/issues']").parent()
    .append("<br><a href='https://github.com/ki-tools/kitools-py/issues'>https://github.com/ki-tools/kitools-py/issues</a>")

  // make larger github icon not stretch the header
  $('.fa-github').parent().css('padding-bottom', '10px');
  $('.fa-github').parent().css('padding-top', '17px');
});
