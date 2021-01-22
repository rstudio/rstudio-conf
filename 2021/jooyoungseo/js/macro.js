remark.macros.image = function(w, a) {
  var url = this;
  if (!a) a = 'image';
  return '<img src="' + url + '" style="width: ' + w + ';" alt="' + a + '" />';
};
