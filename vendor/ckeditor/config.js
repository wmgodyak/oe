CKEDITOR.editorConfig = function( config ) {
	config.toolbarGroups = [
		{ name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
		{ name: 'insert', groups: ['links' , 'insert' ] },
		{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ]},
		{ name: 'document', groups: [ 'tools', 'mode' ] }
	];

	config.removeButtons = 'Underline,Scayt,Outdent,Indent,Anchor';

	config.filebrowserBrowseUrl = '/vendor/filemanager/dialog.php?type=2&editor=ckeditor&fldr=';
	config.filebrowserUploadUrl = '/vendor/filemanager/dialog.php?type=2&editor=ckeditor&fldr=';
	config.filebrowserImageBrowseUrl = '/vendor/filemanager/dialog.php?type=1&editor=ckeditor&fldr=';
};