<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 17.10.16 : 17:37
 */

namespace system\components\editor\controllers;

use system\Backend;

defined("CPATH") or die();

class Editor extends Backend
{
    public function index()
    {
        // TODO: Implement index() method.
    }
    public function create()
    {
        // TODO: Implement create() method.
    }
    public function edit($id)
    {
        // TODO: Implement edit() method.
    }
    public function process($id)
    {
        // TODO: Implement process() method.
    }

    public function delete($id)
    {
        // TODO: Implement delete() method.
    }

    /**
     *
     */
    public function config()
    {
/*
 *
    [editor_bodyId] => cms_content
    [editor_body_class] => cms_content
    [editor_contents_css] => /themes/default/assets/css/style.css
 * */
        $css = $this->settings['editor_contents_css'];
        $_css = [];
        if(!empty($css)){
            $a = explode(',', $css);
            foreach ($a as $k=>$v) {
                $_css[] = "'$v'";
            }
            $css = implode(',', $_css);
        }
        header('Content-Type: application/javascript');
        echo "CKEDITOR.editorConfig = function( config ) {
    config.bodyId = '{$this->settings['editor_bodyId']}';
    config.bodyClass = '{$this->settings['editor_body_class']}';
    config.contentsCss = [{$css}];
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

	config.specialChars = [
		'&quot;', '&','&lt;', '=', '&gt;','`', '~',
		'&euro;', '&lsquo;', '&rsquo;', '&ldquo;', '&rdquo;', '&ndash;', '&mdash;', '&iexcl;', '&cent;', '&pound;', '&curren;', '&yen;', '&brvbar;', '&sect;', '&uml;',
		'&copy;', '&ordf;', '&laquo;', '&not;', '&reg;', '&macr;', '&deg;', '&sup2;', '&sup3;', '&acute;', '&micro;', '&para;', '&middot;', '&cedil;', '&sup1;',
		'&ordm;', '&raquo;', '&frac14;', '&frac12;', '&frac34;', '&iquest;', '&Agrave;', '&Aacute;', '&Acirc;', '&Atilde;', '&Auml;', '&Aring;', '&AElig;', '&Ccedil;',
		'&Egrave;', '&Eacute;', '&Ecirc;', '&Euml;', '&Igrave;', '&Iacute;', '&Icirc;', '&Iuml;', '&ETH;', '&Ntilde;', '&Ograve;', '&Oacute;', '&Ocirc;', '&Otilde;',
		'&Ouml;', '&times;', '&Oslash;', '&Ugrave;', '&Uacute;', '&Ucirc;', '&Uuml;', '&Yacute;', '&THORN;', '&szlig;', '&agrave;', '&aacute;', '&acirc;', '&atilde;',
		'&auml;', '&aring;', '&aelig;', '&ccedil;', '&egrave;', '&eacute;', '&ecirc;', '&euml;', '&igrave;', '&iacute;', '&icirc;', '&iuml;', '&eth;', '&ntilde;', '&ograve;',
		'&oacute;', '&ocirc;', '&otilde;', '&ouml;', '&divide;', '&oslash;', '&ugrave;', '&uacute;', '&ucirc;', '&uuml;', '&yacute;', '&thorn;', '&yuml;', '&OElig;', '&oelig;',
		'&#372;', '&#374', '&#373', '&#375;', '&sbquo;', '&#8219;', '&bdquo;', '&hellip;', '&trade;', '&#9658;', '&bull;', '&rarr;', '&rArr;', '&hArr;', '&diams;', '&asymp;',

		'&#913;', '&#914;', '&#915;', '&#916;', '&#917;', '&#918;', '&#919;', '&#920;', '&#921;', '&#922;', '&#923;', '&#924;', '&#925;', '&#926;', '&#927;', '&#928;',
		'&#929;', '&#931;', '&#932;', '&#933;', '&#934;', '&#935;', '&#936;', '&#937;', '&#945;', '&#946;', '&#947;', '&#948;', '&#949;', '&#950;', '&#951;', '&#952;',
		'&#953;', '&#954;', '&#955;', '&#956;', '&#957;', '&#958;', '&#959;', '&#960;', '&#961;', '&#962;', '&#963;', '&#964;', '&#965;', '&#966;', '&#967;', '&#968;', '&#969;'
	];

	config.protectedSource.push( /<script[\s\S]*?script>/g );
	config.allowedContent = true;

	config.toolbar = [
		{ name: 'document', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo'  ] },

		{ name: 'links', items : [ 'Link','Unlink','Anchor' ] },
		{ name: 'insert', items : [ 'Image','Table','SpecialChar','PageBreak' ] },

		{ name: 'tools', items : [  'Templates','-','ShowBlocks' ] },
		{ name: 'file', items : [ 'Maximize','-', 'Source'] },
		'/',
		{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
		{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'] },
		{ name: 'styles', items : [ 'Format' ]},
		{ name: 'colors', items : [ 'TextColor','BGColor' ] }
	];
	config.extraPlugins = 'codemirror';
};
";

        die;
    }
}