// TODO: Refactor this beast... introduce Jasmine.
function submit_form(form) {
  try {
    var error_block = form.getElementsByClassName('errors')[0];
    var success_block = form.getElementsByClassName('success')[0];
    error_block.style.display = 'none';
    success_block.style.display = 'none';

    var request = new XMLHttpRequest();
    request.open('POST', form.action, true);
    request.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    request.onreadystatechange = function () {
      if (request.readyState != 4) return;

      if (request.status == 400) {
        error_list = error_block.getElementsByTagName('ol')[0];
        error_list.innerHTML = '';

        errors = JSON.parse(request.responseText)

        // TODO: Make this shizna inline
        for(error in errors) {
          error_list.innerHTML += '<li>' + errors[error][0] + '.';
        }
        error_block.style.display = 'block';
      } else if (request.status == 201) {
        success_block.style.display = 'block';
      } else {
        console.log(request.status);
      }
    };
    var data = '';
    var inputs = form.getElementsByTagName('input');
    var len = inputs.length;
    for(i = 0; i < len; i++) {
      data = join_data(inputs[i].name + '=' + escape(inputs[i].value), data);
    }
    var textareas = form.getElementsByTagName('textarea');
    len = textareas.length;
    for(i = 0; i < len; i++) {
      data = join_data(textareas[i].name + '=' + escape(textareas[i].value), data);
    }
    var select = form.getElementsByTagName('select');

    request.send(data);
  } catch(e) {
    alert(e);
  }
}

function join_data(segment, block) {
  if('' == block) {
    return segment;
  } else {
    return block + '&' + segment;
  }
}

